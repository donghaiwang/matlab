function hNewC=lowerLogic(hN,hC,mode)



    hNewC=pireml.getLogicComp(hN,...
    hC.PirInputSignals,...
    hC.PirOutputSignals,...
    mode,...
    hC.Name);
end
