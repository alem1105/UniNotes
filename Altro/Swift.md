# Tipi di Dato - Intro

- `int`: Rappresenta un numero, può anche essere negativo
- `float, double`: Numeri decimali, i double hanno 15 cifre decimali mentre i float 6
- `string`: Testo
- `bool`: True o False

Ovviamente possiamo creare anche tipi personalizzati.

> [!info] Type Inference
> Swift nella maggior parte dei casi capisce da solo il tipo della variabile che stiamo dichiarando, anche se noi lo omettiamo

# Variabili e Costanti

- Le variabili possono cambiare nel tempo
- Le costanti sono dati, appunto, costanti nel tempo. Possiamo usarle per ottenere un codice più efficiente

```swift
var highscore = 0 // Dichiarazione di variabile
let highscore = 0 // Dichiarazione di costante
```

Se vogliamo specificare il tipo di una variabile utilizziamo:

```swift
var myName: String = "Alessio"
```

# Array

Sono liste ordinate di elementi, ogni elemento è accessibile da un indice.

```swift
var numbers = [21, 55, 19, 47, 22, 37, 88, 71]
```

Anche in questo caso _swift_ capisce che contiene interi, ma se dobbiamo creare un array vuoto da riempire successivamente possiamo scrivere:

```swift
var numbers: [Int] = []
```

Alcuni metodi utili per gli array:
- `array.count` - restituisce il numero di elementi
- `array.first` - restituisce il primo elemento
- `array.last` - restituisce l'ultimo elemento

> [!info] Optional
> Da notare che `.last` restituisce un **Optional** che sono indicato da un `?` ad esempio un intero optional sarà `Int?`. Questo significa che il dato potrebbe non esistere, ad esempio l'ultimo elemento di un array vuoto potrebbe non esistere appunto.
> 
> Il tipo Optional verrà approfondito più avanti

- Possiamo accedere agli elementi tramite gli indici, quindi ad esempio `array[0]` prende il primo elemento.
- `array.append(elem)` - aggiunge l'elemento in ultima posizione
- `array.insert(elem, at)` - aggiunge l'elemento `elem` nella posizione `at`
- `array.sort()` - ordina l'array
- `array.reverse()` - riordina al contrario l'array
- `array.shuffle()` - riordina in modo casuale l'array

# Set

I set sono simili agli array perché contengono ordinamenti ma non hanno ordinamento e non possono avere elementi duplicati.

Il vantaggio principale è che le operazioni sono molto più veloci rispetto agli array.

Si dichiara in questo modo:

```swift
var numbersSet: Set<Int> = [] // Set vuoto di Interi
```

Possiamo anche crearne uno basato su un array già esistente:

```swift
var numbers = [1, 2, 3, 4, 5, 4, 3]
var numbersSet = Set(numbers)
```

Da notare che i duplicati presenti nell'array verranno cancellati e inoltre ogni volta avrà un ordinamento diverso.

> [!info] Hashable
> Per permettere le operazioni del set il tipo contenuto deve essere **hashable** ovvero deve esistere una funzione che ci restituisce un numero univoco che identifica l'oggetto (a grandi linee 😼).
> 
> I tipi di base hanno già questa caratteristica quindi dobbiamo assicurarci di garantirla per nostri eventuali tipi custom.

Condivide molte operazioni di base con gli array, come ad esempio:
- `set.contains(elem)` - Restituisce un booleano che ci dice se l'elemento è contenuto nel set
- `set.innsert(elem)` - Inserisce l'elemento nel set, qui non ci serve una posizione dato che non c'è ordinamento

# Dizionari

Un dizionario è un insieme di elementi dove ogni elemento è una coppia formata da `(chiave, valore)`, li dichiariamo in questo modo:

```swift
let devices: [String: String] = [
	"phone": "iPhone 16",
	"laptop": "MacBook Air M2",
	"desktop": "Ryzen 7 5800X"
]
```

