#import "@preview/showybox:2.0.4": showybox
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#show raw: set block(fill: none)
#show raw.where(block: false): set box(fill: none)

= Automi
\
== Linguaggi Regolari
\
Iniziamo introducendo in modo _informale_ cos'è un *Automa*.\
Un Automa è un modello matematico di calcolo che può elaborare informazioni e agire in modo automatico seguendo una serie di stati predefiniti.

Esistono diversi tipi di automi, il primo che vediamo si chiama *Automa a stati Finiti Deterministico (DFA)*, questo tipo di automa ha un *numero finito di stati* e processa gli input che riceve in modo *sequenziale* bit a bit.

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
  title: [*Esempio* - Sistema di controllo di una porta automatica],
  [
    La porta ha dei sensori "avanti" e "dietro" per rilevare i movimenti ed aprire la porta.
    #align(center, diagram(
      node-stroke: .1em,
      spacing: 4em,
      edge((-1.5,0), (0,0), "-|>", `start`, label-pos: 0.5, label-side: left),
      node((0,0), `Closed`, radius: 2em),
      edge(`avanti, dietro, entrambi`, "-|>", bend: 20deg, ),
      node((4,0), `Open`, radius: 2em),
      edge((4,0), (4,0), `avanti, dietro, entrambi`, "-|>", bend: 130deg),
      edge((4,0), (0,0), `nessun rilevamento`, "-|>", bend: 20deg),
      edge((0,0), (0,0), `no rilevamento`, "-|>", bend: 130deg)
    ))
  ]
)

Adesso però diamo una definizione più formale per i DFA.

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
  title: [*Definizione* - DFA],
  [
    Un DFA è una quintupla $(Q, Sigma, delta, q_0, F)$ dove:
    - $Q$: Insieme finito degli stati

    - $Sigma$: Insieme finito dei simboli in input (*alfabeto*)

    - $delta: Q times Sigma arrow.r Q$: *Funzione di Transizione*, ci dice come avvengono i passaggi di stato

    - $q_0$: Stato *iniziale*

    - $F subset.eq Q$: Insieme degli *stati di accettazione*
  ]
)

Nei nostri diagrammi indicheremo gli stati di accettazione, o finali, con un _doppio bordo_. Inoltre diciamo che un automa "accetta" un input se termina in uno stato di accettazione, altrimenti diremo che lo "rifiuta".

Vediamo quindi un altro esempio di DFA.

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
  title: [*Esempio* - DFA di un linguaggio binario],
  [
    #align(center, diagram(
      node-stroke: .1em,
      spacing: 3em,
      edge((-1.5,0), (0,0), "-|>", `start`, label-pos: 0.5, label-side: left),
      node((0,0), $q_1$, radius: 2em),
      node((2,0), $q_2$, radius: 2em, extrude: (-2.5,0)),
      node((4,0), $q_3$, radius: 2em),
      edge((0,0), (0,0), `0`, "-|>", bend: 130deg),
      edge((0,0), (2,0), `1`, "-|>", bend: 20deg),
      edge((2,0), (2,0), `1`, "-|>", bend: 130deg),
      edge((2,0), (4,0), `0`, "-|>", bend: 20deg),
      edge((4,0), (2,0), `0,1`, "-|>", bend: 20deg)
    ))
    Vediamo i vari elementi rispetto alla definizione che abbiamo dato prima:
    - $Q={q_1, q_2, q_3}$

    - $Sigma={0,1}$

    - $q_0 = q_1$

    - $F={q_2}$
    Mentre per la $delta$ possiamo o rappresentare una tabella o in questo caso semplicemente guardare le frecce del diagramma. Questo DFA, ad esempio, _accetta_ se riceve come input la stringa `w=11101`
  ]
)

Introduciamo altre definizioni che ci serviranno per definire in modo formale il concetto di *linguaggio accettato*.

In modo informale un linguaggio è l'insieme di tutte le stringhe rinosciute da un DFA, se ad esempio abbiamo il DFA $M$ allora l'insieme delle stringhe riconosciute da $M$ lo denotiamo con $L(M)$. Ad esempio il DFA dell'esempio precedente ha come linguaggio: $ A = {w | w "contiene almeno un '1' e un numero pari di '0' segue l'ultimo '1'"} $ E possiamo dire quindi che $L(M)=A$ o anche "$M$ riconosce $A$".

Per definire il linguaggio accettato dobbiamo modificare la funzione di transizione e introdurre la *funzione di transizione estesa*.

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
  title: [*Definizione* - Funzione di Transizione Estesa],
  [
    La denotiamo con $delta^*$ e ha lo stesso funzionamento della funzione di transizione classica, la differenza è che insieme allo stato accetta un'intera stringa e non un solo carattere.
    - $delta^*:Q times Sigma^* arrow.r Q$

    - $delta^*(q, epsilon)=delta (q, epsilon)$

    - $delta^*(q, a x) = delta^* (delta (q,a), x)$

    Con $Sigma^*$ indichiamo l'insieme delle stringhe in input e $x in Sigma^*, a in Sigma$. Questo significa quindi che la funzione di transizione estesa processa intere stringhe ma sempre in modo sequenziale carattere per carattere.
  ]
)

Introduciamo anche il concetto di *configurazione*, ovvero lo stato in cui si trova il DFA, in particolare è definita come una tupla $(q,x) in Q times Sigma^*$ e indica appunto lo stato in cui si trova l'automa e quello che gli resta da leggere. La configurazione iniziale è quella che si trova nello stato $q_0$ quindi ad esempio $(q_0, x)$.

Adesso possiamo definire anche il *passo di computazione* ovvero una relazione binaria tra configurazioni che ci porta appunto da una configurazione ad un'altra. Si ha: $ (p,a x) scripts(tack.r)_M (q,x) arrow.double.r.l delta(p,a)=q $

Con $p,q in Q, a in Sigma, x in Sigma^*$. Stiamo dicendo quindi che passiamo dalla configurazione $(p,a x)$ alla configurazione $(q,x)$ leggendo $a$ (ci resta poi da leggere $x$) che è equivalente a dire che da $p$ passiamo a $q$ se leggiamo $a$.

Anche la relazione binaria $scripts(tack.r)_M$ può essere estesa considerando la *chiusura riflessiva e transitiva* e la denotiamo con $scripts(tack.r)_M^*$:
- $(q,x) scripts(tack.r)_M^* (q,x)$, ovvero quando non legge nessun input.

- $(q, a b y) scripts(tack.r)_M (p, b y) and (p, b y) scripts(tack.r)_M (r, y) arrow.double.r (q, a b y) scripts(tack.r)_M^* (r, y)$, possiamo quindi raccogliere piú passi di configurazione.

Con $p,q,r in Q; a,b in Sigma; y in Sigma^*$

Adesso possiamo finalmente utilizzare tutti questi concetti per formalizzare la definizione di *linguaggio accettato*.

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
  title: [*Definizione* - Linguaggio Accettato],
  [
    Diciamo che $x in Sigma^*$ è accettato da $M=(Q, Sigma, delta, q_0, F)$ se $ delta^* (q_0, x) in F " oppure " (q_0, x) scripts(tack.r)_M ^* (q, epsilon) "con" q in F $
    Possiamo definirlo anche come insieme ovvero $L(M)={x in Sigma^* : delta^* (q_0,x) in F}$
  ]
)

