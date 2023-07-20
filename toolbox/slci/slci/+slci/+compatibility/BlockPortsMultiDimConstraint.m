

classdef BlockPortsMultiDimConstraint<slci.compatibility.Constraint

    methods

        function out=getDescription(aObj)
            out=['The inports and outports of '...
            ,aObj.ParentBlock().getName()...
            ,' must be scalars, vectors, or two-dimensional matrices.'];
        end

        function obj=BlockPortsMultiDimConstraint()
            obj.setEnum('BlockPortsMultiDim');
            obj.setCompileNeeded(1);
            obj.setFatal(false);
        end

        function out=check(aObj)
            out=[];
            compiledPortFramedSignals=aObj.ParentBlock().getParam('CompiledPortFrameData');
            if isempty(compiledPortFramedSignals)
                numIn=0;
                numOut=0;
            else
                numIn=numel(compiledPortFramedSignals.Inport);
                numOut=numel(compiledPortFramedSignals.Outport);
            end
            portHandles=aObj.ParentBlock().getParam('PortHandles');
            if numIn==numel(portHandles.Inport)
                for i=1:numIn
                    dims=get_param(portHandles.Inport(i),'CompiledPortDimensions');
                    inFramed=compiledPortFramedSignals.Inport(i);
                    if~inFramed&&dims(1)>2
                        out=slci.compatibility.Incompatibility(...
                        aObj,...
                        'MultiDimBlockInport',...
                        num2str(i),...
                        aObj.ParentBlock().getName());
                        return
                    end
                end
            end
            if numOut==numel(portHandles.Outport)
                for i=1:numOut
                    dims=get_param(portHandles.Outport(i),'CompiledPortDimensions');
                    inFramed=compiledPortFramedSignals.Outport(i);
                    if~inFramed&&dims(1)>2
                        out=slci.compatibility.Incompatibility(...
                        aObj,...
                        'MultiDimBlockOutport',...
                        num2str(i),...
                        aObj.ParentBlock().getName());
                        return
                    end
                end
            end
        end

    end
end

