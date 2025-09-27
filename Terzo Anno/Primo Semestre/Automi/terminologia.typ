#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton

#set heading(numbering: "1.")

= Introduzione alla terminologia
Introduciamo delle definizioni e delle operazioni che utilizzeremo durante il corso.
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
  title: [*Alfabeto*],
  [É un insieme finito di simboli, quindi ad esempio $Sigma={0,1,x,y,z}$.]
)

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
  title: [*Stringa*],
  [Una stringa è una sequenza di simboli che appertongono ad un alfabeto. Quindi, ad esempio, dato l'alfabeto $Sigma={0,1,x,y,z}$ una sua stringa è $w=01z$.]
)

== Operazioni sulle Stringhe

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
title: [*Lunghezza di una Stringa*],
[Data una stringa $w in Sigma^*$ indichiamo la lunghezza con $|w|$ ed è definita come il numero di simboli che contiene.]
)
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
  title: [*Concatenazione*],
  [Data la stringa $x=x_1, ..., x_n in Sigma^*$ e la stringa $y=y_1,...,y_m in Sigma^*$ definiamo come *concatenazione di $x$ con $y$* la stringa $x dot y = x_1 ...,x_n y_1...y_m$.]
)
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
  title: [*Stringa Vuota*],
  [Durante il corso indicheremo con $epsilon$ la stringa vuota, ovvero una stringa tale che $|epsilon| = 0$ \ Se concateniamo una qualsiasi stringa non vuota con una stringa vuota otteniamo la prima stringa: $ forall w in Sigma^* space w dot epsilon = w $]
)
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
  title: [*Conteggio*],
  [Data una stringa $w in Sigma^*$ e un simbolo $a in Sigma$ indichiamo il contaggio di $a$ in $w$ con $|w|_a$ e lo definiamo come il numero di occorrenze del carattere $a$ nella stringa $w$.]
)
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
  title: [*Stringa Rovesciata*],
  [Data una stringa $w = a_1 dots a_n in Sigma^*$ dove $a_1,dots, a_n in Sigma$, definiamo la stringa rovesciata con $w^R=a_n dots a_1.$.]
)
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
  title: [*Potenza*],
  [Data la stringa $w in Sigma^*$ e dato $n in NN$ definiamo la potenza in modo ricorsivo: $ w^n = cases(epsilon " se " n = 0, w w^{n-1} " se " n>0) $]
)

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
  title: [*Linguaggio*],
  [Dato un alfabeto $Sigma$ definiamo $Sigma^*$ come linguaggio di $Sigma$, ovvero l'insieme di tutte le stringhe di quell'alfabeto.]
)
