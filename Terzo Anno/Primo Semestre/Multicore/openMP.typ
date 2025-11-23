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

== Reduction Clause
Prima abbiamo utilizzato una variabile globale per memorizzare il risultato accumulato dai vari threads. Possiamo farlo anche con una funzione che ritorna il valore dell'area? Ad esempio:

```c
double Local_Trap(double a, double b, int n);
```

Si, ma se scriviamo:

```c
global_result = 0.0;
# pragma omp parallel num_threads(thread_count)
{
# pragma omp critical
  global_result += Local_trap(double a, double b, int n);
}
```

Abbiamo il problema della sezione critica visto prima, per non avere errori i thread andrebbero eseguiti in modo sequenziale.

Possiamo però risolvere il problema definendo una variabile privata nel blocco parallelo e muovere la sezione critica dopo la chiamata a funzione:

```c
global_result = 0.0;
# pragma omp parallel num_threads(thread_count)
{
  double my_result = 0.0;
  my_result += Local_trap(double a, double b, int n);
# pragma omp critical
  global_result += my_result;
}
```

Quello che abbiamo appena fatto è molto simile a una *reduce* in OpenMPI, anche in OpenMP abbiamo delle operazioni simili.

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
  title: [*Reduction Operators*],
  [
    Un *reduction operator* è un operatore binario. Una *riduzione* è un'operazione che ripete la stessa operazione (riduzione) ad una serie di operandi fino ad ottenere un risultato singolo. Tutti i valori intermedi della riduzione dovrebbero essere salvati nella stessa variabile, la *reduction variable*.
  ]
)

Per utilizzarle possiamo aggiungere direttamente le *reduction clause* alle direttive di parallelizzazione:

```c
reduction(<operator>: <variable list>)

//Esempio
global_result = 0.0;
# pragma omp parallel num_threads(thread_count) reduction(+: global_result)

global_result += Local_trap(double a, double b, int n);
```

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
  title: [*Info sulla Riduzione*],
  [
    La variabile privata inizializzata per la riduzione viene inizializzata al valore identità per l'operatore di riduzione, quindi ad esempio se usiamo una moltiplicazione abbiamo 1, con una somma 0.

    Inoltre la riduzione accumula i valori sia all'interno che all'esterno del blocco parallelo.
  ]
)

_Esempio_

```c
int acc = 6;
# pragma omp parallel num_threads(5) reduction(*: acc)
{
  acc += omp_get_thread_num();
  printf("thread %d: private acc is %d\n", omp_get_thread_num(), acc);
}
printf("after: acc is %d\n", acc)
```

Otteniamo come output:
```
tid = 0 sum = 1
tid = 3 sum = 4
tid = 4 sum = 5
tid = 2 sum = 3
tid = 1 sum = 2
Final sum = 720
```

Otteniamo 720 perché appunto ogni thread ottiene come risultato locale $1 + "tid"$ dato che `acc` è inizializzata ad 1 per via della moltiplicazione e infine tutti i valori, anche il 6 esterno, vengono ridotti con la moltiplicazione e otteniamo quindi $1 * 2 * 3 * 4 * 5 * 6 = 720$.

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
  title: [*Info sugli scope*],
  [
    Si può sovrascrivere lo scope di default con:
    ```c
    default(none)
    ```
    Facendo così il compilatore richiederà di specificare lo scope di ogni variabile che usiamo in un blocco parallelo e che è stata dichiarata al suo esterno.
  ]
)

Esistono dei modificatori che vanno inseriti nelle direttive per scegliere gli scope delle variabili:
- *shared*: È il comportamento di default delle variabili dichiarate fuori dai blocchi paralleli, va utilizzato soltanto se abbiamo specificato anche `default(none)`.
- *reduction*: Un'operazione di riduzione viene effettuata tra le copie private e gli oggetti esterni dal blocco, il valore finale è salvato nell'oggetto esterno.
- *private*: Crea una copia della variabile per ogni thread del team, le variabili private *non sono inizializzate* quindi non si ha il valore dichiarato all'esterno del blocco parallelo.

