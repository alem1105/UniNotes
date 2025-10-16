#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= Grammatiche Acontestuali
Le grammatiche sono un mezzo di computazione utile in diverse applicazioni come ad esempio i compilatori, queste coincidono con un automa. 

_Ad esempio_ possiamo indicare come grammatica quella che genera le stringhe $0^n 1^n$ con $n gt.eq 0$

Una grammatica è una sequenza di *sostituzioni e produzioni*, facciamo un esempio di grammatica: $ A arrow.r 0 A 1 \ A arrow.r B \ B arrow.r \# $

Queste sono chiamate *regole della grammatica*; *A,B* sono *variabili* e *0,1,\#* sono detti *terminali*. In ogni grammatica c'è sempre una variabile speciale ovvero la *variabile iniziale*.

Per costruire delle stringhe si parte dalla variabile iniziale e si applicano le regole come vogliamo, usando l'esempio di prima possiamo costruire:

$ A arrow.r "0A1" arrow.r "00A11" arrow.r "000A111" arrow.r "000B111" arrow.r "000#111" $

Abbiamo applicato, in ordine, le regole *1, 1, 1, 2, 3*. Ad ogni produzione che effettuiamo possiamo associare un *albero sintattico*:

_TODO: IMMAGINE_

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
  title: [*Definizione - CFG (Context-free grammar)*],
  [
    Una CFG è una tupla $(V, Sigma, R, S)$ dove:
    - $V$ è l'insieme finito delle variabili
    - $Sigma$ è l'insieme finito dei terminali $(V inter Sigma = emptyset)$
    - $R$ è l'insieme di regole
    - $S in V$ è la variabile iniziale
  ]
)

Se $u,v,w in Sigma union V$ e $(A arrow.r w) in R$ allora $u A v$ produce $u w v$ e lo scriviamo come $u A v arrow.double.r u w v$

Diciamo inoltre che $u$ deriva $v$, con la notazione $u arrow.double.r^* v$ se:
- $u=v$
oppure
- $exists u_1,...,u_k$ con $k gt.eq 0$ t.c.: 
$ u arrow.double.r u_1 arrow.double.r u_2 arrow.double.r ... arrow.double.r u_k arrow.double.r v $

Quindi se esiste una sequenza di sostituzione che ci permettono di arrivare a $v$ partendo da $u$.

Questo ci permette di definire il linguaggio assocciato alla grammatica, ovvero: $ "Sia" G=(V,Sigma,R,S) "allora" L(G)={w in Sigma^* : S arrow.double.r ^* w} $

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
  [
    Sia $G=(V={S}, Sigma={a,b}, R, S)$ e $R:S arrow.r "asb"|"ss"|epsilon$.

    Avremo che la stringa $"ab" in L(G)$, ottenuta tramite la sequenza:
    $ S arrow.double.r "asb" arrow.double.r "a"epsilon"b" arrow.double.r "ab" $

    Oppure anche la stringa $"aabb" in L(G)$, con la sequenza:
    $ S arrow.double.r "asb" arrow.double.r "aasbb" arrow.double.r "aa"epsilon"bb" = "aabb" $
  ]
)

Vedremo delle tecniche per costruire delle grammatiche:
- Unendo grammatiche
- Passando da un DFA ad una grammatica
- Sfruttando la ricorsione