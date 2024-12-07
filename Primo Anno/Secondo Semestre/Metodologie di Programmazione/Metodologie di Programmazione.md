# Qualcosa su Java

Java è orientato alla **programmazione ad oggetti**, ogni oggetto:
- Ha uno stato, ovvero i suoi campi
- Ha la possibilità di compiere azioni
- Appartiene a una **classe** che ne indica il tipo
## Incapsulamento
Tramite questo metodo andiamo a nascondere i dettagli di un oggetto che non devono essere manomessi ed esponiamo soltanto quello che noi vogliamo.
- **L'Interfaccia** è la parte visibile ovvero i _metodi pubblici_.
- **L'Implementazione** è quello che manteniamo privato quindi _campi e metodi privati_.
## Ereditarietà
Questo concetto è molto utile per favorire il riutilizzo del codice, una classe madre condivide parte del codice con le sue classi figlie andando ad evitare la riscrittura del codice e la propagazione di errori.

Si forma una **gerarchia di classi**:

![[Pasted image 20240302195743.png]]

> [!info] Extends Impliciti
> In Java qualsiasi classe che creiamo, anche se non estende nessuna classe, in modo implicito estende la classe **Object**, da cui eredità alcuni metodi come `getClass, hashCode, equals`. 

## Polimorfismo
Permette di utilizzare lo stesso codice a oggetti di tipo diverso ma che condividono una classe madre.
In questo modo possiamo utilizzare il codice della classe madre "generica" senza conoscere necessariamente la classe specifica, se prendiamo l'esempio di prima possiamo creare una lista di _Forme_ che contiene nello stesso momento oggetti di tipo _Cerchio, Triangolo e Rettangolo_, inoltre ne potremmo aggiungere delle altre successivamente senza problemi.
Allo stesso modo ogni chiamata ad un metodo invoca la sua implementazione più specifica, ad esempio il metodo _calcolaArea()_ se chiamato su oggetti di tipo _Cerchio, Triangolo o Rettangolo_ si comporterà in modo diverso, ma è comunque disponibile per tutti gli oggetti di tipo _Forma_.

## Info
- Come detto prima, Java è **orientato** agli oggetti ma **non** a oggetti, ci sono anche altri elementi
- È **cross - platform** (WORA - Write Once, Run Anywhere)
- È **compilato** in bytecode e **interpretato** da una macchina virtuale, queste caratteristiche lo rendono indipendente dalla piattaforma.
  Il codice che noi scriviamo è all'interno di file _.java_ questi vengono inviati al compilatore **Javac** che li trasforma in file _.class_ contenenti un codice comprensibile alle **JVM (Java Virutal Machine)** installate sui dispositivi, la JVM è dotata di un compilatore chiamato **JIT (Just in Time)** che interpreta il bytecode e lo trasforma in linguaggio comprensibile al calcolatore.

# Tipi Primitivi
I tipi primitivi sono **built - in** in Java, li possiamo identificare anche da come sono scritti infatti vengono indicati con l'iniziale minuscola, diversi appunto dalle **classi derivate** che identifichiamo con l'iniziale maiuscola.
Alcuni esempi di questi sono:
- **int** - Interi
- **double** - numeri reali
- **boolean** - valori booleani
- **char** - un carattere
- **String** - un "insieme" di caratteri, anche se indicata con la maiuscola viene comunque classificate come tipo primitivo.
I tipi permettono anche delle operazioni con comportamento diverso a seconda di esso, ad esempio una somma fra interi esegue una semplice somma algebrica, mentre una somma tra stringhe esegue un concatenamento di queste due.

# Variabili
Le variabili sono dei nomi che utilizziamo per riferirci a dei valori, queste devono essere dichiarate ed assegnate.

```java
int numero; // tipo nome | Dichiarazione
numero = 5; // nome = valore | Assegnazione

int numero2 = 10; // Si può fare anche tutto su una sola riga
```

È possibile dichiarare una variabile senza assegnarle un valore, questa rimane appunto indefinita.

> [!info] Scelta dei nomi e CamelCase
> In Java ma in generale nella programmazione si cerca di dare nomi con significato alle variabili, quindi che spieghino cosa contiene e a cosa serve quel valore.
> Inoltre in Java si cerca di utilizzare la CamelCase (Notazione a cammello) quindi:
> - Il nome delle classi ha iniziale maiuscola
> - Il nome delle variabili ha iniziale minuscola

## Letterali
Per letterale si intende la rappresentazione in codice sorgente del valore di un tipo di dato

![[Pasted image 20240821125614.png|500]]

Quindi li possiamo riconoscere dai loro prefissi o suffissi.

## Espressioni
Un'espressione è un letterale, una variabile o una sequenza di operazioni su letterali e / o variabili che producono un valore.

```java
42 * (x - 2) + y
```

In Java le operazioni hanno delle precedenze, prima vengono eseguite _moltiplicazioni, divisioni, resti (%)_ poi _somme, differenze_.

## Conversioni di tipo
Esistono diversi tipi di conversioni:
- **Conversione Esplicita**: Utilizzando un metodo che prende in ingresso un argomento di un tipo e restituisce un valore di un altro tipo, ad esempio i metodi _Integer.parseInt(), Double.parseDouble(), Math.round() ecc..._.
- **Cast Esplicito**: Si scrive il tipo desiderato prima del valore e tra le parentesi, quindi scrivendo ad esempio `(int) 3.14` otteniamo un valore intero uguale a 3.
  In questo caso dato che il tipo di partenza era più preciso (double) sono state eliminate le informazioni aggiuntive nel modo più ragionevole, in questo caso togliendo la parte frazionaria.
- **Cast Implicito**: Avviene quando forniamo un valore meno preciso rispetto al tipo dichiarato, Java converte automaticamente al valore più preciso.
  Ad esempio `double num = 2`, abbiamo fornito un intero ad un double, verrà convertito in `2.0`.

### Regole per il cast implicito
Questo tipo di cast può avvenire o in fase di **assegnazione** ad esempio da _int_ a _long_ o da _float_ a _double_ oppure in fase di **calcolo di un'espressione**, se è presente un operando double infatti questa viene convertita in double, un altro esempio è se è presente una stringa, infatti in questo caso viene effettuato il cast a string e vengono concatenate.

# Classi e Oggetti
Una classe è quel pezzo di codice che descrive i campi ed i metodi di un oggetto, viene definita dal programmatore, un oggetto quindi non è altro che un'istanza di una classe.
In Java esistono delle classi già implementate in delle **librerie**, si possono trovare anche online scritte da altri programmatori.
Queste sono organizzate in **package** alcuni presenti in Java sono: `java.util, java.awt, javax.swing, javafx, java.lang`.

## Campi e metodi
I campi costituiscono la memoria di un oggetto, sono delle variabili e hanno quindi un tipo e un nome. Di solito si definiscono privati all'interno della classe.
I metodi invece sono tipicamente pubblici e restituiscono i valori privati dei campi (o operazioni con essi), per convenzione i nomi iniziano con lettera minuscola e poi le parole seguenti con lettera maiuscola.
Se un oggetto o un metodo viene definito **statico** significa che è in comune fra tutti gli oggetti di quella classe.

## Costruttore
Il costruttore è un metodo speciale all'interno di una classe dato che serve a creare gli oggetti, ha il nome uguale a quello della classe, non restituisce nessun valore e all'interno di una classe ce ne può essere più di uno, di solito con parametri diversi.
Di solito all'interno di questo vengono inizializzati i campi dell'oggetto.

> [!info] Campi e Variabili locali
> I campi sono visibili solo all'interno dell'oggetto ed esistono per tutta la sua durata di vita mentre le variabili locali vengono definite all'interno di un metodo o come parametri, una volta terminata la sua esecuzione queste non esistono più.

## Overloading
Accade quando abbiamo metodi con lo stesso nome ma che hanno parametri in input diversi, possiamo utilizzarlo quindi per metodi che svolgono operazioni simili, i metodi vengono chiamati come sempre ma basta fornire il giusto tipo di parametri per chiamare la definizione corretta.

## Modificatori di visibilità
I campi e metodi di una classe possono essere **pubblici, privati o protetti**, i metodi di una classe possono chiamare sia metodi che campi pubblici o privati della stessa classe, mentre possono chiamare soltanto quelli pubblici di altre classi.

## Oggetti vs Valori Primitivi
Per i valori primitivi la memoria utilizzata è allocata automaticamente a tempo di compilazione mentre per gli oggetti la memoria viene allocata nel momento in cui vengono creati in tempo di esecuzione, inoltre non hanno una dimensione fissa ma lo spazio occupato dipende dai loro campi.
In un oggetto a differenza delle variabili locali, i campi vengono inizializzati a dei valori predefiniti, ad esempio i booleani a false, i valori numeri a 0 e oggetti a null.

## Riferimenti ad oggetti
Quando assegniamo un oggetto ad una variabile questa non conterrà l'oggetto ma un **riferimento** ad esso, ovvero l'indirizzo di memoria RAM che lo contiene.

## Metodi Static
Sono dei **metodi di classe** e non **metodi di istanza**, questo significa che possono accedere soltanto ai campi statici (di classe) e non agli oggetti specifici, infatti non è possibile chiamarli tramite degli oggetti.

