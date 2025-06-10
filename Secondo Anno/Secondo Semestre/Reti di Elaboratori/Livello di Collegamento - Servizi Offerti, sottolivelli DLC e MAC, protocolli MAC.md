Riassumendo il come come avviene la comunicazione nei vari livelli dello stack:
- Applicazione - I due utenti possono immaginare che tra di essi esista un unico canale bidirezionale ma in realtà la comunicazione avviene attraverso più livelli.
- Trasporto - I protocolli di trasporto forniscono la **comunicazione logica** tra processi di host differenti, ovvero gli host eseguono i processi come se fossero direttamente connessi
- Rete - Comunicazione host-to-host.
- Collegamento - La comunicazione avviene hop-to-hop o nodo-to-nodo.

Terminologia che si utilizza:
- Host e Router prendono il nome di **nodi o stazioni**
- I canali di comunicazione si chiamano **collegamento o link**
	- Collegamenti cablati
	- Collegamenti wireless
	- LAN
- Le unità di dati scambiate dai protocolli a livello di link sono chiamate **frame**.

I protocolli a livello di collegamento si occuperanno del trasporto di datagrammi lungo un singolo canale di comunicazione.

# Collegamenti o Link
I nodi all'interno di una rete sono fisicamente collegati da un mezzo trasmissivo come un cavo o l'aria e possiamo scegliere se usare l'intera capacità del mezzo trasmissivo per due soli dispositivi (**collegamento punto-punto**) oppure soltanto una parte (**collegamento broadcast**).

Passando da un collegamento ad un altro, un datagramma può essere gestito da diversi protocolli e non tutti i protocolli a livello di trasporto offrono gli stessi servizi.

# Servizi Offerti dal Livello di Trasporto

## Framing
I protocolli incapsulano i datagrammi del livello di rete all'interno di un frame a livello di link.

Per identificare origine e destinazione vengono utilizzati indirizzi **MAC**.

## Consegna Affidabile
È una consegna basata su ACK e non viene sempre utilizzata, soprattutto nelle reti a basso tasso di errore come quelle cablate. È quindi più facile vederla su reti wireless.

## Controllo di Flusso
Evita che il nodo trasmittente saturi quello ricevente.

## Rilevazione degli errori
Gli errori sono causati dalle interferenze, il nodo ricevente è in grado di rilevare errori tramite l'inserimento di bit di "parità" nel frame da perte del mittente.

## Correzione degli errori
Il nodo ricevente è anche in grado di determinare in che punto è avvenuto l'errore.

# Dove è implementato il livello Collegamento
Deve essere implementato in tutti gli host e viene realizzato con un adattatore ovvero la **Network Interface Card** (NIC), questa implementa sia il livello di collegamento che quello fisico.

Questa è una combinazione di hardware, software e firmware.

## Adattatori

![[Pasted image 20250509090939.png|400]]

Da parte del lato mittente:
- Incapsula i datagrammi in un frame
- Imposta il bit rilevazione degli errori, trasferimento affidabile, controllo di flusso etc...

Mentre da parte del lato ricevente:
- Individua gli errori, trasferimento dati affidabile, controllo di flusso etc...
- Estrae i datagrammi e li passa al nodo ricevente

## Due Sottolivelli
- **Data-Link Control (DLC)** - Si occupa di tutte le cose in comune fra collegamenti punto-punto e broadcast, quindi:
	- Framing
	- Controllo del flusso e degli errori
	- Rilevamento e correzione degli errori
  Si occupa quindi della comunicazione tra due nodi adiacenti indipendentemente dal fatto che il collegamento sia dedicato o broadcast.

- **Media Access Control (MAC)** - Si occupa solo degli aspetti dei canali broadcast, più precisamente del controllo dell'accesso al mezzo condiviso.

Quindi avremo che:

![[Pasted image 20250509091432.png|200]]

## Errori su singolo bit o a burst
Gli errori sono dovuti a interferenze che possono cambiare la forma del segnale.

![[Pasted image 20250509091640.png|300]]