Adesso che sappiamo cos'è un DFA e il suo linguaggio accettato, possiamo definire i *linguaggi regolari*.

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
  title: [*Definizione* - Linguaggio Regolare],
  [
    Un linguaggio è chiamato *regolare* se un DFA lo riconosce, indichamo con `REG` l'insieme dei linguaggi regolari: $ "REG" = {L subset.eq Sigma^* | exists "DFA" M "t.c." L(M)=L} $
  ]
)

Ci interessa capire come costruire un DFA dato un certo linguaggio, ad esempio prendiamo il linguaggio: $ L = {x in {0,1}^* | x = 1||y, y in {0,1}^*} $

L'operatore $||$ indica la concatenazione di stringhe, in questo caso quindi stiamo indicando tutte le stringhe che iniziano con $1$. Proviamo a costruire un DFA $A$ che riconosce il linguaggio:

#align(center, diagram(
  node-stroke: .1em,
  spacing: 2em,
  edge((-1.5,0), (0,0), "-|>", `start`, label-pos: 0.5, label-side: left),
  node((0,0), $q_0$, radius: 2em),
  node((0,2), $q_2$, radius: 2em),
  node((2,0), $q_1$, radius: 2em, extrude: (-2.5,0)),
  edge((0,0), (2,0), `1`, "-|>", bend: 20deg),
  edge((0,0), (0,2), `0`, "-|>", bend: -20deg),
  edge((2,0), (2,0), `0,1`, "-|>", bend: 130deg),
  edge((0,2), (0,2), `0,1`, "-|>", bend: -130deg, loop-angle: 180deg)
))

Lo stato $q_2$ viene chiamato "stato pozzo", ovvero uno stato non di accettazione che non ha archi uscenti verso altri stati. Possiamo disegnare anche un DFA equivalente senza gli archi di $q_2$:

#align(center, diagram(
  node-stroke: .1em,
  spacing: 2em,
  edge((-1.5,0), (0,0), "-|>", `start`, label-pos: 0.5, label-side: left),
  node((0,0), $q_0$, radius: 2em),
  node((2,0), $q_1$, radius: 2em, extrude: (-2.5,0)),
  edge((0,0), (2,0), `1`, "-|>", bend: 20deg),
  edge((2,0), (2,0), `0,1`, "-|>", bend: 130deg)
))

In questo caso se in $q_0$ riceviamo 0 semplicemente ignoramo l'input.

Adesso peró vogliamo dimostrare la correttezza del DFA appena costruito, ovvero dimostrare che il DFA accetta $x$ *se e solo se* $x in L$. Costruiamo una dimostrazione per induzione, per prima cosa però notiamo due cose nel nostro DFA:
- $delta^* (q_1, u) = q_1 space forall u in {0,1}^*$

- $delta^* (q_2, u) = q_2 space forall u in {0,1}^*$

Stiamo dicendo che se entriamo in $q_1$ o $q_2$ non andremo più in altri stati. Adesso iniziamo la dimostrazione per induzione:

- *Caso Base* - Abbiamo $|x|=0$ ovvero $x=epsilon$ stringa vuota. Si ha che
  $ delta^* (q_0, epsilon)=delta (q_0, epsilon)= q_0 in.not F $

- *Ipotesi Induttiva* - Sia $n > 0$, supponiamo $|w| lt.eq n$. Si ha:
  $ delta^* (q_0, w) = cases(
    q_1 "se" w "inizia con" 1,
    q_2 "se" w "inizia con" 0
  ) $
  Possiamo dirlo perchè abbiamo visto all'inizio che una volta entrati in $q_1$ o $q_2$ il DFA non cambia più stato.

- *Passo Induttivo* - Prendiamo $x$ t.c. $|x|=n+1$, possiamo scomporla in $x=a u$ con $a in {0,1}$ e $u in {0,1}^*$. Otteniamo quindi $ delta^* (q_0,x)=delta^* (q_0, a u) = delta^* (underbrace(delta (q_0, a), "ha 2 soluzioni"), u) $
  Le 2 soluzioni sono quelle che abbiamo visto nell'ipotesi induttiva, infatti:
  $ delta(q_0, a) = cases(
    q_2 & "se" a = 0,
    q_1 & "se" a = 1
  ) $

  Dato che abbiamo dimostrato che l'automa non uscirá mai da nessuno dei due stati e che entra sicuramente in uno dei due possiamo quindi dire che: $ delta^* (q_0, x) = q_1 arrow.double.r.l a = 1 $

== Operazioni sui Linguaggi
\
I linguaggi non sono altro che insiemi di stringhe, questo significa che possiamo applicare delle operazioni su di essi, vediamole alcune:

- *Unione*: $L_1 union L_2 = {x in Sigma^* | x in L_1 or x in L_2}$

- *Intersezione*: $L_1 union L_2 = {x in Sigma^* | x in L_1 and x in L_2}$

- *Complemento*: $overline(L_1) = {x in Sigma^* | x in.not L_1}$

- *Concatenzaione*: $L_1 op(circle.small) L_2 = {x y} | x in L_1 and y in L_2}$ importante notare che non é commutativi quindi $L_1 op(circle.small) L_2 eq.not L_2 op(circle.small) L_1$.

  Vediamo un esempio, prendiamo:
  - $Sigma={a,b}$

  - $L_1 = {a, a b, b a}$

  - $L_2 = {a b, b}$

  Otteniamo $L_1 op(circle.small) L_2 = {a a b, a b, a b a b, a b b, b a a b, b a b}$ 

- *Potenza*: La definiamo in modo ricorsivo
  $ "per stringhe" cases(
    x^0 &= epsilon,
    x^(n+1)&=x^n x
  ) 
  space "; per linguaggi" cases(
    L^0 &= {epsilon},
    L^(n+1) &= L^n op(circle.small) L
  )
  $

  Quindi ad esempio se prendiamo $L={a, a b, b a}$ possiamo dire: $ L^2=L op(circle.small) L = {a a, a a b, a b a, a b a, a b a b, a b b a, b a a, b a a b, b a b a} $

- *Operatore \**: $L^*=op(union.big)_(n gt.eq 0) L^n= {epsilon} union L^1 union L^2 union ...$ ovvero tutte le combinazioni di stringhe possibili. Ad esempio se $L={a,b}$ abbiamo $L^*={epsilon, a, b, a a, a b, b a, b b, a a a ,...}$

== Non Determinismo
\
Per ora abbiamo visto come un DFA che si trova in uno stato quando processa un input farà un solo movimento verso un altro stato, oppure rimane nello stesso. Nel non determinismo invece abbiamo dei comportamenti diversi:
- Quando un automa si trova in uno stato e processa un input può andare in *diversi* stati *contemporaneamente*.

- Sono ammessi gli $epsilon$-archi, ovvero degli archi che non hanno bisogno di input per essere percorsi.

- L'automa a questo punto, visto che esplora più rami di computazione contemporaneamente, accetta se esiste almeno un ramo che accetta. Vedremo successivamente cosa significa "ramo di computazione".

