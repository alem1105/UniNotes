# Visione d'Insieme

## I File
I file sono l'elemento principale per la maggior parte delle applicazioni, molto spesso l'input di un'applicazione è un file o anche l'output.

I file a differenza della RAM "sopravvivono" ad un processo.

Il file system è quindi una parte del SO che più interessa all'utente e delle proprietà che deve gestire il SO sono:
- Esistenza a lungo termine dei file
- Diversi processi utilizzano gli stessi file
- Strutturabilità ovvero un sistema di organizzazione per aiutare l'utente a trovare i file

## Gestione dei File
I file vengono gestiti da un insieme di programmi e librerie del kernel e questi vengono chiamati **File Management System** e sono eseguiti a livello kernel.

Le librerie vengono invocate come system call sempre in kernel mode.

Questi hanno a che fare con la memoria secondaria e in Linux anche con la RAM, possiamo gestirla come fosse un file.

Forniscono astrazione attraverso delle operazioni.

Per ogni file vengono mantenuti dei metadati come il proprietario, la dimensione, la creazione ecc...

## Operazioni sui File
- Creazione
- Cancellazione
- Apertura
- Lettura, solo su file aperti
- Scrittura, solo su file aperti
- Chiusura

> [!NOTE] Terminologia
> - Campo (field)
> - Record
> - File
> - Databse

## Campi e Record
I **campi** sono i dati di base e contengono valori singoli, sono caratterizzati da una lunghezza e un tipo di dato, un esempio di campo é un carattere ASCII.

Un insieme di Campi è un **record**, ad esempio Impiegato è caratterizzato da _nome, cognome, matricola, stipendio_.

## File e Database
I file sono visti come **insieme di record**, questi hanno un nome e possono implementare meccanismi di controllo dell'accesso, decidere quindi chi può accedere a cosa. Nei moderni SO ogni record è un solo campo con un byte.

I database sono collezioni di file, esistono dei DBMS che sono dei processi che gestiscono database.

## Sistemi per la gestione dei File

![[Pasted image 20241209182306.png]]

Adesso ci occuperemo di _Directory Management, File System, Physical Organization_.

I File Management Systems sollevano i programmatori dal dover scrivere codice per gestire i file e forniscono servizi agli utente per l'uso di file.

**Obiettivi per un File Management System**:
- Rispondere alla necessità degli utenti riguardo alla gestione dei dati
- Garantire che i dati non si corrompano
- Ottimizzare le prestazioni
- Fornire supporto per diversi tipi di memoria secondaria come USB, CD, DVD…
- Minimizzare i dati persi o distrutti
- Fornire interfacce standard per processi utente
- Fornire supporto per I/O effettuato da più utenti in contemporanea

**Requisiti per i File Management System**:
- Ogni utente deve essere in grado di creare, cancellare e modificare un file
- Ogni utente deve poter accedere in modo controllato ai file di un altro utente
- Ogni utente deve poter leggere e modificare i permessi di accesso ai propri file
- Ogni utente deve poter ristrutturare i propri file in modo attinente al problema affrontato (nei moderni SO hanno rimosso l'organizzazione in campi record ecc... e i file sono soltanto una sequenza di byte, e sta a chi progetta l'applicazione decidere come interpretare i byte)
- Ogni utente deve poter muovere i dati da un file ad un altro
- Ogni utente deve poter mantenere una copia di backup dei propri file
- Ogni utente deve poter accedere ai propri file tramite nomi simbolici (scelti da lui)

Ma vediamo come é organizzato il codice, riprendiamo la foto di prima:

![[Pasted image 20241209182306.png]]

- Directory Management: Sono tutte le operazioni utente che hanno a che fare con i file come crearli, cancellarli ecc... In questa fase si passa da nomi di file a identificatori.
- File System: Struttura logica delle operazioni (apri, chiudi, leggi, scrivi …)
- Organizzazione fisica: Dagli identificatori dei file si passa agli indirizzi fisici sul disco. Decide dove mettere i file e come posizionarli.
- Scheduling & Control: Qui avvengono i vari SCAN

# Le Directory
Le directory sono anche loro dei file, anche se speciali, queste contengono altri file e le loro informazioni come attributi (metadati), proprietario e soprattutto la loro posizione. Forniscono inoltre il mapping tra nome del file e file vero e proprio.

