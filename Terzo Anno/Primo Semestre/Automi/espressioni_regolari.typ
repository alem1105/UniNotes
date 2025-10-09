#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= Espressioni Regolari

Possiamo vederle come delle espressioni algebriche, ma definiscono dei linguaggi su un certo alfabeto.

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
  title: [*Esempio*],
  [$ (0 union 1) circle 0^* " che equivale a " {0,1} circle 0^* $]
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
  title: [*Definizione*],
  [Sia $Sigma$ un alfabeto possiamo definire un'espressione regolare ssu $Sigma$ (denotata con $"re"(Sigma)$) in modo ricorsivo: $ "caso base" cases(emptyset in "re"(Sigma) \ \ epsilon in "re"(Sigma) \ \ a in "re"(Sigma) " con " a in Sigma) $
  
  $ "induzione" cases(R_1 union R_2 " se " R_1\, R_2 in "re"(Sigma) \ \ R_1 circle R_2 " se " R_1\, R_2 in "re"(Sigma) \ \ (R_1)^* " se " R_1 in "re"(Sigma)) $]
)

Ogni espressione regolare ha un solo linguaggio associato: $ L(r) " t.c. " r in "re"(Sigma) $

Vediamolo ricorsivamente: $ "caso base" cases(L(r) = emptyset " se " r = emptyset \ \ L(r) = epsilon " se " r = epsilon \ \ L(r)={a} " se " r=a ) $

$ "induzione" cases(L(r) = L(R_1) union L(R_2) " se " r = R_1 union R_2 \ \ L(r) = L(R_1) circle L(R_2) " se " r = R_1 circle R_2 \ \ L(r)=(L(R_1))^* " se " r=R_1^* ) $

Qualche esempio:
- $0^* 1 0^* = {w: w " contiene esattamente un 1"}$

- $Sigma^* 1 Sigma^* = {w: w " contiene almeno un 1"}$

- $Sigma^* 001 Sigma^* = {w: w " contiene 001 come sottostringa"}$

- $(0 union 1000)^* = {w: "ogni occorrenza di 1 é seguita da 000"}$

#showybox(
  frame: (
    border-color: purple.lighten(60%),
    title-color: purple.lighten(60%),
    body-color: purple.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Teorema*],
  [Un linguaggio regolare è regolare se e solo se esiste un'espressione regolare che lo descrive: $ "REG" equiv L("re") $]
)

Per dimostrarlo dobbiamo dimostrare la doppia implicazione $L("re") subset.eq "REG"$ e $"REG" subset.eq L("re")$.

Iniziamo dimostrando $L("re") subset.eq "REG"$, quindi data un'espressione regolare $r$ costruiamo un NFA $N_r$ tale che $L(N_r) = L(r)$.

I casi base sono 3, quando l'espressione regolare è un solo carattere, quando l'espression regolare è la stringa vuota oppure quando è l'insieme vuoto.

Data l'espressione regolare $r=a$ con $a in Sigma$ costruiamo l'NFA che la riconosce:

#align(center,
  automaton(
    initial: "q0", final: none,
    (
      q0: (q1:"a"),
      q1: (),
    ),
    layout: (q0: (0,0), q1: (3, 0)),
    style: (
      q1: (fill: green.lighten(50%))
    )
  )
)

Dove:
- $N_r = ({q_0, q_1}, Sigma, delta, q_0, {q_1})$
- $delta(q_0, a)=q_1$
- $delta(q, b) = emptyset$ con $q eq.not q_1 and b eq.not a$

Se invece abbiamo $r=epsilon$, possiamo costrutire:

#align(center,
  automaton(
    initial: "q1", final: none,
    (
      q1: ()
    ),
    layout: (q1: (0,0)),
    style: (
      q1: (fill: green.lighten(50%))
    )
  )
)

Definiamo:
- $N_r = ({q_1}, Sigma, delta, q_1, {q_1})$
- $delta (q_1, b) = emptyset, forall b in Sigma$

Se invece $r=emptyset$ costruiamo:

