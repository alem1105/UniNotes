#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= Non Determinismo

Per adesso abbiamo visto soltanto automi deterministici, questo significa che trovandoci in uno stato e ricevendo un input possiamo soltanto andare in un altro stato o rimanere fermi, ma in generale un solo movimento.

Nel *non determinismo* invece:
- Quando l'automa è in $q in Q$ e legge $a in Sigma$ può andare in diversi stati
- Sono ammessi gli "$epsilon$-archi" ovvero l'automa può muoversi senza leggere input. Dallo stesso stato possono partire più "$epsilon$-archi".
- Accettazione: Se e solo se esiste un ramo che accetta, vedremo più avanti che quando studiamo un NFA avremo un albero con vari rami, se un ramo accetta allora consideriamo la stringa come accettata per il NFA.

Nel non determinismo quindi abbiamo un input che si dirama in vari stati invece che seguire un cammino di _uno stato alla volta_.

- *Determinismo*
#align(center, 
  automaton(
    initial: "q0", final: none,
    (
      q0: (q1:()),
      q1: (q2:()),
      q2: (q3: ()),
      q3: (),
    ),
    layout: (q0: (0,0), q1: (3, 0), q2: (6, 0), q3: (9, 0)),
    style: (
      q3: (fill: green.lighten(60%))
    )
  )
)

- *Non Determinismo*

#align(center, 
  automaton(
    initial: none, final: none,
    (
      q0: (q1:(), q2: ()),

      q1: (q4: ()),
      q2: (q3: ()),

      q3: (),
      q4: (q5:()),
      q5: (),
    ),
    layout: (q0: (0,0), q1: (-2, -2), q2: (2, -2), q3: (4, -4), q4: (-4, -4), q5: (-2, -6)),
    style: (
      q0-q1: (curve: -1),
      q1-q4: (curve: -1),
      q3: (fill: green.lighten(60%)),
      q4: (fill: green.lighten(60%))
    )
  )
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
  title: [*Definizione - NFA*],
  [Un NFA è $(Q, Sigma, delta, q_0, F)$ dove $Q,Sigma,q_0,F$ sono come nei DFA ma: $ delta: Q times Sigma_epsilon arrow.r PP(Q) \ "Dove " Sigma_epsilon union {epsilon} $ e $PP$ è l'insieme delle parti.]
)

Vediamo un esempio e capiamo come ci si muove al loro interno.

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
    #align(center,
    automaton(
      initial: "q1", final: none,
      (
        q1: (q1: (0,1), q2: 1),
        q2: (q3: (0,1)),
        q3: (q4: (0,1)),
        q4: (q5: (0,1)),
        q5: (q5: (0,1))
      ),
      layout: (q0: (0,0), q1: (2, 0), q2: (4, 0), q3: (6, 0), q4: (8, 0), q5: (10,0)),
      style: (
        q4: (fill: green.lighten(60%)),
        q5-q5: (anchor: right)
      )
    ))

    Che ha come linguaggio: $ L={x:x in {0,1}^* " che hanno un '1' in terzultima posizione"} $

    _Da notare che lo stato $q_5$ possiamo anche ometterlo, ma non dobbiamo indicare in $q_4$ nessun arco_.
  ]
)

Per muoverci, ad esempio nel NFA dell'esempio sopra, ci torna utile disegnare un albero con tutte i cammini che stiamo intrapendendo. Se ad esempio riceviamo in input la stringa "10110":

