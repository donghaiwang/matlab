function hNewC=lowerBitSet(hN,hC)



    hNewC=pireml.getBitSetComp(hN,...
    hC.PirInputSignals,...
    hC.PirOutputSignals,...
    hC.getBitSet,...
    hC.getBitPos,...
    hC.Name,...
    hC.getUsingBitMask);
end
