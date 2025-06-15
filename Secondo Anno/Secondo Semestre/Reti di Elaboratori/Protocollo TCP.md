Il protocollo TCP raggruppa un certo numero di byte da inviare in un segmento al quale poi aggiunge un'intestazione.

Come è fatta questa intestazione?

# Struttura Segmenti

![[Pasted image 20250331094634.png]]

- Numero di sequenza: È il numero del primo byte dei dati che stanno venendo inviati
- Acknowledgment number: È il numero di sequenza del prossimo byte che il client si aspetta di ricevere dal server

Invece le flag colorate in celeste indicano:
- URG: Puntatore urgente, questi dati vanno elaborati subito
- ACK: Riscontro valido
- PSH: Richiesta di push ovvero inviare i dati all'applicazione non appena possibile
- RST: Azzeramento connessione
- SYN: Sincronizzazione dei numeri di sequenza
- FIN: Chiusura della connessione

# Connessione TCP
La connessione TCP crea un percorso virtuale tra mittente e destinatario sopra all'indirizzo IP che invece è privo di connessione.

Una connessione TCP è caratterizzata da 3 fasi:
1) Apertura connessione
2) Trasferimento dati
3) Chiusura connessione

## Apertura della Connessione
L'apertura della connessione avviene tramite un meccanismo chiamato **3 way handshake**:

![[Pasted image 20250331095916.png]]

1) Il client invia un segmento con la flag `SYN`, il numero di sequenza `seq` viene scelto casualmente dal client, in questo caso 8000
2) Il server riceve il messaggio e risponde con un `ACK + SYN`, manderà ACK = 8001 dato che ha ricevuto 8000 e quindi si aspetta dati a partire da 8001. Per il suo `seq = 15000`anche questo è scelto a caso
3) Il client risponde con un ultimo `ACK`

Adesso si può iniziare a trasferire dati

## Trasferimento dati: Push

![[Pasted image 20250331101203.png]]

1) Il client invia due segmenti da 1000 byte infatti i loro numeri di sequenza vanno da 8001 a 9000 e da 9001 a 10000.
2) Il server risponde con un `ACK` e inviando i byte con numero di sequenza da 15001 a 17000, il campo `rwnd = 3000` indica quanti byte può ricevere per volta il server. Indica la `receive window`.
3) Il client invia la sua `receive window` e un `ACK`.

## Trasferimento dati: Urgent
I dati che hanno un flag `URG` vengono elaborati subito, indipendentemente dalla loro posizione nel flusso di byte.

Questi dati urgenti vengono inseriti all'inizio di un nuovo segmento che potrà comunque avere dati non urgenti ma solo dopo quelli urgenti. Il campo `URG` viene fornito insieme ad un puntatore, questo puntatore indica dove finiscono i dati urgenti e iniziano quelli normali nel nuovo segmento.

## Chiusura della Connessione
Entrambi le parti coinvolte nella connessione possono richiedere la chiusura. Di solito questa viene chiesta dal client oppure dal server per timeout.

La procedura è simile a quella per aprire la connessione ma al posto di segnali `SYN` vengono inviati segnali `FIN`:

![[Pasted image 20250331103513.png]]

Esiste anche un altro tipo di chiusura, ovvero la **half - close**, questa non è sincronizzata fra le due parti, la chiusura infatti avviene solo da un lato mentre dall'altro la connessione rimane aperta.

Essenzialmente una delle due parti ha finito di inviare i dati e chiude la connessione ma vuole comunque continuare a ricevere dall'altra parte finché anche questa non manderà un `FIN`

![[Pasted image 20250331103856.png]]

# Controllo degli Errori
Come gestisce TCP i numeri di sequenza e gli ACK:
- Numeri di sequenza: Numero del primo byte del segmento nel flusso di byte. Il numero iniziale viene scelto a caso.
- ACK: Numero di sequenza del prossimo byte atteso dall'altro lato. Usa inoltre ACK cumulativi.

![[Pasted image 20250331104427.png|400]]

Ma come vengono gestiti i segmenti fuori sequenza? Non ci sono specifiche TCP, di solito è il destinatario che li mantiene in memoria e poi li "riceve" quando rispettano il giusto ordine.

## Affidabilità
- Si usa la **checksum** per scartare i segmenti che arrivano corrotti.
- Usa degli ACK cumulativi e un timer associato al più vecchio pacchetto non riscontrato.
- Il segmento viene ritrasmesso all'inizio della coda di spedizione.

Perché ACK cumulativi? Vediamo come si comporta TCP in varie situazioni:

