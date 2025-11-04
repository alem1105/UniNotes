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

Quando, i PDA, si trovano in uno stato di accettazione? Un PDA $M$ accetta una stringa $w=w_1 ... w_m$ t.c. $w_i in Sigma$ se $exists r_0,...,r_m in Q$ e stringhe $s_0,...,s_m in Gamma^*$ t.c.:
- All'inizio $r_0 = q_0$ e $s_0 = epsilon$
- $r_m in F$
- $forall i = 0,...,m-1$:
  - $(r_(i+1), b) in delta(r_i, w_(i+1),a)$
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

Dimostriamo quindi la seconda parte dell-implicazione.

*Lemma* - Se $L$ è riconosciuto da un PDA $M$ allora $L$ è acontestuale.

Abbiamo un PDA $P$ e vogliamo costruire una grammatica $G$ che genera tutte le stringhe accettate da $P$. Generiamo una grammatica che per ciascuna coppia di stati $p, q in P$ avrà una variabile $A_(p q)$, questa variabile genera tutte le stringhe che portano $P$ da $p$ con pila vuota a $q$ con pila vuota. Da notare che queste stringhe possono portare $P$ da $p$ a $q$ indpendentemente dal contenuto della pila ma lasciandola comunque nella stessa condizione di prima.

Forniamo a $P$ delle caratteristiche per semplificare la dimsotrazione ma senza perdere di generalità:
- Ha un unico stato accettante $p_"acc"$
- Svuota lo stack prima di accettare
- Ciascuna transizione o fa un POP o fa un PUSH, non può farle entrambe

Per fornire l'ultima caratterstica al PDA dobbiamo sostituire tutte le transizione che sostituiscono simboli (POP e PUSH contemporaneamente) con una sequenza di transizioni, inoltre sostituiamo anche ogni transizione che non fa POP o PUSH con una sequenza di transizioni che inserisce ed elima un simbolo dalla pila.

Per qualsiasi stringa $x$ che dobbiamo generare, l'automa $P$ farà come prima azione un PUSH, dato che non può eliminare dalla pila vuota, l'ultima azione invece sarà sicuramente un POP perchè la pila deve essere vuota.

Durante questa computazione possono verificarsi due casi:

1. Il simbolo eliminato alla fine è lo stesso simbolo che è stato inserito all'inizio, in questo caso la pila potrebbe essere vuota soltanto all'inizio e alla fine della computazione su $x$.

Questa possibilità la gestiamo con la regola: $ A_(p q) arrow.r a A_(r s)b $ dove $a$ è l'input della prima transizione e $b$ nell'ultima, $r$ è lo stato che segue $p$ ed $s$ è lo stato che precede $q$.

2. Il simbolo inserito all'inizio viene tolto durante la computazione ma non alla fine, la pila si svuota in quel punto.

Questa possibilità la simuliamo con la regola:
$ A_(p q) arrow.r A_(p r)A_(r q) $

*Dimostrazione* - Prendiamo $P=(Q,Sigma,Gamma,delta,q_0,{q_"acc"})$ e assumiamo che sia nella forma di prima. La grammatica $G$ sarà definita da $V={A_(p q):p,q in Q}$ ed $S=A_(q_0 q_"acc")$. Le regole sono:
- $forall p,q,r,s in Q; u in Gamma; a,b in Sigma_epsilon$
  - Se $(r,u) in delta(p,a,epsilon)$ e $(q,epsilon) in delta(s,b,u)$ allora $A_(p q) arrow.r a A_(r s) b$
- $forall p,q in Q; A_(p q) arrow.r A_(p r)A_(r q)$
- $forall p in Q; A_(p p) arrow.r epsilon$

Proviamo che questa costruzione funziona dimostrando che $A_(p q)$ genera $x$ se e solo se $x$ porta $P$ da $p$ con pila vuota a $q$ con pila vuota. Consideriamo la doppia implicazione.

