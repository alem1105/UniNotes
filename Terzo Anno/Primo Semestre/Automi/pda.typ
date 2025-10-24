#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= PDA (Push-Down Automata o Automi a Pila)

I PDA sono un'estensione dei DFA che riescono a riconoscere anche i linguaggi non regolari, loro infatti sono equivalenti alle CFG.

Possiamo vederli come degli NFA con associata una pila di tipo LIFO. Ad ogni passo di computazione il PDA può operare sulla cima della pila con diverse operazioni:
- Sostituzione del simbolo in cima
- PUSH ovvero inserimento di un simbolo in cima
- POP ovvero rimozione del simbolo in cima

Graficamente abbiamo che:

#align(center, 
  automaton(
    initial: none, final: none,
    (
      q1: (q2: ()),
      q2: ()
    ),
    layout: (q0: (0,0), q1: (3, 0)),
    style: (
      q1-q2: (label: $a;b arrow.r c$)
    )
  )
)

Il PDA sopra permette di spostarci da $q_1$ a $q_2$ se leggiamo $a$ e se in cima alla pila abbiamo $b$, nel passaggio sostitusce $b$ con $c$.

Sempre facendo riferimento all'esempio, questo significa che se leggiamo $a$ ma sulla pila non abbiamo $b$ allora non possiamo effettuare la transizione.

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
  title: [*Osservazioni*],
  [Dato che il PDA avrà più rami di computazione per via del non determinismo è importante notare che ogni ramo avrà una sua pila.
  
  Inoltre l'alfabeto della pila può anche essere diverso dall'alfabeto dell'automa.]
)

La funzione di transizione è definita come: 

$ "Dominio": Q times Gamma_epsilon times Gamma_epsilon, "Immagine": cal(P)(Q times Gamma_epsilon) $

Diamo una *definizione formale di PDA*.

Un PDA è una tupla $(Q, Sigma, Gamma, delta, q_0, F)$ dove $Q, Sigma, q_0, F$ sono come nei DFA / NFA mentre $Gamma$ è l'alfabeto usato dalla pila.

Cosa succede in una transizione? Prendiamo $(q,c) in delta(p, a, b)$, abbiamo diversi casi:
- Se $a,b,c eq.not epsilon$ allora la transizione leggendo $a$ ci porta dallo stato $p$, con $b$ in cima alla pila, allo stato $q$ con $c$ in cima alla pila.
- Se $c eq.not epsilon, b eq epsilon$ e $a$ in lettura allora fa PUSH di $c$. Ovvero abbiamo la siturazione $a; epsilon arrow.r c$
- Se $c eq epsilon, b eq.not epsilon$ e $a$ in lettura allora fa POP di $b$. Ovvero $a; b arrow.r epsilon$

Notiamo quindi che le configurazioni di un PDA sono del tipo $Q times Sigma^* times Gamma^*$

Quando, i PDA, si trovano in uno stato di accettazione? Un PDA $M$ accetta una stringa $w=w_1 ... w_n$ t.c. $w_i in Sigma$ se $exists r_0,...,r_m in Q$ e stringhe $s_0,...,s_m in Gamma^*$ t.c.:
- All'inizio $r_0 = q_0$ e $s_0 = epsilon$
- $r_m in F$
- $forall i = 0,...,m$:
  - $(r_(i+1), b) in delta(r_i, w_i,a)$
  - $s_i = a t$ e $s_(i+1)=b t$ con $a,b in Gamma_epsilon$ e $t in Gamma^*$

Quindi partiamo con $r_0$ uguale allo stato iniziale e con lo stack $s$ vuoto, ad ogni transizione passiamo da $r_i$ a $r_(i+1)$ se abbiamo in cima allo stack un carattere $a$ e leggendo $w_i$, infatti avremo che lo stack ad $s_i$ è uguale alla stringa composta da $a$ ovvero l'ultimo carattere e $t$ la stringa precedente, all'ultima transizione ovvero $s_(i+1)$ avremo come carattere in cima $b$ e poi $t$ che comprende tutti gli altri caratteri.

