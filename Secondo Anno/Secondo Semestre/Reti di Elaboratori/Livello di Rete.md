Il livello di rete nella pila dei protocolli è quello che si occupa di instradare i datagrammi dal mittente al destinatario.

Quindi a differenza del livello di trasporto non stiamo più facendo comunicare due processi ma **due host**.

Il livello di rete prende i segmenti del trasporto, li incapsula trasformandoli in **datagrammi** e li trasmette al router più vicino, il datagramma viene instradato fra i vari router fino a raggiungere l'host destinatario, dove viene decapsulato e inviato al livello di trasporto.

Abbiamo detto che il datagramma viene instradato fra i router, ma come fa un router a capire dove mandarlo?

# Funzioni del Livello di Rete

- **Routing** - Determina il percorso da seguire, dall'origine fino alla destinazione. Più localmente, un router decide quale sarà il prossimo router su cui instradare il datagramma.
- **Forwarding** - Si occupa del trasferimento vero e proprio dei pacchetti sul percorso scelto dal routing.

Più nello specifico, tramite gli **algoritmi di routing** creiamo le **tabelle di routing** (o forwarding table) che verranno poi usate dal forwarding.

Le tabelle di solito associano ad ogni intestazione un collegamento d'uscita.

## Switch e Router
Sono entrambi dei **packet switch (commutatore di pacchetto)** ovvero dei dispositivi che si occupano di trasferire dati da un'interfaccia di ingresso ad una di uscita in base ai valori presenti nei datagrammi.

- **Link - layer switch (commutatore a livello di collegamento)** - Stabiliscono il percorso in base al campo presente nell'intestazione a livello di collegamento (livello 2)
  
  Principalmente usato per collegare singoli computer all'interno di una LAN
  
- **Router** - Stabiliscono il percorso in base al campo presente nell'intestazione a livello di rete (livello 3)
  
  Riceve un insieme di informazioni (pacchetto) e in base alle tabelle di routing decide quale sarà il prossimo router su cui instradarlo 

# Circuit Switching vs Packet Switching
- **Circuit Switching** (approccio a circuito virtuale) - È un servizio orientato alla connessione, infatti prima che i datagrammi passino è necessario che i due host e i vari router intermedi abbiano stabilito una connessione virtuale
- **Packet Switching** (approccio a datagramma) - Non è orientato alla connessione infatti ogni datagramma viaggia in modo indipendente dagli altri.

## Reti a Circuito Virtuale
In questo tipo di rete viene quindi stabilita una connessione virtuale e durante tutta la connessione i pacchetti seguiranno il percorso prestabilito inizialmente.

I pacchetti in un circuito virtuale hanno un'**etichetta di circuito** VC nella loro intestazione, il router in base a questo numero sceglie su che percorso instradare il pacchetto. Da notare che il VC può essere diverso da router a router anche riferendosi allo stesso percorso, per questo ai pacchetti viene cambiato il VC durante il passaggio all'interno di un router.

![[Pasted image 20250409102937.png|500]]

### Implementazioni
Ci serve:
- Un percorso tra i due host
- Numeri di VC per ogni collegamento
- Righe nella tabella di inoltro in ciascun router

- Il numero di VC rappresenta un etichetta di flusso e cambia su tutti i collegamenti del percorso.

_Esempio_

![[Pasted image 20250409103225.png|300]]

- Possibile tabella di R1:

![[Pasted image 20250409103338.png|500]]

1) Entra nell'interfaccia 1 un pacchetto con VC 12
2) Viene instradato sull'interfaccia 2 e gli viene cambiato il VC in 22
3) R2 probabilmente avrà una regola per la quale i pacchetti con VC 22 dall'interfaccia 1 vanno in interfaccia 2 con VC 32

Per ogni connessione stabilita i router mantengono una linea nella tabella, quando una connessione viene rilasciata non ne hanno più bisogno e quindi la cancellano.

> [!info] ATM (Asynchronous transfer mode)
> È una rete orientata alla connessione progettata negli anni 90 allo scopo di unificare dati, voce, televisione via cavo....
> Viene usata ancora oggi per spostare pacchetti IP all'interno della rete telefonica.
> Le connessioni vengono chiamate **circuiti virtuali** dato che quelli telefonici sono quelli fisici.
> Una volta stabilita una connessione, entrambe le parti possono trasmettere.

## Reti a Datagramma
**Internet** di oggi è una rete a datagramma (packet switched), quindi i router in questo caso non conservano informazioni sui circuiti virtuali dato che non esistono vere e proprie connessioni a livello di rete. I pacchetti vengono semplicemente inoltrati in altri router in base al loro indirizzo di destinazione.

Questo significa inoltre che i pacchetti non seguiranno più lo stesso percorso, potenzialmente potrebbero prendere ciascuno un percorso diverso per arrivare a destinazione.

![[Screenshot 2025-04-09 alle 10.44.32.png|500]]

