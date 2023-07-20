function[outData]=simrfV2_ce_forward(inData)






    outData.NewBlockPath='';
    origData=inData.InstanceData;



    validBlks={...
    'simrf_lib/Elements/R','resistor';...
    'simrf_lib/Elements/L','inductor';...
    'simrf_lib/Elements/C','capacitor';...
    'simrf_lib/Elements/Gnd','ground';...
    'simrfV2_lib/Elements/INDUCTOR','inductor';...
    'simrfV2_lib/Elements/CAPACITOR','capacitor';...
    'simrfV2_lib/Elements/IdealTransformer','idealtransformer';...
    'simrfV2_lib/Elements/MutualInductor','inductormut';...
    'simrfV2_lib/Elements/Three-WindingTransformer','inductor3a';...
    'simrfelements1/Z','impedance';...
    'simrfelements1/MutualInductor','inductormut';...
    'simrfelements1/Three-WindingTransformer','inductor3';...
    'simrfelements1/Amplifier','amplifier';...
    'simrfelements1/Mixer','mixer';...
    'simrfelements1/S-parameters','sparam';...
    'simrfelements1/PhaseShift','phase';...
    'simrfelements1/SignalCombiner','sum';...
    'simrfelements1/TransmissionLine','xline';...
    'simrfutil1/SimRFInport','inport';...
    'simrfutil1/SimRFOutport','outport';...
    'simrfutil1/SimRFParameters','solver';...
    'simrfsources1/ContinuousWave','cwsource';...
    'simrfsources1/Sinusoid','sinesource';...
    'simrfsources1/Noise','noisesource';...
    'simrfV2util1/Outport','outport';...
    'simrfV2util1/Configuration','configuration';...
    'simrfV2elements/S-parameters','sparam';...
    'simrfV2elements/Amplifier','amplifier';...
    'simrfV2elements/TransmissionLine','xline';...
    'simrfV2elements/Filter','filter';...
    'simrfV2junction1/Divider','divider'};


    blkName=regexprep(inData.ForwardingTableEntry.('__slOldName__'),...
    '\n','');
    funcName=validBlks{strcmpi(blkName,validBlks(:,1)),2};

    if funcName=="xline"
        oldVersion=inData.ForwardingTableEntry.('__slOldVersion__');
        if str2double(oldVersion.ModelVersion)>1.784
            funcName='xline2';
        end
    end


    fh=str2func(['simrfV2_ce_',funcName]);
    validateattributes(fh,{'function_handle'},{'nonempty','numel',1},...
    funcName,blkName)
    outData.NewInstanceData=fh(origData);

end