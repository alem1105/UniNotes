#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= Go Basics
Le funzioni Go sono raggruppate in pacchetti, questi sono composti da file nella stessa directory e vengono dichiarati all'inizio dei file con, ad esempio:

```go
package main
```

Inoltre un file può importare diversi pacchetti:

```go
import (
  "fmt"
  "math/rand"
)
```

Il pacchetto `fmt` contiene le funzioni per la formattazione e la stampa del testo. All'interno di un pacchetto possiamo utilizzare le funzioni se queste hanno il nome che inizia con una lettera maiuscola, ad esempio per stampare a schermo:

```go
package main

import "fmt"

func main() {
  fmt.Println("Hello, World!")
}
```

E lo stesso vale per le variabili, ad esempio possiamo utilizzare `math.Pi`

== Tipi di Base - Assegnazione Variabili e Costanti
Ci sono diversi metodi per assegnare e dichiarare variabili:

```go
var i int
const i int

var i int = 3
const i int = 3

var i = 3
// Funziona anche per const ma è senza tipo `untyped`

i := 3 // Inferisce in automatico il tipo
// Non si può usare con const
```

I tipi di dato di base sono:

```
bool // Default false
string // Default "" stringa vuota
// Per i tipi numerici il default è 0
int int8 int16 int32 int64
uint uint8 uint16 uint32 uint64 uintptr
byte // alias per uint8
rune // rappresenta un codepoint Unicode
float32 float64
complex64 complex128
```

I tipi `int, uint, uintptr` cambiano grandezza in base al sistema in cui si trovano, 32bit su sistemi a 32bit e 64 su sistemi a 64bit

Utilizzando la sintassi vista prima per assegnare i valori, il tipo viene inferito in automatico, quindi ad esempio:

```go
i := 42 // int
f := 3.142 // float64
g := 0.867 + 0.5i // complex128
```

Invece le costanti senza tipo, `untyped`, assumono un tipo solo quando vengono usate e possono essere quindi usate in contesti dove servono diversi tipi numerici ma il valore deve rientrare nel range:

```go
const (
  // Entrambe non hanno un tipo specifico
  untypedInt = 1
  untypedFloat = 1.1
)

func needInt(x int) int {
  return x * 10 + 1
}

func needFloat(x float64) float64 {
  return x * 0.1
}

func main() {
  // OK: untypedInt diventa int
  fmt.Println(needInt(untypedInt))
  // OK: untypedInt diventa float64
  fmt.Println(needFloat(untypedInt))
  // Errore: Non possiamo convertire da float a int
  // senza un cast esplicito
  fmt.Println(needInt(untypedFloat))
}
```

Per effettuare i casting si usa l'espressione `T(v)` dove `T` è il tipo in cui vogliamo convertire il dato e `v` è il valore da convertire:

```go
i := 42
f := float64(i) // i (int) convertito in float64
u := uint(f) // f (float64) convertito in uint
```

Proviamo adesso a vedere la lunghezza di una stringa, utilizziamo due funzioni presenti in Go e vediamo le differenze:

```go
package main

import (
  "fmt"
  "unicode/utf8"
)

func main() {
  s := "Ciao, Mondo! 🌍"
  fmt.Println("Len (Byte):", len(s))
  fmt.Println("Rune Count:", utf8.RuneCountInString(s))
}
```

Otteniamo, rispettivamente:
- `Len (Byte): 17`
- `Rune Count: 14`

Infatti la funzione `Len` ci ritorna la grandezza in byte e il carattere emoji è più grande di un singolo byte infatti è grande 4 byte. Per contare la lunghezza in caratteri dobbiamo usare la funzione `RuneCountInString`.

== Loop
In Go esiste un solo tipo di loop ovvero i `for`, a differenza di molti altri linguaggi di programmazione qui non abbiamo parentesi tonde, scriviamo infatti:

```go
sum := 0
for i := 0; i < 10; i++ {
  sum += i
}
```

Possiamo anche inizializzare le variabili all'esterno ed utilizzare il for nel seguente modo:

```go
sum := 0
i := 0 // init statement
for ; ; {
  // condition
  if i >= 10 { break }
  sum += i
  i++ // post statement
}
```

Gli statement `init e post` sono opzionali, possiamo infatti scrivere un while:

```go
sum := 1
for sum < 1000 {
  sum += sum
}
```

Oppure creare un loop infinito:

```go
for {
}
```

== Regole e scope degl IF
La condizione non va indicata con parentesi tonde ma vanno sempre messe le graffe per indicare lo scope. Possono iniziare con un'istruzione eseguita prima della condizione (dichiarazione breve), le variabili dichiarate in questa istruzione breve saranno visibili soltanto all'interno del blocco `if` e dei successivi `else`. Anche i blocchi `else if` possono avere delle istruzioni:

```go
func pow(x, n, lim float64) float64 {
  // v è dichiarata e inizializzata qui
  if v := math.Pow(x, n); v < lim {
    return v
  }
  return lim // v non è visibile qui
}
```

In Go ci sono poi gli `switch` ovvero una sequeunza di istrunzioni `if - else` ottimizzati, a differenza di altri linguaggi tipo Java qui i case vengono valutati tutti. I valori dei case non devono essere costanti ma non per forza interi.