I file system permettono in genere diverse operazioni sulle directory:
- Ricerca
- Creazione File
- Cancellazione File
- Lista del contenuto
- Modifica della directory

Le directory devono mantenere, per ogni file:
- Delle informazioni di base
	- Nome del file, che in ogni directory deve essere unico
	- Tipo del file (anche se alcuni SO non lo fanno)
	- Organizzazione del file (non viene più usato ma serviva a capire come interpretare un file, come erano organizzati i suoi record e campi)
- Informazioni sull'indirizzo
	- Volume: Indica il dispositivo sui cui é memorizzato il file
	- Indirizzo di partenza: da quale traccia o settore inizia il file
	- Dimensione attuale in word, byte o blocchi
	- Dimensione allocata: la dimensione massima del file
- Controllo di Accesso
	- Proprietario, chi può concedere o negare permessi ad altri utenti e modificare tali impostazioni
	- Informazioni sull'accesso: ad esempio nome utente e password degli utenti autorizzati
	- Azioni permesse: Per controllare lettura, scrittura, esecuzione o altro tramite rete
- Informazioni sull'uso
	- Data di creazione e identità del creatore
	- Ultimo accesso in lettura e scrittura
	- Identità ultimo lettore o scrittore
	- Data ultimo backup
	- Uso attuale

Il metodo usato per memorizzare le informazioni sopra varia da sistema a sistema.

Inizialmente si faceva una sola directory con una lista di tutti i file sul dispositivo ma ovviamente portava a diversi problemi, ad esempio non si poteva dare lo stesso nome a due file e poi con il crescere dei file non aiutava l'organizzazione.

Si è passati a uno **schema a due livelli** dove c'è una directory per ogni utente che contiene una lista dei file di quell'utente. Inoltre tutte le directory degli utenti erano contenute in una directory **master**.

## Schema Gerarchico ad Albero
Infine si è arrivati allo schema usato ancora oggi ovvero uno **schema gerarchico ad albero per le directory**. Qui una directory **master** contiene le directory utente che a loro volta possono contenere sia file che altre directory. Esistono anche sottodirectory di sistema.

![[Pasted image 20241210123145.png]]

Gli utente devono potersi riferire ad un file usando solo il suo nome, questo deve essere unico. La struttura ad albero permette agli utenti di trovare un file seguendo un percorso nell'albero (directory path), i nomi duplicati sono possibili solo se con percorsi diversi.

## Directory di Lavoro
Dare ogni volta il percorso intero di un file potrebbe risultare lento e noioso, per questo agli utenti viene solitamente associata una directory di lavoro, tutti i nomi dei file sono forniti relativamente a questa directory. Ovviamente è sempre possibile fornire l'intero percorso

# Gestione della Memoria Secondaria
Il SO è responsabile dell'assegnamento di blocchi a file, significa che deve soddisfare l'utente sulle operazioni dei file, avendo a disposizione il disco.

Per fare questo ci sono due problemi principali:
- Decidere dove posizionare le strutture richieste
- Mantenere traccia di dove è stato deciso mettere le informazioni di un file

Ovviamente per fare questo è necessario tenere traccia anche dello spazio libero ovvero quello allocabile.

I file si allocano in "blocchi" e l'unità minima è il settore del disco, di solito un blocco è una sequenza contigua di settori del disco. Quindi ad esempio se dobbiamo salvare un file anche di un solo carattere, il SO allocherà comunque un intero blocco.

Ci sono vari problemi da affrontare.

## Allocazione di Spazio per i File
Dobbiamo decidere:
1) Se fare **preallocazione** oppure **allocazione dinamica**
2) Blocchi di dimensione fissa o dinamica, di solito quando si parla di blocchi siamo in dimensioni fisse, se parliamo di porzioni in dinamica.
3) Metodo di allocazione: Contiguo, concatenato o indicizzato
4) Gestione della file allocation table: una tabella che mantiene delle informazioni per ogni file come ad esempio dove si trova sul disco e quali porzioni lo compongono.

### Preallocazione vs Allocazione Dinamica
La preallocazione è molto semplice, stiamo creando un file e allora allochiamo sul disco la dimensione massima che quel file può richiedere. Nei file system che usano questa allocazione al momento di creazione di un file dobbiamo dichiarare anche la sua grandezza massima.

