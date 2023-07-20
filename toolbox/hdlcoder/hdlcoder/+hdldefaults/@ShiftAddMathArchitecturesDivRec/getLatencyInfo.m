function latencyInfo=getLatencyInfo(this,hC)





    blockInfo=getBlockInfo(this,hC);
    if strcmpi(blockInfo.inputSigns,'/')
        if(strcmpi(blockInfo.OutType,'Inherit: Inherit via internal rule'))
            iterNum=hC.PirOutputSignals(1).Type.BaseType.Wordlength;
        else
            Input1WordLength=hC.PirInputSignals(1).Type.BaseType.Wordlength;
            iterNum=Input1WordLength+abs(blockInfo.fractiondiff);
        end
    else

        sig1Signedness=hC.PirInputSignals(1).Type.BaseType.Signed;
        sig2Signedness=hC.PirInputSignals(2).Type.BaseType.Signed;
        if(strcmpi(blockInfo.OutType,'Inherit: Inherit via internal rule'))

            iterNum=hC.PirOutputSignals(1).Type.BaseType.Wordlength;
        else
            Input1FractionLength=hC.PirInputSignals(1).Type.BaseType.Fractionlength;
            Input2FractionLength=hC.PirInputSignals(2).Type.BaseType.Fractionlength;
            outputFractionLength=hC.PirOutputSignals(1).Type.BaseType.Fractionlength;
            fractiondiff=Input1FractionLength-Input2FractionLength-outputFractionLength;
            Input1WordLength=hC.PirInputSignals(1).Type.BaseType.Wordlength;
            Input2WordLength=hC.PirInputSignals(2).Type.BaseType.Wordlength;
            iterNum=max(Input1WordLength,Input2WordLength)+abs(fractiondiff)+1;
        end

        if((sig1Signedness==1&&sig2Signedness==0)||(sig1Signedness==0&&sig2Signedness==1))
            iterNum=iterNum+1;
        end
    end


    if strcmpi(blockInfo.pipeline,'on')
        if(strcmpi(blockInfo.latencyStrategy,'MAX'))
            outputDelay=iterNum+4;
        elseif(strcmpi(blockInfo.latencyStrategy,'CUSTOM'))
            outputDelay=blockInfo.customLatency;
        else
            outputDelay=0;
        end
    else
        outputDelay=0;
    end

    latencyInfo.inputDelay=0;
    latencyInfo.outputDelay=outputDelay;
    latencyInfo.samplingChange=1;


