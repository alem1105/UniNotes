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
- Coloro i suoi vicini di ROSSO
- Coloro i vicini dei vicini di BLU
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
  title: [*Definizione* - Verificatore],
  [
    Una TM $V$ è un verificatore per un linguaggio $L$ se:
    - $V$ ha input $chevron.l x,y chevron.r$ con $x in Sigma^*$ e $y$ certificato (configurazione da verificare)
    - $forall x, x in L arrow.double.r.l exists y "t.c." V(chevron.l x,y chevron.r)="ACC"$
    
    Un verificatore puó portare a due casi:
    - YES CASE: $x in L arrow.double.r exists y "t.c." V(chevron.l x,y chevron.r)="ACC"$
    - NO CASE: $x in.not L arrow.double.r forall y, V(chevron.l x,y chevron.r)="REJ"$
  ]
)

È importante notare che un verificatore $V$ ha tempo di esecuzione polinomiale se il suo tempo di esecuzione è $O(|x|^k)$ per $k in NN$. Come conseguenza $y$ deve essere polinomiale in $n$: $|y|="poly"(n)$ perchè $V$ deve leggere $y$, altrimenti il tempo di lettura supererebbe quello di esecuzione. La regola fondamentale è quindi che il verificatore deve lavorare in tempo polinomiale rispetto alla grandezza del problema originale.

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
  title: [*Definizione* - VERIFIER-NP],
  [
    Possiamo descrivere la classe NP come l'insieme dei linguaggi $L$ t.c. $L$ ha un verificatore in tempo polinomiale.
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
    $ "3COL" in "NP" $
  ]
)

*Dimostrazione* - Consideriamo il seguente verificatore $V$:
- Su input $chevron.l x,y chevron.r$ dove $x$ é un grafo $G=(V',E)$.
  - Interpreta $y=chevron.l c_1,...,c_n chevron.r$ dove $n=|V'|$ e $c_i in {R,Y,B}$. È quindi una lista che ci indica per ogni nodo come é colorato.
  - $forall (i,j) in E, "REJECT" arrow.double.r.l c_i=c_j$
  - Se dopo aver controllato tutti gli archi non ha mai rifiutato, "ACCEPT"

$V$ ha tempo polinomiale in $|x|$ dato che controlla una sola volta tutto il grafo.

Inoltre:
- YES CASE: $G in "3COL" arrow.double.r exists "3COL" y=(c_1,...,c_n)$ t.c. $forall (i,j) in E, c_i eq.not c_j$ allora $V(chevron.l x,y chevron.r)="ACC"$. Ovvero se forniamo una soluzione al verificatore ci dá la risposta corretta.
- NO CASE: Se $V(chevron.l x,y chevron.r)="ACC"$ per qualche $y$ allora $y$ é una 3COL del grafo e quindi $G in "3COL"$ perchè ha controllato tutti gli archi. Non ci sono falsi positivi ovvero che diamo un certificato non valido ma il verificatore ci dice che lo é.

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
    $ P subset.eq N P subset.eq E X P $
  ]
)

Per il Time Hierarchy Theorem dobbiamo avere $P eq.not N P$ oppure $N P eq.not E X P$ oppure entrambe.

*Dimostrazione* - Prima dimostriamo $P subset.eq N P$. Sia $L in P$ vuole dire che $exists M "t.c." L(M) = L$ e $M$ ha tempo polinomiale. Per vedere che $L in N P$ basta considerare il verificatore che su input $chevron.l x,y chevron.r$ ignora $y$ e accetta se e solo se $M(x)="ACC"$.

Dimostriamo adesso che $N P subset.eq E X P$. Sia $L in N P$ allora esiste un verificatore $V$ in tempo polinomiale e il certificato è lungo al massimo $|x|^k$ con $k in NN$. Esiste allora una TM $M$ che genera tutte le possibili stringhe $y$ di lunghezza $|x|^k$ e per ognuna esegue il verificatore $V$. Se $V$ accetta anche solo una volta allora $M$ accetta altrimenti rifiuta. Dato che ci sono in totale circa $2^(|x|)^k$ combinazioni di $y$ che richiedono tempo polinomiale per essere controllate allora il tempo totale diventa esponenziale quindi $M$ lavora in EXP.

Possiamo definire NP anche in termini di macchine di Turing non-deterministiche (Non-deterministic Polynomial time).

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
  title: [*Definizioni*],
  [
    $ "NTIME"(f(n))={L "t.c." exists "NTM" N | L(N)=L "e" N "ha tempo" O(f(n))} $

    $ "NP" = union.big_(k in NN) "NTIME"(n^k) $

    $ "NEXP"= union.big_(k in NN) "NTIME" (2^n^k) $
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
  title: [*Teorema*],
  [
    $ "3SAT" in N P $
  ]
)

*Dimostrazione* - Prendiamo la NTM $N$ t.c. su input $chevron.r x chevron.l = chevron.l phi chevron.r$ 3SAT formula: Prova non deterministicamente tutti i possibili assegnamenti $x_1,...,x_n$ e controlla $phi(x_1,...,x_n)$.

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
    $ "VERIFIER-NP" = N P $

    Mostriamo che le due definizione sono equivalenti, una quella del verificatore con il certificato e l'altra quella della TM non deterministica.
  ]
)

