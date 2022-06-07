clc;
clear all;

str1 = 'D:\jansen and rit\Peaky waveform\modified parameters\c40.15c\10Hz\output';
str3 = '.mat';

DataLen = 5000;
ForAmp = zeros(DataLen,1);

    
for cn = 1:1:DataLen
    str2 = num2str(cn);
    str4 = [str1 str2 str3];
    load(str4);
    ForAmp(cn,1) = zta;
    % PSDFF1 = PSDFF1./max(PSDFF1);
    PSDFFreq(:,cn) = smooth(PSDFF1,5);
end

surf(ForAmp',FreqRec1,log(abs(PSDFFreq)),'edgecolor','none')
ylabel('Brain Dynamics in 4-30 Hz')
xlabel('Forcing Amplitude')
title('S1')
set(gca,'FontName','Times','Fontsize',20,'fontweight','bold');

%set(gca, 'XScale', 'log')
ylim([2 30])
% xlim([5 15])
view(2)
% set(gca,'ColorScale','log')
%set(gca,'YDir','normal')
colormap('jet')
 colorbar
 caxis([-15 0])
 
 
 ForcingFreq = 10;
 Initn = FreqRec1(1,1);
 FreqStep = (FreqRec1(1,2) - FreqRec1(1,1));
 IndexNeeded1 = (ForcingFreq - Initn)/(FreqStep);
 IndexNeeded2 = (2*ForcingFreq - Initn)/(FreqStep);
 
 PSDV1 = zeros(DataLen,1);
 PSDV2 = zeros(DataLen,1);
 PSDVf = zeros(DataLen,1);
 
 for cnt = 1:1:DataLen
     
    PSDV1(cnt,1) = max(PSDFFreq(IndexNeeded1 - 20:IndexNeeded1 + 20,cnt));
    PSDV2(cnt,1) = max(PSDFFreq(IndexNeeded2 - 20:IndexNeeded2 + 20,cnt));
    
 end
 
 PSDVf = PSDV1./PSDV2;
 
 figure;
 plot(ForAmp,PSDV1,'r','linewidth',2)
 hold on
 plot(ForAmp,PSDV2,'b','linewidth',2)
 hold on
 plot(ForAmp,PSDVf,'k','linewidth',2)
 
 legend('Fundamental Harmonic','Second Harmonic')
 
set(gca,'FontName','Times','Fontsize',20,'fontweight','bold');
