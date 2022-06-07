function [ y ] = bp(x2, Fs)

low=2.0;
high=50.0;
fx=fft(x2);
N=length(fx);
lowp=round((N*low)/Fs);
highp=round((N*high)/Fs);
fx(1:lowp)=0;
fx(highp:end)=0;
x1_bp=real(ifft(fx));
temp1=abs(fft(x2(1:end)));
temp2=abs(fft(x1_bp(1:end)));
y = x1_bp; 

end