*Fatto 1* - Se $A_(p q)$ genera $x$ allora $x$ può portare $P$ da $p$ con pila vuota a $q$ con pila vuota. Dimostriamolo per induzione sul numero di passi nella derivazione di $x$ da $A_(p q)$

- *Caso Base*: La derivazione è in un solo passo, in questo caso deve usare una regola dove nella parte destra non ci sono variabili, l'unica regola è $A_(p p) arrow.r epsilon$ e ovviamente questa regola porta da $p$ con pila vuota a $p$ con pila vuota.

- *Induzione*: Assumiamo il fatto vero per $k$ derivazioni con $k gt.eq 1$ e dimostriamo per $k + 1$.

Supponiamo che $A_(p q) arrow.double.r^* x$ in $k+1$ passi, il primo passo può usare una delle due regole di prima, vediamo entrambi i casi:

- Caso $A_(p q) arrow.r a A_(r s)b$: Dividiamo $x$ in $x=a y b$ e consideriamo la parte $y$ generata da $A_(r s)$. Dato che $A_(r s) arrow.double.r^* y$ in $k$ passi, l'ipotesi induttiva ci dice che $P$ può andare da $r$ con la pila vuota a $s$ con la pila vuota. Dato che $A_(p q) arrow.r a A_(r s) b$ è una regola di $G$ allora $(r,u) in delta(p,a,epsilon)$ e $(q, epsilon) in delta(s,b,u)$ per qualche simbolo $u$ della pila. Quindi se $p$ inizia con pila vuota, legge $a$ e può andare in $r$ con $u$ nella pila, leggendo $y$ può andare in $s$ e lasciare $u$ sulla pila, poi può leggere $b$ ed andare in $q$ eliminando $u$.

- Caso $A_(p q) arrow.r A_(p r)A_(r q)$: Consideriamo le parti di $x = y z$, dato che $A_(p r) arrow.double.r^* y$ in al più $k$ passi e $A_(r q) arrow.double.r^* z$ in al più $k$ passi, l'ipotesi induttiva ci dice che $y$ può portare $P$ da $p$ ad $r$ e $z$ può portare $P$ da $r$ a $q$ con la pila vuota all'inizio e alla fine.

Quindi $x$ può portare $P$ da $p$ a $q$ con la pila vuota.

*Fatto 2* - Se $x$ può portare $P$ da $p$ a $q$ con la pila vuota allora $A_(p q)$ genera $x$. Dimostriamo sempre per induzione sul numero di passi nella computazione da $p$ a $q$ con input $x$.

- *Caso Base*: La computazione ha 0 passi quindi inizia e termina nello stesso stato $p$. Dobbiamo mostrare che $A_(p p) arrow.double.r^* x$. $P$ non può leggere alcun carattere in 0 passi quindi $x = epsilon$ e per costruzione di $G$ abbiamo la regola $A_(p p) arrow.r epsilon$ quindi il caso base è dimostrato

- *Passo Induttivo*: Assumiamo l'enunciato vero per computazioni lunghe $k gt.eq 0$, dimostriamo per $k+1$. Supponiamo ci sia una computazione in $P$ dove $x$ lo porta da $p$ a $q$ con pile vuote in $k+1$ passi, anche qui o la pila è vuota solo all'inizio e solo alla fine o si svuota in altri momenti.

Nel primo caso il simbolo inserito all'inizio deve essere quello rimosso alla fine, chiamiamo $u$ questo simbolo e sia $a$ il simbolo di input letto nella prima mossa e $b$ quello letto nell'ultima, $r$ lo stato dopo la prima mossa ed $s$ lo stato prima dell'ultima allora $(r,u) in delta(p,a,epsilon)$ e $(q, epsilon) in delta(s,b,u)$ e quindi la regola $A_(p q) arrow.r a A_(r s) b$ è in $G$.

