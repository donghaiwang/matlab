function[hC,num]=getTargetSpecificInstantiationCompsWithTwoInputs(targetCompInventory,hN,hInSignals,hOutSignals,altMegaFunctionName,outPort)




    if(nargin<6)
        outPort='';
    end

    [dimlen,~]=pirelab.getVectorTypeInfo(hInSignals(1));
    if dimlen>1
        hC=alteratarget.getVectorMegaFunctionComp(targetCompInventory,hN,hInSignals,hOutSignals,altMegaFunctionName,@getScalarTargetSpecificMegafunctionCompWithTwoInputs);
    else
        hC=getScalarTargetSpecificMegafunctionCompWithTwoInputs(targetCompInventory,hN,hInSignals,hOutSignals,altMegaFunctionName);
    end

    num=dimlen*hN.getNumOfInstances();

    function hC=getScalarTargetSpecificMegafunctionCompWithTwoInputs(~,hN,hInSignals,hOutSignals,altMegaFunctionName)

        hC=pirelab.getInstantiationComp(...
        'Network',hN,...
        'Name',altMegaFunctionName,...
        'EntityName',altMegaFunctionName,...
        'InportNames',{'dataa','datab'},...
        'OutportNames',{'result'},...
        'InportSignals',hInSignals,...
        'OutportSignals',hOutSignals,...
        'AddClockPort','on',...
        'ClockInputPort','clock',...
        'AddClockEnablePort','on',...
        'ClockEnableInputPort','clk_en',...
        'AddResetPort','on',...
        'ResetInputPort','aclr',...
        'InlineConfigurations','off'...
        );

        hC.setTargetIP(true);


