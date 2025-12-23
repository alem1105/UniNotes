#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= Espressioni Regolari

Possiamo vederle come delle espressioni algebriche, ma definiscono dei linguaggi su un certo alfabeto.

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
  [$ (0 union 1) circle 0^* " che equivale a " {0,1} circle 0^* $]
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
  [Sia $Sigma$ un alfabeto possiamo definire un'espressione regolare ssu $Sigma$ (denotata con $"re"(Sigma)$) in modo ricorsivo: $ "caso base" cases(emptyset in "re"(Sigma), epsilon in "re"(Sigma), a in "re"(Sigma) " con " a in Sigma) $
  
  $ "induzione" cases(R_1 union R_2 " se " R_1\, R_2 in "re"(Sigma), R_1 circle R_2 " se " R_1\, R_2 in "re"(Sigma), (R_1)^* " se " R_1 in "re"(Sigma)) $]
)

Ogni espressione regolare ha un solo linguaggio associato: $ L(r) " t.c. " r in "re"(Sigma) $

Vediamolo ricorsivamente: $ "caso base" cases(L(r) = emptyset " se " r = emptyset, L(r) = epsilon " se " r = epsilon, L(r)={a} " se " r=a ) $

$ "induzione" cases(L(r) = L(R_1) union L(R_2) " se " r = R_1 union R_2, L(r) = L(R_1) circle L(R_2) " se " r = R_1 circle R_2, L(r)=(L(R_1))^* " se " r=R_1^* ) $

Qualche esempio:
- $0^* 1 0^* = {w: w " contiene esattamente un 1"}$

- $Sigma^* 1 Sigma^* = {w: w " contiene almeno un 1"}$

- $Sigma^* 001 Sigma^* = {w: w " contiene 001 come sottostringa"}$

- $(0 union 1000)^* = {w: "ogni occorrenza di 1 é seguita da 000"}$

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
  [Un linguaggio regolare è regolare se e solo se esiste un'espressione regolare che lo descrive: $ "REG" equiv L("re") $]
)

Per dimostrarlo dobbiamo dimostrare la doppia implicazione $L("re") subset.eq "REG"$ e $"REG" subset.eq L("re")$.

Iniziamo dimostrando $L("re") subset.eq "REG"$, quindi data un'espressione regolare $r$ costruiamo un NFA $N_r$ tale che $L(N_r) = L(r)$.

I casi base sono 3, quando l'espressione regolare è un solo carattere, quando l'espression regolare è la stringa vuota oppure quando è l'insieme vuoto.

Data l'espressione regolare $r=a$ con $a in Sigma$ costruiamo l'NFA che la riconosce:

#align(center,
  automaton(
    initial: "q0", final: none,
    (
      q0: (q1:"a"),
      q1: (),
    ),
    layout: (q0: (0,0), q1: (3, 0)),
    style: (
      q1: (fill: green.lighten(50%))
    )
  )
)

Dove:
- $N_r = ({q_0, q_1}, Sigma, delta, q_0, {q_1})$
- $delta(q_0, a)=q_1$
- $delta(q, b) = emptyset$ con $q eq.not q_1 and b eq.not a$

Se invece abbiamo $r=epsilon$, possiamo costrutire:

#align(center,
  automaton(
    initial: "q1", final: none,
    (
      q1: ()
    ),
    layout: (q1: (0,0)),
    style: (
      q1: (fill: green.lighten(50%))
    )
  )
)

Definiamo:
- $N_r = ({q_1}, Sigma, delta, q_1, {q_1})$
- $delta (q_1, b) = emptyset, forall b in Sigma$

Se invece $r=emptyset$ costruiamo:

#align(center,
  automaton(
    initial: "q1", final: none,
    (
      q1: ()
    ),
    layout: (q1: (0,0)),
  )
)

Definiamo:
- $N_r = ({q_1}, Sigma, delta, q_1, emptyset)$
- $delta (q_1, b) = emptyset, forall b in Sigma$