#align(center,
  diagram(
	node-defocus: 0,
	spacing: (1cm, 2cm),
	edge-stroke: 1pt,
	crossing-thickness: 5,
	mark-scale: 70%,
	node-outset: 3pt,
	node((0,0), [$q_1, 10110$], name: <a>),

	node((-1,1), $q_1, 0110$, name: <b>),
	node((1,1), $q_2, 0110$, name: <c>),

	node((-1, 2), $q_1, 110$, name: <d>),
  node((1, 2), $q_3, 110$, name: <e>),

  node((1, 3), $q_4, 10$, name: <f>),
  node((-1.5, 3), $q_1, 10$, name: <g>),
  node((-0.5, 3), $q_2, 10$, name: <h>),

  node((-1.5, 4), $q_1, 0$, name: <i>),
  node((1, 4), $q_4 "non Accetta"$, name: <j>),
  node((-0.5, 4), $q_3, 0$, name: <k>),

  node((-1.5, 5), $q_1 "non accetta"$, name: <l>),
  node((-0.5, 5), $q_4 "accetta"$, name: <m>),

  edge(<a>, <b>, "->"),
  edge(<a>, <c>, "->"),

  edge(<c>, <e>, "->"),
  edge(<e>, <f>, "->"),
  edge(<f>, <j>, "->"),

  edge(<b>, <d>, "->"),
  edge(<d>, <g>, "->"),
  edge(<d>, <h>, "->"),
  edge(<g>, <i>, "->"),
  edge(<i>, <l>, "->"),
  edge(<h>, <k>, "->"),
  edge(<k>, <m>, "->")
)
)

== Configurazione negli NFA

Possiamo estendere il concetto di *configurazione* anche per gli NFA.

Dato un NFA $N$ indichiamo come configurazione una coppia $(q,x) in Q times Sigma_epsilon^*$ e avremo un passo di configurazione come: $ (p,a x) attach(tack.r, br: N) (q,x) arrow.double.r.l q in delta(p,a) $
Con:
- $x in Sigma^*_epsilon$
- $a in Sigma_epsilon$
- $p,q in Q$

Quindi il risultato di una transizione deve far parte dell'insieme delle parti degli stati: $ delta(p,a) in bb(P) (Q) $

Quando, l'automa $N$, accetta $w in Sigma_epsilon^*$?
- Se e solo se $exists q in F " t.c. " (q_0,w) attach(tack.r, br: N, tr: *) (q, epsilon)$. Dove $attach(tack.r, br: N, tr: *)$ è la relazione estesa.

== Equivalenza tra NFA e DFA

Prendiamo le due classi:
- $cal(L)"(DFA)" subset.eq "REG"$
- $cal(L)"(NFA)" = {L:exists "NFA N t.c. " cal(L)(N) = L}$

*Teorema* - Per ogni automa finito non deterministico esiste un automa finito deterministico equivalente.

*Dimostrazione*. Dobbiamo dimostrare la doppia implicazione $cal(L)("DFA")subset.eq cal(L)("NFA")$ e $cal(L)("NFA") subset.eq cal(L)("DFA")$.

La *prima implicazione* è molto semplice infatti dato un linguaggio $L in cal(L)("DFA")$ e un DFA $D$ tale che $L=L(D)$ e siccome gli NFA sono una generalizzazione dei DFA avremo che $D$ è anche un NFA e quindi $L in cal(L)("NFA")$. Quindi $cal(L)("DFA")subset.eq cal(L)("NFA")$.

Per la *seconda implicazione* prendiamo un $"NFA" = (Q_N, Sigma, delta_N, q_0^N, F_N)$ che riconosce un linguaggio $A$. Dobbiamo costruire un $"DFA" D=(Q_D, Sigma, delta_D, q_0^D, F_D)$ che riconosce $A$.

Consideriamo il caso in cui non abbiamo $epsilon-"archi"$:
1. $Q_D=bb(P)(Q_N)$ - Uno stato del DFA equivale quindi ad un insieme di stati del NFA.
2. Presi un $R in Q_D$ e $a in Sigma$, sia $ delta_D (R,a)={q in Q_N : q in delta_N (r,a) " per qualche " r in R} $

Quindi la funzione di transizione del DFA equivale ad eseguire la transizione su tutti gli di $R$ nel NFA.

Possiamo anche scriverla come: $ delta_D (R, a) = union.big_(r in R) delta(r,a) $

3. $q_0^D = {q_0^N}$
4. $F_D = {R in Q : R " contiene uno stato accettante di " N}$ - Quindi il DFA accetta se e solo se nell'insieme risultante della transizione abbiamo almeno uno stato accettante dell'NFA. I due automi sono equivalenti.

