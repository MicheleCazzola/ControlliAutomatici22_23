%% Progetto di un controllore statico e verifica della stabilità in catena chiusa

clc
clear all
close all

%% Definizione funzione di trasferimento sistema LTI
s = tf('s');
F = (s - 1) / ((s + 0.2)*(s^3 + 2.5*s^2 + 4*s));    % tipo 1
Kr = 0.5;

%% Punto a - Calcolo parametri preliminari di F(s)

% Guadagno stazionario negativo
Kf = dcgain(s*F);

% Zero instabile
zero(F)

% Tre poli stabili, di cui due complessi coniugati
pole(F)

% Coppia di poli a smorzamento elevato
damp(F)

% Fase iniziale: -270° (Kf < 0 e polo semplice nell'origine) -> 90°
% Fase finale: -630° (3 poli stabili e uno zero instabile) -> -270°

%% Punto b - Calcolo diagramma di Bode di Ga(jw) per Kc = 1

Kc = 1;
Ga = Kc*F/Kr;

% Modulo:
% 0 < s < 0.2: -20 dB/dec
% 0.2 < s < 1: -40 dB/dec
% 1 < s < 1.25: -20 dB/dec
% s > 1.25: -60 dB/dec
% Fase:
% inizialmente: 90° (Kf < 0 -> 180°, polo s = 0 -> -90°)
% zero in s = 1 (instabile): -90°
% poli in s = -2, -1.25 + 1.56i, -1.25 - 1.56i (stabili): -270°
% w -> inf: -270°
w = logspace(-3, 2, 3000);
figure(1), bode(Ga, w), grid on;

%% Punto c - Calcolo diagramma di Nyquist di Ga(jw)

% W_pi = 2.66 rad/s
% A(-0.11, 0), B(4.04, 0)
figure(2), nyquist(Ga, w);

%% Punto d - Studio stabilità sistema ad anello chiuso al variare di Kc e verifica stabilità asintotica per Kc = -0.1

% n_ia = 0
% xA = -0.11, xB = 4.04
% 1: 0 < Kc < -1/xA = 9.17 -> N = 1 -> n_ic = 1 -> Instabile
% 2: Kc > -1/xA = 9.17 -> N = 3 -> n_ic = 3 -> Instabile
% 3: Kc < -1/xB = -0.25 -> N = 2 -> n_ic = 2 -> Instabile
% 4: -0.25 = -1/xB < Kc < 0 -> N = 0 -> n_ic = 0 -> Stabile

Kc = -0.1;
W = feedback(Kc * F, 1/Kr);
w = logspace(-3, 2, 3000);
figure(3), bode(W, w), grid on;

% Due coppie di poli complessi coniugati stabili (smorzamento piccolo)
damp(W);

%% Punto e - Calcolo errore inseguimento in regime permanente

Ga = Kc * F / Kr;
We = Kr * feedback(1, Ga);
Wd1 = feedback(F, Kc/Kr);
Wd2 = feedback(1, Ga);

D1_1 = 0.1;
D2_1 = 0.5;
alfa_r_1 = 1;
% r(t) rampa e Ga tipo 1 -> Errore limitato
e_r_1 = dcgain(s * We * alfa_r_1 / s^2);
% d1(t) costante, F tipo 1, C tipo 0 -> errore limitato
e_d1_1 = -dcgain(s * Wd1 * D1_1/s);
% d2(t) costante, Ga tipo 1 -> errore nullo
e_d2_1 = -dcgain(s * Wd2 * D2_1/s);
e_tot_1 = e_r_1 + e_d1_1 + e_d2_1;

D1_2 = 0.1;
alfa_2_2 = 0.01;
R_2 = 2;

% r(t) costante e Ga tipo 1 -> Errore nullo
e_r_2 = dcgain(s * We * R_2 / s);
% d1(t) costante, F tipo 1, C tipo 0 -> Errore limitato
e_d1_2 = -dcgain(s * Wd1 * D1_2/s);
% d2(t) rampa, Ga tipo 1 -> errore nullo
e_d2_2 = -dcgain(s * Wd2 * alfa_2_2/s^2);
e_tot_2 = e_r_2 + e_d1_2 + e_d2_2;

% Plot simulazione 1
figure(4), plot(output1.Time, output1.Data(:,1), 'r', output1.Time, output1.Data(:,2), 'b'), grid on;
figure(5), plot(output1.Time, output1.Data(:,2) - output1.Data(:,1), 'b'), grid on;

% Plot simulazione 2
figure(6), plot(output2.Time, output2.Data(:,1), 'r', output2.Time, output2.Data(:,2), 'b'), grid on;
figure(7), plot(output2.Time, output2.Data(:,2) - output2.Data(:,1), 'b'), grid on;