# Stack e Heap
Nello stack vengono allocate le variabili locali e anche i frame di attivazione dei metodi, questi spazi di memoria vengono impilati quindi l'ultimo a venire chiamato è il primo a essere chiuso.
Nell'heap vengono allocati dinamicamente gli oggetti ovvero i loro campi, questo oggetto sarà puntato da una variabile presente nello stack.
I campi di tipo **static** vengono allocati in uno spazio diverso chiamato **metaspace**, questi sono allocati prima di tutti gli altri nel momento della creazione di un oggetto, ovviamente dato che sono in comune questo processo avviene soltanto per il primo oggetto di quella classe.
Quando un oggetto nell'heap non viene più puntato da nessuna variabile, questo viene eliminato dal **garbage collector** in un momento casuale.

# Condizionali (sono gli IF daaaaaai)

# Iterative (while, do while, for)

# Array
Gli array sono una sequenza di elementi dello stesso tipo (sia primitivi che oggetti).
Per accedere ad un elemento dell'array dobbiamo specificare il suo indice all'interno della sequenza, non si possono fornire indici maggiori o minori della lunghezza dell'array altrimenti andiamo in contro ad un errore.
Se vogliamo modificare le dimensioni di un array possiamo soltanto creare un nuovo array e copiare gli elementi del vecchio tramite il metodo static `Arrays.copyOf()`.

## Matrici
Rappresenta un array bidimensionale, per accedere quindi agli elementi è necessario fornire due indici, possiamo "visualizzarli" come delle tabelle con righe e colonne.
# Metodi con numero di parametri variabile
Se vogliamo passare un numero non preciso di parametri ad un metodo per prima cosa questi devono essere tutti dello stesso tipo e vanno dichiarati come ultimi parametri tramite la dicitura:

```java
public double sum(double... valori) {
	double somma = 0;
	for (int k = 0; k < valori.length; k++) {
		somma += valori[k];
	}
	return somma;
}
```

Quindi la variabile _valori_ viene considerata a tutti gli effetti un array.

# Enumerazioni
Sono delle classi speciali nelle quali possiamo definire dei valori tramite degli **identificatori univoci**, ognuno di questi corrisponde ad una costante che costituisce un riferimento ad un oggetto dell'enumerazione, infatti non si possono creare altri oggetti di tipo enum con il costrutto _new_.

```java
public enum Seme {
	CUORI, QUADRI, FIORI, PICCHE
}
```

All'interno di queste è possibile definire costruttori e metodi:

```java
public enum Mese {
	GEN(1), FEB(2), MAR(3), APR(4), MAG(5);
	private int mese;

	Mese(int mese) {
		this.mese = mese;
	}
	public int toInt() { return mese; }
}
```

Il costruttore viene invocato implicitamente dalle costanti e non può essere invocato al di fuori dell'enum.
Nell'esempio di prima abbiamo assegnato ad ogni costante di tipo Mese un valore intero.
Le enum ci forniscono dei metodi già implementati:

**Metodi Statici**
- **values()**: Restituisce l'array delle costanti enumerative.
- **valuesOf(v)**: Restituisce l'oggetto corrispondente al nome della costante fornito dalla Stringa _v_.

**Metodi non Statici**
- **ordinal()**: Restituisce la posizione intera di una costante nell'enumerazione.
- **toString()**: Chiamato su una costante restituisce il suo nome come Stringa.
- **name()**: Restituisce il nome della costante su cui è invocato.
La differenza fra gli ultimi due metodi è che _name_ è un metodo final e quindi non può essere sovrascritto mentre _toString_ si, inoltre se ci serve una rappresentazione a Stringa del nome meglio chiamare _toString_ mentre se abbiamo bisogno del nome vero e proprio chiamiamo _name_.

Per confrontare le enum è consigliato **usare `==`**.

# Classi Wrapper
Queste classi "involucro" ci permettono di convertire in oggetto i valori di un tipo primitivo fornendo anche dei metodi utili ad accesso, visualizzazione e operazioni del dato.
Le distinguiamo dal fatto che iniziano con una lettera maiuscola o in alcuni casi hanno un nome diverso, ad esempio _int -> Integer_, gli oggetti ottenuti da queste classi sono **immutabili** e quindi hanno i campi non modificabili.
Per creare questi oggetti si utilizzano metodi statici come _valueOf_ che dato un valore intero restituiscono il corrispondente oggetto Integer.

# Confronti

- **`==`**: si utilizza per confrontare l'**identità**, ci si confrontano tipi primitivi oppure i **riferimenti** agli oggetti e non gli oggetti stessi.
- **equals**: Confronto logico, confronta i campi degli oggetti quindi è utilizzabile per quest'ultimi.
- **compareTo**: Serve a comparare due oggetti, restituisce un intero, 0 se i due oggetti sono uguali, < 0 se il primo è minore del secondo e > 0 se il primo è maggiore del secondo.

# Autoboxing e Auto - unboxing
L'autoboxing avviene quando un tipo primitivo viene convertito automaticamente nel suo wrapper associato:

```java
int[] a = { 1, 2, 3 }; // Valori primitivi
Integer[] b = { 1, 2, 3 }; // Riferimenti ad oggetti
```

L'autounboxing invece avviene quando un tipo wrapper è convertito automaticamente nel suo primitivo:

```java
Integer[] b = { 1, 2, 3}; // Riferimenti ad oggetti
int k = b[2]; // Viene inserito un oggetto in un valore primitivo
```

# Costo di un oggetto in memoria
Il costo di base per varie informazioni di ogni oggetti è di **8 byte**, poi vengono aggiunti dei byte addizionali **per i campi** e se necessario dei byte per il **padding** ovvero dello spazio inutilizzato che serve a rendere la dimensione dell'oggetto un multiplo di 8 (necessario per allocarlo in memoria)

_Esempi:_

**INTEGER** = 8 byte + 4 byte int = 12 byte non è multiplo di 8 quindi + padding (4) = 16 byte
**STRING** = 28 + 2 * numeroCaratteri byte

> [!info] Memoria
> Di solito in sistemi da 64 bit si utilizzano appunto 64 bit per memorizzare i puntatori, anche perchè questi sistemi hanno accesso a grandi quantità di memoria, però per piccole applicazioni che non richiedono molta memoria avere riferimenti da 64 bit è uno spreco di spazio, in Java si è trovata come soluzione i **Compressed oop (ordinary object pointer)**.
> Questi indirizzi vengono salvati in 32 bit e poi moltiplicati per un fattore di scala (solitamente 8 dato che la memoria in Java è allineata ogni 8 bit) per ricostruire l'indirizzo da 64, in Java questa tecnica è utilizzata per memoria da 4Gb fino a 32Gb, questo perchè superando in 32Gb la compressione non è più efficiente.
> Questo perchè con i C. oop abbiamo un limite alla quantità di indirizzi rappresentabili di 2^32 e dato che il fattore di scala è 8 abbiamo una dimensione massima di 4Gb * 8 = 32Gb.
> Se si superano i 32Gb abbiamo due soluzioni, o cambiamo fattore di scala perdendo però accesso a molti indirizzi oppure passare a indirizzi da 64 bit ma che per oggetti piccoli risulta solo in uno spreco di spazio.

# Ereditarietà
Permette molto riutilizzo del codice tramite la "condivisione" di membri di una classe e aggiunta di funzionalità a questi.
Quando una **sottoclasse estende** una **superclasse** ne eredita i membri d'istanza secondo i modificatori di accesso indicati, inoltre hanno la possibilità di aggiungere campi o metodi

## Classi Astratte
Sono classi con le quali non possiamo creare oggetti, di solito vengono estese da altre classi che possono invece essere istanziate.
All'interno di queste classi possiamo definire **metodi astratti** che non hanno implementazione, le sottoclassi sono **obbligate** a fornirne una, l'unico caso in cui non lo sono è quando sono anche esse astratte.

Quando definiamo una classe con un costruttore non vuoto le sue sottoclassi devono necessariamente chiamarlo tramite **super** nel loro costruttore, se invece non ci sono parametri i costruttori possono anche essere lasciati vuoti impliciti.

## Overriding
L'overriding avviene quando all'interno di una sottoclasse sovrascriviamo l'intera implementazione di un metodo della superclasse lasciando però la stessa intestazione, dobbiamo lasciare gli stessi argomenti, un tipo di ritorno compatibile e non dobbiamo cambiare il livello di visibilità.

## Livelli di Visibilità
 - **private**: visibile solo all'interno della classe
 - **public**: visibile a tutti
 - **deafult**: visibile all'interno di tutte le classi del package (viene assegnato se non specificato un altro livello)
 - **protected**: visibile dalle sottoclassi e dalle classi dello stesso package

## Relazioni

**is - a**: Si tratta di ereditarietà, un oggetto di una sottoclase può essere trattato come oggetto della superclasse.
**has - a**: (Composizione) un oggetto contiene come campi dei riferimenti ad altri oggetti.

# Polimorfismo
Una variabile di un certo tipo _A_ può contenere un riferimento ad un oggetto di tipo _A_ o di qualsiasi sua sottoclasse, se sono presenti degli override dei metodi la selezione di quale invocare avviene in base all'effettivo tipo dell'oggetto, questo è utile per poter utilizzare senza differenze degli oggetti diversi ma con delle caratteristiche in comune attraverso i metodi della superclasse.

_Esempio:_

