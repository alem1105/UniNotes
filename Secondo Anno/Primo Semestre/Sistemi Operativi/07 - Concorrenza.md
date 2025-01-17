Come accennato precedentemente, la multiprogrammazione può causare problemi, vediamo quali con la **gestione della concorrenza**.

Per i moderni sistemi operativi é fondamentale l'esecuzione di più processi contemporaneamente e qualsiasi tecnica si usi bisogna affrontare il problema della concorrenza ovvero la gestione del modo in cui questi processi interagiscono fra di loro.

> [!NOTE] Multiprogramming
> Quando si ha un solo processore e i processi si alternano nel suo utilizzo (interleaving)

> [!NOTE] Multiprocessing
> C'è più di un processore e i processi si alternano nell'uso di un processore (interleaving) ma possono anche sovrapporsi nell'uso di vari processori (overlapping), quindi più processi possono trovarsi in esecuzione nello stesso momento.

La concorrenza si manifesta in diverse occasioni:
- Più applicazioni aperte nello stesso momento
- Applicazioni strutturate in modo parallelo, quindi organizzate in thread oppure perché danno vita ad altri processi.
- Struttura del sistema operativo, infatti il SO stesso ha diversi thread e processi in esecuzione parallela.

**Terminologia**:
- Sezione Critica: Parte del codice di un processo dove viene eseguito l'accesso ad una certa risorsa condivisa, questa è la parte di codice che può portare ad una Race Condition.
- Mutua Esclusione: Due o più processi vogliono accedere ad una risorsa (si trovano in una sezione critica che li fa accedere alla stessa risorsa condivisa) ma questa risorsa può essere usata da un solo processo alla volta, quindi o la usa un processo o l'altro. I due processi si escludono a vicenda
- Race Condition (Corsa Critica): Situazione in cui viene violata la sezione critica
- Operazione Atomica: Sequenza indivisibile di comandi, abbiamo visto che il dispatcher può interrompere un processo quando vuole ma in realtà non è sempre così, ci sono alcune operazioni che non possono essere interrotte in qualsiasi momento.
- Deadlock (Stallo): Situazione dove due o più processi sono bloccati perché si stanno "aspettando" a vicenda.
- Livelock (stallo attivo): Situazione dove due o più processi cambiano continuamente il proprio stato, l'uno per rispondere all'altro ma senza concludere nulla di utile.
- Starvation: Un processo, anche se _ready_, non viene mai scelto dallo scheduler.

# Difficoltà Principali
- La principale é che non possiamo fare nessuna assunzione sul comportamento dei processi e su quello dello scheduler, quindi in ogni problema di concorrenza che vedremo dovremo scrivere una soluzione che funzioni sempre, indipendentemente dal comportamento dello scheduler o del processo.

- Condivisione di Risorse
- Gestione dell'allocazione delle risorse condivise
	- Il sistema operativo deve decidere se assegnare una certa risorsa ad un processo che ne fa richiesta. La concorrenza rende impossibile una gestione ottima, ad esempio se ad un processo viene assegnato un I/O e poi il processo viene messo in pausa dal dispatcher come consideriamo quell'I/O, in uso o no?

- Difficile tracciare gli errori di programmazione
	- Questo perché in alcuni casi gli errori dipendono dalle scelte fatte dal dispatcher, quindi se abbiamo ottenuto un errore e vogliamo indagare ripetendo le stesse azioni per riprodurlo potremmo non ottenere lo stesso errore di prima o magari non ottenerne nessuno.

_Esempio - Race Condition_

```c
void echo() 
{
	chin = getchar(); /* Globale */
	chout = chin; /* Globale */
	putchar(chout);
}
```

Facciamo eseguire questo codice a due processi su uno stesso processore:

![[Pasted image 20250117162534.png]]

Notiamo che per il processo P2 tutto é andato come previsto mentre per P1 no, infatti ha ricevuto un carattere me ha stampato quello ricevuto da P2, questo per via delle decisione del dispatcher, infatti se avesse mandato in esecuzione prima tutto P1 e poi tutto P2 il problema non si sarebbe verificato. Vediamo un altro caso con più processori: 

![[Pasted image 20250117162720.png]]

Anche in questo caso P1 stampa il dato ottenuto da P2.

Entrambi i casi sono una **race condition** quindi una violazione della mutua esclusione più nello specifico questa si ha quando:
- Più processi o thread leggono e scrivono su una stessa risorsa condivisa e lo fanno in modo tale che lo stato finale della risorsa dipende dall'ordine di esecuzione di processi e thread. Negli esempi di prima, il valore all'interno di `chin` dipende da l'ultimo processo che esegue l'assegnamento
- Quindi il risultato dipende dal processo o thread che finisce per ultimo

**Come Risolviamo il problema?** 

## Restrizione all'Accesso Singolo

Facciamo in modo che la funzione _echo_ possa essere chiamata da un solo processo per volta, quindi diventa atomica.

In questo modo P1 ci entra per primo e P2 viene bloccato fino al termine di P1.

Per fare questo ci serve un meccanismo per identificare la funzione come atomica.

