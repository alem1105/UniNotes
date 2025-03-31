Il protocollo TCP raggruppa un certo numero di byte da inviare in un segmento al quale poi aggiunge un'intestazione.

Come è fatta questa intestazione?

# Struttura Segmenti

![[Pasted image 20250331094634.png]]

- Numero di sequenza: È il numero di sequenza del primo byte che stanno venendo inviati
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
3) Il client invia la sua `receive window` e un `ACK`

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

- Arriva un segmento con numero di sequenza atteso e un altro segmento precedente è in attesa di trasmissione dell'ACK
- Si invia un singolo ACK cumulativo per entrambi

---

**Regola 4**

- Arriva un segmento non ordinato che ha quindi un numero di sequenza superiore a quello atteso e viene quindi rilevato un buco.
- Viene subito inviato un ACK duplicato indicando il numero di sequenza del prossimo byte atteso. Questa procedura prende il nome di **ritrasmissione veloce**

---

**Regola 5**

- Arriva un segmento mancante ovvero è già stato ricevuto un suo successivo.
- Viene inviato subito un ACK

---

**Regola 6**

- Arriva un segmento duplicato
- Invia un ACK che contiene il numero di sequenza atteso.

## Ritrasmissione dei segmenti
Quando un segmento viene inviato viene comunque mantenuta una copia in una coda, in attesa di ricevere un riscontro.

Se questo riscontro non arriva possono accadere due cose:
- Se è il primo segmento all'inizio della coda può scadere il timer e viene quindi ritrasmesso. Viene anche rinviato il timer.
- Vengono ricevuti 3 ACK duplicati e quindi avviene una **ritrasmissione veloce** del segmento senza aspettare il timer.

---

_FSM per Mittente_

![[Pasted image 20250331110114.png|500]]

_FSM Destinatario_

![[Pasted image 20250331110225.png|500]]

---

Usando quindi i timer per gli ACK cumulativi avremo una situazione simile:

![[Pasted image 20250331110413.png|500]]

Quando il client riceve 4001-5000 si aspetta 5001, attende 500ms e non riceve niente e quindi invia ACK di 5001.

Il server risponde con 5001-6000 e quindi il server aspetta per 500ms il 6001, dato che riceve 6001-7000 entro la finestra invia un singolo ACK di 7001.

## Segmento Smarrito

![[Pasted image 20250331110838.png|500]]

1) Client invia in ordine 501 - 600 e 601-700 quindi il server aspetta 701.
2) 701-800 viene spedito ma smarrito
3) Il client invia anche 801-900 e il server lo riceve, siccome ha ricevuto un pacchetto superiore a quello che si aspettava rinvia un ACK di 701.
4) Il client lo riceve e rispedisce 701-800
5) A questo punto il server, una volta ricevuto spedisce l'ACK dei prossimi ovvero 901.

## Ritrasmissione Rapida

![[Pasted image 20250331111316.png|500]]

Il pacchetto perso è il 301-400. Una volta che il client ha ricevuto 3 ACK duplicati per lo stesso pacchetto inizia la ritrasmissione veloce **prima dello scadere del timer** del 301.

## Riscontro smarrito senza ritrasmissione

![[Pasted image 20250331111719.png|500]]

Viene smarrito ACK di 701 ma non viene ritrasmesso dato che il server ha ricevuto dei segmenti successivi e quindi può inviare direttamente ACK di 901. Ma non sempre accade questo

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
4) Il client invia 200 byte di dati (parte griga), il server li riceve e fa scorrere la sua finestra di ricezione, 800-200 = 600
5) Il server invia ACK contenente anche la nuova finestra da 600. Il server la riceve e fa scorrere anche la sua.
6) Il client invia altri 300 byte. Il server li riceve e passa a 300 byte di finestra ma 100 byte di quelli ricevuti vengono passati all'applicazione e quindi li riguadagna la finestra, siamo a 400
7) Il server invia la nuova finestra in un ACK, il client fa scorrere la finestra togliendo da sinistra i segmenti per i quali ha ricevuto ACK e aggiungendo a destra fino a raggiungere 400
8) Il server consuma altri 200 byte e quindi la finestra passa a 600, invia un ACK al client che allargherà verso destra la finestra di invio per farla combaciare.

# Controllo della Congestione