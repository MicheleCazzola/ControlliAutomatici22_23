%% Progetto di un controllore statico e verifica della stabilità in catena chiusa

clc, clear all, close all

%% Definizione funzione di trasferimento sistema LTI
s = tf('s');
F = (s + 10) / (s^3 + 45*s^2 - 250*s);
Kr = 2;

%% Punto a - Calcolo parametri preliminari di F(s)
% F di tipo 1
Kf = dcgain(s * F);

% Zeri: unico, reale e semplice in -10 (stabile)
zero(F)

% Poli: tre reali semplici in 0, -50 (stabile), 5 (instabile)
pole(F)

% Fase iniziale: -270° (singolo polo nell'origine con Kf < 0)
% Fase finale: -180° (da -270° -> zero guadagna 90°, poli guadagnano 0° nel
% complesso)

%% Punto b - Diagrammi di Bode di Ga(jw) con Kc = 1

Kc = 1;
Ga = Kc * F / Kr;

% Modulo:
% 0 < s < 5: -20 dB/dec
% 5 < s < 10: -40 dB/dec
% 10 < s < 50: -20 dB/dec
% s > 50: -40 dB/dec
% Fase:
% s = 0: -270°
% s = 5, s = 10: guadagna 90° ciascuno
% s = 50: perde 90°
% s -> inf: -180°
w = logspace(0, 3, 1000);
figure(1), bode(Ga, w), grid on;

%% Punto c - Diagramma di Nyquist di Ga(jw), con Kc = 1

% W_pi = 8.45 rad/s (considerando Kc = 1)
% A(-56.2 dB, 0) = (-1.55e-3, 0)
w = logspace(0, 3, 1000);
figure(2), nyquist(Ga, w);

%% Punto d - Studio stabilità ad anello chiuso al variare di Kc e verifica con Kc = 800

% Dato 1/xA = 645.65
% Dato n_ia = 0
% 1: 0 < Kc < 645.65 -> N = 1 (o forse 2?) -> n_ic = 1(2) -> Instabile
% 2: Kc > 645.65 -> N = 0 -> Stabile
% 3: Kc < 0 -> N = 1 -> Instabile

Kc = 800;
W = feedback(Kc * F, 1/Kr);
figure(3), bode(W, w), grid on;

% Si nota che sono tutti poli a parte reale negativa (damping piccolo)
damp(W)
%% Punto e - Calcolo errore inseguimento in regime permanente

D1_1 = 0.1;
D2_1 = 0.5;
Ga = Kc * F / Kr;
KGa = dcgain(s*Ga);

% r(t) rampa, Ga tipo 1 -> errore limitato
e_r_1 = 1/KGa;
% d1(t) costante, F tipo 1, C tipo 0 -> errore limitato
e_d1_1 = - D1_1 / (Kc/Kr);
% d2(t) costante, Ga tipo 1 -> errore nullo
e_d2_1 = 0;
e_tot_1 = e_r_1 + e_d1_1 + e_d2_1; % da simulazione, si ha errore doppio

D1_2 = 0;
alfa2_2 = 0.01;

% r(t) costante, Ga tipo 1 -> errore nullo
e_r_2 = 0;

% d1(t) nullo -> errore nullo
e_d1_2 = 0;
% d2(t) rampa, Ga tipo 1 -> errore limitato
e_d2_2 = - alfa2_2 / KGa;
e_tot_2 = e_r_2 + e_d1_2 + e_d2_2;

% Prova punto 1
%diff1 = output1.Data(:,1) - output1.Data(:,2);

% Prova punto 2
%diff2 = output2.Data(:,1) - output2.Data(:,2);

%mean(diff2(13000:13172,1))