Adesso consideriamo il caso con gli $epsilon"-archi"$, introduciamo delle notazioni. Per ogni $R$ di $D$ definiamo $E(R)$ come la collezione di stati che possono essere raggiunti dagli elementi di $R$ proseguendo solo con $epsilon"-archi"$, includendo anche gli stessi elementi di $R$, in modo formale possiamo dire: $ E(R) = {q : q " può essere raggiunto con " gt.eq 0 quad epsilon-"archi"} $

Adesso modifichiamo la funzione di transizione di $D$ in modo da far aggiungere gli stati che possono essere raggiunti da $epsilon-"archi"$ dopo ogni passo, sostituendo $delta_N (r,a)$ con $E(delta_N (r,a))$: $ delta_D (R,a) = {q in Q : q in E(delta_N (r,a) ) " per qualche " r in R} $

Dobbiamo anche modificare lo stato iniziale di $D$ in modo che anche nello stato iniziale raggiunga subito tutti gli stati possibili tramite $epsilon-"archi"$ e lo facciamo cambiando $q_0^D$ in $E({q_0^N})$.

Abbiamo completato la costruzione del DFA equivalente ad NFA, infatti ad ogni passo del NFA avremo che il DFA entra in uno stato equivalente all'insieme degli stati in cui si trova l'NFA.

== Convertire un NFA in DFA

Prendiamo come esempio l'NFA:

#align(center,
  automaton(
    initial: "q1", final: none,
    (
      q1: (q2: "b", q3: ()),
      q2: (q2: "a", q3: ("a","b")),
      q3: (q1: "a")
    ),
    layout: (q1: (0,0), q2: (-2, -3), q3: (2, -3)),
    style: (
      q1: (fill: green.lighten(65%)),
      q2-q2: (anchor: left),
      q1-q2: (curve: -1),
      q3-q1: (curve: -1),
      q1-q3: (curve: -1, label: $epsilon$),
      q2-q3: (curve: -1)
    )
  )
)

Iniziamo a definire gli elementi del DFA $D$:
- $Q_D = {q_0, q_{1}, q_{2}, q_{3}, q_{1,2}, q_{1,3}, q_{2,3}, q_{1,2,3}}$

- $q_0^D = E({q_1})= q_{1,3}$ -  Consideriamo quindi l'estensione dello stato iniziale con gli $epsilon-"archi"$

- $F_D = {q_{1}, q_{1,2}, q_{1,3}, q_{1,2,3}}$ - Sono tutti gli stati che contengono almeno uno stato accettante, in questo caso soltanto $q_1$

Adesso dobbiamo calcolare $delta_D$, vediamo alcuni casi ma non tutti:
- $delta_D (q_{2},a)=q_{2,3}$

- $delta_D (q_{2},b)=q_{3}$

- $delta_D (q_{3},a)=q_{3}$ - Perché dobbiamo considerare anche l'$epsilon"-archi"$

- $delta_D (q_{3},b)=q_{emptyset}$ - Infatti finisce la stringa ma non siamo in uno stato accettante

Ci sarebbero altre funzioni, ma vediamo cosa otteniamo:

#align(center,
  automaton(
    initial: "q13", final: none,
    (
      q13: (q13: "a", q2: "b"),
      q2: (q23: "a", q3: "b"),
      q3: (q13: "a", q0: "b"),
      q23: (q123: "a", q3: "b"),
      q0: (q0: ("a", "b")),
      q123: (q123: "a", q23: "b")
    ),
    layout: (
      q13: (0,0), q3: (3, 0), q0: (6, 0), q2: (0, -3), q23: (3, -3), q123: (6, -3)
    ),
    style: (
      q13: (fill: green.lighten(65%)),
      q123: (fill: green.lighten(65%)),
      q13-q2: (curve: -1),
      q3-q13: (curve: -1),
      q2-q23: (curve: -1),
    )
  )
)
