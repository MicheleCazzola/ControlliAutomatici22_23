%% Progetto di un controllore analogico mediante sintesi per tentativi

clear all, close all;

% Definizione sistema
s = tf('s');

F = 5*(s+20) / (s * (s^2 + 2.5*s + 2)*(s^2 + 15*s + 100));  % tipo 1
Kr = 2;
Kf = dcgain(s*F);

w_int = logspace(-2, 3, 1e4);
alfar = 1;
ermax = 0.05;
d = 1;
ydmax = 0.02;
tsdes = 1;
tstol = 0.1;
tsmin = tsdes*(1-tstol);
tsmax = tsdes*(1+tstol);
sovrmax = 0.3;

% Specifiche statiche
figure(1), bode(F), grid on;    % stabilità regolare -> Kc > 0

Kc = (Kr^2) / (Kf*ermax);
Ga = Kc * F / Kr;

% Specifiche dinamiche
wcdes = 3*0.63/tsdes;
MrmaxdB = 20*log10((1+sovrmax)/0.9);
mphmin = 60 - 5*MrmaxdB;     % da Nichols, circa 40°
figure(2), bode(Ga, w_int), grid on;

[m0, f0] = bode(Ga, wcdes);

% m0 = 8.5 unat -> 18.6 dB
% f0 = -210° (necessario recupero di circa 74°)

% Anticipatrice (recupero 90° con due reti)
md = 6;
xd = 1.3;
taud = xd / wcdes;
Rd = (1 + taud*s) / (1 + taud*s/md);
Ga1 = Ga*Rd^2;
[m1, f1] = bode(Ga1, wcdes);

% m1 = 22 unat -> 27 dB
% f1 = -129°

% Attenuatrice
mi = 24;
figure(3), bode((1+s/mi)/(1+s)), grid on;
xi = 200;
taui = xi / wcdes;
Ri = (1 + taui*s/mi) / (1 + taui*s);
Ga2 = Ga1 * Ri;
[m2, f2] = bode(Ga2, wcdes);

% m2 = 0.9 unat -> -1 dB
% f2 = -138°

C = Kc * Rd^2 * Ri;

% Verifica specifiche dinamiche
W = feedback(C*F, 1/Kr);
figure(4), margin(Ga2), grid on;
figure(5), step(W), grid on;

% s^_reale = 25.4%
% ts_reale = 1 s

% Verifica specifiche statiche -> Simulink

% Verifica attività sul comando per riposta al gradino -> Simulink: 240
Wu = feedback(C, F/Kr);
figure(6), step(Wu), grid on;

u0 = Kc * md^2 / mi;

% Valutazione banda passante e picco risonanza risposta in frequenza
figure(7), bode(W, w_int), grid on;

peakdB = 8.34;
Mr_realedB = peakdB - 20*log10(dcgain(W));

% wb_reale = 4.73 rad/s (da Bode)