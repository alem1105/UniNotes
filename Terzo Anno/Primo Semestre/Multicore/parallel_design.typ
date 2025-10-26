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