```java
Animale a = new Cane();
a.emettiVerso(); // "bau bau"
a = new Gatto();
a.emettiVerso(); // "miao"
```

## Binding
Esistono due tipi di binding:
- **statico**: A **tempo di compilazione** si sceglie il metodo da invocare per una data variabile in base al suo tipo, questo avviene per i metodi **final, statici e privati** dato che non permettono Override.
- **dinamico**: È implementato dal polimorfismo, viene eseguito a **tempo di esecuzione** e si controlla il tipo dell'oggetto riferito alla variabile in quel momento e si invoca il metodo con il livello di specializzazione più alto. Viene chiamato dunque sui metodi di istanza.


## Operatori
**istanceof**: Restituisce true se l'oggetto sui cui è applicato è un tipo o sottotipo della classe specificata
**getClass**: Restituisce la classe dell'oggetto sottoforma di oggetto _Class_.

# Casting

## Upcasting
Si può convertire un sottotipo ad un supertipo **senza cast esplicito**, in questo modo andiamo a restringere l'interfaccia dell'oggetto alla superclasse, questo significa che non avrà accesso a tutti i suoi campi e metodi più specifici.

## Downcasting
Per convertire invece un supertipo ad un sottotipo è necessario un **cast esplicito**, se poi il tipo specificato non corrisponde a quello dell'oggetto viene sollevata un'eccezione.

> [!info] Oggetto in memoria
> L'oggetto in memoria rimane sempre dello stesso tipo, è la variabile che contiene il suo riferimento a svolgere il lavoro di "filtro".

Da notare che è comunque possibile creare una variabile del tipo di una classe astratta e assegnargli un oggetto del tipo di una sua sottoclasse, sempre grazie al polimorfismo.

# La superclasse Object
Tutte le classi presenti in Java ereditano direttamente o indirettamente dalla classe Object, i metodi che ereditano sono:

- **clone()**: Restituisce una copia dell'oggetto, per chiamare questo metodo è necessario implementare l'interfaccia _segnaposto_ **Cloneable**.
  Il clone crea un oggetto uguale dal punto di vista dei campi ma diverso sulla memoria, inoltre effettua una **shallow copy** ovvero una copia campo per campo, se uno di questi è un riferimento ad un altro oggetto allora dovrà essere **Cloneable** anche lui altrimenti la shallow copy copierà il suo riferimento.
  Se tutti sono cloneable abbiamo effettuato una **deep copy**.

# Metodi e classi Final
Un metodo dichiarato final **non può essere sovrascritto** da altri metodi mentre una classe final **non può essere estesa** da sottoclassi. (ad esempio le classi wrapper)

# Liste
Sono delle classi che permettono la memorizzazione di sequenze di dimensioni variabili (dinamiche), ad esempio le classi _ArrayList e LinkedList_.

## ArrayList
Implementa tramite un Array una lista ad accesso casuale di dimensione variabile (se non specifichiamo una capienza iniziale di base è 10).
Il tipo degli elementi contenuti nella lista deve essere un **tipo derivato** e quindi **primitive**, al posto di queste possiamo usare le classi Wrapper se necessario

## LinkedList
Rappresenta una lista linkata in cui ogni elemento contiene il proprio valore e in aggiunta un riferimento al successivo, possiamo utilizzarla come uno **stack**.

# Interfaccia
Le interfacce sono uno strumento fornito da Java per risolvere il problema dell'**ereditarietà multipla** infatti non è possibile estendere più di una classe ma è possibile implementare più di un'interfaccia. (Non si possono ereditare più classi per il **problema del diamante** ovvero la duplicazione ambigua di campi e metodi).
Per questa loro proprietà quindi se più classi implementano la stessa interfaccia non significa che abbiano una relazione simile a quella dell'ereditarietà, le interfacce infatti definiscono soltanto i metodi privi di implementazione che dovranno essere poi implementati nelle classi.
Nelle interfacce tutti i metodi **sono implicitamente astratti e pubblici** inoltre da Java 8 in poi è possibile definire dei metodi di default, ovvero che hanno anche un'implementazione fornita dall'interfaccia.

Le interfacce possono contenere anche dei campi, **implicitamente statici e costanti** e **estendere altre interfacce**.
Sempre grazie al polimorfismo possiamo assegnare ad una variabile del tipo di un'interfaccia un oggetto di una classe che la implementa, se chiamiamo un metodo verrà chiamato l'override della classe ma la visibilità dei metodi è ridotta a quelli dell'interfaccia.

Una classe che implementa un'interfaccia deve fornire un'implementazione di tutti i metodi a meno che non sia astratta, se una classe implementa molteplici interfacce e dovesse ereditare lo stesso metodo con implementazione di default, dovrà necessariamente reimplementarlo.

## Iterable ed Iterator
Molte classi presentano una sequenza di valori che hanno la proprietà di iterare su questi.
Tutte implementano l'interfaccia **Iterable** dotata di un unico metodo **iterator()** il quale restituisce un oggetto che implementa **Iterator**, quest'ultima interfaccia è dotata di 3 metodi **hasNext(), next(), remove()**.

## Interfaccia ListIterator
Estende Iterator ed è specifica per le liste, il suo metodo **listIterator()** restituisce un iteratore **bidirezionale**, utilizzabile con i metodi **hasPrevious(), previous()** e **hasNext(), next()**.

## Interfacce notevoli

- **Comparable**: Impone un ordinamento degli oggetti tramite il metodo **compareTo(T b)** che restituisce un intero >, = o < di 0 rispettivamente se l'oggetto su cui è stato chiamato è maggiore uguale o minore di quello passato _b_.
- **Cloneable**: Si deve implementare il metodo **clone()**, in questo modo il clone di object capisce che è possibile effettuare una copia campo a campo.
- **Serializable**: Come cloneable è un'interfaccia _segnaposto_ e serve ad indicare al compilatore che l'oggetto è **serializzabile** ovvero salvabile in memoria su un file.

> [!info]
> È possibile utilizzare anche l'interfaccia **Comparator** al posto di comparable, questa ha anche dei metodi di default come **thenComparing** che ordina secondo un altro ordinamento nel caso in cui il primo fornisca un valore di uguaglianza.

# Passare funzioni in input tramite interfacce
Le interfacce con un solo metodo sono definite **interfacce funzionali**, ad esempio l'interfaccia comparator richiede l'implementazione soltanto del metodo **compare** e può quindi essere passata come parametro a **Collection.sort()**.

# Classi annidate e interne
Differenziamo prima di tutto due tipi di classe:

- **Classi TOP - LEVEL**: Sono classi non contenute in altre classi, queste richiedono quindi un file _.java_ dedicato a loro.
- **Classi NESTED**: Sono classi annidate all'interno di altre classi, queste possono essere definite _static_ oppure _non static_ e vengono chiamate **classi INNER** o **INTERNE**.

Una classe annidata interna (non statica) viene quindi definita all'interno di un'altra classe e contiene **implicitamente** un riferimento all'istanza della classe esterna che deve **esistere prima della sua istanziazione**, questa può accedere a tutti i campi e metodi della classe esterna.
Quando vogliamo disambiguare dei campi all'interno della classe interna possiamo utilizzare _this_ mentre per riferirci a campi esterni possiamo utilizzare _ClasseEsterna.this_, inoltre per istanziare un oggetto della classe interna da un'altra classe si utilizza _oggettoClasseEsterna.new ClasseInterna()_.

Se invece la classe annidata viene definita statica (non interna) allora non sarà legata alla classe esterna, infatti non potrà accedere ai suoi campi privati, l'unica differenza è quindi che vi si potrà accedere tramite il nome della classe esterna come visto prima.
Non è quindi necessario avere un'istanza dell'esterna per istanziare l'interna.

# Classi Anonime
Sono classi prive di nome che implementano un'interfaccia o estendono una classe.
Vengono utilizzate in un unico punto del codice e servono a definire velocemente del codice compatto che non verrà riutilizzato.

_Esempio_

```java
public interface Formula {
	double calculate(int a);
	default double sqrt(int a) { return Math.sqrt(a); }
}

Formula formula = new Formula() {
	@Override
	public double calculate(int a) {
		return sqrt(a * 100);
	}
}

// Da Java 8 è possibile utilizzare le lambda
Formula formula = a -> Math.sqrt(a*100);
```

In questo esempio l'interfaccia Formula richiede di implementare il metodo _calculate_, possiamo quindi creare un oggetto e definire l'implementazione del metodo in un unico blocco.
Abbiamo creato un oggetto di un tipo anonimo che implementa Formula.

# Interfacce Funzionali
Sono delle interfacce che espongono un solo metodo astratto, sono chiamate anche di tipo **SAM**, è consigliato marcarle tramite l'annotazione **@FunctionalInterface**.

## Espressioni Lambda
È un metodo che si utilizza per definire funzione in modo compatto ovvero su un'unica linea, queste espressioni lambda creano delle **funzioni anonime** ovvero degli oggetti virtuali **non stanziati nell'heap** che possono essere assegnati a riferimenti di interfacce funzionali compatibili con la funzione creata, questo significa che la funzione che creiamo deve rispettare i parametri in input e i tipi in output dell'unico metodo che l'interfaccia richiede.

_Esempio_

```java
@FunctionalInterface
public interface FunzioneMatematica {
	int calcola(int x, int y);
}
```