In questo caso la tabella di inoltro dei router sarebbe troppo grande se coprisse tutte le possibilità, ovvero circa 4 miliardi di possibili indirizzi.

Per scegliere il percorso viene utilizzato quindi il prefisso degli indirizzi:

![[Pasted image 20250409104940.png|300]]

- Se riceve 11001000 00010111 00010110 10100001 verrà instradato sull'interfaccia 0 
- Se riceve 11001000 00010111 00011000 10101010 verrà instradato sull'interfaccia 1

Nel secondo caso scegliamo l'interfaccia 1 anche se il prefisso è uguale alla 2 perché abbiamo più cifre che combaciano sulla 1 (i 3 zeri che seguono i due 1).

Ovviamente per avere questo tipo di tabelle devo avere **continuità** degli indirizzi ovvero essere sicuro che in quella interfaccia su cui instraderò il pacchetto poi troverò la destinazione.

# Router
Come è fatto un router? (praticamente tutto quello visto fino ad adesso)

![[Pasted image 20250409105535.png]]

La commutazione può avvenire anche direttamente sulle porte, prende il nome di **commutazione decentralizzata**, questa è permessa da una copia della tabella d'inoltro nella porta di ingresso.

Questo tipo di commutazione serve ad avere un'elaborazione allo stesso tasso della linea ed evitare i colli di bottiglia ovvero quando il tasso di arrivo è maggiore a quello di inoltro.

Una volta scelto il percorso il pacchetto viene mandato alla switching fabric dove viene instradato sulla porta di output.

Sulle porte di output è presente quindi la **funzionalità di accodamento** che gestisce i colli di bottiglia e lo **schedulatore di pacchetti** che stabilisce in quale ordine spedire quelli accodati.

## Ricerca nella tabella di inoltro
Come è strutturata la tabella per garantire una ricerca veloce? Usa una **struttura ad albero**:
- Ogni livello corrisponde ad un bit dell'indirizzo di destinazione
- Si inizia dalla radice e si va a sinistra se il bit è 0, a destra se il bit è 1

La ricerca avviene in N passi dove N è il numero di bit dell'indirizzo

## Tecniche di Commutazione

![[Pasted image 20250409110204.png|400]]

### Commutazione in Memoria
Utilizzata dalle prime generazioni di router, la commutazione era effettuata sotto il controllo della CPU.

Il pacchetto veniva copiato nella memoria del processore e poi trasferito nelle porte di output.

### Commutazione tramite bus
In questo caso le porte di ingresso trasferiscono un pacchetto direttamente alle porte di output tramite un bus condiviso, senza utilizzare il processore.

In questo modo però si può trasferire un solo pacchetto alla volta e quindi si ha che la larghezza di banda della commutazione è limitata da quella del bus, c'è una vera e propria **contesa per il bus**.

Alcuni router però hanno bus da 32Gbps che sono sufficienti per reti d'accesso o aziendali.

### Commutazione con rete d'interconnessione
Questa tecnica permette di superare il limite di larghezza di banda di un solo bus.

Si usa una **crossbar switch** ovvero una rete che consiste di $2n$ bus che collegano $n$ porte d'ingresso a $n$ porte d'uscita (disegno sopra). Si utilizza questa rete andando a frammentare ulteriormente i pacchetti e riassemblandoli alla porta d'uscita.

I router di oggi utilizzano reti d'interconnessione fino a 60Gbps

## Accodamento
Può verificarsi sia nelle porte di input che in quelle di output, ricordiamo:
- Velocità di commutazione: Frequenza alla quale il router trasferisce i pacchetti dalle porte input a quelle output.

- **Accodamento nelle porte di input** - Quando la velocità di commutazione è inferiore a quella delle porte di ingresso
- **Accodamento nelle porte di output** - Quando la velocità di commutazione è più veloce di quella delle porte di output oppure quando troppi pacchetti vanno sulla stessa porta.

### Accodamento sulle porte in Input
Oltre alla differenza di velocità può verificarsi anche per dei **blocchi in testa alla fila (HOL: Head Of The Line Blocking)** ovvero quando un pacchetto nella coda d'ingresso deve attendere il suo trasferimento, anche se la sua coda è libera, perché in testa alla coda c'è un pacchetto bloccato:

![[Pasted image 20250409111726.png|400]]

Il pacchetto verde potrebbe passare ma è bloccato da quello rosso.

In questi casi se le code diventano troppo lunghe si potrebbero saturare i buffer e quindi in pacchetti in eccesso verrebbero scartati.

### Accodamento sulle porte di Output
Non ci sono altri casi particolari oltre a:
- Velocità di commutazione superiore a quello di uscita
- Troppi pacchetti sulla stessa uscita

Anche qui quindi se le code sono troppo lunghe si saturano i buffer e si perdono pacchetti.


