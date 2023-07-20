function[X,Y]=ThreeLevelBridgeIcon(Device)






    switch Device
    case 1;
        X.p1=[50,30,70,50,30,70,50,50];
        Y.p1=[60,30,30,60,60,60,60,90];
        X.p2=[50,50];
        Y.p2=[10,30];
        X.p3=0;
        Y.p3=0;
        X.p4=0;
        Y.p4=0;
        X.p5=0;
        Y.p5=0;
        X.p6=0;
        Y.p6=0;
        X.p7=0;
        Y.p7=0;
    case 2;
        X.p1=[50,30,70,50,30,70,50,50];
        Y.p1=[60,30,30,60,60,60,60,90];
        X.p2=[50,50];
        Y.p2=[10,30];
        X.p3=[20,35,50];
        Y.p3=[75,75,60];
        X.p4=0;
        Y.p4=0;
        X.p5=0;
        Y.p5=0;
        X.p6=0;
        Y.p6=0;
        X.p7=0;
        Y.p7=0;
    case 3;
        Icon='plot(0,0,100,100,[40 28 52 40 24 52 40 40],[40 60 60 40 40 40 40 10],[40,40],[90,60],[16 28 40],[25,25,40],[21.6 35.2],[25,40],[65 57 73 65 57 73 65 65],[54 42 42 54 54 54 54 66],[40 65 65],[24 24 42],[65 65 40],[66,76,76]);';
        X.p1=[40,28,52,40,24,52,40,40];
        Y.p1=[40,60,60,40,40,40,40,10];
        X.p2=[40,40];
        Y.p2=[90,60];
        X.p3=[16,28,40];
        Y.p3=[25,25,40];
        X.p4=[21.6,35.2];
        Y.p4=[25,40];
        X.p5=[65,57,73,65,57,73,65,65];
        Y.p5=[54,42,42,54,54,54,54,66];
        X.p6=[40,65,65];
        Y.p6=[24,24,42];
        X.p7=[65,65,40];
        Y.p7=[66,76,76];
    case 4;
        Icon=['plot(0,0,100,100,[36 36 20.8],[75.6 24.4 24.4],[44 44 44 56 56],[22 36.4 29.2 29.2 6.4],[44 44 44 48 48 44 56 56],[56.4 42 49.2 44.4 54 49.2 49.2 29.2],[44 44 44 56 56],[76.4 62.8 70 70 96],[65 57 73 65 57 73 65 65]+10,[54 42 42 54 54 54 54 66],[46 65 65]+10,[24 24 42],[65 65 46]+10,[66,76,76])'];

        X.p1=[36,36,20.8];
        Y.p1=[75.6,24.4,24.4];
        X.p2=[44,44,44,56,56];
        Y.p2=[22,36.4,29.2,29.2,6.4];
        X.p3=[44,44,44,48,48,44,56,56];
        Y.p3=[56.4,42,49.2,44.4,54,49.2,49.2,29.2];
        X.p4=[44,44,44,56,56];
        Y.p4=[76.4,62.8,70,70,96];
        X.p5=[65,57,73,65,57,73,65,65]+10;
        Y.p5=[54,42,42,54,54,54,54,66];
        X.p6=[46,65,65]+10;
        Y.p6=[24,24,42];
        X.p7=[65,65,46]+10;
        Y.p7=[66,76,76];
    case 5;
        Icon=['plot(0,0,100,100,[39 39 23.8],[71 28 28],[44 56 49.6 56 52.8 56 61 61],[39.2 33.6 32.8 33.6 40.8 33.6 30 12.4],[44 44 44 61 61],[28 71 60 66.4 90],[75 67 83 75 67 83 75 75],[54 42 42 54 54 54 54 66],[61 75 75],[24 24 42],[75 75 61],[66,76,76])'];
        X.p1=[39,39,23.8];
        Y.p1=[71,28,28];
        X.p2=[44,56,49.6,56,52.8,56,61,61];
        Y.p2=[39.2,33.6,32.8,33.6,40.8,33.6,30,12.4];
        X.p3=[44,44,44,61,61];
        Y.p3=[28,71,60,66.4,90];
        X.p4=[75,67,83,75,67,83,75,75];
        Y.p4=[54,42,42,54,54,54,54,66];
        X.p5=[61,75,75];
        Y.p5=[24,24,42];
        X.p6=[75,75,61];
        Y.p6=[66,76,76];
        X.p7=0;
        Y.p7=0;
    case 6;
        Icon='plot(-100,-100,100,100,[0,0,30],[70,30,0],[0,0],[-10,-70])';
        X.p1=[0,0,30]+100;
        Y.p1=[70,30,0]+100;
        X.p2=[0,0]+100;
        Y.p2=[-10,-70]+100;
        X.p3=0;
        Y.p3=0;
        X.p4=0;
        Y.p4=0;
        X.p5=0;
        Y.p5=0;
        X.p6=0;
        Y.p6=0;
        X.p7=0;
        Y.p7=0;
    end