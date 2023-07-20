function delayComp=getIntDelayEnabledResettableComp(hN,hSignalsIn,hSignalsOut,...
    delayNumber,compName,ic,resettype,hEnableSigs,hRstSignal,desc,slHandle)















    narginchk(9,11);

    if(nargin<11)
        slHandle=-1;
    end

    if(nargin<10)
        desc='';
    end







    hwSemantics=hN.hasSLHWFriendlySemantics||hN.getWithinHWFriendlyHierarchy;

    hasExtEnable=~isempty(hEnableSigs);
    hasExtReset=~isempty(hRstSignal);


    if hasExtEnable&&hasExtReset
        delayType=hdldelaytypeenum.DelayEnabledResettable;
    elseif hasExtEnable&&~hasExtReset
        delayType=hdldelaytypeenum.DelayEnabled;
    elseif~hasExtEnable&&hasExtReset
        delayType=hdldelaytypeenum.DelayResettable;
    else
        delayType=hdldelaytypeenum.Delay;
    end

    if delayNumber==0
        delayComp=pirelab.getWireComp(hN,hSignalsIn,hSignalsOut,compName);
        return;
    end

    [dimlen,ht]=pirelab.getVectorTypeInfo(hSignalsIn(1));

    if(isempty(ic))
        ic=0;
    end

    if(length(ic)==1)
        ic=repmat(ic,dimlen,delayNumber);
    end

    ic=reshape(ic,dimlen,delayNumber);
    if delayNumber==1
        ic=pirelab.getTypeInfoAsFi(hSignalsIn.Type,'Floor','Wrap',ic);

    else
        ic=fliplr(ic);
        ic=pirelab.getTypeInfoAsFi(hSignalsIn.Type,'Floor','Wrap',ic,false);
    end

    resetnone=false;
    if~isempty(resettype)
        resetnone=resettype;
    end


    if(dimlen>1&&delayNumber>1)
        delayComp=getVectorIntDelay(hN,hSignalsIn,hSignalsOut,delayNumber,compName,...
        ic,resetnone,hwSemantics,dimlen,ht,delayType,hEnableSigs,hRstSignal,desc,slHandle);
    else
        delayComp=makeAnIntDelay(hN,hSignalsIn,hSignalsOut,delayNumber,compName,...
        ic,resetnone,hwSemantics,delayType,hEnableSigs,hRstSignal,desc,slHandle);
    end

end


function intcomp=getVectorIntDelay(hN,hSignalsIn,hSignalsOut,delayNumber,compName,...
    ic,resettype,hwSemantics,numDims,hInType,delayType,hEnableSigs,hRstSignal,desc,slHandle)
    for ii=1:numDims
        hDelayInSignals(ii)=hN.addSignal(hInType,sprintf('%s_in_%d',compName,ii));%#ok<AGROW>
        hDelayOutSignals(ii)=hN.addSignal(hInType,sprintf('%s_out_%d',compName,ii));%#ok<AGROW>
    end

    intcomp=pirelab.getDemuxComp(hN,hSignalsIn(1),hDelayInSignals);

    delayComps=hdlhandles(numDims,1);
    for ii=numDims:-1:1
        initval=ic(ii,:);
        if~isreal(ic)&&isreal(initval)


            initval=complex(initval);
        end
        delayComps(ii)=makeAnIntDelay(hN,hDelayInSignals(ii),hDelayOutSignals(ii),...
        delayNumber,sprintf('%s_%d',compName,ii),initval,resettype,hwSemantics,...
        delayType,hEnableSigs,hRstSignal,desc,slHandle);
    end

    hMux=pirelab.getMuxComp(hN,hDelayOutSignals,hSignalsOut(1));%#ok<*NASGU>
    hN.groupComponents(delayComps);
end