Quindi dobbiamo definire sia il tipo della chiave che del valore.

Attraverso una chiave possiamo accedere al suo valore in tempo costante:

```swift
devices["phone"] // Restituirà "iPhone 16" in questo caso
```

# Funzioni

Sono dei pezzi di codice che possiamo riutilizzare semplicemente chiamandoli. Prima ovviamente vanno definiti.

```swift
func printName() {
	print("Alessio Marini")
}
```

Per far funzionare la funziona ci basta chiamarla all'interno del codice del programma:

```swift
printName()
```

Possiamo anche passare dei parametri e lavorarci sopra, ad esempio:

```swift
func printName(name: String) {
	print(name)
}

// E chiamare nel main:
printName("Alessio Marini")
```

La funzione può anche ritornare valori:

```swift
func add(firstNumber: Int, to secondNumber: Int) -> Int {
	return firstNumber + secondNumber
}

// La invochiamo con
add(5, 3) // Restituisce il valore quindi non lo stampa

// Per stamparlo possiamo fare ad esempio:
var somma = add(5, 3)
print(somma)
```


> [!info] Il `to` nella segnatura
> Serve semplicemente per migliorare la leggibilità del codice, infatti possiamo chiamare la funzione anche con:
> 
> ```swift
> add(firstNumber: 18, to: 126)
> ```
> Serve quindi a rendere più leggibile a noi umani il "call site" della funzione ovvero dove la chiamiamo ma non è essenziale.
> 
> Possiamo quindi dare una sorta di "alias" ai parametri.

# IF / ELSE

...

# FOR Loops

Ci permette di ripetere un'azione tante volte, possiamo anche usarli per iterare su delle collezioni, ad esempio:

```swift
let names = ["James", "Davis", "Harden"]

for name in names {
	print(name)
}
```

Si possono anche filtrare le iterazioni:

```swift
for name in names where name == "Harden" {
	print(name)
}
```

Possiamo anche iterare su un range di valori:

```swift
for i in 0..<25 {
	
}
```

## Range

Si usano i range, hanno diverse formattazioni:

- `0...n` - va da 0 ad n compreso
- `0..<n` - va da 0 ad n escluso

Si possono usare anche senza un estremo:

- `..<2` - contiene tutti i valori da 2 a $-\infty$
- `2...` - contiene tutti i valori da 2 a $\infty$

I range possono essere usati anche per accedere a un range di valori di una collezione, ad esempio:

```swift
let languages = ["Swift", "Java", "C"]
print(languages[0...2])
```

Ad esempio possiamo riempire un array con numeri casuali in questo modo:

```swift
var randomInts: [Int] = []

for i in 0..<25 {
	let randomNumber = Int.random(in: 0...100)
	randomInts.append(randomNumber)
}
```

# Enum

Rappresentano un insieme di valori

```swift
enum Phone {
	case iPhone11Pro
	case iPhoneSE
	case pixel
	case onePlus
}
```

Si possono anche dichiarare tutti su una linea.

Per utilizzarli creiamo una funzione che prende come input il tipo enum appena creato:

```swift
func getAlemOpinion(on phone: Phone) {
	if phone == .iPhone11Pro {
		print("Something about 11 Pro")
	}
	else if phone == .iPhoneSE {
		print("Something about iPhhoneSE")
	}
	else if ...
	else ...
}
```

Adesso quando la chiamiamo possiamo passare come parametro soltanto uno dei tipi dell'enum, va passato con un `.` davanti quindi, ad esempio:

```swift
getAlemOpinion(on: .pixel)
```

## Raw Value

Possiamo dare un tipo "raw" alle enum ovvero un valore associato all'enum, ad esempio:

```swift
enum Phone: String {
	case iPhone11Pro    = "Pro Model of Apple"
	case iPhoneSE       = "Economic Model of Apple"
	case pixel          = "Google Phone"
	case onePlus        = "Another Android phone"
}
```

