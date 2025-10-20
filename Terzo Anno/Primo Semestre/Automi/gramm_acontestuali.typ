#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= Grammatiche Acontestuali
Le grammatiche sono un mezzo di computazione utile in diverse applicazioni come ad esempio i compilatori, queste coincidono con un automa. 

_Ad esempio_ possiamo indicare come grammatica quella che genera le stringhe $0^n 1^n$ con $n gt.eq 0$

Una grammatica è una sequenza di *sostituzioni e produzioni*, facciamo un esempio di grammatica: $ A arrow.r 0 A 1 \ A arrow.r B \ B arrow.r \# $

Queste sono chiamate *regole della grammatica*; *A,B* sono *variabili* e *0,1,\#* sono detti *terminali*. In ogni grammatica c'è sempre una variabile speciale ovvero la *variabile iniziale*.

Per costruire delle stringhe si parte dalla variabile iniziale e si applicano le regole come vogliamo, usando l'esempio di prima possiamo costruire:

$ A arrow.r "0A1" arrow.r "00A11" arrow.r "000A111" arrow.r "000B111" arrow.r "000#111" $

Abbiamo applicato, in ordine, le regole *1, 1, 1, 2, 3*. Ad ogni produzione che effettuiamo possiamo associare un *albero sintattico*:

_TODO: IMMAGINE_

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
  title: [*Definizione - CFG (Context-free grammar)*],
  [
    Una CFG è una tupla $(V, Sigma, R, S)$ dove:
    - $V$ è l'insieme finito delle variabili
    - $Sigma$ è l'insieme finito dei terminali $(V inter Sigma = emptyset)$
    - $R$ è l'insieme di regole
    - $S in V$ è la variabile iniziale
  ]
)

Se $u,v,w in Sigma union V$ e $(A arrow.r w) in R$ allora $u A v$ produce $u w v$ e lo scriviamo come $u A v arrow.double.r u w v$

Diciamo inoltre che $u$ deriva $v$, con la notazione $u arrow.double.r^* v$ se:
- $u=v$
oppure
- $exists u_1,...,u_k$ con $k gt.eq 0$ t.c.: 
$ u arrow.double.r u_1 arrow.double.r u_2 arrow.double.r ... arrow.double.r u_k arrow.double.r v $

Quindi se esiste una sequenza di sostituzione che ci permettono di arrivare a $v$ partendo da $u$.

Questo ci permette di definire il linguaggio assocciato alla grammatica, ovvero: $ "Sia" G=(V,Sigma,R,S) "allora" L(G)={w in Sigma^* : S arrow.double.r ^* w} $

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
    Sia $G=(V={S}, Sigma={a,b}, R, S)$ e $R:S arrow.r "asb"|"ss"|epsilon$.

    Avremo che la stringa $"ab" in L(G)$, ottenuta tramite la sequenza:
    $ S arrow.double.r "asb" arrow.double.r "a"epsilon"b" arrow.double.r "ab" $

    Oppure anche la stringa $"aabb" in L(G)$, con la sequenza:
    $ S arrow.double.r "asb" arrow.double.r "aasbb" arrow.double.r "aa"epsilon"bb" = "aabb" $
  ]
)

Vedremo delle tecniche per costruire delle grammatiche:
- Unendo grammatiche
- Passando da un DFA ad una grammatica
- Sfruttando la ricorsione

== Unione di Grammatiche
Supponiamo di avere $G_i = (V_i, Sigma_i, R_i, S_i)$ tutte CFG tali che $forall i in [1,2,3,...,k]$ con $k in NN$, vogliamo costruire una grammatica $G=(V,Sigma,R,S)$ t.c. $L(G)= union_i L(G_i)$.

Lo facciamo costruendola in questo modo:
- $V= union_i V_i union {S}$, senza perdere generalità possiamo assumere che $V_i inter U_j = emptyset$ con $forall i,j in [1,2,3,...,k]$ t.c. $i eq.not j$
- $S$ è la nuova variabile iniziale
- $Sigma = union_j Sigma_i$
- $R=union_j R_i union {S arrow.r S_1 | ... | S_k}$

Dimostriamo che l'unione è anche essa una grammatica acontestuale, dobbiamo mostrare che $union_i L(G_i) = L(G)$ e quindi la doppia implicazione.

*Prima parte* - $union_i L(G_i) subset.eq L(G)$

Sia $w in union_i L(G_i):exists j in [k]$ t.c. $w in L(G_j)$ ovvero esiste una sostituzione $S_j arrow.double.r^*_G_j w$ ma allora per definizione $S arrow.double.r S_j arrow.double.r^*_G_j w$ ovvero $w in L(G)$

*Seconda parte* - $L(G) subset.eq union_i L(G_i)$

Sia $w in L(G)$ ovvero $S arrow.double.r^*_G w$, per definizione $exists j in [k]$ t.c. $S arrow.double.r S_j arrow.double.r^*_G w$, siccome $V_j$ è disgiunto da tutte le altre variabili abbiamo che $S_j arrow.double.r^*_G w$ implica che $w in L(G_j) union_i L(G_i)$

== Da DFA a CFG
Dato un DFA $D=(Q,Sigma,delta,q_0, F)$ voglio definire $G=(V,Sigma,R,S)$ t.c. $L(G)=L(D)$.

