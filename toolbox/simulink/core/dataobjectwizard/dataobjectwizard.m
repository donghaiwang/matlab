function dataobjectwizard(varargin)







    guiFlag=0;
    modelName='';
    if isempty(varargin)==0
        if isnumeric(varargin{1})==0
            if isempty(varargin{1})
                guiFlag=0;
                modelName='';
            else
                guiFlag=1;
                modelName=varargin{1};
            end
        end
    end



    newDow=1;
    hAllChild=allchild(0);
    for i=1:length(hAllChild)
        if strcmp(get(hAllChild(i),'Name'),DAStudio.message('Simulink:dow:UI_FigureTitle'))
            userData=get(hAllChild(i),'UserData');
            if~isempty(userData)&&isfield(userData,'oldModelName')
                if strcmp(userData.oldModelName,modelName)
                    newDow=0;
                    getframe(hAllChild(i));
                    break;
                end
            end
        end
    end


    if newDow==1
        data_object_wizard(modelName,guiFlag);
    end


    function data_object_wizard(modelName,guiFlag,varargin)







        get_param(0,'Version');


        dow.dowFigureTitle=DAStudio.message('Simulink:dow:UI_FigureTitle');


        dow.defaultFrameColor=[0.86,0.86,0.86];
        dow.defaultColor=[0.96,0.96,0.96];
        dow.defaultErrorColor=[1.0,0.55,0.75];
        dow.chkColor=[0.62,0.62,0.62];
        dow.defaultBoxHeight=22;
        dow.defaultFontSize=8;
        dow.dataList='';
        dow.modelPath=pwd;
        dow.addPath=0;
        dow.tagField='UndefinedDataObjectWizard';
        dow.chk=[];
        dow.nameTxt=[];

        dow.type=[];

        dow.class=[];
        dow.fullClassName=[];

        dow.oldModelName=modelName;


        if guiFlag==0
            enable='off';
        else
            enable='on';
        end


        dow.objectList=dow_package_registry;


        dow.objectType={'Signal','Parameter'};


        dh=50;

        scrsz=get(groot,'ScreenSize');
        dow.fig=figure('tag',dow.tagField,...
        'numbertitle','off',...
        'handlevis','off',...
        'units','pixels',...
        'Color',dow.defaultFrameColor,...
        'menubar','none',...
        'position',[50,scrsz(4)-(550+dh),555,500+dh],...
        'paperpositionmode','auto',...
        'DeleteFcn','clear global dow;',...
        'resize','off',...
        'WindowStyle','normal',...
        'name',dow.dowFigureTitle);

        dow.topText=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'BackgroundColor',dow.defaultFrameColor,...
        'FontSize',10,...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_FigureHeader'),...
        'Units','pixels',...
        'Visible','on',...
        'Enable','on',...
        'Position',[12,445+dh,500,52]);



        dow.frame=uicontrol('Parent',dow.fig,...
        'Style','Frame',...
        'BackgroundColor',dow.defaultColor,...
        'HorizontalAlignment','Left',...
        'Units','pixels',...
        'Visible','on',...
        'Enable','on',...
        'Position',[10,126+dh,537,325]);




        dow.TitleFrame1=uicontrol('Parent',dow.fig,...
        'Style','Frame',...
        'HorizontalAlignment','Left',...
        'BackGroundColor',dow.defaultColor-[0.08,0.08,0.08],...
        'FontWeight','bold',...
        'String','Sl',...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Position',[10,431+dh,19,dow.defaultBoxHeight+4]);

        dow.Title1=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'HorizontalAlignment','center',...
        'BackGroundColor',dow.defaultColor-[0.08,0.08,0.08],...
        'FontWeight','bold',...
        'String',' ',...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Position',[12,432+dh,19,dow.defaultBoxHeight+2]);


        dow.TitleFrame2=uicontrol('Parent',dow.fig,...
        'Style','Frame',...
        'HorizontalAlignment','Left',...
        'BackGroundColor',dow.defaultColor-[0.08,0.08,0.08],...
        'FontWeight','bold',...
        'String',DAStudio.message('Simulink:dow:UI_ObjectName_Widget'),...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Position',[28,431+dh,266,dow.defaultBoxHeight+4]);


        dow.Title2=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'HorizontalAlignment','center',...
        'BackGroundColor',dow.defaultColor-[0.08,0.08,0.08],...
        'FontWeight','bold',...
        'String',DAStudio.message('Simulink:dow:UI_ObjectName_Widget'),...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Position',[29,432+dh,266,dow.defaultBoxHeight+2]);

        clsHeaderFrameWidth=253;
        clsHeaderTextLeft=350;


        dow.TitleFrame3=uicontrol('Parent',dow.fig,...
        'Style','Frame',...
        'HorizontalAlignment','Left',...
        'BackGroundColor',dow.defaultColor-[0.08,0.08,0.08],...
        'FontWeight','bold',...
        'String',DAStudio.message('Simulink:dow:UI_Class_Widget'),...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Position',[293,431+dh,clsHeaderFrameWidth,dow.defaultBoxHeight+4]);


        dow.Title3=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'HorizontalAlignment','center',...
        'BackGroundColor',dow.defaultColor-[0.08,0.08,0.08],...
        'FontWeight','bold',...
        'String',DAStudio.message('Simulink:dow:UI_Class_Widget'),...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Position',[clsHeaderTextLeft,432+dh,109,dow.defaultBoxHeight+2]);


        XStartAppButn=421;
        WidthAppButn=126;
        pkgBtnBottom=147;
        mdlLabelBottom=65;
        toolTipStrBottom=61;
        browseBtnBottom=61;
        analyzeGrpBottom=45;
        analyzeGrpHeight=65;
        checkBoxBottomDiff=12;
        aliasBottom=45;
        aliasHeight=60;
        YStartAliasChkBox=65;
        YStartBottomButns=15;


        XStartSimuPullDnButn=322;
        WidthSimuPullDnButn=95;


        dow.ApplyPackage=uicontrol('Parent',dow.fig,...
        'Style','pushbutton',...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_ChangeClass_Widget'),...
        'Callback','dow_callback(''changeClass'');',...
        'Visible','on',...
        'Units','pixels',...
        'Enable','off',...
        'ToolTipString',DAStudio.message('Simulink:dow:UI_ChangeClass_Tooltip'),...
        'Position',[XStartAppButn,pkgBtnBottom,WidthAppButn,23],...
        'Value',0);


        dow.modelNameText=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'BackgroundColor',dow.defaultFrameColor,...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_ModelName_Widget'),...
        'Units','pixels',...
        'Visible','on',...
        'Enable','on',...
        'Position',[10,mdlLabelBottom+dh,100,dow.defaultBoxHeight]);
        XStartModelEdit=107;
        dow.modelNameEdit=uicontrol('Parent',dow.fig,...
        'Style','edit',...
        'BackgroundColor',dow.defaultColor,...
        'HorizontalAlignment','Left',...
        'Callback','dow_callback(''modeledit'');',...
        'String',modelName,...
        'ForegroundColor',[0,0,1],...
        'Units','pixels',...
        'Visible','on',...
        'Enable','on',...
        'ToolTipString',DAStudio.message('Simulink:dow:UI_ModelName_Tooltip'),...
        'Position',[XStartModelEdit,toolTipStrBottom+dh,XStartSimuPullDnButn+WidthSimuPullDnButn-XStartModelEdit,23]);

        dow.Browse=uicontrol('Parent',dow.fig,...
        'Style','pushbutton',...
        'HorizontalAlignment','Left',...
        'Callback','dow_callback(''browse'');',...
        'String',[DAStudio.message('Simulink:dow:UI_Browse_Widget'),'...'],...
        'Visible','on',...
        'Units','pixels',...
        'ToolTipString',DAStudio.message('Simulink:dow:UI_Browse_Tooltip'),...
        'Enable','on',...
        'Position',[XStartAppButn,browseBtnBottom+dh,WidthAppButn,23],...
        'Value',0);


        XStartFindOptsFrm=8;

        dow.analyzeOpGroup=uipanel('Parent',dow.fig,...
        'Title',DAStudio.message('Simulink:dow:UI_FindOptions_Widget'),...
        'BackgroundColor',dow.defaultFrameColor,...
        'Units','pixels',...
        'Position',[XStartFindOptsFrm,analyzeGrpBottom,XStartAppButn+WidthAppButn-8,analyzeGrpHeight]);

        dw=10;
        wChkBox=20;
        hChkBox=wChkBox;
        hTxtField=16;

        dow.rootiChk=uicontrol('Parent',dow.fig,...
        'Style','CheckBox',...
        'BackgroundColor',dow.defaultFrameColor,...
        'Callback','dow_callback(''rootichk'');',...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Value',1.0,...
        'Position',[10+dw,62+checkBoxBottomDiff,wChkBox,hChkBox]);

        dow.rootiTxt=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'BackgroundColor',dow.defaultFrameColor,...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_RootInputs_Widget'),...
        'Units','pixels',...
        'Visible','on',...
        'Enable','on',...
        'Position',[28+dw,62+checkBoxBottomDiff,86,hTxtField]);

        dow.rootoChk=uicontrol('Parent',dow.fig,...
        'Style','CheckBox',...
        'BackgroundColor',dow.defaultFrameColor,...
        'Callback','dow_callback(''rootochk'');',...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Value',1.0,...
        'Position',[10+dw,42+checkBoxBottomDiff,wChkBox,hChkBox]);

        dow.rootoTxt=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'BackgroundColor',dow.defaultFrameColor,...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_RootOutputs_Widget'),...
        'Units','pixels',...
        'Visible','on',...
        'Enable','on',...
        'Position',[28+dw,42+checkBoxBottomDiff,86,hTxtField]);


        dow.stateChk=uicontrol('Parent',dow.fig,...
        'Style','CheckBox',...
        'BackgroundColor',dow.defaultFrameColor,...
        'Callback','dow_callback(''statechk'');',...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Value',1.0,...
        'Position',[120+dw,62+checkBoxBottomDiff,wChkBox,hChkBox]);

        dow.stateTxt=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'BackgroundColor',dow.defaultFrameColor,...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_States_Widget'),...
        'Units','pixels',...
        'Visible','on',...
        'Enable','on',...
        'Position',[138+dw,62+checkBoxBottomDiff,82,hTxtField]);

        dow.datastoreChk=uicontrol('Parent',dow.fig,...
        'Style','CheckBox',...
        'BackgroundColor',dow.defaultFrameColor,...
        'Callback','dow_callback(''datstorechk'');',...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Value',1.0,...
        'Position',[120+dw,42+checkBoxBottomDiff,wChkBox,hChkBox]);

        dow.datastoreTxt=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'BackgroundColor',dow.defaultFrameColor,...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_DataStores_Widget'),...
        'Units','pixels',...
        'Visible','on',...
        'Enable','on',...
        'Position',[138+dw,42+checkBoxBottomDiff,82,hTxtField]);

        dow.blockoChk=uicontrol('Parent',dow.fig,...
        'Style','CheckBox',...
        'BackgroundColor',dow.defaultFrameColor,...
        'Callback','dow_callback(''blockochk'');',...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Value',1.0,...
        'Position',[225+dw,62+checkBoxBottomDiff,wChkBox,hChkBox]);

        dow.blockoTxt=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'BackgroundColor',dow.defaultFrameColor,...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_BlockOutputs_Widget'),...
        'Units','pixels',...
        'Visible','on',...
        'Enable','on',...
        'Position',[243+dw,62+checkBoxBottomDiff,96,hTxtField]);

        dow.paramChk=uicontrol('Parent',dow.fig,...
        'Style','CheckBox',...
        'BackgroundColor',dow.defaultFrameColor,...
        'Callback','dow_callback(''paramchk'');',...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Value',1.0,...
        'Position',[225+dw,42+checkBoxBottomDiff,wChkBox,hChkBox]);

        dow.paramTxt=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'BackgroundColor',dow.defaultFrameColor,...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_Parameters_Widget'),...
        'Units','pixels',...
        'Visible','on',...
        'Enable','on',...
        'Position',[243+dw,42+checkBoxBottomDiff,86,hTxtField]);



        dow.aliasGroup=uipanel('Parent',dow.fig,...
        'Title','',...
        'BackgroundColor',dow.defaultFrameColor,...
        'Units','pixels',...
        'Position',[355,aliasBottom,XStartAppButn+WidthAppButn-355,aliasHeight]);

        dow.aliastypeChk=uicontrol('Parent',dow.fig,...
        'Style','CheckBox',...
        'BackgroundColor',dow.defaultFrameColor,...
        'Callback','dow_callback(''aliastypechk'');',...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Value',1.0,...
        'Position',[400+dw,YStartAliasChkBox,wChkBox,hChkBox]);

        dow.aliastypeTxt=uicontrol('Parent',dow.fig,...
        'Style','Text',...
        'BackgroundColor',dow.defaultFrameColor,...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_AliasTypes_Widget'),...
        'Units','pixels',...
        'Visible','on',...
        'Enable','on',...
        'Position',[420+dw,YStartAliasChkBox,86,hTxtField]);



        hBottomButns=21;
        dow.Analyze=uicontrol('Parent',dow.fig,...
        'Style','pushbutton',...
        'HorizontalAlignment','Left',...
        'Callback','dow_callback(''analyze'');',...
        'String',DAStudio.message('Simulink:dow:UI_Find_Widget'),...
        'Visible','on',...
        'Units','pixels',...
        'ToolTipString',DAStudio.message('Simulink:dow:UI_Find_Tooltip'),...
        'Enable',enable,...
        'Position',[XStartFindOptsFrm,YStartBottomButns,70,hBottomButns],...
        'Value',0);


        XStartSelectAllButn=10;
        wSelectAllButn=82;
        dow.CheckAll=uicontrol('Parent',dow.fig,...
        'Style','pushbutton',...
        'HorizontalAlignment','Left',...
        'Callback','dow_callback(''checkall'');',...
        'String',DAStudio.message('Simulink:dow:UI_CheckAll_Widget'),...
        'Visible','on',...
        'Units','pixels',...
        'ToolTipString',DAStudio.message('Simulink:dow:UI_CheckAll_Tooltip'),...
        'Enable','off',...
        'Position',[XStartSelectAllButn,147,87,hBottomButns],...
        'Value',0);


        dow.UncheckAll=uicontrol('Parent',dow.fig,...
        'Style','pushbutton',...
        'HorizontalAlignment','Left',...
        'Callback','dow_callback(''uncheckall'');',...
        'String',DAStudio.message('Simulink:dow:UI_UncheckAll_Widget'),...
        'Visible','on',...
        'Units','pixels',...
        'ToolTipString',DAStudio.message('Simulink:dow:UI_UncheckAll_Tooltip'),...
        'Enable','off',...
        'Position',[XStartSelectAllButn+wSelectAllButn+8,147,110,hBottomButns],...
        'Value',0);


        dow.Create=uicontrol('Parent',dow.fig,...
        'Style','pushbutton',...
        'Callback','dow_callback(''create'');',...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_Create_Widget'),...
        'Visible','on',...
        'Units','pixels',...
        'Enable','off',...
        'ToolTipString',DAStudio.message('Simulink:dow:UI_Create_Tooltip'),...
        'Position',[XStartAppButn+WidthAppButn-70-80-80,YStartBottomButns,70,hBottomButns],...
        'Value',0);


        dow.Cancel=uicontrol('Parent',dow.fig,...
        'Style','pushbutton',...
        'Callback','dow_callback(''cancel'');',...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_Cancel_Widget'),...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'ToolTipString',DAStudio.message('Simulink:dow:UI_Cancel_Tooltip'),...
        'Position',[XStartAppButn+WidthAppButn-70-80,YStartBottomButns,70,hBottomButns],...
        'Value',0);


        dow.Help=uicontrol('Parent',dow.fig,...
        'Style','pushbutton',...
        'Callback','dow_callback(''help'');',...
        'HorizontalAlignment','Left',...
        'String',DAStudio.message('Simulink:dow:UI_Help_Widget'),...
        'Visible','on',...
        'Units','pixels',...
        'Enable','on',...
        'Position',[XStartAppButn+WidthAppButn-70,YStartBottomButns,70,hBottomButns],...
        'Value',0);

        refFrame=get(dow.frame,'Position');
        refPos=get(dow.TitleFrame1,'Position');
        dow.viewItems=round((refFrame(4)-refPos(4)-2)/dow.defaultBoxHeight);
        set(dow.fig,'Visible','on');
        set(dow.fig,'UserData',dow);

        return;
