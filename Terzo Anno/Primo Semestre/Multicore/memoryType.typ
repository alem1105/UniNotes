#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages)
#show raw: set text(font: "Cascadia Code")

= Memory Type
Esistono diversi tipi di memorie:

#align(center, image("img/memorie.png"))
- *Registers*: Mantengono le variabili locali
- *Shared Memory*: Una memoria ad alta velocità presente sul chip che serve a mantenere dati usati molto spesso. Si utilizza per spostare dati fra i cores dello stesso SM.
- *L1 / L2 Cache*: Una memoria invisibile al programmatore.
- *Global Memory*: Di solito ha una grande capacità ma è molto lenta (rispetto alle memorie interne), è l'unica zona accessibile all'host tramite le funzioni CUDA.
- *Texture and Surface Memory*: Contiene risorse gestite da hardware dedicato che permettono un'implementazione più veloce di alcuni operatori.
- *Constant Memory*: Può contenere soltanto costanti, viene cachata e permette il broadcast di un singolo valore a tutti i threads del suo stesso warp.

#showybox(
  frame: (
    border-color: green.lighten(60%),
    title-color: green.lighten(60%),
    body-color: green.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*CUDA Variable Type Qualifiers*],
  [
    #align(center, image("img/cudavar.png", width: 80%))
  ]
)

== Registri
Servono a memorizzare le variabili locali dei threads, i registri sono condivisi fra i threads dello stesso core. La *compute capability* determina il numero massimo di registri che possono essere usati da un thread, se questo numero viene superato allora le variabili locali sono allocate nella global off-chip memory che è molto più lenta, anche se alcuni variabili potrebbero comunque trovarsi sulla cache L1. É il compilatore che deciderà quali variabili allocare nei registri e quali nella memoria.

Il numero massimo di registri utilizzabili da un thread influenza anche il numero massimo di *resident thread* che possiamo avere in un SM.

_Ad esempio_
- Un Kernel utilizza 48 registri e abbiamo blocchi da 256 threads
- Ogni blocco richiede quindi $48 * 256 = 12.288$ registri in totale
- Assumiamo che la GPU abbia 32.000 registri per SM e 1.536 threads per SM. Questo significa che ogni SM ha 2 blocchi ($12.288 * 2 < 32.000$)
- Questo significa però che abbiamo $2 * 256 = 512$ threads per SM che è molto inferiore alle capacità di un SM.

Nvidia definisce come *occupancy* come il rapporto fra i *resident warps* e il *numero massimo di resident warps*.

$ "occupancy"=frac("resident_warps", "maximum_warps") quad frac(2 * frac(256 "threads",32 "threads / warps"), 48 "warps") = 16/48 = 33.3% $

Come valore desiderato vorremmo un occupancy più vicina possibile a 1, perché significa che ci sono più opportunità di effettuare swap fra threads e nascondere la latenza.
L'occupancy di una kernel può essere analizzata con un profiler, ma come facciamo poi ad aumentarla?
- Riduciamo il numero di registri richiesti dalla kernel, ad esempio riducendo il numero di variabili o riutilizzandone alcune.
- Usare una GPU con più registri per thread.

== Constant Memory
É importante ricordare che `Constant Memory != ROM`, la constant memory è soltanto una memoria che può contenere i valori delle costanti, su questa memoria ci scrive l'host. I vantaggi principali sono:
- Ha una cache
- Supporta il broadcast di un singolo valore a tutti i threads nello stesso warp

Per dichiarare una constante in questa zona scriviamo:

```cuda
__constant__ type variable_name; // static
cudaMemcpyToSymbol(variable_name, &host_src, sizeof(type), cudaMemcpyHostToDevice);
```

I dati saranno presenti in memoria fino alla terminazione dell'applicazione, questi sono leggibili da tutti i threads della kernel.

#showybox(
  frame: (
    border-color: blue.lighten(60%),
    title-color: blue.lighten(60%),
    body-color: blue.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Esempio*],
  [
    Se abbiamo 10 warps in un SM e tutti richiedono la stessa variabile:
    - Se questa si trova nella global memory tutti richiedono quel segmento di memoria.
    - Dopo la prima richiesta il dato finirà in L2 ma questa è molto trafficata e il dato potrebbe andare perso.
    - Se il dato si trova in constant memory invece è molto probabile che anche tutti gli altri warps lo trovino lì.
  ]
)

