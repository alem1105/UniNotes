#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton

#set heading(numbering: "1.")

= Linguaggi Regolari

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
  [$ "REG" = {L subset.eq Sigma^* : exists " DFA M t.c. " L(M) = L} $
  Quindi i linguaggi regolari sono tutti quei linguaggi che sono accettati da almeno un DFA.
  ]
)

Uno dei nostri obiettivi nel corso è quello di, dato un linguaggio, progettare dei DFA adatti.

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
  title: [Esempio],
  [Dato il linguaggio $L={x in {0,1}^* " t.c. " x=1y, y in {0,1}^* }$, un possibile DFA potrebbe essere:
    #align(center,
      automaton(
        initial: "q0", final: none,
        (
          q0: (q1:1, q2:0),
          q2: (q2:(1,0)),
          q1: (q1:(1,0)),
        ),
        layout: (q0: (0,0), q1: (3, 0), q2: (0, -3)),
        style: (
          q0-q2: (curve: -1, label: (anchor: left)),
          q1-q1: (anchor: right+top),
          q2-q2: (anchor: top+right),
          q1: (fill: green.lighten(50%))
          )
      )
    )
  ],
) 

Questo DFA accetta quindi tutte le stringhe che iniziano con il simbolo 1 mentre rifiuta tutte quelle che iniziano con il simbolo 0.

#showybox(
  frame: (
    border-color: red.lighten(60%),
    title-color: red.lighten(60%),
    body-color: red.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Attenzione - Stato Pozzo*],
  [Notiamo che è presente lo stato $q_2$ dal quale il DFA non esce più una volta entrato, questo è necessario perchè se omesso il DFA accetterebbe tutte le stringhe:#align(center,
      automaton(
        initial: "q0", final: none,
        (
          q0: (q1:1, q0:0),
          q1: (q1:(1,0)),
        ),
        layout: (q0: (0,0), q1: (3, 0), q2: (0, -3)),
        style: (
          q0-q2: (curve: -1, label: (anchor: left)),
          q1-q1: (anchor: right+top),
          q2-q2: (anchor: top+right),
          q1: (fill: green.lighten(50%))
          )
      )
    )
  Infatti in questo modo se in $q_0$ riceve 0 rimane su stesso ma poi continua ad attendere input. \ Il modo corretto per lasciare lo stesso significato del primo DFA ma omettere lo stato $q_2$ è quello di omettere anche il comportamento di $q_0$ in caso riceviamo 0, ovvero:
  #align(center,
      automaton(
        initial: "q0", final: none,
        (
          q0: (q1:1),
          q1: (q1:(1,0)),
        ),
        layout: (q0: (0,0), q1: (3, 0), q2: (0, -3)),
        style: (
          q0-q2: (curve: -1, label: (anchor: left)),
          q1-q1: (anchor: right+top),
          q2-q2: (anchor: top+right),
          q1: (fill: green.lighten(50%))
          )
      )
    )
  ]
)

Adesso dobbiamo dimostrare formalmente che questo DFA accetta il linguaggio fornito, dobbiamo quindi dimostrare che: $ "DFA accetta " x arrow.double.l.r x in L $

Innanzitutto facciamo due osservazioni, ovvero che se il DFA si trova in $q_1$ o $q_2$ allora non cambierà mai più stato:
- $delta^* (q_1, u) = q_1 quad forall u in {0,1}^*$
- $delta^* (q_2, u) = q_2 quad forall u in {0,1}^*$