*Dimostrazione* - ($arrow.double.r$) Supponiamo che il problema $L$ abbia un verificatore $V$ che lavora in tempo polinomiale. Vogliamo costruire una NTM $N$ che risolva lo stesso problema. Dato che $V$ lavora in tempo polinomiale allora il certificato $y$ deve essere $|y|=O(|x|^k)$.

La NTM quindi: Su input $x$ la macchina $N$ genera tutte i certificati $y$ possibili di lunghezza polinomiale, e accetta quando un ramo eseguendo $V(chevron.l x,y chevron.r)$ accetta.

La NTM $N$ quindi accetta $x$ se e solo se un suo ramo ha generato un certificato $y$ valido.

$(arrow.double.l)$ - Supponiamo adesso di avere una NTM $N$ che risolve il problema in modo non deterministico in tempo polinomiale. Vogliamo costruire un verificatore deterministico $V$ di tempo polinomiale. Il certificato sará l'insieme di scelte non-deterministiche di $N$ rappresentate come stringa di lunghezza polinomiale.
Ora costruiamo $V$ che prende in input il problema $x$ e il certificato $y$, simula la macchina $N$ ma non si sdoppia mai dato che in $y$ sono contenute le scelte corrette.

$V$ accetterá se e solo se la mappa $y$ lo porta di uno stato di accettazione di $N$ e se $x$ appartiene al linguaggio quel percorso esiste perché $N$ accetta e quindi esisterá un certificato $y$.

$ x in L arrow.double.r.l N "accetta" arrow.double.r.l exists y "insieme di scelte per cui" N "accetta" arrow.double.r.l exists y "t.c." V(chevron.l x,y chevron.r)="ACC" $

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
  title: [*Definizione* - Riduzione],
  [
    Siano $A,B$ linguaggi: $ A lt.eq^p_m B "se" exists "poly-time" R: Sigma^* arrow.r Sigma^* "t.c." forall x in Sigma^* : x in A arrow.double.r.l R(x)=B $
    Quindi come le mapping reduction ma R deve essere calcolabile in tempo polinomiale.
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
    Se $A lt.eq_m^p B "e" B in P, "allora" A in P$
  ]
)

*Dimostrazione* - Sia $M_B$ l'algoritmo poly-time che decide $B$ costruisco la TM $M_A(x)=M_B(R(x))$ dove $R$ é la riduzione $A lt.eq_m^p B$ e quindi $M_A$ é polinomiale. Infatti prende l'input $x$ lo passa alla funzione $R$ e poi il risultato lo passa ad $M_B$, entrambe sono polinomiali e quindi $M_A$ é polinomiale. Formalmente $x in A arrow.double.r.l R(x) in B arrow.double.r.l M_B(R(x)) = "ACC" arrow.double.l.r M_A(x)="ACC"$

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
    Se $A lt.eq_m^p B "e" B in N P "allora" A in N P$
  ]
)

*Dimostrazione* - La dimostrazione é analoga alla precedente ma si sostituiscono $M_A$ e $M_B$ con NTM $N_A$ e $N_B$

*Osservazione* - La riduzione $lt.eq^p_m$ é transitiva. Se $A lt.eq^p_m B$ e $B lt.eq^p_m C$ allora $A lt.eq^p_m C$. Inoltre osserviamo anche che $X lt.eq^p_m Y arrow.double.r overline(X) lt.eq^p_m overline(Y)$

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
    $ "4COL" lt.eq^p_m "SAT" $
  ]
)

*Dimostrazione* - Dato un grafo $G=(V,E)$ 4-colorabile devo costruire una formula $phi_G$ t.c. $phi_G in "SAT" arrow.double.r.l G in "4COL"$.

La formula avrá $2n$ variabili $x_1,x_1',...,x_n,x_n'$ dove $n=|V|$ e ogni coppia di variabili $x_i,x_j in {0,1}$ rappresenta una codifica di un colore.

Nella formula, per ogni arco $(i,j) in E$ codifico la regola "avere colori diversi" nel seguente modo: $(x_i, x_i') eq.not (x_j, x_j')$ ovvero $not (x_i arrow.double.r.l x_j and x_i' arrow.double.r.l x_j')$. Traducendo ogni $x_i arrow.r x_j$ con $not x_i or x_j$ ottengo una formula $phi_(i j)$. Ottengo quindi $phi_G(dot)=and.big_((i,j) in E) phi_(i,j)(dot)$

La formula é corretta quindi $phi_G in "SAT" arrow.double.r.l G in "4COL"$

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
    $ "3COL" lt.eq^p_m  "4COL" $
  ]
)

*Dimostrazione* - Devo definire $R(chevron.l G chevron.r)=chevron.l H chevron.r$ t.c. $G in "3COL" arrow.double.r.l H in "4COL"$.

É molto semplice, infatti se $G$ é 3 colorabile aggiungo un nodo e lo collego a tutti i nodi di G, questo nuovo grafo $H$ avrá il nuovo nodo che posso colorare con un nuovo colorare e diventerá quindi 4 colorabile.

*Osservazione* - Usando la transitivitá di prima osserviamo che $"3COL" lt.eq^p_m "4COL" lt.eq^p_m "SAT" arrow.double.r "3COL" lt.eq^p_m "SAT"$

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
  title: [*Definizione* - NP-HARD],
  [
    Un linguaggio $S$ é NP-HARD se $forall l in N P, L lt.eq^p_m S$
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
  title: [*Definizione* - NP-COMPLETEZZA],
  [
    Un linguaggio $S$ é NP-COMPLETO se $S$ é NP-HARD e $S in N P$.
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
    Se $S$ é NP-COMPLETO allora $S in P arrow.double.r.l P = N P$
  ]
)