== Performance Estimation
In che modo possiamo stimare le performance per capire se stiamo sfruttando al massimo la *computational capabilities*?
- `FLOP/s` (floating point operations per second), ma va specificato che tipo di floating-point 64bit, 32bit, 16bit...
- Oggi abbiamo sistemi capaci di gestire fino a 1 ExaFLOP/s ($10^(18) "FLOP/s"$)

Se prendiamo ad esempio l'operazione: `pixVal += in[curRow * w + curCol];`

- Tutti i threads accedono alla memoria globale per ottenere i loro input dalla matrice. Supponiamo che la memoria abbia una banda di $200 "GB/s"$ quindi possiamo caricare $(200 "GB/s") / (4 "bytes") = 50G "operands/s"$
- Facciamo un'operazione con floating-point ad ogni operand, ci aspettiamo quindi come performance più alta $50 "GFLOP/s"$.
- Supponiamo che questa GPU abbia come picco $1.500 "GFLOP/s"$, questo significa che la nostra esecuzione è limitata al $3.3% (50 / 1500)$, lo spostamento di dati fra le memorie sta limitando le nostre performance.
- Diciamo che questa applicazione è *memory bound*. Per aumentare le performance dobbiamo ridurre gli accessi in memoria.

Definiamo *compute-to-global-memory-access ratio* come il numero di operazioni floating-point eseguite per ogni accesso nella memoria globale in una regione di programma. É anche conosciuta come la *arithmetic / operational intensity* misurata in FLOP/byte.

== Shared Memory
I dati presenti nella shared memory sono condivisi fra tutti i threads. Possiamo utilizzarla, ad esempio, per:
- Memorizzare i dati usati molto frequentemente che altrimenti richiederebbero una memoria globale.
- Un modo per condividere i dati fra cores dello stesso SM.
Il modificatore `__shared__` viene usato per indicare che un dato va salvato nella memoria shared invece che la globale.

Shared Memory vs L1 cache:
- Sono entrambe on-chip
- In alcuni casi avere i dati sulla shared-memory e avendo controllo su questa si ottengono risultati migliori rispetto alla cache.

_Esempio di utilizzo: 1D Stencil_

Per capire lo stencil, prendiamo una lista di valori e consideriamo un raggio di, ad esempio, 3. Ogni valore diventerà la somma di se stesso e i 6 elementi vicini a lui, 3 a sinistra e 3 a destra. Abbiamo quindi che ogni thread processa un elemento ma ogni elemento verrà letto più volte, con raggio 3 ogni elemento viene letto 7 volte.

Possiamo salvare i dati nella shared memory per accedervi più velocemente:
- Leggiamo gli elementi in `blockDim.x + 2 * radius` dalla memoria globale e li mettiamo nella shared memory
- Calcoliamo `blockDim.x` elementi
- Scriviamo `blockDim.x` elementi nella memoria globale.

Ogni thread però calcola solo il suo elemento.

Ovviamente va creato un nuovo array altrimenti ogni stencil applicato influenzerebbe il successivo calcolo.

_Esempio Codice_

```c
__global__ void stencil_1d(int *in, int *out) {
  __shared__ int temp[BLOCK_SIZE + 2 * RADIUS];
  int gindex = threadIdx.x + blockIdx.x * blockDim.x;
  // Indice locale (dentro la shared) calcolato in base al RADIUS
  int lindex = threadIdx + RADIUS;

  // Salva i dati nella shared memory
  temp[lindex] = in[gindex];
  if (threadIdx.x < RADIUS) {
    temp[lindex - RADIUS] = in[gindex - RADIUS];
    temp[lindex + BLOCK_SIZE] = in[gindex + BLOCK_SIZE];
  }

  // Applica lo stencil
  int result = 0;
  for (int offset = -RADIUS; offset <= RADIUS; offset++) {
    result += temp[lindex + offset];
  }
  // Salva i risultati
  out[gindex] = result;
}
```

Quindi ogni thread carica il suo valore in shared memory ma quelli più esterni caricano anche gli HALO ovvero i valori ai bordi del blocco.
Ma cosa succede se ad esempio il thread 31 inizia la computazione quando il thread 32 ha già scritto i suoi risultati? Dobbiamo sincronizzare i threads in modo che i calcoli vengano effettuati soltanto quando i dati sono stati caricati in shared memory, aggiungiamo una barriera.