_Esempio_

```c
int x = 5;
# pragma omp parallel private(x)
{
  x = x+1 // Pericoloso dato che x non è inizializzata
  printf("thread %d: private x is %d\n", omp_get_thread_num(), x);
}
printf("after: x is %d\n", x); // Pericoloso dato che stampa la x dichiarata nella prima riga
```

Infatti otteniamo come output:
```
thread 0: private x is 1
thread 1: private x is 1
thread 3: private x is 1
thread 2: private x is 1
after: x is 5
```

Altri modificatori sono:
- *firstprivate*: Si comporta come il private ma la copia della variabile privata è inizializzata al valore di quella esterna.
- *lastprivate*: Si comporta come il private ma l'ultimo thread, *quello che esegue l'ultima iterazione del blocco sequenziale*, copia il valore della variabile in quella esterna.

Quando dichiariamo una variabile *privata* questa non esisterà più una volta usciti dal suo scope. Come possiamo dichiarare una variabile privata che esiste in più sezioni parallele?

- *threadprivate*: Crea uno storage dedicato ai thread per i dati globali, questi dati devono essere delle variabili globali o statiche in C o membri statici di una classe in C++.
- *copyin*: Utilizzata insieme a *threadprivate* per inizializzare le copie threadprivate di un team di threads dalle variabili del thread master.

_Esempio_

```c
int tp;

int main(int argc, char **argv) {
  # pragma omp threadprivate(tp)

  # pragma omp parallel num_threads(7)
  tp = omp_get_thread_num();

  # pragma omp parallel num_threads(9)
  printf("Thread %d has %d\n", omp_get_thread_num(), tp);
}
```

Otteniamo come output:
```
Thread 3 has 3
Thread 2 has 2
Thread 8 has 0
Thread 7 has 0
Thread 5 has 5
Thread 4 has 4
Thread 6 has 6
Thread 1 has 1
Thread 0 has 0
```

Questo perché i thread del secondo blocco non hanno associato il loro valore alla variabile.

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
  title: [*Esempi con threadprivate*],
  [
    Se vogliamo che il dato privato sia uguale per tutti i threads:
    ```c
    # pragma omp threadprivate(private_var)
    ...
    private_var = 1;

    # pragma omp parallel copyin(private_var)
    private_var += omp_get_thread_num()
    ```

    Se invece vogliamo fare in modo che un thread imposti il suo valore privato anche sugli altri thread:
    ```c
    # pragma omp parallel
    {
      # pragma omp single copyprivate(private_var)
      private_var = 4
    }
    ```
  ]
)

== Parallel For
Con la direttiva che vedremo potremo rendere parallela l'esecuzione di un for loop. Ad esempio il codice per l'esercizio del trapezio:

```c
h = (b - a) / n;
approx = (f(a) + f(b)) / 2.0;
for (i = 1; i <= n - 1; i++) {
  approx += f(a + i * h);
}
approx = h * approx;
```

Possiamo parallelizzarlo con:
```c
h = (b - a) / n;
approx = (f(a) + f(b)) / 2.0;
# pragma omp parallel for num_threads(thread_count) reduction(+ : approx)
for (i = 1; i <= n - 1; i++) {
  approx += f(a + i * h);
}
approx = h * approx;
```

È importante ricordare però che non tutti i tipi di _for_ sono parallelizzabili con questa direttiva. I _for_ concessi devono rispettare:

