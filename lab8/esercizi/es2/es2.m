%% Progetto di un controllore PID

close all, clear all;

% Definizione sistema da controllare
s = tf('s');
F = 5 * (1 + s/4) / ((1 + s)^2 * (1 + s/16)^2);

%% Taratura con metodo di Ziegler-Nichols in anello chiuso (classico)

% Verifica margini di F e definizione parametri di partenza
figure(1), margin(F);
Wf = feedback(F,1);
figure(2), step(Wf);
Kp_ = 19;
T_ = 0.45;

% Definizione parametri del regolatore PID
Kp = 0.6*Kp_;
Ti = 0.5*T_;
Td = 0.125*T_;

% Definizione sistema controllato verifiche stabilità e valutazione
% prestazioni
% Genera polo in N/Td = -178 rad/s -> Non influisce quasi su wpi = 11 rad/s
N = 10;
Cpid = Kp * (1 + 1/(Ti*s) + Td*s/(1+Td*s/N));
Gapid = Cpid*F;
figure(3), margin(Gapid);
Wpid = feedback(Gapid, 1);
figure(4), step(Wpid);

% Si ottiene:
%   Pm = 22.9° -> decisamente basso
%   ts = 0.136 s
%   s^_max = 65.2%, t^_max = 0.261 s
%   ta_2% = 1.33 s

%% Taratura con metodo di Ziegler-Nichols in anello chiuso (imposizione Pm)

% Definizione parametri desiderati (Kp_ e T_ dal metodo classico)
Pmdes = 50;
Pmdes_rad = (Pmdes/180)*pi;
Kp_ = 19;
T_ = 0.45;

% Definizione parametri del regolatore PID
Kp = Kp_ * cos(Pmdes_rad);
Ti = (T_/pi) * ((1+sin(Pmdes_rad))/cos(Pmdes_rad));
Td = 0.25 * (T_/pi) * ((1+sin(Pmdes_rad))/cos(Pmdes_rad));

% Definizione sistema controllato verifiche stabilità e valutazione
% prestazioni
% Introduce polo in circa -200 rad/s -> Non influisce quasi su wpi = 14 rad/s
N = 20;
Cpid = Kp * (1 + 1/(Ti*s) + Td*s/(1+Td*s/N));
Gapid = Cpid*F;
figure(1), margin(Gapid);
Wpid = feedback(Gapid, 1);
figure(2), step(Wpid);

% Si ottiene:
%   Pm = 46.7° -> poco inferiore a quello desiderato, con wpi = 14 rad/s
%   ts = 0.116 s -> veloce circa come il caso classico
%   s^_max = 31.3%, t^_max = 0.201 s -> dimezzata rispetto al caso classico
%   ta_2% = 0.62 s -> effetto coda dimezzato rispetto al caso classico