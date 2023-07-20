function schema





    mlock;

    pkg=findpackage('dpigen');
    this=schema.class(pkg,'SimulinkConnection');


    if isempty(findtype('BlockDiagramHandle')),
        schema.UserType('BlockDiagramHandle','mxArray',...
        @checkBlockDiagramHandle);
    end


    schema.prop(this,'ModelName','ustring');


    schema.prop(this,'System','ustring');


    schema.prop(this,'SubsystemName','ustring');


    p=schema.prop(this,'Model','BlockDiagramHandle');
    p.getFunction=@getModel;


    schema.prop(this,'BlockReductionOpt','on/off');
    schema.prop(this,'ConditionallyExecuteInputs','on/off');
    schema.prop(this,'DirtyState','on/off');


    schema.prop(this,'SignalLogging','string');
    schema.prop(this,'ReturnWorkspaceOutputs','string');
    schema.prop(this,'LoggingToFile','string');
    schema.prop(this,'SignalLoggingName','ustring');
    schema.prop(this,'SignalLoggingSaveFormat','string');
    schema.prop(this,'SimulationMode','string');


    schema.prop(this,'InportTestPoint','string vector');
    schema.prop(this,'InportDataLogging','string vector');
    schema.prop(this,'InportDataLoggingNameMode','string vector');
    schema.prop(this,'InportDataLoggingName','string vector');


    schema.prop(this,'OutportTestPoint','string vector');
    schema.prop(this,'OutportDataLogging','string vector');
    schema.prop(this,'OutportDataLoggingNameMode','string vector');
    schema.prop(this,'OutportDataLoggingName','string vector');



    function checkBlockDiagramHandle(h)

        if~isempty(h)&&~isa(h,'Simulink.BlockDiagram')
            error(message('HDLLink:SimulinkConnection:BadBlkDiagram'));
        end

