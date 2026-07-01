#import "@preview/showybox:2.0.4": showybox
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#show raw: set block(fill: none)
#show raw.where(block: false): set box(fill: none)

= Complessità
In questa sezione del corso ci si concentra sull'efficienza degli algoritmi (ovvero le TM) nella risoluzione dei problemi, ovvero la decisione dei linguaggi. L'efficienza di un algoritmo può essere espressa in termini di:
- Tempo e Spazio
- Randomness
- Numero di processori per il calcolo parallelo

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
  title: [*Definizione* - Complessità di Tempo],
  [
    Sia $M$ una TM decisore, la sua *complessità di tempo* é $ T:NN arrow.r NN "t.c." T(n)="max"_(x in Sigma^*, |x|=n){\# "pasi richiesti da" M(x)} $
    Ovvero $T(n)$ sia il massimo numero di passi necessari a $M$ per processare una stringa lunga $n$
  ]
)

Siamo interessati a come una funzione si comporta in termini della lunghezza di $x$.

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
    - La TM $M$ che può fare ${L,R,S}$ si puó simulare con una TM $M'$ classica e la complessità di tempo sarà $lt.eq 2T(n) = O(T(n))$.
    - La TM $M$ con $k$ nastri si puó simulare con una TM $M'$ classica e la complessità di tempo sarà $O(T(n)^2$. Questo perchè costruire il nastro richiede $O(T(n))$ mentre per la simulazione abbiamo diversi casi:
      - Per simulare un passo si deve scorrere tutto il nastro e in più si potrebbe dover traslare tutto il nastro a destra di una posizione. Il nastro sarà lungo al piú $O(n)$ quindi con $n$ passi abbiamo $O(T(n)^2)$. In totale quindi $ O(T(n)) + O(T(n)^2) $
  ]
)

*Osservazione* - Ogni TM a singolo nastro necessita di $Omega(n^2)$ tempo per decidere `PALINDROMES`. Se si usassero due nastri invece $O(n)$.

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
  title: [*Definizione* - D-Time],
  [
    Sia $t:NN arrow.r RR^+$. Definiamo $ "DTIME"t(n)={L:exists "TM che decide" L "in tempo" O(t(n))} $
    Quindi ad esempio, `PALINDROMES`$in "DTIME"(n^2)$ e invece $in.not"DTIME"(n)$
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
  title: [*Definizione* - Classe P],
  [
    $P$ è la classe di linguaggi decidibili da una TM in tempo polinomiale. $ P=union.big_(k in NN) "DTIME"(n^k) $
  ]
)

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
    $ "PATH"={chevron.l G,s,t chevron.r | exists s arrow.r.squiggly t in G} in P $
    Dove $G$ è un grafo diretto e vogliamo trovare un percorso da $s$ a $t$.
  ]
)

*Dimostrazione* - Vogliamo dimostrare che esiste una TM che in tempo polinomiale ci può dire se esiste un percorso in grafo diretto $G$ che ci porta da $s$ a $t$.

Costruiamo la TM $M$ = "Data $chevron.l G,s,t chevron.r$
- Marca il vertice $s$
- Finché non vengono marcati nuovi vertici
  - Marca ogni vertice con un arco entrante da un vertice già marcato
- Se $t$ è marcato, accetta; altrimenti rifiuta"

Definiamo $n=|V|$ il numero di vertici e $m=|E|$ il numero di archi. Nel caso peggiore in assoluto ad ogni ciclo marcheremo un solo vertice, siccome ci sono $n$ vertici il ciclo può ripetersi massimo $n$ volte. Inoltre ad ogni ciclo dobbiamo guardare tutte le frecce collegate, scorrerle tutte costa $m$. Il tempo totale è quindi $O(m dot n)$.

In un grafo orientato, nel peggiore dei casi, abbiamo un grafo completamente connesso dove ogni nodo ha una freccia che lo collega ad ogni altro nodo, quindi gli archi massimi crescono fino a circa $n^2$. La complessità di tempo è quindi $T(n)=O(n dot n^2)=O(n^3)$. La complessità è quindi polinomiale.

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
    $ "2COL"={chevron.l G chevron.r | G "è 2-colorabile"} in P $
  ]
)

*Dimostrazione* - Il numero delle possibili colorazione è $O(2^n) in "EXP"$ però per capire se è 2-colorabile possiamo usare il seguente algoritmo:
- Prendo un vertice e lo coloro di BLU
- Coloro i suoi vicini di BLU
- Coloro i suoi vicini di ROSSO
- ...
- Se trovo contraddizioni, rifiuto; altrimenti ripeto per tutte le componenti connesse di G. Se ho colorato tutto, accetto.

L'algoritmo esplora tutto il grafo una sola volta quindi ha complessità $O(n)$.

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
  title: [*Definizione* - Classe EXP],
  [
    EXP è la classe dei linguaggi decidibili da una TM in tempo esponenziale $ "EXP"=union.big_(k in NN) "DTIME"(2^n^k) $
  ]
)

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
  title: [*Time Hierarchy Theorem*],
  [
    $ exists L "t.c." L in "EXP ma" L in.not P, "ovvero" P eq.not "EXP" $
  ]
)

== Satisfiability
La soddisfacibilità è uno dei problemi fondamentali della teoria della complessità, consiste nel determina se una formula booleana è soddisfacibile.

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
  title: [*Definizione* - Circuito Booleano],
  [
    Un circuito booleano $C$ è un grafo aciclico con $n$ input $x_1,...,x_n$ e un output. I vertici sono detti *porte* ($and, or, not$). Il *fan-out* di una porta è il numero di archi uscenti da essa.
  ]
)

