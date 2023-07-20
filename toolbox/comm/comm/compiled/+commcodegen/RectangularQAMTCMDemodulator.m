classdef RectangularQAMTCMDemodulator<matlab.System
%#codegen


    properties(Access=private)
cSFunObject
    end

    properties(Access=private,Nontunable)
ConstructorArgs
    end

    properties(Nontunable)
TrellisStructure
ModulationOrder
TerminationMethod
TracebackDepth
OutputDataType
ResetInputPort
    end
    properties
    end
    properties(Access=private)

NoTuningBeforeLockingCodeGenError
    end
    methods
        function obj=RectangularQAMTCMDemodulator(cnt_dummy,varargin)%#ok<INUSL>
            coder.allowpcode('plain');
            coder.extrinsic('commcodegen.RectangularQAMTCMDemodulator.propListManager');
            coder.extrinsic('commcodegen.RectangularQAMTCMDemodulator.getFieldFromMxStruct');
            if coder.internal.const(~coder.target('Rtw'))
                obj.NoTuningBeforeLockingCodeGenError=true;
            end
            obj.cSFunObject=comm.RectangularQAMTCMDemodulator(varargin{:});
            obj.ConstructorArgs=varargin;
            setProperties(obj,nargin-1,varargin{:},'TrellisStructure');
            numValueOnlyProps=coder.internal.const(matlab.system.coder.ProcessConstructorArguments.getLastValueOnlyArgIndex(class(obj),varargin{:}));
            s=commcodegen.RectangularQAMTCMDemodulator.propListManager(numValueOnlyProps,'TrellisStructure');
            for i=coder.unroll(numValueOnlyProps+1:2:(nargin-1))
                s=commcodegen.RectangularQAMTCMDemodulator.propListManager(s,varargin{i},true);
            end

            propValues=get(obj.cSFunObject);
            if~coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.propListManager(s,'TrellisStructure',false))
                val=coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.getFieldFromMxStruct(propValues,'TrellisStructure'));
                obj.TrellisStructure=val;
            end
            if~coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.propListManager(s,'ModulationOrder',false))
                val=coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.getFieldFromMxStruct(propValues,'ModulationOrder'));
                obj.ModulationOrder=val;
            end
            if~coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.propListManager(s,'TerminationMethod',false))
                val=coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.getFieldFromMxStruct(propValues,'TerminationMethod'));
                obj.TerminationMethod=val;
            end
            if~coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.propListManager(s,'TracebackDepth',false))
                val=coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.getFieldFromMxStruct(propValues,'TracebackDepth'));
                obj.TracebackDepth=val;
            end
            if~coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.propListManager(s,'OutputDataType',false))
                val=coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.getFieldFromMxStruct(propValues,'OutputDataType'));
                obj.OutputDataType=val;
            end
            if~coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.propListManager(s,'ResetInputPort',false))
                val=coder.internal.const(commcodegen.RectangularQAMTCMDemodulator.getFieldFromMxStruct(propValues,'ResetInputPort'));
                obj.ResetInputPort=val;
            end
            if coder.internal.const(~coder.target('Rtw'))
                obj.NoTuningBeforeLockingCodeGenError=false;
            end
        end
        function set.TrellisStructure(obj,val)
            coder.inline('always');
            coder.internal.errorIf(coder.internal.is_defined(obj.TrellisStructure),'MATLAB:system:codeGenNontunableSetAfterConstructor','comm.RectangularQAMTCMDemodulator');
            obj.TrellisStructure=val;
        end
        function set.ModulationOrder(obj,val)
            coder.inline('always');
            coder.internal.errorIf(coder.internal.is_defined(obj.ModulationOrder),'MATLAB:system:codeGenNontunableSetAfterConstructor','comm.RectangularQAMTCMDemodulator');
            obj.ModulationOrder=val;
        end
        function set.TerminationMethod(obj,val)
            coder.inline('always');
            coder.internal.errorIf(coder.internal.is_defined(obj.TerminationMethod),'MATLAB:system:codeGenNontunableSetAfterConstructor','comm.RectangularQAMTCMDemodulator');
            obj.TerminationMethod=val;
        end
        function set.TracebackDepth(obj,val)
            coder.inline('always');
            coder.internal.errorIf(coder.internal.is_defined(obj.TracebackDepth),'MATLAB:system:codeGenNontunableSetAfterConstructor','comm.RectangularQAMTCMDemodulator');
            obj.TracebackDepth=val;
        end
        function set.OutputDataType(obj,val)
            coder.inline('always');
            coder.internal.errorIf(coder.internal.is_defined(obj.OutputDataType),'MATLAB:system:codeGenNontunableSetAfterConstructor','comm.RectangularQAMTCMDemodulator');
            obj.OutputDataType=val;
        end
        function set.ResetInputPort(obj,val)
            coder.inline('always');
            coder.internal.errorIf(coder.internal.is_defined(obj.ResetInputPort),'MATLAB:system:codeGenNontunableSetAfterConstructor','comm.RectangularQAMTCMDemodulator');
            obj.ResetInputPort=val;
        end
        function sObj=getCSFun(obj)
            sObj=obj.cSFunObject;
        end
        function args=getConstructionArgs(obj)
            args=obj.ConstructorArgs;
        end
        function cloneProp(obj,prop,value)
            if coder.internal.const(~coder.target('Rtw'))
                oldFlag=obj.NoTuningBeforeLockingCodeGenError;
                obj.NoTuningBeforeLockingCodeGenError=true;
            end
            obj.(prop)=value;
            if coder.internal.const(~coder.target('Rtw'))
                obj.NoTuningBeforeLockingCodeGenError=oldFlag;
            end
        end
    end
    methods(Access=protected)
        function num=getNumInputsImpl(obj)
            num=getNumInputs(obj.cSFunObject);
        end
        function num=getNumOutputsImpl(obj)
            num=getNumOutputs(obj.cSFunObject);
        end
        function resetImpl(obj)
            reset(obj.cSFunObject);
        end
        function setupImpl(obj,varargin)
            setup(obj.cSFunObject,varargin{:});
            if coder.internal.const(~coder.target('Rtw'))
                obj.NoTuningBeforeLockingCodeGenError=true;
            end
        end
        function varargout=isInputDirectFeedthroughImpl(obj,varargin)
            [varargout{1:nargout}]=isInputDirectFeedthrough(obj.cSFunObject,varargin{:});
        end
        function varargout=outputImpl(obj,varargin)
            [varargout{1:nargout}]=output(obj.cSFunObject,varargin{:});
        end
        function updateImpl(obj,varargin)
            update(obj.cSFunObject,varargin{:});
        end
        function out=getDiscreteStateImpl(~)
            out.s=1;
            coder.internal.assert(false,'MATLAB:system:getDiscreteStateNotSupported');
        end
        function out=getContinuousStateImpl(~)
            out.s=1;
            coder.internal.assert(false,'MATLAB:system:getContinuousStateNotSupported');
        end
        function setDiscreteStateImpl(~,~)
            coder.internal.assert(false,'MATLAB:system:setDiscreteStateNotSupported');
        end
        function setContinuousStateImpl(~,~)
            coder.internal.assert(false,'MATLAB:system:setContinuousStateNotSupported');
        end
    end
    methods(Static,Hidden)
        function s=propListManager(varargin)














            if nargin>0&&isstruct(varargin{1})
                s=varargin{1};
                fieldName=varargin{2};
                if varargin{3}
                    s.(fieldName)=true;
                else
                    s=isfield(s,fieldName);
                end
            else
                s=struct;
                if nargin>0
                    for ii=1:varargin{1}
                        s.(varargin{ii+1})=true;
                    end
                end
            end
        end
        function y=getFieldFromMxStruct(s,field)







            y=s.(field);
        end
        function result=matlabCodegenUserReadableName
            result='comm.RectangularQAMTCMDemodulator';
        end
    end
end
