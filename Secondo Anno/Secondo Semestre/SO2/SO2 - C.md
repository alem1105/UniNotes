Fare fino a slide 45 pdio

C è un linguaggio di alto livello dove i programmi sono un insieme di istruzioni.

Noi scriveremo codice con dei text editor e compileremo da linea di comando, si possono usare anche degli IDE con tutto integrato ovviamente.

# Ambiente di Sviluppo e Esecuzione in C
Per sviluppare programmi in C abbiamo bisogno di un compilatore, in questo caso **gcc (GNU Compiler Collection)**, il compilatore svolge le attività di **pre-processamento, compilazione e linking**.

Nel dettaglio:
1) Tramite un editor di testo scriviamo del codice e lo memorizziamo sul disco.
2) Avviene il pre - processamento, questo processo ha varie funzioni (vedremo più avanti) come ad esempio gestire gli `include`, i condizionali, i commenti e altro, possiamo vederla come una modellazione del codice già esistente.
3) Prende l'output del preprocessamento e genera del codice assembly, quindi codice più vicino alla macchina poi questo viene assemblato e viene generato il codice macchina (zeri e uni) chiamato anche **object code**
4) Linking: Questo prende tutti gli object code generati e li collega in uno unico, collega fra loro anche librerie esterne se le utilizziamo. Di linking ne esistono due tipi:
	- Statico: Il codice esterno viene copiato all'interno del file finale
	- Dinamico: Il codice non viene copiato ma viene semplicemente scritto il nome della libreria a cui fa riferimento.

Adesso si passa all'ambiente di esecuzione:

5) Il loader prende il programma dal disco e lo carica in RAM
6) La CPU esegue tutte le istruzioni quando possibile

# Differenze con Java e Python
La compilazione che avviene in Java tramite javac non produce del codice eseguibile ma un codice interpretabile dalla JVM, questo è il file `.class`. Quindi per eseguirlo questo codice non va dato direttamente al PC ma alla JVM.

Il file che generiamo con gcc invece è un eseguibile che potrebbe essere eseguito anche su altre macchine indipendentemente da gcc, non va ricompilato.

# Struttura di un Programma C
Composto principalmente da due parti:
- Main Function: È il punto da cui parte il programma, quindi può essere dove risiede tutto il codice oppure dove vengono chiamate le altre funzioni.
- Funzioni: Blocchi di codice che svolgono determinate azioni, sono identificate da un nomo univoco.

Queste due componenti possono trovarsi anche all'interno dello stesso file `.c`

## Functions
Ogni funzione è composta da un **header** e un **basic block**

- Header:

```c
<return-type> fn-name (parameter-list)
	basic block
```

- Basic Block:

```c
{
	declaration of variables
	executable statements
}
```

Nel basic block dobbiamo usare il `;`per concludere le righe (statement).

Uno statement importante è il **return**, questo imposta il valore di ritorno di una funzione a chi l'ha chiamata in base ad un'espressione.

```c
int main()
{
	return 0;
}
```

L'espressione può essere una costante, una variabile o altro, es:

- `return 1;`
- `return x;`
- `return 3 * x + 1;`
- `return fact(x);`

## Compilare ed Eseguire
Per compilare eseguiamo il comando

- `gcc -Wall prog-name.c`

Se ci sono messaggi di errore ci verranno stampati a schermo.

Se si includono librerie esterne e vogliamo includerle usiamo `-lm` quindi:

- `gcc -Wall prog-name.c -lm`

In generale come risultato otteniamo un file eseguibile con estensione `.out`, se vogliamo specificare il nome di questo file in fase di compilazione:

- `gcc -Wall prog-name.c -o executable-name.o`

## Precompilazione, Compilazione e Linking
Se vogliamo eseguire soltanto la precompilazione e non eseguire:

- `cpp helloworld.c > precompilato.c`

Questo esegue tutte le direttive del compilatore ed elimina i commenti, fornisce un precompilato.

Se dal precompilato vogliamo effettuare la compilazione:

- `gcc -c precompilato.c -o compilato.o`

Questo controllerà che la sintassi sia corretta, che i tipi stabiliti negli header vengano rispettati, crea il codice macchina delle funzioni. Le chiamate a funzioni avranno una destinazione simbolica finché non eseguiamo il linking.

Se vogliamo effettuare precompilazione + compilazione, quindi entrambe le operazioni precedenti:

- `gcc -c file.c -o file.o`

Infine, per effettuare il linking:

- `gcc file.o`

Questo risolve tutte le chiamate a funzione, quindi ogni chiamata avrà header e blocco di codice. L'inclusione di alcune librerie è automatica, altre vanno specificate dal programmatore.

Il linking può essere eseguito anche su più file contemporaneamente.

## Direttive al preprocessore
Una riga preceduta da `#` è una direttiva destinata al preprocessore, ad esempio:

- `#include filename` dice di includere il contenuto di `filename` al posto della riga.

I file usati in queste istruzioni di solito hanno estensione `.h` e sono detti **header file**

Esempio con altri elementi:

- `#include <stdio.h>`

- `<>` indicano che il file header è un file standard del C
- `""` indicano che il file header è dell'utente e si trova nella directory corrente
- `-I` permette di specificare le directory in cui cercare i file header

