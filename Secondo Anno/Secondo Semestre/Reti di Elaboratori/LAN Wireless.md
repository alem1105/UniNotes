Fanno parte delle reti Wireless:
- LAN Wireless quindi reti WiFi
- Reti Cellulari
- Bluetooth
- Reti di sensori come ad esempio RFID o altri dispositivi smart

Standard IEEE per le LAN Wireless:

![[Pasted image 20250519125255.png|500]]


**Elementi delle LAN Wireless**
- Wireless hosts - Cellulari, laptop ma anche dispositivi fissi come PC che non usano ethernet ma WiFi per la connettività
- Base Station - Sono connesse alla rete tramite cavo e servono a collegare le varie reti sia wireless che non
- Wireless Link - Sono usati tipicamente per collegare dispositivi mobili alla base station ma anche come backbone link

**Caratteristiche LAN Wireless**
- Usano l'aria come mezzo trasmissivo, questo significa che è condiviso fra tutti gli host
- Gli host non fisicamente connessi alla rete con un cavo e possono quindi muoversi liberamente
- Connessione ad altre reti - La base station (anche chiamata **Access Point**) è collegata ad altre reti cablate.

![[Pasted image 20250519130400.png|500]]


> [!info] Migrazione da cablato a wireless
> Il funzionamento di una rete cablata o wireless dipende dai due sottolivelli inferiori dello stack ovvero collegamento e fisico, per migrare una rete cablata ad una wireless basta cambiare le schede di rete e sostituire lo switch con un AP, in questo modo cambiano soltanto gli indirizzi MAC ma non quelli IP.

> [!info] Reti ad hoc - Senza Infrastruttura
> È anche possibile creare una rete utilizzando soltanto degli host, questi si auto-organizzano e comunicano liberamente fra loro. Ogni host dovrà eseguire le funzionalità di rete come network setup, routing, forwarding...
> 
> ![[Pasted image 20250519130832.png|300]]
> 

# Caratteristiche del link Wireless
- **Attenuazione del Segnale** - La forza dei segnali elettromagnetici diminuisce rapidamente all'aumentare della distanza dal trasmettitore, questo perché il segnale si propaga in tutte le direzioni
- **Propagazione multi-path** - Quando un'onda trova un ostacolo questa viene riflessa e perde potenza, un segnale quindi può raggiungere una destinazione attraverso più percorsi a seconda di quante volte viene riflesso sugli oggetti

![[Pasted image 20250519131423.png|300]]

- **Interferenze** - Ci sono due casi:
	- Un destinatario potrebbe ricevere più segnali dallo stesso mittente a causa del multi-path
	- Oppure un destinatario potrebbe ricevere più segnali da altri mittenti che si trovano sulla stessa frequenza.

Tutte queste caratteristiche causano degli **errori**, si usa il **SNR** (Signal to Noise Ratio) o rapporto segnale - rumore per misurare il rapporto tra il segnale buono e quello cattivo, se il rapporto è:
- Alto, allora il segnale è più forte del rumore e quindi può essere convertito in dati
- Basso, allora il segnale è stato danneggiato dal rumore e i dati non possono essere recuperati

# Controllo dell'accesso al mezzo
Siccome l'aria è un mezzo condiviso fra gli host c'è necessità di controllare l'accesso al mezzo per evitare le collisioni. Nel Wireless non possiamo utilizzare CSMA/CD come in ethernet perché non si può effettuare **collision detection** con lo stesso metodo.

Infatti un host dovrebbe trasmettere e ricevere contemporaneamente ma poiché la potenza del segnale ricevuto è inferiore a quella del segnale trasmesso sarebbe troppo costoso usare un adattatore di rete in grado di rilevare le collisioni, spesso infatti i dispositivi wireless sono mobili e hanno quindi un'energia limitata dalla batteria, usare questo metodo comporterebbe un consumo molto elevato e quindi una batteria molto grande.

Un altro problema è il **hidden terminal problem** - Un host potrebbe non accorgersi che un altro host sta trasmettendo anche ascoltando il canale per diversi motivi:

![[Pasted image 20250519132336.png|400]]

Oppure

![[Pasted image 20250519132354.png|400]]

# IEEE 802.11
IEEE ha definito le specifiche per le LAN wireless chiamate 802.11, queste coprono i due livelli di collegamento e fisico.
- 802.11b
	- 11 Mbps
	- 2.4 - 2.5 GHz
- Wi - Fi (Wireless Fidelity) usato negli States
- Wi - Fi è una LAN wireless certificata dalla Wi-Fi alliance, un'associazione no-profit che si occupa di promuovere la crescita delle LAN Wireless.

# Architettura

## BSS - Basic Service Set
È costituita da uno o più host wireless e da un access point, l'access point è poi collegato ad un router. Questa è l'architettura più diffusa

