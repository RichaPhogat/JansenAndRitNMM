clc;
clear all;
tic;



    
Fs = 250;

Ti = 0;
Transi = 110;
Tf = Transi + 110;

smd = 10;

SampleNumber = (Tf-Ti)*Fs;

rng(27865398);

tiw = 120+200*rand(4*SampleNumber+1,1);

% tiwi = randn(4*SampleNumber+1,1);         %Gaussian white noise
% tiw = 120+100*((tiwi+max(tiwi))/max(tiwi));

Tspan = linspace(Ti,Tf,4*SampleNumber);
%%%%%%%%%%%%%%%%%%%
C = 135;
dlta = 7;
eta = 10;
%%%%%%%%%%%%%%%%%%%
e0 = 2.5;     %Hz
v0 = 6;       %mV
r = 0.56;     %(mV)^-1
A = 3.25;     %mV
B = 22;       %mV
a = 100;      %Hz
b = 50;       %Hz
%%%%%%%%%%%%%%%%%%%%
zta = 0.3;
yi = rand(7,1);
yi(7,1) = 0;
k = 1E-6;
options=odeset('RelTol',k);
[t,y] = ode45(@(t,y) odefcn(t,y,e0,v0,r,A,B,a,b,dlta,eta,zta,C,Fs,tiw,Transi), Tspan, yi, options);
%%%%%%%%%%%%%%%%%%%%
Fs = 1000;

discard = 10;
OutS = y(discard*Fs+1:Transi*Fs,2) - y(discard*Fs+1:Transi*Fs,3);
OutS = OutS-mean(OutS);
OutS = bp(OutS,Fs);
Nsamps = length(OutS);
xdft2 = fft(OutS);
xdft2 = xdft2(1:floor(Nsamps/2)+1);
psdx2 = (1/(Fs*Nsamps)) * abs(xdft2).^2;
psdx2(2:end-1) = (2*psdx2(2:end-1));


discardd = Transi + 10;
OutS = y(discardd*Fs+1:end,2) - y(discardd*Fs+1:end,3);
OutS = OutS-mean(OutS);
OutS = bp(OutS,Fs);
Nsamps = length(OutS);
xdft1 = fft(OutS);
xdft1 = xdft1(1:floor(Nsamps/2)+1);
psdx1 = (1/(Fs*Nsamps)) * abs(xdft1).^2;
psdx1(2:end-1) = (2*psdx1(2:end-1));

freq = 0:Fs/Nsamps:Fs/2;


axes('Position', [0.05 0.55 0.42 0.35]);
xline(5,'--','5 Hz','color',[0.6, 0.6, 0.6],'LineWidth',1,'Fontsize',15);
hold on
xline(10,'--','10 Hz','color',[0.6, 0.6, 0.6],'LineWidth',1,...
    'Fontsize',15,'LabelVerticalAlignment','bottom');
hold on


plot(freq,(smooth(psdx1,smd)),'color',[0, 0.45, 0.75],'LineWidth',2);
hold on;
plot(freq,(smooth(psdx2,smd)),'color',[0.65, 0.01, 0.20],'LineWidth',2);
set(gca,'FontSize',20)
xlim([2 30]);
xticks([5 10 20 30])
% yticks([10E-5 10])
% yticklabels({'10^-5','1'})
ylabel('PSD (mV^2/Hz)', 'FontSize',20);
title('(a)')

set(gca,'YScale','log','FontName','Times','LineWidth',2,'Fontsize',20,'fontweight','bold','xticklabel',{[]});


hold on;




    
Fs = 250;

Ti = 0;
Transi = 110;
Tf = Transi + 110;

smd = 10;

SampleNumber = (Tf-Ti)*Fs;

rng(27865398);

tiw = 120+200*rand(4*SampleNumber+1,1);

% tiwi = randn(4*SampleNumber+1,1);         %Gaussian white noise
% tiw = 120+100*((tiwi+max(tiwi))/max(tiwi));

Tspan = linspace(Ti,Tf,4*SampleNumber);
%%%%%%%%%%%%%%%%%%%
C = 135;
dlta = 7;
eta = 10;
%%%%%%%%%%%%%%%%%%%
e0 = 2.5;     %Hz
v0 = 6;       %mV
r = 0.56;     %(mV)^-1
A = 3.25;     %mV
B = 22;       %mV
a = 100;      %Hz
b = 50;       %Hz
%%%%%%%%%%%%%%%%%%%%
zta = 1.2;
yi = rand(7,1);
yi(7,1) = 0;
k = 1E-6;
options=odeset('RelTol',k);
[t,y] = ode45(@(t,y) odefcn(t,y,e0,v0,r,A,B,a,b,dlta,eta,zta,C,Fs,tiw,Transi), Tspan, yi, options);
%%%%%%%%%%%%%%%%%%%%
Fs = 1000;