Molto spesso però le interferenze coinvolgono più di un bit, questo perché la probabilità che avvenga un errore di tipo *burst* (a raffica) è più elevata rispetto a quella di un singolo bit in quanto la durata dell'interferenza (rumore) normalmente è più lunga rispetto a quella di un solo bit.

Più precisamente il numero di bit coinvolti dipende dalla velocità di trasferimento dati e dalla durata del rumore. 

Ad esempio 1Kbps con un rumore di 1/100 sec può influire su 10bit.

## Tecniche di rilevazione degli errori

![[Pasted image 20250509092306.png|400]]

Indichiamo:
- **EDC** - Error Detection and Connection
- **D** - Dati che devono essere protetti da errori e ai quali vengono aggiunti dei bit EDC.

Da notare che la rilevazione degli errori non è affidabile al 100%:
- Potrebbero esserci errori non rilevati
- Per ridurre la probabilità della mancata rilevazione di solito si usa un'elevata **ridondanza**.

## Controllo di Parità
È un bit aggiuntivo che viene scelto in modo da rendere pari il numero totale di 1 all'interno della codeword.

Se si usa un **unico bit di parità** possiamo sapere soltanto che si è verificato almeno un errore in un bit.

Se si usa una **parità bidimensionale** allora possiamo individuare e correggere gli errori:

![[Pasted image 20250509094232.png|300]]

## Protocolli di Accesso Multiplo
Esistono due tipi di collegamenti:
- **Collegamento punto-punto**
	- Connessioni telefoniche
	- Collegamenti punto-punto tra Ethernet e host.
	- Si usa il Point-to-Point protocol (PPP) del DLC
- **Collegamento Broadcast**
	- Ethernet tradizionale
	- Wireless LAN 802.11
	- Necessità di un protocollo (MAC) per la gestione del canale condiviso

# Problema dell'accesso Multiplo
La rete usa dei mezzi di comunicazione che sono condivisi fra i vari host, quindi se ci sono delle comunicazione in parallelo gli host non riescono a comunicare perfettamente.

## Protocolli di Accesso Multiplo
Servono a evitare le collisioni quando i nodi ricevono due o più frame contemporaneamente, questi protocolli fissano quindi le modalità con cui i nodi regolano le loro trasmissioni sul canale condiviso.

Un protocollo di accesso multiplo ideale su un canale broadcast di R bit al sec è strutturato in questo modo:
1) Quando un nodo deve inviare dati dispone di un tasso trasmissivo pari a R bps
2) Quando M nodi devono inviare dati questi dispongono di un tasso trasmissivo pari a R/M bps
3) Il protocollo è decentralizzato, non ci sono nodi master e non c'è sincronizzazione dei clock

## Classificazione dei protocolli di accesso multiplo
Abbiamo 3 categorie:
- Protocolli a **suddivisione del canale** (channel partitiong) - Suddivide un canale in "parti più piccole" (tempo o frequenza o altro) e le alloca ad un nodo per utilizzo esclusivo. Non si hanno collisioni.
- Protocolli ad **accesso casuale** (random access) - I canali non vengono divisi e si può verificare una collisione. Inoltre i nodi coinvolti nella collisione ritrasmettono ripetutamente i pacchetti.
- Protocolli **a rotazione** (taking-turn) - Ciascun nodo ha il suo turno per trasmettere, chi deve trasmettere di più però avrà turni più lunghi.

# Classificazione dei protocolli MAC

![[Pasted image 20250509102308.png|400]]

## Protocolli a suddivisione del canale: TDMA
In questi protocolli assegnamo diversi intervalli di tempo ai nodi per comunicare, ogni nodo avrà il suo intervallo. Se uno slot non viene utilizzato allora rimane inattivo.

_Esempio_

![[Pasted image 20250509103504.png|400]]

- In questi protocolli abbiamo un tasso trasmissivo di R/N bps dove N è il numero di processi. 
- Non sono flessibili rispetto a variazioni nel numero di nodi

## Protocolli a suddivisione del canale: FDMA
Suddividono il canale in bande di frequenza, a ciascun nodo è assegnata una banda di frequenza prefissata.

![[Pasted image 20250509103718.png|400]]

## Protocolli ad Accesso Casuale
Ogni nodo non ha controllo sugli altri e quando deve inviare qualcosa segue delle procedure definite dal protocollo per decide se può spedire o no.