**Regola 2**

- Arriva un segmento ordinato che ha il numero di sequenza attesto, allora tutti i dati precedenti sono stati riscontrati.
- Per rispondere con un ACK si aspetta 500ms, in questo modo se arriva anche il segmento successivo viene inviato un solo ACK ma se entro questi 500ms non viene ricevuto il successivo si invia l'ACK singolo.

---

**Regola 3**

- Arriva un segmento con numero di sequenza atteso e un altro segmento precedente è in attesa di trasmissione dell'ACK.
- Si invia un singolo ACK cumulativo per entrambi.

---

**Regola 4**

- Arriva un segmento non ordinato che ha quindi un numero di sequenza superiore a quello atteso e viene quindi rilevato un buco.
- Viene subito inviato un ACK duplicato indicando il numero di sequenza del prossimo byte atteso. Questa procedura prende il nome di **ritrasmissione veloce**.

---

**Regola 5**

- Arriva un segmento mancante ovvero è già stato ricevuto un suo successivo.
- Viene inviato subito un ACK.

---

**Regola 6**

- Arriva un segmento duplicato.
- Invia un ACK che contiene il numero di sequenza atteso.

## Ritrasmissione dei segmenti
Quando un segmento viene inviato viene comunque mantenuta una copia in una coda, in attesa di ricevere un riscontro.

Se questo riscontro non arriva possono accadere due cose:
- Se è il primo segmento all'inizio della coda può scadere il timer e viene quindi ritrasmesso. Viene anche rinviato il timer.
- Vengono ricevuti 3 ACK duplicati e quindi avviene una **ritrasmissione veloce** del segmento senza aspettare il timer.

---

_FSM Mittente_

![[Pasted image 20250331110114.png|500]]

_FSM Destinatario_

![[Pasted image 20250331110225.png|500]]

---

Usando quindi i timer per gli ACK cumulativi avremo una situazione simile:

![[Pasted image 20250331110413.png|500]]

Quando il client riceve 4001-5000 si aspetta 5001, attende 500ms e non riceve niente e quindi invia ACK di 5001.

Il server risponde con 5001-6000 e quindi il client aspetta per 500ms il 6001, dato che riceve 6001-7000 entro la finestra invia un singolo ACK di 7001.

## Segmento Smarrito

![[Pasted image 20250331110838.png|500]]

1) Il client invia in ordine 501-600 e 601-700 quindi il server aspetta 701.
2) 701-800 viene spedito ma smarrito
3) Il client invia anche 801-900 e il server lo riceve, siccome ha ricevuto un pacchetto superiore a quello che si aspettava rinvia un ACK di 701.
4) Il client lo riceve e rispedisce 701-800
5) A questo punto il server, una volta ricevuto spedisce l'ACK dei prossimi ovvero 901.

## Ritrasmissione Rapida

![[Pasted image 20250331111316.png|500]]

Il pacchetto perso è il 301-400. Una volta che il client ha ricevuto 3 ACK duplicati per lo stesso pacchetto inizia la ritrasmissione veloce **prima dello scadere del timer** del 301.

## Riscontro smarrito senza ritrasmissione

![[Pasted image 20250331111719.png|500]]

Viene smarrito l'ACK di 701 ma non viene ritrasmesso dato che il server ha ricevuto dei segmenti successivi e quindi può inviare direttamente ACK di 901. Ma non sempre accade questo

## Riscontro smarrito con ritrasmissione

![[Pasted image 20250331112033.png|500]]

In questo caso l'ACK viene rispedito:
- Il server invia ACK 701 e il client non lo riceve
- Il client rispedisce quindi il primo pacchetto e il server riceve un duplicato
- Dato che è stato ricevuto un duplicato il server rinvia l'ACK con il numero di sequenza atteso.

---

# Riassunto su meccanismi del TCP
- Pipeline
- Numero di sequenza
- ACK cumulativo e delayed. Ovvero conferma tutti i precedenti e posticipato nel caso di segmenti in sequenza.
- Timeout basato su RTT, ovvero si ha un unico timer di ritrasmissione associato al più vecchio segmento non riscontrato. Se arriva un ACK intermedio si riavvia il timer del più vecchio non riscontrato.
- Ritrasmissione
	- Singola ovvero solo sul segmento non riscontrato
	- Rapida quando si riceve il terzo ACK duplicato prima del timeout del timer.

# Controllo del Flusso
L'obiettivo del controllo del flusso per il mittente è quello di non sovraccaricare il buffer del destinatario inviando troppi dati troppo velocemente.