Ovviamente in alcune situazioni si può stimare facilmente la dimensione massima del file mentre in altre no. Quindi in alcuni caso la preallocazione porta a spreco di spazio anche se a un risparmio di computazione.

Per questo la preferita è la allocazione dinamica, la dimensione viene aggiustata in base alle syscall _append, truncate_.

### Dimensione delle Porzioni
Quanto facciamo grandi le porzioni?

Abbiamo due possibilità:
- Allocare subito una porzione larga a sufficienza per l'intero file, questo è molto efficiente per il processo dato che le porzioni sono contigue e l'accesso sequenziale è più veloce.
- Allocare un blocco alla volta, è molto efficiente per il SO che deve gestire molte richieste.

Per fare al meglio, si cerca un insieme di queste due tecniche:
- Per le prestazioni di accesso al file sono ottime porzioni contigue
- Porzioni piccole portano a grandi tabelle di allocazione e quindi molto overhead dato che nella tabella abbiamo molte "indicazioni" per raggiungere tutte le porzioni di ogni file. Ma portano anche a maggior riutilizzo dei blocchi
- Vogliamo evitare grandi porzioni fisse che causano frammentazione interna, ovvero spreco di spazio
- La frammentazione esterna è sempre possibile infatti i file possono venire cancellati. Per frammentazione esterna intendiamo quando rimangono degli "spazi" non allocati molto piccoli non contigui sparsi per la memoria e che quindi non possono essere allocati da altri file, risultando quindi inutili. Essenzialmente, nel complesso magari abbiamo spazio per un nuovo file, ma gli "spazi" di memoria liberi non sono grandi abbastanza o non contigui da contenerlo.

Arriviamo quindi a 2 possibilità, valide per entrambi i tipi di allocazione:
- Porzioni grandi e di dimensione variabile, in questo modo ogni allocazione è contigua e le tabella delle allocazioni non è molto grande ma diventa complicata la gestione dello spazio libero, avremo bisogno di algoritmi ad hoc
- Porzioni fisse e piccole, tipicamente 1 blocco per 1 porzione, molto meno contiguo dell'altra opzione e per lo spazio libero ci basta guardare una tabella di bit.

Ad esempio con la preallocazione conviene utilizzare le porzioni grandi con dimensione variabile, in questo modo nella tabella ci basta salvare per ogni indirizzo il suo inizio e la lunghezza. Anche qui come nella RAM ci sono diversi modi per scegliere dove salvare i file ma é comunque inefficiente per quanto riguarda lo spazio libero dato che avremo bisogno di fare compattazione (problema della frammentazione). Compattare il disco é più costoso che compattare la RAM dato che il disco è un dispositivo I/O.

## Come Allocare spazio per i File
Si utilizzano principalmente 3 metodi:
- Contiguo
- Concatenato
- Indicizzato

In ogni caso serve una tabella di allocazione dei file.

Per ciascuno dei metodi ci sono delle "regole":

![[Pasted image 20241210160643.png]]

### Allocazione Contigua
Se abbiamo un file e sappiamo quanto è grande allochiamo subito tutta la memoria necessaria in modo contiguo. Se non sappiamo quanto diventerà grande il file non possiamo quindi applicarla, perderemo contiguità.

In questo modo per ogni file sarà necessaria una sola entry nella tabella di allocazione che indica la partenza e la lunghezza del file.

Ci sarà frammentazione esterna al momento di cancellazione dei file con quindi necessità di compattazione.

![[Pasted image 20241210161134.png]]

Quindi ad esempio se volessimo salvare un file da 8 blocchi anche se abbiamo a disposizione lo spazio necessario non potremmo farlo dato che non abbiamo 8 sezioni contigue, dovremmo eseguire una compattazione che ancora al giorno d'oggi è molto onerosa per il disco.

Se però eseguiamo compattazione otteniamo:

![[Pasted image 20241210161357.png]]

Da notare che è cambiata anche la tabella ovviamente.

### Allocazione Concatenata
Allochiamo un blocco alla volta, non è necessaria preallocazione.

Ogni blocco, nella parte finale ha un puntatore  al prossimo blocco, anche qui nella tabella abbiamo bisogno di una sola entry dato che i puntatori sono sparsi fra i blocchi.

La frammentazione interna è trascurabile mentre quella esterna non c'è dato che non vogliamo contiguità.

