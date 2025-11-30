#import "@preview/showybox:2.0.4": showybox

= Complessitá di Tempo
Anche quando un problema é decidibile, e quindi risolvibile, potrebbe non esserlo nella pratica se la soluzione richiede una quantitá enorme di tempo o memoria.

Consideriamo il linguaggio $A={0^k 1^k | k gt.eq 0}$, $A$ é un linguaggio decidibile ma di quanto tempo necessita una TM a nastro singolo per decidere $A$? Esaminiamo la seguente TM $M_1$ e contiamo il numero di passi necessari:
- $M_1$ su input $w$:
  1. Scandisce il nastro e rifiuta se trova uno 0 a destra di un 1.
  2. Ripete se il nastro contiene almeno uno 0 ed almeno un 1.
  3. Scandisce il nastro, cancellando uno 0 ed un 1.
  4. Se rimane almeno uno 0 dopo che ogni simbolo 1 é stato cancellato o se rimane almeno un 1 dopo che ogni simbolo 0 é stato cancellato, rifiuta. Altrimenti se non rimangono né simboli 0 né simboli 1, accetta.

Introduciamo la terminologia necessaria per analizzare i tempi. Il numero di passi che un algoritmo utilizza puó dipendere da diversi parametri, per semplicitá consideriamo la lunghezza della stringa in input. Analizzeremo il *caso peggiore* ovvero il tempo di esecuzione massimo e il *caso medio* ovvero la media di tutti i tempi su input di una determinata lunghezza.

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
  [
    Sia $M$ una TM deterministica che si ferma su tutti gli input. Il tempo di esecuzione di $M$ é la funzione:
    $ f:NN arrow.r NN $
    Dove $f(n)$ é il numero massimo di passi che $M$ utilizza su un qualsiasi input di lunghezza $n$. Se $f(n)$ é il tempo di esecuzione di $M$ diciamo che $M$ ha un tempo di esecuzione $f(n)$ e che $M$ é una macchina di Turing di tempo $f(n)$.
  ]
)

== Notazione O-grande ed o-piccola