%We had to plot the discrete time signals. However, just for
%the sake of analysis and better visualization, I have plotted the continous 
%versions of those signals too.

%The eye diagram has been submitted in another PDF as the time scale to be
%taken for the analysis was different.

%With the increase in noise variance, the noise in the r_k increases
%and thus the distortion observed is more.

%We can clearly see that as the noise variance increases,
%the output has more noise.

%Given parameters:
T = 10; 
A = 2; 
mu = 0; 
var = 0.5;
sd = sqrt(var);
t = -T/2 : 1 : T/2;
t0 = -T/2 : 0.05 : T/2; %For plotting continuous s0, s1

%Variance for part b 
var1 = 2;
sd1 = sqrt(var1);

%Gauss(0,0.5) and extracting 11 random points (noise)

%Instead of using default function for Gaussian distribution;
%the formula for gaussian distribution could have been used too.
% gauss = gaussmf(t, [sd, mu]);
% n = gauss(randperm(length(gauss),length(t)));

n = mu + sd*randn(1,11); %Randomly generating Gaussian noise

%Gauss(0,2) and extracting 11 random points (noise)
% gauss1 = gaussmf(t, [sd1, mu]);
% n1 = gauss1(randperm(length(gauss1),length(t)));

n1 = mu + sd1*randn(1,11); %Randmonly generating Gaussian noise

%CONTINUOUS
gauss_c = gaussmf(t0, [sd, mu]);
n_c = gauss_c(randperm(length(gauss_c),length(t0)));

gauss_c1 = gaussmf(t0, [sd, mu]);
n_c1 = gauss_c1(randperm(length(gauss_c1),length(t0)));

%Given in question s0 and s1
%Continuous plot for s0 and s1
s00 = A*cos(pi*t0/T);
s10 = A*cos(2*pi*t0/T);

s0 = A*cos(pi*t/T);
s1 = A*cos(2*pi*t/T);

r0 = s0 + n;
r1 = s1 + n;
snr_s0 = snr(s0, n);
snr_s1 = snr(s1, n);

%Plotting r0 and r1 
figure(1);
stem(t,r0,'linewidth', 1.5);
hold on;
stem(t,r1,'linewidth', 1.5);
plot(t,r0,'b', 'linewidth', 1.5);
plot(t,r1,'r', 'linewidth', 1.5);
plot(t0,s00,'--','linewidth', 1.5);
plot(t0,s10,'--','linewidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude'); 
legend('r_0','r_1', 'r_0(cont)', 'r_1(cont)', ...
    's_0(original signal)','s_1(original signal)', 'location', 'northoutside');
title('3a) r_0 and r_1');

%In second part it was not mentioned if we've to plot the r_k discretely or
%in a continuous form. So, I've plotted both both of them.
%Calculating SNR values to use in awgn(.)

snr_s01 = snr(s0, n1);
snr_s11 = snr(s1, n1);

%i) r0, r1 with variance = 0.5
r0_awgn = awgn(s0, snr_s0);
r1_awgn = awgn(s1, snr_s1);

%ii) r0, r1 with variance = 2
r0_awgn1 = awgn(s0, snr_s01);
r1_awgn1 = awgn(s1, snr_s11);

%CONTINUOUS
snr_s0c = snr(s00, n_c);
snr_s1c = snr(s10, n_c);
r0_awgnc = awgn(s00, snr_s0c);
r1_awgnc = awgn(s10, snr_s1c);


snr_s01c = snr(s00, n_c1);
snr_s11c = snr(s10, n_c1);
r0_awgn1c = awgn(s00, snr_s01c);
r1_awgn1c = awgn(s10, snr_s11c);

%Plotting r0 and r1 using awgn(.) [var=0.5]
figure(2);
stem(t,r0_awgn,'linewidth', 1.5 );
hold on;
stem(t,r1_awgn,'linewidth', 1.5);
plot(t,r0_awgn,'b', 'linewidth', 1.5);
plot(t,r1_awgn,'r', 'linewidth', 1.5);
plot(t0,s00,'--','linewidth', 1.5);
plot(t0,s10,'--','linewidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude'); 
legend('r_0','r_1', 'r_0(cont)', 'r_1(cont)', ...
    's_0(original signal)','s_1(original signal)','location', 'northoutside');
title('3b) r_0 and r_1 (discrete) using awgn(.), var=0.5');