Adesso per il caso induttivo dobbiamo considerare un'espressione regolare $r=R_1 union R_2$ e per ipotesi induttiva sappiamo che $exists M_1, M_2$ t.c. $L(M_1) = L(R_1) and L(M_2) = L(R_2)$ e per chiusura di REG sappiamo che questo implica che $exists M " t.c. " L(M) = L(R_1) union L(R_2)$. Questo è analogo per la concatenazione e l'operatore star.

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
  [Vogliamo costruire un NFA che riconosce il linguaggio $("ab" union "a")^*$
  - Possiamo costruire prima l'automa che riconosce $a$:

  #align(center,
    automaton(
      initial: "q0", final: none,
      (
        q0: (q1:"a"),
        q1: (),
      ),
      layout: (q0: (0,0), q1: (3, 0)),
      style: (
        q1: (fill: green.lighten(50%))
      )
    )
  )

  - Poi costruiamo l'automa che riconosce $b$:

  #align(center,
    automaton(
      initial: "q0", final: none,
      (
        q0: (q1:"b"),
        q1: (),
      ),
      layout: (q0: (0,0), q1: (3, 0)),
      style: (
        q1: (fill: green.lighten(50%))
      )
    )
  )

  - Adesso possiamo ricavare quello che riconosce $a b$:

  #align(center,
    automaton(
      initial: "q0", final: none,
      (
        q0: (q1:"a"),
        q1: (q2: ""),
        q2: (q3: "b"),
        q3: ()
      ),
      layout: (q0: (0,0), q1: (2, 0), q2: (4,0), q3: (6,0)),
      style: (
        q3: (fill: green.lighten(50%)),
        q1-q2: (label: $epsilon$)
      )
    )
  )

  - Costruiamo l'automa che riconosce $("ab" union "a")$:

  #align(center,
    automaton(
      initial: "q", final: none,
      (
        q: (q0: "", q4: ""),

        q0: (q1:"a"),
        q1: (q2: ""),
        q2: (q3: "b"),
        q3: (),

        q4: (q5: "a"),
        q5: ()
      ),
      layout: (q: (-2, -1), q0: (0,0), q1: (2, 0), q2: (4,0), q3: (6,0), q4: (0, -2), q5: (2, -2)),
      style: (
        q3: (fill: green.lighten(50%)),
        q-q0: (label: $epsilon$),
        q1-q2: (label: $epsilon$),
        q-q4: (label: $epsilon$, curve: -1),
        q4-q5: (curve: -1),
        q5: (fill: green.lighten(50%))
      )
    )
  )

  - Infine costruiamo l'NFA che riconosce il linguaggio dell'espressione regolare:

  #align(center,
    automaton(
      initial: "i", final: none,
      (
        i: (q: ""),
        q: (q0: "", q4: ""),

        q0: (q1:"a"),
        q1: (q2: ""),
        q2: (q3: "b"),
        q3: (q: ""),

        q4: (q5: "a"),
        q5: (q: ""),
      ),
      layout: (i: (-4, -1), q: (-2, -1), q0: (0,0), q1: (2, 0), q2: (4,0), q3: (6,0), q4: (0, -3), q5: (2, -3)),
      style: (
        i-q: (label: $epsilon$),
        i: (fill: green.lighten(50%)),
        q3: (fill: green.lighten(50%)),
        q-q0: (label: $epsilon$),
        q1-q2: (label: $epsilon$),
        q-q4: (label: $epsilon$, curve: -1),
        q4-q5: (curve: -1),
        q5: (fill: green.lighten(50%)),
        q3-q: (label: $epsilon$, curve: 0.8, anchor: bottom),
        q5-q: (label: $epsilon$, curve: -0.5)
      )
    )
  )
  ]
)

Adesso dobbiamo dimostrare la seconda implicazione, quindi $"REG" subset.eq L("re")$. Dobbiamo quindi prendere un NFA e vogliamo trovare l'espressione regolare corrispondente.

Prima di farlo vediamo come *convertire un NFA in un'espressione regolare*.

== Convertire NFA in espressione regolare

Partiamo da un NFA $N$ con $L in "REG":L(N)=L$ e introduciamo il concetto di *GNFA (NFA Generalizzato)*.

