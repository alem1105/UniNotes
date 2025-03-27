# Stop and Wait
In questo meccanismo sia mittente che destinatario hanno una finestra scorrevole di un solo pacchetto, quindi:
- Il mittente invia un pacchetto e attende il suo ACK prima di inviarne un altro.
- Quando il pacchetto arriva, il destinatario calcola il suo checksum e se corretto invia un ACK altrimenti lo scarta e non informa il mittente
- Il mittente capisce che il pacchetto non è stato ricevuto correttamente tramite un timer.

Questo significa che il mittente deve tenere una copia del pacchetto fino a che non riceve il suo ACK.

Questo meccanismo garantisce quindi:
- Controllo errori: Tramite il **numero di sequenza** dei pacchetti, l'ACK e il timer
- Controllo del flusso: Non è possibile inviare più di un pacchetto quindi non possono arrivare in ordine sparso.

Per gestire i duplicati, lo stop and wait utilizza i numeri di sequenza, in questo caso 0 ed 1 sono sufficienti per il meccanismo.

Quando viene ricevuto un pacchetto si invia un ACK con il numero di sequenza successivo, quindi se ricevo 0 invio ACK 1 e se ricevo 1 invio ACK 0, questo sta ad indicare qualche pacchetto sta aspettando.

_FSM che rappresenta il Mittente_

![[Pasted image 20250327215751.png]]

Quindi invia un pacchetto e aspetta o un riscontro o la fine del timer prima di inviarne un altro.

_FSM che rappresenta il Destinatario_

![[Pasted image 20250327215841.png]]

Lui è sempre pronto a ricevere pacchetti, non va mai in stato di blocked.

## Efficienza
Quanto è efficiente questo meccanismo?

Prendiamo ad esempio un sistema che ha:
- Rate = `1Mbps`
- Ritardo di andata e ritorno di 1 bit = `20 ms`

Abbiamo un valore di `rate * ritardo = 20'000 bit/ms`

I pacchetti hanno dimensione `1000bit` quindi significa che l'utilizzo del canale è `1000 / 20000 = 5%` dato che possiamo inviare un solo pacchetto alla volta. Abbiamo quindi una rete molto inefficiente.

---

Utilizziamo quindi i **protocolli con pipeline** ovvero dove il mittente può inviare più di un pacchetto alla volta. Vediamo **Go-Back-N** e **Ripetizione Selettiva**

# Go Back N
In questo meccanismo i numeri di sequenza sono calcolati modulo $2^m$ dove $m$ è la dimensione del numero di sequenza in bit.

Anche qui inviamo gli ACK con il numero successivo a quello ricevuto, ovvero quello che stiamo aspettando, la differenza è che qui usiamo un **ACK cumulativo** ovvero tutti i pacchetti fino al numero di sequenza indicato nell'ACK sono stati ricevuti correttamente.

Quindi se ACK = 7 significa che fino a 6 è stato tutti ricevuto e si sta aspettando il pacchetto 7.

La nostra finestra di scorrimento per l'invio non è più quindi da un solo slot:

![[Pasted image 20250327221329.png]]

- `Sf` indica il primo inviato, per il quale stiamo ancora aspettando un ACK
- `Sn` indica il prossimo da inviare appena possibile.

Quindi se ad esempio arriva un ACK = 6

![[Pasted image 20250327221435.png]]

---

Per quanto riguarda la finestra di ricezione invece rimaniamo con un solo slot. Il destinatario è sempre in attesa di un solo pacchetto e qualsiasi arriva fuori sequenza viene scartato.

Quindi se ad esempio siamo in attesa di 5 e arrivano 6,7 questi verranno scartati e dovranno essere rinviati successivamente.

Qui entra il gioco il timer, infatti questo viene mantenuto per il più vecchio pacchetto inviato e per il quale non abbiamo ancora ricevuto un ACK. Quando il timer scade "Go Back N" ovvero vengono rispediti tutti i pacchetti in attesa di riscontro.

_Esempio_

Il primo pacchetto inviato e su quale si trova il timer è 3 (`Sf = 3`) e il mittente invia 6 quindi abbiamo `Sf = 7`. Non arrivano ACK e scade il timer quindi vengono rinviati i pacchetti 3,4,5,6.

_FSM per rappresentare il mittente_

![[Pasted image 20250327222215.png]]

_FSM per il destinatario_

![[Pasted image 20250327222227.png]]

---

Ma con una finestra di $2^m$ i duplicati vengono gestiti correttamente?

![[Pasted image 20250327222457.png]]

Notiamo che in questo caso la finestra di ricezione viene riempita e tutti i segnali di ACK sono stati persi, cosa succede?

Che il destinatario sta di nuovo aspettando un pacchetto 0 e scade anche il timer del mittente, vengono quindi rispediti tutti i pacchetti e ricevuti erroneamente come corretti quando in realtà erano già stati ricevuti.

La dimensione corretta per la finestra di invio è $2^m - 1$:

![[Pasted image 20250327222908.png|500]]

In questo modo i pacchetti già ricevuti ma per i quali sono andati persi gli ACK vengono scartati quando ricevuti nuovamente (duplicati).

# Ripetizione Selettiva
Nel Go Back N se un pacchetto non viene ricevuto correttamente dobbiamo rinviare tutti quelli presenti nella finestra, questo è molto efficiente se la rete funziona sempre correttamente ma se ad esempio c'è congestione non lo è.

In questo meccanismo vengono rispediti soltanto i pacchetti per i quali non è stato ricevuto un ACK.

In questo caso la finestra di invio e ricezione hanno la stessa dimensione:

![[Pasted image 20250327223752.png]]

Per implementare questo meccanismo abbiamo bisogno di un timer per ciascun pacchetto in attesa di riscontro, quando un timer scade viene rispedito soltanto quel pacchetto.

Quindi adesso cambia anche il significato del numero di sequenza presente nell'ACK, se ACK = 7 non significa più che stiamo aspettando il 7 e abbiamo ricevuto il 6 ma significa che abbiamo ricevuto correttamente il 7.

_FSM per rappresentare il mittente_

![[Pasted image 20250327223946.png]]

_FSM per Destinatario_

![[Pasted image 20250327224001.png]]

---

Le dimensione delle finestre abbiamo detto essere uguali e in questo meccanismo sono calcolate modulo $2^{m-1}$

Perché non possiamo usare $2^m -1$?

![[Pasted image 20250327224146.png|500]]

In questo caso scade il timer per 0 e viene rispedito, il destinatario lo prende come nuovo pacchetto ma in realtà è un duplicato.

Se usiamo $2^{m-1}$:

![[Pasted image 20250327224248.png|500]]

---

> [!info] Protocolli Bidirezionali: Piggybacking
> I meccanismi che abbiamo visto li abbiamo presentati in modo unidirezionale ovvero i pacchetti vengono spediti in una direzione e gli ACK in un'altra ma in realtà questi viaggiano in entrambe le direzioni, sia pacchetti che ACK.
   Per migliorare l'efficienza dei protocolli bidirezionali si usa la tecnica **piggybacking** ovvero quando un pacchetto trasporta dati da A a B può trasportare anche gli ACK relativi ai pacchetti ricevuti da B e viceversa.

---

In generale:

![[Pasted image 20250327224918.png]]

