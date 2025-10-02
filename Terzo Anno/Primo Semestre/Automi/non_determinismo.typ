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

#automaton(
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

== Confronto tra linguaggi di DFA e NFA

Prendiamo le due classi:
- $cal(L)"(DFA)" subset.eq "REG"$
- $cal(L)"(NFA)" = {L:exists "NFA N t.c. " cal(L)(N) = L}$

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
  title: [*Teorema*],
  [
    $ "REG" = cal(L) ("NFA") $
  ],
  [
    *Dimostrazione*. Dobbiamo dimostrare la doppia implicazione $cal(L)("DFA")subset.eq cal(L)("NFA")$ e $cal(L)("NFA") subset.eq cal(L)("DFA")$.

    La *prima implicazione* è molto semplice infatti dato un linguaggio $L in cal(L)("DFA")$ e un DFA $D$ tale che $L=L(D)$ e siccome gli NFA sono una generalizzazione dei DFA avremo che $D$ è anche un NFA e quindi $L in cal(L)("NFA")$. Quindi $cal(L)("DFA")subset.eq cal(L)("NFA")$.

    Per la *seconda implicazione* prendiamo un linguaggio $L in cal(L)("NFA")$, quindi $exists "NFA " N=(Q_N, Sigma, delta_N, q_0^N, F_N)$ t.c. $L(N)=L$. 

    Dobbiamo costruire un DFA $D=(Q_D, Sigma, delta_D, q_0^D, F_D)$ t.c. $L(D)=L$. Costruiamolo tramite $N$.

    Consideriamo il caso dove non ci sono $epsilon-"archi"$:
    - $Q_D=bb(P)(Q_N)$
    - $q_0^D = {q_0^N}$
    - $F_D = {R in Q_D, R inter F_N eq.not emptyset}$

    Quindi sia $R in Q_D, a in Sigma$: $ delta_D (R,a) = union.big_(r in R) delta_N (r,a) = {q in Q_N : q in delta_N (r,a) " per qualche " r in R} $

    Quindi abbiamo costruito come stati finali, un insieme di insiemi, gli insiemi elemento sono formati da stati e sono tali che almeno uno di loro faccia parte degli stati finali dell'NFA. In questo modo durante la risoluzione del DFA possiamo eseguire in modo deterministico tutte le strade e fare l'unione di tutti i risultati, raggiungeremo sicuramente uno stato accettato.

    Consideriamo invece adesso il caso generale dove ci sono gli $epsilon-"archi"$.
    
    Sia $R in Q_D$ definiamo:
    - $E(R)={q in Q_N: q " può essere raggiunto da stato in R attraverso " gt.eq 0 "  "epsilon "-archi"}$ e quindi: $ delta_D (R,a) = union.big_(r in R) E(delta_N (r,a)) $

    *TODO: Da finire*
  ]
)