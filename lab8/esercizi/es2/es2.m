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
%   ts = 0.136 s -> veloce
%   s^_max = 65.2%, t^_max = 0.261 s -> elevata
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

%% Metodo di Ziegler-Nichols in anello aperto

% Valutazione risposta al gradino di F
figure(1), step(F, 8), grid on;

% Definizione parametri nel tempo
Kf = 5;
thetaf = 0.24;
T = 2.08;
tauf = T - thetaf;

% Definizione e valutazione approssimazione
Fapprox = Kf*exp(-thetaf*s)/(1 + tauf*s);
figure(2), step(Fapprox, F), grid on;

%% Metodo della tangente
% Definizione regolatore
Kp = 1.2*tauf/(Kf*thetaf);
Ti = 2*thetaf;
Td = 0.5*thetaf;

% Introduce polo in -125 rad/s -> Non influisce quasi su wpi = 3.3 rad/s
N = 15;
Cpid = Kp * (1 + 1/(Ti*s) + Td*s/(1+Td*s/N));

Gapid = Cpid*F;
figure(3), margin(Gapid);
Wpid = feedback(Gapid, 1);
figure(4), step(Wpid);

% Si ottiene:
%   Pm = 36.8° -> superiore al caso in anello chiuso, con wpi = 3.3 rad/s
%   ts = 0.451 s -> più lento del metodo classico in anello aperto
%   s^_max = 37.5%, t^_max = 0.885 s -> superiore al caso in anello aperto
%   ta_2% = 4.25 s -> effetto coda molto elevato

%% Metodo di Cohen-Coon

% Definizione regolatore
Kp = (16*tauf+3*thetaf)/(12*Kf*thetaf);
Ti = thetaf*(32*tauf+6*thetaf)/(13*tauf+8*thetaf);
Td = 4*thetaf*tauf/(11*tauf+2*thetaf);

% Introduce polo in -59 rad/s -> Non influisce quasi su wpi = 3.6 rad/s
N = 5;
Cpid = Kp * (1 + 1/(Ti*s) + Td*s/(1+Td*s/N));

Gapid = Cpid*F;
figure(3), margin(Gapid);
Wpid = feedback(Gapid, 1);
figure(4), step(Wpid);

% Si ottiene:
%   Pm = 37.1° -> simile al caso precedente, con wpi = 3.6 rad/s
%   ts = 0.421 s -> simile al caso precedente
%   s^_max = 37.8%, t^_max = 0.81 s -> simile al caso precedente
%   ta_2% = 3.22 s -> effetto coda diminuito

%% Metodo IMC

% Definizione regolatore
Tf = 0.1;
Kp = (tauf+0.5*thetaf)/(Kf*(0.5*thetaf+Tf));
Ti = tauf+0.5*thetaf;
Td = 0.5*thetaf*tauf/(0.5*thetaf+tauf);

% Introduce polo in -44 rad/s -> Non influisce quasi su wpi = 3.25 rad/s
N = 5;
Cpid = Kp*(1 + 1/(Ti*s) + Td*s/(1+Td*s/N));

Gapid = Cpid*F;
figure(3), margin(Gapid);
Wpid = feedback(Gapid, 1);
figure(4), step(Wpid), grid on;

% Si ottiene:
%   Pm = 61.7° -> simile al caso precedente, con wpi = 3.25 rad/s
%   ts = 0.978 s -> più lento dei casi precedenti
%   s^_max = 8.38%, t^_max = 1.44 s -> inferiore ai casi precedenti
%   ta_2% = 3.41 s -> effetto simile al caso precedente, comunque elevato