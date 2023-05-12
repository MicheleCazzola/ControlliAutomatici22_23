%% Esercitazione di laboratorio #5 - Controlli Automatici
% *Esercizio #1*
%
% Autori: M. Indri, M. Taragna (ultima modifica: 11/05/2020)
%% Comandi di pulizia iniziali

clear all, close all, clc

%% Definizione del sistema

s=tf('s');
F=(s^2+11*s+10)/(s^4+4*s^3+8*s^2)
Kr=1;

%% Punto a): studio di F(s)

% Guadagno stazionario di F(s)
Kf=dcgain(s^2*F)   % F(s) ha 2 poli nell'origine

% Zeri e poli di F(s)
zero(F)
pole(F)
damp(F)

% Diagrammi di Bode di F(jw)
bode(F)

%% Punti b) e c): studio di Ga(s)

Kc=1
Ga=Kc*F/Kr

% Diagrammi di Bode di Ga(jw)
figure, bode(Ga)

% Diagramma di Nyquist di Ga(jw), con ingrandimento
% in corrispondenza degli attraversamenti dell'asse reale
figure, nyquist(Ga)

w=logspace(0,3,1000);
figure, nyquist(Ga,w)

%% Punto d): calcolo di W(s) e dei suoi poli

W=feedback(Kc*F,1/Kr)
damp(W)

%% Punto e): errore di inseguimento in regime permanente
% Nota bene: il sistema di controllo e' di tipo 2

We=Kr*feedback(1,Ga)
Wd1=feedback(F,Kc/Kr)
Wd2=feedback(1,Ga)

%% Caso e.1): r(t)=t, d1(t)=0.1, d2(t)=0.5

% errore intrinseco di inseguimento a r(t) = t NULLO perché il sistema è di
% tipo 2

% effetto del disturbo d1 costante sull'uscita pari a d1/(Kc/Kr) perché ci sono poli
% nell'origine solo nel blocco a valle del disturbo

% effetto del disturbo d2 costante sull'uscita NULLO perché c'è almeno un
% polo nell'origine nel blocco a monte del disturbo

errore_r=dcgain(s*We*1/s^2)
effetto_d1=dcgain(s*Wd1*0.1/s)
effetto_d2=dcgain(s*Wd2*0.5/s)
errore_tot=errore_r-(effetto_d1+effetto_d2)

open_system('es_V_1')
sim('es_V_1')

%% Caso e.2): r(t)=2t, d1(t)=0, d2(t)=0.01t

% errore intrinseco di inseguimento a r(t) = 2t NULLO perché il sistema è di
% tipo 2

% effetto del disturbo d1 NULLO essendo nullo il disturbo

% effetto del disturbo d2 a rampa sull'uscita NULLO perché il sistema è di
% tipo 2

errore_r=dcgain(s*We*2/s^2)
effetto_d1=dcgain(s*Wd1*0)
effetto_d2=dcgain(s*Wd2*0.01/s^2)
errore_tot=errore_r-(effetto_d1+effetto_d2)

open_system('es_V_2')
sim('es_V_2')

%% Caso e.3):  r(t)=t^2/2, d1(t)=0, d2(t)=0

% errore intrinseco di inseguimento a r(t) = t^2/2 pari a Kr/KGa (con KGa = Kc*Kf/Kr)
% perché il sistema è di tipo 2

% effetto del disturbo d1 NULLO essendo nullo il disturbo

% effetto del disturbo d2 NULLO essendo nullo il disturbo

errore_r=dcgain(s*We*1/s^3)
effetto_d1=dcgain(s*Wd1*0)
effetto_d2=dcgain(s*Wd2*0)
errore_tot=errore_r-(effetto_d1+effetto_d2)

open_system('es_V_3')
sim('es_V_3')

%% Caso e.4):  r(t)=t^2/2, d1(t)=0.1, d2(t)=0.2

% errore intrinseco di inseguimento a r(t) = t^2/2 pari a Kr/KGa (con KGa = Kc*Kf/Kr)
% perché il sistema è di tipo 2

% effetto del disturbo d1 costante sull'uscita pari a d1/(Kc/Kr) perché ci sono poli
% nell'origine solo nel blocco a valle del disturbo

% effetto del disturbo d2 costante sull'uscita NULLO perché c'è almeno un
% polo nell'origine nel blocco a monte del disturbo

errore_r=dcgain(s*We*1/s^3)
effetto_d1=dcgain(s*Wd1*0.1/s)
effetto_d2=dcgain(s*Wd2*0.2/s)
errore_tot=errore_r-(effetto_d1+effetto_d2)

open_system('es_V_4')
sim('es_V_4')