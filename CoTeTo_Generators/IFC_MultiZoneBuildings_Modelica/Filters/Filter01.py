# -*- coding: utf-8 -*-
#
import ifcopenshell
import ifcopenshell.geom

import libdm.BuildingDataModel as bdm
import libdm.DataModelGenerator as dmg
import IfcLib.Ifc2x3Lib as ifcLib
from IfcLib import DataClasses
import math
from numpy import mean
import re
import os

def cmp(a, b):
    '''
    Compares a and b and returns -1 if a < b, 0 if a == b and 1 if a > b
    '''
    return (a > b) - (a < b)

def azimuthAngle(x,y,z):
    '''
    returns the azimuth angle of a surface based on its normal vector
    '''
    if x == 0.0 and y == 0.0:
        return 0.0
    if y < 0 and x == 0:
        return math.acos(y*1.0/math.sqrt(x*x+y*y))/math.pi*180.0
    else:
        return math.acos(y*1.0/math.sqrt(x*x+y*y))/math.pi*180.0*cmp(x,0)

def tiltAngle(x,y,z):
    '''
    returns the tilt angle of a surface based on its normal vector
    '''
    return math.acos(z*1.0/math.sqrt(x*x+y*y+z*z))/math.pi*180.0

def mapIFCtoBuildingDataModel(file,filename):
    '''
    Analyses the IFC file regarding the information, which defines
    the building zones and the building elements and maps it to the
    building data model
    '''
    settings = ifcopenshell.geom.settings()
    settings.set(settings.USE_PYTHON_OPENCASCADE, True)

    # Elements need two representations (SweptSolid and Curve2D). If those are not present,
    # it is likely that the building element has childrens containing the necessary representations.
    # Elements/Walls with one representation will throw an error when calling create_shape().
    # This problem appeared for some IfcWall with air gaps.
    # The IfcWall were composed by several "IfcBuildingElementPart" elements
    # which contain the necessary representations.
    # Here, the list all_walls obtained with file.by_type("IfcWall") is filtered. Removing the
    # elements with less than 2 Representations.
    all_walls = file.by_type("IfcWall")
    originalWalls = []
    walls = []
    walls_decomposed = []
    
    for w in all_walls:
        shape_tup = ifcopenshell.geom.create_shape(settings, w)
        toposhape = shape_tup.geometry
        mesh = DataClasses.Mesh(toposhape)
        originalWalls.append(mesh)
        if len(w.Representation.Representations) >= 2:
            walls.append([w, toposhape])
        else:
            walls_decomposed.append(w)

    # Add element parts of IfcWall with one representation to the "walls" list
    # walls includes ifcWall (incl. IfcWallStandardCase, ...)
    # and ifcBuildingElementPart elements.
    BuildingElementPart = file.by_type("IfcBuildingElementPart")
    for be in BuildingElementPart:
        walls.append([be, ifcopenshell.geom.create_shape(settings, be).geometry])

    all_doors = file.by_type("IfcDoor")
    originalDoors = []
    for d in all_doors:
        shape_tup = ifcopenshell.geom.create_shape(settings, d)
        toposhape = shape_tup.geometry
        mesh = DataClasses.Mesh(toposhape)
        originalDoors.append(mesh)

    # Slabs and Colums are not filtered, but stored using the same data structure
    # that was used for the walls: [Ifc element, shape]
    all_slabs = file.by_type("IfcSlab")
    originalSlabs = []
    slabs = []
    for s in all_slabs:
        shape_tup = ifcopenshell.geom.create_shape(settings, s)
        toposhape = shape_tup.geometry
        mesh = DataClasses.Mesh(toposhape)
        originalSlabs.append(mesh)
        slabs.append([s, ifcopenshell.geom.create_shape(settings, s).geometry])

    all_columns = file.by_type("IfcColumn")
    originalColumns = []
    columns = []
    for c in all_columns:
        shape_tup = ifcopenshell.geom.create_shape(settings, c)
        toposhape = shape_tup.geometry
        mesh = DataClasses.Mesh(toposhape)
        originalColumns.append(mesh)
        columns.append([c, ifcopenshell.geom.create_shape(settings, c).geometry])

    all_windows = file.by_type("IfcWindow")
    originalWindows = []
    for w in all_windows:
        shape_tup = ifcopenshell.geom.create_shape(settings, w)
        toposhape = shape_tup.geometry
        mesh = DataClasses.Mesh(toposhape)
        originalWindows.append(mesh)

    # Dictionary with key name of Ifc element (IfcWall, ...) containg a list of the element-id which
    # for some reason (i.e. wrong definition, too complex, ...) should be disregarded.
    black_list = {}
    # Main programm: 
    # 1.Check Ifc file
    # Search for spaces overlapping with building elements and correct them
    # overlappedId,overlappedShape = ifcLib.getOverlappedelements(ifc_file)
    # get black list of spaces by adding spaces (Id) of redundand spaces
    black_list["IfcSpace"] = ifcLib.getOverlappedSpaces(file)
    # Search for wrong defined IfcSpaces that do not fill a whole space/room
    # (gap between building elements and IfcSpace) and correct them
    # 2.Obtain information
    # Definition of the building constructions
    MaterialLayerset = ifcLib.LayerSet_toLayers(file)
    # Definition of the constructions and combination with the building elements
    BuildingElementToMaterialLayerSet, BuildingElementToMaterial = ifcLib.BuildingElement_toMaterialLayer(file)
    # Building element dictionaries
    WindowToStyle, DoorToStyle = ifcLib.WindowAndDoor_toStyle(file)
    WallInfo, problematicWalls = ifcLib.getWallInfo(walls)
    SlabsInfo = ifcLib.getSlabInfo(slabs)
    ColumnsInfo = ifcLib.getColumninfo(columns)
    # Definition of the building site
    Site = file.by_type("IfcSite")
    # Instantiation of SpaceContainer using Spaces Volumes
    SpacesW, Spaces = ifcLib.initSpaceContainer(file, black_list["IfcSpace"])
    # Find contacts between space boundaries (from space volume) and IfcWalls
    SpacesW, black_list["IfcWall"], black_list["IfcSlab"] = ifcLib.RelatedElementsWalls(SpacesW, file, WallInfo, SlabsInfo)
    # Modify SpaceContainer accordingly with Walls information.
    SpacesW = ifcLib.SecondLvLBoundariesWalls(SpacesW, WallInfo, SlabsInfo)
    # Remove any boundary attached to a IfcWall of the previously initialized SpaceContainer list -Spaces-
    Spaces = ifcLib.SpaceBoundariesWithoutWalls(Spaces, SpacesW)
    # Find relation/contact between IFC classes (openings,slabs,.. even spaces)
    # to boundaries of each SpaceContainer within Spaces.
    Spaces, OpeningsDict, giv = ifcLib.RelatedElements(Spaces, file, WallInfo, ColumnsInfo)
    # Dictionary Spaces.RelatedOpening is checked. Removing/filtering boundary definitions in excess.
    Spaces = ifcLib.OverlappedOpenings(Spaces)
    #
    Spaces = ifcLib.addVirtualBoundaries(Spaces)
    # Update SpaceContainer list Spaces. Editing boundaries based on connected/related IFC classes
    Spaces = ifcLib.SecondLvLBoundaries(Spaces, SpacesW, WallInfo, OpeningsDict, SlabsInfo, ColumnsInfo)
    # Als normals of the boundaries show to the ambient of a space
    Spaces = ifcLib.CorrectNormalVector(Spaces)
    # Analysis of the adjacent space (other space, ambient, other building element) and modification
    # of the correspodent boundaries
    Spaces = ifcLib.UpdateSecondLvLBoundaries(Spaces, WallInfo, ColumnsInfo, black_list["IfcWall"])
    Spaces = ifcLib.CorrectNormalVector(Spaces)
    #
    Spaces = ifcLib.ExploreSurroundings(Spaces)
    # Correct some of the 3rd level boundaries which OtherSideSpace is not properly defined ("unknown")
    # The definition of 3rd level boundaries is not working properly (failing for complex cases). Some code has
    # been commented out in - UpdateSecondLvLBoundaries -. Until improvements, to call CorrectThirdLevelBoundaries
    # is no further necessary
    # Spaces = ifcLib.CorrectThirdLevelBoundaries(Spaces, ifc_file, WallInfo, ColumnsInfo)
    # Estimation of all height and with for all boundaries
    Spaces = ifcLib.BoundariesHeightWidth(Spaces, WindowToStyle, DoorToStyle, file)
    # Get points of the profile of each boundary face (ignore points of gaps)
    Spaces = ifcLib.Profiles(Spaces)
    # Definition of all positions (spaces, elements)
    Spaces = ifcLib.DefinePosition(Spaces)
    # Add the id's of included space boundaries to their related space boundaries
    Spaces = ifcLib.StoreEnclosedBoundaries(Spaces, WallInfo, OpeningsDict)
    '''
    Instantiation and parameterisation of the building data model
    '''
    modelName = os.path.basename(filename).split('.')[0]
    # Remove invalid characters
    modelName = re.sub('[^0-9a-zA-Z_]', '', modelName)
    # Remove leading characters until a letter or underscore occurs
    modelName = re.sub('^[^a-zA-Z_]+', '', modelName)

    buildingData = bdm.Building(name=modelName, pos=(0.0,0.0,0.0))
    ico = 1
    treatedCon = {}

    ## Original walls
    for owa in originalWalls:
        buildingData.addOriginalWall(owa)

    ## Original doors
    for odo in originalDoors:
        buildingData.addOriginalDoor(odo)

    ## Original slabs
    for osl in originalSlabs:
        buildingData.addOriginalSlab(osl)

    ## Original Windows
    for owi in originalWindows:
        buildingData.addOriginalWindow(owi)

    ## Materials
    mats = {}
    for ram in file.by_type("ifcrelassociatesmaterial"):
        if ram.RelatingMaterial.is_a("IfcMaterial"):
            mats.setdefault(ram.RelatingMaterial, []).extend([x for x in ram.RelatedObjects if x.is_a("IfcBuildingElement")])
        elif ram.RelatingMaterial.is_a("IfcMaterialLayerSet"):
            if ram.RelatingMaterial.MaterialLayers:
                ml = ram.RelatingMaterial.MaterialLayers[0]
                objects = []
                for o in [x for x in ram.RelatedObjects if x.is_a("IfcBuildingElementType")]:
                    for typo in o.ObjectTypeOf:
                        if typo.is_a("IfcRelDefinesByType"):
                            mats.setdefault(ml.Material, []).extend(typo.RelatedObjects)
                        elif typo.is_a("IfcBuildingElement"):
                            mats.setdefault(ml.Material, []).append(typo)
        elif ram.RelatingMaterial.is_a("IfcMaterialLayerSetUsage"):
            ml = ram.RelatingMaterial.ForLayerSet.MaterialLayers[0]
            objects = []
            for o in [x for x in ram.RelatedObjects if x.is_a("IfcBuildingElementType")]:
                for typo in o.ObjectTypeOf:
                    if typo.is_a("IfcRelDefinesByType"):
                        mats.setdefault(ml.Material, []).extend(typo.RelatedObjects)
                    elif typo.is_a("IfcBuildingElement"):
                        mats.setdefault(ml.Material, []).append(typo)
            for i in [x for x in ram.RelatedObjects if x.is_a("IfcBuildingElement")]:
                mats.setdefault(ml.Material, []).append(i)

    props = {}
    for mp in file.by_type("IfcMaterialProperties"):
        props.setdefault(mp.Material, {})
        if mp.is_a("IfcThermalMaterialProperties"):
            if mp.SpecificHeatCapacity:
                props[mp.Material]["Cp"] = mp.SpecificHeatCapacity
            if mp.ThermalConductivity:
                props[mp.Material]["k"] = mp.ThermalConductivity
        if mp.is_a("IfcGeneralMaterialProperties"):
            if mp.MassDensity:
                props[mp.Material]["rho"] = mp.MassDensity

    def printProperty(p,mat,name):
        if p.is_a("IfcPropertySingleValue"):
            if p.NominalValue.is_a("IfcMassDensityMeasure") and p.Name == "MassDensity":
                props.setdefault(mat, {})
                props[mat]["rho"] = p.NominalValue.wrappedValue
            if p.NominalValue.is_a("IfcSpecificHeatCapacityMeasure") and p.Name == "SpecificHeatCapacity":
                props.setdefault(mat, {})
                props[mat]["Cp"] = p.NominalValue.wrappedValue
            if p.NominalValue.is_a("IfcThermalConductivityMeasure") and p.Name == "ThermalConductivity":
                props.setdefault(mat, {})
                props[mat]["k"] = p.NominalValue.wrappedValue
        elif p.is_a("IfcComplexProperty"):
            browsePropertySet(p,mat)

    def browsePropertySet(ps,mat):
        if ps.HasProperties:
            for p in ps.HasProperties:
                printProperty(p,mat,ps.Name)

    for mat in [x for x in mats if x not in props or not props[x]]:
        for s in mats[mat]:
            for rd in s.IsDefinedBy:
                if rd.is_a("IfcRelDefinesByType") and rd.RelatingType.HasPropertySets:
                    for ps in rd.RelatingType.HasPropertySets:
                        if ps.is_a("ifcpropertyset"):
                            browsePropertySet(ps, mat)
                elif rd.is_a("IfcRelDefinesByProperties") and rd.RelatingPropertyDefinition.is_a("ifcpropertyset"):
                    browsePropertySet(rd.RelatingPropertyDefinition, mat)
            if mat in props and props[mat]:
                break

    for mat,prop in props.items():
        k = prop["k"] if "k" in prop else None
        c = prop["Cp"] if "Cp" in prop else None
        d = prop["rho"] if "rho" in prop else None
        buildingData.addMaterial(bdm.Material(name=re.sub('[^0-9a-zA-Z_]', '', mat.Name), density=d, capacity=c, conductivity=k))

    ## Construction types
    for con in MaterialLayerset.items():
        thickness = []
        material = []
        treatedCon[con[0]] = "Construction"+str(ico)
        for layer in con[1]:
            if layer.Thickness > 1.0: # length unit in the IFC file in mm
                thickness.append(layer.Thickness/1000.0)
            else: # length unit in the IFC file in m
                thickness.append(layer.Thickness)
            material.append(re.sub('[^0-9a-zA-Z_]', '',layer.Material.Name))   
            #material.append("BuildingSystems.HAM.Data.MaterialProperties.Thermal.Masea.Concrete")
        buildingData.addConstruction(bdm.Construction(name="Construction"+str(ico),
                                                      numberOfLayers=len(con[1]),
                                                      thickness=thickness,
                                                      material=material))
        ico = ico + 1
    treatedBuildingEle = {}
    treatedZones = {}
    zone_for_space = {}
    spaces_for_zone = {}
    Spaces2 = {s.Space.GlobalId : s for s in Spaces}
    
    ## Thermal zones
    for space in Spaces:
        if str(space.Space.Name) is not None:
            treatedZones[space.Space.GlobalId] = space.Space.LongName+"_"+ str(space.Space.Name)
        else:
            treatedZones[space.Space.GlobalId] = space.Space.LongName
          
    if not file.by_type("ifczone"):
        print("Thermal zones are not specified. Each space will be treated as a single thermal zone")

        for cont, space in enumerate(Spaces):
            if "Zone_" not in str(space.Space.Name):
                print('Space ',space.Space.GlobalId,' will be renamed as ',"Zone_"+str(cont+1))
                space.Space.Name = "Zone_"+str(cont+1)

            treatedZones[space.Space.GlobalId] = space.Space.Name
            
            spaces_for_zone[space.Space] = [Spaces2[space.Space.GlobalId]]
            zone_for_space[space.Space.GlobalId] = space.Space
    else:
        for z in file.by_type("IfcZone"):
            spaces_for_zone[z] = []
            for ratg in z.IsGroupedBy:
                for s in ratg.RelatedObjects:
                    zone_for_space[s.GlobalId] = z
                    spaces_for_zone[z].append(Spaces2[s.GlobalId])


    # print(black_list)
    iwa = 1
    isl = 1
    irf = 1
    ido = 1
    iwi = 1
    bounds_by_zone = {}
    for zone, spaces in spaces_for_zone.items():
        volume = 0
        iel = 0
        iwaz = 0
        islz = 0
        irfz = 0
        idoz = 0
        iwiz = 0
        heightMin = 0.0
        heightMax = 0.0
        # Revit gives a suffix to zone name after :
        zone_name = zone.Name.split(':')[0]
        for space in spaces:
            ## Construction elements
            for bound in space.Boundaries:
                if bound.OtherSideSpace in treatedZones.keys() or bound.OtherSideSpace == "EXTERNAL":
                    side1 = zone_name
                    if bound.OtherSideSpace == "EXTERNAL":
                        side2 = "AMB"
                    elif zone_for_space[bound.OtherSideSpace] != zone:
                        side2 = zone_for_space[bound.OtherSideSpace].Name.split(':')[0]
                    else:
                        # if other side in same zone, discard boundary
                        continue
                    ## Walls
                    if bound.RelatedBuildingElement in WallInfo.keys() and bound.thickness[0] > 0.0:
                        if bound.OtherSideBoundary not in treatedBuildingEle.keys():
                            treatedBuildingEle[bound.Id] = "wall_"+str(iwa)
                            includedWindows = []
                            includedDoors = []
                            for b in space.Boundaries:
                                if b.Id in bound.IncludedBoundariesIds:
                                    if b.RelatedBuildingElement in WindowToStyle.keys():
                                        includedWindows.append((b.Width,b.Height))
                                    if b.RelatedBuildingElement in DoorToStyle.keys():
                                        includedDoors.append((b.Width,b.Height))
                            opaque_element = bdm.BuildingElementOpaque(id=''.join(list(bound.Id)[-22:]),
                                                                       name="wall_"+str(iwa),
                                                                       pos=(bound.Position.X(),bound.Position.Y(),bound.Position.Z()),
                                                                       angleDegAzi=azimuthAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()),
                                                                       angleDegTil=tiltAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()),
                                                                       adjZoneSide1=side1,
                                                                       adjZoneSide2=side2,
                                                                       width=bound.Width,
                                                                       height=bound.Height,
                                                                       areaNet=bound.Area,
                                                                       thickness=bound.thickness[0],
                                                                       constructionData=treatedCon[BuildingElementToMaterialLayerSet[bound.RelatedBuildingElement]],
                                                                       mesh=DataClasses.Mesh(bound.Face),
                                                                       includedWindows=includedWindows,
                                                                       includedDoors=includedDoors)
                            bounds_by_zone.setdefault((bound.RelatedBuildingElement, side2), []).append(opaque_element)
                            iwa = iwa + 1

                        else:
                            iel = iel + 1

                    ## Slabs
                    if bound.RelatedBuildingElement in SlabsInfo.keys() and tiltAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()) in [0.0,180.0]:
                        if bound.OtherSideBoundary not in treatedBuildingEle.keys():
                            treatedBuildingEle[bound.Id] = "slab_"+str(isl)
                            if bound.Position.Z() > heightMax:
                                heightMax = bound.Position.Z()
                            if bound.Position.Z() < heightMin:
                                heightMin = bound.Position.Z()
                            opaque_element = bdm.BuildingElementOpaque(id=''.join(list(bound.Id)[-22:]),
                                                                       name="slab_"+str(isl),
                                                                       pos=(bound.Position.X(),bound.Position.Y(),bound.Position.Z()),
                                                                       angleDegAzi=azimuthAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()),
                                                                       angleDegTil=tiltAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()),
                                                                       adjZoneSide1=side1,
                                                                       adjZoneSide2=side2,
                                                                       width=bound.Width,
                                                                       height=bound.Height,
                                                                       areaNet=bound.Area,
                                                                       thickness=bound.thickness[0],
                                                                       constructionData=treatedCon[BuildingElementToMaterialLayerSet[bound.RelatedBuildingElement]],
                                                                       mesh=DataClasses.Mesh(bound.Face),
                                                                       includedWindows=[],
                                                                       includedDoors=[])                                                                             
                            bounds_by_zone.setdefault((bound.RelatedBuildingElement, side2), []).append(opaque_element)
                            isl = isl + 1
                        else:
                            iel = iel + 1
                    
                    ## Roofs
                    if bound.RelatedBuildingElement in SlabsInfo.keys() and tiltAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()) not in [0.0,180.0]:
                        if bound.OtherSideBoundary not in treatedBuildingEle.keys():
                            treatedBuildingEle[bound.Id] = "roof_"+str(irf)
                            if bound.Position.Z() > heightMax:
                                heightMax = bound.Position.Z()
                            if bound.Position.Z() < heightMin:
                                heightMin = bound.Position.Z()
                            opaque_element = bdm.BuildingElementOpaque(id=''.join(list(bound.Id)[-22:]),
                                                                       name="roof_"+str(irf),
                                                                       pos=(bound.Position.X(),bound.Position.Y(),bound.Position.Z()),
                                                                       angleDegAzi=azimuthAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()),
                                                                       angleDegTil=tiltAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()),
                                                                       adjZoneSide1=side1,
                                                                       adjZoneSide2=side2,
                                                                       width=bound.Width,
                                                                       height=bound.Height,
                                                                       areaNet=bound.Area,
                                                                       thickness=bound.thickness[0],
                                                                       constructionData=treatedCon[BuildingElementToMaterialLayerSet[bound.RelatedBuildingElement]],
                                                                       mesh=DataClasses.Mesh(bound.Face),
                                                                       includedWindows=[],
                                                                       includedDoors=[])                                                                             
                            bounds_by_zone.setdefault((bound.RelatedBuildingElement, side2), []).append(opaque_element)
                            irf = irf + 1
                        else:
                            iel = iel + 1

                    ## Doors
                    if bound.RelatedBuildingElement in DoorToStyle.keys():
                        iel = iel + 1
                        idoz = idoz + 1
                        if bound.OtherSideBoundary not in treatedBuildingEle.keys():
                            mesh=DataClasses.Mesh(bound.Face)
                            treatedBuildingEle[bound.Id] = "door_"+str(ido)
                            if bound.Width <= 0.01: # unit is m
                                bound.Width = bound.Width*1000 # convert to mm
                            if bound.Height <= 0.01:
                                bound.Height = bound.Height*1000
                            buildingData.addDoorElement(bdm.BuildingElementDoor(id=''.join(list(bound.Id)[-22:]),
                                                                                name="door_"+str(ido),
                                                                                pos=(bound.Position.X(),bound.Position.Y(),bound.Position.Z()),
                                                                                angleDegAzi=azimuthAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()),
                                                                                angleDegTil=tiltAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()),
                                                                                adjZoneSide1=side1,
                                                                                adjZoneSide2=side2,
                                                                                width=bound.Width,
                                                                                height=bound.Height,
                                                                                areaNet=bound.Area,
                                                                                thickness=bound.thickness[0],
                                                                                constructionData="Construction1",
                                                                                mesh=DataClasses.Mesh(bound.Face)))
                            ido = ido + 1

                    ## Transparent elements
                    if bound.RelatedBuildingElement in WindowToStyle.keys():
                        iel = iel + 1
                        iwiz = iwiz + 1
                        if bound.OtherSideBoundary not in treatedBuildingEle.keys():
                            mesh=DataClasses.Mesh(bound.Face)
                            treatedBuildingEle[bound.Id] = "window_"+str(iwi)
                            if bound.Width <= 0.01: # unit is m
                                bound.Width = bound.Width*1000 # convert to mm
                            if bound.Height <= 0.01:
                                bound.Height = bound.Height*1000
                            buildingData.addTransparentElement(bdm.BuildingElementTransparent(id=''.join(list(bound.Id)[-22:]),
                                                                                              name="window_"+str(iwi),
                                                                                              pos=(bound.Position.X(),bound.Position.Y(),bound.Position.Z()),
                                                                                              angleDegAzi=azimuthAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()),
                                                                                              angleDegTil=tiltAngle(bound.Normal.X(),bound.Normal.Y(),bound.Normal.Z()),
                                                                                              adjZoneSide1=side1,
                                                                                              adjZoneSide2=side2,
                                                                                              width=bound.Width,
                                                                                              height=bound.Height,
                                                                                              areaNet=bound.Area,
                                                                                              thickness=bound.thickness[0],
                                                                                              mesh=DataClasses.Mesh(bound.Face)))
                            iwi = iwi + 1

            volume += space.Volume

        for related_element, side2 in bounds_by_zone:
            opaque_elements = bounds_by_zone[(related_element, side2)]
            iel = iel + 1
            
            if related_element in WallInfo.keys():
                iwaz = iwaz + 1
            else:
                islz = islz + 1

            posX = min([x.pos.X() for x in opaque_elements])
            posY = min([x.pos.Y() for x in opaque_elements])
            posZ = min([x.pos.Z() for x in opaque_elements])
            areaNet = sum([x.areaNet for x in opaque_elements])
            height = mean([x.height for x in opaque_elements])
            width = sum([x.width for x in opaque_elements])
            angleDegAzi = sum([x.areaNet*x.angleDegAzi for x in opaque_elements])/areaNet
            angleDegTil = sum([x.areaNet*x.angleDegTil for x in opaque_elements])/areaNet
            includedWindows = sum([x.includedWindows for x in opaque_elements], [])
            includedDoors = sum([x.includedDoors for x in opaque_elements], [])
            buildingData.addOpaqueElement(bdm.BuildingElementOpaque(id=opaque_elements[0].id,
                                                                    name=opaque_elements[0].name,
                                                                    pos=(posX, posY, posZ),
                                                                    angleDegAzi=angleDegAzi,
                                                                    angleDegTil=angleDegTil,
                                                                    adjZoneSide1=zone_name,
                                                                    adjZoneSide2=side2,
                                                                    height=height,
                                                                    width=width,
                                                                    # width=areaNet,
                                                                    # height=1,
                                                                    areaNet=areaNet,
                                                                    thickness=opaque_elements[0].thickness,
                                                                    constructionData=opaque_elements[0].constructionData,
                                                                    mesh=opaque_elements[0].mesh,
                                                                    includedWindows=includedWindows,
                                                                    includedDoors=includedDoors))

        bounds_by_zone.clear()

        ## Thermal zones
        buildingData.addZone(bdm.BuildingZone(id=zone.GlobalId,
                                              name=zone_name,
                                              pos=(0.0,0.0,0.0),
                                              volume=volume,
                                              height=abs(heightMax-heightMin),
                                              numberOfElements=iel,
                                              numberOfWalls=iwaz,
                                              numberOfSlabs=islz,
                                              numberOfDoors=idoz,
                                              numberOfWindows=iwiz,
                                              TSetHeating=20.0,
                                              TSetCooling=24.0,
                                              airchange=0.5,
                                              thermalLoads=0.0,
                                              moistLoads=0.0))        
    return buildingData
    