**Accesso Casuale**
- Non c'è un tempo programmato nel quale il nodo deve trasmettere
- Non ci sono regole su quale sarà il prossimo nodo a trasmettere

I nodi competeranno quindi fra di loro per accedere al mezzo trasmissivo, **contesa del canale**.

Quando però due nodi trasmettono nello stesso momento allora si verifica una **collisione**, i protocolli ad accesso casuale devono essere in grado di:
- Rilevare le collisioni
- Definire come ritrasmettere il segnale se si è verifica una collisione

### ALOHA
È il primo protocollo ad accesso casuale che è stato proposto, è stato sviluppato nelle Hawaii negli anni 70 per permettere la comunicazione di isole mediante una LAN wireless (possiamo in realtà utilizzare qualsiasi mezzo). Essendo ad accesso casuale possono quindi verificarsi collisioni.

**ALOHA PURO**
- Ogni stazione può inviare un frame tutte le volte che ha dati da inviare
- Il ricevente invia un ACK se riceve correttamente il frame, se il mittente non riceve questo ACK entro un timeout allora deve ritrasmettere.
- Se due nodi ritrasmettono contemporaneamente si verifica nuovamente una collisione, allora si attende altro tempo random **back-off** prima di effettuare la ritrasmissione. (Possiamo vederla quindi come due persone che parlano).
- La casualità del back-off aiuta ad evitare altre collisioni
- Dopo un numero massimo di tentativi $K_{max}$ un nodo interrompe i suoi tentativi di rinvio e prova più tardi.

### Timeout e backoff
- **Timeout**
	- Per quanto tempo un nodo deve aspettare l'ACK dal ricevente?
	- Il timeout equivale al massimo ritardo di propagazione di round-trip tra le due stazioni più lontane
- **Backoff esponenziale binario**
	- Quanto si aspetta prima di ritrasmettere?
	- Si aspetta un tempo $T_{B}$ scelto casualmente che dipende dal numero $K$ di trasmissioni fallite

$$
\text{Backoff time = } R*T_{fr}
$$

Dove:
- $R\in[0, 2^k-1]$
- $K=\#$ tentativi
- $T_{fr}=$ tempo per inviare un frame
- $K_{max}=15$

_Esempio calcolo di Backoff_

I nodi in una rete wireless ALOHA sono a una distanza massima di 600km, supponendo che i segnali si propaghino a $3\times 10^8 m/s$ abbiamo che:

$$
T_{fr} = (600\times 10^3) / (3\times 10^8)=2ms
$$

- Per $K=2$ l'intervallo di $R$ è $\{ 0,1,2,3 \}$
- Quindi abbiamo che $T_{B}=R* T_{Fr}$ può essere 0, 2, 4 o 6 ms sulla base del risultato della variabile casuale R.

---

Nell'ALOHA puro ci sono elevate probabilità di collisione, definiamo **tempo di vulnerabilità** l'intervallo di tempo nel quale il frame è a rischio di collisioni:
- Il frame trasmesso a $t$ si sovrappone con la trasmissione di qualsiasi altro frame inviato in $[t-1, t+1]$
- Il tempo di vulnerabilità è = $2T_{fr}$

![[Pasted image 20250509110720.png|400]]

# Studio dell'efficienza (Throuhgput)
L'efficienza è definita come la frazione di slot vincenti in presenza di un elevato numero $N$ di nodi attivi, che hanno sempre un elevato numero di pacchetti da spedire.

- Assumiamo che tutti i frame hanno la stessa dimensione e ogni nodo ha sempre un frame da trasmettere.
- In ogni istante di tempo, $p$ è la probabilità che un nodo trasmetta un frame e quindi $(1-p)$ la probabilità che non trasmetta
- Supponendo che un nodo inizi a trasmettere all'istante $t_{0}$, per avere un esito positivo della trasmissione nessun altro nodo deve aver iniziato una trasmissione nel tempo $[t_{0} - 1, t_{0}]$. Tale probabilità è data da $(1-p)^{N-1}$
- Allo stesso modo nessun nodo deve iniziare a trasmettere nel tempo $[t_{0}, t_{0} + 1]$ e la probabilità di questo evento è sempre $(1-p)^{N-1}$
- Quindi in conclusione la probabilità che un nodo trasmetta con successo è $p(1-p)^{2(N-1)}$
- Studiando il valore di $p$ che massimizza la probabilità di successo per $N$ che tende a infinito si ottiene che l'efficienza massima è $\frac{1}{2} e$ ovvero $0.18$, molto bassa.