#align(center, diagram(
  node-stroke: .1em,
  spacing: 3em,
  // ab
  node((0,0), radius: 1.5em, $and$),
  node((1,0), radius: 1.5em, $or$),
  edge((0,0), (1,0), "-|>"),

  node((-0.5,1), $x_1$),
  node((0.5,1), $x_2$),
  node((1.5,1), $x_3$),

  edge((-0.5,1), (0,0), "-|>"),
  edge((0.5,1), (0,0), "-|>"),
  edge((1.5,1), (1,0), "-|>"),
))

In questo caso la porta $and$ ha fan-out 1 mentre la porta $or$ ha fan-out 0. Inoltre abbiamo $F: (x_1 and x_2) or x_3$

Un circuito booleano con fan-out massimo 1 è definito *formula* booleana.

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
  title: [*Definizione* - Circuit-eval],
  [
    $ "Circuit-eval"={chevron.l C,x chevron.r "con" C "circuito booleano e" C(x)=1} $

    Quindi riceviamo un circuito ed un input, la coppia appartiene al linguaggio soltanto se il circuito produce 1 come output.
  ]
)
*Osservazione* - Sia $C$ con $n$ input $n$ porte, $|chevron.l C chevron.r|=O(n log n)$ e quindi circuit-eval $in P$. Il costo è giustificato dal fatto che il circuito ha $n$ porte e per descrivere ciascuna di esse in binario abbiamo bisogno di $log(n)$ bit.

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
  title: [*Definizione* - Circuit-SAT],
  [
    $ "Circuit-SAT"={chevron.l C chevron.r | exists x in {0,1}^n "t.c." C(x)=1} $
  ]
)

*Osservazione* - Circuit-SAT $in "EXP"$ perché posso deciderlo in $O(|chevron.l C  chevron.r dot 2^n)$

Esistono alcune varianti:
- `FORMULA-SAT`: $C$ é una formula
- `CNF-SAT`: $C$ è una CNF, ovvero una formula in una forma fatta esclusivamente da una catena di clausole tenute insieme da operatori AND. Una clausola è un gruppo di letterali tenuti insieme da operatori OR. I letterali sono le variabili (anche negate).
- `K-SAT`: CNF-SAT in cui tutte le clausole hanno $k$ letterali

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
    $ "2-SAT" in P $
  ]
)

*Dimostrazione* - Sia $phi(x_1,...,x_n)$ la CNF 2SAT con $n$ variabili e $n$ clausole. La rappresentiamo come grafo in questo modo:
- Per ogni clausola $x or y$ consideriamo due implicazioni logiche equivalenti: $ overline(x) arrow.r y " e " overline(y) arrow.r x $
- Gli archi del grafo rappresentano queste implicazioni.

*Claim* - $phi$ è soddisfacibile $arrow.double.r.l$ nessuna componente fortemente connessa di $G$ contiene una variabile e la sua negazione. Una componente fortemente connessa é un insieme di nodi tutti tali che presi due nodi qualsiasi esiste un percorso che li collega.

*Dimostrazione Claim* - Supponiamo $phi$ soddisfacibile ($arrow.double.r$). Supponiamo per assurdo ci sia una componente fortemente connessa che contiene $x$ e $overline(x)$. Poiché è una CFC, vuol dire che $exists x arrow.r.squiggly overline(x)$ e $overline(x) arrow.r.squiggly x$. Ma poiché gli archi sono implicazioni equivale a dire che valgono $x arrow.double.r overline(x)$ e $overline(x) arrow.double.r x$, impossibile se $phi in "SAT"$, quindi $x$ e $overline(x)$ non sarrano mai nella stessa CFC.

Adesso assumiamo che nessuna CFC contenga sia $x$ che $overline(x)$ ($arrow.double.l$). Definiamo un ordinamento topologico delle componenti e il seguente assegnamento: $ alpha(x) = cases("True" space "se ord"(x) gt "ord"(not x), "False" space "se ord"(x) lt "ord"(not x)) $

Dimostriamo che l'assegnamento non viola implicazioni: Supponiamo per assurdo che $exists (U,V) "t.c." U="true" "e" V="false"$.

Dato che esiste l'arco $u arrow.r v$, l'ordinamento topologico deve rispettare la direzione dell'arco ovvero $"ord"(U) lt.eq "ord"(V)$. Dato che siamo in 2-SAT deve anche esistere l'arco $(overline(V),overline(U))$ per cui $"ord"(overline(V)) lt.eq "ord"(overline(U))$.

Per la supposizione fatta $U = "True"$ abbiamo che $"ord"(overline(U)) lt "ord"(U)$, sempre per la supposizione abbiamo $V="False"$ e abbiamo quindi che $"ord"(V) lt "ord"(overline(V))$.

Mettendo tutto insieme otteniamo: $ "ord"(V) lt "ord"(overline(V)) lt.eq "ord"(overline(U)) lt "ord"(U) lt.eq "ord"(V) $

Leggendo i termini agli estremi abbiamo che $"ord"(V) lt "ord"(V)$ che è un assurdo. L'assegnamento soddisfa quindi $phi$.

Per quanto riguarda la complessità abbiamo la costruzione del grafo $O(n+m)$, l'algoritmo per trovare le componenti $O(n+m)$ e la verifica delle componenti $O(n)$, essendo tutto lineare 2SAT $in P$.