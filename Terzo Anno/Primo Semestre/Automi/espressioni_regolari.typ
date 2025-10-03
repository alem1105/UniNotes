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
  title: [*Essempio*],
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