function flag=hasGetParent(blockObject)




    flag=~(...
    isa(blockObject,'fxptds.MATLABIdentifier')...
    ||isa(blockObject,'SimulinkFixedPoint.DataObjectWrapper')...
    ||isa(blockObject,'SimulinkFixedPoint.BusObjectHandle')...
    );
end


