clc;
clear all;
tic;


parfor tn = 1:2000
    
Fs = 250;

Ti = 0;
Transi = 30;
Tf = Transi + 110;

SampleNumber = (Tf-Ti)*Fs;

rng(27865398);

tiw = 120+200*rand(4*SampleNumber+1,1);                % uniform white noise

Tspan = linspace(Ti,Tf,4*SampleNumber);                % Time duration for the data
%%%%%%%%%%%%%%%%%%%
C = 135;                                               % Synaptic gain Constant
dlta = 7;                                              % Dlta and eta are waveform parameters
eta = 6;
%%%%%%%%%%%%%%%%%%%
e0 = 2.5;     %Hz                                      % System parameters for alpha like output
v0 = 6;       %mV
r = 0.56;     %(mV)^-1
A = 3.25;     %mV
B = 22;       %mV
a = 100;      %Hz
b = 50;       %Hz
%%%%%%%%%%%%%%%%%%%%
zta = (tn-1)*0.004;
yi = rand(7,1);

yi(7,1) = 0;
k = 1E-6;
options=odeset('RelTol',k);
[t,y] = ode45(@(t,y) odefcn(t,y,e0,v0,r,A,B,a,b,dlta,eta,zta,C,Fs,tiw,Transi), Tspan, yi, options);
%%%%%%%%%%%%%%%%%%%%
Fs = 1000;
discardd = Transi + 10;
OutS = y(discardd*Fs+1:end,2) - y(discardd*Fs+1:end,3);
OutS = OutS-mean(OutS);
OutS = bp(OutS,Fs);
Nsamps = length(OutS);
xdft1 = fft(OutS);
xdft1 = xdft1(1:floor(Nsamps/2)+1);
psdx1 = (1/(Fs*Nsamps)) * abs(xdft1).^2;            % Calculating the PSD             
psdx1(2:end-1) = (2*psdx1(2:end-1));

freq1 = 0:Fs/Nsamps:Fs/2;

Fpoint1 = 2*length(psdx1)/Fs;
F1 = 2*(Fpoint1);
F2 = 50*(Fpoint1);                                   % Saving the PSD data between 2 and 50 Hz
PSDFF1 = psdx1(F1+1:F2,1);
FreqRec1 = freq1(1,F1+1:F2);

parsave(sprintf('output%d.mat', tn), PSDFF1,FreqRec1,zta,OutS)

end

toc;
