#import "@preview/showybox:2.0.4": showybox
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#show raw: set block(fill: none)
#show raw.where(block: false): set box(fill: none)

= Calcolabilità
Iniziamo introducendo il concetto di *Macchina di Turing*, queste corrispondono al modello astratto di computer, tuttio ciò che è calcolabile per un computer lo è anche per una TM.

Una Turing Machine possiede un nastro infinito e una testina con la quale può leggere e scrivere sul nastro. Inizializziamo il nastro scrivendoci sopra la stringa di input, i restanti slot sono riempiti con il carattere _blank_ $union.sq$. I movimenti possibili per la testina sono _dx, sx, lettura, scrittura_ e continua a computare fino al raggiungimento lo stato di accettazione o rifiuto, se non raggiunge nessuno dei due allora va in loop.

#showybox(
  frame: (
    border-color: blue.lighten(60%),
    title-color: blue.lighten(60%),
    body-color: blue.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Esempio*],
  [
    Costruiamo una TM per il linguaggio $ {w\#w:w in {0,1}^*} $
    La TM si muove a zig-zag tra i simboli a dx e sx di $\#$ e controlla se il simbolo a sx combacia con quello a dx, se si li cancella. Se trova un confronto non valido rifiuta altrimenti se sovrascrive tutti i simboli accetta.
  ]
)

Diamo adesso la definizione formale di TM.

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
  title: [*Definizione* - Turing Machine],
  [
    Una TM è una tupla $M=(Q,Sigma,Gamma,delta,q_"start",q_"acc",q_"rej")$ dove:
    - $Q$ è l'insieme finito degli stati
    - $Sigma$ è l'insieme finito di input $union.sq in.not Sigma$
    - $Gamma$ è l'alfabeto del nastro $(union.sq in Gamma, Sigma subset.eq Gamma$
    - $q_"acc"$ è lo stato di accettazione
    - $q_"rej" eq.not q_"acc"$ è lo stato di rifiuto
    - $delta: Q times Gamma arrow.r Q times Gamma times {L,R}$ definita come,
      se $delta(p,a)=(q,b,X)$ allora:
        - $a$ viene letto dal nastro e sostituito da $b$
        - la macchina passa dallo stato $p$ allo stato $q$
        - Il nastro viene spostato a sx se $X=L$ e a dx se $X=R$
        La transizione avrà quindi come etichetta $a arrow.r b; X$
    Inoltre le transizione in realtà avvengono da $Q \\ {q_"acc", q_"rej"}$ dato che se la TM va in uno dei due termina subito.
  ]
)

Vediamo quindi adesso il concetto di *configurazione*. La configurazione di una TM si rappresenta in questo modo: $ u q v $ Dove:
- La posizione della testina è il primo simbolo di $v$
- $q$ è lo stato corrente
- $u$ è il restante contenuto del nastro precedente

Quindi ad esempio, una configurazione potrebbe essere: $ 1011 q_7 01111 $, inoltre la configurazione iniziale è $q_"start" w$ e quella finale $q in {q_"acc", q_"rej"}$.

Possiamo quindi dire che:
- $u a q_i b v tack.r u q_j a c v arrow.double.r.l delta(q_i, b)=(q_j, c, L)$
- $u a q_i b v tack.r u a c q_j v arrow.double.r.l delta(q_i, b)=(q_j, c, R)$

Diciamo che $M$ *accetta* $w in Sigma^* arrow.double.r.l c_"start"=q_"start" w "è t.c." c_"start" op(tack.r)^* c_"acc"$ dove $c_"acc"$ è la configurazione di accettazione.

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
  title: [*Definizione* - Linguaggi Turing Riconoscibili],
  [
    Un linguaggio $L$ è Turing-Riconoscibile se $exists "TM M"$ che lo riconosce, ovvero se $forall w in L, M$ accetta $w$.
  ]
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
  title: [*Definizione* - Decisore],
  [
    Una TM è detta *decisore* se termina sempre, ovvero non va in loop.
  ]
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
  title: [*Definizione* - Decidibilità],
  [
    Un linguaggio $L$ è Turing-Decidibile se $exists M$ decisore t.c. $L = L(M)$
  ]
)

Esistono delle varianti di TM che mantengono lo stesso potere espressivo:
- Nastro infinito a 2 direzioni
- TM che muovono a R, L, S - "stay-put". Infatti basta che ad ogni transizione fanno prima uno spostamento a sinistra e poi a destra.
- TM con $k$ nastri
- TM non deterministiche

== TM Multinastro
Formalmente abbiamo che $delta: Q times Gamma^k arrow.r Q times Gamma^k times {L,R,S}^k$ con $k = \# "nastri"$, abbiamo quindi $ delta(q_i, a_1, ..., a_k) = (q_j, b_1, b_k, L, R, ..., L) $
Se la macchina è nello stato $q_i$ e le $k$ testine leggono i simboli $a_1,...,a_k$ la macchina va nello stato $q_j$, scrive i simboli $b_1,...,b_k$ e ogni testina si muove come specificato.

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
  [
    Ogni TM multinastro ha una TM singolo-nastro equivalente.
  ]
)

*Dimostrazione* - $S$ simula $M$ mettendo il suo contenuto in un singolo nastro in questo modo:
- Scrive sequenzialmente i contenuti dei $k$ nastri con $"\#"$ come delimitatore
- Per tenere traccia di dove si trovano le testine, introduce un simbolo $°$ sopra al carattere corrispondente, le chiamiamo "testine virtuali".

*METTERE DISEGNO FATTO BENE*

Quindi $S$ su input $w = w_1, ..., w_n$ si comporta così:
1. Pone il nastro nella configurazione "iniziale" $\# w_1^° w_2 ... w_n \# union.sq^° \# ... \#$
2. S scansiona il nastro dal primo all'ultimo $\#$, per capire quali siano i simboli puntati dalle testine virtuali. Poi fa una seconda scansione per aggiornare il nastro secondo $delta'$ di $M$.
3. Se in qualsiasi momento una testina finisce su un $\#$ significa che ha raggiunto un $'union.sq'$ e quindi vi scrive $'union.sq'$ e sposta di una posizione a destra l'intero contenuto del nastro.

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
  title: [*Corollario*],
  [
    Un linguaggio è Turing-Riconoscibile $arrow.double.r.l$ una TM multinastro lo riconosce.
  ]
)

*Dimostrazione* - Dato che la singolo-nastro è una caso speciale di multinastro e che ogni multinastro ha una singolo-nastro equivalente la dimostrazione è completa.