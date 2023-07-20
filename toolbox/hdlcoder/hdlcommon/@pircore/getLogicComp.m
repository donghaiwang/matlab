function hNewC=getLogicComp(hN,hInSignals,hOutSignals,op,compName,desc,slHandle)



    hNewC=hN.addComponent2(...
    'kind','logic',...
    'SimulinkHandle',slHandle,...
    'name',compName,...
    'InputSignals',hInSignals,...
    'OutputSignals',hOutSignals,...
    'OpName',op,...
    'BlockComment',desc);

end