Quindi l'interfaccia richiede un solo metodo, questo metodo ha bisogno di due parametri interi e deve restituire un intero, possiamo quindi scrivere tramite una funzione lambda:

```java
FunzioneMatematica somma = (int x, int y) -> { return x + y; };
FunzioneMatematica prodotto = (int x, int y) -> { return x * y; };

System.out.println(somma.calcola(2, 5)); // 7
System.out.println(prodotto.calcola(2, 5)); // 10
```

Esistono inoltre delle sintassi semplificate per le lambda:

- Possiamo omettere i tipi in input dato che sono già specificati nell'interfaccia.
- Se il corpo della funzione è una singola istruzione possiamo omettere le parentesi graffe.
- Se restituire un singolo valore possiamo omettere anche il return.
- Se in input abbiamo un singolo parametro possiamo omettere le parentesi tonde

Per l'esempio di prima avremmo potuto anche scrivere:

```java
FunzioneMatematica somma = (x, y) -> x + y;
FunzioneMatematica prodotto = (x, y) -> x * y ;

System.out.println(somma.calcola(2, 5)); // 7
System.out.println(prodotto.calcola(2, 5)); // 10
```

È possibile utilizzare anche i tipi generici con le interfacce:

```java
@FunctionalInterface
public interface Converter<F, T> {
	T convert(F from);
}

// main
Converter<String, Integer> converter = from -> Integer.valueOf(from);
Converter<String, MyString> stringConverter = a -> new MyString(a);
```

## Classi Anonime vs Espressioni Lambda

**Classi Anonime**: il **this** si riferisce all'oggetto anonimo della classe estesa, inoltre vengono compilate come delle classi interne quindi gli oggetti vengono comunque istanziati nell'heap ma non hanno un tipo definito.

**Espressioni Lambda**: il **this** si riferisce all'oggetto della classe esterna in cui è usata, vengono compilate come dei metodi privati quindi non vanno sull'heap, c'è un meccanismo della JVM che lega una variabile ad un'espressione lambda.
Inoltre un'espressione lambda ha accesso alle variabili esterne come una classe anonima, possiamo quindi accedere a:
- variabili statiche
- campi d'istanza
- variabili final del metodo che definisce la lambda
- variabili del metodo esterno **implicitamente final** (quelle variabili che non vengono mai modificate anche se non final)

## Interfacce funzionali notevoli

### Function < T1, T2 >
Ha un tipo di ingresso (T1) e un tipo di ritorno (T2), bisogna implementare il metodo **apply** che definisce la funzione

### BiFunction < T1, T2, T3 >
Ha due parametri e un tipo di ritorno, funzionamento uguale alla function.

### Metodi di default
- **andThen(funzione)**: ritorna una funzione composta che applica la funzione su cui lo invochiamo e successivamente quella che abbiamo passato in input.

```java
Function<String, String> backToString = toInteger.andThen(toString);
```

**backToString** è quindi una funzione che ne applica 2, prima la funzione **toInteger** e poi **toSting**.

- **compose(funzione)**: Ritorna una funzione composta che applica la funzione in input e poi la funzione specificata dalla sua interfaccia.
- **identity()**: ritorna la funzione identità che ritorna sempre il suo parametro.

### Predicate \<T\>
È una funzione che ha un parametro e ritorna un booleano.
Anche questa ha deti metodi di default:

- **negate()**: restituisce un altro predicate che nega il risultato del predicate su cui è invocato.
- **and(predicate)**: restituisce l'**and** tra il predicate su cui è invocato e quello passato come parametro.
- **or(predicate)**: restituisce l'**or** tra il predicate su cui è invocato e quello passato come parametro.
- **isEqual(oggetto)**: restituisce il predicate che testa se l'oggetto su cui è invocato è _equals_ a quello in input

### BiPredicate <T1, T2 >
Funziona come il predicate ma ha due paraemtri in input.

### Supplier \<T\>
Una funzione con un tipo di ritorno ma private di parametri, ad esempio i costruttori delle classi, infatti possiamo riferirci a questi come _supplier_ attraverso **NomeClasse::new**, ovviamente se il costruttore è privo di parametri.
Utilizza il metodo **T get()**.

### Consumer \<T\>
Il contrario del supplier, infatti non ha tipo di ritorno ma ha un tipo di parametro in input, utilizza il metodo **void accept(T o)**.

```java
Consumer<Persona> greeter1 = p -> System.out.println("Hello, " + p.firstName);
greeter1.accept(new Person("Luke", "Skywalker"));
```

I consumer vengono utilizzati nel metodo **ForEach**, è un metodo delle Collection che vuole come input un **Consumer\<? super T\>** dove T è il tipo generico della collection, applica il consumer a tutti gli elementi.

### BiConsumer\<T1, T2\>
Il suo metodo **accept()** vuole due parametri in input ma restituisce sempre un void.

# Strutture Dati
Le strutture dati servono a memorizzare e organizzare i dati in memoria in modo da poterli utilizzare in modo più efficiente, in Java possiamo trovare alcune interfacce utili a definire delle strutture:
- **Collection**: È alla radice della gerarchia delle collezioni.
- **Set**: Una collezione senza duplicati.
- **List**: Una collezione ordinati che può contenere duplicati.
- **Map**: Una collezione di coppie chiave - valore senza chiavi duplicate.
- **Queue**: Una collezione **FIFO** (first in first out) che modella una coda.

## Iterazione su una struttura dati
Possiamo fare un'iterazione **esterna** mediante:
- L'oggetto **Iterator** della collezione.
- Mediante il costrutto **for each**.
- Medianti **indici** ma soltanto sulle Liste.
Un'iterazione **interna** mediante:
- Il metodo **Iterable.forEach** che utilizza il polimorfismo e quindi chiamerà il forEach della classe specifica.
  Questo prende in input un **Consumer**, ovvero l'interfaccia funzionale vista prima con un solo metodo **void accept(T ogg)**.

L'oggetto Iterator è utile anche nel caso in cui volessimo rimuovere un oggetto durante l'iterazione, infatti è possibile farlo soltanto tramite il suo metodo **.remove()** altrimenti andremo incontro ad eccezioni.

> [!info] Alcune strutture dati
> Estendono **Abstract List**
> - ArrayList
> - LinkedList
> Estendono **Abstract Set**
> - HashSet
> - TreeSet
> Estendono **HashSet**
> - LinkedHashSet
> Estendono **Abstract Map**
> - HashMap
> - TreeMap
> Estendono **HashMap**
> - LinkedHashMap

**LinkedHashSet**, è un set ma mantiene l'ordine di inserimento degli elementi

**TreeMap**, mantiene gli elementi ordinati in base all'ordinamento naturale delle chiavi, funzionamento simile quindi ai TreeSet.

**LinkedHashMap**, funzionamento simile alle classiche hashmap ma mantiene anche l'ordine di inserimento degli elementi.

## Insiemi
Sono delle collezioni prive di duplicati che estendono la classe **AbstractSet** e implementano l'interfaccia **Set**. Se vogliamo inserire oggetti nei set è necessario implementare correttamente i metodi **equals() e hashCode()**.

### HashSet\<T\>
Memorizza gli elementi della collezione in una tabella di hash e non mantiene nessun ordinamento degli elementi.
Una mappa di hash funziona come un array in cui ogni elemento è un puntatore ad una lista, ogni elemento viene chiamato "bucket", quando chiamiamo hashcode su un oggetto questo ci ritorna un numero intero che indica il bucket sul quale inserirlo (questo conterrà pochi elementi), questo serve a controllare se un elemento è presente nel set prima di andare effettivamente a cercarlo all'interno della lista del bucket.

È necessario quindi che elementi uguali **abbiano lo stesso hashcode** in modo che vengano inseriti all'interno dello stesso bucket e confrontati poi con **equals**.

> [!info] Hashcode e oggetti uguali
> Come detto prima se due oggetti sono uguali devono avere necessariamente lo stesso hashcode, ma se due oggetti hanno lo stesso hashcode non necessariamente sono uguali, qesto perchè abbiamo a disposizione circa 4.5 miliardi di interi e se dobbiamo immagazzinare ad esempio un hashcode per ogni persona del mondo non basterebbero, questo però ci garantisce dei bucket molto piccoli sui quali usare il metodo equals.

### TreeSet\<T\>
Memorizza gli elementi della collezione mantenendoli nel loro ordine naturale tramite il _compareTo_, questa struttura dati ci garantisce un inserimento, accesso e rimozione di log(N) dato che è possibile usare una ricerca binaria.

### LinkedHashSet\<T\>
Memorizza gli elementi della collezione mantenendoli in ordine di inserimento tramite una lista linkata.

## Record
Alternativa a _class_, dopo il nome del record si inseriscono i campi tra parentesi tonde, in automatico vengono creati costruttore, getter e vengono implementati equals e hashCode.
I record non sono mutabili questo significa che i campi sono final.

```java
public record Colore(int red, int green, int blue) {
	public static void main(String[] args) {
		Colore c1 = new Colore(1, 2, 3);
	}
}
```

## Mappe
Sono delle strutture dati che organizzano delle coppie chiave - valore, non possono esserci delle chiavi duplicate, implementano l'interfaccia **Map** e di base non implementano iterable, si può iterare sull'insieme delle chiavi o dei valori.

