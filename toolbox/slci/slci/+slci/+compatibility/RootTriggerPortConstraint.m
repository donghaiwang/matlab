


classdef RootTriggerPortConstraint<slci.compatibility.Constraint

    methods

        function out=getDescription(aObj)%#ok
            out='Trigger Port blocks are not permitted at the model root (i.e. in the top diagram of the model)';
        end

        function obj=RootTriggerPortConstraint()
            obj.setEnum('RootTriggerPort');
            obj.setCompileNeeded(0);
            obj.setFatal(true);
        end

        function out=check(aObj)
            out=[];
            blkSID=aObj.ParentBlock().getSID();
            if strcmpi(get_param(blkSID,'Parent'),aObj.ParentModel().getName())
                out=slci.compatibility.Incompatibility(...
                aObj,...
                'RootTriggerPort');
            end
        end

    end
end


