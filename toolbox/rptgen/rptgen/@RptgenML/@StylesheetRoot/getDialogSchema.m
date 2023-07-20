function dlgStruct=getDialogSchema(this,name)




    descPanelContent{1}=this.dlgText(...
    getString(message('rptgen:RptgenML_StylesheetRoot:stylesheetEditorDescriptionLabel')),...
    'WordWrap',true,...
    'RowSpan',[1,1],...
    'ColSpan',[1,2]);





    ssNew={
    '-NEW_HTML',getString(message('rptgen:RptgenML_StylesheetRoot:newHTMLLabel')),getString(message('rptgen:RptgenML_StylesheetRoot:customHTMLLabel'))
    '-NEW_HTML_CHUNKED',getString(message('rptgen:RptgenML_StylesheetRoot:newMultipageHTMLLabel')),getString(message('rptgen:RptgenML_StylesheetRoot:customMultiHTMLLabel'))
    '-NEW_FO',getString(message('rptgen:RptgenML_StylesheetRoot:newFOLabel')),getString(message('rptgen:RptgenML_StylesheetRoot:customFOLabel'))
    '-NEW_DSSSL',getString(message('rptgen:RptgenML_StylesheetRoot:newDSSSLLabel')),getString(message('rptgen:RptgenML_StylesheetRoot:customDSSSLLabel'))
    };




    stylesheetCount=size(ssNew,1);
    for i=1:stylesheetCount
        cbk=['rpteditstyle(''',ssNew{i,1},''');'];

        descPanelContent=[descPanelContent;{
        struct('Type','pushbutton',...
        'FilePath',fullfile(matlabroot,'toolbox/rptgen/resources/Stylesheet.png'),...
        'MatlabMethod',cbk,...
        'RowSpan',[i+1,i+1],...
        'ToolTip',ssNew{i,2},...
        'ColSpan',[1,1])
        struct('Type','hyperlink',...
        'Name',ssNew{i,2},...
        'MatlabMethod',cbk,...
        'ToolTip',ssNew{i,3},...
        'RowSpan',[i+1,i+1],...
        'ColSpan',[2,2])
        }];%#ok<AGROW>
    end

    dlgStruct=this.dlgMain(name,{
    this.dlgContainer(descPanelContent,...
    getString(message('rptgen:RptgenML_StylesheetRoot:gettingStartedLabel')),...
    'RowSpan',[1,1],...
    'ColSpan',[1,1],...
    'LayoutGrid',[stylesheetCount+1,2],...
    'ColStretch',[0,1])
    RptgenML.dlgChildContainer(this,getString(message('rptgen:RptgenML_StylesheetRoot:openStylesheetsLabel')),...
    'RowSpan',[2,2],...
    'ColSpan',[1,1]),...
    },'DialogTitle',getString(message('rptgen:RptgenML_StylesheetRoot:stylesheetEditorLabel')));