# Slotted ALOHA
Un modo per aumentare l'efficienza di ALOHA consiste nel dividere il tempo in intervalli discreti, ciascuno corrispondente ad un frame time $F_{fr}$.

Serve **sincronizzazione** - i nodi devono essere d'accordo nel confine fra gli intervalli, possiamo realizzare questo facendo emettere da un'attrezzatura speciale un breve segnale all'inizio di ogni intervallo.

Vanno fatte delle assunzioni:
- Tutti i pacchetti hanno la stessa dimensione
- Il tempo è suddiviso in slot, questi equivalgono al tempo di trasmissione di un pacchetto
- I nodi possono iniziare la trasmissione soltanto all'inizio di uno slot
- I nodi sono sincronizzati
- Se in uno slot ci sono delle collisioni di pacchetti allora i nodi coinvolti rilevano l'evento prima del termine dello slot.

Cosa si fa?
- Quando ad un nodo arriva un nuovo pacchetto da spedire il nodo attende l'inizio di uno slot e:
	- Se non si verificano collisioni il nodo può trasmettere un nuovo pacchetto allo slot successivo
	- Se si verificano collisioni allora il nodo ritrasmette con probabilità $p$ il pacchetto negli slot successivi

**PRO** dello slotted ALOHA:
- Consente ad un singolo nodo di trasmettere continuamente pacchetti alla massima velocità consentita.
- Il tempo di vulnerabilità si riduce ad uno slot.

**CONTRO**:
- Una frazione degli slot avrà collisioni e saranno quindi persi
- Molti slot rimangono vuoti ovvero inattivi.

---

In slotted ALOHA seguendo gli stessi calcoli di prima, la probabilità che ogni nodo abbia successo è data da:

$$
N*p*(1-p)^{N-1}
$$

Per un alto numero di nodi abbiamo un'efficienza di 0.37, quindi nel caso migliore solo il 37% degli slot svolge lavoro utile.

# Accesso Multiplo a rilevazione della portante (CSMA)
Il CSMA (Carrier Sense Multiple Access):
- Si pone in ascolto prima di trasmettere
- Se trova il canale libero allora trasmette l'intero pacchetto
- Se il canale sta già trasmettendo allora il nodo aspetta un altro intervallo di tempo

Possono esserci collisioni?

Si per via del ritardo di propagazione, se un nodo trasmette e un altro è in ascolto, il pacchetto trasmesso deve aver raggiunto il secondo nodo altrimenti non verrà rilevato.

Il tempo di vulnerabilità è dato quindi dal tempo di propagazione.

![[Pasted image 20250509112930.png|300]]

## CSMA / CD (rilevazione di collisione)
Questo protocollo ascolta il canale anche durante la trasmissione e quindi:
- rileva la collisione in poco tempo
- Annulla la trasmissione non appena si accorge che c'è un'altra trasmissione in corso

La rilevazione però è semplice nelle reti cablate ma complessa in quelle wireless.

_Esempio_

![[Pasted image 20250509113117.png|500]]

### Dimensione minima del frame
Cosa succede se un nodo mittente finisce di trasmettere un frame prima di ricevere il primo bit di un'altra comunicazione che stava già trasmettendo?
- Un nodo una volta inviato un frame non tiene una copia di questo e non controlla nemmeno il mezzo trasmissivo per rilevare collisioni
- Poiché il Collision Detection funzioni il mittente deve poter rilevare le trasmissione mentre sta trasmettendo ovvero prima di inviare l'ultimo bit del frame.
- Il tempo di trasmissione quindi deve essere almeno due volte il tempo di propagazione $T_{p}$
- Quindi il primo nodo deve essere ancora in trasmissione dopo essere passati $2T_{p}$