*Dimostrazione* - Se $S$ é NP-COMPLETO allora $forall L in N P$ abbiamo $L lt.eq^p_m S$. Se $S in P$ allora ogni $L in P$ e quindi $P = N P$.

L'altra implicazione invece se $P = N P$ e $S$ NP-COMPETO abbiamo che $S in N P = P$ ovvero $S in P$

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
  title: [*Teorema* - Cook-Levin],
  [
    $ "SAT" in "NP-COMPLETE" $
  ]
)

*Dimostrazione* - Dimostriamo che $"SAT" in "NP-HARD"$ ovvero che dato un qualsiasi $L in N P$ allora $L lt.eq^p_m "SAT"$.

Dato un qualsiasi problema $L in N P$ sappiamo che esiste una NTM $N$ che lo risolve in tempo polinomiale. Creiamo un tableau tale che:
- Le righe rappresentano i passi di computazione
- Le colonne rappresentano le celle del nastro della TM
- In ogni istante (riga) il nastro contiene dei simboli e la testina della macchina si trova in una certa posizione in un certo stato.

Il nostro obiettivo é creare una formula $phi_N$ che sia soddisfacibile se e solo se esiste un modo di riempire questa griglia in modo che rappresenti un'esecuzione accettante della macchina $N$.

Per trasformare questa griglia in logica, inventiamo una variabile booleana $x_(i,j,s)=1 arrow.double.r.l$ nella riga $i$ alla colonna $j$ c'é il simbolo $s$.

La grande formula $phi_N$ é un insieme di 4 AND fra formule che impongono delle regole al tableau affinché si comporti come una vera TM.

_METERE FOTO CARINA_

Costruisco la formula $ phi_N = phi_"cell" and phi_"start" and phi_"move" and phi_"accept" $

Dove:
- $phi_"cell"$: Ogni cella contiene un solo simbolo $ phi_"cell" (x) = and_(i,j in [n^k]) [(or_(s in c) x_(i,j,s)) and (and_(s,t in c, s eq.not t) (overline(x_(i,j,s)) or overline(x_(i,j,c))))] $
Ovvero per ogni cella, ogni cella deve avere almeno un valore e non ne puó avere 2.

- $phi_"start"$: La prima riga deve contenere la configurazione iniziale $\# q_0 w_1 ... w_n \# union.sq ...$: $ phi_"start" (x)=x_(1,1,\#) and x_(1,2,q_0) and x_(1,3,w 1) and ... and x_(1, n^k, \#) $

- $phi_"accept"$: Esiste una configurazione accettante $ phi_"accept" (x)= or_(i,j in [n^k]) x_(i,j,q_"acc") $

- $phi_"move"$: Ogni riga del tableau é consistente rispetto a $delta_N$ e alla riga precedente, usiamo la finesta 2x3, una finestra é lecita se non viola le regole di $delta_N$. Questa regola controlla appunto che il tableau segua le regole della TM, la finestra 2x3 é la piú piccola che ci serve infatti una cella nella riga $i+1$ la possiamo verificare semplicemente guardando la cella alla riga $i$ e le due celle adiacenti ad essa. Se tutte le finestre possibili sono legali allora l'intera azione é legale.

*Osservazione* - Se la prima riga é la configurazione iniziale e ogni finestra del tableau é lecita, allora ogni riga segue la precedente secondo $delta_N$

$ phi_"move" (x) = and_(i,j in [n^k]) ("finestra (i,j) lecita") $

Il tableau ha $O(n^k dot n^k)=O(n^(2k))$ celle quindi $O(n^(2k))$ variabili. Quindi $phi_"cell", phi_"move"$ e $phi_"acc"$ hanno dimensione $O(n^(2k))$. Dunque $phi_N$ ha dimensione polinomiale. Perció la formula puó essere generata in tempo polinomiale ed é semplice costruire una riduzione.

*Osservazione* - Per dimostrare che un problema é NP-Completo si procede tipicamente per riduzione a SAT. Infatti abbiamo mostrato che possiamo prendere una qualsiasi TM (problema) e trasformarlo in una formula SAT.

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
    K-CLIQUE (CLIQUE) = ${chevron.l G,k chevron.r | G "é un grafo e contiene una K-clique"}$ é NP-COMPLETO.

    Una k-clique é un gruppo di k vertici in cui ogni coppia di vertici é collegata da un arco.
  ]
)

*Dimostrazione* - Facciamo una riduzione $"3SAT" lt.eq_m^p "CLIQUE"$. L'obiettivo é quello di trasformare una formula logica in un grafo

Prendiamo quindi una formula 3SAT formata da $k$ parentesi (clausole) ognuna con 3 letterali, sia $phi=(a_1 or b_1 or c_1) and ... and (a_k or b_k or c_k)$. Vogliamo costruire un grafo in cui se troviamo una "clique" di grandezza $k$ significa che abbiamo trovato la soluzione alla formula. $chevron.l G,k chevron.r$ t.c. $phi in "3SAT" arrow.double.r.l chevron.l G,k chevron.r in "CLIQUE"$

