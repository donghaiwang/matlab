function[success,info,newCount]=rmidlgApply(linkSource,reqs)




    try
        rmitm.setReqs(linkSource,reqs);
        success=true;
        info='';
        newCount=length(reqs);
    catch Mex
        success=false;
        info=Mex.message;
        newCount=-1;
    end
end