È buona se vogliamo accedere ad un file sequenzialmente ma se invece ci serve un certo blocco dobbiamo scorrerli tutti fino ad arrivare a quello desiderato.

Al posto della compattazione si esegue il **consolidamento** ovvero mettere i blocchi di un file contigui e migliorare l'accesso non sequenziale, quindi non serve a guadagnare spazio ma solo a migliorare le prestazione.

![[Pasted image 20241210161900.png]]

Se eseguiamo un consolidamento:

![[Pasted image 20241210161925.png]]

### Allocazione Indicizzata
Questa è quella più utilizzata, anche se al giorno d'oggi con delle modifiche, è infatti una via di mezzo fra i due metodi precedenti ma risolve i loro problemi.

Qui la tabella contiene una sola entry per file con l'indirizzo di un blocco, ma questo blocco in realtà ha una entry per ogni porzione allocata al file, quindi abbiamo blocchi con indirizzi e blocchi con informazioni. È presente quindi un bit che indica che cosa contiene il blocco e se il file è troppo grande si fanno più livelli.

Vediamo un esempio:

![[Pasted image 20241210162340.png]]

Quindi la tabella ci dice che il file B ha come blocco indice il blocco 24, dentro a questo blocco non troviamo i dati del file ma gli indirizzi dei blocchi che contengono il file, in questo caso, in ordine: 1,8,3,14,28.

Questo esempio è se utilizziamo delle porzioni a lunghezza fissa, se le abbiamo variabili:

![[Pasted image 20241210162516.png]]

In questo caso il blocco degli indici oltre agli indirizzi deve contenere anche la lunghezza dei blocchi con le informazioni.

---

L'allocazione qui può essere:
- Blocchi di lunghezza fissa: niente frammentazione esterna
- Blocchi di lunghezza variabile: rischiamo frammentazione esterna ma migliore località
A volte occorre il consolidamento:
- Blocchi di lunghezza fissa: migliora la località
- Blocchi di lunghezza variabile: riduce la dimensione dell'indice, prendiamo l'ultimo esempio, se il file B fosse tutto contiguo il suo blocco avrebbe una sola entry e non 3.

## Gestione dello Spazio Libero
Adesso vediamo come gestire lo spazio libero invece di quello occupato dai file, infatti anche questo è altrettanto importante dato che per salvare i file devo sapere dove ho dello spazio libero.

Ci serve una tabella di allocazione di disco oltre a quella di allocazione dei file e ogni volta che si alloca o cancella un file dobbiamo aggiornare questa tabella.

Abbiamo comunque diversi modi per farlo

### Tabelle di bit
Un vettore dove ogni bit é riferito ad un blocco su disco, se 0 il blocco é libero altrimenti é occupato, questo va bene per tutti gli schemi visti finora e minimizza lo spazio richiesto nella tabella di allocazione del disco.

Il problema é che se il disco é quasi pieno devo scorrere tutti i bit alla ricerca di uno 0, questo é risolvibile con delle tabelle riassuntive di porzioni della tabella di bit, ad esempio che indicano il numero di blocchi liberi in totale e quello di blocchi liberi contigui.

### Porzioni libere concatenate
Questo metodo non ha praticamente overhead di spazio, infatti mi basta sapere dove sta la prima porzione libera e poi con dei puntatori vado a prendere le successive, un po' come avevamo visto nell'allocazione concatenata.

Quindi avere zone libere contigue mi fa risparmiare spazio nella tabella dato che posso indicare l'inizio e la lunghezza.

Anche questa va bene per tutti gli schemi visti ma ci sono dei problemi:
- Se c'è frammentazione le porzioni sono tutte da un blocco e la lista diventa lunga dato che non posso indicare una lunghezza e l'inizio, ma ogni volta un nuovo inizio per ogni porzione.
- È lungo cancellare file molto frammentati

### Indicizzazione
Tratta lo spazio libero come un file e quindi usa un indice come si farebbe per un file, l'indice gestisce le porzioni come se fossero di lunghezza variabile e quindi abbiamo un'entry per ogni porzione libera nel disco.

Questo offre molta efficienza a tutti i metodi di allocazione visti finora.

### Lista dei Blocchi liberi
Ogni blocco ha un numero sequenziale e questi numeri vengono salvati in una zona di memoria.

