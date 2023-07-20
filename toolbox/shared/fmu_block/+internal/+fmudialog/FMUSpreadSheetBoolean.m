classdef(Hidden=true)FMUSpreadSheetBoolean<internal.fmudialog.FMUSpreadSheetItem
    properties
        rowDescription;
        rowParameter;
        rowValueStringPos;
        filterKey;
    end
    methods

        function obj=FMUSpreadSheetBoolean(dataSource,name,description,descName,isTopLevel)
            obj.dlgSource=dataSource.dlgSource;
            obj.dataSource=dataSource;
            obj.isTopLevel=isTopLevel;
            obj.filterKey=descName;
            obj.rowDescription=description;
            obj.rowParameter=name;
            if isTopLevel
                obj.rowValueStringPos=obj.dataSource.workingIndex(1);
            else
                if obj.dataSource.showAsStruct
                    obj.rowValueStringPos=[];
                else
                    obj.rowValueStringPos=obj.dataSource.workingIndex;
                end
            end
        end


        function iconFile=getDisplayIcon(obj)
            iconFile=fullfile('toolbox','shared','dastudio','resources','variable_fmi_bool.png');
        end


        function propValue=getPropValue(obj,propName)
            switch propName
            case obj.FMUDialogColumn1
                propValue=obj.rowParameter;
            case obj.FMUDialogColumn2
                if length(obj.rowValueStringPos)~=2
                    if obj.isTopLevel
                        propValue=obj.dataSource.valueString{obj.rowValueStringPos(1)};
                    else
                        propValue=[];
                    end
                else
                    strRange=obj.dataSource.valueStructurePosition{obj.rowValueStringPos(1)}{obj.rowValueStringPos(2)};
                    propValue=obj.dataSource.valueString{obj.rowValueStringPos(1)}(strRange(1):strRange(2));
                end
            case obj.FMUDialogColumn3
                propValue=[];
            case obj.FMUDialogColumn4
                propValue=obj.rowDescription;
            otherwise
                warning('Unexpected type');
            end
        end


        function propType=getPropDataType(obj,propName)
            switch propName
            case obj.FMUDialogColumn2
                if obj.isTopLevel
                    propType='bool';
                else
                    propType='string';
                end
            case{obj.FMUDialogColumn1,obj.FMUDialogColumn3,obj.FMUDialogColumn4}
                propType='string';
            otherwise
                warning('Unexpected type');
            end
        end



        function setPropValue(obj,propName,propValue)


            isValueOK=false;
            if obj.isTopLevel

                propValue=obj.logicstr2str(propValue);
                isValueOK=true;
            else
                p=mtree(propValue);
                if p.root.Next.isnull&&p.root.iskind('PRINT')&&p.root.Arg.Next.isnull
                    isValueOK=all(isspace(propValue([1:p.root.Arg.lefttreepos-1,p.root.Arg.righttreepos+1:end])));


                    propValue=propValue(p.root.Arg.lefttreepos:p.root.Arg.righttreepos);
                end
            end

            if isValueOK

                obj.updateValueString(propValue,obj.rowValueStringPos);
            else
                dp=DAStudio.DialogProvider;
                msg=DAStudio.message('FMUBlock:FMU:InvalidBoolValue');
                title=DAStudio.message('FMUBlock:FMU:Parameters');
                dp.errordlg(msg,title,true);
            end
        end


        function getMetaInfo(obj,info)
            info.FilterKey=obj.filterKey;
        end

        function isHier=isHierarchical(obj)
            isHier=false;
        end


        function isReadOnly=isReadonlyProperty(obj,propName)
            switch propName
            case obj.FMUDialogColumn2
                isReadOnly=isempty(obj.rowValueStringPos)||...
                ~obj.dlgSource.DialogData.ListEnabled(obj.rowValueStringPos(1))||...
                obj.dlgSource.DialogData.ListReadOnly(obj.rowValueStringPos(1));
            case{obj.FMUDialogColumn1,obj.FMUDialogColumn3,obj.FMUDialogColumn4}
                isReadOnly=true;
            otherwise
                warning('Unexpected type');
            end
        end


        function isValid=isValidProperty(obj,propName)
            switch propName
            case obj.FMUDialogColumn1
                isValid=true;
            case obj.FMUDialogColumn2
                isValid=~isempty(obj.rowValueStringPos);
            case obj.FMUDialogColumn3
                isValid=false;
            case obj.FMUDialogColumn4
                isValid=true;
            otherwise
                warning('Unexpected type');
            end
        end

        function val=logicstr2str(~,logicVal)
            if strcmp(logicVal,'1')
                val='on';
            elseif strcmp(logicVal,'0')
                val='off';
            else
                assert(false,'Unexpected logical value');
            end
        end
    end
end