%Plotting r0 and r1 using awgn(.) [var=2]
figure(3);
stem(t,r0_awgn1,'linewidth', 1.5);
hold on;
stem(t,r1_awgn1,'linewidth', 1.5);
plot(t,r0_awgn1,'b', 'linewidth', 1.5);
plot(t,r1_awgn1,'r', 'linewidth', 1.5);
plot(t0,s00,'--','linewidth', 1.5);
plot(t0,s10,'--','linewidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude'); 
legend('r_0','r_1','r_0(cont)', 'r_1(cont)', ...
    's_0(original signal)','s_1(original signal)','location', 'northoutside');
title('3b) r_0 and r_1 (discrete) using awgn(.), var=2');

%Plotting r0 and r1 using awgn(.) [var=0.5]
figure(4);
plot(t0,r0_awgnc,'b', 'linewidth', 1.5);
hold on;
plot(t0,r1_awgnc,'r', 'linewidth', 1.5);
plot(t0,s00,'--','linewidth', 1.5);
plot(t0,s10,'--','linewidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude'); 
legend('r_0','r_1', ...
    's_0(original signal)','s_1(original signal)','location', 'northoutside');
title('3b) r_0 and r_1 (cont) using awgn(.), var=0.5');

%Plotting r0 and r1 using awgn(.) [var=2]
figure(5);
plot(t0,r0_awgn1c,'b', 'linewidth', 1.5);
hold on;
plot(t0,r1_awgn1c,'r', 'linewidth', 1.5);
plot(t0,s00,'--','linewidth', 1.5);
plot(t0,s10,'--','linewidth', 1.5);
xlabel('Time (s)'); ylabel('Amplitude'); 
legend('r_0','r_1', ...
    's_0(original signal)','s_1(original signal)','location', 'northoutside');
title('3b) r_0 and r_1 (cont) using awgn(.), var=2');

%Generating samples {r_k'}
%ATQ, we had to plot discrete r_k', but I've joined the points where r_k'
%is discrete just for better visualization.

%Given filter h(t) = s(t - T), where T = 10
s0c = A*cos(pi*(t-10)/T);
s1c = A*cos(2*pi*(t-10)/T);

%Convolution r'(t) = r(t) ∗ h(t)
%Variance = 0.5
r0_s0 = conv(r0_awgn,s0c); %r0 * h0
r1_s1 = conv(r1_awgn,s1c); %r1 * h1
r0_s1 = conv(r0_awgn, s1c); %r0 * h1
r1_s0 = conv(r1_awgn, s0c); %r1 * h0

%Convolution r'(t) = r(t) ∗ h(t)
%Variance = 2
r0_s01 = conv(r0_awgn1,s0c); %r0 * h0
r1_s11 = conv(r1_awgn1,s1c); %r1 * h1
r0_s11 = conv(r0_awgn1, s1c); %r0 * h1
r1_s01 = conv(r1_awgn1, s0c); %r1 * h0

t2 = 0:1:2*T;

%Plotting r'(t) for variance = 0.5
figure(6);
stem (t2, r0_s0, 'linewidth', 1.5);
hold on;
stem(t2, r1_s1, 'linewidth', 1.5);
stem(t2, r0_s1, 'linewidth', 1.5);
stem(t2, r1_s0, 'linewidth', 1.5);
plot(t2,r0_s0,'b','linewidth', 1.5);
plot(t2,r1_s1,'r','linewidth', 1.5);
plot(t2, r0_s1, 'y', 'linewidth', 1.5);
plot(t2, r1_s0, 'm', 'linewidth', 1.5);
legend("r_0∗h_0", "r_1∗h_1", "r_0∗h_1", "r_1∗h_0", ...
    "r_0∗h_0(cont)", "r_1∗h_1(cont)", "r_0∗h_1(cont)", "r_1∗h_0(cont)");
xlabel('Time (s)'); ylabel('Amplitude'); 
title("3c) r_k' = r(t) ∗ h(t) [var = 0.5]");

%Plotting r'(t) for variance = 2
figure(7);
stem (t2, r0_s01, 'linewidth', 1.5);
hold on;
stem(t2, r1_s11, 'linewidth', 1.5);
stem(t2, r0_s11, 'linewidth', 1.5);
stem(t2, r1_s01, 'linewidth', 1.5);
plot(t2,r0_s01,'b','linewidth', 1.5);
plot(t2,r1_s11,'r','linewidth', 1.5);
plot(t2,r0_s11,'y','linewidth', 1.5);
plot(t2, r1_s01, 'm', 'linewidth', 1.5);
legend("r_0∗h_0", "r_1∗h_1", "r_0∗h_1", "r_1∗h_0", ...
    "r_0∗h_0(cont)", "r_1∗h_1(cont)", "r_0∗h_1(cont)", "r_1∗h_0(cont)");
xlabel('Time (s)'); ylabel('Amplitude'); 
title("3c) r_k' = r(t) ∗ h(t) [var = 2]");



