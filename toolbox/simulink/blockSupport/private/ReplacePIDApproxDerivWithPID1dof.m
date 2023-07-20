function ReplacePIDApproxDerivWithPID1dof(block,h)





    if askToReplace(h,block)
        P=get_param(block,'P');
        I=get_param(block,'I');
        D=get_param(block,'D');
        N=get_param(block,'N');
        funcSet=uReplaceBlock(h,block,'simulink/Continuous/PID Controller',...
        'P',P,'I',I,'D',D,'N',N);
        appendTransaction(h,block,h.ReplaceBlockReasonStr,{funcSet});
    end

end