# Input e Output
Per mandare in output del testo con C usiamo

- `printf("format string", value-list);`

Dove `value-list` può contenere:
- Sequenze di caratteri
- Variabili
- Costanti
- Espressioni logico matematiche

`printf` riceve dei valori ma in C possiamo manipolare anche indirizzi di memoria, se vogliamo stampare il contenuto di un indirizzo usiamo:

- `scanf`

All'interno del `print` possiamo usare caratteri speciali ad esempio per gestire la spaziatura, sia orizzontale che verticale:

![[Pasted image 20250320115859.png|200]]

# Variabili ed Espressioni
In C come in altri linguaggi usiamo degli indentificatori per nominare le variabili ma non possiamo usare liberamente qualsiasi parola come identificatore, ad esempio:

![[Pasted image 20250320120401.png|300]]

In generale seguiamo delle regole per definire un nome:
- Primo carattere deve essere una lettera o un _ e può essere seguito da lettere o _
- Non iniziare con cifre
- C'è distinzione fra lettere minuscole e maiuscole
- Virgole e spazi non sono consentiti
- Parole chiave (come `return`) non possono essere usate come identificatori
- Lunghezza non superiore a 31 caratteri

## Variabili
Le variabili sono locazioni di memoria dove vengono memorizzati valori, questi possono venire modificati più volte durante il ciclo di vita del programma ma possono contenere un solo valore alla volta.

Le variabili possono essere dichiarate in diverso modo:
- Globali: se dichiarate fuori dalle funzioni
- Parametri: dichiarate nell'header di funzioni
- Locali: all'interno di blocchi di funzioni

Quando le dichiariamo locali possiamo sia dichiarare tutte quelle che useremo all'inizio oppure crearle dal momento in cui ne avremo bisogno.

**Vantaggi** del dichiararle all'inizio
- Convenzione storica del linguaggio
- Dichiarare tutte le variabili nello stesso momento permette al compilatore di allocare tutta la memoria necessaria una sola volta.
- Migliore leggibilità dato che possiamo definire tutto quello che usiamo e il come all'inizio, sappiamo anche dove andarlo a cercare
- Preveniamo gli errori dove usiamo variabili non ancora dichiarate
- Chiarezza del codice senza variabili nel mezzo

**Svantaggi** del dichiararle all'inizio:
- Diventa meno chiaro dove queste variabili vengono utilizzate
- Promuove l'uso di variabili per più scopi che non è una buona abitudine.

E per la dichiarazione vicino al punto di utilizzo?
- Riduce la loro vita il più possibile
- Limita il riuso
- Non mostriamo tutte le variabili in un unico punto

---

 Quando dichiariamo le variabili dobbiamo anche definire il loro tipo, ad esempio:

- `int x; double y; char c;`

È buona norma avere un nome che descrive la funzione della variabile

---

In generale per la dichiarazione si usa la seguente sintassi:

- `optional_modifier data_type name_list`;

Dove per optional modifier abbiamo:
- signed, unsigned
- short, long
- const

data_type:
- specifica il tipo della variabile, questo permette al compilatore di sapere quali sono le operazioni permesse su questo tipo di variabile

name_list:
- lista di nomi di variabili

## Tipi per Numeri

I tipi che possiamo usare per i numeri sono:

![[Pasted image 20250322101121.png|400]]


| Type        | Storage Size | Value Range                   | Precision         |
| ----------- | ------------ | ----------------------------- | ----------------- |
| float       | 4 byte       | 1.2E - 38 to<br>3.4E + 38     | 6 decimal places  |
| double      | 8 byte       | 2.3E - 308 to<br>1.7E + 308   | 15 decimal places |
| long double | 10 byte      | 3.4E - 4932 to<br>1.1E + 4932 | 19 decimal places |

---

## Caratteri
Per i caratteri si usa il tipo `char`, questi occupano 1 byte e possiamo rappresentare tutti i caratteri ASCII

## Boolean
Il tipo `_Bool` può memorizzare soltanto 0 ed 1, qualsiasi cosa diversa da 0 viene considerata 1.

Il tipo `bool` che richiede `<stdbool.h>` memorizza true e false.

In generale 0 corrisponde a false e 1 a true.

## Assegnazioni di valori
Se dichiariamo una variabile e non la inizializziamo ad un valore questa assume un valore indeterminato.

In generale l'assegnazione di un valore possiamo farla o in fase di dichiarazione:
- `int x=3, y=2`

Oppure durante l'esecuzione sempre usando l'operatore `=`.

## Output di variabili
Tramite `printf` possiamo scrivere il valore di una variabile:
- `printf(format_string, expression_list)`

Dove `format_string` deve contenere dei "placeholder", questi iniziano con `%` e indicano il tipo e quale variabile andrà al loro posto, es:
- `printf("%d, %l", integerVariable, longVariable);`

Tipi per i placeholder:
- `%d, %i` Integer
- `%l` long
- `%x` per integers in esadecimale
- `%o` integers in ottale
- `%f, %e, %g` float, nello specifico:
	- `f` formato standard
	- `e` notazione scientifica
	- `g` automatico
- `%lf` per double

## Scanf
Vedere scanf e altre funzioni, non so se scrivo tutto dato che sono cose base anche di altri linguaggi.
