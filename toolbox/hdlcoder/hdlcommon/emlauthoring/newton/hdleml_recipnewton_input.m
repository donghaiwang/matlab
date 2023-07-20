%#codegen
function[aout,dynamicShift,oneMoreShift,varargout]=hdleml_recipnewton_input(ain,...
    reintp_ex,norm_ex,normWL,normFixedShift,numOR,shiftv_ex,absShift_ex)





    coder.allowpcode('plain')
    eml_prefer_const(reintp_ex,norm_ex,normWL,normFixedShift,numOR,shiftv_ex,absShift_ex);

    fm=hdlfimath;

    if ain.Signed
        if bitsliceget(ain,ain.WordLength,ain.WordLength)==fi(1,0,1,0,fm)
            uain=-ain;
            varargout{1}=fi(1,0,1,0,fm);
        else
            uain=ain;
            varargout{1}=fi(0,0,1,0,fm);
        end
    else
        uain=ain;
        varargout{1}=fi(1,0,1,0,fm);
    end


    areintp=reinterpretcast(uain,numerictype(reintp_ex));
    anorm=fi(areintp,numerictype(norm_ex),fm);



    zero=fi(0,0,1,0,fm);
    aor=hdleml_define_len(zero,numOR);
    for ii=coder.unroll(1:numOR)
        lidx=normWL-(ii-1)*2;
        ridx=normWL-(ii-1)*2-1;
        aor(ii)=bitorreduce(bitsliceget(anorm,lidx,ridx));
    end



    dynamicShift=construct_switch_logics(aor,numOR,shiftv_ex);









    shiftnum=bitsll(dynamicShift,1);
    aoutPreshift=bitsll(anorm,int(shiftnum));
    oneMoreShift=bitcmp(bitsliceget(aoutPreshift,normWL,normWL));

    if oneMoreShift==fi(1,0,1,0,fm)
        aout=bitsll(aoutPreshift,int(fi(1,0,1,0,fm)));
    else
        aout=aoutPreshift;
    end

end


function sel=construct_switch_logics(aor,numOR,shiftv_ex)

    eml_prefer_const(numOR);

    fm=hdlfimath;

    for ii=coder.unroll(1:numOR)
        if aor(ii)==fi(1,0,1,0,fm)
            sel=fi(ii-1,numerictype(shiftv_ex),fm);

            return;
        end
    end
    sel=fi(numOR,numerictype(shiftv_ex),fm);

end


