clear all
close all
clc
%% Import Data and Reshape Data
data = readmatrix("p1data.xlsx");
x = data(:,1)'; %Input
y = data(:,2)'; %Output
nin = 1; %Number of input
nout = 1; %Number of output
r2 = 2;
r3 = 3; %Dimensions of reduced model
r4 = 4; %Dimensions of reduced model
r5 = 5;
nr = 10; %Effective system order

%% Compute Ideal Simulation from OKID
[H,M] = OKID(y(1:150),x(1:150),nr);

%% Compute ERA from impulse response
mco = floor((length(H)-1)/2);
[A2,B2,C2,D2,HSVs2] = ERA(H,mco,mco,nin,nout,r2);
[A3,B3,C3,D3,HSVs3] = ERA(H,mco,mco,nin,nout,r3);
[A4,B4,C4,D4,HSVs4] = ERA(H,mco,mco,nin,nout,r4);
[A5,B5,C5,D5,HSVs5] = ERA(H,mco,mco,nin,nout,r5);
sysOKIDERA3 = ss(A3,B3,C3,D3,-1);
sysOKIDERA2 = ss(A2,B2,C2,D2,-1);
sysOKIDERA4 = ss(A4,B4,C4,D4,-1);
sysOKIDERA5 = ss(A5,B5,C5,D5,-1);

%% Verify my ERA model with Input x
ynew3 = lsim(sysOKIDERA3,x);
ynew2 = lsim(sysOKIDERA2,x);
ynew4 = lsim(sysOKIDERA4,x);
ynew5 = lsim(sysOKIDERA5,x);

%% Plot impulse responses for all kind of 
subplot(2,2,1)
stairs(ynew2,'LineWidth',1)
set(gca,'XLim',[0 200]);
hold on
stairs(y,'LineWidth',1)
ylabel('Output_2')
xlabel('Time = 350')
legend('ERA+OKID r=2','Original Output')
hold on 
grid on

subplot(2,2,2)
grid on
stairs(ynew3,'LineWidth',1)
set(gca,'XLim',[0 200]);
hold on
stairs(y,'LineWidth',1)
ylabel('Output_3')
xlabel('Time = 350')
legend('ERA+OKID r=3','Original Output')
hold on
grid on

subplot(2,2,3)
grid on
stairs(ynew4,'LineWidth',1)
set(gca,'XLim',[0 200]);
hold on
stairs(y,'LineWidth',1)
ylabel('Output_4')
xlabel('Time = 350')
legend('ERA+OKID r=4','Original Output')
hold on
grid on

subplot(2,2,4)
grid on
stairs(ynew5,'LineWidth',2)
set(gca,'XLim',[0 200]);
hold on
stairs(y,'LineWidth',1)
ylabel('Output_5')
xlabel('Time = 350')
legend('ERA+OKID r=5','Original Output')
hold on
grid on