Consideriamo la parte $y "di" x=a y b$, l'input può portare $P$ da $r$ ad $s$ senza toccare $u$ e quindi far muovere $P$ da $r$ a $s$ con una pila vuota su input $y$, abbiamo eliminato il primo e l'ultimo passo dei $k+1$ quindi abbiamo ottenuto $k-1$ passi, per ipotesi induttiva abbiamo $A_(r s) arrow.double.r^* y$ e quindi $A_(p q) arrow.double.r^* x$

Nel secondo caso sia $r$ uno stato in cui si svuota la pila oltre alla fine o inizio, allora le computazioni da $p$ a $r$ e da $r$ a $q$ contengono al più $k$ passi, sia $y$ l'input letto nella prima parte e sia $z$ l'input letto nella seconda, l'ipotesi induttiva ci dice che $A_(p r) arrow.double.r^* y$ e $A_(r q) arrow.double.r^* z$. Siccome la regola $A_(p q) arrow.r A_(p r)A_(r q)$ è in $G$ allora $A_(p q) arrow.double.r^* x$.

Possiamo dire quindi che *ogni linguaggio regolare è context-free*.

= Pumping Lemma per i linguaggi CFL
_Segue 1:1 il libro in modo che me la studio da qui_

Se $A$ è un linguaggio context-free allora esiste un numero $p$ tale che, se $s$ è una stringa in $A$ di lunghezza almeno $p$ allora può essere divisa in cinque parti $s=u v x y z$ che soddisfano:
- $forall i gt.eq 0, u v^i x y^i z in A$
- $|v y| > 0$, serve per dire che entrambe non sono la stringa vuota altrimenti il teorema sarebbe banalmente vero.
- $|v x y| lt.eq p$, afferma che queste 3 parti hanno al più lunghezza $p$, utile per dimostrare che alcuni linguaggi non sono context-free.

Preso un CFL $A$ e una CFG $G$ che lo genera dobbiamo mostrare che ogni stringa sufficientemente lunga $s in A$ può essere iterata e restare in $A$. Sia $s$ una stringa molto lunga in $A$, essa è derivabile da $G$ e quindi ha un albero sintattico.

Anche l'albero sintattico sarà molto lungo e ci deve essere un cammino dalla variabile alla radice a uno dei simboli terminali su una foglia. Per il principio della piccionaia qualche simbolo di variabile $R$ si deve ripetere in questo cammino lungo. Questa ripetizione ci permette di sostituire il sottoalbero sotto la seconda occorrenza di $R$ con il sottoalbero sotto la prima occorrenza di $R$ e ottenere un albero sintattico consentito:

#align(center, image("img/palbero.png", width: 80%))

Questo significa che possiamo dividere la stringa in cinque parti $u v x y z$ e possiamo replicare il secondo e quarto pezzo e ottenere ancora una stringa nel linguaggio, formalmente $u v^i x y^i z in A$ per ogni $i gt.eq 0$.

Vediamo la *dimostrazione*:
Sia $G$ una CFG per il CFL $A$ e sia $b$ il massimo numero di simboli nel lato destro di una regola (assumiamo che sia almeno 2), questo significa che in ogni albero sintattico di questa grammatica un nodo non può avere più di $b$ figli, abbiamo quindi che:
- Ci sono al più $b$ foglie in un passo dalla variabile iniziale.
- Ci sono al più $b^2$ foglie in 2 passi dalla variabile iniziale
- Ci sono al più $b^h$ foglie in $h$ passi dalla variabile iniziale.

Quindi se l'altezza dell'albero è al più $h$, la lunghezza della stringa generata è al più $b^h$. Viceversa se una stringa generata ha lunghezza maggiore o uguale a $b^h + 1$ allora ciascuno dei suoi alberi sintattici deve avere un'altezza maggiore o uguale a $h+1$.

Sia $V$ il numero delle variabili in $G$, poniamo $p$ (lunghezza del pumping) uguale a $b^(|V + 1)$. Ora se $s$ è una stringa in $A$ e la sua lunghezza è maggiore o uguale a $p$ allora il suo albero sintattico deve avere altezza maggiore o uguale a $|V|+1$ dato che $b^(|V|+1) gt.eq b^|V|+1$.

