#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages)
#show raw: set text(font: "Cascadia Code")

= GPU Programming
Per ora abbiamo visto la computazione avvenire nella CPU, più precisamente nei core della ALU, questi comportano:
- Alte frequenze di clock
- Grandi cache che riducono i tempi di accesso in memoria
- Predizione delle operazioni da svolgere che in caso di successo riducono i tempi di esecuzione

Adesso iniziamo a fare calcoli con la GPU:
- Ci sono molti più core ma ad una frequenza di clock moderata
- Cache più piccole
- Niente branch control quindi niente predizioni di operazioni
- Ha delle interfacce a banda ultralarga per le memorie.

*Architettura di una GPU CUDA-Capable*
#align(center, image("img/cudaarch.png"))

Sono composte da:
- *SM (Streaming Multiprocessor)*: _Sono un insieme di quadrati verdi_, uno singolo è uno streaming processor (o anche CUDA Core). I processori di un multiprocessor condividono la stessa control logic e instruction cache.
- Due o più SM formano un *building block*
- Sono tutti collegati da una memoria a banda larga.

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
  title: [*Application Benefits from CPU and GPU*],
  [
    - Utilizziamo la CPU per le parti di programma sequenziali dove è importante la latenza.
    - La GPU la utilizziamo per codice parallelo dove è più importante il throughput.
  ]
)

La programmazione con le GPU ha un ostacolo principale ovvero che la memoria della GPU e dell'host non sono unite e quindi sono necessarie delle operazioni esplicite per trasferire i dati fra le due memorie. Un altro problema è che non sempre la GPU ha la stessa rappresentazione della CPU per i numeri floating-point.

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
  title: [*Piattaforme per lo sviluppo con GPU*],
  [
    - *CUDA*: Compute Unified Device Architecture, fornisce due set di API, una a basso ed un ad alto livello. Supporta Windows, MacOS X e Linux ma funzione soltanto su hardware Nvidia anche se adesso ci sono dei tool per eseguire codice CUDA su GPU AMD.
    - *HIP*: É l'equivalente di CUDA ma per AMD, esistono appunto dei tool che permettono di convertire codice CUDA in codice HIP.
    - *OpenCL*: Open Computing Language è uno standard Open Source per scrivere programmi su piattaforme diverse come GPU, CPU o altri tipi di processori, è supportato sia da Nvidia che AMD ed è la piattaforma di sviluppo principale per AMD.
    - *OpenACC*: Permette di utilizzare le direttive del compilatore per mappare automaticamente i calcoli da eseguire sulla GPU.
  ]
)

== Cuda
Prima di CUDA, che permette di programmare con le schede Nvidia, le GPU trasformavano gli algoritmi in una sequenza di primitive per la manipolazione di immagini. CUDA inoltre:
- Abilita la gestione esplicita della memoria.
- La GPU è vista come un dispositivo di computazione che:
    - É un co-processore della CPU o dell'host
    - Ha la sua DRAM
    - Esegue più threads in parallelo, la creazione o il cambio di questi costa comunque qualche ciclo di clock

É importante ricordare che CUDA *è una piattaforma o modello di programmazione* e *non* è un linguaggio di programmazione.

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
  title: [*Struttura di un programma CUDA*],
  [
    1. Alloca la memoria della GPU
    2. Trasferisci i dati dalla memoria dell'host alla memoria della GPU
    3. Esegui il Kernel CUDA
    4. Copia i risultati dalla memoria della GPU alla memoria host
  ]
)

Come viene eseguito, invece, del codice CUDA?
#align(center, image("img/cudaex.png", width: 80%))

Nella maggior parte dei casi è l'host che si occupa delle operazioni di I/O, del passaggio e della raccolta dei dati dalla memoria della GPU.

I thread in CUDA sono organizzati in una struttura 6-D ma sono possibili anche con dimensioni più piccole. La struttura è divisa in:
- *Griglia*: Qui vengono posizionati i blocchi e possono avere quindi fino a 3 dimensioni per essere individuati
- *Blocco*: All'interno dei blocchi ci sono i thread, anche qui possiamo avere fino a 3 dimensioni per individuare ciascun thread.

