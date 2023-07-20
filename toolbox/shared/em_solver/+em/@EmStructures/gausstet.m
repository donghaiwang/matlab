function[coeff,weights,IndexT]=gausstet(arg1,arg2)






    nargs=nargin;











    if arg1==1
        coeff(:,1)=[1/4,1/4,1/4,1/4]';
        weights(1)=1;
    end

    if(arg1==4)&&(arg2==2)
        a1=0.58541020;
        b1=0.13819660;
        coeff(:,1)=[a1,b1,b1,b1]';
        coeff(:,2)=[b1,a1,b1,b1]';
        coeff(:,3)=[b1,b1,a1,b1]';
        coeff(:,4)=[b1,b1,b1,a1]';
        weights(1)=0.25;
        weights(2)=0.25;
        weights(3)=0.25;
        weights(4)=0.25;
    end

















    if(arg1==5)&&(arg2==3)
        a1=1/2;
        b1=1/6;
        coeff(:,1)=[1/4,1/4,1/4,1/4]';
        coeff(:,2)=[a1,b1,b1,b1]';
        coeff(:,3)=[b1,a1,b1,b1]';
        coeff(:,4)=[b1,b1,a1,b1]';
        coeff(:,5)=[b1,b1,b1,a1]';
        weights(1)=-4/5;
        weights(2)=9/20;
        weights(3)=9/20;
        weights(4)=9/20;
        weights(5)=9/20;
    end




























































































































































































































































































































































    IndexT=size(coeff,2);

end