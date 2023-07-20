function expr=sldvDiscIntegLimitOutputDecision(blockH,offsetInCvgPts,outcome)


    coder.inline('never');
    coder.allowpcode('plain');

    portSize=blockInportSize(blockH,1);
    outputExpr=true(portSize,1);

    numOfCvgPts=2;
    coverageType=getDecCvgString();
    outcome=cast(outcome,'double');


    expr=sldv.getObjective(outputExpr,coder.const(outputExpr),...
    coder.const(coverageType),coder.const(numOfCvgPts),...
    coder.const(offsetInCvgPts),coder.const(outcome));
end
