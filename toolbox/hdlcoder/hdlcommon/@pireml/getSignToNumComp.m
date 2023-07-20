function cgirComp=getSignToNumComp(hN,hInSignals,hOutSignals,compName)






    if(nargin<4)
        compName='signum';
    end

    oType_ex=pirelab.getTypeInfoAsFi(hOutSignals(1).Type);

    cgirComp=hN.addComponent2(...
    'kind','cgireml',...
    'Name',compName,...
    'InputSignals',hInSignals,...
    'OutputSignals',hOutSignals,...
    'EMLFileName','hdleml_signum',...
    'EMLParams',{oType_ex},...
    'EMLFlag_ParamsFollowInputs',true,...
    'EMLFlag_RunLoopUnrolling',true);

end