Quindi possiamo mettere in relazione due configurazioni:

$ (p, a x, b y) tack.r_M (q, x, c y) "se e solo se" (q,c) in delta(p,a,b) $

Con $a in Sigma; x in Sigma^*; a,b in Gamma, y in Gamma^*; p,q in Q$

Come per i DFA e NFA possiamo estendere la chiusura con la chiusura simmetrica e transitiva:

$ L(M) = {w in Sigma^* : (q_0, w, epsilon) tack.r_M^* (q, epsilon, y) quad q in F, y in Gamma^*} $

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
  title: [*Nota*],
  [Il PDA accetta *indipendentemente dal contenuto della pila* quindi, senza perdere generalità, possiamo assumere che la pila deve essere vuota.]
)

== Corrispondenza tra PDA e CFG

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
  title: [*Teorema*],
  [Un linguaggio è acontestuale se e solo se esiste un PDA che lo riconosce.]
)

*Lemma* - Se $L$ è acontestuale allora $exists M in "PDA t.c." L = L(M)$. Ovvero una delle due implicazioni del teorema.

*Dimostrazione* - Sia $M=(Q, Sigma, Gamma, delta, q_0, F)$, scriviamo le transizioni in questo modo:

#align(center, 
  automaton(
    initial: none, final: none,
    (
      q: (r: ()),
      r: ()
    ),
    layout: (q: (0,0), r: (3, 0)),
    style: (
      q-r: (label: $a;s arrow.r x y z$)
    )
  )
)

Questa transizione implica che $(r, x y z) in delta(q,a,s)$. 

Consideriamo la grammatica $G=(V, Sigma, R, S)$.

Definiamo il PDA:
- $Q = {q_"START", q_"LOOP", q_"ACC")} union Q'$ dove $Q'$ sono degli stati ausiliari che ci serviranno per definire $delta$.
- $Gamma = V union Sigma$
- $F = {q_"ACCEPT"}$
- Dato $q_"START" in Q$, inseriamo $S\$$ nello stack, si ha che:

$ delta(q_"START", epsilon, epsilon) = {(q_"LOOP", S\$)} $

A questo punto, nello stato $q_"LOOP"$ abbiamo diversi casi:
- Se la cima dello stack contiene una variabile $(A in V)$ allora

$ delta(q_"LOOP", epsilon, A) = {(q_"LOOP", w): A arrow.r w "con" w in G} $

- Se la cima contiene un terminale $(a in Sigma)$ allora 

$ delta(q_"LOOP", a, a) = {(q_"LOOP", epsilon)} $


- Se la cima contiene \$ allora

$ delta(q_"LOOP", epsilon, \$) = {(q_"ACC", epsilon)} $

Graficamente abbiamo che:

#align(center, 
  automaton(
    initial: "q0", final: none,
    (
      q0: (q1: ()),
      q1: (q1: (), q2: ()),
      q2: ()
    ),
    layout: (q0: (0, 0), q1: (3, 0), q2: (6, 0)),
    style: (
      q0: (label: $q_"start"$),
      q1: (label: $q_"loop"$),
      q2: (label: $q_"acc"$),
      q0-q1: (label: $epsilon; epsilon arrow.r s\$$),
      q1-q1: (label: $\ \ epsilon; A arrow.r w \ a; a arrow.r epsilon$, anchor: bottom),
      q1-q2: (label: $epsilon; \$ arrow.r epsilon$)
    )
  )
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
  title: [*Esempio*],
  [Consideriamo la grammatica $G$ con le regole $S arrow.r a T b | b$ e $T arrow.r T a | epsilon$, costruire il PDA equivalente, usando le regole della dimostrazione precedente:
  
  #align(center, image("img/Senza titolo-2025-10-07-0914.svg", width: 80%))
  ]
)