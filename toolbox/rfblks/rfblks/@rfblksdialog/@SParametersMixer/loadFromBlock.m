function loadFromBlock(this)








    this.NetParamData=this.Block.NetParamData;
    this.NetParamFreq=this.Block.NetParamFreq;
    if strcmp(this.Block.MaskType,'S-Parameters Mixer')
        this.Z0=this.Block.Z0;
    else
        this.Z0='';
    end
    this.InterpMethod=this.Block.InterpMethod;
    this.MixerType=this.Block.MixerType;
    this.FLO=this.Block.FLO;


    this.NoiseDefinedBy=this.Block.NoiseDefinedBy;
    this.NF=this.Block.NF;
    this.FMIN=this.Block.FMIN;
    this.GammaOpt=this.Block.GammaOpt;
    this.RN=this.Block.RN;
    this.NFactor=this.Block.NFactor;
    this.NTemp=this.Block.NTemp;
    this.NoiseDataFreq=this.Block.NoiseDataFreq;
    this.FreqOffset=this.Block.FreqOffset;
    this.PhaseNoiseLevel=this.Block.PhaseNoiseLevel;


    this.IP3Type=this.Block.IP3Type;
    this.IIP3=this.Block.IIP3;
    this.OIP3=this.Block.OIP3;
    this.P1dB=this.Block.P1dB;
    this.PSat=this.Block.PSat;
    this.GCSat=this.Block.GCSat;
    this.NonlinearDataFreq=this.Block.NonlinearDataFreq;


    this.SourceFreq=this.Block.SourceFreq;
    this.Freq=this.Block.Freq;
    this.AllPlotType=this.Block.AllPlotType;
    this.YOption=this.Block.YOption;
    this.XOption=this.Block.XOption;
    this.PlotZ0=this.Block.PlotZ0;


