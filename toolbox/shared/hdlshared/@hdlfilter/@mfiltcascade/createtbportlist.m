function createtbportlist(this)






    entity_name=hdlentitytop;
    if isempty(entity_name)
        if isempty(hdlgetparameter('filter_name'))
            error(message('HDLShared:hdlfilter:nofilter'));
        else
            entity_name=hdlgetparameter('filter_name');
        end
    end



    hdlentitysignalsinit;
    clkname=hdlgetparameter('clockname');
    if isempty(clkname)
        clkname='clk';
    end

    clkenname=hdlgetparameter('clockenablename');
    if isempty(clkenname)
        clkenname='clk_enable';
    end

    resetname=hdlgetparameter('resetname');
    if isempty(resetname)
        resetname='reset';
    end

    innamename=hdlgetparameter('filter_input_name');
    if isempty(innamename)
        innamename='filter_in';
    end

    outnamename=hdlgetparameter('filter_output_name');
    if isempty(outnamename)
        outnamename='filter_out';
    end

    ceoutname=hdlgetparameter('clockenableoutputname');
    if isempty(ceoutname)
        ceoutname='ce_out';
    end

    bdt=hdlgetparameter('base_data_type');

    hdlnewsignal(clkname,'filter',-1,0,0,bdt,'boolean');
    hdlnewsignal(clkenname,'filter',-1,0,0,bdt,'boolean');
    hdlnewsignal(resetname,'filter',-1,0,0,bdt,'boolean');
    inputall=hdlgetallfromsltype(this.Stage(1).inputSLtype,'inputport');
    inputvtype=inputall.portvtype;
    inputsltype=inputall.portsltype;


    hdlnewsignal(innamename,'filter',-1,hdlgetparameter('filter_complex_inputs'),0,inputvtype,inputsltype);
    hdllastinputsignal;
    if hdlgetparameter('RateChangePort')
        createVarRatePorts(this);
    end

    outputall=hdlgetallfromsltype(this.Stage(end).outputsltype,'outputport');
    outputvtype=outputall.portvtype;
    outputsltype=outputall.portsltype;

    hdlnewsignal(outnamename,'filter',-1,hdlgetparameter('filter_complex_inputs'),0,outputvtype,outputsltype);

    rcf=this.RateChangeFactors;
    if~any(rcf(end,:)==1)
        ceinname=hdlgetparameter('clockenableinputname');
        if isempty(ceinname)
            ceinname='ce_in';
        end
        hdlnewsignal(ceinname,'filter',-1,0,0,bdt,'boolean');
    end
    if hdlgetparameter('clockinputs')==1
        hdlnewsignal(ceoutname,'filter',-1,0,0,bdt,'boolean');
    end
    if strcmpi(this.Implementation,'localmultirate')&&...
        strcmpi(this.getCascadeType,'interpolating')
        ceoutvldname=hdlgetparameter('clockenableoutputvalidname');
        if isempty(ceoutvldname)
            ceoutvldname='ce_valid';
        end
        hdlnewsignal(ceoutvldname,'filter',-1,0,0,bdt,'boolean');
    end
    hdllastoutputsignal;