```go
package main

import (
  "fmt"
  "runtime"
)

func main() {
  switch os := runtime.GOOS; os {
    case "darwin":
      fmt.Println("macOS.")
    case "linux":
      fmt.Println("Linux.")
    default:
      // freebsd, openbsd,
      // plan9, windows...
      fmt.Println("%s.\n", os)
  }
}
```

== Defer
Questa keyword serve a posticipare l'esecuzione di una funzione fino a quando la funzione che la racchiude non ritorna.

Gli argomenti della funzione `defer` vengono valutati immediatamente ma la chiamata alla funzione è posticipata. Queste istruzioni marcate da `defer` vengono eseguite in ordine *LIFO (Last In, First Out)* quindi l'ultima posticipata viene eseguita per prima.

_Esempio:_

```go
package main

import "fmt"

func test() {
  defer fmt.Print(" world") // (2) Eseguita prima del ritorno di test()
  fmt.Print(" cruel") // (1) Eseguita immediatamente
}

func main() {
  defer fmt.Println("!") // (4) Eseguita per ultima (LIFO)
  fmt.Print("hello") // (0) Eseguita immediatamente
  test() // (1) e (2)
}

// Output: hello cruel world!
```

== Puntatori
I puntatori sono delle variabili speciali che contengono l'indirizzo di memoria di un valore. Vengono indicati con `*T` dove `T` indica il tipo del valore puntato, un valore zero per un puntatore è `nil`.

- Per generare un puntatore ad una variabile usiamo l'operatore `&`
- Per deferenziare un puntatore ed accedere quindi al valore a cui punta usiamo l'operatore `*`.

Dobbiamo fare attenzione però, infatti a differenza del linguaggio *C* su *Go* non abbiamo l'aritmetica dei puntatori.

_Esempio:_

```go
package main

import "fmt"

func main() {
  var p *int // Variabile p di tipo puntatore a intero
  i := 42
  p = &i // Punta all'indirizzo di i
  fmt.Println(p) // Stampa l'indirizzo di memoria di i
  fmt.Println(*p) // Legge il valore di i tramite il puntatore p
  *p = 21 // Imposta i a 21 tramite il puntatore p
  fmt.Println(i) // Stampa: 21
}
```

== Struct
Possiamo vedere le struct come una collezione di campi. Per accederci possiamo usare la notazione con il `.`, inoltre l'accesso tramite puntatore `(*p).campo` può essere abbreviato in `p.campo`. Quando creiamo un oggetto di tipo struct possiamo anche inizializzare alcuni suoi campi con `NomeCampo:`, ad esempio:

```go
type Vertex struct {
  X, Y int
}

var (
  v1 = Vertex{1, 2}
  v2 = Vertex{X: 1} // Y:0 è implicito
  v3 = Vertex{} // X,Y impliciti
  p = &Vertex{1, 2} // Puntatore a Vertex
)
```

Possiamo anche dichiarare delle struct anonime se dobbiamo utilizzarle soltanto localmente:

```go
a := struct {
  i int
  b bool
} {1, true}
```

In questo modo abbiamo creato una struct locale e anonima con i due campi `i,b` inizializzati rispettivamente a `1, true`.

== Array
Per la dichiarazione di un array usiamo la sintassi `[n]T` dove `n` indica il numero di valori presenti nell'array e `T` il tipo degli elementi.

_Esempi:_

```go
// Esempio di dichiarazione
var a [10]int
// Esempio di inizializzazione
primes := [6]int{2, 3, 5, 7, 11, 13}
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
    La lunghezza di un array fa parte del suo tipo, quindi un `[6]int` è diverso da un `[5]int`. La loro lunghezza è fissa e non possono essere ridimensionati.
  ]
)

Cosa succede quindi se ad esempio creiamo un array ma inseriamo meno valori di quanti ne può contenere?

```go
v := [6]int{2, 3, 5, 7}
```

I valori successivi verranno inizializzati al valore zero del tipo, in questo caso intero quindi 0 e avremo: `[2, 3, 5, 7, 0, 0]`.

=== Slice
Sono una vista a dimensione dinamica su un array, si usa la sintassi:

```go
a[low : high]
```

`a` è l'array mentre `low, high` sono i due estremi dell'intervallo, da notare che `low` è incluso mentre `high` no. In questo caso il tipo è semplicemente `[]T` senza dimensione quindi.

Le slice non memorizzano loro stesse dei dati ma fanno riferimento ad una sezione dell'array che osservano, infatti modificare gli elementi di una slice va a modificare gli elementi dell'array originale.

- Come valore zero hanno `nil`. Questo accade quando non hanno un array sottostante

Possiamo creare un array e una slice che lo referenzia in una riga:

```go
[]bool{true, true, false}
```

Per le slice c'è da differenziare le due definizioni di:
- *Lunghezza (len)*: Il numero di elementi contenuti nella slice.
- *Capacità (cap)*: Il numero di elementi nell'array sottostante *a partire dal primo elemento della slice*.
- Le ricaviamo entrambe con, data `s` slice, `len(s) e cap(s)`

Una volta creata una slice è possibile estenderla verso destra aumentando quindi la sua lunghezza ma non possiamo superare la sua capacità:

```go
s := []int{2, 3, 5, 7, 11, 13} // len = 6, cap = 6

// Rendiamo la slice di lunghezza 0
s = s[:0] // s è [], len = 0, cap = 6

