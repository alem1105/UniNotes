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

