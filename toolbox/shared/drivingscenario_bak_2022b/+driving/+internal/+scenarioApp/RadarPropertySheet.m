classdef RadarPropertySheet<driving.internal.scenarioApp.SensorPropertySheet
    properties
        ShowAdvancedParameters=false;
    end

    properties(Hidden)
hShowAdvancedParameters




hFalseAlarmRate
hAzimuthFieldOfView
hElevationFieldOfView

hHasRangeRate
hRangeRateMin
hRangeRateMax
hHasOcclusion

hAdvancedParameters

hReferenceRange
hReferenceRCS

hAzimuthResolution
hAzimuthBiasFraction

hHasElevation
hElevationResolution
hElevationBiasFraction

hRangeResolution
hRangeBiasFraction

hRangeRateResolution
hRangeRateBiasFraction

hHasFalseAlarms
AdvancedParametersLayout
    end

    methods
        function this=RadarPropertySheet(dlg)
            this@driving.internal.scenarioApp.SensorPropertySheet(dlg)
        end

        function label=getTypeLabel(~)
            label=getString(message('driving:scenarioApp:RadarTypeLabel'));
        end

        function update(this)
            update@driving.internal.scenarioApp.SensorPropertySheet(this);
            sensor=getSpecification(this);
            enable=getEnable(this);
            set(this.hAzimuthFieldOfView,...
            'String',sensor.FieldOfView(1),...
            'Enable',enable);
            set(this.hElevationFieldOfView,...
            'String',sensor.FieldOfView(2),...
            'Enable',enable);
            simpleProps={'DetectionProbability','FalseAlarmRate','MaxRange','HasRangeRate','HasElevation','HasOcclusion',...
            'AzimuthResolution','AzimuthBiasFraction','RangeResolution','RangeBiasFraction',...
            'ReferenceRange','ReferenceRCS','HasNoise','HasFalseAlarms'};
            if sensor.HasRangeRate
                simpleProps=[simpleProps,{'RangeRateResolution','RangeRateBiasFraction'}];
                setupWidgets(this,sensor,{'RangeRate'},{'Min','Max'},'Limits');
            else
                set([this.hRangeRateMin,this.hRangeRateMax,this.hRangeRateResolution,this.hRangeRateBiasFraction],...
                'String','',...
                'Enable','off');
            end
            if sensor.HasElevation
                simpleProps=[simpleProps,{'ElevationResolution','ElevationBiasFraction'}];
            else
                set([this.hElevationResolution,this.hElevationBiasFraction],...
                'String','',...
                'Enable','off');
            end
            set(this.hShowAdvancedParameters,'Enable',enable);
            setupWidgets(this,sensor,simpleProps);
            updateMaxNumWidgets(this,sensor,'Detections',enable);
        end

        function updateLayout(this)

            layout=this.Layout;
            insertPanel(this,layout,'DetectionParameters',2);
            clean(layout);

            dpLayout=this.DetectionLayout;
            nextRow=insertPanel(this,dpLayout,'AdvancedParameters',9);
            insertPanel(this,dpLayout,'AccuracyNoise',nextRow+1);
            clean(dpLayout);
            setLayoutHeight(dpLayout);
        end
    end

    methods(Access=protected)

        function tags=getDetectionCoordinatesTag(~)
            tags={'Body','Sensor rectangular','Sensor spherical'};
        end

        function labels=getDetectionCoordinatesLabels(~)
            labels={...
            getString(message('driving:scenarioApp:Body'))
            getString(message('driving:scenarioApp:SensorRectangular'))
            getString(message('driving:scenarioApp:SensorSpherical'))};
        end

        function createWidgets(this)

            layoutInputs={'VerticalGap',3,'HorizontalGap',3};

            p=this.Panel;
            this.hShowDetectionParameters=createToggle(this,p,'ShowDetectionParameters');

            detectionParameters=uipanel(p,...
            'Tag','DetectionParameters',...
            'Visible','off',...
            'AutoResizeChildren','off',...
            'BorderType','none');
            this.hDetectionParameters=detectionParameters;

            dpLabel=createLabelEditPair(this,detectionParameters,'DetectionProbability',...
            'TooltipString',getString(message('driving:scenarioApp:DetectionProbabilityDescription')));
            falseAlarmLabel=createLabelEditPair(this,detectionParameters,'FalseAlarmRate',...
            'TooltipString',getString(message('driving:scenarioApp:FalseAlarmRateDescription')));
            azimuthFOVLabel=createLabelEditPair(this,detectionParameters,...
            'AzimuthFieldOfView',@this.FOVCallback,...
            'TooltipString',getString(message('driving:scenarioApp:AzimuthFieldOfViewDescription')));
            elevationFOVLabel=createLabelEditPair(this,detectionParameters,...
            'ElevationFieldOfView',@this.FOVCallback,...
            'TooltipString',getString(message('driving:scenarioApp:ElevationFieldOfViewDescription')));
            maxRangeLabel=createLabelEditPair(this,detectionParameters,'MaxRange',...
            'TooltipString',getString(message('driving:scenarioApp:MaxRangeDescription')));
            createCheckbox(this,detectionParameters,'HasRangeRate',...
            'TooltipString',getString(message('driving:scenarioApp:HasRangeRateDescription')));
            createEditbox(this,detectionParameters,'RangeRateMin',@this.rangeRateLimitsCallback,...
            'TooltipString',getString(message('driving:scenarioApp:RangeRateMinDescription')));
            rangeRateMaxLabel=createLabelEditPair(this,detectionParameters,...
            'RangeRateMax',@this.rangeRateLimitsCallback,...
            'TooltipString',getString(message('driving:scenarioApp:RangeRateMaxDescription')));

            createCheckbox(this,detectionParameters,'HasElevation',...
            'TooltipString',getString(message('driving:scenarioApp:HasElevationDescription')));
            createCheckbox(this,detectionParameters,'HasOcclusion',...
            'TooltipString',getString(message('driving:scenarioApp:HasOcclusionDescription')));

            createToggle(this,detectionParameters,'ShowAdvancedParameters');

            advancedParameters=uipanel(detectionParameters,...
            'Tag','AdvancedParameters',...
            'AutoResizeChildren','off',...
            'Visible','off',...
            'BorderType','none');
            this.hAdvancedParameters=advancedParameters;

            hReferenceRangeLabel=createLabelEditPair(this,advancedParameters,'ReferenceRange',...
            'TooltipString',getString(message('driving:scenarioApp:ReferenceRangeDescription')));
            hReferenceRCSLabel=createLabelEditPair(this,advancedParameters,'ReferenceRCS',...
            'TooltipString',getString(message('driving:scenarioApp:ReferenceRCSDescription')));
            createCheckbox(this,detectionParameters,'LimitDetections',@this.limitDetectionsCallback,...
            'TooltipString',getString(message('driving:scenarioApp:LimitDetectionsDescription')));
            createEditbox(this,detectionParameters,'MaxNumDetections');
            dcLabel=createLabelEditPair(this,detectionParameters,'DetectionCoordinates',@this.detectionCoordinatesCallback,'popupmenu',...
            'TooltipString',getString(message('driving:scenarioApp:DetectionCoordinatesDescription')));

            layout=matlabshared.application.layout.GridBagLayout(advancedParameters,...
            layoutInputs{:},'HorizontalWeights',[0,1]);
            this.AdvancedParametersLayout=layout;

            limitDetectionsWidth=layout.getMinimumWidth(this.hLimitDetections)+20;
            labelWidth=max(layout.getMinimumWidth([hReferenceRangeLabel,hReferenceRCSLabel,dcLabel]),...
            limitDetectionsWidth);
            inset=layout.LabelOffset;
            labelProps={'Anchor','West','TopInset',inset,'MinimumHeight',20-inset};
            add(layout,hReferenceRangeLabel,1,1,...
            labelProps{:},...
            'MinimumWidth',labelWidth);
            add(layout,this.hReferenceRange,1,2,...
            'Fill','Horizontal');
            add(layout,hReferenceRCSLabel,2,1,...
            labelProps{:},...
            'MinimumWidth',labelWidth)
            add(layout,this.hReferenceRCS,2,2,...
            'Fill','Horizontal');
            add(layout,this.hLimitDetections,3,1,labelProps{:},'MinimumWidth',labelWidth);
            add(layout,this.hMaxNumDetections,3,2,'Fill','Horizontal');
            add(layout,dcLabel,4,1,labelProps{:},'MinimumWidth',labelWidth);
            add(layout,this.hDetectionCoordinates,4,2,'Fill','Horizontal');
            setLayoutHeight(layout);



            this.hShowAccuracyNoise=createToggle(this,detectionParameters,'ShowAccuracyNoise');
            accuracyNoise=uipanel(detectionParameters,...
            'Tag','AccuracyNoise',...
            'Visible','off',...
            'AutoResizeChildren','off',...
            'BorderType','none');
            this.hAccuracyNoise=accuracyNoise;
            resolutionLabel=createLabel(this,accuracyNoise,'Resolution');
            biasFractionLabel=createLabel(this,accuracyNoise,'BiasFraction');

            hAzimuthResolutionLabel=createLabelEditPair(this,accuracyNoise,'AzimuthResolution',...
            'TooltipString',getString(message('driving:scenarioApp:AzimuthResolutionDescription')));
            createEditbox(this,accuracyNoise,'AzimuthBiasFraction',...
            'TooltipString',getString(message('driving:scenarioApp:AzimuthBiasFractionDescription')));
            hElevationResolutionLabel=createLabelEditPair(this,accuracyNoise,'ElevationResolution',...
            'TooltipString',getString(message('driving:scenarioApp:ElevationResolutionDescription')));
            createEditbox(this,accuracyNoise,'ElevationBiasFraction',...
            'TooltipString',getString(message('driving:scenarioApp:ElevationBiasFractionDescription')));
            hRangeResolutionLabel=createLabelEditPair(this,accuracyNoise,'RangeResolution',...
            'TooltipString',getString(message('driving:scenarioApp:RangeResolutionDescription')));
            createEditbox(this,accuracyNoise,'RangeBiasFraction',...
            'TooltipString',getString(message('driving:scenarioApp:RangeBiasFractionDescription')));
            hRangeRateResolutionLabel=createLabelEditPair(this,accuracyNoise,'RangeRateResolution',...
            'TooltipString',getString(message('driving:scenarioApp:RangeRateResolutionDescription')));
            createEditbox(this,accuracyNoise,'RangeRateBiasFraction',...
            'TooltipString',getString(message('driving:scenarioApp:RangeRateBiasFractionDescription')));

            createCheckbox(this,accuracyNoise,'HasNoise',...
            'TooltipString',getString(message('driving:scenarioApp:HasNoiseDescription')));

            createCheckbox(this,accuracyNoise,'HasFalseAlarms',...
            'TooltipString',getString(message('driving:scenarioApp:HasFalseAlarmsDescription')));

            layout=matlabshared.application.layout.GridBagLayout(accuracyNoise,...
            layoutInputs{:},'HorizontalWeights',[0,1,1]);
            this.AccuracyNoiseLayout=layout;
            labelWidth=layout.getMinimumWidth([hAzimuthResolutionLabel,hElevationResolutionLabel,hRangeResolutionLabel,hRangeRateResolutionLabel]);
            add(layout,resolutionLabel,1,2,...
            labelProps{:},...
            'BottomInset',-3,...
            'MinimumWidth',layout.getMinimumWidth(resolutionLabel));
            add(layout,biasFractionLabel,1,3,...
            labelProps{:},...
            'BottomInset',-3,...
            'MinimumWidth',layout.getMinimumWidth(biasFractionLabel));
            add(layout,hAzimuthResolutionLabel,2,1,...
            labelProps{:},'MinimumWidth',labelWidth);
            add(layout,this.hAzimuthResolution,2,2,...
            'Fill','Horizontal');
            add(layout,this.hAzimuthBiasFraction,2,3,...
            'Fill','Horizontal');
            add(layout,hElevationResolutionLabel,3,1,...
            labelProps{:},'MinimumWidth',labelWidth);
            add(layout,this.hElevationResolution,3,2,...
            'Fill','Horizontal');
            add(layout,this.hElevationBiasFraction,3,3,...
            'Fill','Horizontal');
            add(layout,hRangeResolutionLabel,4,1,...
            labelProps{:},'MinimumWidth',labelWidth);
            add(layout,this.hRangeResolution,4,2,...
            'Fill','Horizontal');
            add(layout,this.hRangeBiasFraction,4,3,...
            'Fill','Horizontal');
            add(layout,hRangeRateResolutionLabel,5,1,...
            labelProps{:},'MinimumWidth',labelWidth);
            add(layout,this.hRangeRateResolution,5,2,...
            'Fill','Horizontal');
            add(layout,this.hRangeRateBiasFraction,5,3,...
            'Fill','Horizontal');
            add(layout,this.hHasNoise,6,[1,2],...
            'Anchor','West',...
            'MinimumWidth',layout.getMinimumWidth(this.hHasNoise)+20);
            add(layout,this.hHasFalseAlarms,7,[1,2],...
            'Anchor','West',...
            'MinimumWidth',layout.getMinimumWidth(this.hHasFalseAlarms)+20);
            setLayoutHeight(layout);

            layout=matlabshared.application.layout.GridBagLayout(detectionParameters,...
            layoutInputs{:},'HorizontalWeights',[0,1,0,1]);
            this.DetectionLayout=layout;

            labelWidth1=layout.getMinimumWidth([dpLabel,falseAlarmLabel...
            ,azimuthFOVLabel,this.hHasRangeRate]);
            labelWidth2=layout.getMinimumWidth([elevationFOVLabel,rangeRateMaxLabel]);

            add(layout,dpLabel,1,1,...
            'MinimumWidth',labelWidth1,labelProps{:});
            add(layout,this.hDetectionProbability,1,2,...
            'Fill','Horizontal');
            add(layout,falseAlarmLabel,2,1,...
            'MinimumWidth',labelWidth1,labelProps{:});
            add(layout,this.hFalseAlarmRate,2,2,...
            'Fill','Horizontal');
            add(layout,azimuthFOVLabel,3,1,...
            'MinimumWidth',labelWidth1,labelProps{:});
            add(layout,this.hAzimuthFieldOfView,3,2,...
            'Fill','Horizontal');
            add(layout,elevationFOVLabel,3,3,...
            'MinimumWidth',labelWidth2,labelProps{:});
            add(layout,this.hElevationFieldOfView,3,4,...
            'Fill','Horizontal');
            add(layout,maxRangeLabel,4,1,...
            'MinimumWidth',labelWidth1,labelProps{:});
            add(layout,this.hMaxRange,4,2,...
            'Fill','Horizontal');
            add(layout,this.hHasRangeRate,5,1,...
            'MinimumWidth',labelWidth1,labelProps{:});
            add(layout,this.hRangeRateMin,5,2,...
            'Fill','Horizontal');
            add(layout,rangeRateMaxLabel,5,3,...
            'MinimumWidth',labelWidth2,labelProps{:});
            add(layout,this.hRangeRateMax,5,4,...
            'Fill','Horizontal');
            add(layout,this.hHasElevation,6,[1,4],...
            'Fill','Horizontal');
            add(layout,this.hHasOcclusion,7,[1,4],...
            'Fill','Horizontal');
            add(layout,this.hShowAdvancedParameters,8,[1,4],...
            'Fill','Horizontal');
            add(layout,this.hShowAccuracyNoise,9,[1,4],...
            'Fill','Horizontal');
            setLayoutHeight(layout);

            layout=matlabshared.application.layout.GridBagLayout(p,...
            layoutInputs{:},'VerticalWeights',[0,1]);
            layout.add(this.hShowDetectionParameters,1,1,...
            'Fill','Horizontal');
            this.Layout=layout;

        end
        function FOVCallback(this,~,~)
            setVectorProperty(this,'FieldOfView','hAzimuthFieldOfView','hElevationFieldOfView');
        end

        function rangeRateLimitsCallback(this,~,~)
            setVectorProperty(this,'RangeRateLimits','hRangeRateMin','hRangeRateMax');
        end
    end
end