discard = 10;
OutS = y(discard*Fs+1:Transi*Fs,2) - y(discard*Fs+1:Transi*Fs,3);
OutS = OutS-mean(OutS);
OutS = bp(OutS,Fs);
Nsamps = length(OutS);
xdft2 = fft(OutS);
xdft2 = xdft2(1:floor(Nsamps/2)+1);
psdx2 = (1/(Fs*Nsamps)) * abs(xdft2).^2;
psdx2(2:end-1) = (2*psdx2(2:end-1));


discardd = Transi + 10;
OutS = y(discardd*Fs+1:end,2) - y(discardd*Fs+1:end,3);
OutS = OutS-mean(OutS);
OutS = bp(OutS,Fs);
Nsamps = length(OutS);
xdft1 = fft(OutS);
xdft1 = xdft1(1:floor(Nsamps/2)+1);
psdx1 = (1/(Fs*Nsamps)) * abs(xdft1).^2;
psdx1(2:end-1) = (2*psdx1(2:end-1));

freq = 0:Fs/Nsamps:Fs/2;


axes('Position', [0.05 0.13 0.42 0.35]);
xline(5,'--','5 Hz','color',[0.6, 0.6, 0.6],'LineWidth',1,...
    'Fontsize',15,'LabelVerticalAlignment','bottom');
hold on
xline(10,'--','10 Hz','color',[0.6, 0.6, 0.6],'LineWidth',1,...
    'Fontsize',15,'LabelVerticalAlignment','bottom');
hold on
plot(freq,(smooth(psdx1,smd)),'color',[0, 0.45, 0.75],'LineWidth',2);
hold on;
plot(freq,(smooth(psdx2,smd)),'color',[0.65, 0.01, 0.20],'LineWidth',2);
set(gca,'FontSize',20)
xlim([2 30]);
xticks([5 10 20 30])
% ylabel('PSD', 'FontSize',20);

title('(c)')
set(gca,'YScale','log','FontName','Times','LineWidth',2,'Fontsize',20,'fontweight','bold');


hold on;




    
Fs = 250;

Ti = 0;
Transi = 110;
Tf = Transi + 110;

smd = 10;

SampleNumber = (Tf-Ti)*Fs;

rng(27865398);

tiw = 120+200*rand(4*SampleNumber+1,1);

% tiwi = randn(4*SampleNumber+1,1);         %Gaussian white noise
% tiw = 120+100*((tiwi+max(tiwi))/max(tiwi));

Tspan = linspace(Ti,Tf,4*SampleNumber);
%%%%%%%%%%%%%%%%%%%
C = 135;
dlta = 7;
eta = 6;
%%%%%%%%%%%%%%%%%%%
e0 = 2.5;     %Hz
v0 = 6;       %mV
r = 0.56;     %(mV)^-1
A = 3.25;     %mV
B = 22;       %mV
a = 100;      %Hz
b = 50;       %Hz
%%%%%%%%%%%%%%%%%%%%
zta = 0.3;
yi = rand(7,1);
yi(7,1) = 0;
k = 1E-6;
options=odeset('RelTol',k);
[t,y] = ode45(@(t,y) odefcn(t,y,e0,v0,r,A,B,a,b,dlta,eta,zta,C,Fs,tiw,Transi), Tspan, yi, options);
%%%%%%%%%%%%%%%%%%%%
Fs = 1000;

discard = 10;
OutS = y(discard*Fs+1:Transi*Fs,2) - y(discard*Fs+1:Transi*Fs,3);
OutS = OutS-mean(OutS);
OutS = bp(OutS,Fs);
Nsamps = length(OutS);
xdft2 = fft(OutS);
xdft2 = xdft2(1:floor(Nsamps/2)+1);
psdx2 = (1/(Fs*Nsamps)) * abs(xdft2).^2;
psdx2(2:end-1) = (2*psdx2(2:end-1));


discardd = Transi + 10;
OutS = y(discardd*Fs+1:end,2) - y(discardd*Fs+1:end,3);
OutS = OutS-mean(OutS);
OutS = bp(OutS,Fs);
Nsamps = length(OutS);
xdft1 = fft(OutS);
xdft1 = xdft1(1:floor(Nsamps/2)+1);
psdx1 = (1/(Fs*Nsamps)) * abs(xdft1).^2;
psdx1(2:end-1) = (2*psdx1(2:end-1));