Per GNFA intendiamo un NFA dove le etichette degli archi sono delle espressioni regolari.

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
  title: [*Forma Canonica del GNFA*],
  [Un GNFA si trova in forma canonica quando:
  - Lo stato iniziale ha solo archi uscenti verso tutti gli altri stati
  - Lo stato finale ha solo archi entranti
  - Fatta eccezione per lo stato finale ed iniziale esiste un arco fra ogni coppia di stati
  
  Più formalmente dato GNFA=$(Q, Sigma, delta, q_("START"), q_("ACC"))$: $ delta:Q \\ {q_("ACC")} times Q \\ {q_("START")} arrow.r cal(R)="re"(Sigma) $
  Dove $cal(R)$ è l'insieme di tutte le espressioni regolari sul linguaggio $Sigma$]
)

Definiamo adesso la funzione `Convert(G)` che prende in input un grafo e restituisce l'espressione regolare associata.

Definiamo `Convert`:
- Definiamo $k =$ numero di stati in G.
- Se $k=2$ significa che abbiamo soltanto $q_("start"),q_("acc")$ e un singolo arco con etichetta $R in cal(R)$. Avremo $R$ come output.
- Se $k>2$ scegliamo uno stato $q_("rip")$ diverso da $q_("start")$ e $q_("acc")$ e definiamo $G'={Q',Sigma, delta', q_("start"), q_("acc")}$ dove:
  - $Q'=Q \\ {q_("rip")}$
  - $delta':Q' \\ {q_("acc")} times Q' \\ {q_("start")} arrow.r cal(R)$

Adesso $forall q_i in Q' \\ {a_("acc")}, q_j in Q' \\ {q_("start")}$ consideriamo l'automa:

#align(center,
  automaton(
    initial: none, final: none,
    (
      qi: (qj:"R4", qrip: "R1"),
      qj: (),
      qrip: (qj: "R3", qrip: "R2"),
    ),
    layout: (qi: (0,0), qj: (0, 2), qrip: (-2,1)),
    style: (
      qrip-qrip: (anchor: left),
      qi-qj: (curve:-1)
    )
  )
)

Dove:
- $"R1" = delta(q_i, q_("rip"))$
- $"R2" = delta(q_("rip"), q_("rip"))$
- $"R3" = delta(q_j, q_("rip"))$
- $"R4" = delta(q_i, q_j)$

Consideriamo questo automa perché ci interessano soltanto gli archi che collegano $q_i$ e $q_j$ oppure che riguardano $q_("rip")$.
Avremo quindi che $ delta'(q_i,q_j)="(R1)(R2)*(R3)"union "(R4)" $

Abbiamo quindi definito un automa che ci permette di muoverci fra $q_i$ e $q_j$ anche senza $q_("rip")$, dobbiamo continuare a ripetere questo procedimento finché non rimaniamo soltanto con lo stato iniziale e lo stato accettante.

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
    #image("img/image.png")

    _Quando avrò tempo lo farò più carino :P_
  ]
)

Adesso possiamo concludere la dimostrazione iniziata nel capitolo precedente.

Dobbiamo dimostrare che quello che otteniamo da `Convert(G)` è equivalente a $G$.

Se $k=2$ è sicuramente vero.

L'espressione regolare $R$ descrive tutte le stringhe che portano, in $G$, da $q_("start")$ a $q_("acc")$.

Supponiamo che sia vero per $k-1$ stati e dimostriamo che è vero per $k$ stati mostrando che $L(G)=L(G')$ dove $G'$ è l'automa con uno stato rimosso.

Se l'automa $G$ accetta una stringa $w$ significa che esiste un ramo di computazione che permette a $G$ di percorrere gli stati $q_("start")...q_("acc")$, se questa sequenza non contiene $q_("rip")$ allora abbiamo che $L(G)=L(G')$ perché le nuove espressioni regolari conterranno le vecchie per unione.

Se invece $q_("rip")$ è presente nella sequenza avremo comunque che gli stati a lui adiacenti ($q_1, q_2$) in $G'$ hanno degli archi che tengono conto di tutti i modi per percorrere un cammino da $q_1$ a $q_2$ direttamente o passando per $q_("rip")$ e quindi otteniamo di nuovo $L(G)=L(G')$.

= Pumping Lemma
Serve a dimostare che un linguaggio non è regolare.

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
  title: [*Teorema - Pumping Lemma*],
  [
    Se $L$ è regolare, allora esiste $p$ t.c. presa $w in L$ con $|w| gt.eq p$, allora $w$ può essere scomposta in $w=x y z$ in modo che:
    1. $forall i gt.eq 0$ si ha che $x y^i z in L$
    2. $|y| > 0$
    3. $|x y| lt.eq p$
  ]
)

