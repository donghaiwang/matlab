function bypassComp=getBypassRegisterComp(hN,hInSignals,hOutSignals,...
    byPassEnable,compName,ic)



    if nargin<6
        ic=pirelab.getTypeInfoAsFi(hInSignals.Type);
    else
        ic=pirelab.getTypeInfoAsFi(hInSignals.Type,'Floor','Wrap',ic);
    end

    if nargin<5
        compName='bypass_reg';
    end

    bypassComp=hN.addComponent2(...
    'kind','cgireml',...
    'Name',compName,...
    'InputSignals',[hInSignals,byPassEnable],...
    'OutputSignals',hOutSignals,...
    'EnableSignals',byPassEnable,...
    'EMLFileName','hdleml_bypass_register',...
    'EMLParams',{ic},...
    'EMLFlag_RunLoopUnrolling',false);

    if targetmapping.isValidDataType(hInSignals(1).Type)
        bypassComp.setSupportTargetCodGenWithoutMapping(true);
    end
end