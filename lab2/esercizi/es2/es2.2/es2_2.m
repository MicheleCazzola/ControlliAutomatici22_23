%% Risposta al gradino di sistemi del II ordine - Due poli reali e uno zero reale

%% Punto a - Zeri positivi: presenta sottoelongazione

s = tf('s');
z = [100, 10, 1, 0.5];

for i=1:1:length(z)
    G4 = (5*(s-z(i)) / (-z(i)*(s+1)*(s+5)));
    
    figure(i);
    step(G4);
    grid on
end

% z = 100
% Valore finale: 1
% Tempo di salita: 2.27 s
% Tempo di assestamento al 5%: 3.23 s

% z = 10
% Valore finale: 1
% Tempo di salita: 2.27 s
% Tempo di assestamento al 5%: 3.3 s

% z = 1
% Valore finale: 1
% Tempo di salita: 2.21 s
% Tempo di assestamento al 5%: 3.49 s

% z = 0.5
% Valore finale: 1
% Tempo di salita: 2.2 s
% Tempo di assestamento al 5%: 3.54 s

%% Punto b - Zeri negativi con modulo inferiore al modulo del polo più lento: presenta sovraelongazione

s = tf('s');
z = [-0.9, -0.5, -0.1];

for i=1:1:length(z)
    G4 = (5*(s-z(i)) / (-z(i)*(s+1)*(s+5)));
    
    figure(i);
    step(G4);
    grid on
    
end

% z = -0.9
% Valore finale: 1
% Tempo di salita: 0.331 s
% Tempo di assestamento al 5%: 0.417 s (precede il tempo di picco)
% Tempo di picco: 0.921 s
% Sovraelongazione massima: 4.39 %

% z = -0.5
% Valore finale: 1
% Tempo di salita: 0.115 s
% Tempo di assestamento al 5%: 3.22 s
% Tempo di picco: 0.533 s
% Sovraelongazione massima: 57.7 %

% z = -0.1
% Valore finale: 1
% Tempo di salita: 0.017 s
% Tempo di assestamento al 5%: 3.64 s
% Tempo di picco: 0.424 s
% Sovraelongazione massima: 589 %

%% Punto c - Zeri negativi con modulo superiore al modulo del polo più lento

s = tf('s');
z = [-100, -10, -2];

for i=1:1:length(z)
    G4 = (5*(s-z(i)) / (-z(i)*(s+1)*(s+5)));
    
    figure(i);
    step(G4);
    grid on
    
end

% z = -100 (analogo al caso di z=100 per sfera di Riemann)
% Valore finale: 1
% Costante di tempo equivalente: 1.19 s
% Costante di tempo reale al 63%: 1.2 s
% Tempo di salita: 2.27 s
% Tempo di assestamento al 5%: 3.21 s

% z = -10
% Valore finale: 1
% Costante di tempo equivalente: 1.1 s
% Costante di tempo reale al 63%: 1.11 s
% Tempo di salita: 2.26 s
% Tempo di assestamento al 5%: 3.11 s

% z = -2
% Valore finale: 1
% Costante di tempo equivalente: 0.7 s
% Costante di tempo reale al 63%: 0.589 s
% Tempo di salita: 1.79 s
% Tempo di assestamento al 5%: 2.53 s