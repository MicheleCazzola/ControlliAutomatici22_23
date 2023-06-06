%% Progetto di un controllore digitale per un motore elettrico

clear all, close all

% Parametri del motore elettrico

s=tf('s');

Ra=6;
La=3.24e-3;
Km=0.0535;
J=19.74e-6;
Beta=17.7e-6;
Kf=14e-3;
Kpwm=2.925;
Rs=7.525;
Kt=0.02;                % guadagno della dinamo tachimetrica
tau_a=0.001;


F=402.5/(s*(1+s/0.8967)); % f.d.t. motore fra  u e velocita' angolare
Fd=-56500/(1+s/0.8967);   % f.d.t. motore fra Td e velocita' angolare

Td=-1e-4; %da cambiare a seconda dei casi

%% Specifiche statiche
h = 0;
Kf = dcgain(s*F);
Kcmin = 1/(Kt*0.05*Kf);     % Kcmin = 3

figure(1), bode(F), grid on;

% Non è a stabilità regolare, si usa nyquist
figure(2), nyquist(F);

% Si sceglie Kc > 0
Kc = 3;
%% Specifiche dinamiche
smax = 0.25;
Mrmax = (1+smax)/0.9;
Pmmin = 60 - 5*(20*log10(Mrmax));     % da Nichols circa 42°
tsdes = 0.5;
wcdes = 3*0.63/tsdes;

F_primo = Kt*F;
[m0, f0] = bode(F_primo, wcdes);   % serve recupero di fase di circa 31°

%% Progetto controllore
% Rete anticipatrice: due reti da 2 che puntano a recuperare 40°
md = 2;
xd = sqrt(md);
taud = xd/wcdes;
Rd = (1+taud*s)/(1+taud*s/md);
Ga1 = Rd^2*Kc*F_primo;
[m1,f1] = bode(Ga1,wcdes);

% Rete attenuatrice: rete da 3
mi = 3;
xi = 70;
taui = xi/wcdes;
Ri = (1+taui*s/mi)/(1+taui*s);
Ga2 = Ri*Ga1;
[m2, f2] = bode(Ga2, wcdes);

C = Kc*Rd^2*Ri;
figure(3), margin(Ga2), grid on;
W = feedback(Ga2, 1);
figure(4), step(W);

%% Verifica attività sul comando: controllore tipo 0 -> Analiticamente
U = Kc*md^2/mi;

%% Discretizzazione

figure(5), bode(W), grid on;

wb = 6.2;
alfa = 20;
Ts = 2*pi/(alfa*wb);

Gazoh = Ga2/(1+s*Ts/2);
figure(5), margin(Gazoh), grid on;  % si perdono 5° circa -> si sceglie Ts = 0.01

Ts = 0.01;

Gazoh = Ga2/(1+s*Ts/2);
figure(5), margin(Gazoh), grid on;

Czt = c2d(C, Ts, 'tustin');
Czz = c2d(C, Ts, 'zoh');
Czm = c2d(C, Ts, 'matched');
C_discreto = Czz;       % garantisce sovraelongazione minore

%% Verifica specifiche complete
Cd = C_discreto;