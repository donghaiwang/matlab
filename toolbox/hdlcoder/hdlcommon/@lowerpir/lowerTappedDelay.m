function hNewC=lowerTappedDelay(hN,hC)




    hNewC=pireml.getTapDelayComp(...
    hN,...
    hC.PirInputSignals,...
    hC.PirOutputSignals,...
    hC.getNumDelays,...
    hC.Name,...
    hC.getInitialValue,...
    hC.getDelayOrder,...
    hC.getIncludeCurrent,...
    hC.getResetNone);

end
