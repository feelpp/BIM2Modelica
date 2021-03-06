within ModelicaModels.IFC2X3.SBT_Unit_Test_Cases;
/**************************************************************************************/
// Automatically generated thermal building model by
// CoTeTo code generator IFC_MultiZoneBuildings_Modelica on Tue Mar  3 21:09:12 2020
//
// Used MODELICA_CODE_SWITCHES for code generation:
// surTemOut = on: sets surface temperatures as an output of the building model
// used value: off
//
// intHeaSou = on: sets internal heat sources for all thermal zones:
// used value: on
//
// useAirPaths = on: uses air paths of windows and doors to calculate ventilation rates:
// used value: off
//
// prescribedAirchange = on: defines ventilation rates for each thermal zone as
// a prescribed air change rate:
// used value: on
//
// calcIdealLoads = on: calculates the ideal heating and cooling loads for each
// thermal zone for prescribed set temperatures:
// used value: on
/***************************************************************************************/
model SWW5_SB
  "Model of a building with its climate ambience"
  extends Modelica.Icons.Example;

  record Construction1
    extends BuildingSystems.Buildings.Data.Constructions.OpaqueThermalConstruction(
      nLayers=1,
      thickness={
        0.2
      },
      material={
        BuildingSystems.HAM.Data.MaterialProperties.Thermal.Masea.Concrete()
      });
  end Construction1;

  model Building
    "Automatically generated multi-zone building model"
    extends BuildingSystems.Buildings.BaseClasses.BuildingTemplate(
    nZones = 9,
    surfacesToAmbience(nSurfaces = 21),
    nSurfacesSolid = 0,
    surfacesToSolids(nSurfaces = nSurfacesSolid),
    useAirPaths = false,
    calcIdealLoads = true,
    prescribedAirchange = true,
    heatSources = true,
    nHeatSources = 9,
    convectionOnSurfaces = BuildingSystems.HAM.ConvectiveHeatTransfer.Types.Convection.forced);

    // Thermal zones
    BuildingSystems.Buildings.Zones.ZoneTemplateAirvolumeMixed zone_1(
      V=72.200392768,
      nConstructions = 8,
      calcIdealLoads = true,
      prescribedAirchange = true,
      heatSources = true,
      nHeatSources = 1,
      height=3.8);
    BuildingSystems.Buildings.Zones.ZoneTemplateAirvolumeMixed zone_2(
      V=269.95150751999995,
      nConstructions = 9,
      calcIdealLoads = true,
      prescribedAirchange = true,
      heatSources = true,
      nHeatSources = 1,
      height=3.8);
    BuildingSystems.Buildings.Zones.ZoneTemplateAirvolumeMixed zone_3(
      V=281.199487,
      nConstructions = 8,
      calcIdealLoads = true,
      prescribedAirchange = true,
      heatSources = true,
      nHeatSources = 1,
      height=3.8);
    BuildingSystems.Buildings.Zones.ZoneTemplateAirvolumeMixed zone_4(
      V=114.00062016,
      nConstructions = 9,
      calcIdealLoads = true,
      prescribedAirchange = true,
      heatSources = true,
      nHeatSources = 1,
      height=3.8);
    BuildingSystems.Buildings.Zones.ZoneTemplateAirvolumeMixed zone_5(
      V=72.45931531461997,
      nConstructions = 7,
      calcIdealLoads = true,
      prescribedAirchange = true,
      heatSources = true,
      nHeatSources = 1,
      height=7.8);
    BuildingSystems.Buildings.Zones.ZoneTemplateAirvolumeMixed zone_6(
      V=176.1395425226143,
      nConstructions = 7,
      calcIdealLoads = true,
      prescribedAirchange = true,
      heatSources = true,
      nHeatSources = 1,
      height=7.8);
    BuildingSystems.Buildings.Zones.ZoneTemplateAirvolumeMixed zone_7(
      V=222.66904060500983,
      nConstructions = 9,
      calcIdealLoads = true,
      prescribedAirchange = true,
      heatSources = true,
      nHeatSources = 1,
      height=7.8);
    BuildingSystems.Buildings.Zones.ZoneTemplateAirvolumeMixed zone_8(
      V=72.45931531461997,
      nConstructions = 7,
      calcIdealLoads = true,
      prescribedAirchange = true,
      heatSources = true,
      nHeatSources = 1,
      height=7.8);
    BuildingSystems.Buildings.Zones.ZoneTemplateAirvolumeMixed zone_9(
      V=176.13954355941664,
      nConstructions = 7,
      calcIdealLoads = true,
      prescribedAirchange = true,
      heatSources = true,
      nHeatSources = 1,
      height=7.8);

    // Opaque construction elements
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_1(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 90.0,
      AInnSur = -0.0,
      height = 3.8,
      width = 5.0000272);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_2(
      redeclare Construction1 constructionData,
      angleDegAzi = -90.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 3.8);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_3(
      redeclare Construction1 constructionData,
      angleDegAzi = 180.0,
      angleDegTil = 90.0,
      AInnSur = -0.0,
      height = 3.7999999999999994,
      width = 5.0000272);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_4(
      redeclare Construction1 constructionData,
      angleDegAzi = 90.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 3.8);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_1(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 180.0,
      AInnSur = -0.0,
      height = 3.8,
      width = 5.0000272);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_2(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = -0.0,
      height = 0.8715728999999959,
      width = 2.0716002000000002);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_3(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = -6.26,
      height = 0,
      width = 3.858578608766293);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_4(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = 3.722,
      height = 2.7284271,
      width = 4.8586058);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_5(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 14.799973);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_6(
      redeclare Construction1 constructionData,
      angleDegAzi = -90.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 0.8000000000000026);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_7(
      redeclare Construction1 constructionData,
      angleDegAzi = 180.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 14.7999731);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_8(
      redeclare Construction1 constructionData,
      angleDegAzi = 90.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 4.8);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_5(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 180.0,
      AInnSur = 0.0,
      height = 4.8,
      width = 14.799973);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_6(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = 3.722,
      height = 2.728427100000001,
      width = 4.658578660000001);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_7(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = 0.0,
      height = 1.8715728999999994,
      width = 11.871546);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_8(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = 3.722,
      height = 2.7284271,
      width = 14.6585515);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_9(
      redeclare Construction1 constructionData,
      angleDegAzi = -90.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.7999999999999994,
      width = 5.0);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_10(
      redeclare Construction1 constructionData,
      angleDegAzi = 180.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 14.799973);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_11(
      redeclare Construction1 constructionData,
      angleDegAzi = 90.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 5.0);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_9(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 180.0,
      AInnSur = 0.0,
      height = 5.0,
      width = 14.799973);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_10(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = 3.722,
      height = 2.728427100000001,
      width = 4.85857864);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_11(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = 3.722,
      height = 2.7284270999999998,
      width = 14.658551359999999);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_12(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = 0.0,
      height = 2.071572900000004,
      width = 11.871545999999997);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_12(
      redeclare Construction1 constructionData,
      angleDegAzi = -90.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 6.0);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_13(
      redeclare Construction1 constructionData,
      angleDegAzi = 180.0,
      angleDegTil = 90.0,
      AInnSur = -0.0,
      height = 3.8,
      width = 5.0000272);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_13(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 180.0,
      AInnSur = 0.0,
      height = 5.0000272,
      width = 6.0);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_14(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = 3.722,
      height = 2.7284270999999998,
      width = 4.85860584);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_15(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = 0.0,
      height = 2.0716002000000002,
      width = 3.071572900000005);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_16(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = 3.722,
      height = 2.7284271,
      width = 5.858578700000001);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_14(
      redeclare Construction1 constructionData,
      angleDegAzi = 90.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 9.7171573);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_15(
      redeclare Construction1 constructionData,
      angleDegAzi = -45.0,
      angleDegTil = 90.0,
      AInnSur = -0.0,
      height = 3.8000000000000007,
      width = 3.8585786043831485);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_16(
      redeclare Construction1 constructionData,
      angleDegAzi = -90.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 4.1431458);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_17(
      redeclare Construction1 constructionData,
      angleDegAzi = -135.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8000000000000007,
      width = 3.8585786100966057);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_17(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = -19.068,
      height = 0,
      width = 9.7171573);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_18(
      redeclare Construction1 constructionData,
      angleDegAzi = 180.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 19.717157);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_19(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 90.0,
      AInnSur = -0.0,
      height = 3.8,
      width = 14.143145999999994);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_20(
      redeclare Construction1 constructionData,
      angleDegAzi = -45.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8000000000000007,
      width = 3.858578610096605);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_18(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = -46.353,
      height = 0,
      width = 19.717157);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_21(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 90.0,
      AInnSur = -0.0,
      height = 3.8,
      width = 14.143145999999998);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_22(
      redeclare Construction1 constructionData,
      angleDegAzi = -90.00000000000001,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 4.1431458);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_19(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = 0.0,
      height = 4.1431458,
      width = 14.143146);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_23(
      redeclare Construction1 constructionData,
      angleDegAzi = -90.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 9.7171573);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_24(
      redeclare Construction1 constructionData,
      angleDegAzi = 45.0,
      angleDegTil = 90.0,
      AInnSur = -0.0,
      height = 3.8000000000000007,
      width = 3.858578604383147);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_20(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = -19.068,
      height = 0,
      width = 9.7171573);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes wall_25(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 90.0,
      AInnSur = 0.0,
      height = 3.8,
      width = 19.7171571);
    BuildingSystems.Buildings.Constructions.Walls.WallThermal1DNodes slab_21(
      redeclare Construction1 constructionData,
      angleDegAzi = 0.0,
      angleDegTil = 0.0,
      AInnSur = -46.353,
      height = 0,
      width = 19.7171571);

    // Transparent construction elements

    // Door elements

  equation

    // connections between construction elements and thermal zones
    connect(wall_1.toSurfacePort_1, zone_1.toConstructionPorts[1]);
    connect(wall_2.toSurfacePort_1, zone_1.toConstructionPorts[2]);
    connect(wall_3.toSurfacePort_1, zone_1.toConstructionPorts[3]);
    connect(wall_4.toSurfacePort_1, zone_1.toConstructionPorts[4]);
    connect(slab_1.toSurfacePort_1, zone_1.toConstructionPorts[5]);
    connect(slab_2.toSurfacePort_1, zone_1.toConstructionPorts[6]);
    connect(slab_3.toSurfacePort_1, zone_1.toConstructionPorts[7]);
    connect(slab_4.toSurfacePort_1, zone_1.toConstructionPorts[8]);
    connect(wall_3.toSurfacePort_2, zone_4.toConstructionPorts[1]);
    connect(wall_6.toSurfacePort_2, zone_4.toConstructionPorts[2]);
    connect(wall_9.toSurfacePort_2, zone_4.toConstructionPorts[3]);
    connect(wall_12.toSurfacePort_1, zone_4.toConstructionPorts[4]);
    connect(wall_13.toSurfacePort_1, zone_4.toConstructionPorts[5]);
    connect(slab_13.toSurfacePort_1, zone_4.toConstructionPorts[6]);
    connect(slab_14.toSurfacePort_1, zone_4.toConstructionPorts[7]);
    connect(slab_15.toSurfacePort_1, zone_4.toConstructionPorts[8]);
    connect(slab_16.toSurfacePort_1, zone_4.toConstructionPorts[9]);
    connect(wall_4.toSurfacePort_2, zone_2.toConstructionPorts[1]);
    connect(wall_5.toSurfacePort_1, zone_2.toConstructionPorts[2]);
    connect(wall_6.toSurfacePort_1, zone_2.toConstructionPorts[3]);
    connect(wall_7.toSurfacePort_1, zone_2.toConstructionPorts[4]);
    connect(wall_8.toSurfacePort_1, zone_2.toConstructionPorts[5]);
    connect(slab_5.toSurfacePort_1, zone_2.toConstructionPorts[6]);
    connect(slab_6.toSurfacePort_1, zone_2.toConstructionPorts[7]);
    connect(slab_7.toSurfacePort_1, zone_2.toConstructionPorts[8]);
    connect(slab_8.toSurfacePort_1, zone_2.toConstructionPorts[9]);
    connect(slab_2.toSurfacePort_2, zone_7.toConstructionPorts[1]);
    connect(slab_7.toSurfacePort_2, zone_7.toConstructionPorts[2]);
    connect(slab_12.toSurfacePort_2, zone_7.toConstructionPorts[3]);
    connect(slab_15.toSurfacePort_2, zone_7.toConstructionPorts[4]);
    connect(wall_16.toSurfacePort_2, zone_7.toConstructionPorts[5]);
    connect(wall_19.toSurfacePort_2, zone_7.toConstructionPorts[6]);
    connect(wall_21.toSurfacePort_1, zone_7.toConstructionPorts[7]);
    connect(wall_22.toSurfacePort_1, zone_7.toConstructionPorts[8]);
    connect(slab_19.toSurfacePort_1, zone_7.toConstructionPorts[9]);
    connect(slab_3.toSurfacePort_2, zone_8.toConstructionPorts[1]);
    connect(slab_16.toSurfacePort_2, zone_8.toConstructionPorts[2]);
    connect(wall_20.toSurfacePort_2, zone_8.toConstructionPorts[3]);
    connect(wall_22.toSurfacePort_2, zone_8.toConstructionPorts[4]);
    connect(wall_23.toSurfacePort_1, zone_8.toConstructionPorts[5]);
    connect(wall_24.toSurfacePort_1, zone_8.toConstructionPorts[6]);
    connect(slab_20.toSurfacePort_1, zone_8.toConstructionPorts[7]);
    connect(slab_4.toSurfacePort_2, zone_9.toConstructionPorts[1]);
    connect(slab_8.toSurfacePort_2, zone_9.toConstructionPorts[2]);
    connect(wall_15.toSurfacePort_2, zone_9.toConstructionPorts[3]);
    connect(wall_21.toSurfacePort_2, zone_9.toConstructionPorts[4]);
    connect(wall_24.toSurfacePort_2, zone_9.toConstructionPorts[5]);
    connect(wall_25.toSurfacePort_1, zone_9.toConstructionPorts[6]);
    connect(slab_21.toSurfacePort_1, zone_9.toConstructionPorts[7]);
    connect(wall_7.toSurfacePort_2, zone_3.toConstructionPorts[1]);
    connect(wall_9.toSurfacePort_1, zone_3.toConstructionPorts[2]);
    connect(wall_10.toSurfacePort_1, zone_3.toConstructionPorts[3]);
    connect(wall_11.toSurfacePort_1, zone_3.toConstructionPorts[4]);
    connect(slab_9.toSurfacePort_1, zone_3.toConstructionPorts[5]);
    connect(slab_10.toSurfacePort_1, zone_3.toConstructionPorts[6]);
    connect(slab_11.toSurfacePort_1, zone_3.toConstructionPorts[7]);
    connect(slab_12.toSurfacePort_1, zone_3.toConstructionPorts[8]);
    connect(slab_6.toSurfacePort_2, zone_5.toConstructionPorts[1]);
    connect(slab_10.toSurfacePort_2, zone_5.toConstructionPorts[2]);
    connect(wall_14.toSurfacePort_1, zone_5.toConstructionPorts[3]);
    connect(wall_15.toSurfacePort_1, zone_5.toConstructionPorts[4]);
    connect(wall_16.toSurfacePort_1, zone_5.toConstructionPorts[5]);
    connect(wall_17.toSurfacePort_1, zone_5.toConstructionPorts[6]);
    connect(slab_17.toSurfacePort_1, zone_5.toConstructionPorts[7]);
    connect(slab_11.toSurfacePort_2, zone_6.toConstructionPorts[1]);
    connect(slab_14.toSurfacePort_2, zone_6.toConstructionPorts[2]);
    connect(wall_17.toSurfacePort_2, zone_6.toConstructionPorts[3]);
    connect(wall_18.toSurfacePort_1, zone_6.toConstructionPorts[4]);
    connect(wall_19.toSurfacePort_1, zone_6.toConstructionPorts[5]);
    connect(wall_20.toSurfacePort_1, zone_6.toConstructionPorts[6]);
    connect(slab_18.toSurfacePort_1, zone_6.toConstructionPorts[7]);

    // connections between construction elements and environment
    connect(wall_1.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[1]);
    connect(wall_2.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[2]);
    connect(slab_1.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[3]);
    connect(wall_5.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[4]);
    connect(wall_8.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[5]);
    connect(slab_5.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[6]);
    connect(wall_10.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[7]);
    connect(wall_11.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[8]);
    connect(slab_9.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[9]);
    connect(wall_12.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[10]);
    connect(wall_13.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[11]);
    connect(slab_13.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[12]);
    connect(wall_14.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[13]);
    connect(slab_17.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[14]);
    connect(wall_18.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[15]);
    connect(slab_18.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[16]);
    connect(slab_19.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[17]);
    connect(wall_23.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[18]);
    connect(slab_20.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[19]);
    connect(wall_25.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[20]);
    connect(slab_21.toSurfacePort_2, surfacesToAmbience.toConstructionPorts[21]);

    // Heating set temperature of each thermal zones
    connect(zone_1.T_setHeating, T_setHeating[1]);
    connect(zone_2.T_setHeating, T_setHeating[2]);
    connect(zone_3.T_setHeating, T_setHeating[3]);
    connect(zone_4.T_setHeating, T_setHeating[4]);
    connect(zone_5.T_setHeating, T_setHeating[5]);
    connect(zone_6.T_setHeating, T_setHeating[6]);
    connect(zone_7.T_setHeating, T_setHeating[7]);
    connect(zone_8.T_setHeating, T_setHeating[8]);
    connect(zone_9.T_setHeating, T_setHeating[9]);

    // Cooling set temperatures of each thermal zones
    connect(zone_1.T_setCooling, T_setCooling[1]);
    connect(zone_2.T_setCooling, T_setCooling[2]);
    connect(zone_3.T_setCooling, T_setCooling[3]);
    connect(zone_4.T_setCooling, T_setCooling[4]);
    connect(zone_5.T_setCooling, T_setCooling[5]);
    connect(zone_6.T_setCooling, T_setCooling[6]);
    connect(zone_7.T_setCooling, T_setCooling[7]);
    connect(zone_8.T_setCooling, T_setCooling[8]);
    connect(zone_9.T_setCooling, T_setCooling[9]);

    // Cooling load of each thermal zones
    connect(zone_1.Q_flow_cooling, Q_flow_cooling[1]);
    connect(zone_2.Q_flow_cooling, Q_flow_cooling[2]);
    connect(zone_3.Q_flow_cooling, Q_flow_cooling[3]);
    connect(zone_4.Q_flow_cooling, Q_flow_cooling[4]);
    connect(zone_5.Q_flow_cooling, Q_flow_cooling[5]);
    connect(zone_6.Q_flow_cooling, Q_flow_cooling[6]);
    connect(zone_7.Q_flow_cooling, Q_flow_cooling[7]);
    connect(zone_8.Q_flow_cooling, Q_flow_cooling[8]);
    connect(zone_9.Q_flow_cooling, Q_flow_cooling[9]);

    // Heating load of each thermal zones
    connect(zone_1.Q_flow_heating, Q_flow_heating[1]);
    connect(zone_2.Q_flow_heating, Q_flow_heating[2]);
    connect(zone_3.Q_flow_heating, Q_flow_heating[3]);
    connect(zone_4.Q_flow_heating, Q_flow_heating[4]);
    connect(zone_5.Q_flow_heating, Q_flow_heating[5]);
    connect(zone_6.Q_flow_heating, Q_flow_heating[6]);
    connect(zone_7.Q_flow_heating, Q_flow_heating[7]);
    connect(zone_8.Q_flow_heating, Q_flow_heating[8]);
    connect(zone_9.Q_flow_heating, Q_flow_heating[9]);

    // airchange rates of each thermal zones
    connect(zone_1.airchange, airchange[1]);
    connect(zone_2.airchange, airchange[2]);
    connect(zone_3.airchange, airchange[3]);
    connect(zone_4.airchange, airchange[4]);
    connect(zone_5.airchange, airchange[5]);
    connect(zone_6.airchange, airchange[6]);
    connect(zone_7.airchange, airchange[7]);
    connect(zone_8.airchange, airchange[8]);
    connect(zone_9.airchange, airchange[9]);

    // ambient temperature of each thermal zones
    connect(zone_1.TAirAmb, TAirAmb);
    connect(zone_2.TAirAmb, TAirAmb);
    connect(zone_3.TAirAmb, TAirAmb);
    connect(zone_4.TAirAmb, TAirAmb);
    connect(zone_5.TAirAmb, TAirAmb);
    connect(zone_6.TAirAmb, TAirAmb);
    connect(zone_7.TAirAmb, TAirAmb);
    connect(zone_8.TAirAmb, TAirAmb);
    connect(zone_9.TAirAmb, TAirAmb);

    // ambient moisture of each thermal zones
    connect(zone_1.xAirAmb, xAirAmb);
    connect(zone_2.xAirAmb, xAirAmb);
    connect(zone_3.xAirAmb, xAirAmb);
    connect(zone_4.xAirAmb, xAirAmb);
    connect(zone_5.xAirAmb, xAirAmb);
    connect(zone_6.xAirAmb, xAirAmb);
    connect(zone_7.xAirAmb, xAirAmb);
    connect(zone_8.xAirAmb, xAirAmb);
    connect(zone_9.xAirAmb, xAirAmb);
    // Radiative heating source of each thermal zones
    connect(zone_1.radHeatSourcesPorts[1], radHeatSourcesPorts[1]);
    connect(zone_2.radHeatSourcesPorts[1], radHeatSourcesPorts[2]);
    connect(zone_3.radHeatSourcesPorts[1], radHeatSourcesPorts[3]);
    connect(zone_4.radHeatSourcesPorts[1], radHeatSourcesPorts[4]);
    connect(zone_5.radHeatSourcesPorts[1], radHeatSourcesPorts[5]);
    connect(zone_6.radHeatSourcesPorts[1], radHeatSourcesPorts[6]);
    connect(zone_7.radHeatSourcesPorts[1], radHeatSourcesPorts[7]);
    connect(zone_8.radHeatSourcesPorts[1], radHeatSourcesPorts[8]);
    connect(zone_9.radHeatSourcesPorts[1], radHeatSourcesPorts[9]);

    // Convective heating source of each thermal zones
    connect(zone_1.conHeatSourcesPorts[1], conHeatSourcesPorts[1]);
    connect(zone_2.conHeatSourcesPorts[1], conHeatSourcesPorts[2]);
    connect(zone_3.conHeatSourcesPorts[1], conHeatSourcesPorts[3]);
    connect(zone_4.conHeatSourcesPorts[1], conHeatSourcesPorts[4]);
    connect(zone_5.conHeatSourcesPorts[1], conHeatSourcesPorts[5]);
    connect(zone_6.conHeatSourcesPorts[1], conHeatSourcesPorts[6]);
    connect(zone_7.conHeatSourcesPorts[1], conHeatSourcesPorts[7]);
    connect(zone_8.conHeatSourcesPorts[1], conHeatSourcesPorts[8]);
    connect(zone_9.conHeatSourcesPorts[1], conHeatSourcesPorts[9]);
  end Building;

  Building building(
    nZones = 9)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));

  BuildingSystems.Buildings.Ambience ambience(
    nSurfaces = building.nSurfacesAmbience,
    redeclare block WeatherData = BuildingSystems.Climate.WeatherDataMeteonorm.Germany_Berlin_Meteonorm_ASCII)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));

    // Heating set temperature of the thermal zones
    Modelica.Blocks.Sources.Constant TSetHeating_zone_1(
      k=273.15 + 20.0)
      annotation (Placement(transformation(extent={{58,16},{50,24}})));
    Modelica.Blocks.Sources.Constant TSetHeating_zone_2(
      k=273.15 + 20.0)
      annotation (Placement(transformation(extent={{58,16},{50,24}})));
    Modelica.Blocks.Sources.Constant TSetHeating_zone_3(
      k=273.15 + 20.0)
      annotation (Placement(transformation(extent={{58,16},{50,24}})));
    Modelica.Blocks.Sources.Constant TSetHeating_zone_4(
      k=273.15 + 20.0)
      annotation (Placement(transformation(extent={{58,16},{50,24}})));
    Modelica.Blocks.Sources.Constant TSetHeating_zone_5(
      k=273.15 + 20.0)
      annotation (Placement(transformation(extent={{58,16},{50,24}})));
    Modelica.Blocks.Sources.Constant TSetHeating_zone_6(
      k=273.15 + 20.0)
      annotation (Placement(transformation(extent={{58,16},{50,24}})));
    Modelica.Blocks.Sources.Constant TSetHeating_zone_7(
      k=273.15 + 20.0)
      annotation (Placement(transformation(extent={{58,16},{50,24}})));
    Modelica.Blocks.Sources.Constant TSetHeating_zone_8(
      k=273.15 + 20.0)
      annotation (Placement(transformation(extent={{58,16},{50,24}})));
    Modelica.Blocks.Sources.Constant TSetHeating_zone_9(
      k=273.15 + 20.0)
      annotation (Placement(transformation(extent={{58,16},{50,24}})));

    // Cooling set temperature of each thermal zones
    Modelica.Blocks.Sources.Constant TSetCooling_zone_1(
      k=273.15 + 24.0)
      annotation (Placement(transformation(extent={{58,2},{50,10}})));
    Modelica.Blocks.Sources.Constant TSetCooling_zone_2(
      k=273.15 + 24.0)
      annotation (Placement(transformation(extent={{58,2},{50,10}})));
    Modelica.Blocks.Sources.Constant TSetCooling_zone_3(
      k=273.15 + 24.0)
      annotation (Placement(transformation(extent={{58,2},{50,10}})));
    Modelica.Blocks.Sources.Constant TSetCooling_zone_4(
      k=273.15 + 24.0)
      annotation (Placement(transformation(extent={{58,2},{50,10}})));
    Modelica.Blocks.Sources.Constant TSetCooling_zone_5(
      k=273.15 + 24.0)
      annotation (Placement(transformation(extent={{58,2},{50,10}})));
    Modelica.Blocks.Sources.Constant TSetCooling_zone_6(
      k=273.15 + 24.0)
      annotation (Placement(transformation(extent={{58,2},{50,10}})));
    Modelica.Blocks.Sources.Constant TSetCooling_zone_7(
      k=273.15 + 24.0)
      annotation (Placement(transformation(extent={{58,2},{50,10}})));
    Modelica.Blocks.Sources.Constant TSetCooling_zone_8(
      k=273.15 + 24.0)
      annotation (Placement(transformation(extent={{58,2},{50,10}})));
    Modelica.Blocks.Sources.Constant TSetCooling_zone_9(
      k=273.15 + 24.0)
      annotation (Placement(transformation(extent={{58,2},{50,10}})));
    // Air change rate of each thermal zones
    Modelica.Blocks.Sources.Constant airchange_zone_1(
      k=0.5)
    annotation (Placement(transformation(extent={{58,-14},{50,-6}})));
    Modelica.Blocks.Sources.Constant airchange_zone_2(
      k=0.5)
    annotation (Placement(transformation(extent={{58,-14},{50,-6}})));
    Modelica.Blocks.Sources.Constant airchange_zone_3(
      k=0.5)
    annotation (Placement(transformation(extent={{58,-14},{50,-6}})));
    Modelica.Blocks.Sources.Constant airchange_zone_4(
      k=0.5)
    annotation (Placement(transformation(extent={{58,-14},{50,-6}})));
    Modelica.Blocks.Sources.Constant airchange_zone_5(
      k=0.5)
    annotation (Placement(transformation(extent={{58,-14},{50,-6}})));
    Modelica.Blocks.Sources.Constant airchange_zone_6(
      k=0.5)
    annotation (Placement(transformation(extent={{58,-14},{50,-6}})));
    Modelica.Blocks.Sources.Constant airchange_zone_7(
      k=0.5)
    annotation (Placement(transformation(extent={{58,-14},{50,-6}})));
    Modelica.Blocks.Sources.Constant airchange_zone_8(
      k=0.5)
    annotation (Placement(transformation(extent={{58,-14},{50,-6}})));
    Modelica.Blocks.Sources.Constant airchange_zone_9(
      k=0.5)
    annotation (Placement(transformation(extent={{58,-14},{50,-6}})));

    // Heating source of each thermal zones
    Modelica.Blocks.Sources.Constant heatsources_zone_1(
      k=0.0)
      annotation (Placement(transformation(extent={{44,22},{36,30}})));
    Modelica.Blocks.Sources.Constant heatsources_zone_2(
      k=0.0)
      annotation (Placement(transformation(extent={{44,22},{36,30}})));
    Modelica.Blocks.Sources.Constant heatsources_zone_3(
      k=0.0)
      annotation (Placement(transformation(extent={{44,22},{36,30}})));
    Modelica.Blocks.Sources.Constant heatsources_zone_4(
      k=0.0)
      annotation (Placement(transformation(extent={{44,22},{36,30}})));
    Modelica.Blocks.Sources.Constant heatsources_zone_5(
      k=0.0)
      annotation (Placement(transformation(extent={{44,22},{36,30}})));
    Modelica.Blocks.Sources.Constant heatsources_zone_6(
      k=0.0)
      annotation (Placement(transformation(extent={{44,22},{36,30}})));
    Modelica.Blocks.Sources.Constant heatsources_zone_7(
      k=0.0)
      annotation (Placement(transformation(extent={{44,22},{36,30}})));
    Modelica.Blocks.Sources.Constant heatsources_zone_8(
      k=0.0)
      annotation (Placement(transformation(extent={{44,22},{36,30}})));
    Modelica.Blocks.Sources.Constant heatsources_zone_9(
      k=0.0)
      annotation (Placement(transformation(extent={{44,22},{36,30}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heatFlow[9]
      annotation (Placement(transformation(extent={{32,22},{24,30}})));
    BuildingSystems.Buildings.BaseClasses.RelationRadiationConvection relationRadiationConvection[9](
      each radiationportion = 0.5)
      annotation (Placement(transformation(extent={{-5,-5},{5,5}},rotation=-90,origin={21,21})));
  equation
    // building constructions to the ambience
    connect(ambience.toSurfacePorts, building.toAmbienceSurfacesPorts)
      annotation (Line(points={{-12,4},{11,4}},color={0,255,0},smooth=Smooth.None));
    connect(ambience.toAirPorts, building.toAmbienceAirPorts)
      annotation (Line(points={{-12,-4},{11,-4}},color={85,170,255},smooth=Smooth.None));
    connect(ambience.TAirRef, building.TAirAmb)
      annotation (Line(points={{-28.2,7},{-30,7},{-30,12},{-30,14},{26.2,14},{26.2,9.8}}, color={0,0,127}));
    connect(ambience.xAir, building.xAirAmb)
      annotation (Line(points={{-28.2,5},{-32,5},{-32,16},{28.4,16},{28.4,9.8}}, color={0,0,127}));

    // Air change rate of each thermal zones
    connect(airchange_zone_1.y, building.airchange[1])
      annotation (Line(points={{29.8,3.5},{44,3.5},{44,-10},{49.6,-10}}, color={0,0,127}));
    connect(airchange_zone_2.y, building.airchange[2])
      annotation (Line(points={{29.8,3.5},{44,3.5},{44,-10},{49.6,-10}}, color={0,0,127}));
    connect(airchange_zone_3.y, building.airchange[3])
      annotation (Line(points={{29.8,3.5},{44,3.5},{44,-10},{49.6,-10}}, color={0,0,127}));
    connect(airchange_zone_4.y, building.airchange[4])
      annotation (Line(points={{29.8,3.5},{44,3.5},{44,-10},{49.6,-10}}, color={0,0,127}));
    connect(airchange_zone_5.y, building.airchange[5])
      annotation (Line(points={{29.8,3.5},{44,3.5},{44,-10},{49.6,-10}}, color={0,0,127}));
    connect(airchange_zone_6.y, building.airchange[6])
      annotation (Line(points={{29.8,3.5},{44,3.5},{44,-10},{49.6,-10}}, color={0,0,127}));
    connect(airchange_zone_7.y, building.airchange[7])
      annotation (Line(points={{29.8,3.5},{44,3.5},{44,-10},{49.6,-10}}, color={0,0,127}));
    connect(airchange_zone_8.y, building.airchange[8])
      annotation (Line(points={{29.8,3.5},{44,3.5},{44,-10},{49.6,-10}}, color={0,0,127}));
    connect(airchange_zone_9.y, building.airchange[9])
      annotation (Line(points={{29.8,3.5},{44,3.5},{44,-10},{49.6,-10}}, color={0,0,127}));

    // Heating set temperature of each thermal zones
    connect(TSetHeating_zone_1.y, building.T_setHeating[1])
      annotation (Line(points={{29.8,7.5},{44,7.5},{44,20},{49.6,20}}, color={0,0,127}));
    connect(TSetHeating_zone_2.y, building.T_setHeating[2])
      annotation (Line(points={{29.8,7.5},{44,7.5},{44,20},{49.6,20}}, color={0,0,127}));
    connect(TSetHeating_zone_3.y, building.T_setHeating[3])
      annotation (Line(points={{29.8,7.5},{44,7.5},{44,20},{49.6,20}}, color={0,0,127}));
    connect(TSetHeating_zone_4.y, building.T_setHeating[4])
      annotation (Line(points={{29.8,7.5},{44,7.5},{44,20},{49.6,20}}, color={0,0,127}));
    connect(TSetHeating_zone_5.y, building.T_setHeating[5])
      annotation (Line(points={{29.8,7.5},{44,7.5},{44,20},{49.6,20}}, color={0,0,127}));
    connect(TSetHeating_zone_6.y, building.T_setHeating[6])
      annotation (Line(points={{29.8,7.5},{44,7.5},{44,20},{49.6,20}}, color={0,0,127}));
    connect(TSetHeating_zone_7.y, building.T_setHeating[7])
      annotation (Line(points={{29.8,7.5},{44,7.5},{44,20},{49.6,20}}, color={0,0,127}));
    connect(TSetHeating_zone_8.y, building.T_setHeating[8])
      annotation (Line(points={{29.8,7.5},{44,7.5},{44,20},{49.6,20}}, color={0,0,127}));
    connect(TSetHeating_zone_9.y, building.T_setHeating[9])
      annotation (Line(points={{29.8,7.5},{44,7.5},{44,20},{49.6,20}}, color={0,0,127}));

    // Cooling set temperature of each thermal zones
    connect(TSetCooling_zone_1.y, building.T_setCooling[1])
      annotation (Line(points={{29.8,5.5},{39.6,5.5},{39.6,6},{49.6,6}}, color={0,0,127}));
    connect(TSetCooling_zone_2.y, building.T_setCooling[2])
      annotation (Line(points={{29.8,5.5},{39.6,5.5},{39.6,6},{49.6,6}}, color={0,0,127}));
    connect(TSetCooling_zone_3.y, building.T_setCooling[3])
      annotation (Line(points={{29.8,5.5},{39.6,5.5},{39.6,6},{49.6,6}}, color={0,0,127}));
    connect(TSetCooling_zone_4.y, building.T_setCooling[4])
      annotation (Line(points={{29.8,5.5},{39.6,5.5},{39.6,6},{49.6,6}}, color={0,0,127}));
    connect(TSetCooling_zone_5.y, building.T_setCooling[5])
      annotation (Line(points={{29.8,5.5},{39.6,5.5},{39.6,6},{49.6,6}}, color={0,0,127}));
    connect(TSetCooling_zone_6.y, building.T_setCooling[6])
      annotation (Line(points={{29.8,5.5},{39.6,5.5},{39.6,6},{49.6,6}}, color={0,0,127}));
    connect(TSetCooling_zone_7.y, building.T_setCooling[7])
      annotation (Line(points={{29.8,5.5},{39.6,5.5},{39.6,6},{49.6,6}}, color={0,0,127}));
    connect(TSetCooling_zone_8.y, building.T_setCooling[8])
      annotation (Line(points={{29.8,5.5},{39.6,5.5},{39.6,6},{49.6,6}}, color={0,0,127}));
    connect(TSetCooling_zone_9.y, building.T_setCooling[9])
      annotation (Line(points={{29.8,5.5},{39.6,5.5},{39.6,6},{49.6,6}}, color={0,0,127}));

    // Heating source of each thermal zones
    connect(heatsources_zone_1.y, heatFlow[1].Q_flow)
      annotation (Line(points={{32,26},{35.6,26}}, color={0,0,127}));
    connect(heatsources_zone_2.y, heatFlow[2].Q_flow)
      annotation (Line(points={{32,26},{35.6,26}}, color={0,0,127}));
    connect(heatsources_zone_3.y, heatFlow[3].Q_flow)
      annotation (Line(points={{32,26},{35.6,26}}, color={0,0,127}));
    connect(heatsources_zone_4.y, heatFlow[4].Q_flow)
      annotation (Line(points={{32,26},{35.6,26}}, color={0,0,127}));
    connect(heatsources_zone_5.y, heatFlow[5].Q_flow)
      annotation (Line(points={{32,26},{35.6,26}}, color={0,0,127}));
    connect(heatsources_zone_6.y, heatFlow[6].Q_flow)
      annotation (Line(points={{32,26},{35.6,26}}, color={0,0,127}));
    connect(heatsources_zone_7.y, heatFlow[7].Q_flow)
      annotation (Line(points={{32,26},{35.6,26}}, color={0,0,127}));
    connect(heatsources_zone_8.y, heatFlow[8].Q_flow)
      annotation (Line(points={{32,26},{35.6,26}}, color={0,0,127}));
    connect(heatsources_zone_9.y, heatFlow[9].Q_flow)
      annotation (Line(points={{32,26},{35.6,26}}, color={0,0,127}));
    connect(relationRadiationConvection.heatPort, heatFlow.port)
      annotation (Line(points={{21,22.5},{21,26},{24,26}}, color={191,0,0}));
    connect(relationRadiationConvection.heatPortCv, building.conHeatSourcesPorts[1:9])
      annotation (Line(points={{22,19},{22,10.5}}, color={191,0,0}));
    connect(relationRadiationConvection.heatPortLw, building.radHeatSourcesPorts[1:9])
      annotation (Line(points={{20,19},{20,10.5}}, color={191,0,0}));

  annotation(experiment(StartTime=0, StopTime=31536000, __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="modelica://ModelicaModels/Resources/Scripts/Dymola/IFC2X3/SBT_Unit_Test_Cases/SWW5_SB.mos" "Simulate and plot"),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})));
  end SWW5_SB;