- La variabile index usata per indicare le iterazioni deve essere un intero o un puntatore.
- Le espressioni `start, end, incr` devono essere di un tipo compatibile ad index.
- Le espressioni `start, end, incr` non devono cambiare durante le iterazioni.
- Durante le iterazioni la variabile index può essere modificata soltanto dall'espressione di incremento indicata nel for.

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
  title: [*Ottimizzazione con i threads*],
  [
    Se in più punti del codice utilizziamo dei for paralleli, ad esempio:

    ```c
    ...
    # pragma omp parallel for num_threads(thread_count) default(none) shared(a, n) private(i, tmp)
    for (i = 1; i < n; i += 2) {
      ...
    }
    ...

    # pragma omp parallel for num_threads(thread_count) default(none) shared(a, n) private(i, tmp)
    for (i = 1; i < n - 1; i += 2) {
      ...
    }
    ...
    ```

    Ogni volta verranno creati nuovi threads e non è molto efficiente, infatti potremmo creare direttamente dei thread ad inizio programma e riutilizzare sempre gli stessi:

    ```c
    # pragma omp parallel for num_threads(thread_count) default(none) shared(a, n) private(i, tmp, phase)
    ...
    # pragma omp for
    for (i = 1; i < n; i += 2) {
      ...
    }
    ...
    # pragma omp for
    for (i = 1; i < n - 1; i += 2) {
      ...
    }
    ```
    Questo si applica in generale a tutti gli approcci multithreads e non soltanto ai for.
  ]
)

In OpenMP è possibile dare dei nomi alle sezioni critiche con:
```c
# pragma omp critical(name)
```

In questo modo, due blocchi protetti perché sezione critica possono comunque essere eseguiti nello stesso momento se hanno un nome diverso. Questo dobbiamo comunque farlo a tempo di compilazione ma se non sappiamo a tempo di compilazione quante sezioni critiche ci sono? Utilizziamo i locks in OpenMP:

```c
omp_lock_t writelock;
omp_init_lock(&writelock);

# pragma omp parallel for
for (i = 0; i < x; i++) {
  ...
  omp_set_lock(&writelock);
  // Codice da far eseguire da un solo thread alla volta
  omp_unset_lock(&writelock);
  ...
}
omp_destroy_lock(&writelock);
```

Cosa scegliamo quindi? *Critical, Atomic o i Locks*? Atomic è quella che di solito è la più veloce per farci ottenere mutua esclusione. I lock andrebbero utilizzati quando vogliamo mutua esclusione per delle strutture dati invece che un blocco di codice.

Inoltre è importante non mischiare i due tipi di mutua esclusione per una singola sezione critica perché non è garantita l'equità, è quindi pericoloso innestare due costrutti di mutua esclusione:

```c
int main() {
  # pragma omp critical
  y = f(x);
  ...
}

double f(double x) {
  # pragma omp critical
  z = g(x); // z is shared
  ...
}
return z;
```

Il codice sopra andrà in *deadlock*, in questo caso possiamo risolverlo rinominando le sezioni:

```c
int main() {
  # pragma omp critical (one)
  y = f(x);
  ...
}

double f(double x) {
  # pragma omp critical (two)
  z = g(x); // z is shared
  ...
}
return z;
```

== Nested Loops
Nella maggior parte dei casi quando si hanno dei cicli for annidati possiamo parallelizzare soltanto quello più esterno. Inoltre, spesso, il ciclo più esterno è quello con meno iterazioni e non tutti i thread creati vengono utilizzati ma questo non significa che è meglio parallelizzare quello interno infatti potrebbe accadere che alcuni thread hanno più lavoro di altri.

La soluzione corretta è quella di collassarli tutti in unico loop, possiamo farlo o noi manualmente oppure farlo fare ad OpenMP:

```c
a();
# pragma omp parallel for collpse(2)
for (int i = 0; i < 3; ++i) {
  for (int j = 0; j < 6; ++j) {
    c(i, j);
  }
}
z();
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
  title: [*Attenzione!*],
  [
    Di default la parallelizzazione innestata è disabilitata, ovvero non possiamo fare questo:
    ```c
    # pragma omp parallel for
    for (int i = 0; i < 3; ++i) {
      # pragma omp parallel for
      for (int j = 0; j < 6; ++j) {
        c(i, j);
      }
    }
    ```
    Questo perché, se fosse abilitata, andrebbe a creare ad esempio su una macchina con 4 threads: $3*4=12$ threads
  ]
)