// Estendiamo la lunghezza a 4
s = s[:4] // s è [2, 3, 5, 7], len = 4, cap = 6
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
    Alcune cose da ricordare:
    - *Non si può estendere una slice verso sinistra*, non si può quindi cambiare il suo indice di partenza.
    - Non si può indicizzare oltre la `len` se questa è inferiore a `cap`.
    - Si può indicizzare oltre la `len` se si effettua un *re-slicing*.
  ]
)

_Esempi_:

```go
a := []int{0, 1, 2, 3, 4} // len = 5, cap = 5
b := a[1:4]
// b è [1, 2, 3], len = 3, cap = 4 perchè punta a [1, 2, 3, 4]

fmt.Println(b[3])
// Restituisce errore perchè l'indice 3 sta fuori dalla lunghezza.

fmt.Println(b[:cap(b)][3])
// Adesso l'indice 3 è valido
```

Nell'ultima riga è stato effettuato un *re-slicing*, abbiamo fatto uno slicing su `b` che in quel momento vale `[1, 2, 3]` e fa riferimento a `[0, 1, 2, 3, 4]`, lo slicing parte dall'inizio e quindi sempre `1` non `0` e arriva fino alla capacità ovvero 4 ma esclusa, ma se `1` ha indice `0` allora l'elemento `4` è quello a indice `3` e anche se è fuori la lunghezza sta comunque nella capacità e quindi possiamo accederci. Adesso la slicing è `[1, 2, 3, 4]` e possiamo quindi accedere all'elemento `3`.

Se vogliamo creare un array azzerato e avere subito una slice che lo referenzia possiamo utilizzare la funzione `make`:

```go
a := make([]int, 5) // len(a) = 5, cap(a) = 5
```

Se vogliamo specificare una lunghezza diversa possiamo passare un terzo argomento:

```go
b := make([]int, 0, 5) // len(b) = 0, cap(b) = 5. La slice adesso è uguale a [] ma ha comunque capacità 5.
```

Per aggiungere elementi ad una slice possiamo utilizzare la funzione `append`, la sintassi è:

```go
func append(s []T, vs ...T) []T
```

- Il primo parametro è una slice di tipo `T`.
- I successivi sono valori di tipo `T`
- Restituisce una nuova slice di tipo `T` con i nuovi elementi aggiunti.
- Se l'array su cui fa riferimento `s` non è abbastanza grande per contenere i nuovi elementi allora ne crea uno nuovo più grande.

Se quindi eseguiamo:
```go
s := []int{9000}[:0]
s = append(s, 0)
```

- Quanto vale `len(s)`? 1
- Quanto vale `cap(s)`? 1
- Cosa contiene `s`? `[0]`

Questo perchè:
  - Inizialmente contiene `[9000]` con `len = 1` e `cap = 1` ma facciamo lo slice a `[:0]` e quindi vale `[]` con `len = 0` e `cap = 1`.
  - Con `append` usiamo la capacità esistente impostando l'elemento a `0` e restituendo quindi una slice uguale a `[0]` con `len = 1` e `cap = 1`.

=== Approfondimento sulle Slice
Come detto prima le slice sono una vista dinamica, ovvero un puntatore, che referenzia una sezione di un array sottostante, la modifica di un elemento in una slice lo modifica nell'array originale e quindi anche per tutte le altre slice che referenziano lo stesso array.

Ognuna è definita da 3 componenti:
- *Puntatore*: L'indirizzo del primo elemento referenziato nell'array sottostante.
- *Length*: Il numero di elementi nella slice.
- *Capacity*: Il numero di elementi dall'inizio della slice fino alla fine dell'array sottostante.

Si può estendere una slice solo fino al valore massimo della sua `cap` e non si può estendere verso sinistra.

_Esempio di modifica di un array con slice_:
```go
array_originale := [5]int{10, 20, 30, 40, 50}

slice_a := array_originale[1:4]
// Contenuto: [20, 30, 40], len = 3, cap = 4

slice_b := array_originale[2:5]
// Contenuto: [30, 40, 50], len = 3, cap = 3

slice_a[1] == 99 // Modifica l'elemento 1 della slice
// Corrisponde a 30 nell'array originale

fmt.Println("Array modificato: ", array_originale)
// Stampa [10, 20, 99, 40, 50]
fmt.Println("Slice B aggiornata: ", slice_b)
// Stampa [99, 40, 50]
```

_Altro esempio più complesso:_

```go
BaseArray := [8]int{10, 20, 30, 40, 50, 60, 70, 80}
A := BaseArray[1:5]
B := BaseArray[3:6]

// Slice A è [20, 30, 40, 50], len = 4, cap = 7
fmt.Printf("1. A: %v (len %d, cap %d)\n", A, len(A), cap(A))
// Slice B è [40, 50, 60], len = 2, cap = 5
fmt.Printf("1. B: %v (len %d, cap %d)\n", B, len(B), cap(B))

// Modifica condivisa, il 40 diventa 99
A[2] = 99

// Stampa [20, 30, 99, 50]
fmt.Printf("2. A: %v\n", A)
// Stampa [99, 50, 60]
fmt.Printf("2. B: %v\n", B)

// Aggiunge elementi alla slice A
// A diventa [20, 30, 99, 50, 100, 110, 120, 130]
// E' stato anche allocato un nuovo array dato che superiamo la capacità
// B però rimane referenziato a quello vecchio
A = append(A, 100, 110, 120, 130)

// Stampa [20, 30, 99, 50, 100, 110, 120, 130], len = 8, cap = 16
fmt.Printf("3. A: %v (len %d, cap %d)\n", A, len(A), cap(A))
// Stampa [99, 50, 60]
fmt.Printf("3. B: %v\n, B")
```

