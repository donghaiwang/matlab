classdef LogicStringForFlatNearestFixedSlopeBias<handle





    methods(Static)
        function string=getInterpolationLogicString(numInputs)
            string=['if index >= numel(tableValues)',newline,...
            'output(i) = tableValues(end);',newline,...
            'else',newline,...
            'output(i) = tableValues(index);',newline,...
            'end'];
            if numInputs>1
                string=FunctionApproximation.internal.interpolationstrategy.NDLogicStringForFlatNearestFixedSlopeBias.getInterpolationLogicString();
            end
        end
    end
end
