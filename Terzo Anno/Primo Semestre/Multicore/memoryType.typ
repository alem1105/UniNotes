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
- Calcoliamo l'elemento in `blockDim.x`
- Scriviamo `blockDim.x` nella memoria globale.

Ovviamente va creato un nuovo array altrimenti ogni stencil applicato influenzerebbe il successivo calcolo.

_Esempio Codice_

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

  // Applica lo stencil
  int result = 0;
  for (int offset = -RADIUS; offset <= RADIUS; offset++) {
    result += temp[lindex + offset];
  }
  // Salva i risultati
  out[gindex] = result;
}
```

Quindi ogni thread carica il suo valore in shared memory va quelli più esterni caricano anche gli HALO ovvero i valori ai bordi del blocco.
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