== Mappe
Mappano *chiavi* a *valori*, il valore zero è *nil*, per inizializzare una mappa si usa la funzione *make*.

```go
package main

import "fmt"

var m map[string]string // m è nil, non si possono aggiungere elementi

func main() {
  m = make(map[string]string) // inizializzazione corretta
  m["Bell Labs"] = "cooked"
  fmt.Println(m["Bell Labs"])
}
```

Come per le struct possiamo inizializzarle sul momento:

```go
type Vertex struct {
  Last, Long float64
}

var m = map[string]Vertex {
  "Bell Labs": Vertex {
    40.68433, -74.39967,
  },
  "Google": Vertex {
    37.42202, -122.08408,
  },
}
```

I principali metodi per le mappe sono:
- *Inserimento / Aggiornamento*: `m[key] = elem`
- *Lettura*: `elem := m[key]`
- *Cancellazione*: `delete(m, key)`
  - Se la chiave è assente fallisce l'eliminazione
- *Test di Presenza*: `elem, ok := m[key]`
  - `elem` prende il valore zero del tipo se la chiave non è presente
  - `ok` è un booleano e vale `true` se la chiave è presente

== Range
È una forma del ciclo for che itera su una slice, un array, una stringa o una mappa.
Restituisce due valori per iterazione, indice e copia dell'elemento

```go
for i, value := range pow {
  // i è l'indice, value è la copia dell'elemento
}

// Per usare solo l'indice ed ignorare l'elemento
for i, _ := range pow {
  //
}

// Forma abbreviata per solo l'indice
for i := range pow {
  // ...
}

// Per usare solo il valore ed ignorare l'indice
for _, value := range pow {
  // ...
}
```

== Cheat Codes
Si possono raggruppare gli import:

```go
import "fmt"
import "math"

import (
  "fmt"
  "math"
)
```

Possiamo raggruppare anche le variabili globali:

```go
import "complex"

var (
  ToBe bool = false
  MaxInt uint64 = 1 << 64 - 1
  z complex128 = complex128(complex.Sqrt(-5 + 12i))
)
```

Per specificare il tipo di variabili multipli possiamo accorciare:

```go
x int, y int
x, y int
```

== Package
Un programma in Go è una composizione di pacchetti, il pacchetto principale prende il nome di *main*, al suo interno troviamo anche la funzione di partenza chiamata sempre `main()`. I pacchetti vengono importati utilizzando il loro percorso, ad esempio `encoding/json`, ognuno si trova in una directory dedicata. Un *modulo* invece è un gruppo di pacchetti.

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
  title: [*Module*],
  [
    È una collezione di pacchetti, viene definita nel file `go.mod` e serve a gestire le dipendenze e version control. Per importarne uno si usa il percorso completo ovvero `nome-modulo/pacchetto`. Per creare la radice del progetto si esegue il comando `go mod init nome-modulo`
  ]
)

_Esempio utilizzo di pacchetti_:

```go
package main

import(
  "fmt"
  "math/rand"
)

func main() {
  // Stampa un numero casuale tra 0 e 9
  fmt.Println("Il mio numeero preferito è", rand.Intn(10))
}
```

In *Go* è presente una libreria standard con all'interno vari pacchetti che troviamo a `pkg.go.dev/std`. Possiamo anche creare dei pacchetti all'interno del nostro nuovo progetto oppure usare pacchetti esterni e condividere i nostri.

=== Creare un pacchetto nel progetto
Quando lanciamo il comando `go mod init nome-modulo` abbiamo creato un modulo, da questo momento possiamo creare dei sotto-moduli per i pacchetti ed importarli usando il percorso `nome-modulo/sotto-dir`.

_Esempio_

Nel nostro progetto potremmo creare una situazione simile a: 

```
main.go
go.mod
go.sum
package1/
  functions.go
  other-things.go
  subpackage/
    file.go
```

All'interno del file `package1/functions.go` abbiamo:

```go
package package1

// Va usata una maiuscola come prima lettera della funzione
// Per renderla pubblica

func Dummy() {}

// Questa invece è privata e quindi non esportata fuori
func internalFunction() {}
```

Mentre nel file `main.go`:

```go
package main

import "nome-modulo/package1" // Importa il package interno

func main() {
  // Chiama la funzione pubblica Dummy
  package1.Dummy()
}
```

=== Moduli e Pacchetti Esterni
Per utilizzare dei pacchetti esterni dobbiamo prima scaricarli con il comando:

```go
go get gopkg.in/yaml.v2
```

Con questo comando scarichiamo il pacchetto `gopkg.in/yaml.v2` e lo aggiungiamo in automatico a `go.mod`, a questo punto per utilizzarlo dobbiamo semplicemente importarlo con `import "gopkg.in/yaml.v2"`

== Go Toolchain
Il comando `go mod` lo abbiamo utilizzato prima per inizializzare il modulo ma serve anche a mantenerlo pulito ed aggiornato:

- `go mod init <path/nome>`: Inizializza un nuovo modulo Go, crea il file `go.mod` nella directory corrente definendo il percorso radice del modulo, ad esempio `github.com/utente/repo`
- `go mod tidy`: Pulisce e aggiorna, aggiunge eventuali dipendenze mancanti e rimuove quelle inutilizzate
- `go mod download` scarica tutti i moduli richiesti in `go.mod` nella cache locale.

