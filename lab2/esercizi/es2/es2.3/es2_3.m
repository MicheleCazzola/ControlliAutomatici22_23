%% Risposta al gradino di sistemi del II ordine - Due poli complessi coniugati e nessuno zero

s = tf('s');

w = [2, 2, 1];
z = [0.5, 0.25, 0.5];

for i=1:1:length(z)
    G5 = (w(i)^2) / (s^2 + 2*z(i)*w(i)*s + w(i)^2);
    
    figure(i);
    step(G5);
    grid on
end

% w = 2, z = 0.5
% Valore finale: 1
% Tempo di salita: 1.21 s (teorico = 1.2092 s)
% Tempo di picco: 1.8 s
% Sovraelongazione massima: 16.3% (teorica = 0.163)
% Tempo di assestamento al 5%: 2.64 s

% w = 2, z = 0.25
% Valore finale: 1
% Tempo di salita: 0.942 s (teorico = 0.9416 s)
% Tempo di picco: 1.66 s
% Sovraelongazione massima: 44.3% (teorica = 0.4443)
% Tempo di assestamento al 5%: 5.39 s

% w = 1, z = 0.5
% Valore finale: 1
% Tempo di salita: 2.42 s (teorico = 2.4184 s)
% Tempo di picco: 3.59 s
% Sovraelongazione massima: 16.3% (teorica = 0.163)
% Tempo di assestamento al 5%: 5.29 s