Per ogni letterale di ogni parentesi disegnamo un nodo, inseriamo archi fra tutti i nodi ad eccezione di due casi:
- Nessun arco fra nodi della stessa clausola
- Nessun arco deve formare una contraddizione, quindi non colleghiamo mai $x_i$ con $overline(x_i)$


$(arrow.double.r)$ - Se la formula é soddisfatta allora c'é la clique: Se la formula $phi$ é vera significa che abbiamo trovato una combinazione logica che accende almeno un letterale in ogni parentesi. Coloriamo nel grafo i nodi corrispondenti a questi letterali e siccome appartengono a clausole diverse, per costruzione, saranno collegati.

$(arrow.double.l)$ - Se c'é la clique, allora la formula é soddisfatta: Supponiamo quindi di aver trovato una clique nel grafo, dato che non ci sono archi fra nodi della stessa clausola l'unico modo per avere $k$ nodi connessi é averne preso uno per ogni clausola, inoltre non ci sono contraddizioni sempre perché sono tutti connessi. Accendendo i letterali corrispondenti abbiamo trovato una formula valida.

Costruire il grafo richiede tempo polinomiale e anche risolvere la clique nel grafo equivale esattamente a risolvere la formula 3SAT, abbiamo dimostrato che CLIQUE é NP-COMPLETO.


Adesso ci chiediamo se esiste un linguaggio $L in N P$ e $L in.not P$ ma non NP-Completo.

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
  title: [*Teorema di Ladner*],
  [
    Esistono linguaggi $in.not P$ ma $in N P$ e non NP-Completi

    Ovvero linguaggi che non sappiamo risolvere velocemente ma che non sono abbastanza "potenti" da fare da chiave per la riduzione per tutta la classe NP.
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
  title: [*Definizione*],
  [
    $ "coNP" = {L | overline(L) in N P} $

    Fino ad adesso abbiamo visto che i linguaggi in NP sono facili da verificare, ovvero se la risposta al problema é "SI" esiste un certificato veloce da verificare. coNP é l'opposto, se la risposta é "NO" allora esiste un certificato veloce da verificare.

    Osserviamo che $"coNP" eq.not overline("NP")$
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
    $ "SAT" in P arrow.double.r.l "UNSAT" in P $
  ]
)

*Dimostrazione* - Se $"SAT" in P$ allora esiste una TM di tempo polinomiale che data $chevron.l phi chevron.r$ accetta $arrow.double.r.l phi in "SAT"$. Per decidere UNSAT scambio ACCEPT con REJ. 

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
    $P$ é chiusa per complemento: $ L in P arrow.double.r.l overline(L) in P space (P = "coP") $
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
    $ "EXP" = "coEXP" $
  ]
)

Questi teoremi ci dicono essenzialmente che la classe P e coP sono la stessa cosa, infatti se un linguaggio appartiene ad una delle due ed essite quindi una TM deterministica in tempo polinomiale, ci basta invertire gli output di questa.

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
    $ "coNP" subset.eq "EXP" $
  ]
)

*Dimostrazione* - Sia $L in "coNP"$, allora abbiamo che $overline(L) in "NP" subset.eq "EXP"$ questo significa che $L in "coEXP"="EXP"$

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
    $ P subset.eq "coNP" $
  ]
)

*Dimostrazione* - Prendiamo un problema $L in P$ e visto che $P$ é chiuso per complemento abbiamo $overline(L) in P$. Sappiamo che $P subset.eq "NP"$ e quindi $overline(L) in N P$ ma allora $L in "coNP"$.

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
    $ P=N P arrow.double.r P = "coNP" $
  ]
)

*Dimostrazione* - Se $L in "coNP"$ allora $overline(L) in N P$ ma dato che $P = N P$ il suo inverso sta anche in $P$. Ma se invertiamo le risposte abbiamo quindi che anche $L in P$. Quindi se NP collassasse dentro $P$ allora si porterebbe con se anche $"coNP"$.

*Corollario* - Basandoci sul teorema precedente allora possiamo anche dire che $"NP"eq.not"coNP" arrow.double.r P eq.not "NP"$.

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
    $ "NP"="coNP" arrow.double.r.l "UNSAT" in "NP" $
  ]
)

*Dimostrazione* - Prima dimostriamo ($arrow.double.r$), quindi sia $"NP" = "coNP"$ allora $"UNSAT" in "coNP"$ che é uguale a $"NP"$.

$(arrow.double.l)$ - Sia $"UNSAT" in "NP"$. Prendiamo $L in "coNP"$ quindi $overline(L) in "NP"$. Per NP-Completezza, abbiamo $overline(L) lt.eq_m^p "SAT"$ e quindi $overline(L) lt.eq_m^p "SAT" arrow.double.r.l L lt.eq_m^p "UNSAT"$. Ma UNSAT $in N P$ quindi $L in "NP"$.

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
  title: [*Definizione* - coNP-Completezza],
  [
    Un linguaggio $L$ è coNP-Completo se:
    - $L in "coNP"$
    - $forall A in "coNP", A lt.eq_m^p L$
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
    "UNSAT" é NP-Completo
  ]
)

*Dimostrazione* - Sappiamo che UNSAT $in$ coNP. Inoltre $A lt.eq_m^p "UNSAT" arrow.double.r.l overline(A) lt.eq_m^p "SAT"$. Visto che SAT é NP-Completo allora $overline(A) lt.eq_m^p "SAT"$.

