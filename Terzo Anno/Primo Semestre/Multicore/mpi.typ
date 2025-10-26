#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

= Distributed memory programming with MPI
Possiamo astrarre un *distributed memory system* in questo modo: #align(center, image("img/image3.png", width: 80%))

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
  title: [*Single-Program Multiple-Data*],
  [
    Noi *compiliamo un solo programma* ma poi questo verrà eseguito da più processi. Useremo un *if-else* per cambiare il comportamento dei processi quindi, ad esempio:
    - Se sono il processo 0 faccio X 
    - Altrimenti faccio Y
    Ricordiamo che i processi non condividono memoria quindi la comunicazione avviene tramite *message passing*.
  ]
)

Per programmare con la libreria *MPI* abbiamo bisogno di aggiungere l'header `mpi.h` e usare degli identificatori, di solito iniziano con `MPI_`.

#showybox(
  frame: (
    border-color: blue.lighten(60%),
    title-color: blue.lighten(60%),
    body-color: white
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Esempio*],
  [
    ```c
    #include <stdio.h>
    #include <mpi.h>

    int main(void) {
      MPI_Init(NULL, NULL);
      printf(“hello, world\n”);
      MPI_Finalize();
      return 0;
    }
    ```
  ]
)

- `MPI_Init` inizializza `mpi` per tutto il necessario, possiamo passare dei puntatori ai parametri del main, se non ci servono possiamo anche passare `NULL`, come l'esempio sopra.

- `MPI_Finalize` fa capire a `mpi` che il programma è finito e può pulire tutta la memoria allocata.