function delayComp=makeAnIntDelay(hN,hSignalsIn,hSignalsOut,delayNumber,compName,...
    ic,resetnone,hwSemantics,delayType,hEnableSigs,hRstSignal,desc,slHandle)

    [~,clkEnb,~]=hN.getClockBundle(hSignalsIn,1,1,0);

    if delayNumber==1
        emlFileDelayTypePrefix='hdleml_delay';
        emlParams={ic};
    else
        emlParams={delayNumber,ic};
        emlFileDelayTypePrefix='hdleml_intdelay';
    end

    switch delayType
    case hdldelaytypeenum.Delay
        emlFile=emlFileDelayTypePrefix;
        delayComp=hN.addComponent2(...
        'kind','cgireml',...
        'Name',compName,...
        'SimulinkHandle',slHandle,...
        'InputSignals',hSignalsIn,...
        'OutputSignals',hSignalsOut,...
        'EMLFileName',emlFile,...
        'EMLParams',emlParams,...
        'EMLFlag_RunLoopUnrolling',false,...
        'BlockComment',desc);
    case hdldelaytypeenum.DelayEnabledResettable
        if hwSemantics
            emlFile=emlFileDelayTypePrefix;

            delayComp=hN.addComponent2(...
            'kind','cgireml',...
            'Name',compName,...
            'SimulinkHandle',slHandle,...
            'InputSignals',hSignalsIn,...
            'OutputSignals',hSignalsOut,...
            'EnableSignals',clkEnb,...
            'ExternalEnableSignal',hEnableSigs,...
            'ExternalSynchronousResetSignal',hRstSignal,...
            'EMLFileName',emlFile,...
            'EMLParams',emlParams,...
            'EMLFlag_RunLoopUnrolling',false,...
            'BlockComment',desc);
            delayComp.setIsSynchronousRegister(true);
        else
            emlFile=[emlFileDelayTypePrefix,'_enabled_resettable_classic'];

            delayComp=hN.addComponent2(...
            'kind','cgireml',...
            'Name',compName,...
            'SimulinkHandle',slHandle,...
            'InputSignals',[hSignalsIn,hRstSignal,hEnableSigs],...
            'OutputSignals',hSignalsOut,...
            'EnableSignals',clkEnb,...
            'ExternalEnableSignal',hEnableSigs,...
            'ExternalSynchronousResetSignal',hRstSignal,...
            'EMLFileName',emlFile,...
            'EMLParams',emlParams,...
            'EMLFlag_RunLoopUnrolling',false,...
            'BlockComment',desc);
        end
    case hdldelaytypeenum.DelayEnabled
        if hwSemantics
            emlFile=emlFileDelayTypePrefix;

            delayComp=hN.addComponent2(...
            'kind','cgireml',...
            'Name',compName,...
            'SimulinkHandle',slHandle,...
            'InputSignals',hSignalsIn,...
            'OutputSignals',hSignalsOut,...
            'EnableSignals',clkEnb,...
            'ExternalEnableSignal',hEnableSigs,...
            'EMLFileName',emlFile,...
            'EMLParams',emlParams,...
            'EMLFlag_RunLoopUnrolling',false,...
            'BlockComment',desc);
        else
            emlFile=[emlFileDelayTypePrefix,'_enabled_classic'];

            delayComp=hN.addComponent2(...
            'kind','cgireml',...
            'Name',compName,...
            'SimulinkHandle',slHandle,...
            'InputSignals',[hSignalsIn,hEnableSigs],...
            'OutputSignals',hSignalsOut,...
            'EnableSignals',clkEnb,...
            'ExternalEnableSignal',hEnableSigs,...
            'EMLFileName',emlFile,...
            'EMLParams',emlParams,...
            'EMLFlag_RunLoopUnrolling',false,...
            'BlockComment',desc);
        end
    case hdldelaytypeenum.DelayResettable
        if hwSemantics
            emlFile=emlFileDelayTypePrefix;

            delayComp=hN.addComponent2(...
            'kind','cgireml',...
            'Name',compName,...
            'SimulinkHandle',slHandle,...
            'InputSignals',hSignalsIn,...
            'OutputSignals',hSignalsOut,...
            'ExternalSynchronousResetSignal',hRstSignal,...
            'EMLFileName',emlFile,...
            'EMLParams',emlParams,...
            'EMLFlag_RunLoopUnrolling',false,...
            'BlockComment',desc);
        else
            emlFile=[emlFileDelayTypePrefix,'_resettable_classic'];

            delayComp=hN.addComponent2(...
            'kind','cgireml',...
            'Name',compName,...
            'SimulinkHandle',slHandle,...
            'InputSignals',[hSignalsIn,hRstSignal],...
            'OutputSignals',hSignalsOut,...
            'ExternalSynchronousResetSignal',hRstSignal,...
            'EMLFileName',emlFile,...
            'EMLParams',emlParams,...
            'EMLFlag_RunLoopUnrolling',false,...
            'BlockComment',desc);
        end
    end


    if targetmapping.isValidDataType(hSignalsIn(1).Type)
        delayComp.setSupportTargetCodGenWithoutMapping(true);
    end
    delayComp.resetNone(resetnone);
end

