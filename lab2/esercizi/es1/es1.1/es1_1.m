%% Risposta sistemi del I ordine ad ingressi canonici - Impulso unitario

% Definizione funzioni trasferimento
s = tf('s');
G1 = 10 / (s-5);
G2 = 10 / s;
G3 = 10 / (s+5);
G4 = 10 / (s+20);

% Costruzione grafici

% La risposta diverge (infatti polo con parte reale positiva)
% Non si possono valutare costante di tempo e valore finale
figure(1);
impulse(G1);
grid on

% La risposta è limitata (infatti polo con parte reale nulla)
% Non si può valutare la costante di tempo
% Il valore finale coincide col valore costante e con s*G2(s), s->0+
figure(2);
impulse(G2);
grid on

% La risposta converge (infatti polo con parte reale negativa)
% La costante di tempo è pari a 0.2 (s) = -1/p, p = -5
% Il valore finale è pari a 0, infatti s*G3(s) = 0, s->0+
figure(3);
impulse(G3);
grid on

% La risposta converge (infatti polo con parte reale negativa)
% La costante di tempo è pari a 0.05 (s) = -1/p, p = -20
% Il valore finale è pari a 0, infatti s*G4(s) = 0, s->0+
figure(4);
impulse(G4);
grid on