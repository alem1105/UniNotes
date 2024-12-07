![[Pasted image 20241130155717.png|500]]

Questo è come si presenta un Hard Disk all'interno, a noi non interessa il tempo in cui il disco reperisce le informazioni ma il bensì il numero di accessi in memoria. Il trasferimento avviene sottoforma di blocchi di byte utilizzando dei buffer grandi quanto un blocco.

Il blocco di byte è la nostra unità di misura per lo spazio e per i trasferimenti.

Un file nel nostro caso è la struttura di memorizzazione di una tabella, questo può richiedere più blocchi per essere memorizzato e un blocco può essere allocato in memoria solo per intero, inoltre un record non può trovarsi "a cavallo" su più blocchi.

- Al momento della formattazione del disco, ogni traccia è suddivisa in blocchi di dimensione fissa.
- Per accesso intendiamo il trasferimento di un blocco da memoria secondaria a principale (lettura) o da memoria principale a secondaria (scrittura).

Quindi il tempo di trasferimento è dato da:
- Tempo di posizionamento della testina
- Ritardo di rotazione del disco, serve a posizionare le testina all'inizio del blocco
- Tempo di trasferimento dei dati

Definiamo il costo in numero di accessi, perché prendere un dato in memoria secondaria richiede molto più tempo dell'elaborazione in memoria principale.

**Come indichiamo gli schemi che conosciamo?**

- Ad ogni relazione corrisponde un file di record, tutti dello stesso tipo.
- Ad ogni attributo corrisponde un campo
- Ad ogni tupla corrisponde un record

**Record**

Da notare che in un record, oltre ai dati della tupla, possono esserci altri campi che contengono informazioni sul record stesso o puntatore ad altri record / blocchi.

Per poter accedere ad un campo di un record è necessario sapere qual è il primo byte del campo nel record, se tutti i campi hanno la stessa lunghezza ci basta ordinarli e in questo modo l'inizio di ciascun campo sarà sempre ad un numero fisso di byte dall'inizio del record, questo numeri di byte si chiama **offset**.

Se invece il record ha campi a lunghezza variabile allora l'offset potrebbe variare da record a record, possiamo utilizzare due strategie:
- all'inizio di ogni campo inseriamo un contatore che indica la lunghezza del campo in numero di byte
- All'inizio del record ci sono due puntatori (con puntatore intendiamo l'offset del campo) all'inizio di ciascun campo a lunghezza variabile, quest'ultimi sono sempre preceduti da tutti quelli a lunghezza fissa.

(Infatti ad esempio prendiamo due record di una tabella studente, due studenti avranno nome e cognome di lunghezza diversa fra loro, in alcuni casi.)

Con la prima strategia abbiamo dei tempi più grandi, dato che per trovare un campo dobbiamo scorrere tutti i precedenti.

**Puntatori**

I puntatori sono dei dati che ci permettono di accedere rapidamente al record / blocco, possono contenere:
- L'indirizzo del primo byte del record / blocco sul disco
Oppure
- Nel caso di un record, una coppia _(b,k)_ dove:
	- _b_ è l'indirizzo del blocco che contiene il record
	- _k_ è il valore della chiave

Utilizzando la seconda strategia possiamo muovere il record all'interno del blocco, dato che una volta identificato quest'ultimo andiamo a cercare la chiave. Se invece spostassimo all'interno del blocco un record utilizzando il primo tipo di puntatori avremo dei _dangling pointer_ ovvero dei puntatori che puntano al niente, inutili.

**Blocchi**

Come per i record, anche i blocchi possono avere dello spazio per memorizzare dati aggiuntivi su di loro o puntatori ad altri blocchi. 

Se un blocco contiene solo record di lunghezza fissa:
- Il blocco è suddiviso in aree (sottoblocchi) di lunghezza fissa ciascuna delle quali riesce a contenere un record.
- Dei bit di utilizzo all'inizio del blocco

Se si deve inserire un record nel blocco occorre cercare un'area non usata e quindi se il bit di utilizzo si trova in ciascun record potrebbe richiedere la scansione di tutto il blocco, per questo li raccogliamo tutti all'inizio.

Se invece il blocco ha record di lunghezza variabile:
- Si pone in ogni record un campo che ne specifica la lunghezza in byte
Oppure
- Si pone all'inizio del blocco una directory con i puntatori ai record del blocco

**Directory del blocco**

È possibile realizzarla in diversi modi:
- Preceduta da un campo che specifica quanti sono i puntatori nella directory
- Una lista di puntatori (la fine si indica con uno 0)
- Ha dimensione fissa e contiene il valore 0 negli spazi che non contengono puntatori

# Operazioni sulla base di dati
Un'operazione sulla base di dati consiste di:
- Ricerca
- Inserimento (implica ricerca se vogliamo evitare duplicati)
- Cancellazione (implica ricerca)
- Modifica (implica ricerca)

