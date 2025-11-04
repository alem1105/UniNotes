#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

= Parallel Program Design 

== Foster's Methodology
Questo metodo si divide in:
1. *Partitioning*: Dividere la computazione da svolgere in task più piccole, è importante quindi saper individuare le task eseguibili in parallelo.
2. *Communication*: Determinare il tipo di comunicazione necessarie fra le tasks individuate precedentemente. Ci si deve incentrare sul permettere una comunicazione veloce ed efficiente con meno spreco di lavoro possibile e senza errori di sincronizzazione.
3. *Agglomeration or Aggregation*: Combinare le tasks e le comunicazioni precedenti in tasks più grandi. Ad esempio se una task A va eseguita prima di una task B allora ha senso unirle in un'unica task, in questo modo riduciamo l'overhead delle comunicazioni fra queste due.
4. *Mapping*: Assegnare le tasks individuate a dei processi o threads. Andrebbe fatto in modo che ci sia il minor numero di comunicazioni possibile e i processi svolgano tutti la stessa quantità di lavoro.

= Parallel Design Patterns
Possiamo dividere i pattern per programmi paralleli in due grandi categorie: *Globally Parallel, Locally Sequential (GPLS)* e *Globally Sequential, Locally Parallel (GSLP)*.

- *GPLS*: L'applicazione è in grado di svolgere più operazioni nello stesso momento, ciascuna operazione viene eseguita in modo sequenziale, ricadono in questa categoria:
  - Single-Program, Multiple Data
  - Multiple-Program, Multiple Data
  - Master-Worker
  - Map-reduce

- *GSLP*: L'applicazione viene eseguita come un programma sequenziale ma ci sono più parti eseguite in parallelo, ricadono in questo pattern:
  - Fork/join
  - Loop Parallelism

#align(center, image("img/image5.png", width: 80%))

== Single Program Multiple Data
Mantiene tutta la logica dell'applicazione in un unico programma, tipicamente hanno una struttura del tipo:
- *Program Initialization*
- *Obtaining a unique identifier*: Questi sono numerati a partire da 0 fino al numero di processi o threads, alcuni sistemi utilizzano dei vettori (CUDA).
- *Running the program*: Tutti i processi eseguono la stessa computazione ma su set di dati diversi.
- *Shutting down the program*: Pulizia, salvataggio dei risultati ecc...

== Multiple Program Multiple Data
Il SPMD inzia a non funzionare bene quando ci sono tanti dati e quindi la memoria di un singolo processo non riesce a mantenerli oppure quando i processi non sono simili in termini di potenza (macchine eterogenee). Se abbiamo delle macchine con questa architettura allora possiamo valure il MPMD che ha una struttura simile al precedente ma ci permette di eseguire compiti diversi su processori diversi, in questo modo possiamo affidare computazioni più pesanti ai core più potenti o implementare altre specifiche più adatte alla macchina.

== Master-Worker
In questo approccio esistono due componenti, il Master e il Worker. Possono esserci più di un master ma in generale si occupa di:
- Mandare il lavoro da svolgere ai workers
- Raccogliere i risultati delle operazioni
- Svolgere operazioni di I/O tra i workers ma anche con l'utente.
Il master potrebbe però fare da bottleneck in alcuni contesti, se accade sarebbe meglio utilizzare una gerarchia di masters.

== Map-Reduce
E' una variante del Master-Worker, il master coordina tutto e i workers possono svolgere due tipi di azione:
- Map: Applicare una funzione su dei dati, fornisce un set di risultati parziali.
- Reduce: Colleziona i risultati parziali e ottiene quelli completi

== Fork/Join
C'è un singolo thread padre che è il principale e vengono creati dinamicamente dei thread figli a runtime, è possibile utilizzare anche delle thread pool già pronte risparmiando tempo e risorse per la creazione e distruzione di thread. I thread figli devono finire le loro operazioni per permettere al padre di andare avanti.

== Loop Parallelism
Viene utilizzato per trasformare programmi sequenziali in programmi paralleli, in generale modifica le variabili dei loop (devono avere una forma specifica) e li rende paralleli. Ha una flessibilità molto limitata ma è anche vero che dobbiamo impegnarci molto poco per implementarlo.

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
  title: [*Input*],
  [
    Quasi tutte le implementazioni di MPI permettono soltanto al processo con rank 0 in *MPI_COMM_WORLD* di accedere a *stdin*, sarà quindi lui a dover prendere in input i dati dall'utente con _scanf_ se necessari.
  ]
)

