%INITIAL
clear all 
clc;

global VD L R Kt Ke bs Jm Jw KC KD KH KS KV KY Rw Rm Gc KI VT 

%Define Model Parameters
VD = 2; %V
L = 0.1; %H
R = 4; %Ohms
Kt = 0.35; %Nm/A
Ke = 0.35; %V/rad/s
bs = 0.03; %Nm/rad/s
Jm = 0.003;%kgm2
Jw = 0.001; %kgm2
KC = 2.5;
KD = 18.14;
KH = 2.1;
KS = 9.81;
KV = 0.466;
KY = 29.94;
Rw = 0.064; %m
Rm = 0.124; %m


%Initial conditions of inputs
integ = 0;
psiref = 40 *(pi/180); %radians
psio = -15*(pi/180);
ro = 0; %rad/s
vo = 0; %m/s
% Gc = 7.5;
% KI = 0.1;
 Gc = 0.9;
 KI = 1.2;

% Initial states and state derivatives
x = [0,0,psio,0,0,0,0,0,0]'; % Define Initial Model States
xdot = [0,0,0,0,0,0,0,0,0]'; % Define Initial Model State Derivatives


% Parameters for the simulation
stepsize = 0.001; % Simulation step size
comminterval = 0.001; % Communications interval
EndTime = 10; % Simulation End Time
i = 0; % Initialise counter for data storage
% VT = 0.5;
t = [0, 2.1,4.6,6.3,8.5,10.0];
Vt_data = [0.5,0.7,0.9,0.8,1.0,1.2];
f = newtondivdif(Vt_data,t);

    
%DYNAMIC 
for time = 0:stepsize:EndTime
    
    if rem(time,comminterval)==0
        i = i + 1; 
        tout(i) = time;
        xout(i,:) = x;			% store states
        xdout(i,:) = xdot;
    end
    
    %CONTROL
     dpsi = (psiref*KC-x(3)*KH);
     %dV = Gc*dpsi;
     integ = integ + stepsize*(dpsi*Gc*KI);
     dV = Gc*dpsi + integ;  
     VT = f(time);
     vtout(i,:) = VT;
    
    %DERIVATIVE
    xdot = RoverModel(x,dV);
    
    %INTEGRATE
    x = RungeKatta('RoverModel', stepsize, x,dV);
    
end

%TERMINAL
figure(1) 
plot(tout,vtout(:,1)) 
title('VT'), grid on, xlabel('Time [s]'),ylabel('Forward Velocity (m/s)')

figure(2)
clf
subplot(3,3,1)
plot(tout,xout(:,1))        %v (sway velocity)
title('v'), grid on, xlabel('Time (s)'),ylabel('Sway velocity(m/s)')

subplot(3,3,2)
plot(tout,xout(:,2))        %r (yaw rate)
title('r'), grid on, xlabel('Time (s)'),ylabel('Yaw Rate (rad/s)')

subplot(3,3,3)
plot(tout,xout(:,3))        %psi (yaw angle)
title('psi'), grid on, xlabel('Time (s)'),ylabel('Yaw Angle(rad)')

subplot(3,3,4)
plot(tout,xout(:,4))        %omega motor left
title('omegamL'), grid on, xlabel('Time (s)'),ylabel('Omega (rad/s)')

subplot(3,3,5)
plot(tout,xout(:,5))        %omega wheel left 
title('omegawL'), grid on, xlabel('Time (s)'),ylabel('Omega(rad/s)')

subplot(3,3,6)
plot(tout,xout(:,6))        %current left
title('iL'), grid on, xlabel('Time (s)'),ylabel('Current(A)')

subplot(3,3,7)
plot(tout,xout(:,7))        %omega motor right
title('omegamR'), grid on, xlabel('Time (s)'),ylabel('Omega (rad/s)')

subplot(3,3,8)
plot(tout,xout(:,8))        %omega wheel right 
title('omegawR'), grid on, xlabel('Time (s)'),ylabel('Omega (rad/s)')

subplot(3,3,9)
plot(tout,xout(:,9))        %current right 
title('iR'), grid on, xlabel('Time (s)'),ylabel('Current(A)')