A questo punto non parliamo più di DFA ma di *NFA* ovvero automi *non deterministici* a stati finiti.

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
  title: [*Definizione* - NFA],
  [
    Un NFA è una tupla $(Q, Sigma, delta, q_0, F)$ dove tutti gli elementi sono come per i DFA ma abbiamo un cambio nella funzione di transizione. infatti questa diventa:

    - $delta:Q times Sigma_epsilon arrow.r cal(P)(Q)$ con $Sigma_epsilon$ indichiamo $Sigma union {epsilon}$, mentre con $cal(P)(Q)$ l'insieme delle parti di $Q$ ovvero l'insieme di tutti i possibili sottoinsiemi di $Q$
  ]
)

Per chiarire il concetto di "ramo di computazione" vediamo un esempio di NFA. Costruiamo un NFA che riconosce il linguaggio $ L={x:x in {0,1}^* and x "ha un '1' in terzultima posizione"} $

Costruiamo l'NFA:

#align(center, diagram(
  node-stroke: .1em,
  spacing: 1.5em,
  edge((-1.5,0), (0,0), "-|>", `start`, label-pos: 0, label-side: left),
  node((0,0), $q_0$, radius: 2em),
  node((2,0), $q_1$, radius: 2em),
  node((4,0), $q_2$, radius: 2em),
  node((6,0), $q_3$, radius: 2em, extrude: (-2.5,0)),
  edge((0,0), (0,0), `0,1`, "-|>", bend: 130deg),
  edge((0,0), (2,0), `1`, "-|>", bend: 20deg),
  edge((2,0), (4,0), `0,1`, "-|>", bend: 20deg),
  edge((4,0), (6,0), `0,1`, "-|>", bend: 20deg),
))

Cosa succede quanto l'NFA computa la stringa `10110`? In un NFA quando uno stato permette più transizioni si creano più rami, uno per ogni strada presa, ad esempio con l'NFA appena costruito se inseriamo la stringa `10110` con il primo carattere 1 l'NFA andrà sia in $q_0$ che in $q_1$ e questo porta la creazione di due rami di computazione. L'automa accetta se esiste almeno un ramo fra questi che accetta. Per chiarezza vediamo quali rami si creano in questo esempio:

#align(center, diagram(
  spacing: 1em,
  // Radice
  node((0,0), $q_0, 10110$),
  // 1
  node((-2,2), $q_0, 0110$),
  node((2,2), $q_1, 0110$),
  // 2
  node((2,4), $q_2, 110$),
  node((-2,4), $q_0, 110$),
  // 3
  node((2,6), $limits(q_3\, 10)_"RIF"$),
  node((-3,6), $q_0, 10$),
  node((-1,6), $q_1, 10$),
  // 4
  node((-1,8), $q_2, 0$),
  node((-3.5,8), $q_0, 0$),
  node((-2.5,8), $q_1, 0$),
  // 5
  node((-1,10), $limits(q_3\, epsilon)_"ACC"$),
  node((-3.5,10), $limits(q_0\, epsilon)_"RIF"$),
  node((-2.5,10), $limits(q_1\, epsilon)_"RIF"$),
  
  edge((0,0), (-2,2), "-|>"),
  edge((0,0), (2,2), "-|>"),
  edge((-2,2), (-2,4), "-|>"),
  edge((-2,4), (-1,6), "-|>"),
  edge((-2,4), (-3,6), "-|>"),
  edge((-3,6), (-3.5,8), "-|>"),
  edge((-3,6), (-2.5,8), "-|>"),
  edge((-3.5,8), (-3.5,10), "-|>"),
  edge((-2.5,8), (-2.5,10), "-|>"),
  edge((-1,6), (-1,8), "-|>"),
  edge((-1,8), (-1,10), "-|>"),
  edge((2,2), (2,4), "-|>"),
  edge((2,4), (2,6), "-|>"),
))

Per quanto riguarda gli $epsilon$-archi invece, se l'automa si trova in uno stato che ne possiede uno allora l'automa si duplica in due rami senza leggere nessun input:
- Un ramo rimane nella stessa configurazione di prima.

- L'altro ramo segue l'$epsilon$-arco.

Vediamo un altro esempio per chiarire anche questo concetto.
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
  title: [*Esempio* - NFA con $epsilon$-archi],
  [
      #align(center, diagram(
      node-stroke: .1em,
      spacing: 2em,
      edge((-1,0), (0,0), "-|>", `start`, label-pos: 0, label-side: left),
      node((0,0), $q_0$, radius: 2em, extrude: (-2.5,0)),
      node((0,2), $q_1$, radius: 2em),
      node((2,0), $q_2$, radius: 2em),

      edge((0,0), (2,0), $epsilon$, "-|>", bend: 20deg),
      edge((0,0), (0,2), `b`, "-|>", bend: -20deg),
      edge((0,2), (0,2), `a`, "-|>", bend: 130deg, loop-angle: 180deg),
      edge((0,2), (2,0), `a,b`, "-|>", bend: -60deg),
      edge((2,0), (0,0), `a`, "-|>", bend: 20deg),
    ))

    Vediamo cosa succede con la computazione della stringa `babba`

    #align(center, diagram(
      spacing: 1em,
      // 0
      node((0,0), $q_0, b a b b a$),
      // 1
      node((1,-1), $q_1, a b b a$),
      node((1,1), $q_2, b a b b a "RIF"$),
      // 2
      node((2,-1), $q_2, b b a "RIF"$),

      // Archi
      edge((0,0), (1,-1), "-|>"),
      edge((0,0), (1,1), "-|>"),

      edge((1,-1), (2,-1), "-|>"),
    ))
  ]
)

Dobbiamo adesso rivedere i concetti di *configurazione, computazione ed accettazione* in un NFA:

- Dato un NFA $N$, indichiamo come configurazione una coppia $(q,x) in Q, Sigma_epsilon^*$

- Avremo $ (p,a x) op(tack.r)_N (q,x) arrow.double.l.r q in delta(p,a) space space space "con" x in Sigma_epsilon^*; a in Sigma_epsilon; p,q in Sigma $
  Da notare che $q,p$ non sono più degli stati singoli ma un insieme di stati infatti $q,p in cal(P)(Q)$, ovviamente possono anche contenere un singolo stato ma saranno comunque insiemi di stati.

- Un NFA $N$ accetta $ w in Sigma_epsilon^* arrow.r.l.double exists q in F "t.c." (q_0, w) op(tack.r)_N^* (q, epsilon) $

== Equivalenza tra DFA e NFA
\
Dimostriamo come in realtá le due classi di automi sono equivalenti. Per prima cosa definiamo in modo formale le due classi:

- $cal(L)("DFA") = "REG"$, quindi la classe dei linguaggi regolari, riconosciuti da almeno un DFA.

- $cal(L)("NFA") = {L|exists "NFA" N "t.c." L(N)=L}$, la classe dei linguaggi riconosciuti da almeno un NFA.

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
    $"REG":=cal(L)("DFA")=cal(L)("NFA")$
  ]
)

*Dimostrazione* - Formalmente vogliamo dimostrare $cal(L)("DFA") subset.eq cal(L)("NFA")$ e $cal(L)("NFA") subset.eq cal(L)("DFA")$

1. *Prima implicazione* $cal(L)("DFA") subset.eq cal(L)("NFA")$
  
  Dato $L in cal(L)("DFA")$ e $D:=(Q,Sigma,delta,q_0,F)$ t.c. $L=L(D)$. Notiamo che il concetto di NFA, in realtà, non è altro che una generalizzazione di un DFA, infatti se prendiamo un qualsiasi DFA possiamo dire che è anche un NFA, quindi $D$ è un NFA e $L in cal(L)("NFA")$.

