function[X,Y]=SwitchesIcon(varargin)







    Device=varargin{1};
    Rs=varargin{3};
    Cs=varargin{4};

    if isempty(Rs)
        Rs=Inf;
    end
    if isempty(Cs)
        Cs=0;
    end
    if(Rs==Inf)||(Cs==0)
        s=0;
    else
        s=1;
    end

    switch Device

    case 'Diode'

        X.p1=-75;
        Y.p1=-50;
        X.p2=100;
        Y.p2=150;
        X.p3=[-15,-15,43,-15,-15,-75];
        Y.p3=[50,8,50,92,50,50];
        X.p4=[43,43];
        Y.p4=[8,94];
        X.p5=[100,43];
        Y.p5=[50,50];
        X.p6=s*[-65,-65,-20,-20,40,40,85,85,85,40,40,-20,-20];
        Y.p6=s*[50,-20,-20,-10,-10,-20,-20,50,-20,-20,-30,-30,-20];

    case{'Thyristor','Detailed Thyristor'}

        X.p1=-100;
        Y.p1=-50;
        X.p2=120;
        Y.p2=110;
        X.p3=2*[-30,-30,0,-30,-30,-55]+25;
        Y.p3=(2*[20,0,20,41,20,20]+8);
        X.p4=[0,0]+25;
        Y.p4=(2*[0,40]+8);
        X.p5=2*[37.5,0]+25;
        Y.p5=(2*[20,20]+8);
        X.p6=2*[10,10,0]+25;
        Y.p6=(1*[-15,6,20]+12);
        X.p7=s*[-65,-65,-20,-20,40,40,85,85,85,40,40,-20,-20];
        Y.p7=s*[48,-20,-20,-10,-10,-20,-20,48,-20,-20,-30,-30,-20];

    case 'GTO'

        X.p1=-140;
        Y.p1=-60;
        X.p2=140;
        Y.p2=100;
        X.p3=2*[-30,-30,0,-30,-30,-60]+25;
        Y.p3=(2*[20,0,20,41,20,20]+8);
        X.p4=[0,0]+25;
        Y.p4=(2*[0,40]+8);
        X.p5=2*[35,0]+25;
        Y.p5=(2*[20,20]+8);
        X.p6=2*[10,10,0]+25;
        Y.p6=(2*[-15,6,20]+8);
        X.p7=[20,0]+35;
        Y.p7=[-8,-8];
        X.p8=s*[-75,-75,-20,-20,20,20,75,75,75,20,20,-20,-20];
        Y.p8=s*([78,0,0,10,10,0,0,78,0,0,-10,-10,0]-30);

    case 'IGBT'

        X.p1=-15;
        Y.p1=-100;
        X.p2=115;
        Y.p2=0;
        X.p3=[50,50,35,65];
        Y.p3=[0,-40,-40,-40];
        X.p4=[3,19,35,18,80,60,76,97];
        Y.p4=-[80,80,50,50,50,50,80,80];
        X.p5=[73,78,63,73];
        Y.p5=-[75,65,72,75];
        X.p6=s*([-75,-75,-20,-20,20,20,75,75,75,20,20,-20,-20]*.45+50);
        Y.p6=-s*([0,50,50,60,60,50,50,0,50,50,40,40,50]*.4+65)-15;

    case 'MOSFET'

        X.p1=-15;
        Y.p1=-110;
        X.p2=115;
        Y.p2=0;
        X.p3=[50,50,15,85];
        Y.p3=-[0,30,30,30]-5;
        X.p4=[60,30,45,38,52,45,45,75,75,70,80,75,75,100]+5;
        Y.p4=-[20,20,20,29,29,20,50,50,20,20,20,20,50,50]*1.3-20;
        X.p5=[39,26,32,32,5]-10;
        Y.p5=-[20,20,20,50,50]*1.3-20;
        X.p6=[22,22,42];
        Y.p6=[-80,-95,-95]-6;
        X.p7=[42,54,54,42,42,42,42];
        Y.p7=[-95,-80,-110,-95,-80,-110,-95]*.7-35;
        X.p8=[54,80,80];
        Y.p8=[-95,-95,-80]-6;

    case 'IGBT/Diode'

        X.p1=-15;
        Y.p1=-110;
        X.p2=115;
        Y.p2=0;
        X.p3=[50,50,35,65];
        Y.p3=[0,-40,-40,-40];
        X.p4=[3,19,35,18,80,60,76,97];
        Y.p4=-[80,80,50,50,50,50,80,80];
        X.p5=[73,78,63,73];
        Y.p5=-[75,65,72,75];
        X.p6=[10,10,42];
        Y.p6=[-81,-95,-95];
        X.p7=[42,54,54,42,42,42,42];
        Y.p7=[-95,-80,-110,-95,-80,-110,-95];
        X.p8=[54,90,90];
        Y.p8=[-95,-95,-81];

    case 'Ideal Switch'

        X.p1=-120;
        Y.p1=-40;
        X.p2=120;
        Y.p2=140;
        X.p3=[-100,-30,5];
        Y.p3=[50,50,95];
        X.p4=[20,100];
        Y.p4=[50,50];
        X.p5=s*[-75,-75,-20,-20,20,20,75,75,75,20,20,-20,-20];
        Y.p5=s*[50,0,0,10,10,0,0,50,0,0,-10,-10,0];

    case 'Breaker'

        External=varargin{8};
        if External
            X.p1=0;
            X.p2=100;
        else
            X.p1=15;
            X.p2=85;
        end

        Y.p1=25;
        Y.p2=75;
        X.p3=[15,15,25,25,15];
        Y.p3=[55,45,45,55,55];
        X.p4=[75,75,85,85,75];
        Y.p4=[55,45,45,55,55];
        X.p5=[25,75];

        InitialState=varargin{6};
        if isempty(InitialState)
            InitialState=0;
        end
        if InitialState
            Y.p5=[50,50];
        else
            Y.p5=[50,75];
        end

        if s
            X.p6=[20,20,40,40,60,60,80,80,80,60,60,40,40];
            Y.p6=[45,30,30,35,35,30,30,45,30,30,25,25,30];
        else
            X.p6=50;
            Y.p6=50;
        end

    end