Per fare questo il destinatario comunica al mittente lo spazio disponibile attraverso il campo `RWND` dell'header.

![[Pasted image 20250331113212.png|400]]

La finestra di invio è completamente gestita dal destinatario:

![[Pasted image 20250331113339.png]]

Quindi mano a mano che vengono ricevuti i riscontri e inviati segmenti, la finestra si sposta verso destra. Riduciamo quindi la grandezza della finestra in base alla situazione attuale della rete e del destinatario.

_Esempio_

![[Pasted image 20250331113603.png]]

1) Viene inviato il pacchetto 100
2) Il server con un ACK comunica la sua finestra grande 800, il client quindi adatta la sua finestra di invio a 800.
3) Il client aggiusta la sua finestra di invio e trasmette un ACK per stabilire la connessione
4) Il client invia 200 byte di dati (parte grigia), il server li riceve e fa scorrere la sua finestra di ricezione, 800-200 = 600
5) Il server invia ACK contenente anche la nuova finestra da 600. Il client la riceve e fa scorrere anche la sua.
6) Il client invia altri 300 byte. Il server li riceve e passa a 300 byte di finestra ma 100 byte di quelli ricevuti vengono passati all'applicazione e quindi li riguadagna la finestra, siamo a 400
7) Il server invia la nuova finestra in un ACK, il client fa scorrere la finestra togliendo da sinistra i segmenti per i quali ha ricevuto ACK e aggiungendo a destra fino a raggiungere 400
8) Il server consuma altri 200 byte e quindi la finestra passa a 600, invia un ACK al client che allargherà verso destra la finestra di invio per farla combaciare.

# Controllo della Congestione
La rete si dice congestionata quando troppe sorgenti inviano troppi dati ad elevata velocità e la rete non riesce a gestirli tutti, questo problema può causare:
- Pacchetti smarriti (overflow nei buffer dei router)
- Lunghi ritardi (accodamento nei buffer dei router)

Cosa cambia dalla gestione del flusso? Con la gestione del flusso andiamo solo a fare in modo che il mittente non sovraccarichi il destinatario, modificando la finestra di invio. Questo però non esclude la possibilità che ad esempio i router possano congestionarsi dato che un router riceve dati da più mittenti.

Quando si iniziano a perdere pacchetti perché i router sono pieni questi vengono rispediti e quindi la rete si sovraccarica ulteriormente.

La congestione è un problema che riguarda IP ma viene gestito da TCP.

Ci si approccia in due modi al controllo della congestione:
- Controllo congestione **end-to-end**: È il metodo che usa TCP e non prevede nessun supporto dalla rete, la congestione viene quindi gestita dagli "estremi" in modo deduttivo andando a osservare perdite e ritardi nei terminali
- Controllo congestione **assistito dalla rete**: I router forniscono un feedback ai sistemi terminali per indicare il livello della congestione

# Problematiche
Ci sono vari problemi per garantire un ottimo controllo della congestione:
1) Come fa il mittente a limitare la frequenza di invio sulla propria connessione?
2) Come fa il mittente a rilevare la congestione?
3) Quale algoritmo va usato per limitare la frequenza di invio in funziona della congestione end-to-end

## Finestra di Congestione
Per controllarla si usa la variabile `CWND` che insieme a `RWND` definisce la dimensione della finestra di invio:
- CWND: Congestione relativa alla rete
- RWND: Congestione relativa al ricevente

La dimensione della finestra è data da `min(rwnd, cwnd)`.

## Rilevare la congestione
Possiamo usare vari segnali:
- ACK duplicati o timeout posso essere interpretati come delle perdite e quindi ridurre la quantità di segmenti da inviare, la rete potrebbe avere qualche congestione.
- Se invece gli ACK arrivano in sequenza e con buona frequenza possiamo aumentare la frequenza di invio, la rete sta funzionando bene
- TCP è **auto-temporizzante** ovvero reagisce in base ai riscontri che ottiene

## Controllo della Congestione
Abbiamo detto quindi che vogliamo incrementare il rate di trasmissione se non c'è congestione e diminuirlo se c'è.

L'algoritmo di controllo si basa su tre componenti:
- Slow Start
- Congestion Avoidance
- Fast Recovery

### Slow Start - Incremento esponenziale
La congestion windows CWND è inizializzata a 1 MSS (quanto inviare) e poiché la banda disponibile è molto maggiore lo slow start incrementa di 1 MSS la cwnd per ogni segmento riscontrato.