2. *Seconda implicazione* $cal(L)("NFA") subset.eq cal(L)("DFA")$
  
  Per dimostrare questa implicazione prendiamo un NFA e costruiamo un DFA che lo simula.
  Sia
  - $N={Q,Sigma,delta,q_0,F}$ l'NFA t.c. $L(N)=A$
  costruiamo il DFA
  - $M={Q_M,Sigma,delta_M,q_0^M,F_M}$ t.c. $L(M)=A$

  Prima facciamo una costruzione senza considerare gli $epsilon$-archi:
  - $Q_M = cal(P)(Q)$ - Ogni stato di $M$ è un insieme di stati $N$
  
  - $delta_M (R,a)=op(union.big)_(r in R) delta (r,a)$
    
    Dove $R in Q_M, a in Sigma, delta (R,a) = {q in Q | q in delta (r,a) "con" r in R}$, stiamo dicendo che la funzione di transizione si applica su un insieme di stati e restituisce un altro insieme di stati, precisamente quelli che si ottengono applicando la funzione di transizione su tutti gli elementi dell'insieme in input.

  - $q_0^M = {q_0}$

  - $F_M = {R in Q_M | R inter F eq.not emptyset}$ ovvero quegli insiemi di stati che hanno al loro interno almeno uno stato accettante del DFA.

  A questo punto introduciamo gli $epsilon$-archi e per farlo definiamo $ E(R)={q | q "può essere raggiunto da" R "attraverso 0 o più" epsilon-"archi"} $
  Scriviamo 0 o più perchè in questo modo includiamo anche il nodo su cui ci troviamo. Con questa definizione possiamo modificare la funzione di transizione del DFA e lo stato iniziale del DFA in:

  - $delta_M (R,a) = {q in Q | q in E(delta (r,a)), exists r in R}$. In questo modo includiamo sia gli archi visti con la definizione di prima ma anche quelli che raggiungiamo tramite gli $epsilon$-archi.
  
  - $q_0^M = {q_0}$

Vediamo un esempio di trasformazione da NFA a DFA per chiarire i concetti.

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
  title: [*Esempio* - Da NFA a DFA],
  [
    Prendiamo questo NFA come esempio, ha come linguaggio $Sigma={a,b}$
    #align(center, diagram(
      node-stroke: .1em,
      spacing: 3em,
      // q0
      node((0,0), $q_0$, radius: 2em, extrude: (-2.5,0)),
      // q1
      node((-1,1), $q_1$, radius: 2em),
      // q2
      node((1,1), $q_2$, radius: 2em),

      edge((0,0), (1,1), $epsilon$, "-|>", bend: 40deg),
      edge((1,1), (0,0), `a`, "-|>", bend: 40deg),
      edge((0,0), (-1,1), `b`, "-|>", bend: -40deg),
      edge((-1,1), (-1,1), `a`, "-|>", bend: 130deg, loop-angle: 180deg),
      edge((-1,1), (1,1), `a,b`, "-|>", bend: -40deg)
    ))
  ],
  [
    Iniziamo a dare le prime definizioni:
    - $Q_D={q_emptyset, q_({0}), q_({1}), q_({2}), q_({0,1}), q_({0,2}), q_({1,2}),q_({0,1,2})}$. Con la notazione $q_({0,1})$ indichiamo l'insieme di stati ${q_0, q_1}$

    - $q_0^D = E(q_{0})=q_{0,2}$. Infatti da $q_0$ ci muoviamo con un $epsilon$-arco in $q_2$ ma manteniamo anche il ramo che si trova in $q_0$.

    - $F_D = {q_{0}, q_{0,1}, q_{0,2}, q_{0,1,2}}$. Ovvero tutti gli stati che contengono lo stato $q_0$

    Adesso ci manca da definire la funzione di transizione, è un passaggio lungo quindi vediamo solo alcuni casi.
    
    Per lo stato $q_{0}$ abbiamo:

      - $delta_D (q_{0},a)=E(delta (q_0,a))=q_{0,2}$

      - $delta_D (q_{0},b)=E(delta (q_0, b))=q_{1,2}$

    Per lo stato $q_{1}$:

      - $delta_D (q_{1},a)=E(delta (q_1,a))=q_{1,2}$

      - $delta_D (q_{1},b)=E(delta (q_1, b))=q_{2}$

    ...

    Per lo stato $q_{0,1}$:

      - $delta_D (q_{0,1},a)=E(delta (q_0,a))union E(delta (q_1,a))=q_{0,2} union q_{1,2} = q_{0,1,2}$

      - ...

    ...
  ]
)

Basandoci sull'esempio di prima possiamo anche provare a costruire il DFA che abbiamo soltanto definito. (semplificando anche alcuni nodi mai raggiunti)

#align(center, diagram(
  node-stroke: .1em,
  spacing: 3em,
  // q02
  node((0,0), $q_{0,2}$, radius: 2em, extrude: (-2.5,0)),
  // q1
  node((1,0), $q_{1}$, radius: 2em),
  // q2
  node((2,0), $q_{2}$, radius: 2em),
  // q012
  node((0,1), $q_{0,1,2}$, radius: 2em, extrude: (-2.5,0)),
  // q12
  node((1,1), $q_{1,2}$, radius: 2em),

  edge((-1.5,0), (0,0), "-|>", `start`, label-pos: 0.5, label-side: left),

  edge((0,0), (0,0), `a`, "-|>", bend: 130deg, loop-angle: 90deg),
  edge((0,0), (1,0), `b`, "-|>", bend: 40deg),
  edge((1,0), (2,0), `b`, "-|>", bend: 40deg),
  edge((1,0), (1,1), `a`, "-|>"),
  edge((1,1), (0,1), `a`, "-|>", bend: 40deg),
  edge((1,1), (2,0), `b`, "-|>", bend: -40deg),
  edge((0,1), (0,1), `a`, "-|>", bend: 130deg, loop-angle: 180deg),
  edge((0,1), (1,1), `b`, "-|>", bend: 40deg),
))

Da adesso in poi quindi non ci importa più distinguere NFA e DFA dato che abbiamo visto essere equivalenti, possiamo usare benissimo entrambi in qualsiasi situazione, ovviamente in alcuni casi potrebbe essere più vantaggioso un determinato tipo.

== Chiusura per Linguaggi Regolari
\
I linguaggi regolari sono *chiusi* rispetto alle loro operazione? Ovvero, se applichiamo un'operazione a due linguaggi regolari otteniamo come risultato un altro linguaggio regolare?

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
    L'insieme REG è chiuso per unione. Ovvero $L_1,L_2 in "REG" arrow.double.r L_1 union L_2 in "REG"$
  ]
)

*Dimostrazione* - Possiamo svolgere la dimostrazione in due modi:

1. Senza NFA

  Per dimostrare il teorema utilizzando i DFA dobbiamo costruire un automa $M$ che riconosce il linguaggio $L_1 union L_2$. Per farlo dobbiamo fare in modo che $M$ simuli il comportamento di altri due automi $M_1,M_2$ tali che $L(M_1) = L_1$ e $L(M_2) = L_2$, e che accetti soltanto se almeno una delle due simulazioni accetta.

  Dati
  - $M_1=(Q_1,Sigma, delta_1, q_1, F_1)$ t.c. $L(M_1)=L_1$

  - $M_2=(Q_2,Sigma, delta_2, q_2, F_2)$ t.c. $L(M_2)=L_2$

  Costruiamo quindi $M=(Q,Sigma,delta,q_0,F)$ dove:
  - $Q = Q_1 times Q_2 = {(r_1, r_2) | r_1 in Q_1 and r_2 in Q_2}$

  - $delta:Q times Sigma arrow.r Q$. Ad esempio $delta ((r_1,r_2),a) = (delta_1 (r_1,a), delta (r_2, a))$

  - $q_0 = (q_1, q_2)$

  - $F={(r_1, r_2) | r_1 in F_1 or r_2 in F_2}=(F_1 times Q_2) union (Q_1 times F_2)$

2. Con NFA

  In questo caso la dimostrazione è molto semplice, infatti ci basiamo sempre sull'idea di prima di usare due simulazioni $N_1, N_2$ per i due linguaggi ma le inglobiamo in un NFA $N$ che avrá come nodo iniziale un nuovo nodo collegato ai nodi iniziali delle simulazioni tramite $epsilon$-archi:

  #align(center, diagram(
    node-stroke: 1pt,
    edge-stroke: 1pt,
    spacing: 2em, // Controlla la distanza generale tra le coordinate

    // ==========================
    // LATO SINISTRO
    // ==========================

    // Automa N1 (in alto)
    node((-1, 0), $N_1$, stroke: none),
    edge((-0.5, 0), (0, 0), "-|>"), // Freccia di ingresso
    node((0, 0), shape: circle, radius: 5pt, name: <n1_start>),
    node((0.5, 0.5), shape: circle, radius: 4pt, name: <n1_mid>),
    // extrude: (0, 3) crea il doppio cerchio
    node((1, -0.2), shape: circle, radius: 5pt, extrude: (0, 3), name: <n1_end>),
    // Il riquadro che racchiude N1
    node(enclose: (<n1_start>, <n1_mid>, <n1_end>), shape: rect, inset: 15pt, name: <box_n1>),

    // Automa N2 (in basso)
    node((-1, 2), $N_2$, stroke: none),
    edge((-0.5, 2), (0, 2), "-|>"),
    node((0, 2), shape: circle, radius: 5pt, name: <n2_start>),
    node((0.5, 1.6), shape: circle, radius: 4pt, name: <n2_m1>),
    node((1, 1.8), shape: circle, radius: 4pt, name: <n2_m2>),
    node((0.2, 2.5), shape: circle, radius: 5pt, extrude: (0, 3), name: <n2_e1>),
    node((0.8, 2.5), shape: circle, radius: 5pt, extrude: (0, 3), name: <n2_e2>),
    node(enclose: (<n2_start>, <n2_m1>, <n2_m2>, <n2_e1>, <n2_e2>), shape: rect, inset: 15pt, name: <box_n2>),

    // ==========================
    // LATO DESTRO (Unione)
    // ==========================

    // Nuovo stato iniziale N
    edge((2.5, 1), (3.5, 1), "-|>", `N`, label-pos: 0, label-side: left),
    node((3.5, 1), shape: circle, radius: 12pt, name: <n_start>, $q_0$),

    // Copia Automa N1 (in alto a destra)
    node((5.5, 0), shape: circle, radius: 5pt, name: <rn1_start>),
    node((6.0, 0.5), shape: circle, radius: 4pt, name: <rn1_mid>),
    node((6.5, -0.2), shape: circle, radius: 5pt, extrude: (0, 3), name: <rn1_end>),
    node(enclose: (<rn1_start>, <rn1_mid>, <rn1_end>), shape: rect, inset: 15pt, name: <rbox_n1>),

    // Copia Automa N2 (in basso a destra)
    node((5.5, 2), shape: circle, radius: 5pt, name: <rn2_start>),
    node((6.0, 1.6), shape: circle, radius: 4pt, name: <rn2_m1>),
    node((6.5, 1.8), shape: circle, radius: 4pt, name: <rn2_m2>),
    node((5.7, 2.5), shape: circle, radius: 5pt, extrude: (0, 3), name: <rn2_e1>),
    node((6.3, 2.5), shape: circle, radius: 5pt, extrude: (0, 3), name: <rn2_e2>),
    node(enclose: (<rn2_start>, <rn2_m1>, <rn2_m2>, <rn2_e1>, <rn2_e2>), shape: rect, inset: 15pt, name: <rbox_n2>),

    // Transizioni epsilon curve
    edge(<n_start>, <rn1_start>, "-|>", $epsilon$, bend: 40deg),
    edge(<n_start>, <rn2_start>, "-|>", $epsilon$, bend: -40deg),
  ))

Più formalmente, dati

- $N_1=(Q_1,Sigma, delta_1, q_1, F_1)$ t.c. $L(N_1)=L_1$

- $N_2=(Q_2,Sigma, delta_2, q_2, F_2)$ t.c. $L(N_2)=L_2$

Costruiamo $N=(Q,Sigma,delta,q_0,F)$ dove:

- $Q={q_0} union Q_1 union Q_2$

- $F = F_1 union F_2$

- $delta:Q times Sigma arrow.r Q$ dove $ delta (q,a)=cases(
  delta_1 (q,a) &space space q in Q_1,
  delta_2 (q,a) &space space q in Q_2,
  {q_1, q_2} &space space q=q_0\, a = epsilon,
  emptyset &space space q=q_0\, a eq.not epsilon
) $

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
    REG è chiuso per complemento. Ovvero $forall L in "REG", overline(L) in "REG"$
  ]
)

*Dimostrazione* - Costruisco un automa $overline(L)$ che accetta tutto tranne le stringhe accettate da $L$. Per farlo ci basta avere come stati finali il complemento dell'insieme degli stati finali.

Dato $L=(Q,Sigma,delta,q_0,F)$ t.c. $L(L)=A$ costruisco $overline(L)=(Q,Sigma,delta,q_0,Q-F)$

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
    REG è chiuso per intersezione. Ovvero $forall L_1,L_2 in "REG", L_1 inter L_2 in "REG"$
  ]
)

*Dimostrazione* - Dati $D_1=(Q,Sigma,delta_1,q_1,F_1)$ t.c. $cal(L)(D_1)=L_1$ e $D_2=(Q_2,Sigma,delta_2,q_2,F_2)$ t.c. $cal(L)(D_2)=L_2$ costruisco $M=(Q,Sigma,delta,q_0,F)$ t.c.:

- $Q=Q_1 times Q_2$

- $F = F_1 times F_2$

- $q_0 = (q_1, q_2)$

- $delta((r_1, r_2), a) = (delta_1 (r_1, a), delta_2 (r_2,a))$

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
    REG è chiuso per concatenazione. $forall L_1, L_2 in "REG", L_1 op(circle.small) L_2 in "REG"$
  ]
)

Dati $D_1=(Q_1,Sigma,delta_1,q_1,F_1)$ t.c. $cal(L)(D_1)=L_1$ e $D_2=(Q_2,Sigma,delta_2,q_2,F_2)$ t.c. $cal(L)(D_2)=L_2$ costruisco $N=(Q,Sigma,delta,q_0,F)$ t.c.:

- $Q=Q_1 union Q_2$

- $q_0 = q_1$