_Esempio: Calcolo area sottostante ad una funzione_

Data una funzione vogliamo calcolare l'area sottostante nel grafico in un intervallo $a,b$

#align(center, image("img/trapezio.svg", width: 80%))

L'area del trapezio è data da:

$ h/2 [f(x_i)+f(x_(x+1))] $


Ovvero somma delle basi per altezza diviso 2. 

Per calcolare l'area sottostante alla funzione dividiamo l'area in tanti trapezi per ottenere un'approssimazione della misura, abbiamo quindi che $h = frac(b-a,n)$ e che $x_0 = a, x_1 = a + h, x_2 = a + 2h, ..., x_(n-1)=a+(n-1)h, x_n = b$. Le $x$ sono i punti di inizio e fine dei trapezi e $h$ è la loro distanza (e anche la loro altezza).

Il calcolo della somma delle aree dei trapezi è:

$ h dot [f(x_0 / 2 + f(x_1) +f(x_2)+...+f(x_(n-1))+f(x_n)/2 ] $

Possimo quindi scrivere uno pseudocodice seriale:

```c
h = (b - a) / n;
approx = (f(a) + f(b)) / 2.0;
for (i = 1; i <= n - 1; i++) {
  x_i = a + i * h;
  approx += f(x_i);
}
approx = h * approx;
```

Possiamo renderelo parallelo andando a far calcolare a più processi diversi trapezi e poi unire i risultati.

Codice parallelo:

```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <mpi.h>
#include <math.h>

// Si utilizza la funzione coseno

double Trap(double left_endpt, double right_endpt, int trap_count, double base_len) {
    double estimate, x;
    int i;

    estimate = (cos(left_endpt) + cos(right_endpt)) / 2.0;
    for (i = 1; i <= trap_count-1; i++) {
        x = left_endpt + i * base_len;
        estimate += cos(x);
    }
    estimate = estimate * base_len;
    return estimate;
}

int main() {
    int comm_sz, my_rank, n = 1024, local_n;
    double a = 0.0, b = 1.0, h, local_a, local_b;
    double local_int, total_int;
    int source;

    MPI_Init(NULL, NULL);
    MPI_Comm_size(MPI_COMM_WORLD, &comm_sz);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

    h = (b - a) / n;        // Altezza dei trapezi (distanza asse x)
    local_n = n / comm_sz;  // Quanti trapezi deve calcolare ogni processo

    local_a = a + my_rank * local_n * h;
    local_b = local_a + local_n * h;
    local_int = Trap(local_a, local_b, local_n, h);

    if (my_rank != 0) {
        MPI_Send(&local_int, 1, MPI_DOUBLE, 0, 0, MPI_COMM_WORLD);
    } else {
        total_int = local_int;
        for (source = 1; source < comm_sz; source++) {
            MPI_Recv(&local_int, 1, MPI_DOUBLE, source, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
            total_int += local_int;
        }
    }

    if (my_rank == 0) {
        printf("Con %d trapezi, la stima da %f a %f = %f\n", n, a, b, total_int);
    }

    MPI_Finalize();
    return 0;
}
```

Però c'é un problema con questa implementazione infatti $p-1$ processi inviano la loro stima al processo 0 che calcolerá la somma di tutti, ma questo non è bilanciato, infatti abbiamo un tempo di $(p-1) * (T_"sum" + T_"recv")$ per il processo 0 mentre per tutti gli altri un tempo di $T_"send"$.

Un alternativa potrebbe essere, per tutti i processi un tempo di $log_2 (p) * (T_"sum" + T_"recv")$

Il modo ottimale per effettuare una somma dipende dal numero di processi, la grandezza dei dati e dal sistema, avere un modo nativo per esprimere la somma migliora le performance e semplifica la programmazione. Utilizziamo *reduce*.

== Collective Communication

Vediamo la firma per l'operazione di `Reduce`:

```c
int MPI_Reduce(
  void         *input_data_p, //.Dati da inviare
  void         *output_data_p,// Buffer di ricezione
  int          count,         // numero di elementi
  MPI_Datatype datatype,      // tipo di dato
  MPI_Op       operator,      // operazione, sono definite da MPI
  int          dest_process,  // chi riceverà il dato
  MPI_Comm     comm           // comunicatore
);
```

Con questa operazione i dati di tutti i processi partecipanti vengono combinati tramite un'operazione e il risultato finale inviato ad un solo processo.

Possiamo ad esempio utilizzarla nella nostra implementazione del trapezio invece della send:

```c
MPI_Reduce(&local_int, &total_int, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
```

Un'altra funzione molto utile è `MPI_Bcast` che serve ad inviare i dati di un processo a tutti gli altri processi nello stesso comunicatore:

```c
int MPI_Bcast(
  void         *data_p,     // Input o output
  int          count,
  MPI_Datatype datatype,
  int          source_proc, // Rank di chi invia i dati
  MPI_Comm     comm
);
```

Tutti i processi che la chiamano devono farlo con gli stessi paramentri, l'operazion è sincrona quindi termina soltanto quando tutti i processi hanno ricevuto i dati.

Infine c'è `MPI_Allreduce` che concettualmente corrisponde a `reduce + broadcast`, consente a tutti i processi di partecipare ad una riduzione, ottenere il risultato finale e poi inviarlo a tutti i processi:

```c
int MPI_Allreduce(void *sendbuf, void *recvbuf, int count, MPI_Datatype datatype, MPI_Op op, MPI_Comm comm);
```

= Performance Evaluation
Per effettuare una valutazione dei tempi di computazione utilizziamo la funzione `double MPI_Wtime(void);`, va chiamata al tempo di inizio della misurazione e alla fine, per misurare il tempo basta calcolare la differenza fra i due tempi:

```c
double start, finish;
start = MPI_Wtime();
...
finish = MPI_Wtime();
printf("Process %d, elapsed time: %e", my_rank, finish - start);
```

Ovviamente i processi, in molti casi, finiranno in tempi diversi ad esempio quando il processo padre (rank 0) esegue più lavoro rispetto agli altri. Dobbiamo quindi stampare il tempo mmassimo fra tutti i processi. Possiamo farlo con `reduce`:

```c
double local_start, local_finish, local_elapsed, elapsed;

local_start = MPI_Wtime();
// Codice da valutare
...
local_finish = MPI_Wtime();
local_elapsed = local_finish - local_start;

MPI_Reduce(&local_elapsed, &elapsed, 1, MPI_DOUBLE, MPI_MAX, 0, comm);

if (my_rank == 0) {
  printf("Elapsed time: %e\n", elapsed);
}
```

Un altro problema però è che non tutti i processi partiranno nello stesso momento e se questo accade allora il tempo che vedremo sarà elevato non perché abbiamo scritto male il programma ma perché semplicemente alcuni processi sono partiti più tardi di altri. Come ci assicuriamo quindi che i processi iniziano nello stesso momento?

Utilizziamo `MPI_Barrier`, in alcune implementazioni potrebbe non garantire quello che serve a noi ma per lo scopo del corso va bene.

- *Basta una sola misurazione per valutare le performance?*
Ovviamente no, se eseguiamo il codice 100 volte vedremo molti risultati diversi, soprattutto se durante le esecuzioni cambiano le condizioni della macchina come ad esempio memoria utilizzata, utilizzo del processore e altro.

Per eseguire una valutazione quindi eseguiamo il codice molte volte e facciamo un report della distribuzione totale dei tempi.

_Ad esempio_

#align(center, image("img/timing.png", width: 80%))

Quindi, per raccogliere dati sui tempi d'esecuzione dobbiamo:
1. Impostare un `Barrier` all'inizio in modo che tutti i processi inizino nello stesso momento
2. Salvare il tempo massimo d'esecuzione fra tutti i rank
3. Eseguire l'applicazione più volte e salvare la distribuzione dei tempi

Confrontiamo adesso alcuni tempi d'esecuzione e diamo delle definizioni.

#align(center, image("img/tempi1.png", width: 80%))

- Notiamo che nel caso di un'esecuzione sequenziale, quindi con un solo thread, i tempi crescono con il crescere della grandezza del problema. (Basta guardare la prima riga)
- Se scegliamo una grandezza (una colonna) e scendiamo verso il basso, quindi aumentiamo i processi, notiamo che i tempi diminuiscono

Osserviamo però che con una matrice grande 1024 i tempi d'esecuzione con 8 e 16 thread sono uguale. Perché?

Ci aspettiamo che se eseguiamo un programma con $p$ processi allora sarà $p$ volte pù veloce di quando lo eseguiamo con 1, non è sempre così. Definiamo
- $T_"serieal" (n)$ come il tempo con esecuzione sequenziale e $n$ la dimensione del problema.
- $T_"parallel" (n, p)$ come il tempo con esecuzione parallela con $p$ processi.
- $S(n, p)$ come la *speedup* (incremento) dell'esecuzione parallela:

$ S(n,p) = frac(T_"serial" (n), T_"parallel" (n,p)) $

Idealmente, vorremmo avere $S(n,p) = p$, se questo accade diciamo che abbiamo *linear speedup*.

Osserviamo i tempi di speedup con lo stesso problema di prima:

#align(center, image("img/speedup.png", width: 80%))

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
  title: [*Parallelizzazione con un solo processo*],
  [
    E' importante notare che $T_"serial" (n) eq.not T_"parallel" (n,1)$.

    In generale si ha che $T_"parallel" (n,1) gt.eq T_"serial" (n)$

    Questo perché il codice parallelo richiede delle operazioni di preparazione anche per un solo processo e quindi sarà più lento rispetto ad un codice seriale.
  ]
)

