%A sinc pulse is a raised cosine pulse with roll-off factor, r=0.
%Now, bandwidth of P(f) = (1+r).R_b/2, where R_b = 1/T_b.
%Since R_b is constant, bandwidth of P(f) depends on roll-off factor r.
%Therefore, P(f) with r=0.75 occupies maximum bandwidth, followed by
%P(f) with r=0.5 and lastly sinc pulse (r=0).  This could be clearly seen
%in the plot at the end.

%The excess bandwidth, f_x=r/(2*T_b). Hence excess bandwidth for P(f) with:
%r= 0.5 -->  0.5/(2*2) = 0.125 Hz
%r= 0.75 --> 0.75/4 = 0.1875 Hz

%Code:

T_b = 2; %T_b = 1/R_b = 2 (given)

%Added 1^-15 (negligible non-zero number) to avoid t=0 case.
t = [-5*T_b:1/(5*T_b):5*T_b] + 1e-15; 

%Roll-off factors as given in the question.
r1 = 0.5;
r2 = 0.75;

t1 = -5*T_b:1/(100*T_b):5*T_b;

%p(t)
p_1 = (sin(pi*t/T_b)./(pi*t/T_b)).*(cos(r1*pi*t/T_b)./(1-(2*r1*t/T_b).^2)); 
p_2 = (sin(pi*t/T_b)./(pi*t/T_b)).*(cos(r2*pi*t/T_b)./(1-(2*r2*t/T_b).^2));
sinc_func = sinc(t1);

%Plotting the raised cosine pulses and the sinc pulse.
figure(1);
plot(t,p_1, t, p_2, t1, sinc_func,'linewidth', 1.5); 
hold on; 
grid on;
legend('Raised cosine_r_=_0_._5','Raised cosine_r_=_0_._7_5','sinc pulse');
xlabel('Time (s)'); ylabel('Amplitude'); 
title('2a) Raised cosine pulses p(t): r=0.5,0.75 and sinc(t) pulse');

%Calculation of P(f)
%The fourier transform of the Raised cosine pulses is P(f), and that of the
%sinc function is rectangular function. Also, to find the FT of sinc, we
%simply plug in r=0 in P(f), since sinc is raised cosine pulse with r=0.

%P(f) for raised cosine pulse with r=0.5
y1 = [];
f = [-1.5:1/10000:1.5];
for i=1:length(f)
    if (abs(f(i)) <= (1-r1)/(2*T_b)) %By definition of P(f)
        y1 = [y1 1];
    elseif (abs(f(i)) > (1-r1)/(2*T_b) && abs(f(i)) <= (1+r1)/(2*T_b))
        y1 = [y1 0.5*(1+cos((pi*T_b/r1)*(abs(f(i))-(1-r1)/(2*T_b))))];
    else
        y1 = [y1 0];
    end
end

%P(f) for raised cosine pulse with r=0.75
y2 = [];
for i=1:length(f)
    if (abs(f(i)) <= (1-r2)/(2*T_b)) %By definition of P(f)
        y2 = [y2 1];
    elseif (abs(f(i)) > (1-r2)/(2*T_b) && abs(f(i)) <= (1+r2)/(2*T_b))
        y2 = [y2 0.5*(1+cos((pi*T_b/r2)*(abs(f(i))-(1-r2)/(2*T_b))))];
    else
        y2 = [y2 0];
    end
end

%P(f) for raised cosine pulse with r=0 (sinc pulse)
r3=0;
y3 = [];
for i=1:length(f)
    if (abs(f(i)) <= (1-r3)/(2*T_b)) %By definition of P(f)
        y3 = [y3 1];
    elseif (abs(f(i)) > (1-r3)/(2*T_b) && abs(f(i)) <= (1+r3)/(2*T_b))
        y3 = [y3 0.5*(1+cos((pi*T_b/r3)*(abs(f(i))-(1-r3)/(2*T_b))))];
    else
        y3 = [y3 0];
    end
end

%Plotting the spectrum(frequency domain) of the raised cos pulses and the
%sinc pulse. 
figure(2);
plot(f,y1,f,y2,f,y3,'linewidth',1.5);
hold on; 
grid on;
xlabel('Frequency (Hz)'); ylabel('Amplitude'); 
title('2b) Spectrum of Raised cosine pulses (P(f)) and sinc pulse (Rectangular pulse)');
legend('Spectrum of raised cosine_r_=_0_._5','Spectrum of raised cosine_r_=_0_._7_5', ...
'Spectrum of sinc pulse');
hold off;