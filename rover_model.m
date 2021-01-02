function xdot = RoverModel(x,dV)

    global VD L R Kt Ke bs Jm Jw KC KD VT KH KS KV KY Rw Rm Gc KI 
    
    FL = (2*Kt/Rw)*x(6);
    FR = (2*Kt/Rw)*x(9);
   
    VinL = VD + dV;
    VinR = VD - dV;
   
    %v,r,psi
    xdot(1,1) = (KV*(FL + FR)*(x(1)/VT))-KS*x(1)+VT*x(2); 
    xdot(2,1) = KD*x(1)-VT*x(2)+KY*(FL-FR)*Rm;
    xdot(3,1) = x(2); 
    %motor speed,wheel speed,current (Left)
    xdot(4,1) = (Kt*x(6)-bs*(x(4)-x(5)))/Jm; 
    xdot(5,1) =  bs*(x(4)-x(5))/Jw;
    xdot(6,1) = (VinL-R*x(6)-Ke*x(4))/L ;
    %motor speed,wheel speed,current (Right)
    xdot(7,1) = (Kt*x(9)-bs*(x(7)-x(8)))/Jm; 
    xdot(8,1) =  bs*(x(7)-x(8))/Jw;
    xdot(9,1) = (VinR-R*x(9)-Ke*x(7))/L;
end