Quindi visto che $overline(A) lt.eq_m^p "SAT"$ si ha anche $A lt.eq_m^p "UNSAT"$.

Quindi abbiamo che:
- Se $L in N P$ allora esiste un verificatore in tempo polinomiale $V(x,y)$ tale che $forall x, x in L arrow.double.r.l exists y "t.c." V(x,y)="ACC"$

- Se $L in "coNP"$ allora esiste un verificatore in tempo polinomiale $V(x,y)$ tale che $forall x, x in.not L arrow.double.r.l exists y "t.c." V(x,y)="ACC"$

== Space Complexity
Vogliamo misurare l'efficienza delle TM in termini di spazio.

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
  title: [*Definizione* - Complessitá di Spazio],
  [
    La complessitá di spazio di un decisore $M$ é una funzione $ S:NN arrow.r NN "t.c." S(n)="max"_(x, |x|=n) {\#"celle del nastro scritte da" M(x)} $
  ]
)

Dato che l'input ha dimensione $n$ non vogliamo essere penalizzati dalla sua lettura, cambiamo quindi il modello di TM.

$M$ ha due nastri, uno di input in sola lettura e quello di output che sará quello di lavoro. Consideriamo ad esempio la TM multinastro, per la complessitá di tempo passare da una multinastro ad una singolo genera un overhead da $T(n)$ a $O(t(n)^2z)$. Per lo spazio invece soltanto da $S(n)$ a $O(S(n))$.

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
    $ "SPACE"(f(n))={L | exists "TM" M "con complessitá di spazio" O(f(n)) "t.c." L(M)=L} $
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
  title: [*Definizione*],
  [
    $ "NSPACE"(f(n))={L | exists "NTM" N "con complessitá di spazio" O(f(n)) "t.c." L(M)=L} $
  ]
)

*Osservazioni*:
- Per quanto riguarda il tempo, la complessitá è almeno lineare in $n$ dato che la TM deve leggere l'input.
- Per lo spazio invece la complessitá é almeno $log n$, possiamo "ignorare" l'input e considerare soltanto la memoria necessaria a far funzionare l'algoritmo con una variabile che ricorda a che punto dell'input siamo, per contenerlo tutto serve quindi almeno $log n$ spazio.

Per la complessitá di spazio le principali classi sono:
- $L = "SPACE"(log n)$ e $"NL" = "NSPACE"(log n)$. Quindi i problemi risolvibili usando una memoria proporzionale al logaritmo dell'input.

- $"PSPACE"=union_k "SPACE"(n^k)$ e $"NSPACE"=union_k "NSPACE"(n^k)$. Problemi risolvibili con una memoria polinomiale rispetto all'input.

- $"EXPSPACE"=union_k "SPACE"(2^n^k)$ e $"NEXSPACE"=union_k "NSPACE"(2^n^k)$

Mettendo tutto insieme con anche le complessitá di tempo abbiamo: $ P subset.eq "NP" subset.eq "PSPACE" subset.eq "EXP" subset.eq "NEXP" subset.eq "EXPSPACE" $

- $N subset.eq "NP"$: Lo sapevamo da prima

- $"NP" subset.eq "PSPACE"$: Un problema risolvibile in modo non deterministico in tempo polinomiale possiamo risolverlo con memoria polinomiale, infatti basta esplorare un ramo alla volta e tenere in memoria soltanto quel ramo.

- $"PSPACE" subset.eq "EXP"$: Se una TM ha a disposizione uno spazio polinomiale, quante configurazioni diverse puó assumere il nastro prima di ripetersi? Un numero esponenziale, quindi se la macchina lavorasse in tempo esponenziale finirebbe in un loop.

- $"EXP" subset.eq "NEXP"$: Come P ed NP ma in tempo esponenziale.

- $"NEXP" subset.eq "EXPSPACE"$: Stesso funzionamento del punto 2 ma usiamo ordini di grandezza esponenziali.

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
    $ "TIME"(f(n)) subset.eq "SPACE"(f(n)) $
  ]
)

*Dimostrazione* - Una TM con tempo $O(f(n))$ puó scrivere al piú $O(f(n))$ celle.

*Corollario* - $P subset.eq "PSPACE", "NP" subset.eq "NPSPACE"$

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
    $ "NP" subset.eq "PSPACE" $
  ]
)

*Dimostrazione* - Segue dal teorema di Savitch (si vede dopo) ma si puó dimostrare anche direttamente.

Sappiamo che $A in "NP"$ se esiste una TM in tempo polinomiale che $forall x, x in L arrow.double.r.l exists y "t.c." V(x,y)=1$. Siccome $V$ é in tempo polinomiale allora $|y|=p(n)$ per un polinomio $p$.

Per decidere $A$ in spazio polinomiale:
- Memorizzo il candidato $y$ sul nastro di lavoro 1.
- Simulo $V(x,y)$ sul nastro 2.
- Se $V(x,y)$ accetta, accetto; altrimenti passo all'$y$ successivo riutilizzando lo stesso spazio.

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
  title: [*Teorema* - Lo spazio limita il tempo],
  [
    Per ogni $f(n) gt.eq log n, "SPACE"(f(n)) subset.eq "DTIME"(2^(O(f(n))))$
  ]
)

