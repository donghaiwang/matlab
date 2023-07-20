function[newData]=simrfV2_ce_cwsource(origData)






    newData(length(origData))=struct;
    s_idx=0;
    for n_idx=1:length(origData)
        switch origData(n_idx).Name
        case{'CWSourceType','Z0','IVoltage','ICurrent','MagPower',...
            'QVoltage','QCurrent','AnglePower','CarrierFreq',...
            'InternalGrounding'}
            s_idx=s_idx+1;
            newData(s_idx).Name=origData(n_idx).Name;
            newData(s_idx).Value=origData(n_idx).Value;
        case 'IVoltageUnit'
            s_idx=s_idx+1;
            newData(s_idx).Name='IVoltage_unit';
            newData(s_idx).Value=origData(n_idx).Value;
        case 'ICurrentUnit'
            s_idx=s_idx+1;
            newData(s_idx).Name='ICurrent_unit';
            newData(s_idx).Value=origData(n_idx).Value;
        case 'PowerUnit'
            s_idx=s_idx+1;
            newData(s_idx).Name='MagPower_unit';
            newData(s_idx).Value=origData(n_idx).Value;
        case 'QVoltageUnit'
            s_idx=s_idx+1;
            newData(s_idx).Name='QVoltage_unit';
            newData(s_idx).Value=origData(n_idx).Value;
        case 'QCurrentUnit'
            s_idx=s_idx+1;
            newData(s_idx).Name='QCurrent_unit';
            newData(s_idx).Value=origData(n_idx).Value;
        case 'CarrierFreqUnit'
            s_idx=s_idx+1;
            newData(s_idx).Name='CarrierFreq_unit';
            newData(s_idx).Value=origData(n_idx).Value;
        end
    end

    newData=newData(1:s_idx);

end