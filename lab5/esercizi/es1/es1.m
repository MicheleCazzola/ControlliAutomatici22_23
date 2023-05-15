%% Progetto di un controllore statico e studio della stabilità

clear all
close all
clc

% Funzione trasferimento
s = tf('s');

F = (s^2 + 11*s + 10)/(s^2 * (s^2 + 4*s + 8));

%% Punto a - Guadagno stazionario, singolarità, fase iniziale e finale

% Kf = s^2 * F(s) = 1.25
Kf = dcgain(s^2 * F);

% Singolarità:
% - zeri: -1, -10
% - poli: uso damp -> {0 (2), -2 + 2i (z = 0.707, wn = 2.83 rad/s), -2 - 2i(z = 0.707, wn = 2.83 rad/s)}
damp(F);

% Fasi:
% - iniziale: -180° (doppio polo nell'origine con Kf > 0)
% - finale: -180°[ = -180° + 2*90° (doppio zero stabile) - 2*90 (doppio polo stabile)]

%% Diagrammi di Bode
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
bode(F), grid on;
