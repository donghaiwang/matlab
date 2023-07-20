function newComp=getVariableSelectorComp(hN,hInSignals,hOutSignals,...
    zerOneIdxMode,idxMode,elements,...
    fillValues,rowsOrCols,numInputs,...
    compName)


    newComp=hN.addComponent2(...
    'kind','variableselector_comp',...
    'name',compName,...
    'InputSignals',hInSignals,...
    'OutputSignals',hOutSignals,...
    'ZerOneIdxMode',zerOneIdxMode,...
    'IdxMode',idxMode,...
    'Elements',elements,...
    'FillValues',fillValues,...
    'RowsOrCols',rowsOrCols,...
    'NumInputs',numInputs);
end
