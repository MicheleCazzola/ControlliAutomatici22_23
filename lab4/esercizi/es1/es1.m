%% Simulazione motore elettrico controllato in velocità

clear all
close all
clc

% Definizione sistema

s = tf('s');

Ra = 1;         % ohm
La = 6e-3;      % H
Km = 0.5;       % V*s/rad = N*m/A
J = 0.1;        % kg*m^2
beta = 0.02;    % N*s/m
Ka = 10;

F1 = (Ka * Km) / (s^2 * J * La + s * (beta * La + J * Ra) + beta * Ra + Km^2);
F2 = -(s * La + Ra) / (s^2 * J * La + s * (beta * La + J * Ra) + beta * Ra + Km^2);

% Definizione controllore
Kc = 5;       % Proporzionale: 0.1, 1, 5 -> 
% Senza disturbi: asintotica stabilità, errore finito non nullo (decresce in media all'aumentare di Kc),
% sovraelongazione per Kc = 5
% Con disturbi: semplice stabilità, errore finito non nullo (decresce in media all'aumentare di Kc)
% sovraelongazione per Kc = 0.1, 5

% Definizione funzione di trasferimento ingresso di riferimento - uscita
Kc_v = [0.1, 1, 5];
Wy(1) = feedback(Kc_v(1) * F1, 1);
Wy(2) = feedback(Kc_v(2) * F1, 1);
Wy(3) = feedback(Kc_v(3) * F1, 1);
damp(Wy(1));
damp(Wy(2));
damp(Wy(3));
figure(1);                            % w_rif(s) ha pulsazione di circa 0.63 rad/s -> sempre in banda passante -> 
bode(Wy(1), Wy(2), Wy(3)), grid on;   % il guadagno aumenta all'aumentare di Kc rimanendo sempre < 1 ->
                                      % infatti l'errore diminuisce all'aumentare di Kc
