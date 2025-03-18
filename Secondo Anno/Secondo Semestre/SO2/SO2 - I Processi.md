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

Da notare che alcune aree di memoria