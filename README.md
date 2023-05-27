# Laboratori controlli automatici A.A. 2022/23

**Laboratorio 1 - 21/03/2023**
- ***Esercizio 1:*** simulazione di sistemi dinamici LTI
	- *Punto a*: sistema meccanico
	- *Punto b*: sistema elettrico
- ***Esercizio 2:*** calcolo di una funzione di trasferimento
- ***Esercizio 3:*** calcolo di una risposta nel tempo mediante trasformata di Laplace
# 
**Laboratorio 2 - 04/04/2023**
- ***Esercizio 1:*** risposta di sistemi del I ordine ad ingressi canonici
	- *Punto 1*: risposta all'impulso unitario
	- *Punto 2*: risposta al gradino unitario
- ***Esercizio 2:*** risposta al gradino di sistemi del II ordine
	- *Punto 1*: risposta di sistemi con due poli reali e nessuno zero
	- *Punto 2*: risposta di un sistema con due poli reali e uno zero
	- *Punto 3*: risposta di un sistema con due poli complessi coniugati e nessuno zero
- ***Esercizio 3:*** stabilità di sistemi dinamici LTI
	- *Punto 1*: sistema a tempo continuo
	- *Punto 2*: sistema a tempo discreto
# 
**Laboratorio 3 - 02/05/2023**
- ***Esercizio 1:*** posizionamento dei poli mediante retroazione degli stati
- ***Esercizio 2:*** progetto di un osservatore dello stato
- ***Esercizio 3:*** posizionamento dei poli mediante regolatore
# 
**Laboratorio 4 - 09/05/2023**  
- ***Esercizio 1:*** progetto di un motore controllato in velocità
	- *Punto 1*: simulazione del sistema in catena aperta
	- *Punto 2*: simulazione del sistema in catena chiusa
- ***Esercizio 2:*** progetto di un motore controllato in posizione
	- *Punto 1*: simulazione del sistema in catena aperta
	- *Punto 2*: simulazione del sistema in catena chiusa
# 
**Laboratorio 5 - 16/05/2023** 
- ***Esercizio 1:*** progetto di un controllore statico e studio della stabilità
	- *Punto a*: determinazione guadagno stazionario, fase iniziale e fase finale del sistema LTI
	- *Punto b*: disegno a mano dei diagrammi di Bode della funzione d'anello e verifica su Matlab
	- *Punto c*: disegno diagramma di Nyquist con l'ausilio di Matlab
	- *Punto d*: verifica asintotica stabilià ad anello chiuso con criterio di Nyquist
	- *Punto e*: calcolo errore di inseguimento con riferimenti e disturbi differenti
	- *Facoltativo*: studio stabilità ad anello chiuso mediante applicazione del criterio di Nyquist
# 
**Laboratorio 6 - 23/05/2023**  
- ***Esercizio 1:*** progetto di un controllore statico e studio della stabilità
  	- *Punto a*: determinazione guadagno stazionario, fase iniziale e fase finale del sistema LTI
	- *Punto b*: disegno a mano dei diagrammi di Bode della funzione d'anello e verifica su Matlab
	- *Punto c*: disegno diagramma di Nyquist con l'ausilio di Matlab
	- *Punto d*: verifica asintotica stabilià ad anello chiuso con criterio di Nyquist, al variare del guadagno K<sub>c</sub>
	- *Punto e*: calcolo errore di inseguimento con riferimenti e disturbi differenti
	- *Punto f*: verifica risultati ottenuti con modello Simulink
- ***Esercizio 2:*** progetto di un controllore statico e studio della stabilità
  	- *Punto a*: determinazione guadagno stazionario, fase iniziale e fase finale del sistema LTI
	- *Punto b*: disegno a mano dei diagrammi di Bode della funzione d'anello e verifica su Matlab
	- *Punto c*: disegno diagramma di Nyquist con l'ausilio di Matlab
	- *Punto d*: verifica asintotica stabilià ad anello chiuso con criterio di Nyquist, al variare del guadagno K<sub>c</sub>
	- *Punto e*: calcolo errore di inseguimento con riferimenti e disturbi differenti
	- *Punto f*: verifica risultati ottenuti con modello Simulink
#
**Laboratorio 7 - 30/05/2023**
- ***Esercizio 1:*** progetto di un controllore analogico mediante sintesi per tentativi
  -	Soddisfare le specifiche sui seguenti parametri:
	  - *a)*: errore di inseguimento
	  - *b)*: effetto di un disturbo posto sull'uscita
	  - *c)*: banda passante del sistema retroazionato
	  - *d)*: picco di risonanza della risposta in frequenza ad anello chiuso
  -	Verificare il rispetto di tali specifiche
  -	Valutare:
	  - *a)*: errore di inseguimento massimo in regime permanente, con riferimento dato
	  - *b)*: attenuazione di disturbi dati, oltre pulsazione nota
- ***Esercizio 2:*** progetto di un controllore analogico mediante sintesi per tentativi
  -	Soddisfare le specifiche sui seguenti parametri:
	  - *a)*: errore di inseguimento
	  - *b)*: effetto di un disturbo posto sull'uscita
	  - *c)*: tempo di salita della risposta al gradino unitario
	  - *d)*: sovraelongazione massima della risposta al gradino unitario
  -	Verificare il rispetto di tali specifiche
  -	Valutare:
	  - *a)*: attività massima sul comando, con riferimento dato
	  - *b)*: banda passante e picco di risonanza della risposta in frequenza ad anello chiuso
#
**Laboratorio 8 - 06/06/2023**   
- ***Esercizio 1:*** progetto di un controllore digitale per un motore elettrico
  -	Progettare il controllore digitale, soddisfando le specifiche sui seguenti parametri:
	  -	*a)*: errore di inseguimento a riferimento costante
	  -	*b)*: errore di inseguimento a riferimento a rampa
	  -	*c)*: sovraelongazione massima della risposta al gradino unitario
	  -	*d)*: tempo di salita della risposta al gradino unitario
  -	Progettare il controllore analogico, sulla base del modello semplificato
  -	*Verifica 1*:
	  -	verificare il rispetto delle specifiche, sulla base del modello semplificato
	  -	valutare l'attività massima sul comando
  -	*Verifica 2*:
	  -	verificare il rispetto delle specifiche, sulla base del modello completo
	  -	confrontare il comportamento con modello completo e con modello semplificato
- ***Esercizio 2:*** progetto di un controllore PID
  -	*Punto a*: progettare il controllore
  -	*Punto b*: valutare tempo di salita e sovraelongazione massima della risposta al gradino del sistema retroazionato