Dimostriamo per induzione che il linguaggio è accettato, quindi presa una stringa dobbiamo far vedere che se inizia con 1 terminiamo in $q_1$ altrimenti in $q_2$.

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
  title: [*Dimostrazione*],
  showybox(
  frame: (
    border-color: purple.lighten(95%),
    title-color: purple.lighten(60%),
    body-color: purple.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Caso Base*],
  [
    Come caso base prendiamo una stringa vuota, quindi $|x|=0$ ovvero $x=epsilon$, abbiamo che: $ delta^*(q_0, epsilon) = delta(q_0, epsilon) = q_0 in.not F $
    Infatti se abbiamo una stringa vuota il DFA non fa nulla e rimane in $q_0$
  ]
  ),
  showybox(
  frame: (
    border-color: purple.lighten(95%),
    title-color: purple.lighten(60%),
    body-color: purple.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Passo Induttivo*],
  [
    Adesso dobbiamo prendere una stringa $w$ tale che $|w| lt.eq  n$ con $n>0$, la funzione di transizione avrà quindi 3 risultati possibili: $ delta^*(q_0,w) = cases(q_0 " se " w=epsilon, q_1 " se " w " inizia con " 1, q_2 " se " w " inizia con " 0) $

    Prendiamo quindi una stringa $x$ tale che $|x| = n+1$ e la costruiamo come $x=a u$ con $a in {0,1}$ e $u in {0,1}^*$, la funzione di transizione ci restituirà:

    $ delta^*(q_0,x) = delta^*(q_0, a u) = delta^*(undershell(delta (q_0, a), "ha 2 soluzioni"), u) $

    Le due soluzione del passaggio evidenziato sono:
    - $delta(q_0,a) = q_1$ se $a=1$
    - $delta(q_0,a) = q_2$ se $a=0$

    Quindi il DFA andrà sicuremante in uno dei due stati $q_1$ o $q_2$ e da lí non si muoverà più, per il ragionamento fatto all'inizio della dimostrazione.
  ]
  )
)

== Operazioni sui Linguaggi
Definiamo adesso delle operazioni sui linguaggi che ci torneranno utili.

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
  title: [*Unione*],
  [$ L_1 union L_2 = {x in Sigma^* : x in L_1 or x in L_2} $]
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
  title: [*Intersezione*],
  [$ L_1 inter L_2 = {x in Sigma^*:x in L_1 and x in L_2} $]
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
  title: [*Complemento*],
  [$ overline(L) = {x in Sigma^*: x in.not L} $]
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
  title: [*Concatenazione*],
  [$ L_1 circle.small L_2 = {x y : x in L_1 and y in L_2} $
  Da notare che questa operazione non è commutativa quindi $L_1 circle.small L_2 eq.not L_2 circle.small L_1$
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
  title: [*Potenza*],
  [Possiamo definirla ricorsivamente:
  $ cases(L_0 = epsilon, L^(n+1) = L^N circle.small L) $
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
  title: [*Operatore \* "star"*],
  [$ L^* = union.big_(n gt.eq 0) L^n = {epsilon} union L^1 union L^2 union dots $
  ]
)

== Proprietà di chiusura dei Linguaggi Naturali
Vogliamo capire se dati due linguaggi naturali $L_1,L_2 in "REG"$ il linguaggio risultante di operazioni effettuate con questi linguaggi è naturale o no, ad esempio se $L_1 union L_2 in "REG"$ oppure se $L_1 inter L_2 in "REG"$

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
  title: [*Teorema - Chiusura per Unione*],
  [Come prima idea possiamo dire che: $ L_1, L_2 in "REG" arrow.double.r exists M_1, M_2 in "DFA t.c. " L(M_1) = L_1 and L(M_2) = L_2 $ 
  ]
)
Quindi dati due linguaggi naturali esistono due automi che li hanno come linguaggi accettati. Noi dobbiamo definire un terzo automa $M$ tale che $L(M)=L_1 union L_2$, ma data una stringa $x$ candidata non possiamo provare a vedere prima cosa succede su $M_1$ e se non la accetta provare $M_2$ perchè perderemmo la sequenza corretta della stringa su $M$. 

Quello che dobbiamo fare è testare ogni carattere di $x$ in parallelo su $M_1$ e $M_2$ e in base al risultato aggiorniamo lo stato di $M$.