Oltre allo *speedup* possiamo calcolare la *scalability*:

$ S(n,p) = frac(T_"parallel" (n,1), T_"parallel" (n,p)) $

E anche l'efficienza:

$ E(n,p) = frac(S(n,p), p) = frac(T_"serial" (n), p dot T_"parallel" (n,p)) $

Vorremmo avere un'efficienza = 1 ma in pratica avremo sempre dei valori $lt.eq 1$ e andrà sempre peggio con problemi più piccoli.

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
  title: [*Strong vs Weak Scaling*],
  [
    - *Strong Scaling*: Fissiamo la grandezza del problema e incrementiamo il numero di processi, se manteniamo un'efficienza alta allora il nostro programma è *strong scalable*.

    - *Weak Scaling*: Incrementiamo la grandezza del problema insieme al numero dei processi, se manteniamo un'alta efficienza allora il programma è *weak scalable*.
  ]
)

Vediamo dei dati esempio con lo stesso problema di prima ed i dati sull'efficienza:

#align(center, image("img/strongscale.png", width: 80%))

Notiamo che il programma non è strong scalable dato che l'efficienza non rimane alta.

#align(center, image("img/weakscale.png", width: 80%))

Notiamo che il programma è weak scalable dato che manteniamo un'alta efficienza.