E "ripulire" il codice di prima in questo modo:

```swift
func getAlemOpinion(on phone: Phone) {
	print(phone.rawValue)
}
```

# Switch

Possiamo rendere più pulito, ad esempio, il codice scritto primo con tutti gli `if / else` a cascata:

```swift
func getAlemOpinion(on phone: Phone) {

	switch phone {
		case .iPhone11Pro:
			print("Something about 11 Pro")
		case .iPhoneSE:
			print("Something about iPhoneSE")
		case ...
		default:
			print("Non hai inserito un telefono valido")
	}
}
```

Il caso `default` viene eseguito quando non rientriamo nei casi precedenti.

È importante gestire tutti i casi in uno switchcase

# Operators

...

# Optionals
Ci permettono di gestire la "mancanza" di valore per un tipo di dato, ad esempio

```swift
var ages: [Int] = []
ages.sort()

let oldestAges = ages.last
```

In questo caso last non esiste dato che l'array è vuoto, ritornerà il valore `nil`

Di base non possiamo accedere direttamente al valore contenuto in un Optional, se presente, ma dobbiamo usare dei costrutti che ci permettono di effettuare **l'unwrap**:

- **If let**

In questo modo stiamo dicendo, _se ages.last ha un valore e non è nil allora lo inseriamo in oldestAge_, abbiamo accesso alla variabile all'interno delle parentesi

```swift
if let oldestAge = ages.last {
	print("The oldest age is \(oldestAge)")
} else {
	print("There is no oldest age. You must have no students.")
}
```

- **Nil coalescing**

Creiamo la variabile, se ha un valore allora lo usiamo altrimenti forniamo un valore di default dopo i `??`

```swift
let oldestAge = ages.last ?? 999
```

- **Guard Statement**

Ci permette di uscire dal codice o eseguire delle operazioni nel caso in cui il valore è nil.

```swift
func getOldestAge() {
	guard let oldestAge = ages.last else {
		return
	}
}
```

> [!info] Guard vs If let
> Cosa cambia allora fra i due?
> 
> Con `if let` abbiamo accesso alla variabile soltanto all'interno dello scope di `if let` quindi se dobbiamo controllare più tipi potremmo avere un codice poco leggibile e pieno di parentesi annidate.
> 
> Con `guard` possiamo controllare il tipo in una riga e poi usare la variabile all'interno dell'intera funzione, quindi anche se controlliamo più variabili abbiamo comunque accesso a tutte.

- **Force Unwrap**

Questo è molto pericoloso, non ci interessa che valore ha il dato, lo usiamo e basta.

```swift
let oldestAge = ages.last!
```

# Self

Si usa con le classi serve a riferirsi all'oggetto in cui ci troviamo, praticamente uguale al `this` di Java

# Classi

Sono la base della programmazione ad Oggetti. Possiamo quindi creare i nostri tipi personalizzati:

```swift
class Developer {
	var name: String
	var jobTitle: String
	var yearsExp: Int

	init(name: String, jobTitle: String, yearsExp: Int) {
		self.name = name
		self.jobTitle = jobTitle
		self.yearsExp = yearsExp
	}
}
```

Possiamo creare degli oggetti in questo modo:

```swift
let alessio = Developer(name: "Alessio", jobTitle: "Student", yearsExp: 2)
```

Ed accedere ai campi come le altre variabili:

```swift
alessio.name
alessio.jobTitle
alessio.yearsExp
```

Se vogliamo crearne uno vuoto dobbiamo rendere i campi della classe degli Optionals, quindi:

```swift
class Developer {
	var name: String?
	var jobTitle: String?
	var yearsExp: Int?

	init(name: String, jobTitle: String, yearsExp: Int) {
		self.name = name
		self.jobTitle = jobTitle
		self.yearsExp = yearsExp
	}
}
```

In questo modo possiamo creare l'oggetto senza parametri e poi aggiungerli successivamente.

# Ereditarietà