Tutte queste operazioni avvengono per i record. Notiamo infine che la ricerca è quindi alla base di tutte le altre operazioni.

Vogliamo che il nostro DBMS esegua queste operazioni in modo efficiente, ovvero il più rapidamente possibile.

Una particolare organizzazione fisica dei dati può rendere più efficienti alcune operazioni, quando si fa il progetto della base è quindi buona norma tenere presente quali saranno le operazioni eseguite più frequentemente.

In generale ad ogni oggetto base di un modello logico (schemi di relazione) corrisponde un file di record che hanno tutti lo stesso formato ovvero gli stessi campi.

Noi ci occuperemo di organizzazioni che consentono la ricerca di record in base al valore di uno o più campi chiave. Da notare che un valore della chiave non necessariamente identifica univocamente un record nel file, come invece accade nella teoria relazionale.

# File Heap
Questa è una NON organizzazione, infatti i record vengono allocati in un ordine determinato soltanto dall'ordine di inserimento, questo porta a prestazioni peggiori in termini di ricerca e quindi di accessi in memoria ma se ammettiamo duplicati, l'inserimento è molto veloce, infatti non controllando se il file già esiste ci basta inserirlo alla fine.

In un file heap infatti un record viene sempre inserito come ultimo record del file e quindi tutti i blocchi ad eccezione dell'ultimo sono pieni. L'accesso al file avviene attraverso la directory che contiene i puntatori ai blocchi.

## Ricerca
Se vogliamo cercare un record specifico dobbiamo cercare in tutto il file, iniziando dal primo record fino ad incontrare quello desiderato, quindi il tempo di ricerca varia in base a dove si trova il record. Se il record che cerchiamo si trova nell'i-esimo blocco avremo i accessi in memoria e quindi **ha senso valutare il costo medio di ricerca**.

_Esempio Pratico_

Abbiamo:
- $N=151$ record
- Ogni record ha 30 byte
- Ogni blocco contiene 65 byte
- Ogni blocco ha un puntatore di 4 byte al prossimo blocco

Quanti record interi possiamo inserire in ogni blocco? Dobbiamo eseguire:

$$
\frac{65-4}{30}
$$

Ovvero $65-4$ perché è la dimensione del blocco meno la dimensione del puntatore, poi dividiamo per 30 che è la dimensione di un record.

Otteniamo $2.03$ come risultato, ovviamente in un blocco non possiamo inserire dei record "a cavallo" e quindi prendiamo la parte intera inferiore, questo significa che in un blocco possiamo inserire 2 record. Quel $0.03$ di blocco non possiamo memorizzarlo in un nuovo blocco.

Quanti blocchi servono per memorizzare $N$ record? Calcoliamo:

$$
\frac{N}{\text{Record per blocco}}=\frac{151}{2}=75.5
$$

In questo caso dato che stiamo considerando i blocchi necessari per memorizzare un record, non arrotondiamo con la parte inferiore ma bensì con la superiore, quindi per memorizzare 151 record con i dati visti prima abbiamo bisogno di 76 blocchi.

Quindi quando effettuiamo una ricerca dobbiamo scorrere una lista di 76 blocchi, se abbiamo fortuna troviamo subito il blocco, ma potrebbe anche trovarsi in ultima posizione.

Abbiamo una situazione simile, **Effettuiamo una ricerca quando la chiave ha valore che non ammette duplicato**:

Definiamo con:
- $R$ il numero di record che possono trovarsi in un blocco, nell'esempio di prima sono 2. 
- $N$ il numero di record
- $n= \frac{N}{R}$ il numero di blocchi

![[Pasted image 20241130192923.png]]

Quindi per ogni record del blocco 2 servono 2 accessi in memoria (scorriamo 2 blocchi) e così via per ogni blocco, per i record del blocco $n$ abbiamo bisogno di $n$ accessi dato che prima scorriamo tutti i precedenti.

Per ottenere il costo medio occorre sommare i costi per accedere ai singoli record e dividere tale somma per il numero di record. Quindi dato che per ogni record degli R record servono i accessi possiamo scrivere:

$$
\begin{align*}
&\frac{R\cdot 1 + R\cdot 2+\dots R\cdot n}{N}=\frac{R(1+2+\dots+n)}{N} \\ \\
&\text{Sappiamo che } \frac{N}{R} = n \text{ quindi } \frac{R}{N}=\frac{1}{n} \text{, sostituiamo:} \\
 \\
&\frac{1+2+\dots+n}{n}=\frac{\sum\limits_{k=1}^n k}{n} \\
 \\
&\text{Ricordiamo la sommatoria di Gauss:} \sum\limits_{k=1}^n k=\frac{n(n+1)}{2}, \text{sostituiamo:} \\
 \\