== Layout Standard
I progetti Go seguono una convenzione:
- *File Sorgente*: Sono quelli che hanno estensione `.go`
- *Package main*: Contiene la funzione `main()` ed é il punto d'ingresso del programma.
- *Package (Nome personalizzato)*: Contiene librerie e logica di business riutilzzabile.

_Esempio_:
1. Crea la cartella `mkdir myproject && cd myproject`
2. Inizializza il modulo: `go mod init example.com/myproject`
3. Crea il file principale: `touch main.go`

Se vogliamo eseguire il codice senza produrre un eseguibile:
- `go run main.go`: Compila ed esegue il codice.
- `go run .`: Compila ed esegue il package `main` nella directory corrente.

Se invece vogliamo compilare il codice ed ottenere un binario:
- `go build .`: Compila il package corrente e genera un file binario
- `go build -o app_name .`: Compila e specifica il nome del file binario
- `go install .`: Compila ed installa l'eseguibile nella cartella binari predefinita di Go.

Per eseguire i test:
- `go test`: Esegue i test nella directory corrente, sono i file con suffisso `_test.go`
- `go test ./...`: Esegue i test in tutte le sottodirectory
- `go test -v`: Esegue i test in modalitá verbosa

Go ha anche una formattazione del codice standard ed é possibile riformattare tutti i file con un comando:
- `go fmt .`: Riformatta automaticamente tutti i file Go nella directory corrente in modo standardizzato, utilizzando lo stile di Go.

Ci sono anche strumenti di analisi e linting:
- `go vet .`: Analizza il codice sorgente per identificare potenziali errori.
- `go doc <package/func>`: Mostra la documentazione per un pacchetto o funzione specifici.

Altri strumenti:
- `go get <path/package>`: Aggiunge un nuovo pacchetto esterno al `go.mod` e lo scarica.
- `go version`: Mostra la versione di Go installata
- `go env`: Stampa le variabili d'ambiente di Go

Aggiunta e aggiornamento:
- `go get <path/package>`: Aggiunge una nuova dipendenza al progetto e la registra in `go.mod`
- `go get <path/package>@v1.2.3`: Scarica e utilizza una specifica versione o un tag.
- `go get -u ./...`: Aggiorna tutte le dipendenze del modulo alla versione patch o minor piú recente.
- `go get -u=patch ./...`: Aggiorna solo alle versioni patch piú recenti.

Ispezione e blocco:
- `go list -m all`: Elenca tutte le dipendenze del modulo, incluse quelle transitive
- `go mod vendor`: Crea una cartella `vendor/` contente le copie locali di tutte le dipendenze per build isolate o per reti limitate.
- `go mod verify`: Verifica che i moduli scaricati nella cache Go corrispondano agli hash in `go.sum`

Comandi per mantenere l'ambiente pulito:
- `go clean -modcache`: Cancella la cache dei moduli forzando il downlaod di tutte le dipendenze alla prossima build/run.

== Funzioni
Si dichiarano e utilizzano nel seguente modo:

```go
package main
import "fmt"

func add(x int, y int) int {
  return x + y
}

func main() {
  fmt.Println(add(42, 13))
}
```

Possiamo anche dichiarare valori di ritorno multipli:

```go
func divide(x int, y int) (int, int) {
  return x / y, x % y
}
```

Si possono anche nominare i valori di ritorno e fare un return generico:

```go
func divide(x int, y int) (div int, mod int) {
  div = x / y
  mod = x % y
  return // Restituisce div e mod
}
```

Quando si utilizzano delle funzioni, in Go, si utilizza sempre il *passaggio per valore* dei parametri, viene quindi passata una copia del dato, questo significa che le modifiche effettuate al dato all'interno della funzione non vengono viste all'esterno di essa. Viene utilizzato per i tipi di base come `int, string e struct` piccole.

Il *passaggio di riferimento* viene utilizzato per struct piú grandi o quando vogliamo effettuare una modifica al dato. Viene passato quindi il puntatore a quel dato:

```go
func scale(v *int) {
  *v *= 10
}

func main() {
  a := 5
  scale(&a) // Passa l'indirizzo di a
}
```

Le funzioni che restituiscono dei valori possono essere passate appunto come valori:
```go
func hypot(x, y, float64) float64 {
  return math.Sqrt(x * x + y * y)
}

// Una funzione che ha come parametro una funzione che a sua volta
// ha come parametri due float e restituisce una float
// la funzione piú esterna restituisce anche lei un float
func compute(fn func(float64, float64) float64) float64 {
  return fn(3, 4)
}

func main() {
  fmt.Println(compute(hypot)) // Stampa 5
  fmt.Println(compute(math.Pow) // Stampa 81
}
```

=== Closure
Possiamo dichiarare delle funzioni all'interno di altre funzioni e farle restituire, la funzione piú interna puó accedere alla variabili dichiarate nella funzione piú esterna, in questo caso ci troviamo in una *closure*.

_Esempio_

```go
func adder() func(int) int {
  sum := 0 // la funzione sotto fa riferimento a questa variabile
  return func(x int) int {
    sum += x
    return sum
  }
}
func main() {
  pos, neg := adder(), adder()
  for i := 0; i < 10; i++ {
    fmt.Println(
      pos(i)
      neg(-2 * i)
    )
  }
}
```

Ogni istanza della funzione avrá una sua copia della variabile `sum`.

