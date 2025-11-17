#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages)
#show raw: set text(font: "Cascadia Code")

= Shared Memory Programming with OpenMP
In OpenMP il sistema è visto come una collezione di cores o CPU, tutti questi hanno accesso alla stessa memoria. L'obiettivo principale è quello di scomporre un programma sequenziali in più componenti che possono essere eseguite in parallelo. Per fare questo si utilizzano le *direttive del compilatore*.

OpenMP segue quindi il paradigma *Globally Sequential, Locally Paralle* e il *fork-join*, infatti i programmi iniziano e sono sequenziali ma durante la loro esecuzioni vengono eseguite delle parti in parallelo.

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
  title: [Pragmas],
  [
    Sono delle istruzioni speciali lette durante il preprocessing del programma, non fanno parte della specifica di base di C. I compilatori che non le supportano, quindi, le ignorano. Si indicano con `#pragma`
  ]
)

Vediamo alcune direttive
- `# pragma omp parallel`: È la più basica, possiamo definire il numero di thread che eseguiranno il blocco a run-time.

Per terminare il blocco di codice parallelo usiamo: `# pragma omp end parallel`, si può omettere se il codice parallelo dura fino alla fine della funzione.

Ad esempio:

```c
int main(int argc, char *argv[]) {
  int thread_count = strtol(argv[1], NULL, 10);

  # pragma omp parallel num_threads(thread_count)
    Hello();
    return 0;
}

void Hello(void) {
  int my_rank = omp_get_thread_num();
  int thread_count = omp_get_num_threads();
  printf("Hello from thread %d of $d\n", my_rank, thread_count);
}
```

Per compilarlo ed eseguirlo:

```
// Compilazione
gcc -g -Wall -fopenmp -o omp_hello omp_hello.c
// Esecuzione
./omp_hello 4
```

Dove 4 indica il numero di thread con cui vogliamo eseguire il programma.

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
  title: [Thread Team Size Control],
  [
    Possiamo modificare il numero di thread con cui eseguire i programmi in diversi modi:
    - *Dalla shell* utilizzando la variabile globale `OMP_NUM_THREADS`:
      -  `echo ${OMP_NUM_THREADS}` per sapere quanto vale la varibile in questo momento
      - `export OMP_NUM_THREADS=4` per impostarla
    - *Program Level* attraverso la funzione `omp_set_num_threads` fuori da un costrutto OpenMP
    - *Pragma Level* attraverso la direttiva `num_threads`

    Se chiamiamo `omp_get_num_threads` riceviamo il numero di threads in una parte di codice parallela, in una sequenziale riceviamo 1. Una chiamata a `omp_get_thread_num` invece ci restituisce l'id del thread che l'ha chiamata.
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
  title: [Clause],
  [
    È un testo che serve a modificare una direttiva, prima abbiamo usato `num_threads` per specificare il numero di threads che devono eseguire il blocco parallelo.
  ]
)

È importante osservare che il sistema potrebbe imporre delle limitazioni sul numero di threads che un programma può utilizzare, infatti OpenMP standard non garantisce che il programma crei esattamente `thread_count` threads.

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
  title: [Terminologia],
  [
    In OpenMP i threads che eseguono lo stesso blocco parallelo sono chiamati *team*:
    - *master*: Il thread originale d'esecuzione
    - *parent*: Un thread che ha incontrato un direttiva per del codice parallelo e ha avviato un team di threads. In alcuni casi il thread parent è anche il master
    - *child*: Ogni thread avviato da un parent è considerato un thread child.
  ]
)

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
  title: [Mancato supporto di OpenMP],
  [
    Nel caso in cui il compilatori non supporti OpenMP possiamo utilizzare:
    ```c
    # include <omp.h>
    // Oppure
    # ifdef _OPENMP
    # include <omp.h>
    # endif

    # ifdef _OPENMP
      int my_rank = omp_get_thread_num();
      int thread_count = omp_get_num_threads();
    # else
      int my_rank = 0;
      int thread_count = 1;
    # endif
    ```
  ]
)

Adesso prendiamo come esempio il codice visto con la regola del trapezio, ad un certo punto i thread dovranno sommare i valori ottenuti ed eseguire quindi:

```c
global_result += my_result;
```

Ma siccome in OpenMP utilizzano una memoria condivia, abbiamo il problema della *mutua esclusione*, se due processi lavoranno sulla stessa memoria nello stesso momento avremo risultati inaspettati.

Si utilizza `# pragma omp critical` per marcare una sezione critica, queste potranno essere eseguite soltanto da un thread alla volta.

Un'altra direttiva con lo stesso scopo ma, in alcuni casi più efficiente, è `# pragma omp atomic`, questa protegge in una sezione critica soltanto l'incremento della variabile globale, se infatti avessimo un codice tipo `global_result += my_function()` allora la funzione `my_function` verrebbe ancora eseguita in parallelo fra tutti i thread.

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
  title: [Scope],
  [
    In un programma seriale lo scope di una variabile è quella parte di programma dove la variabile viene utilizzata. In OpenMP lo scope si riferisce a quell'insieme di threads che possono accedere alla variabile in un blocco parallelo.
    - *Shared Scope*: Una variabile a cui possono accedere tutti i threads nel team.
    - *Private Scope*: Una variabile a cui può accedere un solo thread.
    Lo scope predefinito per le variabili dichiarate prima di un blocco parallelo è *shared*.
  ]
)