&\frac{\sum\limits_{k=1}^n k}{n}=\frac{n\cdot(n+1)}{n\cdot2}=\frac{n+1}{2}\approx \frac{n}{2}
\end{align*}
$$

Quindi abbiamo sempre $\frac{n}{2}$ come costo medio.

Se invece vogliamo cercare tutti i record con una determinata chiave che, in questo caso, **ammette duplicati** allora dovremmo comunque accedere a tutti gli $n$ blocchi dato che non possiamo sapere quando abbiamo trovato l'ultima occorrenza.

## Inserimento
Per effettuare l'inserimento abbiamo bisogno di 1 accesso in lettura per portare l'ultimo blocco in memoria principale e un altro accesso in scrittura per riscriverlo in memoria secondaria dopo averlo modificato. Questo accade se **ammettiamo duplicati**.

Se **non ammettiamo duplicati** l'inserimento è preceduto da una ricerca e quindi dobbiamo aggiungere una media di $\frac{n}{2}$ accessi per verificare che non esista già un record con quella chiave.

## Modifica
Abbiamo come primo costo quello della ricerca, infatti dobbiamo trovare il record, poi dobbiamo aggiungere un accesso in scrittura per riscrivere il blocco in memoria una volta modificato, questo costo va ripetuto per ogni occorrenza della chiave, se ammettiamo duplicati.

## Cancellazione
Dobbiamo pagare il costo della ricerca. Se vogliamo evitare "buchi" dobbiamo pagare anche un accesso in lettura in più per leggere l'ultimo blocco e infine 2 accessi in scrittura, uno per riscrivere il blocco modificato e uno per riscrivere l'ultimo blocco dal quale abbiamo spostato l'ultimo record.

# File Hash
Questo tipo di file è suddiviso in **bucket** numerati da 0 a B-1, ciascun bucket è costituito da uno o più blocchi collegati fra loro tramite puntatori e organizzati come un heap. In cima al file c'è la **bucket directory** che contiene tutti i puntatori per i bucket ovvero B elementi.

Abbiamo quindi una struttura simile:

![[Pasted image 20241130213258.png|500]]

## Funzione Hash
Dato un valore _v_ per la chiave, il numero del bucket in cui deve trovarsi un recordo con chiave _v_ è calcolato mediante una funzione chiamata **funzione hash**.

Una funzione di Hash per essere "buona" deve suddividere in modo equo i record nei vari bucket, quindi al variare della chiave tutti i bucket devono avere la stessa probabilità di "uscita". In genere una funzione hash trasforma la chiave in un numero, lo divide per B e fornisce il resto della divisione come numero del bucket (in modo da rimanere limitati al numero di bucket), questo resto è il bucket dove andrà inserito il record.

_Esempio Funzione Hash_

Trattiamo il valore _v_ della chiave come una sequenza di bit, ad esempio $100101111010$, dividiamo tale sequenza in gruppi di bit uguali fra loro e sommiamo tali gruppi come se fossero interi:

$$
1001 | 0111|1010 = 9+7+10=26
$$

Adesso dividiamo questo risultato per il numero di bucket e prendiamo il resto della divisione, questo sarà il bucket. Ad esempio se $B=3$ allora calcoliamo $26\%3=2$, quindi il record che ha questa chiave andrà inserito nell'ultimo blocco del bucket 2.

## Operazioni
Una qualsiasi operazione in un file hash richiede:
- Valutazione della funzione di hash per _v_, $h(v)$, per individuare il bucket, per noi questo ha costo 0 dato che ci interessano soltanto gli accessi in memoria.
- Esecuzione dell'operazione sul bucket che è organizzato come un heap.

Inoltre dato che l'inserimento di nuovi record viene effettuato sull'ultimo bucket, la bucket directory dovrà contenere anche un puntatore all'ultimo record di ogni bucket oltre che al loro inizio.

Quindi se la funzione di hash distribuisce in modo uniforme i record nei vari bucket avremo che ogni bucket è costituito da $\frac{n}{B}$ blocchi e quindi il costo richiesto da un'operazione è approssimativamente $\frac{1}{B}$ - esimo del costo della stessa operazione eseguita su un file heap.

## Osservazioni
Ovviamente più bucket abbiamo più è basso il costo delle operazioni, ma dobbiamo fare delle considerazioni che ci portano a limitare questo numero:
- Ogni bucket deve avere almeno un blocco
- La bucket directory deve avere una dimensione tale da essere mantenuta in memoria principale altrimenti effettueremo accessi per leggere i blocchi della bucket directory.

**Osservazioni per esame e corso**
- Ogni record deve essere contenuto completamente in un blocco
- I blocchi vengono allocati per intero