- $F=F_2$

- $forall q in Q, a in Sigma$ si ha che $ delta(q,a)=cases(
  delta_1 (q,a) &space space space q in Q_1 - F_1,
  delta_1 (q,a) &space space space q in F_1 and a eq.not epsilon,
  delta_1 (q,a) union {q_2} &space space space q in F_1 and a = epsilon,
  delta_2 (q,a) &space space space q in Q_2
) $

Graficamente ci basta prendere il primo automa $L_1$ e collegare i suoi stati finali allo stato iniziale di $L_2$ tramite $epsilon$-archi:

#align(center, diagram(
  node-stroke: 1pt,
  edge-stroke: 1pt,
  spacing: 2em, // Controlla la distanza generale tra le coordinate

  // ==========================
  // LATO SINISTRO
  // ==========================

  // Automa N1 (in alto)
  node((-1, 0), $L_1$, stroke: none),
  edge((-0.5, 0), (0, 0), "-|>"), // Freccia di ingresso
  node((0, 0), shape: circle, radius: 5pt, name: <n1_start>),
  node((0.5, 0.5), shape: circle, radius: 4pt, name: <n1_mid>),
  // extrude: (0, 3) crea il doppio cerchio
  node((1, -0.2), shape: circle, radius: 5pt, extrude: (0, 3), name: <n1_end>),
  // Il riquadro che racchiude N1
  node(enclose: (<n1_start>, <n1_mid>, <n1_end>), shape: rect, inset: 15pt, name: <box_n1>),

  // Automa N2 (in basso)
  node((-1, 2), $L_2$, stroke: none),
  edge((-0.5, 2), (0, 2), "-|>"),
  node((0, 2), shape: circle, radius: 5pt, name: <n2_start>),
  node((0.5, 1.6), shape: circle, radius: 4pt, name: <n2_m1>),
  node((1, 1.8), shape: circle, radius: 4pt, name: <n2_m2>),
  node((0.2, 2.5), shape: circle, radius: 5pt, extrude: (0, 3), name: <n2_e1>),
  node((0.8, 2.5), shape: circle, radius: 5pt, extrude: (0, 3), name: <n2_e2>),
  node(enclose: (<n2_start>, <n2_m1>, <n2_m2>, <n2_e1>, <n2_e2>), shape: rect, inset: 15pt, name: <box_n2>),

  // ==========================
  // LATO DESTRO (Unione)
  // ==========================

  // Nuovo stato iniziale N
  edge((2.5, 1), (3.5, 1), "-|>", `N`, label-pos: 0, label-side: left),

  // Copia Automa N1 (in alto a destra)
  node((3.5, 1), shape: circle, radius: 15pt, name: <rn1_start>, $q_1$),
  node((4.0, 1.5), shape: circle, radius: 4pt, name: <rn1_mid>),
  node((4.5, 0.5), shape: circle, radius: 5pt, extrude: (0, 3), name: <rn1_end>),

  // Copia Automa N2 (in basso a destra)
  node((6.5, 1), shape: circle, radius: 10pt, name: <rn2_start>, $q_2$),
  node((7.0, 0.6), shape: circle, radius: 4pt, name: <rn2_m1>),
  node((7.5, 0.8), shape: circle, radius: 4pt, name: <rn2_m2>),
  node((6.7, 1.5), shape: circle, radius: 5pt, extrude: (0, 3), name: <rn2_e1>),
  node((7.3, 1.5), shape: circle, radius: 5pt, extrude: (0, 3), name: <rn2_e2>),
  node(enclose: (<rn1_start>, <rn1_mid>, <rn1_end>, <rn2_start>, <rn2_m1>, <rn2_m2>, <rn2_e1>, <rn2_e2>), shape: rect, inset: 30pt, name: <rbox_n2>),

  edge(<rn1_end>, <rn2_start>, "-|>", $epsilon$, label-pos: 0.5, label-side: left, bend: 20deg),
))

Da questa dimostrazione possiamo anche dire che REG è chiuso per potenza, dato che la potenza si esprime in funzione della concatenazione. _Es_ $L^2 = L op(circle.small) L $

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
    REG è chiuso per l'operatore potenza. $forall L in "REG", n in NN, L^n in "REG"$.
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
    REG è chiuso per l'operatore $*$. $forall L in "REG", L^* in "REG"$.
  ]
)

*Dimostrazione* - Dato $L in "REG"$, sia $N_1=(Q_1, Sigma, delta_1, q_1, F)$ l'NFA t.c. $L(N_1)=L$ costruisco $N=(Q,Sigma,delta,q_0,F)$ NFA t.c.:
- $q_0 eq.not q_1$ è un nuovo stato iniziale

- $Q = Q_1 union {q_0}$

- $F = F_1 union {q_0}$. Dobbiamo aggiungere anche il nuovo stato iniziale dato che l'operatore $*$ comprende anche la stringa vuota $epsilon$.

- $forall q in Q, a in Sigma$ si ha che $ delta (q,a) = cases(
  delta_1 (q,a) &space space space q in Q - F,
  delta_1 (q,a) &space space space q in F and a eq.not epsilon,
  delta_1 (q,a) union {q_1} &space space space q in F and a = epsilon,
  {q_1} &space space space q = q_0 and a = epsilon,
  emptyset &space space space q = q_0 and a eq.not epsilon
) $

Questo nuovo automa accetta tutto quello che accetta $N_1$ ma ogni volta che accetta torna indietro con un $epsilon$-arco per provare ad accettare un'altra stringa accettata sempre da $N_1$. Proviamo a rappresentare questo automa:

#align(center, diagram(
  node-stroke: 1pt,
  edge-stroke: 1pt,
  spacing: 2em, // Controlla la distanza generale tra le coordinate

  // ==========================
  // LATO SINISTRO
  // ==========================

  // Automa N1 (in alto)
  node((-1.5, 0), $N_1$, stroke: none, name:<name1>),
  edge((-0.8, 0), (0, 0), "-|>", `start`, label-pos: 0.3, label-side: left), // Freccia di ingresso
  node((0, 0), shape: circle, radius: 15pt, name: <n1_start>, $q_1$),
  node((0.5, 0.5), shape: circle, radius: 9pt, name: <n1_mid1>),
  node((0.25, 0.85), shape: circle, radius: 9pt, name: <n1_mid2>),
  node((0.75, 0.85), shape: circle, radius: 9pt, name: <n1_mid3>),
  // extrude: (0, 3) crea il doppio cerchio
  node((1, -0.2), shape: circle, radius: 10pt, extrude: (0, 3), name: <n1_end>),
  // Il riquadro che racchiude N1
  node(enclose: (<n1_start>, <n1_mid1>,<n1_mid2>,<n1_mid3>, <n1_end>, <name1>), shape: rect, inset: 15pt, name: <box_n1>),

  // ==========================
  // LATO DESTRO
  // ==========================

  // Nuovo stato iniziale N
  node((3, 0), $N$, stroke: none, name:<name>),
  edge((3, 0), (4, 0), "-|>", `start`, label-pos: 0.3, label-side: left), // Freccia di ingresso
  node((4, 0), shape: circle, radius: 15pt, name: <n_start>, $q_0$, extrude: (-2.5,0)),
  node((6, 0), shape: circle, radius: 15pt, name: <n_mid>, $q_1$),
  edge(<n_start>, <n_mid>, "-|>", $epsilon$, label-pos: 0.3, label-side: left),
  node((7.5, 0.5), shape: circle, radius: 9pt, name: <n_mid1>),
  node((7.15, 0.95), shape: circle, radius: 9pt, name: <n_mid2>),
  node((7.85, 0.95), shape: circle, radius: 9pt, name: <n_mid3>),
  node((7.5, -1), shape: circle, radius: 10pt, extrude: (-2.5, 0), name: <n_end>),
  edge(<n_end>, <n_mid>, "-|>", $epsilon$, label-pos: 0.5, label-side: right, bend: -20deg),

  node(enclose: (<n_start>, <n_mid1>,<n_mid2>,<n_mid3>, <n_end>, <name>), shape: rect, inset: 15pt, name: <box_n>),
))