#pagebreak()

Possiamo capire in qualche modo come si comporterà il codice?

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
  title: [*Amdahl's Law*],
  [
    Ogni programma ha una parte che non può essere parallela (*serial fraction* $1-alpha$), ad esempio leggere dei dati o in generale calcoli dove abbiamo bisogno di un valore precedente alla computazione corrente.

    La *Amdahl's Law* ci dice che la speedup è limitata da questo $1-alpha$ non parallelo:

    $ T_"parallel" (p) = (1- alpha) T_"serial" + alpha frac(T_"serial", p) $
  ]
)

I casi estremi della formula sono:
- Se $alpha=0$ allora il codice non può essere parallelizzato e quindi $T_"parallel" (p) = T_"serial"$
- Se $alpha=1$ allora tutto il codice può essere parallelizzato e $T_"parallel" (p) = frac(T_"serial", p)$ ovverlo lo speedup ideale.

Per calcolare lo speedup: 

$ S(p) = frac(T_"serial", (1-alpha) T_"serial" + alpha frac(T_"serial", p)) $

E a questo punto vedere anche lo speedup massimo:

$ lim_(p arrow.r infinity) S(p) = frac(1, 1- alpha) $

Ad esempio se abbiamo il 60% parallelizzabile ovvero $alpha=0.6$ allora avremo uno speedup massimo di 2.5

La formula è anche invertibile, quindi se vogliamo capire di quanti processi abbiamo bisogno per raggiungere un certo speedup possiamo farlo. Ad esempio se volessimo usare 100000 processi dovremmo avere $alpha >= 0.99999$