== Gestione degli errori
In Go non si utilizza il costrutto `try...catch` ma valori di ritorno, esiste anche il tipo `error` che é un'interfaccia predefinita in Go. Le funzioni che possono fallire avranno come ultimo valore di ritorno un tipo `error`.

Gli errori vanno controllati dopo la chiamata:

```go
func Divide(a, b float64) (float64, error) {
  if b == 0 {
    return 0, errors.New("divisione per")
  }
  return a / b, nil
}

func main() {
  result, err := Divide(10, 0)

  // Controlla subito se c'é un errore
  if err != nil {
    fmt.Println("Errore:", err)
    return
  }
  fmt.Println("Risultato:", result)
}
```

Possiamo creare tipi specifici di errori con delle struct o variabili implementando l'interfaccia `error`, é utile a indicare la causa di quest'ultimo. Possiamo controllare la tipologia con `errors.Is` o convertirli e controllare con `errors.As`.

_Esempio_

```go
var ErrInvalidInput = errors.New("input non valido")

func Process(data string) error {
  if data == "" {
    return ErrInvalidInput
  }
}

func main() {
  err := Process("")
  // Controllo sul tipo di errore
  if errors.Is(err, ErrInvalidInput) {
    fmt.Println("Errore logico: input mancante")
  } else if err != nil {
    fmt.Println("Errore generico:", err)
  }
}
```

_Esempio_

```go
type AuthError struct {
  User string
  Code int
  Msg string
}

// Implementazione del metodo Error, non é una nuova funzione
// Error() é un metodo del tipo AuthError
func (e *AuthError) Error() string {
  return fmt.Sprintf("Auth fallita per %s: %s (Codice %d)", e.User, e.Msg, e.Code)
}

func Authenticate(user string) error {
  return &AuthError {User: user, Code: 401, Msg: "Credenziali non valide"}
}

func main() {
  err := Authenticate("ospite")

  var authErr *AuthError

  if errors.As(err, &authErr) {
    fmt.Println("Autenticazione Fallita:")
    fmt.Printf("- Utente: %s\n", authErr.User)
    fmt.Printf("- Codice: %d\n", authErr.Code)
  } else if err != nil {
    fmt.Println("Errore generico:", err)
  }
}
```

Abbiamo visto che `Error()` é un metodo della struct `AuthError`, vediamo meglio i metodi e come si attaccano a delle struct.

```go
type Vertex struct {
  X int
  Y int
}

v := Vertex{1, 2}
```

I metodi sono delle funzioni con un argomento speciale chiamato *receiver*, nell'esempio di prima sugli errori, il receiver era `e` di tipo `*AuthError`.

_Receiver per valore:_

```go
// Opera su una copia della struct
func (v Vertex) Equal(other Vertex) bool {
  return v.X == other.X and v.Y == other.Y
}

// Utilizzo nel codice
vtx1 := Vertex{1, 2}
vtx2 := Vertex{2, 3}
if vtx.Equal(vtx2) { ... }
```

_Receiver per puntatore:_

```go
// Opera sulla struct originale e puó quindi modificarne i campi
func (v *Vertex) Scale(factor int) {
  v.X *= factor
  v.Y *= factor
}

// Uso nel codice
vtx := &Vertex{1, 2}
vtx.Scale(10)
```

I metodi in realtá possono essere definiti su qualsiasi tipo tranne che puntatori e interfacce. Aggiungiamo un metodo ad un tipo di base:

```go
type Latitude float64

func (lat *Latitude) IsValid() bool {
  return lat != nil && *lat >= -90 && *lat <= 90
}

type Longitude float64

func (lng *Longitude) IsValid() bool {
  return lng != nil && *lng >= -180 && *lng <= 180
}
```

== Interfacce
Un'interfaccia definisce un insieme di firme di metodi. Un tipo di dato implementa un'interfaccia se implementa tutti i metodi di questa. L'implementazione avviene in modo implicito, non c'é quindi bisogno della parola chiave *implements* come in altri linguaggi.

_Esempio_

```go
type Stringer interface {
  String() string
}
```

Qualsiasi tipo di dato che implementa il metodo `String()` sta implementando l'interfaccia `Stringer`

```go
type Vertex struct {
  X int
  Y int
}

// Implementazione di String di Vertex
func (v *Vertex) String() string {
  return fmt.Sprintf("(%d, %d)", v.X, v.Y)
}

// Funzione che accetta un'interfaccia Stringer
func printSomething(s fmt.Stringer) {
  fmt.Println(s.String())
}

// Uso nel codice
v := &Vertex{10, 20}
printSomething(v)
```

=== Interfaccia Write
É un'interfaccia fondamentale in Go per l'I/O:

```go
type Writer interface {
  Write(p []byte) (n int, err error)
}
```

Qualsiasi cosa accetti dei byte sta implementando Writer.

In Go inoltre non é presente il concetto di Ereditarietá, ma favorisce il riuso del codice tramite la *composizione*:
- Evita la complessitá dell'ereditarietá multipla
- Si usa l'approccio
  - "Fa qualcosa" -> Interfaccia
  - "É un tipo di" -> Classe

Con la composizione si incorpora una struct all'interno di un'altra:
- *Embedding*: Inserire una struct senza nome di campo
- *Promozione*: I metodi della struct interna sono promossi alla struct esterna
Simula il riutilizzo senza ereditarietá di tipo.