```c
__global__ void stencil_1d(int *in, int *out) {
  __shared__ int temp[BLOCK_SIZE + 2 * RADIUS];
  int gindex = threadIdx.x + blockIdx.x * blockDim.x;
  int lindex = threadIdx + RADIUS;

  // Salva i dati nella shared memory
  temp[lindex] = in[gindex];
  if (threadIdx.x < RADIUS) {
    temp[lindex - RADIUS] = in[gindex - RADIUS];
    temp[lindex + BLOCK_SIZE] = in[gindex + BLOCK_SIZE];
  }
  // Sincronizzazione dei threads
  __syncthreads();

  // Applica lo stencil
  int result = 0;
  for (int offset = -RADIUS; offset <= RADIUS; offset++) {
    result += temp[lindex + offset];
  }
  // Salva i risultati
  out[gindex] = result;
}
```

#showybox(
  frame: (
    border-color: red.lighten(60%),
    title-color: red.lighten(60%),
    body-color: red.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Nota*],
  [
    Non ne sono sicuro ma credo che in questi esempi non sono stati gestiti i casi in cui un thread si trova ai bordi assoluti. In quel caso possiamo anche impostare i valori a 0 e poi successivemnte nel calcolo ignorarli sempre gestendoli tramite un if.
  ]
)

== Pinned Memory
Per trasferire i dati CPU - GPU durante le `cudaMemcpy()` viene utilizzato il *DMA (Direct Memory Access)*, in questo modo:
- La CPU rimane libera per eseguire altre tasks.
- Utilizza connessioni come le PCIe.

I sistemi moderni però gestiscono la memoria tramite indirizzi virtuali:
- Più locazioni di memoria virtuali sono mappate in una singola locazione fisica.
- Gli indirizzi virtuali vengono tradotti in indirizzi fisici.

Per gestire la memoria in modo efficiente non si sposta la memorya byte per byte ma questa viene divisa in pagine (blocchi) di dimensione fissa, in questo modo il sistema operativo sposta intere pagine da RAM a disco rigido e viceversa.

Quindi non tutto può trovarsi sulla RAM:
- *Page-out*: Se la RAM è piena e ce ne serve per un'altra operazione, il sistema prende una pagina che non sta venendo usata da tempo e la sposta sul disco rigido.
- *Page-in*: Quando i dati vengono riportati in RAM

Il DMA utilizza indirizzi fisici:
- Quando una `cudaMemcpy()` copia un array vengono svolti uno o più trasferimenti DMA.
- All'inizio di ogni trasferimento DMA gli indirizzi vengono tradotti e viene controllata la presenza delle pagine necessarie per sia per l'array sorgente che per la destinazione.
- Non sono necessarie altre traduzioni di indirizzi e questo ci fa guadagnare molta efficienza.

Il Sistema Operativo potrebbe però, per sbaglio, spostare dati necessari al DMA dalla RAM al disco e spostare sullo stesso indirizzo fisico necessario al DMA altri dati.

Per risolere questo problema utilizziamo la *pinned memory*, sono indirizzi di memoria virtuale _marchiati_ in modo tale che non venga mai effettuato il *page-out* su questi. Vengono allocati tramite una chiamata API.

Il DMA usato da `cudaMemcpy()` richiede che ogni sorgente o destinazione nella memoria host sia allocata nella pinned memory, se questo non succede va comunque prima copiata nella pinned memory, stiamo quindi aggiungendo overhead. Per guadagnare tempo è buona norma quindi allocare nella pinned per evitare copie extra non necessarie.

Però posizionare i dati del programma nella pinned memory ci risparmia si dei trasferimenti extra ma rovina l'efficienza della memoria virtuale dell'host.

Per posizionare dati nella pinned memory:
- Eseguiamo un normale `malloc()` e poi chiamiamo `mlock()`
- Per deallocare facciamo l'ordine inverso quindi prima `munlock()` e poi `free()`
- Oppure possiamo usare la funzione `cudaMallocHost()`, e per deallocare `cudaFreeHost()`

Il guadagno qui dipende dalla grandezza dei dati, possiamo andare da un miglioramento del 10% fino a un 2.5x !!

== Bank Conflicts in Shared Memory
La memoria virtuale è organizzata in *banks*:

#image("./img/banksmem.png")

- Gli accessi nei bank sono interleaved
- I nuovi dispositivi hanno fino a 32 banks mentre i più vecchi 16.
- Ogni bank permette un accesso per ciclo
- Se i threads accedono a banks differenti nella shared memory allora gli accessi sono istantanei
- Se i threads accedono a dati diversi nello stesso bank allora gli accessi vengono *serializzati*.

