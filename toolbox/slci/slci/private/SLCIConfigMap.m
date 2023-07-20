function[configMap,paneNames]=SLCIConfigMap(aObj)
    values={
    {'Code Generation/Optimization','Code Generation > Optimization > Disable incompatible optimizations','combobox','Disable incompatible optimizations','CodeGenerationPane'},...
    {'Diagnostics','Diagnostics > Algebraic loop','combobox','Algebraic loop','DiagnosticsPane'},...
    {'Diagnostics','Diagnostics > Allow symbolic dimension specification','checkbox','Allow symbolic dimension specification','DiagnosticsPane'},...
    {'Code Generation/Interface','Code Generation > Interface > Array layout','combobox','Array layout','CodeGenerationPane'},...
    {'Solver','Solver > Automatically handle rate transition for data transfer','checkbox','Automatically handle rate transition for data transfer','SolverPane'},...
    {'Code Generation/Optimization','Code Generation > Optimization > Operator to represent Bitwise and Logical Operator blocks','combobox','Operator to represent Bitwise and Logical Operator blocks','CodeGenerationPane'},...
    {'Math and Data Types','Math and Data Types > Implement logic signals as Boolean data (vs. double)','checkbox','Implement logic signals as Boolean data (vs. double)','MathandDataTypesPane'},...
    {'Code Generation/Optimization','Code Generation > Optimization > Pack Boolean data into bitfields','checkbox','Pack Boolean data into bitfields','CodeGenerationPane'},...
    {'Code Generation/Code Style','Code Generation > Code Style > Casting modes','combobox','Casting modes','CodeGenerationPane'},...
    {'Code Generation/Verification','Code Generation > Verification > Measure function execution times','combobox','Measure function execution times','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > Code replacement library','combobox','Code replacement library','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > Single output/update function','checkbox','Single output/update function','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > Combine signal/state structures','checkbox','Combine signal/state structures','CodeGenerationPane'},...
    {'Solver','Solver > Allow tasks to execute concurrently on target','checkbox','Allow tasks to execute concurrently on target','SolverPane'},...
    {'Code Generation/Verification','Code Generation > Verification > Create block','combobox','Create block','CodeGenerationPane'},...
    {'Code Generation/Custom Code','Code Generation > Custom Code > Include headers','editarea','Include headers','CodeGenerationPane'},...
    {'Code Generation/Custom Code','Code Generation > Custom Code > Initialize code','editarea','Initialize code','CodeGenerationPane'},...
    {'Code Generation/Custom Code','Code Generation > Custom Code > Additional code','editarea','Additional code','CodeGenerationPane'},...
    {'Code Generation/Custom Code','Code Generation > Custom Code > Terminate code','editarea','Terminate code','CodeGenerationPane'},...
    {'Code Generation/Optimization','Code Generation > Optimization > Use bitsets for storing Boolean data','checkbox','Use bitsets for storing Boolean data','CodeGenerationPane'},...
    {'Code Generation/Optimization','Code Generation > Optimization > Default parameter behavior','combobox','Default parameter behavior','CodeGenerationPane'},...
    {'Code Generation/Optimization','Code Generation > Optimization > Remove code from floating-point to integer conversions that wraps out-of-range values','checkbox','Remove code from floating-point to integer conversions that wraps out-of-range values','CodeGenerationPane'},...
    {'Code Generation/Optimization','Code Generation > Optimization > Remove code from floating-point to integer conversions with saturation that maps NaN to zero','checkbox','Remove code from floating-point to integer conversions with saturation that maps NaN to zero','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > Existing shared code','edit','Existing shared code','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > External mode','checkbox','External mode','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > Classic call interface','checkbox','Classic call interface','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > Use dynamic memory allocation for model initialization','checkbox','Use dynamic memory allocation for model initialization','CodeGenerationPane'},...
    {'Code Generation/Comments','Code Generation > Comments > Include comments','checkbox','Include comments','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > Terminate function required','checkbox','Terminate function required','CodeGenerationPane'},...
    {'Diagnostics/Data Validity','Diagnostics > Data Validity > Wrap on overflow','combobox','Wrap on overflow','DiagnosticsPane'},...
    {'Diagnostics/Data Validity','Diagnostics > Data Validity > Saturate on overflow','combobox','Saturate on overflow','DiagnosticsPane'},...
    {'Data Import/Export','Data Import/Export > Initial state','checkbox','Initial state','DataImportPane'},...
    {'Code Generation/Interface','Code Generation > Interface > MAT-file logging','checkbox','MAT-file logging','CodeGenerationPane'},...
    {'Diagnostics/Model Referencing','Diagnostics > Model Referencing > Invalid root Inport/Outport block connection','combobox','Invalid root Inport/Outport block connection','DiagnosticsPane'},...
    {'Diagnostics/Sample Time','Diagnostics > Sample Time > Multitask conditionally executed subsystem','combobox','Multitask conditionally executed subsystem','DiagnosticsPane'},...
    {'Diagnostics/Data Validity','Diagnostics > Data Validity > Multitask data store','combobox','Multitask data store','DiagnosticsPane'},...
    {'Diagnostics/Sample Time','Diagnostics > Sample Time > Multitask data transfer','combobox','Multitask data transfer','DiagnosticsPane'},...
    {'Code Generation/Optimization','Code Generation > Optimization > Remove code that protects against division arithmetic exceptions','checkbox','Remove code that protects against division arithmetic exceptions','CodeGenerationPane'},...
    {'Diagnostics/Connectivity','Diagnostics > Connectivity > Non-bus signals treated as bus signals','combobox','Non-bus signals treated as bus signals','DiagnosticsPane'},...
    {'Code Generation/Identifiers','Code Generation > Identifiers > Parameter naming','combobox','Parameter naming','CodeGenerationPane'},...
    {'Diagnostics/Data Validity','Diagnostics > Data Validity > Detect downcast','combobox','Detect downcast','DiagnosticsPane'},...
    {'Diagnostics/Data Validity','Diagnostics > Data Validity > Detect overflow','combobox','Detect overflow','DiagnosticsPane'},...
    {'Diagnostics/Data Validity','Diagnostics > Data Validity > Detect loss of tunability','combobox','Detect loss of tunability','DiagnosticsPane'},...
    {'Diagnostics/Data Validity','Diagnostics > Data Validity > Detect underflow','combobox','Detect underflow','DiagnosticsPane'},...
    {'Code Generation/Code Style','Code Generation > Code Style > Preserve condition expression in if statement','checkbox','Preserve condition expression in if statement','CodeGenerationPane'},...
    {'Hardware Implementation','Hardware Implementation > char','edit','char','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > double','edit','double','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > float','edit','float','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > int','edit','int','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > long','edit','long','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > pointer','edit','pointer','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > ptrdiff_t','edit','ptrdiff_t','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > short','edit','short','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > size_t','edit','size_t','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > Test hardware is the same as production hardware','checkbox','Test hardware is the same as production hardware','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > Device vendor','combobox','Device vendor','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > Signed integer division rounds to','combobox','Signed integer division rounds to','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > Support long long','checkbox','Support long long','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > Shift right on a signed integer as arithmetic shift','checkbox','Shift right on a signed integer as arithmetic shift','HardwareImplementationPane'},...
    {'Hardware Implementation','Hardware Implementation > native','edit','native','HardwareImplementationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > parameters','checkbox','parameters','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > root-level I/O','checkbox','root-level I/O','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > signals','checkbox','signals','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > states','checkbox','states','CodeGenerationPane'},...
    {'Code Generation/Code Placement','Code Generation > Code Placement > Rate Transition block code','combobox','Rate Transition block code','CodeGenerationPane'},...
    {'Code Generation/Optimization','Code Generation > Optimization > Reuse output buffers of Model blocks','checkbox','Reuse output buffers of Model blocks','CodeGenerationPane'},...
    {'Diagnostics/Stateflow','Diagnostics > Stateflow > Invalid input data access in chart initialization','combobox','Invalid input data access in chart initialization','DiagnosticsPane'},...
    {'Diagnostics/Stateflow','Diagnostics > Stateflow > No unconditional default transitions','combobox','No unconditional default transitions','DiagnosticsPane'},...
    {'Diagnostics/Stateflow','Diagnostics > Stateflow > Transition action specified before condition action','combobox','Transition action specified before condition action','DiagnosticsPane'},...
    {'Diagnostics/Stateflow','Diagnostics > Stateflow > Transition outside natural parent','combobox','Transition outside natural parent','DiagnosticsPane'},...
    {'Diagnostics/Stateflow','Diagnostics > Stateflow > Undirected event broadcasts','combobox','Undirected event broadcasts','DiagnosticsPane'},...
    {'Diagnostics/Stateflow','Diagnostics > Stateflow > Unexpected backtracking','combobox','Unexpected backtracking','DiagnosticsPane'},...
    {'Diagnostics/Stateflow','Diagnostics > Stateflow > Unreachable execution path','combobox','Unreachable execution path','DiagnosticsPane'},...
    {'Solver','Solver > Periodic sample time constraint','combobox','Periodic sample time constraint','SolverPane'},...
    {'Code Generation/Identifiers','Code Generation > Identifiers > Signal naming','combobox','Signal naming','CodeGenerationPane'},...
    {'Solver','Solver > Solver','combobox','Solver','SolverPane'},...
    {'Solver','Solver > Type','combobox','Type','SolverPane'},...
    {'Code Generation/Optimization','Code Generation > Optimization > Use bitsets for storing state configuration','checkbox','Use bitsets for storing state configuration','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > absolute time','checkbox','absolute time','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > non-finite numbers','checkbox','non-finite numbers','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > variable-size signals','checkbox','variable-size signals','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > Remove error status field in real-time model data structure','checkbox','Remove error status field in real-time model data structure','CodeGenerationPane'},...
    {'Code Generation/Code Style','Code Generation > Code Style > Suppress generation of default cases for Stateflow switch statements if unreachable','checkbox','Suppress generation of default cases for Stateflow switch statements if unreachable','CodeGenerationPane'},...
    {'Code Generation','Code Generation > TLC options','edit','TLC options','CodeGenerationPane'},...
    {'Code Generation','Code Generation > Language standard','combobox','Language standard','CodeGenerationPane'},...
    {'Diagnostics/Data Validity','Diagnostics > Data Validity > Underspecified initialization detection','combobox','Underspecified initialization detection','DiagnosticsPane'},...
    {'Math and Data Types','Math and Data Types > Use algorithms optimized for row-major array layout','checkbox','Use algorithms optimized for row-major array layout','MathandDataTypesPane'},...
    {'Code Generation/Optimization','Code Generation > Optimization > Optimize using the specified minimum and maximum values','checkbox','Optimize using the specified minimum and maximum values','CodeGenerationPane'},...
    {'Code Generation/Interface','Code Generation > Interface > Shared code placement','combobox','Shared code placement','CodeGenerationPane'},...
    };


    keys={'AdvancedOptControl',...
    'AlgebraicLoopMsg',...
    'AllowSymbolicDim',...
    'ArrayLayout',...
    'AutoInsertRateTranBlk',...
    'BitwiseOrLogicalOp',...
    'BooleanDataType',...
    'BooleansAsBitfields',...
    'CastingMode',...
    'CodeProfilingInstrumentation',...
    'CodeReplacementLibrary',...
    'CombineOutputUpdateFcns',...
    'CombineSignalStateStructs',...
    'ConcurrentTasks',...
    'CreateSILPILBlock',...
    'CustomHeaderCode',...
    'CustomInitializer',...
    'CustomSourceCode',...
    'CustomTerminator',...
    'DataBitsets',...
    'DefaultParameterBehavior',...
    'EfficientFloat2IntCast',...
    'EfficientMapNaN2IntZero',...
    'ExistingSharedCode',...
    'ExtMode',...
    'GRTInterface',...
    'GenerateAllocFcn',...
    'GenerateComments',...
    'IncludeMdlTerminateFcn',...
    'IntegerOverflowMsg',...
    'IntegerSaturationMsg',...
    'LoadInitialState',...
    'MatFileLogging',...
    'ModelReferenceIOMsg',...
    'MultiTaskCondExecSysMsg',...
    'MultiTaskDSMMsg',...
    'MultiTaskRateTransMsg',...
    'NoFixptDivByZeroProtection',...
    'NonBusSignalsTreatedAsBus',...
    'ParamNamingRule',...
    'ParameterDowncastMsg',...
    'ParameterOverflowMsg',...
    'ParameterTunabilityLossMsg',...
    'ParameterUnderflowMsg',...
    'PreserveIfCondition',...
    'ProdBitPerChar',...
    'ProdBitPerDouble',...
    'ProdBitPerFloat',...
    'ProdBitPerInt',...
    'ProdBitPerLong',...
    'ProdBitPerPointer',...
    'ProdBitPerPtrDiffT',...
    'ProdBitPerShort',...
    'ProdBitPerSizeT',...
    'ProdEqTarget',...
    'ProdHWDeviceType',...
    'ProdIntDivRoundTo',...
    'ProdLongLongMode',...
    'ProdShiftRightIntArith',...
    'ProdWordSize',...
    'RTWCAPIParams',...
    'RTWCAPIRootIO',...
    'RTWCAPISignals',...
    'RTWCAPIStates',...
    'RateTransitionBlockCode',...
    'ReuseModelBlockBuffer',...
    'SFInvalidInputDataAccessInChartInitDiag',...
    'SFNoUnconditionalDefaultTransitionDiag',...
    'SFTransitionActionBeforeConditionDiag',...
    'SFTransitionOutsideNaturalParentDiag',...
    'SFUndirectedBroadcastEventsDiag',...
    'SFUnexpectedBacktrackingDiag',...
    'SFUnreachableExecutionPathDiag',...
    'SampleTimeConstraint',...
    'SignalNamingRule',...
    'Solver',...
    'SolverType',...
    'StateBitsets',...
    'SupportAbsoluteTime',...
    'SupportNonFinite',...
    'SupportVariableSizeSignals',...
    'SuppressErrorStatus',...
    'SuppressUnreachableDefaultCases',...
    'TLCOptions',...
    'TargetLangStandard',...
    'UnderspecifiedInitializationDetection',...
    'UseRowMajorAlgorithm',...
    'UseSpecifiedMinMax',...
    'UtilityFuncGeneration',...
    };

    configMap=containers.Map(keys,values);

    paneNames={'CodeGenerationPane','DataImportPane','DiagnosticsPane','HardwareImplementationPane','MathandDataTypesPane','SolverPane'};
end