### HashMap\<K, V\>
Tramite una tabella di hash memorizza le coppie senza un ordine particolare.

### TreeMap\<K, V\>
Memorizza le coppie mantenendole in ordine naturale rispetto alle chiavi tramite un albero.

### LinkedHashMap\<K, V\>
Memorizza le coppie in ordine di inserimento tramite una lista linkata.

> [!info] Multimappa
> Una multimappa è una mappa che permette di memorizzare più valori a fronte della stessa chiave.

# Riferimenti a metodi
È possibile assegnare a interfacce funzionali dei metodi preesistenti piuttosto che creare nuove espressioni lambda utilizzando dei riferimenti ad essi con la sintassi `NomeClasse::nomeMetodo` oppure `nomeOggetto::nomeMetodo`

# Coda
È una struttura **FIFO** quindi First In First Out, possiamo utilizzarla in Java tramite l'interfaccia **Queue** che è implementata ad esempio dalle **LinkedList**.
Fra i metodo come **add e remove** è presente anche **peek** che restituisce il primo elemento presente nella coda senza rimuoverlo.

# Pila
Struttura **LIFO** Last In First Out, permette l'implementazione della ricorsione contenendo i record di attivazione alle chiamate a metodi.
La classe **Stack** (una pila) implementa l'interfaccia List e i metodi che troviamo sono:
- **push(o)** che inserisce un oggetto in cima alla pila.
- **pop()** che rimuove l'elemento in cima alla pila.
- **peek()** restituisce l'oggetto in cima alla pila senza rimuoverlo.

# Alberi
Struttura dati ricorsiva, in Java esistono librerie per implementarli come JGraphT o Guava.
Un albero binario è composto da dei nodi che hanno al massimo altri due nodi figli.

# Come scegliamo la giusta struttura dati?

- Come si vuole accedere agli elementi?
	- Posizione: Array, Liste
	- Chiave: Mappe
	- Non importa: Insiemi
- È importante mantenere l'ordine degli elementi?
	- Si, ordine naturale: TreeMap, TreeSet
	- Si, in ordine di inserimento: LinkedHashMap, LinkedList, LinkedHashSet, ArrayList
	- No: HashSet, HashMap
- Quali operazioni devono essere veloci?
	- Ricerca: HashSet
	- Aggiunta / Rimozione di elementi: LinkedList
	- Non importa: ArrayList

# Ricorsione
Dato un problema ricorsivo è necessario identificare:
- **Casi Base**: Quei problemi di piccola dimensione per i quali conosciamo la soluzione
- **Passo Ricorsivo**: Passo in cui si riduce la complessità del problema ad uno o più sottoproblemi di dimensione minore.
Ogni volta che viene effettuata una chiamata ad un metodo viene creato un nuovo ambiente chiamato **record di attivazione** che contiene la zona di memoria per le variabili locali del metodo e l'indirizzo di ritorno al chiamante, il record si trova nello _stack_.
Se la ricorsione non è gestita correttamente avremo troppe chiamate sullo stack che porterebbero ad un esaurimento della memoria, andiamo incontro ad un'eccezione di tipo **StackOverFlowError**.

La ricorsione è utile per esplorare strutture dati come le linkedlist, infatti possiamo definire le operazioni da svolgere in un nodo e poi andare al prossimo tramite il riferimento, quando il riferimento non contiene un oggetto abbiamo finito la lista e possiamo uscire.
Oppure per esplorare alberi, con lo stesso ragionamento possiamo muoverci nodo per nodo.
Ovviamente esistono diversi modi per effettuare queste "esplorazioni" come **pre order, in order o post order**.

## Mutua Ricorsione
Si verifica quando un metodo _A_ chiama il metodo _B_ che richiama il metodo _A_.

# Eccezioni
Un'eccezione è una classe che eredita dalla super classe **Exception**, sono utilizzate per segnalare una condizione che impedisce la normale prosecuzione del programma e quindi interrompe l'esecuzione.
Possiamo definire le nostre eccezioni personalizzate che verranno generate dai nostri metodi, se un metodo genera un'eccezione deve dichiararlo nell'intestazione:

```java
public class MiaEccezione extends Exception {}

public class MiaClasse {
	private Utente amministratore;
	public void leggiInformazioni(Utente u) throws MiaEccezione {
		if (!amministratore.equals(u)) throw new MiaEccezione();
	}
}
```

## Tipologie di errori / eventi
- **Sincroni**: si verificano dopo l'esecuzione di un'istruzione e possono essere gestiti tramite un'eccezione, si dividono in:
	- **Errori non critici**: Condizioni anomale (divisione per 0)
	- **Critici**: Errori interni della JVM (conversione non consentita, mancanza di memoria)
- **Asincroni**: Avvengono parallelamente all'esecuzione del programma e sono indipendenti dal flusso di controllo, non possono essere gestiti via software.

Quando utilizziamo un metodo che solleva un'eccezione è necessario gestirla altrimenti si va in errore.
**CATCH - OR - DECLARE**: il metodo corrente può sollevare a sua volta la stessa eccezione, si può gestire l'eccezione manualmente tramite il costrutto **try catch**.
I blocchi catch vanno posizionati nell'ordine corretto infatti anche se abbiamo specificato del codice da eseguire per un'eccezione specifica, Java utilizzerà il primo blocco catch compatibile.

Ovviamente se decidiamo di non gestire subito l'eccezione ma di inviarla al chiamante, andrà comunque gestita ad un certo punto del codice, altrimenti se arriva al main causerà la terminazione del programma.
Il messaggio d'errore stampato a schermo si chiama **stack trace** che specifica:
- **thread** sul quale è stata sollevata l'eccezione
- **nome** dell'eccezione
- la successione in ordine inverso di invocazione dei metodi coinvolti.
- **file sorgente** e il **numero di riga** di ogni invocazione.

Dopo il costrutto try catch è possibile inserire un blocco **finally** che indica una parte di codice eseguita **sempre** dopo il blocco try, utile ad esempio a chiudere file.

![[Pasted image 20240913195131.png]]

> [!info] Exception
> Sono eccezioni interne della JVM legate ad errori nella logica del programma.
> Oppure delle eccezioni regolari, ovvero degli errori dalle quali le applicazioni possono riprendersi se anticipati.
> 
> Ci sono due tipologie:
> - Checked: Eccezioni comuni che si gestiscono con catch-or-declare
> - Unchecked: Eccezioni che non siamo obbligati a gestire.


> [!info] Error
> Sono molto rari, è una condizione dell'applicazione irrecuperabile come l'esaurimento della memoria.


All'interno di un blocco catch è possibile si gestire un'eccezione ma anche lanciarne di nuove.

# Optional
Un Optional contiene il riferimento ad un oggetto che può essere null o meno, in ogni caso viene ritornato l'oggetto Optional, è utile per evitare eccezioni di tipo _NullPointerException_

# Stream (Programmazione Funzionale)
Uno stream rappresenta una sequenza di elementi sui quali possiamo svolgere operazioni **sequenziali o parallele**, si creano quindi a partire ad esempio da delle Collection ma a differenza di queste non memorizzano i dati, operano soltanto su di essi.
Lo stream è un metodo di programmazione **dichiarativo** quindi si specifica soltanto cosa si vuole fare, è diverso dal metodo **imperativo / procedurale** che invece specifica anche il come vogliamo eseguire qualcosa.

## Operazioni sugli stream
Ne esistono di due tipi:
- **Intermedie**: restituiscono un altro stream su cui lavorare.
- **Terminali**: restituiscono il tipo atteso.
Dopo che chiamiamo quindi un'operazione terminale lo stream non è più utilizzabile.

![[Pasted image 20240913213144.png]]

> [!info] Lazy Behavior
> Le operazioni intermedie non vengono eseguite immediatamente ma soltanto nel momento in cui si richiede un'operazione terminale. 

Le operazioni possono essere divise in altri due tipi:
- **Stateless**: L'elaborazione degli elementi avviene in modo indipendente si può quindi lavorare in parallelo.
- **Stateful**: L'elaborazione di un elemento potrebbe dipendere da altri elementi si deve quindi lavorare in modo sequenziale. (_skip, distinct, limit, sorted_)

Dato che gli stream servono per lavorare su oggetti, esistono anche delle versioni ottimizzate per lavorare con tipi primitivi: **IntStream, DoubleStream, LongStream**.

Per creare uno stream possiamo:
- Utilizzare **Stream.of(elenco di dati)** che non genera una collection ma itera direttamente sull'elenco.
- Utilizzare il metodo delle collection **stream()** o **parallelStream()**.
- Per gli array utilizzare il metodo **Arrays.stream(T[] array)**.
- Uno stream di righe di testo da **BufferedReader.lines()** o **Files.lines(Path)**.
- Stream di righe da **String.lines()**.

## Metodi nello specifico

### Min e Max
Restituiscono un Optional che contiene il valore minimo / massimo prendendo in input un **Comparator**

### Filter
Prende in input un **Predicate** e restituisce uno stream con i soli elementi che lo rispettano.

### For Each
Prende in input un **Consumer** e lo applica a tutti gli elementi dello Stream.

### Count
Restituisce il numero di elementi nello stream come _long_.

### Sorted
Restituisce uno stream ordinato senza modificare la collection di partenza.

