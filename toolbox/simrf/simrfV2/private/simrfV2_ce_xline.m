function[newData]=simrfV2_ce_xline(origData)






    newData(length(origData))=struct;
    s_idx=0;
    for n_idx=1:length(origData)
        switch origData(n_idx).Name
        case{'Parameterization','TransDelay','TransDelay_unit',...
            'CharImped','CharImped_unit','Resistance','Resistance_unit',...
            'Inductance','Inductance_unit',...
            'Capacitance','Capacitance_unit',...
            'Conductance','Conductance_unit',...
            'LineLength','LineLength_unit','NumSegments',...
            'InternalGrounding','Model_type',...
            'OuterRadius','OuterRadius_unit',...
            'InnerRadius','InnerRadius_unit','MuR','EpsilonR',...
            'LossTangent','SigmaCond','SigmaCond_unit',...
            'StubMode','Termination',...
            'ConductorWidth','ConductorWidth_unit',...
            'SlotWidth','SlotWidth_unit','Height','Height_unit',...
            'Thickness','Thickness_unit','SWidth','SWidth_unit',...
            'Radius','Radius_unit','Separation','Separation_unit',...
            'PWidth','PWidth_unit','PSeparation','PSeparation_unit',...
            'PV','Loss','SourceFreq','PlotFreq','PlotFreq_unit','PlotType',...
            'YOption','XOption','FitOpt','FitTol',...
            'SparamRepresentation','Freq','Interp_type','Freq_unit'}
            s_idx=s_idx+1;
            newData(s_idx).Name=origData(n_idx).Name;
            newData(s_idx).Value=origData(n_idx).Value;
        case{'YParam1','YParam2'}
            s_idx=s_idx+1;
            newData(s_idx).Name=origData(n_idx).Name;
            valMatch=strcmp(origData(n_idx).Value,{'S11','S12','S21','S22'});
            if any(valMatch)
                valNew={'S(1,1)','S(1,2)','S(2,1)','S(2,2)'};
                newData(s_idx).Value=valNew{valMatch};
            else
                newData(s_idx).Value=origData(n_idx).Value;
            end
        case{'YFormat1','YFormat2'}
            s_idx=s_idx+1;
            newData(s_idx).Name=origData(n_idx).Name;
            if strcmp(origData(n_idx).Value,'Magnitude (decibels)')
                newData(s_idx).Value='Magnitude (dB)';
            else
                newData(s_idx).Value=origData(n_idx).Value;
            end
        end
    end



    s_idx=s_idx+1;
    newData(s_idx).Name='AutoImpulseLength';
    newData(s_idx).Value='off';

    s_idx=s_idx+1;
    newData(s_idx).Name='ImpulseLength';
    newData(s_idx).Value='0';

    s_idx=s_idx+1;
    newData(s_idx).Name='ImpulseLength_unit';
    newData(s_idx).Value='s';

    newData=newData(1:s_idx);

end