Quindi:
- Inizialmente invia 1
- Se riscontriamo 1 la prossima volta inviamo 2
- Se riscontriamo 2 la prossima volta inviamo 4
- Se riscontriamo 4 la prossima volta inviamo 8
- ...

Quindi `cwnd = cwnd + 1`.

Ma quanto possiamo andare avanti in questo modo? Ci sono due casi
- Raggiungiamo una soglia prestabilita chiamata **ssthresh** (slow start threshold)
- Viene perso un pacchetto, in questo caso la threshold ssthresh viene impostata uguale a `cwnd / 2`

Una volta usciti da slow start si entra in **congestion avoidance**

### Congestion Avoidance - Additive Increase
Qui non abbiamo più un incremento esponenziale ma lineare, quando riscontriamo tutti i pacchetti inviati incrementiamo soltanto di 1 la cwnd. Si continua ad aumentare in modo lineare finché non si rileva una congestione con un timeout o 3 ACK duplicati.

Quando si rileva la congestione si imposta `ssthresh = cwnd / 2` ma anche `cwnd = 1`

### Fast Recovery dopo :P

# Versioni TCP
Ci sono diverse versioni di TCP che si muovono fra questi metodi in modo diverso.

## TCP Tahoe
Considera timeout e 3 ACK duplicati come congestione e riparte da `cwnd = 1` con `ssthresh = cwnd / 2`

![[Pasted image 20250405223548.png]]

![[Pasted image 20250405223715.png]]

Come possiamo migliorare questo metodo:
- In questo metodo 3 ACK duplicati indicano che la rete è comunque in grado di trasmettere qualche segmento (oltre a quello perso sono arrivati altri 3 pacchetti)
- Un timeout è invece più allarmante di 3 ACK duplicati, significa che non arriva niente

Quindi invece di reagire ad entrambi i segnali allo stesso modo possiamo reagire in maniera meno drastica nel caso dei 3 ACK duplicati: **Fast - Recovery**
- Incrementa linearmente perché abbiamo una congestione leggera

## TCP Reno
- Se abbiamo timeout si riparte da `cwnd = 1`
- 3 ACK duplicati c'è una congestione lieve quindi si applica fast recovery partendo da `ssthreshold + 3`.

![[Pasted image 20250405224536.png]]

![[Pasted image 20250405224628.png]]
## TCP: Tempo di andata e ritorno e timeout

- Come si imposta il valore del timeout di TCP?
	- Vogliamo impostarlo più grande del tempo di andata e ritorno della connessione ma questo varia
	- Se lo impostiamo troppo piccolo abbiamo un timeout prematuro e quindi ritrasmissioni non necessarie
	- Troppo grande: reazione lenta alla perdita di segmenti

- Come stimare RTT?
	- Sample RTT - Tempo misurato dalla trasmissione del segmento fino alla ricezione di ACK, ignora le ritrasmissioni e si usa un solo SampleRTT per più segmenti trasmessi insieme.
	- SampleRTT varia a causa di congestione nei router e carico nei sistemi terminali, vanno quindi fatte delle stime più "livellate", una media di più misure recenti e non solo il SampleRTT

$$
\text{EstimatedRTT}_{t+1}=(1-\alpha) * \text{EstimatedRTT}_{t} +  \alpha * \text{SampleRTT}_{t+1}
$$

È una media esponenziale ponderata dove l'influenza delle misure passate decresce esponenzialmente.

Il valore tipico di $\alpha=0.125$, in questo modo si assegna minore peso alle misure recenti e di più a quelle vecchie.

_Esempio_

![[Pasted image 20250405225920.png]]

Notiamo che in questo modo i picchi non influenzano di molto la stima

---

Per il timeout facciamo un ragionamento simile.

- EstimatedRTT più un "margine di sicurezza" dove se abbiamo una grande variazione di EstimatedRTT allora abbiamo anche un margine di sicurezza maggiore

Dobbiamo stimare di quanto il SampleRTT si discosta da EstimatedRTT:

$$
\text{DevRTT} = (1-\beta) * \text{DevRTT} + \beta * |\text{SampleRTT - EstimatedRTT}|
$$

Dove tipicamente $\beta = 0.25$

Poi va impostato anche un intervallo di timeout:
- Si imposta un valore iniziale a 1 secondo
- Ad ogni timeout si raddoppia il tempo
- Quando si riceve un segmento si aggiorna EstimatedRTT e si usa la formula:

$$
\text{TimeoutInterval = EstimatedRTT} + 4 * \text{DevRTT}
$$