![[Pasted image 20250519133211.png|300]]

Si può trovare anche senza AP, ovvero una rete standalone:

![[Pasted image 20250519133245.png|300]]

## ESS - Extended Service Set
È un'architettura costituita da due o più BSS con infrastruttura collegati fra loro tramite una rete cablata o wireless:

![[Pasted image 20250519151727.png|500]]

# Canali e Associazione
Lo spettro delle frequenze usate, 2.4 - 2.485GHz è diviso in 11 canali parzialmente sovrapposti, per ogni AP va scelta una frequenza e quindi se degli AP vicini sono sulla stessa frequenza sono possibili interferenze.

I canali non interferiscono se separati da 4 o più canali.

L'architettura IEEE 802.11 prevede che una stazione wireless si associ ad un AP per accedere a Internet, come avviene l'associazione?
- È necessario conoscere gli AP disponibili nel BSS
- È necessario un protocollo di associazione:
	- L'AP invia segnali periodici (beacon) che includono il suo identificatore (SSID) e il suo indirizzo MAC
	- La stazione wireless che vuole entrare in un BSS scandisce gli 11 canali alla ricerca di beacon
	- Alla fine della scansione la stazione sceglie l'AP dal quale ha ricevuto il segnale più potente e invia un frame con la richiesta di associazione
	- L'AP accetta la richiesta con un frame di risposta associazione e permette quindi all'host di inviare una richiesta DHCP per ottenere un indirizzo IP
	- Può essere prevista un'autenticazione per eseguire l'associazione

## Protocollo MAC 802.11
Più stazioni possono voler comunicare nello stesso momento, ci sono due tecniche per gestire gli accessi al mezzo trasmissivo:
- Distributed Coordination Function (DCF) - I nodi si contendono l'accesso al canale
- Point Coordination Function (PCF) - Non c'è contesa e l'AP coordina l'accesso dei nodi al canale

## CSMA / CA
Dobbiamo evitare le collisioni tramite il carrier sense ovvero ascoltare il canale prima di trasmettere.

Non possiamo fare collision detection per 3 motivi (alcuni visti prima):
- Impossibilità di trasmettere e ricevere nello stesso momento
- Hidden Terminal Problem
- Raggio di trasmissione limitato, è quindi difficile ascoltare tutte le trasmissioni

### CMSA / CA: ACK

![[Pasted image 20250519161659.png|300]]

Se utilizziamo questo metodo abbiamo bisogno di un doppio carrier sense sia sui dati che per gli ACK.

Quando si riceve un ACK si capisce che una comunicazione è andata a buon fine. Il mittente però non può aspettare l'ACK all'infinito e imposta quindi un timer (ACK timeout), se il timer scade senza aver ricevuto l'ACK allora il nodo suppone che la trasmissione sia fallita e tenta una ritrasmissione.

C'è possibilità di collisione anche sugli ACK.

### CSMA / CA: Spazio Interframe
IFS - Spazio Interframe: Rilevata la portante, se il canale risulta libero si posticipa la trasmissione per evitare che stazioni che hanno già iniziato la trasmissione collidano con altre che devono cominciare.
- SIFS - Short IFS realizza alta priorità
- DIFS - Distributed IFS realizza bassa priorità

![[Pasted image 20250519162017.png|300]]

Cosa fa il mittente?
- Ascolta il canale
- Se libero per DIFS tempo allora trasmette


Il ricevente?
- Se frame ricevuto correttamente allora invia ACK dopo SIFS tempo

DIFS > SIFS per dare priorità alle comunicazione già iniziate (si da priorità agli ACK)

Quindi se durante l'intervallo DIFS il canale diventa occupato allora il nodo interrompe il conteggio DIFS e aspetta che il canale torni completamente libero, quando succede riavvia da zero il conteggio del DIFS completo.

### CSMA / CA: Finestra di Contesa
Dopo aver atteso un tempo IFS, se il canale è ancora inattivo la stazione attente un ulteriore tempo di contesa.

**Finestra di Contesa (Contention Windows)** - Lasso di tempo (backoff) per cui deve sentire il canale libero prima di trasmettere. Questo tempo è diviso in slot e ad ogni slot si esegui il sensing del canale:
- Si sceglie R random in \[0, CW]
- Finché R > 0 si ascolta il canale per uno slot e se questo è libero per la durata dello slot allora R - 1 altrimenti si interrompe il timer e aspetta che il canale si liberi riavviando il timer

![[Pasted image 20250519165139.png|500]]

### DIFS + Finestra di Contesa
1) Attesa dell'IFS
	- Il nodo rileva il canale libero
	- Attende un tempo fisso: DIFS
	- Se il canale rimane libero per tutto il DIFS passa alla finestra di contesa
