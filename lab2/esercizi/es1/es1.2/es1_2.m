%% Risposta sistemi del I ordine ad ingressi canonici - Gradino unitario

% Definizione funzioni trasferimento
s = tf('s');
G1 = 10 / (s-5);        % Y1(s) = 10 / (s(s-5))
G2 = 10 / s;            % Y2(s) = 10 / (s^2)
G3 = 10 / (s+5);        % Y3(s) = 10 / (s(s+5))
G4 = 10 / (s+20);       % Y4(s) = 10 / (s(s+20))

% Costruzione grafici

% La risposta diverge (infatti polo con parte reale positiva)
% Non si possono valutare costante di tempo e valore finale
figure(1);
step(G1);
grid on

% La risposta diverge linearmente (infatti polo con parte reale nulla)
% Non si possono valutare costante di tempo e valore finale
figure(2);
step(G2);
grid on

% La risposta converge (infatti polo con parte reale negativa)
% La costante di tempo è pari a 0.2 (s) = -1/p, p = -5
% Il valore finale è pari a 2, infatti s*Y3(s) = 2, s->0+
figure(3);
step(G3);
grid on

% La risposta converge (infatti polo con parte reale negativa)
% La costante di tempo è pari a 0.05 (s) = -1/p, p = 20
% Il valore finale è pari a 0.5, infatti s*Y3(s) = 0.5, s->0+
figure(4);
step(G4);
grid on