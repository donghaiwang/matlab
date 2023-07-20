function entry=pm_libdef





    entry(1)=PmSli.LibraryEntry('sps_lib','Power_System_Blocks','ee_lib');
    entry(1).Descriptor=sprintf('Specialized Power Systems');
    entry(1).Icon.setImage('powersys.jpg');
    entry(1).EditingModeFcn='sps_editingmodecallback';




    entry=addPrivateLibEntries(entry);
end

function entry=addPrivateLibEntries(entry)

    privateLibs={'spsAC1AExcitationSystemLib',...
    'spsAC4AExcitationSystemLib',...
    'spsAC5AExcitationSystemLib',...
    'spsACCurrentSourceLib',...
    'spsACVoltageSourceLib',...
    'spsAlphaBetaZerotoabcLib',...
    'spsAlphaBetaZerotodq0Lib',...
    'spsAsynchronousMachineSIUnitsLib',...
    'spsAsynchronousMachinepuUnitsLib',...
    'spsBatteryLib',...
    'spsBistableLib',...
    'spsBoostConverterLib',...
    'spsBreakerLib',...
    'spsBridgeFiringUnitACLib',...
    'spsBridgeFiringUnitDCLib',...
    'spsBuckConverterLib',...
    'spsChopperLib',...
    'spsCirculatingCurrentInductorsLib',...
    'spsControlledCurrentSourceLib',...
    'spsControlledVoltageSourceLib',...
    'spsCurrentControllerBrushlessDCLib',...
    'spsCurrentControllerDCLib',...
    'spsCurrentMeasurementLib',...
    'spsCurrentVoltageSimscapeInterfaceLib',...
    'spsCurrentVoltageSimscapeInterfacegndLib',...
    'spsDC1AExcitationSystemLib',...
    'spsDC2AExcitationSystemLib',...
    'spsDCMachineLib',...
    'spsDCVoltageSourceLib',...
    'spsDecouplingLineLib',...
    'spsDecouplingLineThreePhaseLib',...
    'spsDetailedThyristorLib',...
    'spsDigitalFlickermeterLib',...
    'spsDiodeLib',...
    'spsDirectTorqueControllerLib',...
    'spsDiscreteShiftRegisterLib',...
    'spsDiscreteVariableTimeDelayLib',...
    'spsDistributedParametersLineFrequencyDependentLib',...
    'spsDistributedParametersLineLib',...
    'spsDrivesPrivateModels',...
    'spsEdgeDetectorLib',...
    'spsExcitationSystemLib',...
    'spsFieldOrientedControllerLib',...
    'spsFirstOrderFilterLib',...
    'spsFourierLib',...
    'spsFrequencyPhasorLib',...
    'spsFuelCellStackLib',...
    'spsFullBridgeConverterLib',...
    'spsFullBridgeMMCExternalDCLinksLib',...
    'spsFullBridgeMMCLib',...
    'spsFundamentalPLLDrivenLib',...
    'spsGenericPowerSystemStabilizerLib',...
    'spsGroundLib',...
    'spsGroundingTransformerLib',...
    'spsGtoLib',...
    'spsHalfBridgeConverterLib',...
    'spsHalfBridgeMMCLib',...
    'spsHydraulicTurbineandGovernorLib',...
    'spsIGBTDiodeLib',...
    'spsIGBTLib',...
    'spsIdealSwitchLib',...
    'spsImpedanceMeasurementLib',...
    'spsInterfaceElementModel2',...
    'spsInverterFivePhaseLib',...
    'spsInverterThreePhaseLib',...
    'spsLeadLagFilterLib',...
    'spsLinearTransformerLib',...
    'spsLoadFlowBusLib',...
    'spsMeanLib',...
    'spsMeanPhasorLib',...
    'spsMeanVariableFrequencyLib',...
    'spsMonostableLib',...
    'spsMosfetLib',...
    'spsMultiBandPowerSystemStabilizerLib',...
    'spsMultiWindingTransformerLib',...
    'spsMultimeterLib',...
    'spsMutualInductanceLib',...
    'spsNeutralLib',...
    'spsNonlinearInductorLib',...
    'spsNonlinearResistorLib',...
    'spsOffDelayLib',...
    'spsOnDelayLib',...
    'spsOvermodulationLib',...
    'spsPLL3phLib',...
    'spsPLLLib',...
    'spsPMUPLLBasedPositiveSequenceLib',...
    'spsPVArrayLib',...
    'spsPWMGenerator2LevelLib',...
    'spsPWMGenerator3LevelLib',...
    'spsPWMGeneratorDCDCLib',...
    'spsPWMGeneratorInterpolationLib',...
    'spsPWMGeneratorMultilevelLib',...
    'spsPWMGeneratorPulseAveragingLib',...
    'spsParallelRLCBranchLib',...
    'spsParallelRLCLoadLib',...
    'spsPermanentMagnetSynchronousMachineLib',...
    'spsPiSectionLineLib',...
    'spsPositiveSequencePLLDrivenLib',...
    'spsPower3phInstantaneousLib',...
    'spsPower3phPhasorLib',...
    'spsPowerLib',...
    'spsPowerPLLDrivenPositiveSequenceLib',...
    'spsPowerPhasorLib',...
    'spsPowerPositiveSequenceLib',...
    'spsPowerdq0InstantaneousLib',...
    'spsPulseGeneratorThyristor12PulseLib',...
    'spsPulseGeneratorThyristor6PulseLib',...
    'spsRMSLib',...
    'spsRegulationSwitchLib',...
    'spsST1AExcitationSystemLib',...
    'spsST2AExcitationSystemLib',...
    'spsSVPWMGenerator2LevelLib',...
    'spsSVPWMGenerator3LevelLib',...
    'spsSampleandHoldLib',...
    'spsSaturableTransformerLib',...
    'spsSawtoothGeneratorLib',...
    'spsSecondOrderFilterLib',...
    'spsSecondOrderFilterVariableTunedLib',...
    'spsSequenceAnalyzerLib',...
    'spsSequenceAnalyzerPhasorLib',...
    'spsSeriesRLCBranchLib',...
    'spsSeriesRLCLoadLib',...
    'spsSimplifiedSynchronousMachineSIUnitsLib',...
    'spsSimplifiedSynchronousMachinepuUnitsLib',...
    'spsSinglePhaseAsynchronousMachineLib',...
    'spsSixStepGeneratorLib',...
    'spsSpaceVectorModulatorLib',...
    'spsSpeedControllerACLib',...
    'spsSpeedControllerDCLib',...
    'spsSpeedControllerScalarControlLib',...
    'spsStairGeneratorLib',...
    'spsSteamTurbineandGovernorLib',...
    'spsStepperMotorLib',...
    'spsSupercapacitor',...
    'spsSupercapacitorLib',...
    'spsSurgeArresterLib',...
    'spsSwitchedReluctanceMotorLib',...
    'spsSynchronousMachineSIFundamentalLib',...
    'spsSynchronousMachinepuFundamentalLib',...
    'spsSynchronousMachinepuStandardLib',...
    'spsTHDLib',...
    'spsThreeLevelBridgeLib',...
    'spsThreeLevelNPCConverterLib',...
    'spsThreePhaseBreakerLib',...
    'spsThreePhaseDynamicLoadLib',...
    'spsThreePhaseFaultLib',...
    'spsThreePhaseHarmonicFilterLib',...
    'spsThreePhaseMutualInductanceZ1Z0Lib',...
    'spsThreePhaseOLTCPhaseShiftingTransformer',...
    'spsThreePhaseOLTCRegulatingTransformerPhasorTypeLib',...
    'spsThreePhasePISectionLineLib',...
    'spsThreePhaseParallelRLCBranchLib',...
    'spsThreePhaseParallelRLCLoadLib',...
    'spsThreePhaseProgrammableGeneratorLib',...
    'spsThreePhaseProgrammableVoltageSourceLib',...
    'spsThreePhaseSeriesRLCBranchLib',...
    'spsThreePhaseSeriesRLCLoadLib',...
    'spsThreePhaseSineGeneratorLib',...
    'spsThreePhaseSourceLib',...
    'spsThreePhaseTransformer12TerminalsLib',...
    'spsThreePhaseTransformerInductanceMatrixTypeThreeWindingsLib',...
    'spsThreePhaseTransformerInductanceMatrixTypeTwoWindingsLib',...
    'spsThreePhaseTransformerThreeWindingsLib',...
    'spsThreePhaseTransformerTwoWindingsLib',...
    'spsThreePhaseVIMeasurementLib',...
    'spsThyristorConverterLib',...
    'spsThyristorLib',...
    'spsTriangleGeneratorLib',...
    'spsTwoLevelConverterLib',...
    'spsTwoQuadrantDCDCConverterLib',...
    'spsUniversalBridgeLib',...
    'spsVariableCapacitorLib',...
    'spsVariableInductorLib',...
    'spsVariableRatioTransformerLib',...
    'spsVariableResistorLib',...
    'spsVectorControllerPMSMLib',...
    'spsVectorControllerSPIMLib',...
    'spsVectorControllerWFSMLib',...
    'spsVoltageControllerDCBusLib',...
    'spsVoltageCurrentSimscapeInterfaceLib',...
    'spsVoltageCurrentSimscapeInterfacegndLib',...
    'spsVoltageMeasurementLib',...
    'spsWindTurbineDoublyFedInductionGeneratorPhasorTypeLib',...
    'spsWindTurbineInductionGeneratorPhasorTypeLib',...
    'spsWindTurbineLib',...
    'spsZigzagPhaseShiftingTransformerLib',...
    'spsabctoAlphaBetaZeroLib',...
    'spsabctodq0Lib',...
    'spsdq0toAlphaBetaZeroLib',...
    'spsdq0toabcLib',...
    'spspowerguiLib',...
    'spsThreePhaseAutotransformerWithTertiaryWindingLib',...
    'spsThreePhaseTapChangingTransformerThreeWindingsLib',...
    'spsThreePhaseTapChangingTransformerTwoWindingsLib'};
    for idx=1:numel(privateLibs)
        entry(end+1)=PmSli.LibraryEntry(privateLibs{idx},'Power_System_Blocks','');%#ok<*AGROW>
        entry(end).EditingModeFcn='sps_editingmodecallback';
    end
end