2) Finestra di contesa (backoff)
	- Il nodo sceglie un numero casuale in un intervallo \[0, CW - 1] dove CW è la Contention Window
	- Ogni unità di tempo della finestra si chiama Slot Time
	- Il nodo inizia a contare all'indietro solo se il canale rimane libero

_Esempio_

Abbiamo CW = 16 quindi un intervallo casuale in cui scegliere di \[0, 15]. Supponiamo che il nodo scelga 7 e quindi attende 7 * Slot Time = 7 * 20$\mu s$ = 140$\mu s$, solo se il canale è libero. Infatti se durante questo tempo qualcun altro inizia a trasmettere allora il nodo pausa il countdown e quado il canale torna libero si riprende a contare da dove ci si era fermati.

### CSMA / CA: RTS / CTS
Il problema dell'hidden terminal però non viene risolto né con IFS né con finestra di contesa, è necessario un meccanismo di prenotazione del canale:
- Request-to-Send(RTS)
- Clear-to-Send(CTS)

![[Pasted image 20250519170431.png|400]]

Quindi si invia un RTS per capire se si può trasmettere e se si riceve un CTS si possono inviare i dati.

Il CTS viene inviato a tutte le stazioni, in questo modo quest'ultime anche se "nascoste" sanno che non devono inviare pacchetti altrimenti si verificherebbero collisioni.

# Evitare Collisioni sul Destinatario
Come fanno le stazioni che non sono coinvolte nella comunicazione a sapere per quanto tempo devono astenersi dal trasmettere, dato che ascoltando il canale non sono in grado di rilevare la trasmissione?

## Network Allocation Vector (NAV)
Quando una stazione invia un frame RTS include anche per quanto tempo occuperà il canale per trasmettere il frame e ricevere l'ACK, questo tempo viene incluso anche nel CTS.

Le stazioni influenzate da tale trasmissione avviano un timer chiamato NAV che indica quanto tempo devono attendere prima di eseguire il sensing del segnale. Ogni stazione quindi prima di ascoltare deve controllare sul NAV.

## Collisioni durante l'handshaking
Una collisione potrebbe accadere anche durante l'invio di RTS o CTS, molto semplicemente se il mittente non riceve un CTS allora assume che c'è stata una collisione e riprova dopo un tempo di backoff.

## Problema della stazione Esposta
Una stazione si astiene dall'usare il canale anche se potrebbe trasmettere, nell'esempio seguente è C la stazione esposta:

![[Pasted image 20250519171058.png|500]]

# Formato del Frame

![[Pasted image 20250519171147.png]]

- Frame Control (FC) - Tipo del frame e alcune informazioni di controllo
- D - Durata della trasmissione, usata per impostare il NAV
- Indirizzi - Indirizzi MAC
- SC - Informazioni sui frammenti, essenzialmente sono il numero di frammento e di sequenza, servono a distinguere frame ritrasmessi come nel livello di trasporto, questo perché alcuni ACK potrebbero andare perduti.
- Frame body - Payload
- FCS = Codice CRC a 32 bit

Il campo FC è formato quindi da 16 bit, due di questi indicano il tipo, ci sono 3 tipo di frame:
- 00 - Frame di Gestione: usati per le comunicazioni iniziali tra stazioni e punti di accesso
- 01 - Frame di controllo: Si usano per accedere al canale e dare riscontro, questi usano i successivi 4 bit per informazioni aggiuntive sul tipo:
	- 1011 - RTS
	- 1100 - CTS
	- 1101 - ACK
- 10 - Frame di dati: Vengono usati per trasportare i dati

## Frame di Controllo

![[Pasted image 20250519172505.png|300]]

## Indirizzamento
![[Pasted image 20250519172541.png]]

DS sta per sistema di distribuzione.

A seconda del valore di questi due bit (To DS e From DS) i campi degli indirizzi assumono valori diversi:

![[Pasted image 20250519172635.png|500]]

In ordine possiamo visualizzare i casi in questo modo:

![[Pasted image 20250519173233.png]]

# Mobilità all'interno della stessa sottorete IP
La mobilità è semplice all'interno della stessa sottorete, infatti l'indirizzo IP rimane lo stesso, ma quando un dispositivo cambio AP come si mantengono attive tutte le connessioni TCP?

![[Pasted image 20250519173439.png|500]]

L'Host H1 sente che il segnale dell'AP1 si sta indebolendo e avvia una scansione per trovare segnali più forti, rileva AP2 quindi si disassocia da AP1 e si associa ad AP2 mantenendo lo stesso indirizzo IP e sessioni TCP.

Come si comporta lo switch?
- Autoimpara ma non può supportare utenti con elevata mobilità
- AP2 invia un frame broadcast allo switch contenente come indirizzo mittente H1 e lo switch capisce quindi che H1 è nel BSS2