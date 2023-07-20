function this=init(this,varargin)






    this.isVHDL=hdlgetparameter('isvhdl');
    this.isVerilog=hdlgetparameter('isverilog');

    this.hasAsyncReset=hdlgetparameter('async_reset');
    this.hasSyncReset=logical(1-double(this.hasAsyncReset));
    this.resetAssertedLevel=hdlgetparameter('reset_asserted_level');
    this.hasClockEnable=true;
    this.hasNegEdgeClock=hdlgetparameter('clockedge')==1;
    this.useClockRisingEdge=hdlgetparameter('clockedgestyle');

    hdl.setpvpairs(this,varargin{:});


    if isempty(this.clock)
        this.clock=hdlgetcurrentclock;
    end
    if isempty(this.clockenable)
        this.clockenable=hdlgetcurrentclockenable;
    end
    if isempty(this.reset)
        this.reset=hdlgetcurrentreset;
    end

    if isempty(this.processName)
        this.processName=hdluniqueprocessname;
    end

    if isempty(this.resetvalues)
        this.resetvalues=0;
    end