Quello che ci dice il teorema é che se un algoritmo usa una memoria pari a $f(n)$ allora il tempo massimo che impiegherá per arrivare a una soluzione sará proporzionale a un'esponenziale di quello spazio ovvero $2^(O(f(n)))$

*Dimostrazione* - La dimostrazione si basa sul "fotografare" la TM durante l'esecuzione e vedere quante configurazioni possibili ci sono, se la macchina si trova due volte nella stessa configurazione significa che é andata in loop ma stiamo parlando di un decisore quindi non accadere.

Quindi abbiamo che il tempo di esecuzione deve essere minore o uguale al numero totale di configurazioni possibili. Ma quante sono?

- $|Q|$: Stati della TM

- $f(n)$: Posizione della testina, dato che il nastro é lungo al massimo $f(n)$ la testina puó trovarsi in una di queste celle.
- $n$: Nastro di input, anche qui la testina puó trovarsi in una di queste celle, dato che abbiamo imposto che $f(n) gt.eq log n$, per le regole dei logaritmi possiamo dire che $n lt.eq 2^(f(n))$.
- $|Gamma|^(f(n))$: È il nastro di lavoro, abbiamo $f(n)$ celle che possiamo riempire con un alfabeto di $|Gamma|$ simboli, quindi le combinazioni totali sono $|Gamma|^(f(n))$.

Moltiplichiamo tutto fra loro, $|Q|$ e $|Gamma|$ sono costanti, $f(n)$ é un valore piccolo per una potenza di 2 ($2^(f(n))$) e per un'altra potenza $|Gamma|^(f(n))$, quindi il risultato asintotico é $2^(O(f(n)))$, il valore é limitato dallo spazio utilizzato.

*Corollario*:
- $L subset.eq P$. Se la complessitá di spazio é logaritmica cioé in L, applicando la formula del tempo $2^(O(log(n)))$, per le proprietá dei logaritmi, l'esponenziale e il logaritmo si annullano e il risultato diventa un polinomio. Quindi se si usa spazio logaritmico si impiega tempo polinomiale.

- $"PSPACE" subset.eq "EXP"$: Se invece lo spazio é un polinomio e applichiamo la formula per il tempo $2^(O(n^k))$ otteniamo un tempo esponenziale.

Mettendo insieme tutto quello che abbiamo scoperto $ L subset.eq P subset.eq "PSPACE" subset.eq "EXP" $
Sappiamo che $P eq.not "EXP"$ e quindi o $P eq.not "PSPACE"$ o $"PSPACE" eq.not "EXP"$ o entrambi.

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
    $ "PATH" in "SPACE"(log^2 n) $
  ]
)

*Dimostrazione* - PATH é il problema che ci dice se esiste un percorso tra un nodo di partenza $s$ e un nodo di arrivo $t$, se il percorso esiste non puó essere piú lungo di $n$ nodi del grafo. Per comoditá arrotondiamo la lunghezza massima alla potenza di 2 piú vicina, quindi se ad esempio i nodi sono 100 cerchiamo i percorsi lunghi fino a $2^7=128$, lunghezza massima che ci interessa é quindi $2^k$ dove $k$ é approssimativamente $log_2 (n)$.

Quindi formalmente la funzione PATH? prende in input $(x,y,k)$ e ritorna "SI" $arrow.double.r.l exists x arrow.r.squiggly y$ con lunghezza $lt.eq 2^k$.

L'idea alla base della funzione é che se esiste questo percorso allora deve esiste un nodo a metá strada $w$ t.c.:
- Possiamo percorrere da $x$ a $w$ nella prima metá di passi cioé $2^(k-1)$
- Possiamo arrivare da $w$ a $y$ nella seconda metá cioé $2^(k-1)$

La funzione é definita in modo ricorsivo:
- Caso Base $(k=0)$: Se il limite é $2^0=1$ passi controlliamo subito se esiste un arco tra $x$ ed $y$, oppure se $x=y$, in caso positivo accetto.
- Passo Ricorsivo: Come detto prima allora deve esiste un nodo $w$ t.c.:
  - $x arrow.r.squiggly w$ in $lt.eq 2^(k-1)$ passi
  - $w arrow.r.squiggly y$ in $lt.eq 2^(k-1)$ passi
  Ovvero chiede prima $"PATH?"(x,w,k-1)$ e poi in AND $"PATH?"(w,y,k-1)$

In ogni chiamata della funzione devo memorizzare $x,y,k$ e il nodo intermedio $w$. Per memorizzare l'indice di un nodo in un grafo da $n$ nodi ho bisogno di $O(log n)$ spazio.

Ma quante chiamate si "impilano" nello stack? La prima chiamata inizierá da $k=log n$ ovvero misurare la lunghezza massima, poi ogni volta faremo $k-1$ fino ad arrivare a 0, ogni livello ha si due chiamate ma utilizzano sempre la stessa memoria quindi anche qui abbiamo $O(log n)$. (Simile ad una ricerca binaria praticamente).

Mettendo tutto insieme abbiamo complessitá di spazio:$ O(log n) times O(log n) = O(log n)^2 $

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
  title: [*Teorema di Savitch*],
  [
    Data una funzione $f(n) gt.eq log n$ si ha $"NSPACE"(f(n)) subset.eq "DSPACE"(f^2 (n))$
  ]
)