def getGeneratorData(buildingData):
    '''
    Takes the information from the building data model and store it
    in the data model for the multizone building code generator
    '''
    ## Materials
    materials = []
    for mat in buildingData.getParameter('materials'):
        materials.append(dmg.Material(name=mat.name,
                                        density=mat.density,
                                        capacity=mat.capacity,
                                        conductivity=mat.conductivity))

    ## Construction types
    constructions = []
    for con in buildingData.getParameter('constructions'):
        constructions.append(dmg.Construction(name=con.name,
                                              nLayers=con.numberOfLayers,
                                              thickness=con.thickness,
                                              material=con.material))

    ## Thermal zones
    zones = []
    for zone in buildingData.getParameter('zones'):
        zones.append(dmg.Zone(id=zone.id,
                              name=zone.name,
                              pos=(zone.pos.X(),zone.pos.Y(),zone.pos.Z()),
                              nElements=zone.numberOfElements,
                              nWalls=zone.numberOfWalls,
                              nSlabs=zone.numberOfSlabs,
                              nDoors=zone.numberOfDoors,
                              nWindows=zone.numberOfWindows,
                              volume=round(zone.volume,3),
                              height=round(zone.height,3),
                              TSetHeating=zone.TSetHeating,
                              TSetCooling=zone.TSetCooling,
                              airchange=zone.airchange,
                              heatsource=zone.thermalLoads,
                              moisturesource=zone.moistLoads))

    ## Opaque elements
    elementsOpaque = []
    for eleOpa in buildingData.getParameter('opaqueElements'):
        elementsOpaque.append(dmg.ElementOpaque(id=eleOpa.id,
                                                name=eleOpa.name,
                                                pos=(eleOpa.pos.X(),eleOpa.pos.Y(),eleOpa.pos.Z()),
                                                memberOfZone=[eleOpa.adjZoneSide1,eleOpa.adjZoneSide2],
                                                angleDegAzi=round(eleOpa.angleDegAzi,3),
                                                angleDegTil=round(eleOpa.angleDegTil,3),
                                                height=round(eleOpa.height,3),
                                                width=round(eleOpa.width,3),
                                                thickness=round(eleOpa.thickness,3),
                                                mesh=eleOpa.mesh,
                                                constructionData=eleOpa.constructionData,
                                                # AInnSur=round(sum(x[0]*x[1] for x in eleOpa.includedWindows)+sum(y[0]*y[1] for y in eleOpa.includedDoors),3),
                                                AInnSur=round(eleOpa.width*eleOpa.height-eleOpa.areaNet,3), 
                                                includedWindows=eleOpa.includedWindows,
                                                includedDoors=eleOpa.includedDoors))
    ## Transparent elements
    elementsTransparent = []
    for eleTra in buildingData.getParameter('transparentElements'):
        elementsTransparent.append(dmg.ElementTransparent(id=eleTra.id,
                                                          name=eleTra.name,
                                                          pos=(eleTra.pos.X(),eleTra.pos.Y(),eleTra.pos.Z()),
                                                          memberOfZone=[eleTra.adjZoneSide1,eleTra.adjZoneSide2],
                                                          angleDegAzi=round(eleTra.angleDegAzi,3),
                                                          angleDegTil=round(eleTra.angleDegTil,3),
                                                          height=round(eleTra.height,3),
                                                          width=round(eleTra.width,3),
                                                          thickness=round(eleTra.thickness,3),
                                                          mesh=eleTra.mesh))

    ## Door elements
    elementsDoor = []
    for eleDoo in buildingData.getParameter('doorElements'):
        elementsDoor.append(dmg.ElementDoor(id=eleDoo.id,
                                            name=eleDoo.name,
                                            pos=(eleDoo.pos.X(),eleDoo.pos.Y(),eleDoo.pos.Z()),
                                            memberOfZone=[eleDoo.adjZoneSide1,eleDoo.adjZoneSide2],
                                            angleDegAzi=round(eleDoo.angleDegAzi,3),
                                            angleDegTil=round(eleDoo.angleDegTil,3),
                                            height=round(eleDoo.height,3),
                                            width=round(eleDoo.width,3),
                                            thickness=round(eleDoo.thickness,3),
                                            mesh=eleDoo.mesh,
                                            constructionData=eleDoo.constructionData,
                                            AInnSur=round(eleDoo.width*eleDoo.height-eleDoo.areaNet,3)))

    ## Element <-> zone
    conEleZon = []
    eleZoneRel = buildingData.getElementZoneRelations()
    for zone in eleZoneRel.keys():
        i = 1
        for con in eleZoneRel[zone]:
            conEleZon.append(dmg.ConnectionElementZone(element=con[0],
                                                       elementPort=con[1],
                                                       zone=zone,
                                                       zonePort=str(i)))
            i = i + 1

    ## Element <-> ambient
    conEleAmb = []
    eleAmbRel = buildingData.getElementAmbientRelations()
    i = 1
    for con in eleAmbRel:
        conEleAmb.append(dmg.ConnectionElementAmbient(element=con[0],
                                                      elementPort=con[1],
                                                      ambiencePort=str(i)))
        i = i + 1

    ## Element <-> solid ambient
    conEleSol = []
    eleSolRel = buildingData.getElementGroundRelations()
    i = 1
    for con in eleSolRel:
        conEleSol.append(dmg.ConnectionElementSolid(element=con[0],
                                                    elementPort=con[1],
                                                    solidPort=str(i)))
        i = i + 1

    ## Building system
    buildingSystem = dmg.BuildingSystem(name=buildingData.getParameter('name'),
                                        # location='BuildingSystems.Climate.WeatherDataIbat.Illkirch_ASCII',
                                        location='BuildingSystems.Climate.WeatherDataMeteonorm.Germany_Berlin_Meteonorm_ASCII',
                                        originalWalls = buildingData.getParameter('originalWalls'),
                                        originalDoors = buildingData.getParameter('originalDoors'),
                                        originalSlabs = buildingData.getParameter('originalSlabs'),
                                        originalWindows = buildingData.getParameter('originalWindows'))

    return {'materials':materials,
            'constructions':constructions,
            'zones':zones,
            'elementsOpaque':elementsOpaque,
            'elementsTransparent':elementsTransparent,
            'elementsDoor':elementsDoor,
            'conEleZon':conEleZon,
            'conEleAmb':conEleAmb,
            'conEleSol':conEleSol,
            'buildingSystem':buildingSystem}

def filter01(d, systemCfg, generatorCfg, logger):
    for fileName in d:
        fileData = d[fileName]
        logger.info('determine building model information for file: %s', fileName)
        dataModel = mapIFCtoBuildingDataModel(fileData['IfcData'], fileName)
        logger.info('determine generator data for file: %s', fileName)
        # insert additional data into the existing dictionary for this file,
        # using an underscore will minimize the risk of overwriting data read from the json file
        fileData['_buildingData'] = getGeneratorData(dataModel)
    print('ready')