Per i file noi carichiamo in RAM la tabella solo quando ne abbiamo bisogno, per quanto riguarda lo spazio libero invece dobbiamo sempre avere a disposizione informazioni su di esso. Con questo metodo riusciamo a farlo portando in RAM una parte di questa lista di numeri associati ai blocchi, possiamo infatti organizzarla come una pila e tenere la parte alta in RAM e poi utilizzare _pop_ per allocare spazio, _push_ per deallocare spazio. Quando la parte in RAM finisce si prende una nuova parte dal disco.

Ovviamente possiamo gestirla anche in altri modi come ad esempio una coda.

## Volumi
I volumi sono un disco "logico" infatti possono essere una partizione del disco oppure anche più dischi messi insieme e visti come un solo volume (LVM).

I volumi sono quindi un insieme di settori della memoria secondaria che possono essere usati dal SO o dalle applicazioni, questi settori non devono essere necessariamente contigui ma appariranno come tali al SO e alle applicazioni.

Un volume potrebbe anche essere il risultato dell'unione di volumi più piccoli

## Dati e Metadati: Consistenza
I dati sono il contenuto del file mentre i metadati sono delle informazioni aggiuntive sul file.

Ad esempio, lista blocchi liberi, lista blocchi all'interno del file, data ultima modifica, creatore ecc....

I dati sono su disco dato che devono persistere, ma per efficienza sono anche su RAM ma mantenere i metadati consistenti fra RAM e disco è inefficiente quindi si fa solo di tanto in tanto ad esempio quando il disco è poco usato o si sono accumulati molti aggiornamenti.

I SO moderni utilizzano il **journaling**, ovvero scrivere questi aggiornamenti da fare in una zona del disco dedicata chiamata **log**, quando appunto si può fare questo aggiornamento si fanno tutti quelli accumulati nel log, inoltre anche se il sistema crasha ci basta leggere il log.

E se c'è un evento imprevisto?
- Il computer viene spento all'improvviso
- Il disco viene rimosso senza dare un comando

Potrebbero esserci delle informazioni non aggiornate.

Ci basta scrivere un bit all'inizio del disco che ci dice se il sistema é stato spento correttamente.

Al reboot se il bit è 0 occorre eseguire un programma di ripristino del disco, cosa fa?
- Blocco in uso ma non appartenente a nessun file? Viene dichiarato libero
- Blocco libero ma appartenente ad un file? Lo si dichiara appartenente a quel file
- Se c'è journaling è più semplice dato che ci basta consultare il log

## Journaling
Come detto prima è una zona dedicata del disco in cui scrivere le operazioni da fare prima di eseguirle effettivamente nel file system.

Se al reboot il bit di shutdown è 0:
1) Confronta il journal allo stato corrente del file system
2) Corregge inconsistenze nel file system basandosi sulle operazioni presenti nel journal:
	- Se la scrittura è completa, in caso di crash durante la scrittura nel file system è possibile recuperare l'errore
	- Se c'è un crash durante la scrittura nel journal, il file system rimane integro

Ci sono diversi tipi di journaling:
- Fisico
- Logico

### Journaling Fisico
Copia nel journal tutti i blocchi che dovranno essere poi scritti nel file system, inclusi i metadati. Se avviene un crash durante la scrittura nel file system è sufficiente copiare il contenuto dal journal al file system al reboot successivo

### Journal Logico
Copia nel journal soltanto i metadati delle operazioni effettuate e se c'è un crash si copiano i metadati dal journal al file system ma può causare corruzione dei dati infatti il contenuto del file è perso dato che non è stato salvato nel journal

## Alternative al Journaling
- Sofr Updates File System
  
  Riordina scritture su file system in modo da non avere mai inconsistenze, ovvero permette solo determinati tipi di inconsistenze che non causano perdita di dati.

- Log-Structured File Systems
  
  L'intero file system è strutturato come un buffer circolare detto log e sia dati che metadati sono scritti in modo sequenziale sempre alla fine del log, possono esserci quindi diverse versioni dello stesso file corrispondenti a diversi istanti di tempo.

- Copy-on-Write File Systems
  
  Evitano sovrascritture dei contenuti dei file e scrivono i nuovi contenuti in blocchi vuoti aggiornando poi i metadati per puntare ai nuovi contenuti.

# Gestione dei File in UNIX

_Secondo video File System_