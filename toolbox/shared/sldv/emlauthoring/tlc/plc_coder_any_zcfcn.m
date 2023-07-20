%#codegen
function[outEvent,outState]=plc_coder_any_zcfcn(inState,inInput)







    coder.allowpcode('plain');


    ZERO_ZCSIG=uint8(0);
    POS_ZCSIG=uint8(1);
    NEG_ZCSIG=uint8(2);

    ZERO_RISING_EV_ZCSIG=uint8(100);
    ZERO_FALLING_EV_ZCSIG=uint8(101);


    FALLING_ZCEVENT=int32(-1);
    NO_ZCEVENT=int32(0);
    RISING_ZCEVENT=int32(1);

    if inInput>0
        outState=POS_ZCSIG;
    elseif inInput<0
        outState=NEG_ZCSIG;
    else
        outState=ZERO_ZCSIG;
    end

    if xlate_util_zcfcn_detect_rising(inState,outState)
        outEvent=RISING_ZCEVENT;
    elseif xlate_util_zcfcn_detect_falling(inState,outState)
        outEvent=FALLING_ZCEVENT;
    else
        outEvent=NO_ZCEVENT;
    end

    if(inState==NEG_ZCSIG)&&(outState==ZERO_ZCSIG)
        outState=ZERO_RISING_EV_ZCSIG;
    elseif(inState==POS_ZCSIG)&&(outState==ZERO_ZCSIG)
        outState=ZERO_FALLING_EV_ZCSIG;
    end
end