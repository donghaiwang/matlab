function v=validateDSPStyle(this,hC)


    v=hdlvalidatestruct;
    DSPStyleValue=this.getImplParams('DSPStyle');

    numInputPorts=hC.NumberOfPirInputPorts;
    in1signal=hC.PirInputPorts(1).Signal;

    if strcmpi(DSPStyleValue,'on')
        hDriver=hdlcurrentdriver;
        synthesisToolname=hDriver.getParameter('SynthesisTool');
        if~(strcmpi(synthesisToolname,'Xilinx ISE')||strcmpi(synthesisToolname,'Altera Quartus II')||strcmpi(synthesisToolname,'Xilinx Vivado'))
            v(end+1)=hdlvalidatestruct(2,message('hdlcoder:validate:DSPStyleNoSynthesisTool'));
        end
        if numInputPorts==1
            if(in1signal.Type.BaseType.is1BitType)
                v(end+1)=hdlvalidatestruct(2,message('hdlcoder:validate:DSPStyleIn1Bit'));
            end
            if hdlsignalisdouble(in1signal)
                v(end+1)=hdlvalidatestruct(2,message('hdlcoder:validate:DSPStylefloatingPoint'));
            end

            in1Type=in1signal.Type;
            in1Dim=in1Type.getDimensions;
            if(in1Dim>2)
                v(end+1)=hdlvalidatestruct(2,message('hdlcoder:validate:DSPStyleProduceOfElementLinear'));
            end
        else
            in2signal=hC.PirInputPorts(2).Signal;
            if(in1signal.Type.BaseType.is1BitType||in2signal.Type.BaseType.is1BitType)
                v(end+1)=hdlvalidatestruct(2,message('hdlcoder:validate:DSPStyleIn1Bit'));
            end
            if(hdlsignalisdouble(in1signal)||hdlsignalisdouble(in2signal))
                v(end+1)=hdlvalidatestruct(2,message('hdlcoder:validate:DSPStylefloatingPoint'));
            end
        end
    end
end