```go
type Logger struct {
  LogLevel string
}

func (l Logger) Log(msg string) {
  // Logica di logging...
}

type Server struct {
  Logger // Embedding
  Host string
}

func main() {
  s := Server {Logger: Logger{LogLevel: "INFO"}} // Manca Host? 
  // Il metodo Log é ora accessibile direttamente da 's'
  s.Log("Avvio del server.")
}
```

= Web Backend con Go
Go già possiede una libreria per HTTP all'interno del package *net/http*, all'interno di questa troviamo:
- *http.Handler*: Un'interfaccia per gestire le richieste
- *http.HandleFunc*: Funzione per associare un percorso a una funzione gestore
- *http.ListenAndServe*: Avvia il server HTTP
Il gestore di richieste ha la seguente firma:

```go
func handler(w http.ResponseWriter, r *http.Request)
```

Facciamo un esempio creando un servizio "Pari o Dispari", creiamo quindi un endpoint che genera un numero casuale e restituisce se é pari o dispari:

- *http.ResponseWriter (w)*: Usato per scrivere la risposta inviata al client, il corpo.
- *w.Header().Set(...)*: Imposta gli header della risposta, va chiamato prima di scrivere il corpo
- *fmt.Fprintf(w, ...)*: Funzione che accetta un io.Writer (w) e scrive la risposta.

```go
func evenRandomNumber(w http.ResponseWriter, r *http.Request) {
  w.Header().Set("Content-Type", "text/plain")

  p := rand.Int()
  if p % 2 == 0 {
    fmt.Fprintf(w, "%d is even", p)
  } else {
    fmt.Fprintf(w, "%d is odd", p)
  }
}
```

Vediamo invece come leggere i parametri passati tramite URL:
- La richiesta *r* contiene l'URL attraverso `r.URL` di tipo `*url.URL`
- Si usa `.Query()` per ottenere una mappa dei parametri di tipo `url.Values`
- Si usa `.Get("nome_parametro")` per estrarre il valore

_Esempio con `http://localhost:8090/?name=John+Doe`_

```go
func hi(w http.ResponseWriter, r *http.Request) {
  name := r.URL.Query().Get("name")
  w.Header().Set("Content-Type", "text/plain")
  fmt.Fprintf(w, "Hi %s!", name)
}
```

Per leggere invece i dati all'interno di un corpo, quindi da una richiesta POST usiamo:
- *r.Body* di tipo `io.ReadCloser` per ottenere il body
- Si utilizza poi `io.ReadAll(r.Body)` per leggere tutto il contenuto in un array di byte

_Esempio_

```go
func hi(w http.ResponseWriter, r *http.Request) {
  // Legge l'intero corpo
  body, _ := io.ReadAll(r.Body)
  // Si assume che il corpo sia solo il nome in plain text
  name := string(body)
  w.Header().Set("Content-Type", "text/plain")
  fmt.Fprintf(w, "Hi %s!", name)

  // In un caso reale va sempre controllato l'errore di io.ReadAll
  // e l'header della richiesta nel caso di dati strutturati
}
```

Ogni gestore che scriviamo va registrato nel multiplexer HTTP di Go:
- *Registrazione*: `http.HandleFunc(path, handler_function)`
- *Avvio*: `http.ListenAndServe(":porta", nil)`

```go
func main() {
  // Registra la funzione per il percorso radice
  http.HandleFunc("/", hi)
  fmt.Println("Starting web server at http://localhost:8090")
  http.ListenAndServe(":8090", nil)
}
```

Il parametro `r` di tipo `*http.Request` che utilizziamo negli handler contiene tutte le informazioni inviate dal client, oltre ai query parameters visti prima, possiamo accedere ai path parameters ovvero quelli integrati nell'URL (/users/101):

- Si puó utilizzare la libreria standard e fare manualmente uno `strings.Split` per estrarre i segmenti variabili. *Non raccomandato per API complesse*
- Router Esterno, ad esempio `Gorilla Mux`. Attraverso `mux.Vars(r)` estraiamo una mappa di tipo `map[string]string` contenente i parametri estratti dal path. Questo é l'*approccio standrd in Go*.

Per quanto riguarda gli header, come detto prima vanno settati prima di scrivere la risposta, ad esempio il codice di ritorno si imposta con:
- `w.WriteHeader(code)`, se non viene impostato Go utilizzerá di base il 200

Una volta impostati gli header, vediamo come scrivere il body:
- `w.Write([]byte)`: Scrive un array di byte sul corpo, si usa principalmente per dati grezzi
- `fmt.Fprintf(w, format, args...)`: Scrive direttamente su un `io.Writer` (w), si usa per risposte semplici in testo semplice

Nel WEB moderno si utilizza JSON per struttura i dati, in GO per gestirli utilizziamo il package `encoding/json`. Per leggere un corpo JSON in una struct Go si usa `json.NewDecoder`:

```go
type UserInput struct {
  Name string `json:"name"`
  Age int `json:"age"`
}
var input UserInput
err := json.NewDecoder(r.Body).Decode(&input)
```

Se invece vogliamo scrivere una nostra struct in un file json utilizziamo `json.Marshal` o `json.NewEncoder`:

```go
type UserResponse struct {
  Message string `json:"status"`
}
response := UserResponse{Message: "Success"}
w.Header().Set("Content-Type", "application/json")
json.NewEconder(w).Encode(response)
```

