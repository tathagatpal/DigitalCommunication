%EYEDIAGRAM:
%As the variance increases, the opening of the eyediagram 
%gets small and the distortion observed is greater. This is evident from
%the plots.

%Given parameters:
T = 10; 
A = 2; 
mu = 0; 
var = 0.5;
sd = sqrt(var);
%Time range as given in the clarification
t = -T/2 : 0.05: T/2;

%Variance for part b
var1 = 2;
sd1 = sqrt(var1);

%Gauss(0,0.5) and extracting 11 random points (noise)
gauss = gaussmf(t, [sd, mu]);
n = gauss(randperm(length(gauss),length(t)));

%Gauss(0,2) and extracting 11 random points (noise)
gauss1 = gaussmf(t, [sd1, mu]);
n1 = gauss1(randperm(length(gauss1),length(t)));

%Given in question s0 and s1
s00 = A*cos(pi*t/T);
s10 = A*cos(2*pi*t/T);
s0 = A*cos(pi*t/T);
s1 = A*cos(2*pi*t/T);

%Calculating SNR values (var=0.5) to use in awgn(.)
snr_s0 = snr(s0, n);
snr_s1 = snr(s1, n);

%Calculating SNR values (var=2) to use in awgn(.)
snr_s01 = snr(s0, n1);
snr_s11 = snr(s1, n1);

%3b i) r0, r1 with variance = 0.5
r0_awgn = awgn(s0, snr_s0);
r1_awgn = awgn(s1, snr_s1);

%3b ii) r0, r1 with variance = 2
r0_awgn1 = awgn(s0, snr_s01);
r1_awgn1 = awgn(s1, snr_s11);

tau = 100;
%Eyediagram for
eyediagram(r0_awgn, tau); %r0, var = 0.5
eyediagram(r0_awgn1, tau); %r0, var = 2
eyediagram(r1_awgn, tau); %r1, var = 0.5
eyediagram(r1_awgn1, tau); %r1, var = 2