La costruiamo con:
- $Sigma$ rimane lo stesso
- $V={V_q : q in Q}$
- $S=V_q_0$
- Si aggiunge la regola $V_q arrow.r a V_p$ per ogni $p,q in Q, a in Sigma$ t.c. $delta(q,a)=p$ 
- $forall V_q in F$ aggiungo $V_q arrow.r epsilon$

Quindi creo una variabile della grammatica per ogni stato del DFA e i terminali sono le etichette tra uno stato e l'altro. _Esempio_:

#align(center,
  automaton(
    initial: "q0", final: none,
    (
      q0: (q1: "a"),
      q1: (q2: "b"),
      q2: (),
    ),
    layout: (q0: (0,0), q1: (2, 0), q2: (4,0)),
    style: (
      q2: (fill: green.lighten(60%))
    )
  )
)

Abbiamo quindi le regole: $ S=V_q_0 arrow.r a V_q_1; V_q_1 arrow.r b V_q_2 ; V_q_2 arrow.r epsilon $

La costruzione della stringa $a b$ è: $ S arrow.double.r a V_q_0 arrow.double.r a b V_q_1 arrow.double.r a b $

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
  title: [*Ricorsione*],
  [
    Per ricorsione nelle gremmatiche intendiamo regole del tipo: $ R arrow.r 0 R 1 $

    Regole di questo tipo sono utili per ricordare delle "informazioni limitate"
  ]
)

== Forma Normale di Chomsky
Una CFG è in forma normale se ogni regola è del tipo: $ A arrow.r B C \ A arrow.r a $ con ABC variabili ed $a$ terminale inoltre $B,C eq.not S$ ed è ammessa la regola $S arrow.r epsilon$.

*Teorema* - Ogni CFG ammette una CGF equivalente in forma normale.

*Dimostrazione*.

Seguiamo delle regole per passare da una qualsiasi CFG alla sua forma normale:
1. Se la variabile iniziale compare a destra di una regola aggiungiamo una nuova variabile iniziale $S_0$ insieme alla regola $S_0 arrow.r S$
2. Eliminare le $epsilon$-regole, se ad esempio abbiamo $A arrow.r epsilon$ dobbiamo andare a controllare tutte le regole dove la $A$ compare a destra e considerare che possiamo andare in $epsilon$ aggiungendo quindi una nuova regola.
3. Elimino le regole unitarie $A arrow.r B$, per ogni occorrenza $B arrow.r u$ aggiungo $A arrow.r u$ a meno che questa regola non è già stata eliminata.
4. Trasformare le regole restanti, se abbiamo $A arrow.r u_1 u_2 ... u_k$ con $k gt.eq 3$ spezziamo la regola in $ A arrow.r u_1 A_1 quad A_1 arrow.r u_2 A_2 ... A_(k-2) arrow.r u_(k-1) u_k $ Dove $A_i$ nuova variabile. Se $u_i$ è terminale allora lo sostituisco con $U_i$ e aggiungo la regola $U_i arrow.r u_i$

_Esempio_:

Consideriamo una grammatica con le regole:
- $S arrow.r A S A | a B$
- $A arrow.r B | S$
- $B arrow.r b | epsilon$

Usiamo le regole per passare in formale normale:
1. Aggiungiamo la variabile $S_0$ e la regola $S_0 arrow.r S$
2. Eliminiamo le $epsilon$-regole, la prima è $B arrow.r epsilon$ questo significa che una volta rimossa dobbiamo considerare che in ogni regola dove $B$ sta a destra possiamo andare anche in $epsilon$, otteniamo quindi:
- $S_0 arrow.r S$
- $S arrow.r A S A | a B$
- $A arrow.r B | S | epsilon$
- $B arrow.r b$
Adesso eliminiamo $A arrow.r epsilon$ e andiamo a controllare quelle dove la $A$ compare a destra, otteniamo:
- $S_0 arrow.r S$
- $S arrow.r A S A | a B | S A | A S | S$
- $A arrow.r B | S$
- $B arrow.r b$
3. Eliminiamo le regole unitarie, partiamo da $S arrow.r S, S_0 arrow.r S$, ovvero sostituiamo la variabile a destra con la regola rimossa, otteniamo:
- $S_0 arrow.r A S A | a B | S A | A S$
- $S arrow.r A S A | a B | S A | A S$
- $A arrow.r B | S$
- $B arrow.r b$
Vanno rimosse anche $A arrow.r B, A arrow.r S$:
- $S_0 arrow.r A S A | a B | S A | A S$
- $S arrow.r A S A | a B | S A | A S$
- $A arrow.r b | A S A | a B | S A | A S$
- $B arrow.r b$
4. Finiamo le sostituzioni rimuovendo le regole che hanno a destra 3 o più variabili e quelle che hanno terminali e variabili insieme, in questo caso non vanno bene le regole che ci portano nella stringa _ASA_ e in $a B$, creiamo quindi una variabile $A_1$ che ci porta in _SA_ e sostituiamo questa variabile nelle regole, per le regole che ci portano in $a B$ creiamo la variabile $U$:
- $S_0 arrow.r A A_1 | U B | S A | A S$
- $S arrow.r A A_1 | U B | S A | A S$
- $A arrow.r b | A A_1 | U B | S A | A S$
- $B arrow.r b$
- $U arrow.r a$
- $A_1 arrow.r S A$

La grammatica è adesso in forma normale di Chomsky.