Il teorema ci dice che qualsiasi cosa noi facciamo in modo non deterministico utilizzando uno spazio $f(n)$ possiamo simularlo in modo deterministico utilizzando spazio $f(n)^2$.

Sia $N$ una NTM t.c. $L(N) in "NSPACE"(f(n))$. Per comoditá facciamo in modo che $N$ prima di accettare cancelli tutto il nastro si metta in uno specifico stato accettante $q_"acc"$. Chiamiamo questa configurazione $c_"acc"$ mentre la configurazione di partenza $q_"start"$.

Adesso immaginiamo la macchina $N$ non come un nastro ma un *grafo orientato*, il grafo $G_(N,w)$:
- Ad ogni nodo corrisponde una configurazione della macchina
- Gli archi collegano un nodo A ad un nodo B se le regole di $N$ permettono di passare dalla configurazione $A$ alla configurazione $B$ durante l'esecuzione di $w$

A questo punto il problema non é piú se la macchina N accetta ma se esiste un percorso che ci porta da $c_"start"$ a $c_"acc"$.

Quanti nodi ha questo grafo? Per il teorema "Spazio limita il Tempo" abbiamo dimostrato che se una TM usa spazio $f(n)$ allora puó assumere un numero massimo di configurazioni pari a $2^(O(f(n)))$, quindi il grafo ha un numero esponenziale di nodi, chiamiamo questo numero $m=2^(O(f(n)))$.

Adesso possiamo definire una TM $M$ che utilizza l'algoritmo `PATH?` chiedendo di trovare un percorso da $c_"start"$ a $c_"acc"$ lungo al massimo $m$ passi.

Se $M$ provasse a generare tutto il grafo occuperebbe spazio $m$, dobbiamo risparmiare spazio. L'algoritmo `PATH?` ha bisogno di sapere se esiste un arco tra il nodo A e il nodo B, M controlla le regole di base della macchina originale N e senza costruire il grafo risponde SI/NO.

- Sappiamo che `PATH?` su un grafo di $m$ nodi consuma uno spazio pari a $log^2 m$ e sappiamo che $m=2^(O(f(n)))$

- Sostituendo otteniamo che la TM M occupa $O((log (2^(f(n))))^2)$
- Logaritmo e l'esponenziale base 2 si annullano quindi $O((O(f(n)))^2)$
- Otteniamo quindi $O(f^2 (n))$

*Corollari*
- $"PSPACE" = "NSPACE"$: Se una macchina non-deterministica usa uno spazio polinomiale (es. $n^3$) allora per il Teorema di Savitch possiamo simularla deterministicamente usando il quadrato di quello spazio, quindi $n^6$ ma é sempre un polinomio.

- $"NL" subset.eq "DSPACE"(log^2 n)$

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
    $ "NL" subset.eq P $
  ]
)

Se $A in "NL"$ allora esiste una NTM che decide $A$ con spazio $O(log n)$, questo significa che il numero di configurazioni é $2^(O(log n))$, per le regole dei logaritmi questo equivale ad un polinomio. Dato che il grafo delle configurazioni ha grandezza polinomiale ci basta usare `PATH` per risolvere in tempo polinomiale e quindi $"NL" subset.eq "P"$.

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
  title: [*Definizione* - Riduzione Logaritmica],
  [
    $A lt.eq_m^l B$ se esiste $R: Sigma^* arrow.r Sigma^*$ calcolabile in $O(log n)$ spazio tale che $forall x in Sigma^*, x in A arrow.double.r.l R(x) in B$
  ]
)

Questa ci serve appunto per mostrare la NL-Completezza, per mostrare infatti che tutti gli altri problemi sono riducibili ad un problema non possiamo usare una riduzione che impiega tempo polinomiale altrimenti questa potrebbe tranquillamente risolvere il problema senza tradurlo.

Peró la difficoltá sta nel fatto che se una macchina usa spazio $O(log n)$ puó comunque girare per un tempo polinomiale prima di fermarsi, lavorando per questo tempo l'output finale potrebbe risultare troppo lungo per lo spazio, per scrivere l'output si usa quindi un altro nastro WRITE-ONCE che non conta ai fini della complessitá dello spazio.

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
  title: [*Definizione* - NL-Completezza],
  [
    $B$ é NL-Completo se:
    - $B in "NL"$
    - $forall A in "NL", A lt.eq_m^l B$
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
    Se $P,Q$ calcolabili in log-space anche $R(x)=Q(P(x))$ é calcolabile in log-space
  ]
)

*Dimostrazione*
1. $R$ fa partire $Q$
2. Quando $Q$ legge l'i-esimo bit del suo input e non lo trova
3. $R$ mette in pausa $Q$
4. $R$ fa partire $P$ da 0, $R$ ignora tutti i bit che sputa $P$ ma tiene il conto con un contatore (che occuperá soltanto $log n$)
5. Quando $P$ restituirá l'i-esimo bit, $R$ lo prende e lo passa a $Q$, spegne $P$ e fa ripartire $Q$ dalla pausa.

*Corollari*
- $A lt.eq_m^l B$ allora $B in L arrow.double.r A in L$

- $A lt.eq_m^l B$ allora $B in "NL" arrow.double.r A in "NL"$

