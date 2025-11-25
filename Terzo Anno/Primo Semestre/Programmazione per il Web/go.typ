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

== Deeper
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

== Approfondimento sulle Slice
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

= Mappe
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

= Range
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

= Cheat Codes
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
