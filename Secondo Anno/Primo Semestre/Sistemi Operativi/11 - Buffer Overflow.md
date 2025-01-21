L'area di memoria di un processo caricato in memoria è diviso nelle seguenti sezioni:

![[Pasted image 20250121180452.png]]

# Stack

È costituito da stack frames dove ciascun frame contiene: parametri passati alla funzione, variabili locali, indirizzo di ritorno e instruction pointer.

Lo stack pointer punta alla cima dello stack che sarebbe l'indirizzo più basso, mentre il frame pointer punta alla base del frame corrente.

Cosa succede quando chiamiamo una funzione?

## Chiamata a Funzione
Se ci sono dei parametri questi sono aggiunti allo stack, aggiungiamo anche l'indirizzo di ritorno e il puntatore allo stack frame, viene inoltre allocato spazio ulteriore per variabili locali della funzione.

Immaginiamo questo caso:

```c
void foo ( char * s ) {
char buf [10];
strcpy ( buf , s ) ;
printf ( " buf is % s \ n " , s ) ;
}
...
foo ( " stringatroppolungaperbuf " ) ;
```

Stiamo inserendo troppi dati rispetto alle capacità del buffer ma il computer non sa la dimensione di quest'ultimo dato che per lui sono solo indirizzi di memoria quindi continua a copiare la stringa fino a occuparli tutti, dopo inizia a sovrascrivere qualsiasi cosa trovi finché non completa la richiesta.

Succede quindi questo:

![[Pasted image 20250121181705.png]]

Tra le parentesi sono presenti i valori assunti dagli indirizzi di memoria.

Questo porta alla terminazione del programma -> **Segmentation Fault**, tuttavia però se i dati che finiranno nell'overflow sono preparati in modo adeguato è possibile eseguire codice.

Ad esempio:

```c
void foo ( char * s ) {
char buf [10];
strcpy ( buf , s ) ;
printf ( " buf is % s \ n " , s ) ;
}
...
foo ( " stringatroppolun \ xda \ x51 \ x55 \ x55 \ x55 \ x55 \
x00 \ x00 " ) ;
```

In questo modo abbiamo sovrascritto l'indirizzo di ritorno a nostro piacimento:

![[Pasted image 20250121181912.png]]

Modificare l'indirizzo di ritorno è utile, ma come eseguiamo codice arbitrario?
1) Shellcode
2) Return to libc
3) Stack frame replacement
4) ROP Return Oriented Programming

Gli ultimi due non li vediamo

# Shellcode
È un pezzo di codice che viene eseguito quando si sfrutta una vulnerabilità per attaccare un sistema, deve essere piccolo per rientrare nelle dimensioni del buffer.

Si chiama shell code perché solitamente avvia una command shell dalla quale l'attaccante prende il controllo della macchina.

L'idea di base è inserire codice nel buffer e cambiare il return address con quello del buffer.

_Esempio_

Assumiamo che l'indirizzo di buf sia $0x00005555555551da$, possiamo effettuare l'attacco in questo modo:

```c
void foo ( char * s ) {
char buf [10];
strcpy ( buf , s ) ;
printf ( " buf is % s \ n " , s ) ;
}
...
foo ( " < shellcode >\ xda \ x51 \ x55 \ x55 \ x55 \ x55 \ x00 \ x00
" ) ;
```

![[Pasted image 20250121182247.png]]

In questo modo una volta finita la funzione `foo` il processore salterà all'indirizzo di return ed eseguirà il codice presente in `<shellcode>`.

# Return to libc
Data la piccola dimensione del buffer o altri meccanismi di difesa non è sempre possibile inserire shellcode arbitrario, tuttavia esiste del codice attaccabile e sempre raggiungibile in RAM: le librerie dinamiche e di sistema.

Invece di usare shellcode possiamo inserire come ritorno una funzione di sistema utile per un attacco, infatti si chiama return to libc perché di solito l'indirizzo scelto è quello di una funzione della libreria C.

Possiamo scrivere:

```c
void foo ( char * s ) {
char buf [10];
strcpy ( buf , s ) ;
printf ( " buf is % s \ n " , s ) ;
}
...
foo ( " AAAAAAAAAAAAAAAA < indirizzo di system > AAAA ’
bin / sh ’" ) ;
```

E ottenere:

![[Pasted image 20250121182608.png]]

In questo modo una volta conclusa `foo` il processore salterà all'indirizzo di `system()` e ne eseguirà il codice usando come parametro `bin/sh`

# Contromisure
Esistono due tipi di contromisure che possiamo prendere:
- Difese a tempo di compilazione
- Difese a tempo di esecuzione

## A compilazione
Usare linguaggi di programmazione e funzioni sicure, l'overflow è possibile perché in C ci sono alcune funzioni che spostano dati senza limiti di dimensione.

> **Stack Smashing Protection**

Il compilatore inserisce del codice per generare un valore casuale _canary_ a runtime, questo valore viene inserito fra il frame pointer e l'indirizzo di ritorno, se il valore _canary_ viene modificato prima che la funzione ritorni allora interrompiamo l'esecuzione perché significa che è stato sovrascritto da un possibile attacco.

## Durante l'esecuzione

> **Executable Space Protection**

Il sistema marca le pagine/segmenti dello stack e dell'heap come non eseguibili, quindi se un attaccante cerca di eseguire del codice nello stack il sistema termina con un errore. Questo ci protegge quindi da shellcode ma non da return to libc.

> **Address Space Layout Randomization**

Ad ogni esecuzione gli indirizzi dove vengono caricati i segmenti del programma cambiamo casualmente, quindi se l'attaccante non sa dove si trova lo stack sarà molto più difficile attaccarlo ma anche indovinare l'indirizzo delle librerie standard.