Il programma non deve trovarsi tutto all'interno di questo costrutto ma è importante che ci sia la parte che vogliamo venga eseguita da più cores.

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
  title: [*Compilazione*],
  [
    ```bash
    mpicc -g -Wall -o mpi_hello mpi_hello.c
    ```
    - `mpicc` è il compilatore
    - `-g` fa visualizzare delle informazioni di debug
    - `-Wall` attiva tutti gli avvisi
    - `-o` specifica il nome del file di output
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
  title: [*Esecuzione*],
  [
    ```bash
    mpiexec -n <number of processes> <executable>
    ```
    Serve per eseguire il programma e ci permette di specificare con quanti core lanciarlo.
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
  title: [*Debugging*],
  [
    ```bash
    mpiexec –n 4 ./test : -n 1 ddd ./test : -n 1 ./test
    ```
    Debuggare programmi non seriali è più complicato, ad esempio se eseguiamo lo stesso programma con un solo processo il problema potrebbe non verificarsi mentre se lo eseguiamo con un certo numero di core si.

    Con il comando sopra possiamo lanciare 5 processi, il quinto verrà eseguito con il debugger, che si chiama `ddd`. 
  ]
)

== Communicators
Sono dei processi che possono mandarsi dei messaggi fra di loro, quando chiamiamo `MPI_Init` viene inizializzato anche un comunicatore per tutti i processi, questo è chiamato `MPI_COMM_WORLD`.

Dopo un `INIT` possiamo "catturare" l'identificatore di ogni processo e anche il numero totale, attraverso:

```c
int MPI_Comm_size(
  MPI_Comm    comm      /* in */,
  int*        comm_sz_p /* out *
);
```

```c
int MPI_Comm_rank(
  MPI_Comm    comm      /* in */,
  int*        my_rank_p /* out */
);
```

Prendono in input il comunicatore e un puntatore ad interno e salvano in questi interi i valori di, rispettivamente, quanti processi ci sono e il grado del processo attuale.

_Esempio di utilizzo_

```c
#include <stdio.h>
#include <mpi.h>

int main(void) {
	int comm_sz, my_rank;
	MPI_Init(NULL, NULL);
	MPI_Comm_size(MPI_COMM_WORLD, &comm_sz);
	MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
	printf(“hello, world from process %d out of %d\n”, my_rank, comm_sz);
	MPI_Finalize();
	return 0;
}
```

Se eseguiamo questo programma noteremo che ad ogni esecuzione l'ordine dei print cambia, questo perchè non sappiamo con esattezza quale processo finirà per primo quindi otterremo sempre un ordine diverso. Possiamo cambiare questo comportamento facendo comunicare i processi.

Per far comunicare i processi utilizziamo due funzioni `MPI_Send` e `MPI_Recv`:

```c 
int MPI_Send(
  void*           msg_buf_p     /* in */,
  int             msg_size      /* in */,
  MPI_Datatype    msg_type      /* in */,
  int             dest          /* in */,
  int             tag           /* in */,
  MPI_Comm        communicator  /* in */
);

int MPI_Recv(
  void*           msg_buf_p     /* out */,
  int             buf_size      /* in */,
  MPI_Datatype    buf_type      /* in */,
  int             source        /* in */,
  int             tag           /* in */,
  MPI_Comm        communicator  /* in */,
  MPI_Status*     status_p      /* in */
);
```

Da notare che `msg_size` e `buf_size` indicano il numero di elementi e non il numero di byte.

Il campo `status_p` di tipo `MPI_Status*` è un puntatore ad una struttura composta in questo modo:

```c
typedef struct MPI_Status {
    int MPI_SOURCE;  // rank del mittente
    int MPI_TAG;     // tag del messaggio
    int MPI_ERROR;   // eventuale codice d’errore
} MPI_Status;
```

Serve a ricavare dei dati dal messaggio appena ricevuto, tramite una funzioen aggiuntiva chiamata `MPI_Get_count` definita:

```c
int MPI_Get_count(
  MPI_Status*     status_p  /* in */,
  MPI_Datatype    type      /* in */,
  int*            count_p   /* out */
);
```

Possiamo capire quanti elementi stiamo ricevendo.

Proviamo adesso a scrivere una nuova versione di `hello world` che rispetta l'ordine delle stampa, facendo in modo che un processo padre riceva gli output dei processi figli.

È importante anche sapere che in MPI si usano dei tipi di dato specifici e non quelli classici di C:

#align(center, image("img/image4.png", width: 50%))

```c
#include <stdio.h>
#include <string.h>
#include <mpi.h>

const int MAX_STRING = 100;

int main(void) {
  char greeting[MAX_STRING];
  int  comm_sz;
  int  my_rank;

  MPI_INIT(NULL, NULL);
  MPI_Comm_size(MPI_COMM_WORLD, &comm_sz);
  MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);

  if (my_rank != 0) {
    sprintf(greeting, "Greetings from process %d of %d!", my_rank, comm_sz);
    MPI_Send(greeting, strlen(greeting)+1, MPI_CHAR, 0, 0, MPI_COMM_WORLD);
  } else {
    printf("Greetings from process %d of %d!\n", my_rank, comm_sz);
    for (int q = 1; q < comm_sz; q++) {
      MPI_Recv(greeting, MAX_STRING, MPI_CHAR, q, 0, MPI_COMM_WORLD, MPI_STATUS_IGNORE);
      printf("%s\n", greeting);
    }
  }

  MPI_Finalize();
  return 0;
}
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
  title: [*Sending Order*],
  [
     MPI garantisce che i messaggi che si inviano una coppia di processi arrivino nell'ordine di invio, quindi se ad esempio il processo p1 invia a p2 3 messaggi m1, m2 ed m3 questi arriverrano sempre nell'ordine di invio.
     Questo ordine però non è garantito quando ci sono mittenti diversi:
     - Un processo `p1` invia il messaggio `m1` a `p0` al tempo `t0`
     - Un processo `p2` invia il messaggio `m2` a `p0` al tempo `t1`
     Ci aspettiamo che arrivi prima il messaggio `m1` ma potrebbe non accadere sempre.
  ]
)

Oltre al comunicatore visto prima `MPI_COMM_WORLD` possiamo anche crearne di nostri per avere più libertà ed implementare sistemi più complessi.

Quindi per fare comunicare un insieme di processi possiamo o creare un comunicatore per ogni gruppo oppure usare i *tag*.

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
  title: [*Message Matching*],
  [
     Prendiamo come esempio due processi che hanno rank `q` ed `r` che si scambiano dei messaggi:

     ```c
    // rank q
    MPI_Send(send_buf_p, send_buf_sz, send_type, dest, send_tag, send_comm);

    // rank r
    MPI_Recv(recv_buf_p, recv_buf_sz, recv_type, src, recv_tag, recv_comm, &status);
     ``` 

     È importante che i campi `dest` e `src` corrispondano ovvero:
     - In `dest` dobbiamo avere il rank di `r` e su `src` il rank di `q`.
     - `send_comm, recv_comm` devono essere lo stesso comunicatore.
     - `send_tag, recv_tag` devono essere lo stesso tag.

     Oltre a queste condizioni un messaggio può essere ricevuto correttamente se:
     - `recv_type = send_type` - Quindi i tipi devono combaciare
     - `recv_buf_sz  >= send_buf_sz` - Il buffer del ricevente deve essere grande abbastanza da contenere tutto il buffer del mittente.

     Un processo può ricevere un messaggio senza conoscere:
     - Quanti dati riceve.
     - Il mittente (`MPI_ANY_SOURCE`)
     - Il tag del messaggio (`MPI_ANY_TAG`)
  ]
)

Il comando `MPI_Send` può comportarsi in modo diverso a seconda di: 
- Dimensione del messaggio 
- Disponibilità del ricevente 
- Risorse del sistema

Per un `MPI_Send` ci sono due diversi protocolli di implementazione:
- *Eager Protocol*: Viene usato per messaggi piccoli, MPI copia i dati in un buffer interno e li spedisce immediatamente anche se il ricevente non ha ancora effettuato una receive. In questo caso restituisce subito un valore e quindi non è bloccante, finchè il destinatario non riceve il messaggio questo vivrà nel buffer interno.
- *Rendezvous Protocol*: Si usa per messaggi grandi, il mittente non invia subito i dati ma manda prima una *request to send* e se il destinatario risponde in modo positivo allora i dati vengono inviati. In questo caso la send è bloccante, fino a quando il ricevente non è pornto.

Ogni implementazione decide la soglia per usare questi protocolli, in OpenMPI abbiamo:
- `< 8 KB` Eager 
- `>= 8 KB` Rendezvous

La receive però a differenza della send blocca sempre il programma in attesa di ricevere qualcosa, a meno che non si utilizzi una versione non bloccante come `MPI_Irecv`.

È importante capire però che anche se oggi un programma che scriviamo funziona perchè la send ritorna subito con messaggi piccoli non dobbiamo scrivere codice che si basa su questo comportamento perchè se lo portiamo su altre macchine con diverse implementazioni potremmo ottente dei comportamenti diversi.

Per scrivere buon codice bisogna pensare alle send come se fossero sempre bloccanti.

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
     1. Se un processo prova a ricevere un messaggio che però non combacia con nessuno di quelli inviati, il processo rimarrà bloccato per sempre.

     2. Se una send è bloccante e nessuno la riceve allora anche il processo mittente rimarrà bloccato.

     3. Se la send è bufferizzata come ad esempio nel protocollo eager e nessuno riceve i dati, allora i dati nel buffer andranno persi. O perchè il programma termina o perchè in generale non verranno mai prelevati dalla memoria.

     4. Se il rank del processo destinatario è uguale a quello del mittente il processo potrebbe bloccarsi, o peggio, abbinarsi ad un messaggio sbagliato. (Questo comportamento può essere usato per inviare messaggi a se stessi ma va usato con attenzione perchè potrebbe portare a dei deadlock.)
  ]
)

== Point-to-Point Communication Modes
`MPI_Send` utilizza il metodo di comunicazione *standard*, decide in base alla grandezza del messaggio se bloccare la chiamata fino alla ricezione da parte del destinatario o di ritornare prima che questo accada, questa seconda opzione avviene solo se il messaggio è piccolo e rende la `Send` *localmente bloccante* ovvero si blocca soltanto per copiare i dati nel buffer interno ma non per attendere una risposta da un altro processo.

Esistono però altri 3 metodi di comunicazione:
- *Buffered*: Funziona sempre con un buffer indipendentemente dalla grandezza del messaggio, l'unica differenza è che il buffer è fornito dall'utente.
- *Synchronous*: L'operazione di `Send` ritorna soltante se il destinatario ha iniziato la ricezione dei dati, è un'operazione *globally blocking*, infatti i due processi si sincronizzeranno nello stesso punto per scambiare i dati senza ulteriori comunicazioni.
- *Ready*: Il mittente invia i dati ma il destinatario deve essere già pronto, ovvero aver già chiamato una `Receive`, in caso contrario la `Send` ritorna un errore. Serve a ridurre l'overhead di handshake tra i due processi. Il lato negativo è che se il destinatario non è pronto alla ricezione l'invio fallisce, i due processi vanno quindi sincronizzati nel modo corretto.

Per utilizzarle hanno questa firma:

```c
int [ MPI_Bsend | MPI_Ssend | MPI_Rsend ] (void *buf, int count, MPI_Datatype datatype, int dest, int tag, MPI_Comm comm);
```

== Non-Blocking Communication
In generale le `Send` non bloccanti rovinano le performance perché il mittente deve fermarsi e aspettare che venga conclusa la copia sul buffer. Le non bloccanti invece permettono di ritornare subito un valore e permettono *comunicazione e computazione* nello stesso momento. Esistono delle varianti non bloccanti, *immediate*, sia per `Send` che per `Receive`.

Un lato negativo è che il processo mittente per poter riutilizzare il buffer in altre comunicazioni deve comunque assicurarsi che i dati inviati siano stati ricevuti correttamente dal destinatario. Per controllare il buffer si utilizzano le operazioni `MPI_Wait` o `MPI_Test`. Anche il destinatario prima di poter utilizzare i dati deve assicurarsi che siano arrivati tutti correttamente, si utilizzano le stesse funzioni.

Vediamo prima la firma delle due operazioni `Isend` e `Irecv`:

```c
int MPI_Isend (void         *buf,     // Address of data buffer
               int          count,    // Number of data items
               MPI_Datatype datatype, // Tipo di dato
               int          source,   // Rank del destinatario
               int          tag,      // Identificatore del tipo di messaggio
               MPI_Comm     comm,     // Comunicatore
               MPI_Request  *req      // Si usa per controllare lo stato della richiesta
               )
```

```c
int MPI_Irecv (void         *buf,     // Address of receive buffer
               int          count,    // Capacità del buffer in items
               MPI_Datatype datatype, // Tipo di dato
               int          source,   // Rank del mittente
               int          tag,      // Identificatore del tipo di messaggio
               MPI_Comm     comm,     // Comunicatore
               MPI_Request  *req      // Si usa per controllare lo stato della richiesta
               )
```

Per controllare lo stato della ricezione o dell'invio utilizziamo quindi:

- *Metodo bloccante*, distrugge l'handle:

```c
int MPI_Wait(MPI_Request *req, // Indirizzo dell'handle con lo stato della richiesta la chiamata lo invalida impostandolo a MPI_REQUEST_NULL
             MPI_Status *st    // Indirizzo della struttura che conterrà le informazioni del comunicatore
            )
```

- *Metodo non bloccante*, distrugge l'handle solo se la comunicazione è avvenuta con successo:

```c
int MPI_Test(MPI_Request *req, // Indirizzo dell'handle con lo stato della richiesta la chiamata lo invalida impostandolo a MPI_REQUEST_NULL
             int         *flag,// Impostato a 1 se andata a buon fine
             MPI_Status  *st   // Indirizzo della struttura che conterrà le informazioni del comunicatore
            )
```

Esistono comunque altre funzioni per testare il successo dell'operazione:
- Waitall
- Testall
- Waitany
- Testany
- ...