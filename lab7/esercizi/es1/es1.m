%% Progetto di un controllore analogico mediante sintesi per tentativi

clear all, close all;

% Definizione sistema
s = tf('s');

F = 13.5 * ((s+4) * (s+10)) / ((s+3)^3);
Kr = 1;
Kf = dcgain(F);

w_int = logspace(-1,3,1e4);
alfar = 1;
ermax = 0.01;
d = 1;
ydmax = 0.02;
wb = 6;     % rad/s
wbtol = 0.15;
wbmin = wb * (1 - wbtol);
wbmax = wb * (1 + wbtol);
Mrmax = 2;  % dB

% Specifiche statiche
Kc = 5;
Ga = Kc * F / s;

figure(1), bode(Ga, w_int), grid on; 
% Sistema a stabilità regolare -> Kc > 0

% Specifiche dinamiche
wcdes = 0.63 * wb;
mphmin = 60 - 5*Mrmax;

[m0, f0] = bode(Ga, wcdes);

% m0 = 9.35 unat -> 19.4 dB
% f0 = -181° (recupero di circa 55°, Nichols da Mr richiede circa 47°)

% Anticipatrice (doppia)
md = 4;
xd = 1;
taud = xd/wcdes;
Rd = (1 + taud*s) / (1 + taud*s/md);
Ga1 = Ga * Rd^2;
[m1, f1] = bode(Ga1, wcdes);

% m1 = 17.6 unat -> 25 dB
% f1 = -119° (circa 10° superiore al margine)

% Attenuatrice (singola)
mi = 17;
figure(2), bode((1+s/mi)/(1+s)), grid on;
xi = 120;
taui = xi/wcdes;
Ri = (1 + taui*s/mi) / (1 + taui*s);
Ga2 = Ga1 * Ri;
[m2, f2] = bode(Ga2, wcdes);

C = Kc * Rd^2 * Ri / s;

% m2 = 1.05 unat -> 0.39 dB
% f2 = -126° (margine di circa 55°)

% Verifica specifiche dinamiche
W = feedback(C*F, 1/Kr);
figure(3), margin(Ga2), grid on;
figure(4), bode(W, w_int), grid on;

% wb_reale = 5.89 > wbmin = 5.1 rad/s
% Mr_reale = 1.9 dB < Mrmax = 2 dB

figure(5), step(W), grid on;

% ts = 0.437 s
% ta_2% = 2.75 s -> solo un ordine di grandezza differente
% s^ = 21.7% al tempo t^ = 0.785 s

% Verifica specifiche statiche effettuata in simulink -> Soddisfatte

% Errore inseguimento massimo in regime permanente per r(t) = sin(0.1t)
wrif = 0.1;     % rad/s
We = Kr*feedback(1, Ga2);
figure(6), bode(We), grid on;
[erifmax, ~] = bode(We, wrif);  % pari a 0.0033 unat -> -49.6 dB

% Attenuazione disturbi sinusoidali di pulsazione w > wdmin = 100 rad/s
wdmin = 100;        % rad/s
figure(7), bode(W, logspace(1,4)), grid on;
[edmax, ~] = bode(W, wdmin);   % pari a 0.0063 unat -> -44 dB