Vedremo che questo $p$ è il numero di stati dell'automa, infatti prima di dimostrare ragionamo su questo caso:

Fissiamo $p=$\#stati automa ed $M$ t.c. $L(M)=L$ e siccome $|w|gt.eq p$, scomponiamo in questo modo:

#align(center,
  automaton(
    initial: none, final: none,
    (
      q0: (q1: "x"),
      q1: (q1: "y", q2: "z"),
      q2: ()
    ),
    layout: (q0: (0, 0), q1: (3, 0), q2: (6, 0)),
    style: (
      q2: (fill: green.lighten(50%))
    )
  )
)

Una ripetizione, in questo caso $y$, deve esistere sempre dato che la stringa è più grande del numero di stati. Significa appunto che uno stato deve sicuramente ripetersi.

== Dimostrazione
Sia $M=(Q,Sigma, delta, q_1, F)$ t.c. $L(M)=L$ e sia $p=|Q|$.
Consideriamo inoltre $w=w_1 w_2 ... w_n$ con $n gt.eq p$.

Consideriamo anche la sequenza di stati $r_1,...,r_(n+1)$ attraversati da $M$ su input $w$, avremo che $r_1 = q_1$ e $r_(n+1) in F$. Ovviamente avremo che $n+1 gt.eq p+1$.

Per il *pigeonhole principle*, nella sequenza considerata ci sarà sicuramente uno stato che si ripete, sia questo stato $r_j$ nella prima apparizione e $r_l$ nella seconda ($j eq.not l$, lo stato è lo stesso ma consideriamo due iterazioni diverse ovvero j quando lo incontriamo e l quando si ripete per la prima volta), avremo ovviamente che $l lt.eq p+1$ perché $r_l$ si presenta tra le prime $p+1$ posizioni nella sequenza che inizia con $r_1$.

Scomponiamo la stringa in $w= x y z$ e poniamo:
- $x= w_1, ... w_(j-1)$. Ovvero la stringa prima del primo stato che si ripete.
- $y=w_j ... w_(l-1)$. Prima della prima ripetizioni.
- $z = w_l ... w_n$. Tutto il resto della stringa.

Abbiamo che:
- $x$ porta $M$ da $r_1 = q_1$ ad $r_j$
- $y$ porta $M$ da $r_j$ ad $r_l = r_j$
- $z$ porta $M$ da $r_j = r_l$ a $r_(n+1) in F$

Quindi notiamo che possiamo ripetere $y$ quante volte vogliamo e la stringa ottenuta $x y^i z$ apparterrà sempre al linguaggio. *Dimostrata la prima condizione*.

Siccome $j eq.not l$ per costruzione allora $|y|>0$. *Seconda condizione*.

Infine $l lt.eq p+1$ e allora $|x y|=l-1 lt.eq p$. *Terza condizione*

== Esempi 
Utilizziamo il pumping lemma.

1) Mostrare che $L={o^n 1^n : n gt.eq 0}$ non è regolare.

Scegliamo una stringa $0^p 1^p$ con $p$ che sarà il nostro *valore di pumping* che scegliamo per contraddire la prova. Vogliamo comunque $|w| gt.eq q$ per rientrare nelle condizioni.

Se il linguaggio fosse regolare allora presa $w=0^p 1^p$, per qualsiasi scomposizione $w=x y z$ t.c. $|x y| lt.eq p$ avremo che $y$ è composta da soli '0': $ w=underbracket(0..., "x")underbracket(..., "y")01.....1 $

Per falsificare la condizione quindi ci basta prendere una $i gt.eq 2$ e avremo una stringa $x y^i z = o^q 1^p$ con $q>p$ che non rientra nel linguaggio dato che il numero di 0 ed 1 non è lo stesso.