Presa la stringa $s$ e $tau$ il suo albero sintattico che abbia il più piccolo numero di nodi, $tau$ deve avere altezza maggiore o uguale a $|V|+1$ quindi il suo cammino più lungo radice-foglia ha lunghezza almeno $|V|+1$, questo cammino:
- Ha almeno $|V|+2$ nodi
- Uno etichettato da un terminale
- Gli altri etichettati da variabili, almeno $|V+1$

Siccome $G$ ha solo $|V|$ variabili allora qualche variabile $R$ è presente più volte su questo cammino, scegliamo una variabile che si ripete più in basso per comodità.

Dividiamo la stringa in cinque parti come nella figura precedente, ogni occorrenza di $R$ ha un sottoalbero sotto essa che genera una parte della stringa $s$, l'occorrenza più in alto di $R$ ha un sottoalbero più grande e genera $v x y$ mentre quella più in basso soltanto $x$. Entrambi questi sottoalberi sono generati dalla stessa variabile, quindi possiamo sostituire l'uno con l'altro e ottenere comunque un albero corretto.

- Sostituire continuamente il più piccolo con il più grande fornisce gli alberi per le stringe $u v^i x y^i z$ per ogni $i > 1$
- Sostituire il più grande con il più piccolo genera la stringa $u x z$.

Questo dimostra la condizione 1.

Per ottenere la condizione 2 dobbiamo essere certi che $v,y eq.not epsilon$. Se lo fossero, l'albero ottenuto sostituendo il più piccolo al più grande avrebbe meno nodi di $tau$ e genererebbe ancora $s$, questo però non è possibile perché abbiamo scelto $tau$ in modo che sia l'albero per $s$ con meno nodi.

Per ottenere la condizione 3 dobbiamo essere sicuri che la lunghezza di $v x y$ sia al più $p$. Nell'albero sintattico per $s$ l'occorrenza più in alto di $R$ genera $v x y$, abbiamo scelto $R$ in modo che entrambe le occorrenze di essa cadano nelle $|V|+1$ variabili più in basso del cammino e abbiamo scelto il più lungo cammino nell'albero sintattico, in modo che il sottoalbero in cui $R$ genera $v x y$ sia alto al più $|V|+1$. Ma un albero con questa altezza può generare una stringa di lunghezza al più $b^(|V|+1) = p$.

_Esempi_

Mostrare che $B={a^n b^n c^n | n gt.eq 0}$ non è context-free, dimostriamolo per assurdo quindi assumiamo che lo sia per poi arrivare ad una contraddizione.

Quindi sia $B$ un CFL e $p$ la lunghezza del pumping per $B$ scegliamo la stringa $s=a^p b^p c^p$, $s in B$ e $|s| gt.eq p$. Il lemma afferma che $s$ può essere iterata ma noi mostreremo che non è vero, ovvero non importa come diviamo $s$ in $u v x y z$ infatti violeremo sempre una delle tre condizioni del lemma.

Per prima cosa la condizione 2 stabilisce che $v$ o $y$ non sono vuote, consideriamo quindi i due casi dove le sottostringhe $v,y$ contengano più di un tipo di simbolo dell'alfabeto o no:
1. Quando entrambe contengono solo un tipo di simbolo allora $v$ non contiene entrambi i simboli $a,b$ o entrambi i simboli $b,c$ e lo stesso vale per $y$, questo significa che la stringa $u v^2 x y^2 z$ non può contenere lo stesso numero di $a,b,c$ e quindi non può essere un elemento di $B$. Abbiamo violato la condizione 1.

2. Quando $v$ o $y$ contengono più di un tipo di simbolo allora $u v^2 x y^2 z$ può contenere un ugual numero dei tre siboli ma non nell'ordine corretto. Non appartiene quindi a $B$.

Uno di questi due casi deve verificarsi e poichè entrambi portano ad un assurdo la contraddizione si verifica sempre. $B$ non è un CFL.