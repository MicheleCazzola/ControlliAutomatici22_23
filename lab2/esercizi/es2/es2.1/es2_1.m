%% Risposta al gradino sistemi del II ordine - Due poli reali e nessuno zero

% Definizione funzioni
s = tf('s');
G1 = 20 / ((s+1)*(s+10));           % Y1 = 20 / (s*(s+1)*(s+10))
G2 = 2 / (s+1)^2;                   % Y2 = 2 / (s*(s+1)^2)
G3 = 0.2 / ((s+1)*(s+0.1));         % Y3 = 0.2 / (s*(s+1)*(s+0.1))

% Costruzione grafici

% Risposta converge a valore finito
% Parte con tangente orizzontale
% Valore finale: 2, infatti s*Y1(s) = 2, s->0+
% Costante di tempo equivalente: 1.1 s
% Costante di tempo reale al 63%: 1.11 s
% Tempo salita: 2.22 s
% Tempo di assestamento al 5%: 3.1 s
figure(1);
step(G1);
grid on

% Risposta converge a valore finito
% Parte con tangente orizzontale
% Valore finale: 2, infatti s*Y1(s) = 2, s->0+
% Costante di tempo equivalente: 2 s
% Costante di tempo reale al 63%: 2.14 s
% Tempo salita: 3.36 s
% Tempo di assestamento al 5%: 4.74 s;
figure(2);
step(G2);
grid on

% Risposta converge a valore finito
% Parte con tangente orizzontale
% Valore finale: 2, infatti s*Y1(s) = 2, s->0+
% Costante di tempo equivalente: 11 s
% Costante di tempo reale al 63%: 11 s
% Tempo salita: 22.2 s
% Tempo di assestamento al 5%: 31 s;
figure(3);
step(G3);
grid on