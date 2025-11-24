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
