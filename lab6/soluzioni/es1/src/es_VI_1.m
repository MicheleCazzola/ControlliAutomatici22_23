%% Esercitazione di laboratorio #6 - Controlli Automatici
% *Esercizio #1*
%
% Autori: M. Indri, M. Taragna (ultima modifica: 17/05/2020)

%% Comandi di pulizia iniziali

clear all, close all

%% Definizione del sistema

s=tf('s');
F=(s+10)/(s^3+45*s^2-250*s)

%% Punto a): studio di F(s)

% Guadagno stazionario di F(s)
Kf=dcgain(s*F)   % F(s) ha 1 polo nell'origine

% Zeri e poli di F(s)
zeri=zero(F)
poli=pole(F)
damp(F)

% Diagrammi di Bode di F(jw) (valutazione fase iniziale e finale)
bode(F)

%% Punti b) e c): studio di Ga(s) per Kc = 1

Kc=1
Kr=2
Ga1=Kc*F/Kr

% Diagrammi di Bode di Ga1(jw)
figure, bode(Ga1)

% Diagramma di Nyquist di Ga1(jw), da ingrandire opportunamente
% per valutare le ascisse dei punti di attraversamento dell'asse reale 
%(in -1.557e-3 e 0)

figure, nyquist(Ga1)


%% Punto d): calcolo di W(s) e dei suoi poli per Kc=800 dopo studio della stabilità

% Dallo studio della stabilità in catena chiusa con il criterio di Nyquist:
% n_ia = 1
% n_ic = 2 per 0 < Kc < 642
% n_ic = 0 (asintotica stabilità) per Kc > 642
% n_ic = 1 per qualunque Kc < 0

Kc=800
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
% perché il sistema è di tipo 1

% effetto del disturbo d1 costante sull'uscita pari a d1/(Kc/Kr) perché ci sono poli
% nell'origine solo nel blocco a valle del disturbo

% effetto del disturbo d2 costante sull'uscita NULLO perché c'è almeno un
% polo nell'origine nel blocco a monte del disturbo

errore_r=dcgain(s*We*1/s^2)
effetto_d1=dcgain(s*Wd1*0.1/s)
effetto_d2=dcgain(s*Wd2*0.5/s)
errore_tot=errore_r-(effetto_d1+effetto_d2)

open_system('es_VI_1_1')
sim('es_VI_1_1')

%% Caso e.2): r(t)=2, d1(t)=0, d2(t)=0.01t

% errore intrinseco di inseguimento a r(t) = 2 NULLO perché il sistema è di
% tipo 1

% effetto del disturbo d1 NULLO essendo nullo il disturbo

% effetto del disturbo d2 = alfa_d2*t (rampa) sull'uscita pari ad alfa_d2/KGa = alfa_d2/(Kc*Kf/Kr) 
% perché il sistema è di tipo 1

errore_r=dcgain(s*We*2/s)
effetto_d1=dcgain(s*Wd1*0)
effetto_d2=dcgain(s*Wd2*0.01/s^2)
errore_tot=errore_r-(effetto_d1+effetto_d2)

open_system('es_VI_1_2')
sim('es_VI_1_2')