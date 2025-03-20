In Linux abbiamo detto che ci sono due tipi di entità fondamentali:
- Processi
- File

Quando un file eseguibile è in esecuzione questo prende il nome di processo.

Un esempio di processo sono la maggior parte dei comandi visti precedentemente per il file system, ma non tutti. Ad esempio `echo` e `cd` vengono eseguito internamente al processo della bash ma non sono processi veri e propri.

Lo stesso file può dare vita a più processi infatti non è necessario attendere la terminazione di uno per lanciarne un altro.

> [!info] Ridirezione output
> In Linux possiamo usare i simboli `> <` per redirigere l'output di un comando su un file.
> 
> Ad esempio se eseguiamo `ls > dirlist` andremo a scrivere l'output del comando `ls` nel file `dirlist`.

# Rappresentazione dei Processi
Gli elementi fondamentali per rappresentare i processi sono:
- PID - Process Identifier
- PCB - Process Control Block
- Sei aree di memoria

- PID - È un identificatore univoco di un processo, quindi in un dato istante non possono esistere due processi con lo stesso PID.
- PCB - Questo è unico per ogni processo e contiene varie informazioni:

![[Pasted image 20250318142732.png]]

Per quanto riguarda le aree di memoria abbiamo:
- Text Segment: Le istruzioni da eseguire in linguaggio macchina
- Data Segment: I dati statici inizializzati e alcune costanti di ambiente
- BSS: Dati statici non inizializzati
- Heap: Dati dinamici, vedremo che sono ad esempio quelli allocati con `malloc`
- Stack: Chiamate a funzioni e corrispondenti dati dinamici
- Memory Mapping Segment: Librerie esterne dinamiche usate dal processo.

Da notare che alcune aree di memoria potrebbero essere condivise fra più processi come ad esempio la zona contenente il codice magari condivisa fra più istanze dello stesso processo.

# Stato di un Processo
I processi in Linux possono trovarsi in vari stati:
- Running: In esecuzione su un processore
- Runnable: Pronto per essere eseguito
- Sleep: In attesa di un qualche evento per riandare in esecuzione
- Zombie: Processo terminato ma PCB ancora mantenuto dal kernel perché il padre non ha ancora terminato
- Stopped: Caso particolare di sleeping, ricevuto STOP e in attesa di CONT
- Traced: Esecuzione in debug o in attesa di un segnale, anche questo un particolare caso di Sleep
- Uninterruptible sleep: Come lo sleep ma sta facendo IO su dischi lenti e quindi non può essere interrotto.

# Modalità di Esecuzione di un Processo
Ci sono due modalità:
- **Foreground**: La usano praticamente tutti i processi visti finora, finché il processo non termina la shell non viene restituita e non si possono inviare altri comandi. Il comando può leggere input da tastiera
- **Background**: Il comando non può leggere input da tastiera ma può restituire output. In questo caso la shell viene restituita immediatamente e mentre il processo viene eseguito si possono inviare altri comandi.

- `sleep` comando che ci permette di generare un processo che si mette in pausa per un tempo specificato nell'argomento.

Se usiamo il comando possiamo scegliere la modalità, di base viene lanciato in foreground ma se inseriamo `&` viene lanciato in background.

Quindi ad esempio `sleep 15s &`.

Possiamo visualizzare una lista dei job in esecuzione con `jobs`

---

Alcuni comandi

- `bg` serve a portare un processo in background
- `fg` serve a portare un processo in foreground.
- Ad entrambi forniamo il processo con il numero `n` del job tramite `%n`.

---

Possiamo eseguire un job composto da più comandi contemporaneamente tramite il **pipelining**:
- `comando1 | comando2 | ... comando n`

In questo modo lo standard output del comando $i$ diventa l'input del comando $i+1$. Se invece usiamo `|&` è lo standard error che viene ridirezionato sullo standard input del successivo.

Non siamo comunque obbligati a far prendere come input al comando `i+1` l'output del precedente.

---

Altri comandi

- `ps` mostra le informazioni dei processi in esecuzione dall'utente attuale.
	- `-e` tutti i processi di tutti gli utenti
	- `-u {lista di utenti,}` tutti i processi degli utenti specificati
	- `-p {pid,}` tutti i processi con i PID nella lista specificata
	- `-o {field,}` visualizzare solo alcuni campi

I campi hanno diversi significati:
- PPID: è il parent PID ovvero il PID del processo che ha creato questo processo.
- C: parte intera della percentuale di uso della CPU
- STIME: l'ora o la data in cui è stato invocato il comando
- TIME: Tempo di uso della CPU finora
- CMD: Comando con argomenti
- F: Flags associati al processo
- S: modalità del processo
- UID: Utente che ha lanciato il processo
- PRI: Attuale priorità del processo
- NI: Valore di nice da aggiungere alla priorità
- ADDR: Indirizzo di memoria del processo
- SZ: Dimensione totale del processo in numero di pagine sia in memoria che su disco
- WCHAN: Se il processo è in attesa di un qualche segnale o in sleep

- `top` è un `ps` interattivo:
	- `-b` non accetta più comandi interattivi ma continua a fare refresh ogni pochi secondi
	- `-n num` fa `num` refresh e basta
	- `-p` come in `ps`

Una volta aperto in modo interattivo premiamo `?` per avere una lista dei comandi accettati.

- `kill` invia segnali ad un processo, non solo la terminazione. Con `-l` mostriamo la lista dei segnali

I segnali che invia verranno accettati solo se chi li invia è lo stesso possessore del processo.

Alcuni segnali inviabili:
- `SIGSTOP, SIGSTP` sospensione processo
- `SIGCONT` continuazione di processi stoppati
- `SIGKILL, SIGINT` terminazione processi

Esistono anche alcune combinazioni da tastiera per inviare segnali:
- `CTRL z` invia un `SIGSTOP`
- `CTRL c` invia un `SIGINT`

I segnali `SIGUSR1` e `SIGUSR2`sono impostati per essere usati dall'utente per le proprie necessità, questi consentono una comunicazione fra processi. Ad esempio in un programma P1 possiamo assegnare un pezzo di codice a `SIGUSR1` e se un programma P2 invia un `SIGUSR1` a P1 questo eseguirà quel codice.

---

- `nice [-n num] [comando]`

Se usato senza opzioni dice quant'è il _niceness_ di partenza, questo valore va aggiunto alla priorità del processo e ne aumenta quindi il valore, ovviamente se negativo la diminuisce. Questo varia da -19 a +20 con default a 0.

Serve quindi a lanciare un comando e fornire una valore di niceness.

- `renice priority {pid}`

Si usa su processi già in esecuzione

- `strace [-p pid] [comando]`

Lancia un comando visualizzando tutte le syscall che chiama oppure visualizza le syscall di un processo in esecuzione.

È utile per fare debug di programmi che utilizzano syscall