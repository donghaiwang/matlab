function mulComp=getDivComp(hN,hInSignals,hOutSignals,...
    rndMode,satMode,compName,slbh,desc)

    mulComp=hN.addComponent2(...
    'kind','div',...
    'SimulinkHandle',slbh,...
    'name',compName,...
    'InputSignals',hInSignals,...
    'OutputSignals',hOutSignals,...
    'RoundingMode',rndMode,...
    'OverflowMode',satMode,...
    'BlockComment',desc,...
    'inputsigns','*/');

end
