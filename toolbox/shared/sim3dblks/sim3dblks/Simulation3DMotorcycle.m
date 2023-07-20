classdef Simulation3DMotorcycle<Simulation3DActor&Simulation3DHandleMap


    properties
        Translation(4,3)double{mustBeFinite,mustBeReal,mustBeNonmissing}=zeros(4,3);
        Rotation(4,3)double{mustBeFinite,mustBeReal,mustBeNonmissing}=zeros(4,3);
        Scale(:,3)double{mustBeFinite,mustBeReal,mustBeNonmissing}=ones(4,3);
    end
    properties(Nontunable)

        Mesh='Sports bike';

        MotorcycleColor='Red';

        ActorTag='SimulinkVehicle1';

        EnableLightControls=false;

        HeadlightOrientation=[0,0];

        HeadlightLocation=[0,0,0];

        HeadligtColor=[1,1,1];

        TaillightColor=[1,0,0];

        BrakelightColor=[1,0,0];

        SignallightColor=[1,0.146,0];

        HighBeamIntensity=100000;

        LowBeamIntensity=60000;

        AttenuationRadius=10000;

        HighBeamRadius=70;

        LowBeamRadius=70;

        BrakelightIntensity=500;

        IndicatorlightIntensity=500;

        MatPath='/MathWorksSimulation/VehicleCommon/Materials/Lights/M_VehicleMatLight.M_VehicleMatLight';
    end
    properties(Hidden,Constant)
        MeshSet=matlab.system.internal.MessageCatalogSet({'shared_sim3dblks:sim3dblkMotorcycle:sports',...
        'shared_sim3dblks:sim3dblkMotorcycle:economy',...
        'shared_sim3dblks:sim3dblkMotorcycle:scooter'});
        MotorcycleColorSet=matlab.system.internal.MessageCatalogSet({'shared_sim3dblks:sim3dblkMotorcycle:red',...
        'shared_sim3dblks:sim3dblkMotorcycle:orange',...
        'shared_sim3dblks:sim3dblkMotorcycle:yellow',...
        'shared_sim3dblks:sim3dblkMotorcycle:blue',...
        'shared_sim3dblks:sim3dblkMotorcycle:green',...
        'shared_sim3dblks:sim3dblkMotorcycle:white',...
        'shared_sim3dblks:sim3dblkMotorcycle:black',...
        'shared_sim3dblks:sim3dblkMotorcycle:silver'});
    end
    properties(Access=private)
        VehObj;
        VehicleType;
        ActorColor;
        LightConfiguration;
        ModelName=[];
    end
    methods(Access=protected)
        function setupImpl(self)
            setupImpl@Simulation3DActor(self);
            self.VehicleType=sim3d.utils.internal.StringMap.fwd(self.Mesh);
            self.ActorColor=lower(self.MotorcycleColor);
            self.LightConfiguration={};
            if self.EnableLightControls
                self.LightConfiguration=self.generateLightsConfig();
            end
            self.VehObj=sim3d.auto.Motorcycle(self.ActorTag,self.VehicleType,...
            'Color',self.ActorColor,...
            'Translation',self.Translation,...
            'Rotation',self.Rotation,...
            'LightConfiguration',self.LightConfiguration);
            self.VehObj.setup();
            self.VehObj.reset();
            self.ModelName=['Simulation3DMotorcycle/',self.ActorTag];
            if self.loadflag
                self.Sim3dSetGetHandle([self.ModelName,'/VehObj'],self.VehObj);
            end
        end
        function stepImpl(self,translation,rotation,LightStates)

            translation(:,3)=-translation(:,3);
            rotation=[fliplr(rotation(:,1:2)),rotation(:,3)];
            if coder.target('MATLAB')
                if~isempty(self.VehObj)
                    if(self.EnableLightControls)
                        self.VehObj.LightModule.setVehicleLightStatesArray(sim3d.vehicle.VehicleLightingModule.MotorcycleLightCategories,[LightStates;0;LightStates(1)||LightStates(2)]);
                    end
                    self.VehObj.writeTransform(single(translation),single(rotation),single(self.VehObj.getScale()));
                    self.VehObj.writeConfig();
                end
            end
        end
        function releaseImpl(self)
            simulationStatus=get_param(bdroot,'SimulationStatus');
            if strcmp(simulationStatus,'terminating')
                if coder.target('MATLAB')
                    if~isempty(self.VehObj)
                        self.VehObj.delete();
                        self.VehObj=[];
                        if self.loadflag
                            self.Sim3dSetGetHandle([self.ModelName,'/VehObj'],[]);
                        end
                    end
                end
            end
        end
        function resetImpl(~)

        end
        function loadObjectImpl(self,s,wasInUse)
            self.VehicleType=s.VehicleType;
            self.ActorColor=s.ActorColor;
            self.Translation=s.Translation;
            self.Rotation=s.Rotation;
            self.Mesh=s.Mesh;
            self.MotorcycleColor=s.MotorcycleColor;
            self.ActorTag=s.ActorTag;
            self.ModelName=s.ModelName;
            self.LightConfiguration=s.LightConfiguration;
            if self.loadflag
                self.VehObj=self.Sim3dSetGetHandle([self.ModelName,'/VehObj']);
            else
                self.VehObj=s.VehObj;
            end
            loadObjectImpl@Simulation3DActor(self,s,wasInUse);
        end

        function s=saveObjectImpl(self)
            s=saveObjectImpl@Simulation3DActor(self);
            s.VehObj=self.VehObj;
            s.VehicleType=self.VehicleType;
            s.ActorColor=self.ActorColor;
            s.Translation=self.Translation;
            s.Rotation=self.Rotation;
            s.Mesh=self.Mesh;
            s.MotorcycleColor=self.MotorcycleColor;
            s.ActorTag=self.ActorTag;
            s.ModelName=self.ModelName;
            s.LightConfiguration=self.LightConfiguration;
        end
        function icon=getIconImpl(~)
            icon={'Motorcycle'};
        end
        function[nrows,ncols]=getInputPortSize(~)

            nrows=4;
            ncols=3;
        end

        function validateInputsImpl(self,translation,rotation,LightStates)
            [nrows,ncols]=getInputPortSize(self);
            translationSize=size(translation);
            rotationSize=size(rotation);
            lightstatesSize=size(LightStates);
            if(~isequal(translationSize,[nrows,ncols]))
                error(message('shared_sim3dblks:sim3dsharederrAutoIcon:invalidTranslationSize',nrows,ncols));
            end
            if(~isequal(rotationSize,[nrows,ncols]))
                error(message('shared_sim3dblks:sim3dsharederrAutoIcon:invalidRotationSize',nrows,ncols));
            end
            if(~isequal(lightstatesSize,[5,1]))
                error(message('shared_sim3dblks:sim3dsharederrAutoIcon:invalidLightStatesSize',lightstatesSize(1),lightstatesSize(2)));
            end
        end
    end
    methods(Access=public)
        function[Transformation,Rotation,Scale]=getPosition(self)
            [Transformation,Rotation,Scale]=self.VehObj.readTransform();
        end
    end

    methods(Access=private)
        function LightConfiguration=generateLightsConfig(self)
            LightConfiguration={};
            if(~self.EnableLightControls)
                return;
            end
            self.ApplyCoordinateTransformToLightParams();
            if self.VehicleType=="MotorBike"
                HighBeam=struct(...
                'LightType','Spotlight',...
                'Category',"HighBeams",...
                'LightName','HB',...
                'LightColor',self.HeadligtColor,...
                'Intensity',self.HighBeamIntensity,...
                'SocketName','Lights_Headlights',...
                'RelativeTransform',[self.HeadlightOrientation,0,self.HeadlightLocation]+[60,90,0,0,0,0],...
                'AttenuationRadius',self.AttenuationRadius,...
                'InnerConeAngle',self.HighBeamRadius,...
                'OuterConeAngle',self.HighBeamRadius+10,...
                'ReverseState',false);
                HeadlightMat=struct(...
                'LightType',"MatLight",...
                'Category',"HighBeams",...
                'MatPath',self.MatPath,...
                'MatSlotName','M_LightHeadlight',...
                'ParamName','LightOn',...
                'ParamOn',5000,...
                'ParamOff',0,...
                'LightColor',self.HeadligtColor,...
                'ReverseState',false);
                BrakeLight=struct(...
                'LightType',"MatLight",...
                'Category',"BrakeLights",...
                'MatPath',self.MatPath,...
                'MatSlotName','M_LightBrake',...
                'ParamName','LightOn',...
                'ParamOn',self.BrakelightIntensity,...
                'ParamOff',0,...
                'LightColor',self.BrakelightColor,...
                'ReverseState',false);
                LeftSignal=struct(...
                'LightType',"MatLight",...
                'Category',"LeftSignals",...
                'MatPath',self.MatPath,...
                'MatSlotName','M_Indicator_L',...
                'ParamName','LightOn',...
                'ParamOn',self.IndicatorlightIntensity,...
                'ParamOff',0,...
                'LightColor',self.SignallightColor,...
                'ReverseState',false);
                RightSignal=struct(...
                'LightType',"MatLight",...
                'Category',"RightSignals",...
                'MatPath',self.MatPath,...
                'MatSlotName','M_Indicator_R',...
                'ParamName','LightOn',...
                'ParamOn',self.IndicatorlightIntensity,...
                'ParamOff',0,...
                'LightColor',self.SignallightColor,...
                'ReverseState',false);
                LightConfiguration={HighBeam,HeadlightMat,BrakeLight,LeftSignal,RightSignal};
            elseif self.VehicleType=="SportsBike"||self.VehicleType=="Scooter"
                HighBeam=struct(...
                'LightType','Spotlight',...
                'Category',"HighBeams",...
                'LightName','HB',...
                'LightColor',self.HeadligtColor,...
                'Intensity',self.HighBeamIntensity,...
                'SocketName','Lights_Headlights',...
                'RelativeTransform',[self.HeadlightOrientation,0,self.HeadlightLocation],...
                'AttenuationRadius',self.AttenuationRadius,...
                'InnerConeAngle',self.HighBeamRadius,...
                'OuterConeAngle',self.HighBeamRadius+10,...
                'ReverseState',false);
                HeadlightMat=struct(...
                'LightType',"MatLight",...
                'Category',"HighBeams",...
                'MatPath',self.MatPath,...
                'MatSlotName','M_LightHeadlight',...
                'ParamName','LightOn',...
                'ParamOn',5000,...
                'ParamOff',0,...
                'LightColor',self.HeadligtColor,...
                'ReverseState',false);
                BrakeLight=struct(...
                'LightType',"MatLight",...
                'Category',"BrakeLights",...
                'MatPath',self.MatPath,...
                'MatSlotName','M_LightBrake',...
                'ParamName','LightOn',...
                'ParamOn',self.BrakelightIntensity,...
                'ParamOff',0,...
                'LightColor',self.BrakelightColor,...
                'ReverseState',false);
                LeftSignal=struct(...
                'LightType',"MatLight",...
                'Category',"LeftSignals",...
                'MatPath',self.MatPath,...
                'MatSlotName','M_Indicator_L',...
                'ParamName','LightOn',...
                'ParamOn',self.IndicatorlightIntensity,...
                'ParamOff',0,...
                'LightColor',self.SignallightColor,...
                'ReverseState',false);
                RightSignal=struct(...
                'LightType',"MatLight",...
                'Category',"RightSignals",...
                'MatPath',self.MatPath,...
                'MatSlotName','M_Indicator_R',...
                'ParamName','LightOn',...
                'ParamOn',self.IndicatorlightIntensity,...
                'ParamOff',0,...
                'LightColor',self.SignallightColor,...
                'ReverseState',false);
                LightConfiguration={HighBeam,HeadlightMat,BrakeLight,LeftSignal,RightSignal};
            end
        end

        function ApplyCoordinateTransformToLightParams(self)
            self.HeadlightOrientation=rad2deg(self.HeadlightOrientation);
            self.HighBeamRadius=rad2deg(self.HighBeamRadius);
            self.LowBeamRadius=rad2deg(self.LowBeamRadius);
        end
    end
end