## Il sistema operativo
Per quanto riguarda il sistema operativo e la concorrenza, questo deve:
- Tenere traccia di diversi processi
- Allocare e deallocare risorse
- Proteggere dati e risorse dall'interferenza non autorizzata di altri processi
- Assicurarsi che processi ed output siano indipendenti dalla velocità di computazione ovvero dallo scheduling (esempio visto sopra.)

# Interazioni tra Processi

![[Pasted image 20250117164319.png]]

- Competizione: I processi pensano di essere soli e non si vedono l'un l'altro, competono quindi per l'utilizzo delle risorse.
- Cooperazione: Processi nati per cooperare, alcuni hanno una memoria condivisa (un processo scrive in una zona di memoria e qualcun altro legge) mentre altri comunicano con delle primitive apposite (più preciso della memoria).

## Problemi principali con la competizione
- Ogni processo pensa solo per sé:
	- Se però ha bisogno di risorse deve chiedere al sistema operativo

Quindi si hanno tre problemi di controllo principali:
- Mutua Esclusione
- Deadlock
- Starvation

## Mutua Esclusione per Processi in Competizione
Prendiamo come competizione l'accesso alla tastiera o al monitor o altri I/O.

La soluzione ottimale é chiamare una syscall che si occupa di tutto, quindi entra nella sezione critica, fa l'operazione ed esce. Ma questo non é sempre possibile, infatti se si vuole accedere ad una risorsa condivisa con altri processi occorre fare una richiesta di bloccaggio della risorsa e si ricade nel caso di processi cooperanti.

Cosa accade quindi? 

![[Pasted image 20250117174407.png]]

La syscall si occuperebbe delle zone _entercritical, critical section e exitcritical_, più nello specifico nella zona entercritical si decide se assegnare la risorsa o rimanere in attesa.

Tutti i processi sono visti come dei cicli che chiedono continuamente accesso a risorse, inoltre come visto prima non deve importare l'ordine di scelta del dispatcher perché **un solo processo deve trovarsi in zona critica**.

## Mutua Esclusione per Processi Cooperanti
In questo caso é lo sviluppatore di questi processi che deve occuparsi della creazione delle syscall, questo però deve appoggiarsi a degli strumenti forniti dal sistema operativo. (Ad esempio i semafori)

## Requisiti per la Mutua Esclusione
Ricordiamo:

> [!info] Deadlock
> Sono due processi che si aspettano a vicenda senza sbloccarsi mai, ad esempio A chiede stampante e poi monitor mentre B il contrario, se lo scheduler manda B in mezzo alle operazioni di A, succede che B blocca il monitor quindi A non può proseguire ma non può proseguire nemmeno B dato che la stampante è bloccata da A.

> [!info] Starvation
> Un processo attende una risorsa senza mai riceverla, in generale non viene mai mandato in esecuzione.

- Solo un processo alla volta può trovarsi nella sezione critica per una risorsa
- Non devono verificarsi deadlock e starvation
- Nessuna assunzione su scheduling dei processi e nemmeno sul loro numero
- Un processo deve entrare subito nella sezione critica se non ci sono altri processi che usano quella risorsa
- Un processo che si trova nella sezione non critica non deve subire interferenze da altri processi, quindi non può essere bloccato
- Un processo che si trova nella sezione critica deve prima o poi uscirci

_Esempi_

```c
int bolt = 0;
void P ( in t i )
{
	while ( true ) {
		bolt = 1;
		while ( bolt == 1) {
			/* do nothing */
		} 
		/* critical section */;
		bolt = 0;
		/* remainder */;
	}
}
```

Immaginiamo che ci siano $n$ processi che eseguono questa funzione $P$, tutti i processi possono quindi leggere e scrivere sulla stessa variabile `bolt` condivisa fra tutti.

Vediamo subito che questa soluzione di impostare una variabile prima della sezione critica non funziona nemmeno con un solo processo, infatti una volta entrato nel secondo `for` il processo andrà in loop senza più sbloccarsi.

Proviamo a invertire la riga del while e la precedente:

```c
int bolt = 0;
void P ( int i )
{
	while ( true ) {
		while ( bolt == 1) {
			/* do nothing */
		} 
		bolt = 1;
		/* critical section */;
		bolt = 0;
		/* remainder */;
	}
}
```

In questo caso sembra funzionare anche con più processi, infatti se `bolt` vale 1 nessun altro processo può entrare nella sezione critica dato che finché non torna a 0 significa che il precedente processo ancora non ha finito.

Però se lo scheduler fa eseguire i 2 processi in interleaving e violiamo la mutua esclusione, se ad esempio un processo supera il controllo del while ma non imposta bolt = 1 e viene mandato in esecuzione un altro processo allora anche questo troverà bolt = 0 e quindi supererà il controllo mandando entrambi i processi nella critical section.

## Scheduler e Livello Macchina
Lo scheduler può interrompere i processi anche in mezzo alle singole istruzioni, quindi a livello macchina.

Prendendo l'esempio precedente, vediamo una possibile violazione che può accadere a livello macchina:

![[Pasted image 20250117195057.png]]

_Slide 26+_ 