### Map
Restituisce un nuovo stream dove ciascun elemento è stato convertito tramite la funzione passata in input.

### Collect
Raccoglie gli elementi dello stream in un oggetto (Lista, Stringa, Set).

### Distinct
Restituisce un nuovo stream senza ripetizioni.

### Reduce
Effettua una riduzione sugli elementi dello stream in base alla funzione passata in input.
Se ad esempio forniamo come funzione la somma di due elementi, questo ci restituirà l'intero che rappresenta la somma di tutti gli elementi dello stream, la funzione quindi viene applicata ad ogni elemento e il suo successivo fino a raggiungere un solo elemento.

### Limit
Limita lo stream al numero di elementi (long) passato in input.

### Skip
Salta il numero di elementi passato in input.

### Takewhile / dropwhile
Considera / non cosidera gli elementi dello stream che soddisfano la condizione fornita.

### Anymatch / allmatch / nonemath
Prendono tutti un predicato in input e restituiscono true rispettivamente se: un elemento lo rispetta, tutti gli elementi lo rispettano, nessun elemento lo rispetta.

### Findfirst / findany
Operazioni terminali per ottenere il primo o qualsiasi elemento dello stream.

### Flatmap
Operazione intermedia che permette di unire degli stream in un unico stream, serve ad evitare stream di stream.

![[Pasted image 20240913220542.png|400]]

In questo modo dopo aver ottenuto uno stream di Array effetuando map non andiamo a creare uno stream unico che contiene tutti gli elementi ma bensì uno stream di stream di stringhe.

![[Pasted image 20240913220650.png|400]]

In questo modo invece ogni Array viene si trasformato in uno stream di stringhe ma poi tutti i loro elementi vengono portati in un unico stream.

## Gli Stream dei tipi Primitivi
A partire da uno stream di tipo generico possiamo ottenere uno stream di tipo primitivo tramite i metodi **mapToInt(), mapToLong() e mapToDouble()**.
Questi dispongono di metodi statici per iterare su un certo range ma anche di metodi per passare ad altri tipi primitivi ovvero **asIntStream, asLongStream e asDoubleStream**.
A partire da uno stream di tipo primitivo possiamo ottenerne invece uno generico tramite i metodi **mapToObject(lambda) o boxed()**.

# Collectors
Sono degli oggetti in grado di ridurre il numero di elementi dello stream, oppure anche collezionarli all'interno di una struttura dati.
Infatti troviamo alcuni metodi come **counting, maxBy, minBy, summingInt, averagingInt** che riducono il nostro stream ad un solo numero.
Oppure altri metodi che trasformano il nostro stream in una struttura dati, **toList** o **toSet** lo trasformano in una list o un set senza però nessuna garanzia sul tipo specifico di quest'ultimi.
- **toCollection** gli accumula nella collezione scelta, infatti richiede come parametro il riferimento al costruttore della collezione specifica.
  
  ```java
  ArrayList<String> str = l.stream().map(x -> ""+x)
	  .collect(toCollection(ArraList::new));
  ```
  
- **toMap**: Richiede da 2 a 4 parametri, i primi due sono delle funzioni, la prima serve a mappare l'oggetto dello stream nella chiave della mappa, la seconda per mapparlo come valore, la terza funzione non obbligatoria serve a specificare il comportamento della mappa nel caso in cui venga inserita una chiave già presente, infine un _supplier_ sempre non obbligatorio che crea la mappa specifica (treemap, hashmap).
  
    ```java
  Map<Integer, String> map = persons
	  .stream()
	  .collect(Collectors.toMap(
		  Person::getAge,
		  Person::getName,
		  (n1, n2) -> n1 + ";" + n2,
		  HashMap::new
	  ));
  ```
  
- **groupingBy**: Tramite una lambda in input restituisce una mappa dove sono stati raccogli gli elementi tramite la lambda in input, ad esempio se abbiamo una collezione di persone possiamo raccogliere nella lambda la loro città in modo da ottenere una mappa che avrà come chiavi le città e come valori tutte le persone che hanno come campo la stessa città.
  
```java
  Map<City, List<Person>> peopleByCity =
	  people.stream().collect(groupingBy(Person::getCity));
  ```
  
- **mapping**: Mappa gli elementi dello stream in base alla lambda in input e li raccoglie con il collector fornito sempre in input, nell'esempio di prima possiamo mappare le persone con il loro cognome per raccogliere quello invece che l'oggetto Persona.
  
  
  ```java
  Map<City, Set<String>> peopleByCity =
	  people.stream().collect(groupingBy(Person::getCity,
								  mapping(Person::getLastName, toSet())));
  ```

**partitioningBy**: Tramite un predicato in input raggruppa gli elementi dello stream in una mappa di tipo `<Boolean, List<T>>`, raccogliendo gli elementi che lo soddisfano e non.

```java
Map<Boolean, List<Integer>> m = l.stream()
		.collect(Collectors.partitioningBy(x -> x % 2 == 0));
```

## Creare un Collector personalizzato
Java ci da la possibilità di creare un collector personalizzate con il metodo **Collector.of** che prende in input:
- **Un supplier** per creare la "rappresentazione" interna.
- **Un accumulatore** che aggiorna il supplier con il nuovo elemento.
- **Un combiner** che fonde due rappresentazioni ottenute in modo parallelo.
- **Finisher** che trasforma il tutto nel tipo finale.

```java
Collector<Person, StringJoiner, String> personNameCollector =
Collector.of(
	() -> new StringJoiner(" | ");
	(j, p) -> j.add(p.name.toUpperCase()),
	(j1, j2) -> j1.merge(j2),
	StringJoiner::toString
);
String names = people.stream().collect(personNameCollector);
// Aggiunge tutti i nomi in unica stringa, tutti in uppercase e separati da " | ".
```

## Stream Infinito
Gli stream dispongono di un metodo **iterate** che restituisce uno stream infinito partendo dal primo argomento e continuando tramite la funzione passata in input, ne esiste anche un'altra con 3 parametri che ha lo stesso funzionamento del for, quindi partenza, condizione e successione.

```java
Stream<Integer> numbers = Stream.iterate(0, n -> n + 10);
numbers.limit(5).forEach(Sytem.out::println); //0,10,20,30,40
```

## Ordine delle operazioni eseguite sugli stream
Anche se con gli stream usiamo una programmazione **dichiarativa** è comunque importante specificare un giusto ordine con il quale eseguire le operazioni, per ridurre al minimo il numero di queste.

![[Pasted image 20240914120738.png]]

Nell'esempio a sinistra mappiamo tutti gli elementi ad uppercase e poi eseguiamo un filtro su quelli che iniziano per "A", questo significa che il map funzionerà su tutti gli elementi, se invece eseguiamo prima il filtro come nell'esempio a destra abbiamo già ridotto il numero di valori da mappare.

![[Pasted image 20240914121003.png]]

Dato che sorted è **stateful** verrà eseguito su tutti gli elementi prima di passare alle prossime operazioni, anche in questo caso però stiamo ordinando uno stream prima di filtrarlo aggiungendo quindi operazioni inutili.

# Stream Paralleli
Le operazioni su uno stream parallelo vengono eseguite contemporaneamente su **thread multipli**.
Attenzione però non sempre infatti questi riducono il tempo di esecuzione del programma, è consigliato utilizzarli quando:
- Non c'è alternanza di operazioni stateless e stateful, il problema **è parallelizzabile**.
- È possibile sfruttare più risorse ovvero i core del processore.
- La dimensione del problema giustifica l'utilizzo della parallelizzazione, infatti sotto un certo numero non conviene.

# Tipi generici
I tipi generici ci permettono di definire una sola volta dei metodi applicabili a oggetti di tipi differenti, li abbiamo già usati ad esempio con gli ArrayList questi infatti prendono come tipo generico quello di cui vogliamo creare la collezione.
Possiamo definire anche delle classi generiche se hanno dei campi del tipo generico, inoltre è possibile indicarne anche più di uno.
In questo caso quindi quando andiamo a creare un oggetto di quella classe dovremo definire il tipo generico attraverso _l'operatore diamante_.

```java
ArrayList<String> lista = new ArrayList<>();
```

I tipi generici possono essere **esclusivamente** tipi derivati e non primitivi, inoltre è possibile estendere classi generiche o implementare interfacce generiche con classi a loro volta generiche fissando poi il tipo nelle sottoclassi.

È possibile porre dei vincoli sul tipo generico nel momento della definizione di una classe o interfaccia.

```java
public interface MinMax<T extends Comparable<T>> {}

public class MyClass<T extends Comparable<T>> implements MinMax<T> {}
```

È errato quindi scrivere:

```java
class MyClass<T extends Comparable<T>> implements MinMax<T extends Comparable<T>> {}
```

- È possibile definire **metodi con tipo generico** anche in classi non generiche.
  
```java
static public <T> void esamina(ArrayList<T> lista) {
	for (T o : lista)
		System.out.println(o.toString);
}  
```

**Attenzione** nelle classi generiche non vale l'ereditarietà dei tipi generici, quindi ad esempio in un ArrayList\<Frutto\> non possiamo inserire un ArrayList\<Pera\>.
Questo perché se fosse permesso l'upcasting la Collection potrebbe contenere elementi con tipo diverso da quello specificato all'inizio trovandosi in situazioni impredicibili.
Il controllo del tipo avviene **in fase di compilazione**.