Come prima, grazie a questa dimostrazione possiamo anche dire che REG è chiuso per +. L'operatore + é come l'operatore $*$ ma esclude la potenza 0, posiamo definirlo quindi come $L^+ = L^1 union L^2 union ...$

#showybox(
  frame: (
    border-color: silver.lighten(60%),
    title-color: silver.lighten(60%),
    body-color: silver.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Notazione*],
  [
    $L^+$ equivale quindi a scrivere $L L^*$, ovvero almeno una concatenazione di $L$.
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
  title: [*Corollario*],
  [
    REG è chiuso per $+$. La dimostrazione è uguale a $*$ ma ci basta escludere $q_0$ da $F$.
  ]
)

#pagebreak()
== Espressioni Regolari
\
Le espressioni regolari sono come le espressioni matematiche ma invece di rappresentare numeri, rappresentano linguaggi. Diamo una definizione formale.

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
  title: [*Definizione* - Espressione Regolare],
  [
    Sia $Sigma$ un alfabeto. Un'espressione regolare su $Sigma$ che indichiamo con $op(r e)(Sigma)$ è definita ricorsivamente come segue:
    $ "caso base:" cases(
      emptyset &space space space in r e(Sigma),
      epsilon &space space space in r e(Sigma),
      a &space space space in r e(Sigma)\, forall a in Sigma,
    ) $
    $
    "caso induttivo:" cases(
      R_1 union R_2 &space space space R_1\, R_2 in r e(Sigma),
      R_1 op(circle.small) R_2 &space space space R_1\, R_2 in r e(Sigma),
      (R_1)^* &space space space R_1 in r e(Sigma),
    ) $
    Dove $R_i$ sono espressioni regolari.
  ]
)

Stiamo quindi dicendo che, preso un alfabeto, i suoi singoli caratteri, la stringa vuota e l'insieme vuoto appartengono all'espressione regolare che descrive questo alfabeto. L'unione, l'intersezione o la $*$ di espressioni regolari su questo alfabeto sono comunque espressioni regolari dell'alfabeto.

*Osservazione* - Ogni espressione regolare $R in r e (Sigma)$ ha associato un linguaggio $L(R)$:
$ "caso base:" cases(
  L(R) = emptyset &space space space "se" R=emptyset,
  L(R) = {epsilon} &space space space "se" R=epsilon,
  L(R) = {a} &space space space "se" R=a
) $ 

$ "caso induttivo:" cases(
  L(R) = L(R_1) union L(R_2) &space space space "se" R = R_1 union R_2,
  L(R) = L(R_1) op(circle.small) L(R_2) &space space space "se" R = R_1 op(circle.small) R_2,
  L(R) = (L(R_1))^* &space space space "se" R = (R_1)^*
) $

Vediamo qualche esempio di espressione regolare.

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
  title: [*Esempi*],
  [
    - $0^* 10^* = {w | w "contiene un solo" 1}$

    - $(0 union 1) = {0} union {1} = {0,1}$

    - $(Sigma Sigma)^* = {w | w "ha lunghezza pari"}$. Prima concatena 2 simboli qualsiasi dell'alfabeto e poi li eleva, quindi avremo semrpe $2*n$ simboli
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
    Un linguaggio è regolare *se e solo se* esiste un'espressione regolare che lo descrive, ovvero: $ "REG" equiv cal(L)(r e) $
  ]
)

*Dimostrazione* - Dimostriamo il teorema tramite due lemmi.

