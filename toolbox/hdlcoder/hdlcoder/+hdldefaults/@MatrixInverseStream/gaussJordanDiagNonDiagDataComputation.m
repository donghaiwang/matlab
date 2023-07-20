

function gaussJordanDiagNonDiagDataComputation(this,hN,LTNonDiagDataComputationInSigs,LTNonDiagDataComputationOutSigs,...
    hInputDataT,hBoolT,hCounterT,slRate,blockInfo)




    hLTNonDiagDataComputationN=pirelab.createNewNetwork(...
    'Name','gaussJordanDiagNonDiagDataComputation',...
    'InportNames',{'reciprocalValid','reciprocalData','rowCount','readData','nonDiagValidIn','colCount'},...
    'InportTypes',[hBoolT,LTNonDiagDataComputationInSigs(2).Type,hCounterT,LTNonDiagDataComputationInSigs(4).Type,hBoolT,hCounterT],...
    'InportRates',slRate*ones(1,6),...
    'OutportNames',{'nonDiagValidOut','nonDiagDataOut1','diagValidOut','rowFinish','colCountOut','invFinish','nonDiagDataOut2','diagDataOut1','diagDataOut2'},...
    'OutportTypes',[hBoolT,hInputDataT,hBoolT,hBoolT,hCounterT,hBoolT,hInputDataT,hInputDataT,hInputDataT]);

    hLTNonDiagDataComputationN.setTargetCompReplacementCandidate(true);


    for ii=1:numel(hLTNonDiagDataComputationN.PirOutputSignals)
        hLTNonDiagDataComputationN.PirOutputSignals(ii).SimulinkRate=slRate;
    end

    hLTNonDiagDataComputationNinSigs=hLTNonDiagDataComputationN.PirInputSignals;
    hLTNonDiagDataComputationNoutSigs=hLTNonDiagDataComputationN.PirOutputSignals;

    reciprocalValid=hLTNonDiagDataComputationNinSigs(1);
    reciprocalData=hLTNonDiagDataComputationNinSigs(2);
    rowCount=hLTNonDiagDataComputationNinSigs(3);
    readData=hLTNonDiagDataComputationNinSigs(4);
    nonDiagValidIn=hLTNonDiagDataComputationNinSigs(5);
    colCount=hLTNonDiagDataComputationNinSigs(6);

    nonDiagValidOut=hLTNonDiagDataComputationNoutSigs(1);
    nonDiagDataOut1=hLTNonDiagDataComputationNoutSigs(2);
    diagValidOut=hLTNonDiagDataComputationNoutSigs(3);
    rowFinish=hLTNonDiagDataComputationNoutSigs(4);
    colCountOut=hLTNonDiagDataComputationNoutSigs(5);
    invFinish=hLTNonDiagDataComputationNoutSigs(6);
    nonDiagDataOut2=hLTNonDiagDataComputationNoutSigs(7);
    diagDataOut1=hLTNonDiagDataComputationNoutSigs(8);
    diagDataOut2=hLTNonDiagDataComputationNoutSigs(9);



    diagReciprocalDataReg=l_addSignal(hLTNonDiagDataComputationN,'diagReciprocalDataReg',hInputDataT,slRate);
    reciprocalValidOutReg=l_addSignal(hLTNonDiagDataComputationN,'reciprocalValidOutReg',hBoolT,slRate);
    nonDiagValidInReg=l_addSignal(hLTNonDiagDataComputationN,'nonDiagValidInReg',hBoolT,slRate);
    diagValidCount=l_addSignal(hLTNonDiagDataComputationN,'diagValidCount',hCounterT,slRate);
    readDataReg=l_addSignal(hLTNonDiagDataComputationN,'readDataReg',pirelab.createPirArrayType(hInputDataT,[blockInfo.MatrixSize*2,0]),slRate);
    nonDiagValidInCount=l_addSignal(hLTNonDiagDataComputationN,'nonDiagValidInCount',hCounterT,slRate);
    colCountOutReg=l_addSignal(hLTNonDiagDataComputationN,'colCountOutReg',hCounterT,slRate);



    pirTyp1=pir_boolean_t;
    pirTyp2=readData(1).Type.BaseType;
    pirTyp3=hCounterT;

    if blockInfo.MatrixSize==1
        pirTyp4=pir_ufixpt_t(1,0);
    else
        pirTyp4=pir_ufixpt_t(ceil(log2(blockInfo.MatrixSize))*2,0);
    end

    fiMath1=fimath('RoundingMethod','Nearest','OverflowAction','Saturate','ProductMode','FullPrecision','SumMode','FullPrecision');

    nt2=numerictype(0,ceil(log2(blockInfo.MatrixSize))+1,0);



    CompareToConstant_out1_s6=l_addSignal(hLTNonDiagDataComputationN,sprintf('Compare\nTo Constant_out1'),pirTyp1,slRate);
    CompareToConstant1_out1_s7=l_addSignal(hLTNonDiagDataComputationN,sprintf('Compare\nTo Constant1_out1'),pirTyp1,slRate);
    CompareToConstant2_out1_s8=l_addSignal(hLTNonDiagDataComputationN,sprintf('Compare\nTo Constant2_out1'),pirTyp1,slRate);
    CompareToConstant3_out1_s9=l_addSignal(hLTNonDiagDataComputationN,sprintf('Compare\nTo Constant3_out1'),pirTyp1,slRate);
    CompareToConstant4_out1_s10=l_addSignal(hLTNonDiagDataComputationN,sprintf('Compare\nTo Constant4_out1'),pirTyp1,slRate);
    CompareToConstant5_out1_s11=l_addSignal(hLTNonDiagDataComputationN,sprintf('Compare\nTo Constant5_out1'),pirTyp1,slRate);
    Constant_out1_s12=l_addSignal(hLTNonDiagDataComputationN,'Constant_out1',pirTyp1,slRate);
    Constant1_out1_s13=l_addSignal(hLTNonDiagDataComputationN,'Constant1_out1',pirTyp1,slRate);
    Constant2_out1_s14=l_addSignal(hLTNonDiagDataComputationN,'Constant2_out1',pirTyp1,slRate);
    Constant3_out1_s15=l_addSignal(hLTNonDiagDataComputationN,'Constant3_out1',pirTyp1,slRate);




    Delay5_out1_s21=l_addSignal(hLTNonDiagDataComputationN,'Delay5_out1',pirTyp3,slRate);
    Delay6_out1_s22=l_addSignal(hLTNonDiagDataComputationN,'Delay6_out1',pirelab.createPirArrayType(pirTyp2,[blockInfo.MatrixSize*2,0]),slRate);
    Delay7_out1_s23=l_addSignal(hLTNonDiagDataComputationN,'Delay7_out1',pirTyp3,slRate);
    HDLCounter_out1_s31=l_addSignal(hLTNonDiagDataComputationN,'HDL Counter_out1',pirTyp4,slRate);


    Switch_out1_s36=l_addSignal(hLTNonDiagDataComputationN,'Switch_out1',pirTyp1,slRate);
    Switch1_out1_s37=l_addSignal(hLTNonDiagDataComputationN,'Switch1_out1',pirTyp1,slRate);
    Switch2_out1_s38=l_addSignal(hLTNonDiagDataComputationN,'Switch2_out1',pirTyp1,slRate);
    Switch3_out1_s39=l_addSignal(hLTNonDiagDataComputationN,'Switch3_out1',pirTyp1,slRate);
    Switch4_out1_s40=l_addSignal(hLTNonDiagDataComputationN,'Switch4_out1',pirTyp2,slRate);
    Switch5_out1_s41=l_addSignal(hLTNonDiagDataComputationN,'Switch5_out1',pirelab.createPirArrayType(pirTyp2,[blockInfo.MatrixSize*2,0]),slRate);
    Switch6_out1_s42=l_addSignal(hLTNonDiagDataComputationN,'Switch6_out1',pirTyp3,slRate);
    Switch7_out1_s43=l_addSignal(hLTNonDiagDataComputationN,'Switch7_out1',pirelab.createPirArrayType(pirTyp2,[blockInfo.MatrixSize*2,0]),slRate);
    Switch8_out1_s44=l_addSignal(hLTNonDiagDataComputationN,'Switch8_out1',pirTyp3,slRate);




    pirelab.getConstComp(hLTNonDiagDataComputationN,...
    Constant_out1_s12,...
    1,...
    'Constant','on',0,'','','');




    pirelab.getConstComp(hLTNonDiagDataComputationN,...
    Constant1_out1_s13,...
    0,...
    'Constant1','on',1,'','','');




    pirelab.getConstComp(hLTNonDiagDataComputationN,...
    Constant2_out1_s14,...
    1,...
    'Constant2','on',0,'','','');




    pirelab.getConstComp(hLTNonDiagDataComputationN,...
    Constant3_out1_s15,...
    0,...
    'Constant3','on',1,'','','');




    pirelab.getIntDelayComp(hLTNonDiagDataComputationN,...
    Switch_out1_s36,...
    reciprocalValidOutReg,...
    1,'Delay',...
    false,...
    0,0,[],0,0);




    pirelab.getIntDelayComp(hLTNonDiagDataComputationN,...
    Switch2_out1_s38,...
    nonDiagValidInReg,...
    1,'Delay1',...
    false,...
    0,0,[],0,0);




    pirelab.getIntDelayComp(hLTNonDiagDataComputationN,...
    Switch4_out1_s40,...
    diagReciprocalDataReg,...
    1,'Delay2',...
    single(0),...
    0,0,[],0,0);




    pirelab.getIntDelayComp(hLTNonDiagDataComputationN,...
    Switch5_out1_s41,...
    readDataReg,...
    1,'Delay3',...
    single(0),...
    0,0,[],0,0);




    pirelab.getIntDelayComp(hLTNonDiagDataComputationN,...
    Switch6_out1_s42,...
    colCountOutReg,...
    1,'Delay4',...
    fi(0,nt2,fiMath1,'hex','0'),...
    0,0,[],0,0);




    pirelab.getIntDelayComp(hLTNonDiagDataComputationN,...
    colCount,...
    Delay5_out1_s21,...
    1,'Delay5',...
    fi(0,nt2,fiMath1,'hex','0'),...
    0,0,[],0,0);




    pirelab.getWireComp(hLTNonDiagDataComputationN,...
    readData,...
    Delay6_out1_s22,...
    'Delay6');



    pirelab.getWireComp(hLTNonDiagDataComputationN,...
    Delay5_out1_s21,...
    Delay7_out1_s23,...
    'Delay7');







    pirelab.getCounterComp(hLTNonDiagDataComputationN,...
    [CompareToConstant3_out1_s9,reciprocalValidOutReg],...
    diagValidCount,...
    'Count limited',1,1,blockInfo.MatrixSize,1,0,1,0,'HDL Counter1',1);



    pirelab.getCounterComp(hLTNonDiagDataComputationN,...
    [CompareToConstant4_out1_s10,nonDiagValidInReg],...
    nonDiagValidInCount,...
    'Count limited',1,1,blockInfo.MatrixSize,1,0,1,0,'HDL Counter2',1);







    pirelab.getCompareToValueComp(hLTNonDiagDataComputationN,...
    diagValidCount,...
    CompareToConstant1_out1_s7,...
    '==',blockInfo.MatrixSize,...
    sprintf('Compare\nTo Constant1'),0);



    pirelab.getCompareToValueComp(hLTNonDiagDataComputationN,...
    nonDiagValidInCount,...
    CompareToConstant2_out1_s8,...
    '==',blockInfo.MatrixSize,...
    sprintf('Compare\nTo Constant2'),0);



    pirelab.getCompareToValueComp(hLTNonDiagDataComputationN,...
    diagValidCount,...
    CompareToConstant3_out1_s9,...
    '==',blockInfo.MatrixSize,...
    sprintf('Compare\nTo Constant3'),0);


    pirelab.getCompareToValueComp(hLTNonDiagDataComputationN,...
    nonDiagValidInCount,...
    CompareToConstant4_out1_s10,...
    '==',blockInfo.MatrixSize,...
    sprintf('Compare\nTo Constant4'),0);


    pirelab.getCompareToValueComp(hLTNonDiagDataComputationN,...
    rowCount,...
    CompareToConstant5_out1_s11,...
    '==',blockInfo.MatrixSize,...
    sprintf('Compare\nTo Constant5'),0);

    if blockInfo.MatrixSize==1
        diagValidOutReg=l_addSignal(hLTNonDiagDataComputationN,'diagValidOutReg',pirTyp1,slRate);
        pirelab.getIntDelayComp(hLTNonDiagDataComputationN,...
        diagValidOut,...
        diagValidOutReg,...
        1,'diagValidOutReg',...
        false,...
        0,0,[],0,0);

        pirelab.getSwitchComp(hLTNonDiagDataComputationN,...
        [Constant_out1_s12,Constant1_out1_s13],...
        rowFinish,...
        diagValidOutReg,'rowFinishSig',...
        '~=',0,'Floor','Wrap');
    else
        pirelab.getCounterComp(hLTNonDiagDataComputationN,...
        [CompareToConstant_out1_s6,nonDiagValidOut],...
        HDLCounter_out1_s31,...
        'Count limited',0,1,((blockInfo.MatrixSize*(blockInfo.MatrixSize-1))-1),1,0,1,0,'HDL Counter',0);

        pirelab.getCompareToValueComp(hLTNonDiagDataComputationN,...
        HDLCounter_out1_s31,...
        CompareToConstant_out1_s6,...
        '==',((blockInfo.MatrixSize*(blockInfo.MatrixSize-1))-1),...
        sprintf('Compare\nTo Constant'),0);


        pirelab.getLogicComp(hLTNonDiagDataComputationN,...
        [CompareToConstant_out1_s6,nonDiagValidOut],...
        rowFinish,...
        'and',sprintf('Logical\nOperator'));
    end

    pirelab.getLogicComp(hLTNonDiagDataComputationN,...
    [rowFinish,CompareToConstant5_out1_s11],...
    invFinish,...
    'and',sprintf('Logical\nOperator2'));


    pirelab.getSwitchComp(hLTNonDiagDataComputationN,...
    [Constant_out1_s12,Switch1_out1_s37],...
    Switch_out1_s36,...
    reciprocalValid,'Switch',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(hLTNonDiagDataComputationN,...
    [Constant1_out1_s13,reciprocalValidOutReg],...
    Switch1_out1_s37,...
    CompareToConstant1_out1_s7,'Switch1',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(hLTNonDiagDataComputationN,...
    [Constant2_out1_s14,Switch3_out1_s39],...
    Switch2_out1_s38,...
    nonDiagValidIn,'Switch2',...
    '~=',0,'Floor','Wrap');



    pirelab.getSwitchComp(hLTNonDiagDataComputationN,...
    [Constant3_out1_s15,nonDiagValidInReg],...
    Switch3_out1_s39,...
    CompareToConstant2_out1_s8,'Switch3',...
    '~=',0,'Floor','Wrap');



    pirelab.getSwitchComp(hLTNonDiagDataComputationN,...
    [reciprocalData,diagReciprocalDataReg],...
    Switch4_out1_s40,...
    reciprocalValid,'Switch4',...
    '~=',0,'Floor','Wrap');



    pirelab.getSwitchComp(hLTNonDiagDataComputationN,...
    [Delay6_out1_s22,Switch7_out1_s43],...
    Switch5_out1_s41,...
    reciprocalValid,'Switch5',...
    '~=',0,'Floor','Wrap');



    pirelab.getSwitchComp(hLTNonDiagDataComputationN,...
    [Delay7_out1_s23,Switch8_out1_s44],...
    Switch6_out1_s42,...
    reciprocalValid,'Switch6',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(hLTNonDiagDataComputationN,...
    [readData,readDataReg],...
    Switch7_out1_s43,...
    nonDiagValidIn,'Switch7',...
    '~=',0,'Floor','Wrap');


    pirelab.getSwitchComp(hLTNonDiagDataComputationN,...
    [Delay5_out1_s21,colCountOutReg],...
    Switch8_out1_s44,...
    nonDiagValidIn,'Switch8',...
    '~=',0,'Floor','Wrap');




    NonDiagEleComputationInSigs=[diagReciprocalDataReg,reciprocalValidOutReg,...
    nonDiagValidInReg,diagValidCount,rowCount,readDataReg,nonDiagValidInCount,colCountOutReg];
    NonDiagEleComputationOutSigs=[nonDiagDataOut1,colCountOut,nonDiagDataOut2,diagDataOut1,diagDataOut2,nonDiagValidOut,diagValidOut];

    this.gaussJordanDiagNonDiagEleComputation(hLTNonDiagDataComputationN,NonDiagEleComputationInSigs,NonDiagEleComputationOutSigs,...
    hBoolT,hCounterT,hInputDataT,slRate,blockInfo);


    pirelab.instantiateNetwork(hN,hLTNonDiagDataComputationN,LTNonDiagDataComputationInSigs,...
    LTNonDiagDataComputationOutSigs,[hLTNonDiagDataComputationN.Name,'_inst']);
end



function hS=l_addSignal(hN,sigName,pirTyp,simulinkRate)
    hS=hN.addSignal;
    hS.Name=sigName;
    hS.Type=pirTyp;
    hS.SimulinkHandle=-1;
    hS.SimulinkRate=simulinkRate;
end