> [!info] Capacità dei Buffer
> Che capacità dovrebbero avere? Si segue la regola definita in RFC 3439 ovvero una media del tempo di andata e ritorno per la capacità del collegamento.
> 
> Ad esempio se abbiamo un RTT di 250ms e il collegamento C da 10Gbps avremo buffer da 2.5Gbit.
> 
> Oggi si usano regole diverse come ad esempio: $\frac{RTT \cdot C}{\sqrt{ N }}$ dove N sono i flussi TCP

# Protocolli del Livello di Rete
- IP - Internet Protocol (v4 e v6)
- IGMP - Internet Group Management Protocol (si occupa del multicasting)
- ICMP - Internet Control Message Protocol (gestione errori)
- ARP Address REsolution Protocol (associa indirizzi IP - ind. collegamento)

Si può associare a livello di rete anche il DHCP, anche se è livello applicazione. È il protocollo che all'interno di una rete assegna ai dispositivi un indirizzo IP non appena questi si collegano.

## Internet Protocol IPv4
Si occupa della suddivisione in pacchetti, del forwarding e della consegna dei datagrammi a livello di rete, quindi da un host all'altro.

È un protocollo detto inaffidabile, non orientato alla connessione e basato sui datagrami, offre un servizio **best effort** (il meglio che può).

Come sono formati i datagrammi?

![[Pasted image 20250409112638.png|500]]

- Numero versione - consente al router la corretta interpretazione
- Lunghezza Intestazione - Dato che un datagramma IP ha un numero variabile di opzioni, questa indica dove inizia il campo dati (default = 20 byte)
- Tipo di servizio - Distingue diversi datagrammi che hanno bisogno di prestazioni differenti (alcuni sono più urgenti di altri)
- Lunghezza datagramma - Lunghezza totale con intestazione inclusa. Di base non supera i 1500byte. Serve a capire se il pacchetto è arrivato intero
- Identificatore, flag e offset di frammentazione - Servono a gestire la frammentazione (dopo)
- Tempo di vita - Serve a fare in modo che i datagrammi non circolino per sempre nella rete, ad ogni hop viene decrementato e quanto raggiunge 0 il pacchetto viene eliminato.
- Protocollo - Indica a quale protocollo del livello di trasporto va passato il datagramma. Viene utilizzato soltanto nella destinazione finale.
	- 6: TCP
	- 17: UDP
	- 1: ICMP
	- 2: IGMP
	- 89: OSPF
- Checksum dell'intestazione - Rilevazione di errori, si calcola solo in base all'intestazione a differenza di quella UDP / TCP
- Indirizzi IP origine e destinazione - Vengono inseriti dall'host che crea il datagramma
- Opzioni - Usate per debug della rete
- Dati - Dati veri e propri da trasmettere

## Frammentazione
Un datagramma IP può dover viaggiare in più reti, tutte con caratteristiche diverse fra loro. Ogni router estrae il datagramma dal frame, lo elabora e lo incapsula in un nuovo frame.

Definiamo:
- MTU (Maximum Transfer Unit) - Massima quantità di dati che un frame a livello di collegamento può trasportare. Questo valore varia in base alla tecnologia

![[Pasted image 20250409113610.png|400]]

Grazie alla frammentazione, grandi datagrammi IP vengono frammentati in datagrammi IP più piccoli:
1) Datagramma frammentato
2) I frammenti verranno riassemblati soltanto a destinazione
3) Vanno riassemblati prima di raggiungere il livello di trasporto
4) I bit dell'intestazione sono usati per identificare e ordinare i frammenti

![[Pasted image 20250409113909.png|300]]


Quindi quando un host riceve una serie di datagrammi dalla stessa origine deve:
- Individuare i frammenti
- Determinare quando è arrivato l'ultimo
- Stabilire l'ordine di riassemblaggio

Come eseguire le varie fasi:
- Identificazione (16 bit) - Identificativo associato ad ogni datagramma al momento della sua creazione
- Flag (3 bit)
	- Il primo è riservato (?)
	- Il secondo se 1 significa che il datagramma non va frammentato, 0 si può frammentare
	- L'ultimo se vale 1 indica che è un frammento intermedio, 0 se ultimo frammento
- Offset - Indica l'ordine del frammento all'interno del datagramma originario

L'offset è calcolato nel seguente modo:

![[Pasted image 20250409115555.png|500]]

Si calcola quindi:
- Primo frammento ha 0
- Secondo frammento ha `lunghezza primo frammento (precedente) / 8`
- ...

_Esempio di Frammentazione_

![[Pasted image 20250409115716.png]]

Il valore 14.567 indica il datagramma, poi ha 0 quindi significa che può essere scomposto.

I suoi frammenti hanno lo stesso valore di identificazione e poi gli intermedi 1 e l'ultimo 0 su `more fragments`.

L'offset ci indica l'ordine con quale assemblarli a destinazione, da notare che il primo avrà offset a 0 mentre l'ultimo ha il campo M `more fragments` a 0