1. *Lemma* $cal(L)(r e) subset.eq "REG"$
  
  Data un'espressione regolare $R$, costruisco un NFA/DFA $N_R$ t.c. $L(N_R)=L(R)$. Per convertire $R$ in un NFA consideriamo i casi della definizione ricorsiva di $R$. Prima vediamo i 3 casi base e poi i 3 induttivi.

  1. $R=emptyset$. È un NFA che non accetta niente.
    - $N_R = {{q_1}, Sigma, delta, q_1, emptyset}$

    - $delta(q_1, b) = emptyset, forall b in Sigma$

    #align(center, diagram(
      node-stroke: .1em,
      spacing: 3em,
      // q0
      node((0,0), $q_1$, radius: 1.5em),

      edge((-1,0), (0,0), `start`, "-|>", label-pos: 0.5, label-side: left),
    ))

  2. $R=epsilon$. È un NFA che accetta soltanto la stringa vuota.
    - $N_R={{q_1},Sigma,delta,q_1, {q_1}}$

    - $delta(q_1, b)=emptyset, forall b in Sigma$

    #align(center, diagram(
      node-stroke: .1em,
      spacing: 3em,
      // q0
      node((0,0), $q_1$, radius: 1.5em, extrude: (-2.5,0)),

      edge((-1,0), (0,0), `start`, "-|>", label-pos: 0.5, label-side: left),
    ))

  3. $R=a, a in Sigma$. È un NFA che accetta soltanto il carattere $a$.
    - $N_R = ({q_1,q_2}, Sigma,delta,q_1, {q_2})$
    
    - $delta(q_1,a)=q_2$

    - $delta(q,b)=emptyset, b eq.not a$

    #align(center, diagram(
      node-stroke: .1em,
      spacing: 3em,
      // q0
      node((0,0), $q_1$, radius: 1.5em),
      node((1,0), $q_2$, radius: 1.5em, extrude: (-2.5,0)),

      edge((-1,0), (0,0), `start`, "-|>", label-pos: 0.5, label-side: left),
      edge((0,0), (1,0), `a`, "-|>", label-pos: 0.5, label-side: left),
    ))
  
  Passiamo adesso ai 3 casi ricorsivi.

  4.5.6. $R=R_1 union R_2; R=R_1 op(circle.small) R_2; R= (R_1)^*$. Per costruire i casi induttivi ci basta utilizzare le chiusure dei linguaggi regolari. Ad esempio se dobbiamo costruire $R=R_1 union R_2$ ci basta prima costruire i due automi per $R_1,R_2$ e poi utilizzare la chiusura come visto nelle dimostrazioni precedenti.

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
      Convertiamo l'espressione regolare $(a b union a)^*$ in un NFA:
      Per prima cosa costruiamo gli automi per riconoscere i caratter $a$ e $b$:
      #align(center, diagram(
        node-stroke: .1em,
        spacing: 3em,
        // a
        node((0,0), radius: 1.5em),
        node((1,0), radius: 1.5em, extrude: (-2.5,0)),

        edge((-1,0), (0,0), `start`, "-|>", label-pos: 0.5, label-side: left),
        edge((0,0), (1,0), `a`, "-|>", label-pos: 0.5, label-side: left),

        // b
        node((4,0), radius: 1.5em),
        node((5,0), radius: 1.5em, extrude: (-2.5,0)),

        edge((3,0), (4,0), `start`, "-|>", label-pos: 0.5, label-side: left),
        edge((4,0), (5,0), `b`, "-|>", label-pos: 0.5, label-side: left),
      ))
      Poi costruiamo quello per riconoscere $a b$ usando appunto la concatenazione:
      #align(center, diagram(
        node-stroke: .1em,
        spacing: 3em,
        // a
        node((0,0), radius: 1.5em),
        node((1,0), radius: 1.5em),

        edge((-1,0), (0,0), `start`, "-|>", label-pos: 0.5, label-side: left),
        edge((0,0), (1,0), `a`, "-|>", label-pos: 0.5, label-side: left),

        // b
        node((4,0), radius: 1.5em),
        node((5,0), radius: 1.5em, extrude: (-2.5,0)),

        edge((4,0), (5,0), `b`, "-|>", label-pos: 0.5, label-side: left),
        edge((1,0), (4,0), $epsilon$, "-|>", label-pos: 0.5, label-side: left),
      ))
      Adesso usiamo l'unione per costruire l'NFA che riconosce $a b union a$:
      #align(center, diagram(
        node-stroke: .1em,
        spacing: 3em,
        // Start
        node((0,0), radius: 1.5em),
        edge((-1,0), (0,0), `start`, "-|>", label-pos: 0.5, label-side: left),
        edge((0,0), (1,-0.5), $epsilon$, "-|>", label-pos: 0.5, label-side: left, bend:20deg),
        edge((0,0), (1,0.5), $epsilon$, "-|>", label-pos: 0.5, label-side: left, bend:-20deg),

        // ab
        node((1,-0.5), radius: 1.5em),

        node((2,-0.5), radius: 1.5em),
        node((3,-0.5), radius: 1.5em),
        node((4,-0.5), radius: 1.5em, extrude: (-2.5,0)),

        edge((1,-0.5), (2,-0.5), `a`, "-|>", label-pos: 0.5, label-side: left),
        edge((2,-0.5), (3,-0.5), $epsilon$, "-|>", label-pos: 0.5, label-side: left),
        edge((3,-0.5), (4,-0.5), `b`, "-|>", label-pos: 0.5, label-side: left),

        // a
        node((1,0.5), radius: 1.5em),
        node((2,0.5), radius: 1.5em, extrude: (-2.5,0)),
        edge((1,0.5), (2,0.5), `a`, "-|>", label-pos: 0.5, label-side: left),
      ))
      Possiamo finalmente usare la chiusura per $*$ e costruire l'NFA:
      #align(center, diagram(
        node-stroke: .1em,
        spacing: 3em,
        // Start
        node((-1,0), radius: 1.5em, extrude: (-2.5,0)),
        node((0,0), radius: 1.5em),
        edge((-1,0), (0,0), $epsilon$, "-|>", label-pos: 0.5, label-side: left),
        edge((-2,0), (-1,0), `start`, "-|>", label-pos: 0.5, label-side: left),
        edge((0,0), (1,-0.5), $epsilon$, "-|>", label-pos: 0.5, label-side: left, bend:20deg),
        edge((0,0), (1,0.5), $epsilon$, "-|>", label-pos: 0.5, label-side: left, bend:-20deg),

        // ab
        node((1,-0.5), radius: 1.5em),

        node((2,-0.5), radius: 1.5em),
        node((3,-0.5), radius: 1.5em),
        node((4,-0.5), radius: 1.5em, extrude: (-2.5,0)),

        edge((1,-0.5), (2,-0.5), `a`, "-|>", label-pos: 0.5, label-side: left),
        edge((2,-0.5), (3,-0.5), $epsilon$, "-|>", label-pos: 0.5, label-side: left),
        edge((3,-0.5), (4,-0.5), `b`, "-|>", label-pos: 0.5, label-side: left),

        // a
        node((1,0.5), radius: 1.5em),
        node((2,0.5), radius: 1.5em, extrude: (-2.5,0)),
        edge((1,0.5), (2,0.5), `a`, "-|>", label-pos: 0.5, label-side: left),

        //
        edge((2,0.5), (2,0), (0, 0), $epsilon$, "-|>", label-pos: 0.5, label-side: right),
        edge((4,-0.5), (4,-1), (0, -1), (0,0), $epsilon$, "-|>", label-pos: 0.5, label-side: right),
      ))
    ]
  )

2. *Lemma* $"REG" subset.eq cal(L)(r e)$. Adesso dobbiamo mostrare come passare da un linguaggio regolare ad un'espressione regolare. Per farlo dobbiamo imparare a convertire gli NFA in espressioni regolari.

  Per fare questo ci serve il concetto di *NFA Generalizzato (GNFA)*:
  - Le etichette degli archi sono espressioni regolari

  - Lo stato iniziale ha solo archi uscenti verso ogni altro stato

  - C'è un solo stato finale, che ha solo archi entranti da altri stati ed è diverso dallo stato iniziale

  - Eccetto gli stati iniziale e finale, presi due stati qualsiasi (anche lo stesso) esiste un arco tra di essi.

  Per prima cosa convertiamo l'NFA in un GNFA tramite il seguente algoritmo:
  - Se lo stato iniziale ha archi entranti, aggiungere un nuovo stato iniziale con un $epsilon$-arco al vecchio stato iniziale.

  - Se c'è più di uno stato accettante o esiste uno stato accettante con archi uscenti, aggiungere un nuovo stato finale con $epsilon$-archi provenienti da ogni $q in F$.

  - Se qualche arco ha più di un input, usare come input per quell'arco l'unione tra gli input precedenti.

  - Aggiungere archi con input $emptyset$ tra le coppie di stati non unite da archi.

  Possiamo anche fornire una definizione formale di *GNFA*.

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
    title: [*Definizione* - GNFA],
    [
      Un GNFA è una tupla $(Q,Sigma,delta,q_"start", q_"accept")$ dove gli elementi sono definiti come negli NFA ad eccezione della funzione di transizione, infatti:
      $ delta:(Q\\{q_"accept"}) times (Q \\ {q_"start"}) arrow.r cal(R) = r e (Sigma) $
    ]
  )

  *Conversione da GNFA a Espressione Regolare* - Adesso possiamo convertire il GNFA in espressione regolare. Definiamo la funzione `CONVERT(G)` che prende in input un GNFA e restituisce un'espressione regolare:

  1. Sia $k=\#"stati di" G$

  2. Se $k=2$ allora $G$ ha solo i due stati $q_"start"$ e $q_"accept"$ e un singolo arco con etichetta $R in cal(R)$, l'output sarà quindi $R$.

  3. Se $k>2$ scegliamo un $q_"rip" in Q$ diverso da $q_"start"$ e $q_"accept"$. Definiamo $G'=(Q',Sigma,delta',q_"start",q_"accept")$ dove:
    - $Q'=Q \\ {q_"rip"}$
    
    - $delta':Q' \\ {q_"acc"} times Q'\\{q_"start"} arrow.r cal(R)$
    Quindi prendiamo uno stato $q_"rip"$ a caso e lo rimuoviamo. Come si rimuove? Vediamo un esempio: