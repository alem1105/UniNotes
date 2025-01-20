Il deadlock è un sottoproblema della mutua esclusione, ma dato che è un caso particolare va studiato più approfonditamente.

Il deadlock è un blocco permanente di un insieme di processi, il motivo del blocco è dovuto alla richiesta contemporanea delle stesse risorse da parte di due o più processi. A questo non esiste una soluzione efficiente ma ci sono diversi approcci e vanno valutati caso per caso.

Il deadlock potrebbe essere causato da una combinazione rara di eventi (_corner case_) ma noi, come per la mutua esclusione, vogliamo una soluzione che funzioni sempre.

![[Pasted image 20250120170521.png]]

Quindi nella $a$ il deadlock è possibile ma non certo dato che potrebbe partire una sola auto e le altre poi sarebbero libere, ma se tutte insieme fanno un passo avanti allora si crea un deadlock, nessuno può avanzare.

_Esempio_

![[Pasted image 20250120171042.png]]

Notiamo che l'unico caso in cui si verifica deadlock è quando P e Q chiedono prendo la prima risorsa e poi vogliono la seconda, quindi P sta aspettando che B venga rilasciato da Q ma Q per rilasciarlo sta aspettando che P rilasci A e quindi si è creato un deadlock.

- Le frecce nere indicano possibili scelte del dispatcher per mandare i processi e le assi indicano cosa fa un processo nel tempo. Quindi se saliamo verticalmente sta andando avanti Q se invece andiamo avanti orizzontalmente sta procedendo P.

_Esempio 2_

![[Pasted image 20250120171439.png]]

In questo caso non può mai verificarsi deadlock, infatti il processo P non richiede mai entrambe le risorse nello stesso momento.

Questi grafici sono chiamata **Joint Progress Diagram** e sono comodi per situazioni con pochi processi ma già da 3-4 processi iniziano a essere scomodi.

Vogliamo dare una definizione matematica al deadlock, per farlo iniziamo classificando le risorse in due categorie, riusabili e consumabili.

# Risorse Riusabili
Queste sono usabili da un solo processo alla volta e il fatto di venire usate non le consuma. Ad esempio quando diamo il disco ad un processo, il disco non viene distrutto.

In questo caso lo stallo può esistere solo se un processo ha una risorsa e prima di rilasciarla ne richiede un'altra.

_Esempio_

![[Pasted image 20250120171948.png]]

Per fare la sezione critica **Performa Function** i due processi devono usare un lock su D e T, possiamo vederli come una semplificazione dei semafori. Dato che li richiedono in modo inverso può esserci deadlock già dall'inizio se il dispatcher fa eseguire Lock(D) a P e Lock(T) a Q.

_Esempio con Memoria_

![[Pasted image 20250120172239.png]]

Anche qui se P1 prende 80Kbytes e P2 altri 70 allora si bloccheranno entrambi dato che rimarrebbero 50Kbytes liberi che non sono sufficienti a nessuno dei due per rilasciare qualcosa.

## Condizioni per il deadlock con Riusabili
- Mutua esclusione: Le risorse possono essere usate da un solo processo alla volta.
- Hold-and-wait: Si richiede una risorsa quando se ne ha già una, come negli esempi precedenti
- Niente preemption per le risorse: non si può sottrarre una risorsa ad un processo senza che quest'ultimo non la rilasci, il sistema operativo non può togliere risorse da processi in modo forzato.
- Attesa circolare: Esiste una catena chiusa di processi dove ciascun processo detiene una risorsa richiesta dal processo che lo segue nella catena.

# Risorse non Riusabili (Consumabili)
Queste vengono create e distrutte (prodotte e consumate), ad esempio le interruzioni, i segnali, i messaggi ecc...

Il deadlock è possibile se si fa una richiesta bloccante di una risorsa non ancora creata.

_Esempio Stupido_

![[Pasted image 20250120172547.png]]

Qui abbiamo P1 che aspetta un messaggio da P2 che lo invierà soltanto dopo averlo ricevuto uno da P1, quindi sono entrambi bloccati.

## Condizioni per il deadlock con consumabili
- Mutua esclusione
- Si può richiedere in modo bloccante una risorsa che ancora non è stata creata
- Niente preemption sulle risorse
- Attesa circolare: Qui però ogni processo dovrebbe creare una risorsa richiesta dal processo che lo segue.

# Grafo dell'Allocazione delle Risorse
Questo grafo rappresenta lo stato delle risorse e dei processi, le palline indicano processi mentre i quadrati delle risorse.

Con le frecce indichiamo o processi che richiedono risorse o risorse controllate da processi.

Principalmente è usato per le risorse riusabili dato che una consumabili non viene "trattenuta" da un processo.

![[Pasted image 20250120172928.png]]

_Esempio_

![[Pasted image 20250120173604.png]]

Notiamo che nel caso (c) abbiamo tutte le condizioni viste prima:
- Mutua esclusione
- Catena circolare
- No preemption
- Hold-and-wait

Nel caso (d) non abbiamo deadlock dato che le risorse hanno più istanze.

# Possibilità vs Deadlock Certo
Quando si verificano soltanto le seguenti 3 condizioni:
- Mutua Esclusione
- Hold-and-wait
- Niente preemption sulle risorse

Allora il deadlock è possibile ma non certo, ma se aggiungiamo anche:
- Attesa circolare

Otteniamo un deadlock certo.

Questo perché le prime 3 riguardano soltanto il come è fatto il sistema operativo, l'attesa circolare invece dipende da come si evolve la vita di certi processi.

# Deadlock e SO: Cosa fare?
I sistemi operativi hanno 4 modi per affrontare il deadlock:
- Prevenire: Fare in modo che una delle 4 condizioni sia sempre falsa.
- Evitare: Facciamo che il sistema eviti il deadlock
- Rilevare: Il deadlock può capitare, non lo evitiamo ma vogliamo accorgercene
- Ignorare: Se dei processi vanno in deadlock, sono processi utente ed è "colpa dell'utente" quindi li terminerà lui. Questa soluzione è quindi non accettabile in caso di processi di sistema.

## Prevenzione del Deadlock
- Mutua Esclusione: Non possiamo farci nulla.
- Hold and Wait:
	- Si impone che un processo richieda subito tutte le risorse di cui ha bisogno
	- Può essere difficile per software molto complessi e inoltre si tengono risorse bloccate per tempi lunghi
- Niente preemption per le risorse:
	- Il sistema operativo può chiedere ad un processo di rilasciare le sue risorse
- Attesa Circolare:
	- Si definisce un ordinamento crescente sulle risorse, una risorsa viene data solo se segue quelle che il processo già detiene, quindi ad esempio se un processo chiede le risorse 2,4,1 dovrà chiederle in ordine 1,2,4 oppure non gli concedo la 4 se mi ha chiesto la 1 e non ancora la 2.

## Evitare il deadlock
Occorre decidere se l'attuale richiesta di una risorsa può portare ad un deadlock se esaudita. Questo richiede la **conoscenza delle richieste future**.

Abbiamo due possibilità:
- Non mandare in esecuzione un processo se le sue richiesta possono causare deadlock
- Non concediamo una risorsa ad un processo se allocarla può portare a deadlock. (Algoritmo del banchiere.)

Concentriamoci quindi sul secondo caso utilizzando l'algoritmo del banchiere, questo è valido per risorse riusabili.

### Algoritmo del banchiere
Funziona facendo passare il sistema in diversi stati, con stati indichiamo delle situazioni per l'uso delle risorse.

Uno stato è sicuro se da esso parte almeno un cammino che non porta al deadlock altrimenti è insicuro.

> Che strutture dati utilizza?

![[Pasted image 20250120184348.png]]

- Abbiamo un vettore R che indica i tipi di risorse, abbiamo quindi $m$ tipi di risorse. Per ogni tipo, la i-esima instanza indica il numero di istanze per quel tipo di risorsa.

- Il vettore V ha la stessa dimensione e ogni elemento indica le istanze disponibili da usare per la risorsa corrispondente.

- La matrice C claim ha come numero di colonne i diversi tipi di risorse quindi $m$, il numero di righe indica il numero di processi da monitorare, in questo caso $n$. L'elemento $C_{ij}$ indica il numero di istanze della risorsa $j$  richieste **al massimo** dal processo $i$

- La matrice Allocation C indica invece quelle allocate in quel momento

- Non è presente nella foto ma utilizziamo anche delle richieste, queste sono sempre dei vettori che indicano di quante istanza  della i-esima risorsa abbiamo bisogno.

Abbiamo quindi che V e A cambiano nel tempo mentre R e C sono dati dall'inizio.

_Esempio stato sicuro_

![[Pasted image 20250120185135.png]]

Prima di tutto possiamo fare un controllo con la matrice C, infatti per ogni risorsa chiesta da un processo dobbiamo controllare che sia inferiore o uguale alle risorse disponibili in R.

Nella matrice A invece abbiamo la situazione ad un certo punto, in questo caso possiamo calcolare il vettore V facendo la differenza tra la risorsa nel vettore R e la somma delle richieste fatte per certa risorsa in A. Ad esempio nella matrice A abbiamo che per R1 i processi chiedono 1 + 6 + 2 + 0 = 9 istanze e disponibili ne abbiamo 9, infatti nel vettore V abbiamo 0 ovvero 9 - 9.

Oltre a questo, come determiniamo che questo è uno stato sicuro?

- Partiamo dallo stato di partenza visto prima.

- P2 viene eseguito dall'inizio alla fine.

![[Pasted image 20250120190246.png]]

A questo punto, tutto quello allocato per P2 torna disponibile

Tra P1, P3 o P4 qualcuno può andare fino alla fine? Vediamo che a P1 serve 2-2-2 e sono disponibili quindi si, ma anche P3 o P4 riescono a terminare. Invece notiamo che prima P2 era l'unico che poteva terminare.

- Possiamo quindi completare P1 poi P3 e poi P4.

Questo significa che c'è un percorso possibile senza deadlock, siamo quindi in uno stato sicuro.

_Esempio stato non sicuro_

![[Pasted image 20250120190645.png]]

In questo caso l'unico processo che possiamo mandare avanti è P2 dato che la sua linea è l'unica inferiore a V.

Ma mettiamo caso che l'algoritmo del banchiere abbia fallito e P1 richiede altre unità di R1 e R3:

![[Pasted image 20250120190834.png]]

Adesso nessun processo può essere selezionato per andare in esecuzione dato che nessuno ha una linea inferiore o uguale a V.

> Implementazione del banchiere

![[Pasted image 20250120191002.png]]

![[Pasted image 20250120192120.png]]

L'algoritmo deve scegliere fra i vettori di richieste dei processi che sta monitorando uno che sia eseguibile. (Tutto spiegato nei video ma non so quanto sia utile 🥸)

## Rilevare il Deadlock
Usiamo le stesse strutture dati del banchiere ma la claim matrix viene sostituita da Q ovvero le richieste effettuate da tutti i processi, quindi come le richieste del banchiere ma sono tutte insieme in una matrice.

Algoritmo in pseudocodice:
1) Marchiamo tutti i processi che non hanno allocato nulla, questi non daranno problemi.
2) Inizializziamo w con V ovvero il vettore delle risorse attualmente disponibili
3) Cerchiamo un processo non marcato tale che la sua riga sia inferiore o uguale a w e quindi le sue richieste sono accordabili.
4) Se un processo con queste caratteristiche non esiste andiamo al passo 6
5) Marchiamo questo processo e aggiorniamo $w=w+A_{i}$ dove $A_{i}$ è la sua riga di richieste di risorse, abbiamo quindi simulato la sua esecuzione deallocando quello che usa. Torniamo al passo 3
6) C'è un deadlock se e solo se esiste un processo non marcato.

Quindi essenzialmente se rimaniamo con almeno un processo non marcato e quindi che non può essere eseguito abbiamo deadlock.

Ma dopo averlo rilevato cosa facciamo? Abbiamo diverse opzioni:
- Terminiamo tutti i processi coinvolti nel deadlock
- Mantenere dei punti di ripristino ed effettuare il ripristino al punto precedente, potrebbe verificarsi di nuovo il deadlock ma è improbabile che lo faccia infinite volte
- Terminare i processi coinvolti nel deadlock uno alla volta finché non c'è più il deadlock
- Sottrarre forzatamente risorse ai processi coinvolti uno ad uno finché non risolviamo il deadlock

## Vantaggi e Svantaggi

![[Pasted image 20250120230411.png]]

# Deadlock e Linux
Linux come in altri casi già visti cerca di essere molto minimale ma efficiente allo stesso tempo, essenzialmente:
- Se i processi utente sono scritti male e possono andare in deadlock, ci andranno e spetterà all'utente terminarli, essendo processi utente non possono fare danni.
- Per quanto riguarda il kernel invece si usa la **prevenzione dell'attesa circolare**, per fare questo i lock vengono sempre acquisiti in un ordine fisso.

# Filosofi a Cena

![[Pasted image 20250120231016.png]]

La base del problema è: Abbiamo 5 filosofi a cena, 5 sedie, 5 piatti e 5 forchette. Questi sono al tavolo e ad un certo punto hanno fame e vogliono mangiare, il problema è che per mangiare hanno bisogno di due forchette. Un filosofo può prendere soltanto le due forchette alla sua destra e sinistra. Ognuno mangia per un po' e poi posa le forchette. Questo significa che due filosofi vicini non possono mangiare nello stesso momento.