#align(center, image("img/amdahl.png", width: 60%))

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
  title: [*Gustafson's Law*],
  [
    Se consideriamo il weak scaling, la parallel fraction aumenta insieme alla grandezza del problema, quindi il tempo seriale rimane costante ma quello parallelo aumenta. *Scaled Speedup*:

    $ S(n,p)=(1-alpha) +alpha p $

    Il carico su ogni thread rimane costante.
  ]
)

Vediamo i due grafici a confronto:

#align(center, image("img/amvsgu.png"))

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
  title: [*Amdahl's Law Limitations*],
  [
    La serial fraction potrebbe aumentare con l'aumentare del numero di processi, quindi nella realtà non sempre il codice seguirà le stime, infatti potrebbero verificarsi situazioni come:

    #align(center, image("img/amdahlim.png", width: 50%))
  ]
)

Vediamo altre funzioni utili di MPI:
- *MPI_Scatter*: Si utilizza per spezzare un dato in più parti ed inviare ciascuna parte ad un processo, ad esempio il processo 0 legge un array, lo divide in parti uguali e invia ciascuna di queste agli altri processi.

```c
int MPI_Scatter(
  void*         send_buf_p,
  int           send_count,
  MPI_Datatype  send_type,
  void*         recv_buf_p,
  int           recv_count,
  MPI_Datatype  recv_type,
  int           src_proc,
  MPI_Comm      comm
);
```

Il `send_count` è il numero di elementi da inviare a ciascun processo non il totale. Se i dati non possono essere divisi in maniera omogenea, ad esempio abbiamo un array da 5 elementi e vogliamo inviare a ciascun processo 2 elementi possiamo utilizzare `MPI_Scatterv`, altrimenti la Scatter normale va a prendere elementi fuori dal buffer.


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
  title: [*Risparmiare Spazio*],
  [
    Anche il processo 0 che invia i dati riceverà una parte di questi, se non vogliamo fargli allocare un nuovo buffer possiamo usare `MPI_IN_PLACE`:

    ```c
    if (rank == 0) {
      MPI_Scatter(buff, 3, MPI_INT, MPI_IN_PLACE, 3, MPI_INT, 0, MPI_COMM_WORLD);
    } else {
      MPI_Scatter(buff, 3, MPI_INT, dest, 3, MPI_INT, 0, MPI_COMM_WORLD);
    }
    ```
  ]
)

La sua "inversa" è `Gather`, permette di collezionare le parti di un dato in un unico processo:

```c
int MPI_Gather(
  void*         send_buf_p,
  int           send_count,
  MPI_Datatype  send_type,
  void*         recv_buf_p,
  int           recv_count,
  MPI_Datatype  recv_type,
  int           dest_proc,
  MPI_Comm      comm
);
```

Anche qui il `send_count` è il numero di parti che ciascun processo manda e non il totale.

== Matrici
Le matrici possiamo rappresentarle in C o come tanti array allocati dinamicamente oppure come un lungo array contiguo.

Per allocare dinamicamente una matrice come tanti array dobbiamo:

```c
int **a;
a = (int**) malloc(sizeof(int*) * num_rows);
for (int i = 0; i < num_rows; i++) {
  a[i] = (int*) malloc(sizeof(int) * num_cols;
}
```

Se vogliamo però effettuare delle riduzioni, come ad esempio `Reduce` dobbiamo fare attenzione, a primo impatto vorremo scrivere:

```c
MPI_Reduce(a, recvbuf, num_rows * num_cols, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
// Oppure
MPI_Reduce(a[0], recvbuf, num_rows * num_cols, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
```

Ma sono entrambi degli approcci sbagliati dato che gli array allocati dinamicamente nel modo visto sopra non è detto che siano contigui in memoria. Il metodo corretto è fare una reduce per ogni array della matrice:

```c
for (int i = 0; i < num_rows; i++) {
  MPI_Reduce(a[i], recvbuf[i], num_cols, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
}
```

Se invece allochiamo la matrice come un unico array:

```c
int *a;
a = (int*) malloc(sizeof(int) * num_rows * num_cols);
...
...
//Per accedere agli elementi
a[i * num_cols + j] = ...
```

