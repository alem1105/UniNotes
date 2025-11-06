#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/xarrow:0.3.1": xarrow

#let nonumeq = math.equation.with(block: true, numbering: none)
#let dm(x) = box[#nonumeq[#x]]
#let dfrac(x,y) = math.frac(dm(x),dm(y))

= Linguaggio Imperativo Imp
Definiamo un piccolo linguaggio imperativo chiamato *Imp* che utilizzeremo come introduzione ad un linguaggio più complesso chiamato *All*.

È formato da *costanti*:

$ k::= emptyset | 1 | ... | "true" | "false" $

*Espressioni*:

$ M,N ::= k | x | M+N | M < N $

*Programmi*:

$ p,q ::= "skip" | p;q | "if" M "then" p "else" q | "var" x = M "in" p | "while" M "do" p | x:=M $

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
  title: [*Osservazioni*],
  [
    - Il comando `skip` è semplicemente il comando che non fa nulla.
    - L'unione di due comandi `p;q` è un altro comando.
    - Quando scriviamo `var x = M in p` stiamo dichiarando una nuova variabile `x` mentre se usiamo soltanto `x := M` stiamo assegnando un'espressione ad una variabile che già esiste.
  ]
)

Nel prossimo linguaggio vedremo le differenze fra *call by value, by reference e by name* e considereremo la *call by reference*. Anche in questo linguaggio è come se la considerassimo.

Con la call by reference si utilizzano delle locazioni di memoria che contengono il valore del dato, si utilizza l'ambiente per ricavare la locazione di una variabile e con la locazione si ricava il valore, definiamo *formalmente i domini semantici*:

$ E in "Env" = "Var" xarrow("fin") "Loc" \ S in "Store" = "Loc" xarrow("fin") "Val" $

Definiamo le due funzioni di valutazione semantica:
- Per le *espressioni*:

$ E tack.r M,S arrow.r.squiggly v $

- Per i *programmi*:

$ E tack.r p,S arrow.squiggly.r S' $

Quindi un'espressione viene valutata con un valore mentre un programma ci fornisce una locazione.

Vediamo il resto delle regole:

$ E tack.r k,S arrow.squiggly.r k $

$ E tack.r x,s arrow.squiggly.r v quad ("se" E(x)=l " e " S(l)=v) $

$ frac(E tack.r M", "S arrow.r.squiggly v_1 quad E tack.r N", "S arrow.squiggly.r v_2,E tack.r M < N", "S arrow.squiggly.r "true") quad ("se" v_1 < v_2) " e " frac(E tack.r M", "S arrow.r.squiggly v_1 quad E tack.r N", "S arrow.squiggly.r v_2,E tack.r M < N", "S arrow.squiggly.r "false") quad ("se" v_1 > v_2) $

$ E tack.r "skip",S arrow.squiggly.r S $

$ frac(E tack.r p", "S arrow.squiggly.r S' quad E tack.r q", "S' arrow.squiggly.r S'', E tack.r p";"q", "S arrow.squiggly.r S'') $

$ frac(E tack.r M", "S arrow.r.squiggly "true" quad E tack.r p", "S arrow.squiggly.r S', E tack.r "if" M "then" p "else" q", "S arrow.squiggly.r S') " e " frac(E tack.r M", "S arrow.r.squiggly "false" quad E tack.r q", "S arrow.squiggly.r S', E tack.r "if" M "then" p "else" q", "S arrow.squiggly.r S') $

$ frac(E tack.r M", "S arrow.squiggly.r "false", E tack.r "while" M "do" p", "S arrow.squiggly.r S) " e " frac(E tack.r M", "S arrow.squiggly.r "true" quad E tack.r p", "S' quad E tack.r "while" M "do" p", "S' arrow.squiggly.r S'', E tack.r "while" M "do" p", "S arrow.squiggly.r S'') $

$ frac(E tack.r M", "S arrow.squiggly.r v quad E(x", "l) tack.r p", "S(l", "v) arrow.squiggly.r S', E tack.r "var" x = M "in" p", "S arrow.squiggly.r S') quad (l "è una nuova locazione") $

$ frac(E tack.r M", "S arrow.squiggly.r v, E tack.r x := M", "S arrow.squiggly.r S(l", "v)) quad ("se" E(x) = l) $

== Linguaggio All
Adesso estendiamo il linguaggio _Imp_, nello specifico aggiungiamo nei programmi:

$ p,q :== ... | "proc" y(x) "is" p "in" q | "call" y(M) $

Introduciamo anche gli *array*, aspetto prossima lezione per organizzare meglio :P