Noi vogliamo far mangiare, nello stesso momento, il più alto numero di filosofi possibile ed evitare il deadlock.

## Prima Soluzione con Semafori

![[Pasted image 20250120231759.png]]

Abbiamo 5 semafori, ognuno per ogni filosofo, tutti inizializzati ad 1.

Inizialmente pensano e questa funzione non ci dà nessun tipo di problema ma invece la funzione `eat()` ha bisogno delle due forchette quindi chiamiamo la `wait` su le due forchette necessarie e una volta finito le rilasciamo.

In questo modo è ovviamente rispettata la mutua esclusione sulle forchette.

Purtroppo, anche se questa soluzione è molto semplice, potrebbe esserci deadlock, infatti se lo scheduler permettesse a tutti di fare la prima wait allora si bloccherebbero tutti, infatti nessuno potrebbe prendere la seconda forchetta.

## Seconda Soluzione

![[Pasted image 20250120232236.png]]

Cambiamo le regole del problema, abbiamo due stanze, in una si pensa e in una si mangia e inoltre imponiamo che nella stanza dove si mangia possono entrare al massimo `n-1` filosofi.

Per fare questo abbiamo un semaforo inizializzato a $n-1$ cioè 4 in questo caso e chiamiamo le signal e le wait su questo semaforo quando qualcuno vuole entrare o uscire dalla stanza.

Con questa soluzione non abbiamo deadlock. Però abbiamo "aggirato" il problema originale.

## Terza Soluzione con Semafori

![[Pasted image 20250120232601.png]]

Il trucco qui sta nel fatto che, prima tutti prendevano prima la sinistra e poi la destra mentre adesso ci sarà un processo che farà il contrario.

La forchetta di sinistra coincide con l'indice del filosofo e quella di destra con indice + 1 % N.

Ma poi la prima forchetta diventa:
- Right se Right < Left
- Left se Left < Right

Questo funziona perché in un caso, ovvero quando siamo nell'ultimo filosofo abbiamo che `(me + 1) % N` cioè right sarà più piccola di left e quindi la prima forchetta sarà right e la seconda left. E grazie a questo anche se lo scheduler facesse fare a tutti la prima wait arriverebbe all'ultimo che non proverebbe a prendere quella alla sua sinistra ma quella alla sua destra e quindi il processo precedente a lui riuscirebbe a prendere la seconda forchetta e mangiare.

## Quarta soluzione con messaggi

![[Pasted image 20250120233520.png]]

Abbiamo una mailbox per ogni forchetta e inizializziamo questa mailbox con delle send non bloccanti.

![[Pasted image 20250120233601.png]]

Questa soluzione è analoga a quella sbagliata di prima, infatti tutti prendono prima quella di sinistra e poi quella di destra quindi potrebbe esserci deadlock. Per risolvere usiamo lo stesso trucco dei semafori.

_Corretta:_

![[Pasted image 20250120233653.png]]

Quindi anche qui abbiamo che l'ultimo prende prima quella di destra e poi quella di sinistra andando quindi a sbloccare il processo precedente a lui.

## Quinta Soluzione

![[Pasted image 20250120233742.png]]

Qui non usiamo il trucco di scambiare le forchette dell'ultimo.

Usiamo una receive non bloccante sulla forchetta sinistra, quindi se riceviamo qualcosa significa che la forchetta è libera altrimenti no. Stessa cosa per la destra. Se possiamo riceverle entrambe allora possiamo mangiare.

Qui non c'è deadlock perché grazie ai messaggi usiamo delle receive non bloccanti.

Attenzione però perché potrebbe essere possibile il livelock, infatti lo scheduler potrebbe permettere a tutti di fare il primo `nbreceive` prima di fare il secondo, quindi tutti hanno preso la forchetta alla loro sinistra, poi quando passeranno a controllare la destra la troveranno tutti occupata e quindi rilasceranno anche quella di sinistra continuando così all'infinito.

Quindi tutti prendono la sinistra, provano a prendere la destra ma non ci riescono, rilasciano la sinistra e ricominciano.

Questa soluzione si basa quindi sul fatto che tutti pensano per tempi diversi e indipendenti quindi è molto raro che tutti mangino nello stesso momento.

Inoltre è anche possibile la starvation perché ci potrebbero essere dei processi che non riescono mai a mangiare mentre altri si. Anche questo caso è improbabile ma comunque non impossibile.