#align(center,
  automaton(
    initial: "q1", final: none,
    (
      q1: ()
    ),
    layout: (q1: (0,0)),
  )
)

Definiamo:
- $N_r = ({q_1}, Sigma, delta, q_1, emptyset)$
- $delta (q_1, b) = emptyset, forall b in Sigma$

Adesso per il caso induttivo dobbiamo considerare un'espressione regolare $r=R_1 union R_2$ e per ipotesi induttiva sappiamo che $exists M_1, M_2$ t.c. $L(M_1) = L(R_1) and L(M_2) = L(R_2)$ e per chiusura di REG sappiamo che questo implica che $exists M " t.c. " L(M) = L(R_1) union L(R_2)$. Questo è analogo per la concatenazione e l'operatore star.

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
  title: [*Esempio*],
  [Vogliamo costruire un NFA che riconosce il linguaggio $("ab" union "a")^*$
  - Possiamo costruire prima l'automa che riconosce $a$:

  #align(center,
    automaton(
      initial: "q0", final: none,
      (
        q0: (q1:"a"),
        q1: (),
      ),
      layout: (q0: (0,0), q1: (3, 0)),
      style: (
        q1: (fill: green.lighten(50%))
      )
    )
  )

  - Poi costruiamo l'automa che riconosce $b$:

  #align(center,
    automaton(
      initial: "q0", final: none,
      (
        q0: (q1:"b"),
        q1: (),
      ),
      layout: (q0: (0,0), q1: (3, 0)),
      style: (
        q1: (fill: green.lighten(50%))
      )
    )
  )

  - Adesso possiamo ricavare quello che riconosce $a b$:

  #align(center,
    automaton(
      initial: "q0", final: none,
      (
        q0: (q1:"a"),
        q1: (q2: ""),
        q2: (q3: "b"),
        q3: ()
      ),
      layout: (q0: (0,0), q1: (2, 0), q2: (4,0), q3: (6,0)),
      style: (
        q3: (fill: green.lighten(50%)),
        q1-q2: (label: $epsilon$)
      )
    )
  )

  - Costruiamo l'automa che riconosce $("ab" union "a")$:

  #align(center,
    automaton(
      initial: "q", final: none,
      (
        q: (q0: "", q4: ""),

        q0: (q1:"a"),
        q1: (q2: ""),
        q2: (q3: "b"),
        q3: (),

        q4: (q5: "a"),
        q5: ()
      ),
      layout: (q: (-2, -1), q0: (0,0), q1: (2, 0), q2: (4,0), q3: (6,0), q4: (0, -2), q5: (2, -2)),
      style: (
        q3: (fill: green.lighten(50%)),
        q-q0: (label: $epsilon$),
        q1-q2: (label: $epsilon$),
        q-q4: (label: $epsilon$, curve: -1),
        q4-q5: (curve: -1),
        q5: (fill: green.lighten(50%))
      )
    )
  )

  - Infine costruiamo l'NFA che riconosce il linguaggio dell'espressione regolare:

  #align(center,
    automaton(
      initial: "i", final: none,
      (
        i: (q: ""),
        q: (q0: "", q4: ""),

        q0: (q1:"a"),
        q1: (q2: ""),
        q2: (q3: "b"),
        q3: (q: ""),

        q4: (q5: "a"),
        q5: (q: "")
      ),
      layout: (i: (-4, -1), q: (-2, -1), q0: (0,0), q1: (2, 0), q2: (4,0), q3: (6,0), q4: (0, -2), q5: (2, -2)),
      style: (
        i-q: (label: $epsilon$),
        i: (fill: green.lighten(50%)),
        q3: (fill: green.lighten(50%)),
        q-q0: (label: $epsilon$),
        q1-q2: (label: $epsilon$),
        q-q4: (label: $epsilon$, curve: -1),
        q4-q5: (curve: -1),
        q5: (fill: green.lighten(50%)),
        q3-q: (label: $epsilon$, anchor: top),
        q5-q: (label: $epsilon$)
      )
    )
  )
  ]
)