```java
public static void main(String[] args) {
	ArrayList<Mela> mele = new ArrayList<Mela>();
	prendiFrutta(mele);
	// In questo modo ho inserito una Pera in una lista di Mela
}

public static void prendiFrutta(ArrayList<Frutto> frutti) {
	frutti.add(new Pera());
}
```

Quindi nel metodo prendiFrutta dato che abbiamo un ArrayList di Frutto possiamo inserire qualsiasi sua sottoclasse ma noi abbiamo passato al metodo un ArrayList di Mela e non di Frutto.
Il metodo quindi non funziona anche se abbiamo passato un sottotipo di Frutto.
Quella che rimane è l'ereditarietà tra classi, possiamo quindi creare una **List\<Integer\>** che contiene un **ArrayList\<Integer\>**.

L'upcasting è possibile a tempo di compilazione con gli **Array** ma se non gestito correttamente si genereranno eccezioni di tipo **ArrayStoreException**.

```java
public static void main(String[] args) {
	Mela[] mele = { new Mela(), new Mela() };
	prendiFrutta(mele);
	// In questo modo ho inserito una Pera in una lista di Mela
}

public static void prendiFrutta(Frutto[] frutti) {
	frutti[1] = new Pera();
}
```

Questo codice genera quindi un'eccezione.

## Operatore Jolly
Il simbolo **?** può essere utilizzato al posto del nome del tipo generico come un **segnaposto**, questo si utilizza quando non è necessario conoscere il tipo parametrico per prendere in input un oggetto di una classe con qualsiasi tipo generico.

```java
public class Punto<T extends Number> {
	private T x;
	private T y;

	public Punto(T x, T y) {
		this.x = x;
		this.y = y;
	}

	@Override
	public String toString() { return "("+x+";"+y+")"; }

	public static void main(String[] args) {
		Punto<?> p = new Punto<Integer>(10, 42);
		System.out.println(p);

		p = new Punto<Double>(11.0, 43.5);
		System.out.println(p);
	}
}
```

Oppure anche in dei metodi che vogliono delle classi con tipi generici ma poi non utilizzano il tipo all'interno del codice.

## Implementazione dei generici
I tipi generici vengono implementati in Java tramite la **cancellazione del tipo**, quando il compilatore genera il bytecode relativo a un metodo o una classe generica:
- Elimina la sezione del tipo parametrico e lo sostituisce con quello reale.
- Di default, a meno di vincoli sul tipo, il generico viene sostituito con il tipo _Object_.
- Viene creata una copia della classe o del metodo.
Un generico quindi equivale a un tipo Object su cui non devono essere fatte conversioni e downcasting.

Non è possibile ottenere informazioni sull'istanza di un generico a tempo di esecuzione per via della cancellazione del tipo:

```java
// Genera un'eccezione
List<Integer> x = new Arrays.asList(4, 2);
boolean b = x istanceof List<Integer>;

// Non genera eccezione
List<Integer> x = Arrays.asList(4, 2);
boolean b = x istanceof List<?>;
```

## Utilizzo di EXTENDS e SUPER per i vincoli del generico
- **extends (covarianza)**: T deve essere un sotto-tipo della classe specificata o la classe stessa.
- **super (controvarianza)**: T deve essere una superclasse della classe specificata o la classe stessa.

Non posso conoscere i tipi di _l1, l2 e l3_ ma so che saranno sicuramente Number o un suo sottotipo:

![[Pasted image 20240914145925.png|400]]

Non posso conoscere i tipi di _l1, l2 e l3_ ma posso assumere che saranno Object:

![[Pasted image 20240914150108.png|400]]

_Extends e Super_ sono usati prevalentemente per (rispettivamente) _leggere_ e _scrivere_ in una collezione generica. 
**PECS**: _Producer Extends, Consumer Super_

```java
List<?> lista = new ArrayList<Number>();
List<? extends Number> lista = new ArrayList<Number>();
List<? super Number> lista = new ArrayList<Number>();
```

1) Non so nulla sul tipo, posso leggere gli elementi ma non scrivere.
2) Lista che produce elementi di tipo Number, non posso conoscere il tipo specifico della lista, so solo che estende Number, posso quindi soltanto leggere gli elementi, se proviamo ad aggiungerli avremo lo stesso problema visto prima per l'upcasting, potrei star aggiungendo delle _Pere_ ad una lista di _Mele_.
3) Lista che consuma elementi di tipo Number per scrivere nella lista ma non si conosce il tipo specifico di questi elementi, in questo caso quindi posso scrivere perché anche non conoscendo il tipo so che posso inserire in modo sicuro dei Number.

## Overloading dei Metodi Generici
Un metodo generico può essere sovraccaricato anche da un metodo non generico con lo stesso nome e numero di parametri, quando il compilatore riceve una chiamata a questo metodo cerca quello più specifico quindi prima il non generico e poi il generico per garantire un'ottimizzazione in base al tipo.

```java
static public <T extends Comparable<T>> T getMassimo(T a, T b, T c) {...}
static public String getMassimo(String a, String b, String c) {...}
```

## Tipi RAW
Per retrocompatibilità con le vecchie versioni di Java dove non c'erano i tipi generici è possibile istanziare classi generiche senza specificarne il tipo.

```java
Pila<Integer> p1 = new Pila<Integer>(10); // Con tipo parametrizzato
Pila p2 = new Pila(19); // Con tipo RAW
```

Inoltre si possono assegnare istanze con tipo parametrico a una di tipo RAW e viceversa.

# File
Un File è una collezione di dati salvata su un supporto di memorizzazione, ne esistono di due tipi:

- **File di testo:** Contiene linee di testo leggibili (.txt, .java, .html)
- **File binari**: Possono contenere qualsiasi tipo di informazione come testo, immagini o audio sottoforma di concatenzaione di byte (.mp3, .gif, .class).

In Java possiamo manipolarli tramite la classe **java.io.File** che rappresenta un File o una Cartella, è importante non crearli attraverso percorsi assoluti dato che sono specifici per la nostra macchina.

## Stream
Astrazione derivata da dispositivi di input o output sequenziale.
- Uno stream di input riceve uno stream di caratteri, un carattere alla volta.
- Uno stream di output produce uno stream di caratteri.

Un file può essere trattato come uno stream di input o output, i file vengono bufferizzati quindi ci si accede a blocchi dovendo inviare meno richieste al sistema operativo per accedere al file system.

Per leggere o scrivere caratteri ovvero 16 bit alla volta utilizziamo _java.io.Reader/Writer_ mentre per i byte cioè 8 bit alla volta _java.io.InputStream/OutputStream_.

## Interfaccia Path
Rappresenta file e percorsi gerarchici in generale, per ottenerne uno si utilizza **Paths.get("")**, è possibile costruire il percorso specificando le cartelle da legare con il separatore di sistema:
**Paths.get(cartella1, cartella2, ..., file)** oppure con **File.separator**: **Paths.get(cartella1+File.separator+... + file)**.

## Files
La classe files contiene metodi statici utili a svolgere le operazioni che prima si svolgevano con la classe File.

# Reflection
È un meccanismo utilizzato per esaminare o modificare il comportamento a tempo di esecuzione delle applicazioni che girano sulla JVM.
Permette le operazioni come la creazione di classi definite da noi, esaminare i membri anche privati di una classe o visualizzare l'elenco delle intestazioni dei metodi.
I suoi svantaggi sono la lentezza, la possibilità di errori e la impossibilità di girare in ambienti con alta sicurezza.
In breve, in tempo di esecuzione, ci permette di "interrogare" una classe e sapere quindi i suoi metodi e attributi.

## Class
Per ogni tipo non primitivo la JVM crea un'istanza immutabile della classe _java.lang.Class_ che fornisce i metodi per esaminare le proprietà dell'oggetto a tempo di esecuzione.
Per ottenere un tipo Class nei derivati possiamo utilizzare il metodo **getClass()** della classe Object mentre per i primitivi il campo **.class**, è possibile ottenere anche la superclasse con **getSuperclass()**.
Con **getMethod e getField** si ottengono metodi e campi della classe pubblici fino alla classe antenato Object.
Con **getDeclaredMethod / Field** si ottengono invece solo quelli della classe in questione, anche quelli privati.
Gli stessi metodi esistono anche per i costruttori, **getConstructor, getDeclaredConstructor**.

# Moduli
Un modulo è una raccolta di package e risorse ai quali ci si può riferire tramite il nome del modulo.
La dichiarazione di un modulo:
- Specifica il nome del modulo
- Definisce le relazioni che il modulo e i suoi package hanno rispetto ad altri moduli
- Si specifica in un file _modulo-info.java_.