2) Mostrare che il linguaggio $L={w in {0,1}^*: \#_0 w = \#_1 w}$ ovvero le stringhe hanno lo stesso numero di 0 ed 1 ma in qualsiasi ordine.

Proviamo a scomporre con $w in L$ t.c. $w=(01)^p$ e con $|w|=2p gt.eq p$

Otteniamo una stringa: $ underbracket(01, "y")underbracket(0101010...01, "z") quad x = epsilon $

Notiamo però che questa scomposizione non va bene per falsificare le condizioni, infatti qualsiasi $i$ prendiamo aumentiamo sia il numero di 0 che di 1 quindi la stringa appartiene al linguaggio.

Proviamo con la stringa $w=0^p 1^p$ con $|w|=2p$ e rispettiamo $|x y|lt.eq p$ e $|y| > 0$.

Siccome $|x y| lt.eq p$ allora $y$ è fatta solo da 0: $ underbracket(0....0, "x")underbracket(0.....0, "y")underbracket(1....1,"z") $

In questo caso aumentando $y$ aumentiamo soltanto gli 0 e quindi la stringa non appartiene a $L$.

Più precisamente abbiamo che:

- $|y|=k>0$ ma $k lt.eq p$ e inoltre $|x|=p-k, |z| = p$, tuttavia $|x y^2 z|=(p-k)+2k+p=2p+k$ ma il numero di 0 è $(p-k)+2k=p+k$ mentre quello degli 1 è sempre $p$ che è $<p+k$, quindi non rientra nel linguaggio.

Con la stessa stringa possiamo provare anche questa scomposizione: $ underbracket(0....., "x")underbracket(...00.., "y")underbracket(...01...1, "z") $

Anche in questo caso aumentiamo solo gli 0 e quindi non rientriamo nel linguaggio. Più precisamente:

- $|y| = k>0$
- $|z|=p+l$
- $|x|=p-k-l$
- Assumendo $l>0$

Tuttavia $|x y^2 z|=(p-k-l)+2k+p+l=2p+k$ ma il numero di 0 è $(p-k-l)+2k+l=p+k$ mentre quello degli 1 è $p<p+k$.

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
  title: [*Esercizio*],
  [
    Costruire un DFA per il linguaggio $L={w in {0,1}^* : w in.not (01^+)^*}$. Realizzare dei DFA che non rispettano delle regole potrebbe essere complicato considerando solo questa richiesta. Un'idea però potrebbe essere quella di realizzare un DFA che rispetta quella regola e poi usare il complemento per ottenere un linguaggio, sempre regolare per la proprietà di chiusura, che rispetta la richiesta iniziale.

    Costruiamo quindi un DFA che riconosce $(01^+)^*$:
    #align(center,
      automaton(
        initial: "q0", final: none,
        (
          q0: (q1: "0"),
          q1: (q2: "1"),
          q2: (q2: "1", q1: "0")
        ),
        layout: (q0: (0, 0), q1: (3, 0), q2: (6, 0)),
        style: (
          q2: (fill: green.lighten(50%)),
          q0: (fill: green.lighten(50%))
        )
      )
    )

    Per realizzare il complemento dobbiamo scambiare gli stati accettanti con quelli non accettanti, per non perdere delle stringhe però è importante *completare l'automa*:

    #align(center,
      automaton(
        initial: "q0", final: none,
        (
          q0: (q1: "0", q3: "1"),
          q1: (q2: "1", q3: "0"),
          q2: (q2: "1", q1: "0"),
          q3: (q3: ("0", "1"))
        ),
        layout: (q0: (0, 0), q1: (3, 0), q2: (6, 0), q3: (0, -3)),
        style: (
          q0-q3: (curve: -1),
          q2: (fill: green.lighten(50%)),
          q0: (fill: green.lighten(50%)),
          q3-q3: (anchor: left+bottom)
        )
      )
    )
  ]
)

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
  title: [*Esercizio - continuo*],
  [
    A questo punto possiamo eseguire il complemento:
    #align(center,
      automaton(
        initial: "q0", final: none,
        (
          q0: (q1: "0", q3: "1"),
          q1: (q2: "1", q3: "0"),
          q2: (q2: "1", q1: "0"),
          q3: (q3: ("0", "1"))
        ),
        layout: (q0: (0, 0), q1: (3, 0), q2: (6, 0), q3: (0, -3)),
        style: (
          q0-q3: (curve: -1),
          q1: (fill: green.lighten(50%)),
          q3: (fill: green.lighten(50%)),
          q3-q3: (anchor: left+bottom)
        )
      )
    )    
    Abbiamo ottenuto l'automa che cercavamo inizialmente.
  ]
)