- $A lt.eq_m^l B$ allora $B lt.eq_m^l C arrow.double.r A lt.eq_m^l C$

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
    PATH é NL-COMPLETO
  ]
)

*Dimostrazione* - Sappiamo che PATH é NL-HARD perché nel Teorema di Savitch abbiamo visto che una NTM $M$ con spazio $O(log n)$ accetta su $x arrow.double.r.l exists G_(N,x)$ con PATH $c_"start" arrow.r.squiggly c_"acc"$.

Ora dobbiamo mostrare che PATH $in "NL"$ ovvero che puó essere risolto da una macchina non-deterministica usando una memoria minuscola di $O(log n)$.

Costruiamo quindi questa macchina:
- Su input $G,s,t$
- Se $s=t$ accetta
- Calcola in $O(log n)$ spazio $n = |V|$
- Crea una variabile `currNode` e ci salva $s$
- Per $i=1,...,n$
  - Sceglie in modo non-deterministico un nodo $u$
  - Se $u=t$ accetta
  - Se $("currNode",u) in E$ imposta currNode = $u$
  - Se $("currNode",u) in.not E$ rifiuta.
- Rifiuta

La macchina non ricorda mai l'intero percorso ma soltanto tre cose:
- Il nodo finale $t$
- A che numero di passo é arrivata $i$
- Su quale nodo si trova in questo momenot `currNode`

Quindi $3 dot O(log n)=O(log n)$.

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
  title: [*Teorema* - Time Hierarchy Theorem],
  [
    Sia $t_1 (n) << t_2 (n)$ allora esiste $L in "DTIME"(t_2 (n))$ e $L in.not "DTIME"(t_1 (n))$.
  ]
)

Il teorema ci dice che se abbiamo due classi di tempo con una grande differenza fra loro, allora esiste un problema che é risolvibile in quella piú grande ma non in quella piú piccola.

*Dimostrazione* - Per dimostrare che questo linguaggio esiste costruiamo la macchina $D(x)$:
1. Usiamo l'input $x$ per costruire una TM $M_x$
2. Simula $M_x (x)$ per un tempo di $t_(1.5) (n)$ con $t_1 << t_(1.5) << t_2$
3. Se $M_x (x)$ accetta, rifiuto
4. Se $M_x (x)$ rifiuta, accetta
5. Se $M_x (x)$ non termina entro il timer, accetta.

Analisi:
- $L(D) in "DTIME"(t_2 (n))$ perché la macchina $D$ impiega la maggior parte del tempo con il timer che é di soli $t_(1.5)$ e qualcosa di overhead. Quindi il tempo totale rimane $lt.eq t_2$.

- $L(D) in.not "DTIME" (t_1 (n))$: Supponiamo ci sia un programma $Q lt.eq t_1 (n)$ che é in grado di riconoscere lo stesso linguaggio di $D$, siccome il timer di $D$ é $t_(1.5) (n)$ il timer é piú che sufficiente. $D$ riuscirá a finire la simulazione di $Q$.

Alla fine della simulazione $D$ restituirá il contrario di $Q$. Se $D$ dá sempre la risposta opposta a $Q$ quando ricevo in input $Q$ stesso, significa che $D$ e $Q$ stanno calcolando cose diverse, ma avevamo supposto che calcolassero lo stesso linguaggio. Il linguaggio di $D$ é troppo difficile per stare in $"DTIME"(t_1 (n))$.

*Osservazione* - Per fare in modo che la disuguaglianza asintotica funzioni dobbiamo aggiungere un valore `junk` di padding a $Q$ fino a superare la soglia per cui $t_(1.5) >> t_1$. In questo modo abbiamo $n$ grandissimo e $D$ ha tempo di finire l'esecuzione.

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
  title: [*Teorema* - Space Hierarchy Theorem],
  [
    Siano $s_1 (n) gt.eq log n$ e $s_2 (n)$ t.c. $s_2 (n) in omega (s_1 (n))$ allora $exists L "t.c." L in "SPACE"(s_2 (n)) "ma" L in.not "SPACE"(s_1 (n))$
  ]
)

Anche qui il teorema ci dice che se esistono due classi di spazio con una grande differenza fra loro, esiste un problema che posso risolvere in quella grande ma non in quella piccola.

*Dimostrazione* - Come prima costruiamo una macchina $D$ che prende in input $x$ e costruisce una macchina $M_x$:
- $D$ segna sul suo nastro un'area di dimensione $s_2 (|x|)$
- Inizializza un contatore su un altro nastro con un valore massimo $2^(O(s_2 (n)))$, se il contatore supera questo limite significa che la macchina é andata in loop.
- Simula $M_x$:
  - Se $M_x$ supera lo spazio allocato, accetta
  - Se il contatore raggiunge il massimo, accetta
  - Se $M$ termina e accetta, rifiuta; se termina e rifiuta, accetta.


In questo modo otteniamo che:
- $L(D) in "SPACE"(s_2 (n))$ infatti abbiamo allocato dello spazio che la macchina non puó superare.
- $L(D) in.not "SPACE"(s_1 (n))$: Supponiamo esista un problema $Q$ che riconosce lo stesso linguaggio di $D$ usando spazio $s_1 (n)$. Simuliamo $Q$ con $D$, lo spazio allocato basterá e non andrá nemmeno in loop e quindi la simulazione arriverá fino alla fine ma la macchina restituirá il contrario, abbiamo una contraddizione.