Un modulo decide quali package **esportare** (rendere visibili all'esterno)

```java
module funzioni {
	exports it.uniroma1.funzioni;
}
```

Quindi una classe pubblica non lo è in assoluto ma soltanto le classi nei package esportati hanno la visibilità specificata anche negli altri moduli.

Un modulo può dipendere da altri moduli che devono essere importati da esso e siccome possono verificarsi situazioni dove un modulo ne richiede un altro che a sua volta ne richiede un altro ancora si può richiedere un modulo in modo transitivo.

```java
module utente.di.funzioni{
	requires funzioni;
}

module B {
	exports package;
	requires transitive C;
}
```

I package standard di Java sono in moduli che iniziano con il prefisso _java_, il più importante è _java.base_ che include i package _java.lang, java.io e java.util_.

Se il codice non fa parte di un module diviene automaticamente parte dell'**unnamed module** i cui package sono esportati automaticamente e che può accedere a tutti gli altri module.

# Design Pattern

Nella programmazione si può andare incontro a problemi tipici e che capitano spesso anche ad altri programmatori per i quali sono già presenti delle soluzioni che dobbiamo soltanto eseguire passo passo.

## Behavorial Patterns
Sono i pattern legati al comportamento degli oggetti.

### Strategy Pattern
Quando l'ereditarietà non permette di escludere alcuni metodi da classi che non ne dovrebbero disporre si può ricorrere alle interfacce, però ci sono comunque dei problemi:
- Non si può forzare una classe ad implementare un'interfaccia.
- Se due classi hanno lo stesso comportamento devono implementare le interfacce con lo stesso codice duplicandolo inutilmente.

![[Pasted image 20240914182450.png]]

**Principio di design**: Identificare gli aspetti dell'applicazione che variano e separarli da quelli che rimangono uguali.

1) Si eliminano i metodi corrispondenti ai comportamenti da modellare a parte, utilizzando interfacce funzionali per ognuno.
   
   ![[Pasted image 20240914182543.png|600]]

2) Si creano delle classi che implementano il comportamento e le si incapsulano nelle classi che ne devono usufruire.
   
   ![[Pasted image 20240914182649.png|600]]

3) In questo modo ogni classe avrà un comportamento personalizzato senza doverlo implementare più volte, inoltre può anche essere cambiato a runtime tramite dei setter.
   
   ![[Pasted image 20240914182741.png|600]]

Quindi in breve:
1) Creiamo delle interfacce per ogni comportamento comune.
2) Creiamo delle classi che implementano le interfacce, ogni classe è un modo per eseguire quel metodo.
3) Ogni oggetto creerà un campo del tipo dell'interfaccia e ci assocerà la classe con il metodo più opportuno.

### Observer Pattern
Si utilizza ad esempio per aggiornare le interfacce grafiche ad ogni cambiamento di quest'ultime.
Gli osservabili estendono la classe **Observable** mentre gli osservatori l'interfaccia **Observer**, ogni osservabile ha una lista dei suoi osservatori ai quali invia una notifica ad ogni suo cambio di stato tramite il metodo **notifyObserver**.
Gli Observer hanno un metodo **update** che viene chiamato quando ricevono una notifica dai loro observable.

### Iterator
Viene utilizzato per accedere agli elementi di una collezione in sequenza senza esporre la struttura sottostante alla collezione stessa.
Tramite questo pattern separiamo la logica della collezione dall'iterazione in modo da nascondere i dettagli interni.

### Template Method
Il template method serve a permettere a delle sottoclassi di una classe astratta di reimplementare solo alcune parti di un algoritmo favorendo quindi la personalizzazione soltanto di alcuni passaggi.
I suoi componenti sono quindi:
- **Template Method**: Il metodo che definisce la logica base da non modificare, di solito è final per non permettere modifiche.
- **Metodi astratti**: Sono i metodi che verrano ridefiniti dalle sottoclassi, quindi i passi personalizzabili visti primi.
- **Metodi Concreti**: Metodi già implementati nella classe base ma anch'essi non modificabili.
Quindi una classe astratta definisce il template method che chiama una serie di metodi astratti che verrano implementati dalle sottoclassi a modo loro.

### Callback pattern
Il callback pattern consiste nell'invocare una funzione quando un'operazione è terminata, un callback non è altro che una funzione passata come parametro ad un'altra funzione, quando la prima termina allora viene chiamato il callback.

In Java le funzioni di callback vengono implementate tramite interfacce funzionali.

_Esempio_

```java
@FunctionalInterface
public interface Callback {
	void execute();
}

class Task { 
	public void execute(Callback callback) { 
		System.out.println("Eseguendo un'operazione lunga...");
		try { 
			Thread.sleep(2000); 
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		callback.onComplete();
	}
}

public class CallbackExample {
	public static void main(String[] args) {
		Task task = new Task();
		task.execute(() -> System.out.println("Operazione completata!"));
	}
}
```

In questo modo non ci interessa dell'operazione che svolge la classe Task, ma sappiamo che una volta finita stamperà a schermo "Operazione completata!".

### Command Pattern
Questo design pattern serve a incapsulare una richiesta o un'azione di un oggetto, in questo modo la rendiamo modulare e possiamo associarla ad altri oggetti.
Gli obiettivi principali infatti sono:
- Disaccoppiamento tra mittente e ricevente: chi richiede l'esecuzione non è interessato a chi la svolgerà.
- Incapsulamento della richiesta: Ogni comando rappresenta una richiesta.

Abbiamo bisogno di:
- Una classe astratta o interfaccia command che dichiara il metodo execute().
- Una classe concreta che implementa un'azione specifica per il comando.
- Receiver: ovvero l'oggetto che riceve l'azione quando viene chiamato il comando.
- Invoker: L'oggetto che invoca il comando.
- Client: L'oggetto che crea il comando e lo assegna ad un invoker

Quindi la classe client creerà il _ricevitore_, varie classi _command_ per i comandi e un _invoker_ al quale passerà il giusto comando da invocare, tramite un metodo dell'invoker chiamerà il metodo che gli è assegnato in quel momento.

## Creational Patterns
Sono pattern legati alla costruzione di oggetti.

### Simple Factory Pattern
Quando creiamo una nuova classe è possibile non conoscere subito il tipo concreto da istanziare:

![[Pasted image 20240914201740.png]]

Inoltre in questo modo se vogliamo aggiungere un tipo di anatra bisogna aggiornare anche il codice.

Il Factory Pattern **disaccoppia** la creazione di oggetti da chi ne usufruisce utilizzando una classe esterna per crearli.

![[Pasted image 20240914203122.png]]

In questo modo abbiamo delegato la creazione degli oggetti alla classe **PizzaFactory**.

### Factory Pattern
In questo pattern invece di creare una singola classe per la creazione, andiamo a creare un'interfaccia, poi ogni sottoclasse implementa la creazione dell'oggetto a modo suo.

È utile per rimuovere il problema visto prima della riscrittura del codice, infatti se aggiungiamo sottoclassi non dobbiamo modificare la logica già esistente.
Quindi per l'esempio visto prima dobbiamo creare un'interfaccia factory con il metodo creaPizza, poi per ogni pizza creiamo una classe factory che implementa l'interfaccia e anche il suo metodo.
Per creare un oggetto ci basta chiamare il metodo creaPizza della factory corrispondente.

### Builder Pattern
La creazione di un oggetto viene separata in operazioni intermedie di configurazione, una volta terminate c'è un'operazione finale che costruisce l'oggetto, è utile quando si hanno molti parametri opzionali negli oggetti.

1) Creare la classe Builder per la configurazione, di solito questa è statica annidata nella classe da creare. Il costruttore della classe viene impostato a privato e prenderà come parametro un oggetto di tipo Builder.
2) Dotare la classe builder di metodi per impostare i vari parametri opzionali e fare in modo che restituiscano sempre il this dell'oggetto in modo da poter concatenare le operazioni.
3) Dotare la classe builder di un metodo build che restituisce un'istanza della classe da creare.
4) Se vogliamo possiamo implementare anche un costruttore nella classe builder per alcuni parametri obbligatori.

Quando dobbiamo creare un oggetto ci basterà quindi creare un oggetto builder, concatenare i vari metodi impostando i parametri come preferiamo e infine chiamare il metodo build che ci restituirà l'oggetto.
Il costruttore privato della classe dovrà soltanto assegnare i parametri presenti nel builder ai suoi.

### Singleton
Permette di rendere una classe istanziabile una sola volta

1) Nella classe creiamo una campo istanza statico del tipo della classe.
2) Rendiamo il costruttore privato
3) Creiamo un metodo statico getIstance che chiameremo quando ci servirà l'istanza, il metodo ne crea una se istanza è null altrimenti restituisce quella già esistente.

## Structural Patterns
Sono legati all'organizzazione delle classi

### Decorato Pattern
È possibile incapsulare un oggetto dentro un altro per poter eseguire operazioni più avanzate senza mostrarne l'implementazione, ogni classe si occupa del proprio compito.

![[Pasted image 20240914230442.png|600]]

![[Pasted image 20240914230513.png|600]]

Adesso vogliamo associare una rappresentazione grafica a queste automobili, ma separiamo l'aspetto grafico da quello logico senza la parte logica lo sappia.

Il decorator pattern serve proprio a questo: **Aggiungere nuove funzionalità a un oggetto senza che esso lo sappia, incapsulandolo all'interno di altre classi**.

I decorator ovvero le classi che estendono l'oggetto:
- Estendono la classe astratta dell'oggetto (in questo caso Automobile)
- Sono costruiti con un'istanza concreta della classe astratta dell'oggetto.
- Inoltrano le richieste di tutti i comportamenti dell'oggetto.
- Implementano operazioni aggiuntive sull'oggetto

![[Pasted image 20240914230909.png|600]]

_Esempio nel codice_

![[Pasted image 20240914231027.png]]

I decorator servono a estendere le funzionalità delle classi senza modificare quest'ultime.