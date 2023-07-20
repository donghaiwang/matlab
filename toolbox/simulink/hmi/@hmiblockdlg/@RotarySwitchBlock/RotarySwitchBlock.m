function this=RotarySwitchBlock(block)

    this=hmiblockdlg.RotarySwitchBlock(block);
    this.init(block);
    this.widgetType='rotaryswitchblock';
    this.propMap=containers.Map('keyType','int32','ValueType','any');
    modelName=get_param(bdroot(this.blockObj.Handle),'Name');
    initProps=utils.getDiscreteKnobInitialPropertiesStruct(modelName,this.widgetId,this.isLibWidget);
    for idx=1:length(initProps)
        this.propMap(idx)=initProps(idx);
    end
end
