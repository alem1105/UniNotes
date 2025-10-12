#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()
#import "@preview/ilm:1.4.1": *

= JSON
Sta per *JavaScript Object Notation*, è un formato di testo leggero usato per scambiare dati, ad esempio nelle richieste / risposte. Viene utilizzato anche per memorizzare dati in file con estensione `.json`

_Esempio_

```json
{
  "user": {
    "firstName": "John",
    "lastName": "Smith",
    "age": 27
  }
}
```

È un linguaggio estremamente facile sia da leggere che da scrivere anche per gli umani, inoltre è semplice anche realizzare dei programmi in grado di interpretare dei file json.

Utilizza soltanto due concetti:
- Object
- Array

Un oggetto è una collezione non ordinata di coppie *(nome, valore)* racchiusa tra parentesi graffe:
- Il nome deve essere una stringa unica fra tutte le coppie di un oggetto
- Il valore può essere un numero, stringa, booleano, array, object ....

```json
{
  "WASA": {
    "name": "Web and Software Architecture",
    "semester": 1
  }
}
```

Un array è un insieme di valori separati da virgole e racchiusi tra parentesi quadre:

```json
{
  "wasaWeekdays": ["tuesday", "thursday"]
}
```

#showybox(
  frame: (
    border-color: blue.lighten(60%),
    title-color: blue.lighten(60%),
    body-color: white
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Esempio più completo*],
  [
    ```json
    "anObject": {
      "aNumber": 42,
      "aString": "This is a string",
      "aBoolean": true,
      "nothing": null,
      "anArray": [
        1,
        {
          "name": "value",
          "anotherName": 12
        },
        "something else"
      ]
    }
    ```
  ]
)

== YAML (Yet Another Markup Language)
È un altro linguaggio di serializzazione pensato principalmente per gli esseri umani usato sempre per file di configurazione, archiazione o scambio di dati. Si basa sull'indentazione (come Python)

```yaml
anObject:
  aNumber: 42
  aString: This is a string
  aBoolean: true
  nothing: null
  anArray:
    - 1
    - anotherObject:
      someName: some value
      someOtherName: 1234
    - something else
```

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
  title: [*YAML superset di JSON*],
  [
    I file JSON sono anche dei validi file YAML, infatti le parentesi graffe sono accettate per gli oggetti e le quadre per gli array.
    Possiamo commentare delle righe con \#, oppure possiamo specificare un documento facendolo iniziare con --- e finire con ...

    In un file possiamo inserire più documenti.

    ```yaml
    anotherArray: [1, 2, 3]
    anotherObject: { "city": "Rome", "country": "Italy" }
    aStringWithColon: "COVID-19: procedure di accesso"
    aNumeriString: "0649911"
    aLongString: |
      this string spans
      more lines
    ```
  ]
)