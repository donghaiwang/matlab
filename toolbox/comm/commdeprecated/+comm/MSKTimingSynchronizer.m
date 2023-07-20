classdef MSKTimingSynchronizer<comm.internal.TimingSynchronizerBase









































































%#function mcomtimrecmsk

%#ok<*EMCLS>
%#ok<*EMCA>

    methods

        function obj=MSKTimingSynchronizer(varargin)
            coder.allowpcode('plain');
            obj@comm.internal.TimingSynchronizerBase('mcomtimrecmsk');
            setProperties(obj,nargin,varargin{:});
            obj.pSynchronizerIndex=1;


            setForceInputRealToComplex(obj,1,true);
        end
    end

    methods(Static,Hidden)
        function a=getAlternateBlock
            a='commtimrec2/MSK-Type Signal Timing Recovery';
        end

    end

end