= Concorrenza in Go
Prima di tutto differenziamo due concetti:
- *Concorrenza*: Riguarda la struttura del programma, permette di gestire molte cose contemporaneamente.
- *Parallelismo*: Riguarda l'esecuzione, permette di fare molto cose contemporaneamente

Go permette di gestire in modo semplice la concorrenza che _potrebbe_ portare all'esecuzione in parallelo.

== Goroutine
Le Goroutine sono le unitá fondamentali della concorrenza in Go. Sono funzioni eseguite in modo concorrente gestite dal runtime di Go, sono inoltre molto piú leggere dei thread di sistema infatti si possono avere fino a migliaia di Goroutine. Per avviarle é molto semplice basta scrivere la parola chiave `go` prima di una chiamata a funzione.

```go
func main() {
  // Goroutine separata
  go func() {
    for i := 0; i < 10; i++ {
      fmt.Println("Goroutine:", i)
    }
  }()

  // Goroutine principale
  for j := 0; i < 10; j++ {
    fmt.Println("Main:", j)
  }

  // La goroutine principale non aspetta la secondaria, c'é quindi bisogno di sincronizzazione!
}
```

Le goroutine hanno molti vantaggi rispetto ai classici thread:
- *M:N Scheduling*: Lo scheduler di Go assegna M goroutine a N threads del sistema operativo
- *Blocco non fatale*: Se una goroutine si blocca allora il runtime semplicemente sposta quella goroutine in attesa e non blocca l'intero thread del sistema operativo
- *Equitá*: La commutazione di contesto delle Goroutine é molto piú veloce di quella dei thread del SO e permette a GO di garantire equitá e prevenire starvation.

== Sincronizzazione
Per garantire che delle goroutine terminino il lavoro prima che il programma principale termini é necessario un meccanismo di sincronizzazione, in Go ci sono due modi principali:
- Utilizzare i `sync.WaitGroup`
- Utilizzare i Canali

Il WaitGroup é un gruppo di goroutine che deve essere aspettato:
- `wg.Add(N)`: Incrementa un contatore per il numero di goroutine da attendere
- `wg.Done(N)`: Decrementa il contatore (tipicamente con defer)
- `wg.Wait()`: Blocca la goroutine chiamante finché il contatore non torna a zero.

```go
func main() {
  var wg sync.WaitGroup
  wg.Add(1) // Aspettare una goroutine

  go func() {
    defer wg.Done()
    for i := 0; i < 5; i++ {
      fmt.Println("Goroutine: ", i)
      time.Sleep(100 * time.Millisecond)
    }
  }()

  fmt.Prinln("Main in attesa...")
  wg.Wait() // Il main si blocca qui finché la goroutine non chiama wg.Done()
  fmt.Println("Programma completato.")
}
```

Se invece le goroutine devono anche scambiarsi dei dati allora é meglio utilizzare i canali. Il canale non solo trasferisce dati ma blocca l'esecuzione finché sia l'invio che la ricezione non sono pronti.

```go
func main() {
  done := make(chan bool)

  go func() {
    for i := 0; i < 5; i++ {
      fmt.Println("Goroutine: ", i)
      time.Sleep(100 * time.Millisecond)
    }
    done <- true
  }()

  fmt.Println("Main in attesa del segnale")
  <-done // Il main si blocca in attesa di ricevere un valore dal canale 'done'
  fmt.Println("Programma completato.")
}
```

Abbiamo creato il canale con:
- `make(chan Type)` - Canale non bufferizzato
- `make(chan Type, N)` - Canale bufferizzato con capacitá N

Le operazioni bloccanti sono:
- Invio: `channel <- value`
- Ricezione: `v := <-channel`

I canali non bufferizzati garantiscono che invio e ricezione avvengano simultaneamente.

Possiamo permettere a una Goroutine di attendere su piu operazioni di canali contemporaneamente con l'istruzione `select`:
- select blocca finché uno dei suoi case é pronto
- Se piú canali sono pronti allora select ne sceglie uno a caso per l'esecuzione, l'ordine dei casi nella sintassi non influisce sulla prioritá
- default: Se presente, select non blocca. Se nessun canale é pronto allora esegue default

```go
select {
  case v1 := <-chan1:
    fmt.Printf("Ricevuto %v dal chan1\n", v1)
  case chan2 <- 1:
    fmt.Printf("Valore inviato a chan2\n")
  default:
    fmt.Printf("Nessun canale é pronto\n")
}
```

Un uso comune di select é l'implementazione di timeout usando `time.After`:
- `time.After(duration)` restituisce un canale che riceve un valore dopo la durata specificata
- Se il cnale di timeout é pronto prima del canale dati, l'operazione scade

```go
select {
  case v1 := <-dataChannel:
    // Operazione riuscita
    fmt.Printf("Ricevuto dato: %v\n", v1)
  case <- time.After(5 * time.Second):
    // Operazione fallita per timeout
    fmt.Println("Timeout: non é stato ricevuto nessun dato.")
}
```

Quando é necessario condividere la memoria invece di comunicare tramite i canali si usano i Mutex per evitare le race condition. Con i mutex proteggiamo delle sezioni di codice alle quali potranno accedere soltanto una goroutine alla volta.

```go
var counter int
var mu sync.Mutex

func Increment() {
  mu.Lock() // Inizia la sezione critica
  defer mu.Unlock() // Defere garantisce il rilascio del lock anche in caso di panic
  counter++ // Accesso sicuro alla risorsa condivisa
}
```