Grazie a questo coordinate ogni thread riesce a capire a quale subset dei dati è stato assegnato.

La dimensione dei blocchi e delle griglie è determinata dalla *capability* che determina, per ogni generazione di GPU, quanto può elaborare.
La *compute capability* di un dispositivo è rappresentata dal *version number* chiamato anche *SM version*.
Questo numero identifica le features supportate dalla GPU e viene anche utilizzate a runtime dalle applicazioni per capire se delle istruzioni sono disponibili o meno.

=== Scrivere Programmi Cuda
Bisogna scrivere una funzione che verrà eseguita da tutti i threads, questa funzione è chiamata *kernel*, dobbiamo specificare come i threads sono organizzati nelle griglie / blocchi:

```cuda
dim3 block(3,2);
dim3 grid(4,3,2);
foo<<<grid, block>>>();
```

- `dim3` è un vettore di interi
- Ogni componente non specificato è impostato a 1 e ogni componente è accessibile con i campi `x,y,z`

Vediamo come dichiarare le dimensioni di griglie e blocchi:

```cuda
dim3 b(3, 3, 3);
dim3 g(20, 100);
foo<<<g, b>>>(); // Run a 20x100 grid made of 3x3x3 blocks
foo<<<10, b>>>(); // Run a 10-block grid, each block made by 3x3x3 threads
foo<<<g, 256>>>(); // Run a 20x100 grid made of 256 threads
foo<<<g, 2048>>>(); // Invalid, maximum block size is 1024 threads even for compute capability 5.x
foo<<<5, g>>>(); Invalid, that specifies a block size of 20x100=2000 threads
```

_Hello World in CUDA_:

```cuda
#include <stdio.h>
#include <cuda.h>

__global__ void hello() {
    printf("Hello world\n");
}

int main() {
    hello<<<1, 10>>>();
    cudaDeviceSynchronize();
    return 1;
}
```

- La funzione `hello()` può essere chiamata dall'host
- La funzione `hello()` è il kernel e va sempre dichiarata void, i risultati vanno copiati in modo esplicito dalla GPU alla memoria dell'host.
- `cudaDeviceSynchronize` serve a bloccare finchè il CUDA Kernel non è terminato

Per compilare ed eseguire, lanciamo il comando:
- `nvcc -arch=sm_20 hello.cu -o hello`
- `./hello`

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
  title: [*Function Decorations*],
  [
    - `__global__`: Può essere chiamata dall'host o dalla GPU ed eseguita sul device o GPU.
    - `__device__`: Una funzione che viene eseguita sulla GPU e può essere soltanto chiamata dal kernel, ovvero dalla GPU
    - `__host__`: Una funzione che può essere eseguita soltanto sull'host, di solito viene omesso a meno che non è usato in combinazione a `__device__` per indicare che la funzione può essere eseguita sia su host che device. Questo significa che ci saranno due versioni del codice compilato.
  ]
)

=== Ottenere la posizione dei thread
I Thread sono organizzati in uno spazio 6D:
- `blockDim`: Contiene la dimensione di un blocco, $(B_x, B_y, B_z)$
- `gridDim`: Contiene la dimensione della griglia in blocchi, $(G_x, G_y, G_z)$
- `threadIdx`: Le coordinate $(x,y,z)$ del thread all'interno del blocco con $x in [0, B_x - 1], y in [0, B_y - 1], z in [0, B_z - 1]$
- `blockIdx`: Le coordinate $(b_x, b_y, b_z)$ del blocco di cui fa parte il thread all'interno della griglia con $b_x in [0, G_x - 1], b_y in [0, G_y - 1], b_z in [0, G_z - 1]$

_Esempio_

#align(center, image("img/threadgrid.png", width: 80%))

Come prendiamo un unico thread ID?
- Threads diversi potrebbero avere lo stesso ID ma allora si trovano in blocchi differenti
- Per avere un ID unico vanno combinati `threadIdx e blockIdx`:

```
int myID = (
    blockIdx.z * gridDim.x * gridDim.y +
    blockIdx.y + gridDim.x +
    blockIdx.x) * blockDim.x * blockDim.y * blockDim.z +
    threadIdx.z * blockDim.x * blockDim.y +
    threadIdx.y * blockDim.x +
    threadIx.x;
```

Quando i thread si trovano in spazi più piccoli di 6 dimensioni allora queste valgono 1 nella moltiplicazione e 0 nelle coordinate per la somma.

=== Thread Scheduling
- Ogni thread viene eseguito su uno Streaming Processor (CUDA Core)
- Un gruppo di cores nello stesso SM condividono la stessa control unit, questo significa che devono coordinarsi per eseguire la stessa istruzione.
- Diversi SM possono eseguire diversi kernel.
- Ogni blocco viene eseguito su un SM, quando uno di questi viene eseguito completamente allora l'SM esegue il successivo
- Non tutti i threads di un blocco vengono eseguiti in modo concorrente.

=== Warps
I thread di uno stesso blocco sono eseguiti in gruppi, chiamati *warps*, nelle GPU attuali la dimensione di un warp è di 32 ma potrebbe cambiare in futuro. Di solito vengono ordinate nei warps in base al loro intra-block ID.

Tutti i threads in un warp vengono eseguiti secondo il modello Single Instruction Multiple Data (SIMD) ovvero in qualsiasi istante viene eseguito il fetch di un'istruzione ed eseguita per tutti i threads nel warp.

Su ogni SM possono esserci diversi warps schedulers, questo significa che sullo stesso SM possono venir eseguiti più warps e ciascuno di questi con un execution path differente.

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
  title: [*Warp Divergence*],
  [
    Dato che in un warp si segue il modello SIMD, cosa succede se il risultato di un'operazione condizionale porta a diversi percorsi? Vengono valutati tutti questi percorsi fino a quando non si riuniscono, i thread che non devono essere eseguiti vengono messi in stallo.
    #align(center, image("img/warpdiv.png", width: 80%))
  ]
)

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
  title: [*Context Switching*],
  [
    Di solito un SM ha più blocchi / warps di quanti ne sia in grado di eseguire, questo perché un SM può switchare fra i warps infatti ogni thread il suo execution context mantenuto sul chip.

    Quando un'istruzione che deve essere eseguita su un warp ha bisogno di aspettare i resultati di un'operazione precedente con tanta latenza allora il warp non viene selezionato per l'esecuzione ma ne viene selezionato uno che può partire subito.

    Questo meccanismo di selezionare chi non deve aspettare nulla si chiama *latency tolerance* o *latency hiding*.

    Con un numero sufficiente di warps il sistema sarà sempre in grado di trovare un warp eseguibile utilizzando al massimo l'hardware.
    Questo meccanismo è il motivo principale per cui le GPU non devono dedicare così tanto spazio a zone come la cache o meccanismi di branch predictions come fanno le CPU.
  ]
)

_Esempio 1_
- Un dispositivo CUDA permette fino a 8 blocchi con 1024 threads per SM e 512 threads per blocco
- Quanto facciamo grandi i thread blocks? 8x8, 16x16 o 32x32?

- 8x8:
    - Avremo 64 threads per blocco
    - Per riempire i 1024 threads di ciascun SM ci servono 1024 / 64 = 16 blocchi
    - Ma possiamo avere al massimo 8 blocchi per SM, ma in questo caso avremo 64x8=512 threads per SM
    - Non stiamo utilizzando al massimo le risorse a disposizione, questo significa che in qualche momento lo scheduler potrebbe non trovare qualcosa da eseguire.

- 16x16:
    - 256 threads per blocco
    - Per riempire i 1024 threads di ogni SM ci servono 1024 / 256 = 4 blocchi
    - Abbiamo 1024 threads per ogni SM, perfetto

- 32x32:
    - Abbiamo 1024 threads per blocco che è molto più grande di 512 ovvero il massimo che possiamo avere.

_Esempio 2_