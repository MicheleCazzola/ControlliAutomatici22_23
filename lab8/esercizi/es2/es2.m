%% Progetto di un controllore PID

close all, clear all;

% Definizione sistema da controllare
s = tf('s');
F = 5 * (1 + s/4) / ((1 + s)^2 * (1 + s/16)^2);

%% Taratura con metodo di Ziegler-Nichols in anello chiuso

% Verifica margini di F e definizione parametri di partenza
figure, margin(F);
Wf = feedback(F,1);
figure, step(Wf);
Kp_ = 19;
T_ = 0.45;

% Definizione parametri del regolatore PID
Kp = 0.6*Kp_;
Ti = 0.5*T_;
Td = 0.125*T_;

% Definizione sistema controllato verifiche stabilità e valutazione
% prestazioni
N = 10;
Cpid = Kp * (1 + 1/(Ti*s) + Td*s/(1+Td*s/N));
Gapid = Cpid*F;
figure, margin(Gapid);
Wpid = feedback(Gapid, 1);
figure, step(Wpid);

% Si ottiene:
%   Pm = 22.9° -> decisamente basso
%   ts = 0.136 s
%   s^_max = 65.2%, t^_max = 0.261 s
%   ta_2% = 1.33 s