---

_Esempio_

Una rete che utilizza il CSMA / CD ha un rate di 10Mbps. Se il tempo di propagazione massimo è 25.6 μs, qual è la dimensione minima del frame?

_Soluzione_

Il tempo di trasmissione minimo del frame è:
- $T_{fr}=2\times T_{p}=51.2 \mu s$
Questo significa, nel peggiore dei casi, che un nodo deve trasmettere per un periodo di $51.2\mu s$ per poter rilevare la collisione.

La dimensione minima del frame invece è:
- $10Mbps \times 51.2\mu s = 512bit$ o 64 byte.

> [!info] Dimensione minima frame
> Questa è proprio la dimensione minima del frame nell'Ethernet Standard.

# Metodi di Persistenza
Che cosa deve fare un nodo se trova il canale libero? Ci sono più opzioni:
- Trasmette subito
	- **Non persistente**
	- **1-persistente**
- Trasmetterà con probabilità p
	- **p-persistente**

E se invece trova il canale occupato?
- Desiste: Riascolta il canale dopo un tempo random
	- **Non persistente**
- Persiste: Rimane in ascolto finché il canale non si è liberato
	- **1-persistente**
	- **p-persistente**

## Non Persistente
- Se il canale è libero trasmette immediatamente
- Se il canale è occupato attende un tempo random
- Se collisioni backoff

![[Pasted image 20250509144528.png|400]]

## 1 Persistente
- Se il canale è libero trasmette immediatamente
- Se il canale è occupato continua ad ascoltare (carrier sense continuo)
- Se collisione backoff

![[Pasted image 20250509144738.png|400]]

## p persistente
- Se il canale è libero
	- Trasmette con probabilità p
	- Rimanda la connessione con probabilità $1-p$
- Se il canale è occupato usa la procedura di backoff quindi si aspetta un tempo random e si riascolta
- Se collisione backoff

![[Pasted image 20250509145901.png|500]]


> [!info] Efficienza del CSMA / CD
> Quando un nodo trasmette questo può farlo soltanto al massimo rate mentre se sono più nodi a trasmettere allora il throughput è minore. Il CSMA / CD ha comunque un throughput maggiore ad ALOHA puro e slotted, ad esempio con il metodo 1 persistente si ha un throughput massimo del 50%.

# Protocolli MAC a rotazione
**Protocolli MAC a suddivisione del canale**:
- Condividono il canale equamente ed efficientemente con carichi elevati
- Inefficiente con carichi non elevati


**Protocolli MAC ad accesso casuale**:
- Efficienti anche con carichi non elevati: un singolo nodo è libero di usare l'intero canale
- Se abbiamo carichi elevati ci sarà un alto numero di collisioni


**Protocolli a rotazione**:
- Cercano di realizzare un compromesso tra i precedenti

## Protocolli a rotazione

### Protocollo Polling
C'è un nodo principale che "sonda" gli altri a turno, questo protocollo:
- Elimina le collisioni
- Elimina gli slot vuoti
- Ritardo di polling
- Se però il nodo principale si guasta allora l'intero canale resta inattivo

![[Pasted image 20250509150524.png|300]]

### Protocollo Token-Passing
Viene fatto circolare un messaggio di controllo fra i nodi (token), si segue un ordine prefissato. Questo protocollo:
- Decentralizzato
- Altamente efficiente
- Se si guasta un nodo potrebbe andare fuori uso l'intero canale.

![[Pasted image 20250509150638.png|200]]

---

# Riassumendo
Si possono risolvere i problemi sulla contesa di un canale condiviso con:
- Suddivisione del canale
	- Tempo
	- Frequeunza
	- Codice
	- Ad esempio TDM, FDM
- Suddivisione Casuale (dinamico)
	- Ad esempio ALOHA, S-ALOHA, CSMA, CSMA / CD
	- Rilevamento della portante: facile in reti cablate ma non in wireless
	- CSMA / CD da Ethernet
	- CSMA / CA usato in 802.11
- A rotazione
	- Polling con un nodo principale
	- Token passing
	- Ad esempio Bluetooth, FDDI, IBM Token Ring
	