freq = 0:Fs/Nsamps:Fs/2;


axes('Position', [0.55 0.55 0.42 0.35]);
xline(3,'--','3 Hz','color',[0.6, 0.6, 0.6],'LineWidth',1,'Fontsize',15);
hold on
xline(6,'--','6 Hz','color',[0.6, 0.6, 0.6],'LineWidth',1,'Fontsize',15);
hold on
plot(freq,(smooth(psdx1,smd)),'color',[0, 0.45, 0.75],'LineWidth',2);
hold on;
plot(freq,(smooth(psdx2,smd)),'color',[0.65, 0.01, 0.20],'LineWidth',2);
set(gca,'FontSize',20)
xlim([2 30]);
xticks([5 10 20 30])
% ylabel('PSD', 'FontSize',20);
title('(b)')

set(gca,'YScale','log','FontName','Times','LineWidth',2,'Fontsize',20,'fontweight','bold','xticklabel',{[]},'yticklabel',{[]});


hold on;



clc
clear variables



    
Fs = 250;

Ti = 0;
Transi = 110;
Tf = Transi + 110;

smd = 10;

SampleNumber = (Tf-Ti)*Fs;

rng(27865398);

tiw = 120+200*rand(4*SampleNumber+1,1);

% tiwi = randn(4*SampleNumber+1,1);         %Gaussian white noise
% tiw = 120+100*((tiwi+max(tiwi))/max(tiwi));

Tspan = linspace(Ti,Tf,4*SampleNumber);
%%%%%%%%%%%%%%%%%%%
C = 135;
dlta = 7;
eta = 6;
%%%%%%%%%%%%%%%%%%%
e0 = 2.5;     %Hz
v0 = 6;       %mV
r = 0.56;     %(mV)^-1
A = 3.25;     %mV
B = 22;       %mV
a = 100;      %Hz
b = 50;       %Hz
%%%%%%%%%%%%%%%%%%%%
zta = 1.2;
yi = rand(7,1);
yi(7,1) = 0;
k = 1E-6;
options=odeset('RelTol',k);
[t,y] = ode45(@(t,y) odefcn(t,y,e0,v0,r,A,B,a,b,dlta,eta,zta,C,Fs,tiw,Transi), Tspan, yi, options);
%%%%%%%%%%%%%%%%%%%%
Fs = 1000;

discard = 10;
OutS = y(discard*Fs+1:Transi*Fs,2) - y(discard*Fs+1:Transi*Fs,3);
OutS = OutS-mean(OutS);
OutS = bp(OutS,Fs);
Nsamps = length(OutS);
xdft2 = fft(OutS);
xdft2 = xdft2(1:floor(Nsamps/2)+1);
psdx2 = (1/(Fs*Nsamps)) * abs(xdft2).^2;
psdx2(2:end-1) = (2*psdx2(2:end-1));


discardd = Transi + 10;
OutS = y(discardd*Fs+1:end,2) - y(discardd*Fs+1:end,3);
OutS = OutS-mean(OutS);
OutS = bp(OutS,Fs);
Nsamps = length(OutS);
xdft1 = fft(OutS);
xdft1 = xdft1(1:floor(Nsamps/2)+1);
psdx1 = (1/(Fs*Nsamps)) * abs(xdft1).^2;
psdx1(2:end-1) = (2*psdx1(2:end-1));

freq = 0:Fs/Nsamps:Fs/2;


axes('Position', [0.55 0.13 0.42 0.35]);
xline(3,'--','3 Hz','color',[0.6, 0.6, 0.6],'LineWidth',1,...
    'Fontsize',15,'LabelVerticalAlignment','middle');
hold on
xline(6,'--','6 Hz','color',[0.6, 0.6, 0.6],'LineWidth',1,...
    'Fontsize',15,'LabelVerticalAlignment','middle');
hold on
plot(freq,(smooth(psdx1,smd)),'color',[0, 0.45, 0.75],'LineWidth',2);
hold on;
plot(freq,(smooth(psdx2,smd)),'color',[0.65, 0.01, 0.20],'LineWidth',2);
set(gca,'FontSize',20)
xlim([2 30]);
xticks([5 10 20 30])
% ylabel('PSD', 'FontSize',20);
xlabel('Frequency (Hz)', 'FontSize',20);
title('(d)')

set(gca,'YScale','log','FontName','Times','LineWidth',2,'Fontsize',20,'fontweight','bold','yticklabel',{[]});


toc;
