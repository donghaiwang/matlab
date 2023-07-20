

function ReadySignalGenerator(~,hN,ReadySigGenInSigs,ReadySigGenOutSigs,...
    slRate,blockInfo)



    hReadySigGenN=pirelab.createNewNetwork(...
    'Name','ReadySignalGenerator',...
    'InportNames',{'outStreamDone','rowCount','colCount','vldRdy'},...
    'InportTypes',[ReadySigGenInSigs(1).Type,ReadySigGenInSigs(2).Type,...
    ReadySigGenInSigs(3).Type,ReadySigGenInSigs(4).Type],...
    'InportRates',slRate*ones(1,4),...
    'OutportNames',{'ready'},...
    'OutportTypes',ReadySigGenOutSigs(1).Type);

    hReadySigGenN.setTargetCompReplacementCandidate(true);


    for ii=1:numel(hReadySigGenN.PirOutputSignals)
        hReadySigGenN.PirOutputSignals(ii).SimulinkRate=slRate;
    end
    hReadySigGenNinSigs=hReadySigGenN.PirInputSignals;
    hReadySigGenNoutSigs=hReadySigGenN.PirOutputSignals;


    outStreamDone=hReadySigGenNinSigs(1);
    rowCount=hReadySigGenNinSigs(2);
    colCount=hReadySigGenNinSigs(3);
    vldRdy=hReadySigGenNinSigs(4);

    ready=hReadySigGenNoutSigs(1);


    hBoolT=pir_boolean_t;




    Constant1_out1_s3=l_addSignal(hReadySigGenN,'Constant1_out1',hBoolT,slRate);
    Constant2_out1_s4=l_addSignal(hReadySigGenN,'Constant2_out1',hBoolT,slRate);
    LogicalOperator_out1_s6=l_addSignal(hReadySigGenN,sprintf('Logical\nOperator_out1'),hBoolT,slRate);
    Switch_out1_s7=l_addSignal(hReadySigGenN,'Switch_out1',hBoolT,slRate);
    Switch1_out1_s8=l_addSignal(hReadySigGenN,'Switch1_out1',hBoolT,slRate);
    compFlag_out1_s9=l_addSignal(hReadySigGenN,'compFlag_out1',hBoolT,slRate);
    compFlag2_out1_s10=l_addSignal(hReadySigGenN,'compFlag2_out1',hBoolT,slRate);


    pirelab.getConstComp(hReadySigGenN,...
    Constant1_out1_s3,...
    1,...
    'Constant1','on',0,'','','');

    pirelab.getConstComp(hReadySigGenN,...
    Constant2_out1_s4,...
    0,...
    'Constant2','on',1,'','','');

    pirelab.getIntDelayComp(hReadySigGenN,...
    Switch_out1_s7,...
    ready,...
    1,'Delay',...
    true,...
    0,0,[],0,0);

    pirelab.getLogicComp(hReadySigGenN,...
    [compFlag_out1_s9,compFlag2_out1_s10,vldRdy],...
    LogicalOperator_out1_s6,...
    'and',sprintf('Logical\nOperator'));

    pirelab.getSwitchComp(hReadySigGenN,...
    [Constant1_out1_s3,Switch1_out1_s8],...
    Switch_out1_s7,...
    outStreamDone,'Switch',...
    '~=',0,'Floor','Wrap');

    pirelab.getSwitchComp(hReadySigGenN,...
    [Constant2_out1_s4,ready],...
    Switch1_out1_s8,...
    LogicalOperator_out1_s6,'Switch1',...
    '~=',0,'Floor','Wrap');

    pirelab.getCompareToValueComp(hReadySigGenN,...
    colCount,...
    compFlag_out1_s9,...
    '==',blockInfo.ColumnSize,...
    'compFlag',0);

    pirelab.getCompareToValueComp(hReadySigGenN,...
    rowCount,...
    compFlag2_out1_s10,...
    '==',blockInfo.RowSize,...
    'compFlag2',0);





    pirelab.instantiateNetwork(hN,hReadySigGenN,ReadySigGenInSigs,ReadySigGenOutSigs,...
    [hReadySigGenN.Name,'_inst']);
end

function hS=l_addSignal(hN,sigName,pirTyp,simulinkRate)
    hS=hN.addSignal;
    hS.Name=sigName;
    hS.Type=pirTyp;
    hS.SimulinkHandle=-1;
    hS.SimulinkRate=simulinkRate;
end


