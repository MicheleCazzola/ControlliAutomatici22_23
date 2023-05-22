%% Esercitazione di laboratorio #6 - Controlli Automatici
% *Esercizio #2*
%
% Autori: M. Indri, M. Taragna (ultima modifica: 17/05/2020)

%% Comandi di pulizia iniziali

clear all, close all

%% Definizione del sistema

s=tf('s');
F=(s-1)/((s+0.2)*(s^3+2.5*s^2+4*s))

%% Punto a): studio di F(s)

% Guadagno stazionario di F(s)
Kf=dcgain(s*F)   % F(s) ha 1 polo nell'origine

% Zeri e poli di F(s)
zeri=zero(F)
poli=pole(F)
damp(F)

% Diagrammi di Bode di F(jw)(valutazione fase iniziale e finale)
bode(F)

%% Punti b) e c): studio di Ga(s) per Kc = 1

Kc = 1
Kr=0.5
Ga1=Kc*F/Kr

% Diagrammi di Bode di Ga1(jw)
figure, bode(Ga1)

% Diagramma di Nyquist di Ga1(jw), da ingrandire opportunamente
% in corrispondenza degli attraversamenti dell'asse reale
% (in +4, -0.109 e 0)

figure, nyquist(Ga1)

w=logspace(-1,3,5000);
figure,nyquist(Ga1,w)

%% Punto d): calcolo di W(s) e dei suoi poli per Kc = -0.1 dopo studio della stabilit�

% Dallo studio della stabilit� in catena chiusa con il criterio di Nyquist:
% n_ia = 0
% n_ic = 1 per 0 < Kc < 9.17
% n_ic = 3 per Kc > 9.17
% n_ic = 0 (asintotica stabilit�) per -0.25 < Kc < 0
% n_ic = 2 per Kc < -0.25

Kc=-0.1
Ga=Kc*F/Kr;
W=feedback(Kc*F,1/Kr)
damp(W)

%% Punto e): errore di inseguimento in regime permanente
% Nota bene: il sistema di controllo e' di tipo 1

We=Kr*feedback(1,Ga)
Wd1=feedback(F,Kc/Kr)
Wd2=feedback(1,Ga)

%% Caso e.1): r(t)=t, d1(t)=0.1, d2(t)=0.5

% errore intrinseco di inseguimento a r(t) = t pari a Kr/KGa = Kr/(Kc*Kf/Kr) 
% perch� il sistema � di tipo 1

% effetto del disturbo d1 costante sull'uscita pari a d1/(Kc/Kr) perch� ci sono poli
% nell'origine solo nel blocco a valle del disturbo

% effetto del disturbo d2 costante sull'uscita NULLO perch� c'� almeno un
% polo nell'origine nel blocco a monte del disturbo

errore_r=dcgain(s*We*1/s^2)
effetto_d1=dcgain(s*Wd1*0.1/s)
effetto_d2=dcgain(s*Wd2*0.5/s)
errore_tot=errore_r-(effetto_d1+effetto_d2)

open_system('es_VI_2_1')
sim('es_VI_2_1')

%% Caso e.2): r(t)=2, d1(t)=0.1, d2(t)=0.01t

% errore intrinseco di inseguimento a r(t) = 2 NULLO perch� il sistema � di
% tipo 1

% effetto del disturbo d1 costante sull'uscita pari a d1/(Kc/Kr) perch� ci sono poli
% nell'origine solo nel blocco a valle del disturbo

% effetto del disturbo d2 = alfa_d2*t (rampa) sull'uscita pari ad alfa_d2/KGa = alfa_d2/(Kc*Kf/Kr) 
% perch� il sistema � di tipo 1

errore_r=dcgain(s*We*2/s)
effetto_d1=dcgain(s*Wd1*0.1/s)
effetto_d2=dcgain(s*Wd2*0.01/s^2)
errore_tot=errore_r-(effetto_d1+effetto_d2)

open_system('es_VI_2_2')
sim('es_VI_2_2')