Dobbiamo cercare di evitare che threads nello stesso warp accedano, nello stesso momento, allo stesso bank nella shared memory.

#showybox(
  frame: (
    border-color: blue.lighten(60%),
    title-color: blue.lighten(60%),
    body-color: blue.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Info*],
  [
    - Se tutti i threads di un warp accedono alla stessa locazione di memoria allora viene effettuato un broadcast in lettura e quindi non ci sono conflitti.
    - Se un subsets di threads in un warp accede allo stesso momento nella stessa locazione di memoria allora avviene una lettura multicast, anche qui non ci sono conflitti.
  ]
)

== Global Memory Coalescing
Quando un thread accede ad una locazione di memoria in realtà vengono lette più locazione, simile a quando viene caricato un intero blocco di dati nella cache.
Quando tutti i threads in un warp eseguono una lettura l'hardware controlla se stanno accedendo a locazioni contigue di memoria, se questo accade allora viene effettuato un solo accesso.

Ad esempio, se in un warp il Thread 0 accede alla locazione N, il Thread 1 alla locazione N+1 ecc... allora tutti questi accessi verranno effettuati in un singolo accesso. Alcuni device CUDA potrebbero richiedere degli allineamenti, ad esempio che N sia multiplo di 16.

== Global Memory Access
Esistono due tipi di load:
- Cached loads:
  - Sono quelli utilizzati di default dai dispositivi che hanno una L1.
  - Prima si controlla se il dato è in L1, se non c'è si controlla la L2, se non c'è si va in memoria globale.
  - Vengono caricate in cache linee da 128byte. (dipende dal device)
- Non cached loads:
  - Si utilizzano quando il dispositivo non ha una L1 oppure, se ce l'ha, quando compiliamo con le flag `-Xptxas -dlcm=cg`
  - Si controlla soltanto la L2, se il dato non c'è si va in memoria globale.
  - Vengono caricate linee da 32byte.

  Per la scrittura di dati invece:
  - Viene invalitada la linea nella L1 e il writeback viene effettuato sulla L2.
  - Quindi quando CUDA scrive un dato non lo tiene nella L1 locale e se era presente invece viene invalidata la linea e scritto nella L2.
  Questo elimina il false sharing perchè più SM non cercano di avere sempre l'ultima versione della L1 ma utilizzano una L2 comune a tutti. Anche non avendo false sharing però è comunque utile scrivere in modo ordinato nella memoria ad esempio per sfruttare al massimo la larghezza di banda.

  Ad esempio:
  - Un warp richiede 32 words da 4 byte allineate e consecutive in memoria, in totale quindi 128 bytes.
    - Se utilizziamo la L1 possiamo muovere tutti i 128 byte sul bus e occupare una linea di cache
    - Se non la utilizziamo possiamo comunque muovere 128 byte sul bus ma utilizzare 4 segmenti della L2
    - In ogni caso abbiamo utilizzato al 100% il bus.
  Questo accade anche se le words non vengono in modo consecutive ma comunque allineate in memoria.

  #image("./img/l1l2_1.png")

  - Se un warp richiede 32 words da 4 byte ma che non sono allineate in memoria:
    - Utilizzando la L1, siccome sul bus spostiamo segmenti da 128 e le words non sono allineate dobbiamo spostare due segmenti e quindi 256bytes e occupare inoltre 2 linee di cache, abbiamo un utilizzo del 50% sul bus.
    - Non utilizzando la L1, le words occuperanno al massimo 5 segmenti da 32 e quindi 160bytes da muovere sul bus, utilizzando quindi solo l'80%.

  #image("./img/l1l2_2.png")

  - Se tutti i threads in un warp richiedono la stessa word (4 bytes)?
    - Con la L1 occupiamo una linea di cache e muoviamo 128 byte sul bus: utilizzo del 3.125%
    - Senza la L1, richiediamo un segmento e muoviamo 32 bytes sul bus: utilizzo del 12.5%

  #image("./img/l1l2_3.png")

  - Se un warp richiede 32 words da 4 byte tutte in ordine sparso?
    - Con la L1 occupiamo N linee di cache, muoviamo sul bus $N * 128$ bytes: Utilizzo del $128 / (N * 128)$
    - Senza la L1 occupiamo N segmenti e muoviamo $N * 32$ bytes sul bus: utilizzo del $128 / (N * 32)$

  #image("./img/l1l2_4.png")

In generale quindi se non facciamo memory coalescing o comunque accessi in memoria non allineati potremmo considerare di spegnere la L1 per guadagnare performance.