E in questo caso il metodo visto sopra per le `Reduce` è giusto, quindi:

```c
MPI_Reduce(a, recvbuf, num_rows * num_cols, MPI_INT, MPI_SUM, 0, MPI_COMM_WORLD);
```

In alcuni casi vengono usate, una dopo l'altra, le operazioni `Gather` e `Broadcast`, in MPI se due operazioni vengono spesso usate una dopo l'altra allora molto probabilmente esiste un'operazione che le combina, vediamo infatti `Allgather`:

```c
int MPI:Allgather(
  void*         send_buf_p,
  int           send_count,
  MPI_Datatype  send_type,
  void*         recv_buf_p,
  int           recv_count,
  MPI_Datatype  recv_type,
  MPI_Comm      comm
);
```

Altre funzioni utili sono:
- `Reduce-Scatter`: Esegue un'operazione di riduzione, una volta ottenuto il vettore risultato lo distribuisce in parti uguali a tutti i processi.
- `MPI_Alltoall`: Tutti i processi inviano i dati a tutti gli altri processi (inclusi se stessi) e tutti ricevono dati da tutti.

= Derived Datatypes
Supponiamo di dover inviare le coordinate di punti sul piano ed il loro colore:

Per ogni punto effettueremo 3 send

```c
MPI_Send(a_p, 1, MPI_DOUBLE, dest, 0, MPI_COMM_WORLD);
MPI_Send(b_p, 1, MPI_DOUBLE, dest, 0, MPI_COMM_WORLD);
MPI_Send(n_p, 1, MPI_INT, dest, 0, MPI_COMM_WORLD);
```

Stessa cosa per le `Receive`. Si può rendere più efficiente? Si, utilizzando i *Derived Datatypes*. Grazie a questi possiamo salvare in memoria una collezione di dati memorizzando sia il tipo di dato di ciascunno di essi sia la loro posizione. Grazie a questi tipi di dato possiamo, prima di inviare i dati, raccoglierli tutti e fare una sola send. Ragionamento analogo per le receive.

Per costruire le struct utilizziamo:
```c
int MPI_Type_create_struct (
  int           count,
  int           array_of_blocklengths[],
  MPI_Aint      array_of_displacements[],
  MPI_Datatype  array_of_types[],
  MPI_Datatype* new_type_p
);
```

Ad esempio se vogliamo ricreare la struct:
```c
struct t {
  double a;
  double b;
  int n;
}
```

Avremo come paramentri:
- `count = 3`
- `blocklengths = 1,1,1`
- `displacements = 0, 16, 24`
- `types: MPI_DOUBLE, MPI_DOUBLE, MPI_INT`

Non sempre siamo a conoscenza dei `displacements`, utilizziamo quindi:

```c
int MPI_Get_address(
  void*     location_p,
  MPI_Aint* address_p
);
```

Serve a ottenere l'indirizzo di memoria referenziato dal puntatore `location_p`, il tipo `MPI_Aint` è un tipo speciale di MPI in grado di contenere qualsiasi indirizzo di sistema.

Quindi usando la stessa struct di prima avremo:
```c
MPI_Aint a_addr, b_addr, n_addr;

MPI_Get_address(&a, &a_addr);
array_of_displacements[0] = 0;
MPI_Get_address(&b, &b_addr);
array_of_displacements[1] = b_addr - a_addr;
MPI_Get_address(&n, &n_addr);
array_of_displacements[2] = n_addr - a_addr;
```

_Per calcolare questi indirizzi ovviamente va prima creata un'istanza della struct in modo da calcolare gli indirizzi_

Infine, per poter utilizzare il tipo appena creato nelle altre funzioni dobbiamo chiamare:
```c
int MPI_Type_commit(MPI_Datatype* new_mpi_t_p);
```

A questo punto possiamo utilizzarlo anche nelle altre funzioni, ricordiamoci però che una volta finito il suo utilizzo va eseguito un `free`:

```c
int MPI_Type_free(MPI_Datatype* old_mpi_t_p);
```

Possiamo creare in generale tipi di dati contigui e non per forza solo `struct`, con le varie funzioni:
- `MPI_Type_contiguous`
- `MPI_Type_vector`
- `MPI_Type_create_subarray`
- `MPI_pack / MPI_unpack`