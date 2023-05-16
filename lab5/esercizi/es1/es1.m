%% Progetto di un controllore statico e studio della stabilità

clear all
close all
clc

% Funzione trasferimento
s = tf('s');

F = (s^2 + 11*s + 10)/(s^2 * (s^2 + 4*s + 8));
Kc = 1;
Kr = 1;

%% Punto a - Guadagno stazionario, singolarità, fase iniziale e finale

% Kf = s^2 * F(s) = 1.25
Kf = dcgain(s^2 * F);

% Singolarità:
% - zeri: -1, -10
zero(F)
% - poli: uso damp -> {0 (2), -2 + 2i (z = 0.707, wn = 2.83 rad/s), -2 - 2i(z = 0.707, wn = 2.83 rad/s)}
pole(F)
damp(F);

% Fasi:
% - iniziale: -180° (doppio polo nell'origine con Kf > 0)
% - finale: -180°[ = -180° + 2*90° (doppio zero stabile) - 2*90 (doppio polo stabile)]

%% Punto b - Diagrammi di Bode
% Modulo:
% - partenza: polo doppio nell'origine -> -40 dB/dec
% - per 1 < w < 2: zero -> -20 dB/dec
% - per 2 < w < 10: coppia di poli complessi coniugati -> -60 dB/dec
% - per w >= 10: zero -> -40 dB/dec
% Fase:
% - partenza: polo doppio nell'origine -> -180°
% - per 1 < w < 2: zero stabile -> +90° -> guadagno di fase (non totale)
% - per 2 < w < 10: coppia di poli complessi coniugati stabili -> -180° -> perdita di fase (non totale)
% - per w >= 10: zero stabile -> +90° -> guadagno di fase (totale a inf)
% - per w-> inf: -180°
figure(1), bode(Kc * F * 1/Kr), grid on;

%% Punto c - Diagramma di Nyquist

% Pulsazione a -180°: w_pi = 2.62 rad/s
% Modulo a w_pi: 0.402 < 1 (~ -8.01 dB < 0 dB)
w = logspace(0, 3, 1000);
figure(2), nyquist(Kc * F * 1/Kr, w);

%% Punto d - Verifica stabilità con criterio di Nyquist, per Kc = 1
% Numero giri senso orario intorno al punto critico (-1,0): N = 0
% Numero poli instabili in catena aperta: n_ia = 0
% Quindi n_ic = 0 -> Sistema stabile in catena chiusa

W = feedback(Kc * F, 1/Kr);
damp(W);

% Infatti ci sono due coppie di poli complessi coniugati, tutti con parte
% reale negativa

%% Punto e - Calcolo errori in regime permanente

% 1: e_ins = 0, e_d = -0.1, e_tot = -0.1
figure(3), plot(simout1.Time, simout1.Data(:,1), 'r', simout1.Time, simout1.Data(:,2), 'b'), grid on;
figure(4), plot(simout1.Time, simout1.Data(:,2) - simout1.Data(:,1)), grid on;

% 2: e_ins = 0, e_d = 0, e_tot = 0
figure(5), plot(simout2.Time, simout2.Data(:,1), 'r', simout2.Time, simout2.Data(:,2), 'b'), grid on;
figure(6), plot(simout2.Time, simout2.Data(:,2) - simout2.Data(:,1)), grid on;

% 3: e_ins = 0.8, e_d = 0,  e_tot = 0.8
figure(7), plot(simout3.Time, simout3.Data(:,1), 'r', simout3.Time, simout3.Data(:,2), 'b'), grid on;
figure(8), plot(simout3.Time, simout3.Data(:,2) - simout3.Data(:,1)), grid on;

% 4: e_ins = 0.8, e_d = -0.1, e_tot = 0.7
figure(9), plot(simout4.Time, simout4.Data(:,1), 'r', simout4.Time, simout4.Data(:,2), 'b'), grid on;
figure(10), plot(simout4.Time, simout4.Data(:,2) - simout4.Data(:,1)), grid on;