#import "@preview/showybox:2.0.4": showybox
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#show raw: set block(fill: none)
#show raw.where(block: false): set box(fill: none)

= Calcolabilità (DEVO ANCORA STUDIARLA BENE QUINDI LI SISTEMERÓ)
Iniziamo introducendo il concetto di *Macchina di Turing*, queste corrispondono al modello astratto di computer, tuttio ciò che è calcolabile per un computer lo è anche per una TM.

Una Turing Machine possiede un nastro infinito e una testina con la quale può leggere e scrivere sul nastro. Inizializziamo il nastro scrivendoci sopra la stringa di input, i restanti slot sono riempiti con il carattere _blank_ $union.sq$. I movimenti possibili per la testina sono _dx, sx, lettura, scrittura_ e continua a computare fino al raggiungimento lo stato di accettazione o rifiuto, se non raggiunge nessuno dei due allora va in loop.

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
    Costruiamo una TM per il linguaggio $ {w\#w:w in {0,1}^*} $
    La TM si muove a zig-zag tra i simboli a dx e sx di $\#$ e controlla se il simbolo a sx combacia con quello a dx, se si li cancella. Se trova un confronto non valido rifiuta altrimenti se sovrascrive tutti i simboli accetta.
  ]
)

Diamo adesso la definizione formale di TM.

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
  title: [*Definizione* - Turing Machine],
  [
    Una TM è una tupla $M=(Q,Sigma,Gamma,delta,q_"start",q_"acc",q_"rej")$ dove:
    - $Q$ è l'insieme finito degli stati
    - $Sigma$ è l'insieme finito di input $union.sq in.not Sigma$
    - $Gamma$ è l'alfabeto del nastro $(union.sq in Gamma, Sigma subset.eq Gamma$
    - $q_"acc"$ è lo stato di accettazione
    - $q_"rej" eq.not q_"acc"$ è lo stato di rifiuto
    - $delta: Q times Gamma arrow.r Q times Gamma times {L,R}$ definita come,
      se $delta(p,a)=(q,b,X)$ allora:
        - $a$ viene letto dal nastro e sostituito da $b$
        - la macchina passa dallo stato $p$ allo stato $q$
        - Il nastro viene spostato a sx se $X=L$ e a dx se $X=R$
        La transizione avrà quindi come etichetta $a arrow.r b; X$
    Inoltre le transizione in realtà avvengono da $Q \\ {q_"acc", q_"rej"}$ dato che se la TM va in uno dei due termina subito.
  ]
)

Vediamo quindi adesso il concetto di *configurazione*. La configurazione di una TM si rappresenta in questo modo: $ u q v $ Dove:
- La posizione della testina è il primo simbolo di $v$
- $q$ è lo stato corrente
- $u$ è il restante contenuto del nastro precedente

Quindi ad esempio, una configurazione potrebbe essere: $ 1011 q_7 01111 $, inoltre la configurazione iniziale è $q_"start" w$ e quella finale $q in {q_"acc", q_"rej"}$.

Possiamo quindi dire che:
- $u a q_i b v tack.r u q_j a c v arrow.double.r.l delta(q_i, b)=(q_j, c, L)$
- $u a q_i b v tack.r u a c q_j v arrow.double.r.l delta(q_i, b)=(q_j, c, R)$

Diciamo che $M$ *accetta* $w in Sigma^* arrow.double.r.l c_"start"=q_"start" w "è t.c." c_"start" op(tack.r)^* c_"acc"$ dove $c_"acc"$ è la configurazione di accettazione.

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
  title: [*Definizione* - Linguaggi Turing Riconoscibili],
  [
    Un linguaggio $L$ è Turing-Riconoscibile se $exists "TM M"$ che lo riconosce, ovvero se $forall w in L, M$ accetta $w$.
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
  title: [*Definizione* - Decisore],
  [
    Una TM è detta *decisore* se termina sempre, ovvero non va in loop.
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
  title: [*Definizione* - Decidibilità],
  [
    Un linguaggio $L$ è Turing-Decidibile se $exists M$ decisore t.c. $L = L(M)$
  ]
)

Esistono delle varianti di TM che mantengono lo stesso potere espressivo:
- Nastro infinito a 2 direzioni
- TM che muovono a R, L, S - "stay-put". Infatti basta che ad ogni transizione fanno prima uno spostamento a sinistra e poi a destra.
- TM con $k$ nastri
- TM non deterministiche

== TM Multinastro
Formalmente abbiamo che $delta: Q times Gamma^k arrow.r Q times Gamma^k times {L,R,S}^k$ con $k = \# "nastri"$, abbiamo quindi $ delta(q_i, a_1, ..., a_k) = (q_j, b_1, b_k, L, R, ..., L) $
Se la macchina è nello stato $q_i$ e le $k$ testine leggono i simboli $a_1,...,a_k$ la macchina va nello stato $q_j$, scrive i simboli $b_1,...,b_k$ e ogni testina si muove come specificato.

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
    Ogni TM multinastro ha una TM singolo-nastro equivalente.
  ]
)

*Dimostrazione* - $S$ simula $M$ mettendo il suo contenuto in un singolo nastro in questo modo:
- Scrive sequenzialmente i contenuti dei $k$ nastri con $"\#"$ come delimitatore
- Per tenere traccia di dove si trovano le testine, introduce un simbolo $°$ sopra al carattere corrispondente, le chiamiamo "testine virtuali".

#align(center, image("/assets/image-91.png"))

Quindi $S$ su input $w = w_1, ..., w_n$ si comporta così:
1. Pone il nastro nella configurazione "iniziale" $\# w_1^° w_2 ... w_n \# union.sq^° \# ... \#$
2. S scansiona il nastro dal primo all'ultimo $\#$, per capire quali siano i simboli puntati dalle testine virtuali. Poi fa una seconda scansione per aggiornare il nastro secondo $delta'$ di $M$.
3. Se in qualsiasi momento una testina finisce su un $\#$ significa che ha raggiunto un $'union.sq'$ e quindi vi scrive $'union.sq'$ e sposta di una posizione a destra l'intero contenuto del nastro.

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
    Un linguaggio è Turing-Riconoscibile $arrow.double.r.l$ una TM multinastro lo riconosce.
  ]
)

*Dimostrazione* - Dato che la singolo-nastro è una caso speciale di multinastro e che ogni multinastro ha una singolo-nastro equivalente la dimostrazione è completa.

== TM non Deterministica
Formalmente abbiamo che: $ delta: Q times Gamma arrow.r cal(P)(Q times Gamma times {L,R}) $
Il concetto di non determinismo è uguale a quelllo che troviamo negli NFA. Semplicemente in questo caso quando la TM deve fare una mossa potrebbe avere più azioni possibili da svolgere e come per gli NFA, creiamo più percorsi indipendenti.

Simuliamo una NTM $N$ con una TM $D$, per farlo consideriamo l'albero di computazione di $N$ che esploriamo con una BFS. Non effettuiamo la ricerca con una DFS perché dato che vogliamo simulare il parallelismo se eseguissimo una DFS questa potrebbe continuare all'infinito su un ramo.

L'albero ha questa struttura:
- La radice è $epsilon$
- Ogni altro nodo ha un indirizzo $in Gamma_b={1,...,b}$ con $b$ il massimo numero di scelte tra tutti gli stati di $N$, nello specifico l'indirizzo è formato da $x y$ con $x$ indirizzo del padre e $y in Gamma_b$ "numero" del figlio, quindi ad esempio $231$ indica il secondo figlio della radice -> il suo terzo figlio -> il suo primo figlio.

La TM $D$ che simula $N$ è una multi-nastro con 3 nastri:
1. Il nastro 1 contiene l'input $w$ e non viene mai alterato. Ci serve come riferimento per quando cambiamo ramificazione.
2. Il nastro 2 simula un ramo della computazione di $N$, quando ha più scelte effettua quella presente in 3.
3. Il nastro 3 contiene l'indirizzo del nodo fino a cui simulare, quindi conterrà ad esempio "1", "2", "3" poi passa ai figli del primo nodo quindi "11", "12", "13" e poi a quelli del primo nodo ancora "111", "112"...

La TM D si comporta quindi in questo modo:
1. Inizialmente il nastro 1 contiene $w$ e gli altri 2 sono vuoti.
2. Copia il nastro 1 sul nastro 2
3. Usa il nastro 2 per simulare $N$ con input $w$. Ad ogni step $N$ consula il prossimo simbolo sul nastro 3
  - Se il nastro 3 è vuoto va allo step 4
  - Se la simulazione rifiuta va allo step 4
  - Se la simulazione accetta, accetta
4. Sostituisce la stringa sul nastro 3 con la successiva in ordine lessicografico. Va al passo 2.

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
    Una TM non deterministica può essere una TM che su input binario:
    - input 0:
      - Si muove a dx
      - Si muove a sx
    - input 1: accetta
    Quindi quando legge uno 0 crea due rami, se simuliamo questa TM non deterministica con una deterministica avremo che eseguirà entrambe le scelte prima o poi.
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
  title: [*Tesi di Church-Turing*],
  [
    Qualunque problema calcolabile da un algoritmo può essere risolto da una macchina di Turing.
  ]
)

== Linguaggi Decidibili
Sono quei linguaggi per i quali esiste una TM che per ogni stringa termina sempre in un tempo finito e stabilisce se questa appartiene o no al linguaggio.

*Problema dell'accettazione per i DFA* - Definiamo $ A_"DFA"={<B,w> | B "è un DFA che accetta" w} $
E presentiamo una TM che accetta $A_"DFA"$:

M = "Su input $<B,w>$, con $B$ DFA e $w$ stringa:
- Simula $B$ su input $w$
- Se la simulazione finisce con uno stato di accettazione, accetta; altrimenti rifiuta."

*Problema dell'accettazione per gli NFA* - Definiamo $ A_"NFA"={<B,w> | B "è un NFA che accetta" w} $
E presentiamo una TM che accetta $A_"NFA"$:

N = "Su input $<B,w>$, con $B$ NFA e $w$ stringa:
- Converti $B$ in un DFA $C$
- Esegui la TM 'M' (per $A_"DFA"$) su C
-Se M accetta, accetta; altrimenti rifiuta."

*Determinare se una regex genera una stringa* - Definiamo $ A_"REX" = {<R,w> | R "regex che genera" w} $

E costruiamo una TM che accetta $A_"REX"$:

P = "Su input $<R,w>$ con $R$ regex e $w$ stringa:
- Converti $R$ in NFA $A$
- Esegui la TM $N$ (per $A_"NFA"$ su A)
- Se $N$ accetta, accetta; altrimenti rifiuta"

*Emptiness-testing per i DFA* - Definiamo $ E_"DFA" = {<A> | A "DFA e " L(A) = emptyset} $

E costruiamo una TM che accetta $E_"DFA"$:

T = "Su input $<A>$ con $A$ DFA:
- Marca lo stato iniziale
- Finchè non vengono marcati nuovi stati, marca ogni stato che ha una transizione entrante da uno stato già marcato.
- Se almeno uno stato accettante è stato marcato, rifiuta; altrimenti accetta."

*Determinare se due DFA accettano lo stesso linguaggio* - Definiamo $ E Q_"DFA" = {<A,B> | A "e" B "DFA e" L(A) = L(B)} $

Utilizziamo la differenza simmetrica: $ L(C)=L(A) triangle.stroked L(B) $, se è vuota abbiamo che $L(A) = L(B)$.
Si ha $ L(C) = (L(A) inter overline(L(B))) union (overline(L(A)) inter L(B)) $ Dobbiamo verificare se $<C> in E_"DFA"$, costruiamo

F = "Dato un input:
- Costruisci il DFA $C$ come descritto
- Simula la TM T (per $E_"DFA"$)
- Se T accetta, accetta; altrimenti rifiuta"

*Determinare se una CFG genera una stringa* - Definiamo $ A_"CFG" = {<G,w> | G "CFG genera" w} $
Costruiamo la TM

M = "Su input $<G,w>$ con G CFG e w stringa:
- Converti G in CNF (Chomsky)
- Enumera le derivazioni con $2n-1$ passi dove $n=|w|$, se $n=0$ enumera solo quelle con 1 passo. Da questa possiamo ricavare il successivo _claim_
- Se una delle derivazioni genera $w$, accetta; altrimenti rifiuta."

*Claim* - Sia $G=(V,Sigma,R,S)$ una CFG in CNF. Data $w in G$ con $|w|=n$, la sua derivazione è di $2n-1$ passi.

*Dimostrazione* - Dimostriamolo per induzione su $n$.
- Caso Base: $n=1$ allora $|w|=1$ significa che $w in Sigma$. Quindi $w$ è derivata con la regola $S arrow.r w$ in $1=2 dot 1 -1$ passi.
- Passo Induttivo: Assumiamo sia vero per stringhe di lunghezza $lt.eq n-1$. Sia $w in G$ t.c. $|w|=n$.\ Visto che G è in CNF, $S arrow.double.r^* w$ implica che $S arrow.r A B arrow.double.r^* w$. Quindi possiamo scrivere $w = x y$ con $A arrow.double.r^* x$ e $B arrow.double.r^* y$. Visto che non ci sono $epsilon$-regole in CNF abbiamo che $x,y eq.not epsilon$. Quindi siano $|x|=k$ e $|y|=n-k$, per ipotesi induttiva $x,y$ sono derivabili in $2k-1$ e $2(n-k)-1=2n-2k-1$ produzioni. Quindi $A B arrow.double.r^* w$ ha $2k-1+2n-2k-1=2n-2$ produzioni, aggiungendo $S arrow.r A B$ otteniamo che $S arrow.double.r^* w$ in $2n-1$ produzioni.

*Emptiness-testing per CFG* - Definiamo $ E_"CFG"={<G> | G "CFG e" L(G) = emptyset} $

Costruiamo la TM

M = "Su input G, dove G è una CFG:
- Marca tutti i terminali in $Sigma$
- Finchè non vengono marcate nuove variabili:
  - Marca ogni $A in V$ per cui $exists A arrow.r U_1 U_2 ... U_l in R$ dove ogni $U_i$ è già stato marcato
- Se S è marcata, rifiuta; altrimenti accetta".

Otteniamo quindi questa situazione per i linguaggi:
#align(center, image("/assets/image-92.png", width: 50%))

Esistono però linguaggi non TURING-DEC / RIC, introduciamo quindi il problema $A_"TM"$ che determina se una TM accetta un determinato input. $ A_"TM" = {<M,w> | M "TM e" w in L(M)} $

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
  title: [*Definizione* - Turing Machine Universale],
  [
    Una TM universale è una TM in grado di simulare ogni altra TM. Si dice infatti che un modello di calcolo è Turing-complete se è equivalente ad una TM universale.

    Una qualsiasi TM M può essere completamente descritta da un insieme finito di transizioni, e quindi può essere codificata come una stringa finita di simboli. Una TM universale prende in input la descrizione codificata della TM da simulare $<M>$ e l'input $w$ su cui dovrebbe lavorare e simula $M$.
  ]
)

Notiamo che $A_"TM"$ è _T-REC_, infatti abbiamo la TM U che lo riconosce:

U = "Su input $<M,w>$ con M TM e w stringa:
- Simula M su w
- Se M raggiunge uno stato accettante, accetta; altrimenti rifiuta"

Con questa costruzione se M va in loop ci andrà anche U.

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
    $A_"TM"$ non è decidibile.
  ]
)

Ma per dimostrarlo abbiamo prima bisogno di un altro teorema.

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
    Esistono linguaggi non Turing-riconoscibili.
  ]
)

*Dimostrazione* - Notiamo che l'insieme di tutte le TM $cal(M)$ non è numerabile in quanto l'insieme di tutte le stringhe $Sigma^*$ su un alfabeto $Sigma$ è numerabile, queste rappresentano gli encoding di ogni TM in stringe $<M>$.

Notiamo anche che l'insieme delle stringhe binarie infinite $cal(B)$ non è numerabile. Adesso consideriamo $cal(L)=cal(P)(Sigma^*)$ l'insieme di tutti i linguaggi definiti su $Sigma$. Mostriamolo fornendo una corrispondenza biunivoca con $cal(B)$, quindi ogni linguaggio $A in cal(L)$ corrisponde ad una sequenza univoca in $cal(B)$.

Definiamo il concetto *Sequenza Caratteristica* di $A$, ovvero una sequenza binaria definita come segue: $ cal(X)_A = b_1 b_2 ... "t.c." b_i = cases(1 space s_i in A, 0 space s_i in.not A) $

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
    Prendiamo il linguaggio A = "Stringhe binarie che iniziano con 0":
    - $Sigma^* = {epsilon,0,1,00,01,10,11,...}$
    - $A = {space, 0, space, 00, 01, space, space, ...}$
    - $cal(X)_A = 0101100...$
  ]
)

Notiamo che $f:cal(L)arrow.r cal(B):A arrow.r cal(X)_A$ è biunivoca, perciò visto che $cal(B)$ non è numerabile non lo è neanche $cal(L)$. Ovvero $exists A in cal(L) "t.c." exists.not M "TM t.c." L(M)=A$.

Quindi la funzione $h:cal(M) arrow.r cal(L):M arrow.r L(M)$ non è biiettiva, quindi $exists L in cal(L) "t.c." exists.not M "per cui" L(M)=L$.

Adesso possiamo tornare a dimostrare che $A_"TM"$ non è decidibile.

*Dimostrazione* - Supponiamo per assurdo che $A_"TM" in "DEC"$ e sia $H$ un decisore per $A_"TM"$: $ H(<M,w>)=cases("accept" space "se" M "accetta" w, "reject" space "se" M "non accetta" w) $

Adesso costruiamo una TM

$D$ = "Su input $<M>$ con M TM:
1. Esegui H con input $<M, <M>>$
2. Dai in output l'opposto dell'output di H"

$ D(<M>) = cases("accetta" space "se M non accetta <M>", "rifiuta" space "se M accetta <M>") $

Ma adesso cosa succede se eseguiamo $D$ con la sua stessa descrizione $<D>$ in input?

$ D(<D>) = cases("accetta" space "se D non accetta <D>", "rifiuta" space "se D accetta <D>") $ Ma abbiamo ottenuto una contraddizione, se $D$ accetta $<D>$ allora $D$ deve rifiutare $<D>$ e viceversa.

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
  title: [*Definizione* - Coturing-Riconoscibile],
  [
    Un linguaggio si dicec _Co-Turing-Riconoscibile_ se è il complemento di un linguaggio _Turing-Riconoscibile_
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
    Un linguaggio $L$ è decidibile $arrow.double.r.l$ $L in "REC"$ e $L in "CO-REC"$
  ]
)

*Dimostrazione*
- $arrow.double.r$ se $L$ è decidibile, $overline(L)$ è decidibile quindi $L$ e $overline(L)$ sono _Turing-Riconoscibili_.
- $arrow.double.l$ sia $M_1$ un riconoscitore per $A$ e $M_2$ un riconoscitore per $overline(A)$

Costruiamo M = "Su input $w$:
1. Esegui $M_1$ e $M_2$ in parallelo su $w$
2. Se $M_1$ accetta, accetta; se $M_2$ accetta, rifiuta"

Ogni stringa $w$ è in $A$ oppure in $overline(A)$, quindi uno tra $M_1$ e $M_2$ deve accettare. Visto che $M$ si ferma se $M_1$ o $M_2$ accettano, termina sempre e quindi è un decisore.
Inoltre, accetta le stringhe in $A$ e rifiuta quelle in $overline(A)$ quindi è un decisore per $A$.

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
  title: [*Corollario 1*],
  [
    Se $L$ non è decidibile allora almeno uno tra $L$ e $overline(L)$ non è _Turing-Riconoscibile_.
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
  title: [*Corollario 2*],
  [
    $overline(A_"TM")$ non è _Turing-Riconoscibile_.
  ]
)

== Riducibilità
Vediamo una tecnica per dimostrare che alcuni problemi non sono decidibili o riconoscibili. Una *riduzione* è un modo di convertire un problema in un altro problema in modo che una soluzione per il secondo problema possa essere usata per il primo. _(Ci serve aumentare il modello delle TM aggiungendo un nastro di output WLOG)_

Diremo che una TM calcola una funzione su un dato input se inizia con $w$ sul nastro di input e termina con $f(w)$ sul nastro di output.

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
  title: [*Definizione* - Calcolabilità],
  [
    Una funzione $f:Sigma^* arrow.r Sigma^*$ è calcolabile se $exists$TM M che calcola $f$ $forall w in Sigma^*$
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
  title: [*Definizione* - Mapping Reductions],
  [
    $A$ é riducibile tramite funzione a $B$, lo indichiamo con $A op(lt.eq)_m B$, se $exists f: Sigma^* arrow.r Sigma^*$ calcolabile t.c. $forall w in Sigma^*$ si ha che $w in A arrow.r.l.double f(w) in B$
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
    Se $A op(lt.eq)_m$ e $B$ decidibile allora $A$ decidibile.
  ] 
)

*Dimostrazione* - Sia $M in "TM"$ che decide $B$ e sia $F in "TM"$ che calcola la mapping reduction da $A$ a $B$. Costruiamo un decisore $M'$ per $A$ in questo modo:
- Su input $w$ calcola $f(w)$ usando $F$
- Lanca $M$ su $f(w)$ e accetta _se e solo se_ $M$ accetta.

$M'$ é un decisore perché $M$ lo é. Inoltre, $M'(w)="acc" arrow.double.r.l M(f(w))="acc" arrow.double.r.l f(w) in B arrow.double.r.l w in A$

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
    Se $A op(lt.eq)_m$ é indecidibile allora $B$ é indecidibile
  ] 
)

*Dimostrazione* - Se $B$ fosse decidibile allora $A$ sarebbe decidibile per il teorema.

== Halting Problem
Serve a determinare se una TM termina.

$ "HALT"_"TM" = {<M,w> | M "TM e" M "termina su input" w} $

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
    $"HALT"_"TM"$ é indecidibile.
  ] 
)

*Dimostrazione* - Assumiamo che esista una TM $R$ che decide $"HALT"_"TM"$. Usiamo $R$ per costruire $S$ decisore per $A_"TM"$.

Supponiamo quindi che $exists "TM" R$ che decide $"HALT"_"TM"$. Costruiamo $S$ decisore per $A_"TM"$:

S = Su input $<M,w>$ con $M$ encoding di una TM e $w$ stringa:
1. Esegui $R$ su $<M,w>$
2. Se $R$ rifiuta, rifiuta
3. Se $R$ accetta, simula $M$ su $w$ fino alla sua terminazione
  - Se $M$ accetta, accetta; altrimenti rifiuta.

== Altri linguaggi non decidibili
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
    $ E_"TM" = {<M> | M in "TM" and L(M) = emptyset} in.not "DEC" $
  ] 
)

*Dimostrazione* - Supponiamo per assurdo che sia decidibile. Sia quindi $R$ un decisore, costruiamo un decisore $S$ che usi $R$ come subroutine.

Dobbiamo fare in modo che $S$ costruisca una nuova TM $M'$ t.c.:
1. $L(M')$ é vuoto $arrow.double.r.l M$ non accetta $w$.
2. $L(M')$ é non vuoto $arrow.double.r.l M$ accetta $w$.

Abbiamo quindi $M'$: Su input $x$:
1. Se $x eq.not w$ rifiuta
2. Se $x = w$, esegui $M$ su input $x$ e se $M$ accetta, accetta; altrimenti rifiuta.

Quinsi $S$ decisore di $A_"TM"$ = "data $<M,w>$ in input:
1. Costruisci $M'$
2. Esegui $R$ con input $M'$
3. Se $R$ accetta, rifiuta; altrimenti accetta"

Se $R$ fosse un decisore di $E_"TM"$, $S$ sarebbe un decisore di $A_"TM"$ (assurdo).

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
    $"REG"_"TM" = {<M> | M "TM" and L(M) in "REG"} in.not "DEC"$
  ]
)

*Dimostrazione* - Facciamo una reduction $A_"TM" op(lt.eq)_m "REG"_"TM"$. La funzione $f(<M,w>)$ restituisce $M'$ t.c. su input $x$:
1. Se $x in {0^n 1^n | n in NN}$ accetta
2. Se $x in.not {0^n 1^n | n in NN}$ simula $M$ su $w$ e accetta $arrow.double.r.l$ $M(w)="ACC"$

#showybox(
  frame: (
    border-color: gray.lighten(60%),
    title-color: gray.lighten(60%),
    body-color: gray.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Nota*],
  [
    $L(M')$ è:
    - $Sigma^* ("REG")$ se M accetta $w$ (Se $M$ accetta $w$ allora $M'$ accetta indipendentemente da $x$
    - {0^n 1^n} se $M$ non accetta $w$ (Se $M$ non accetta $w$, $M'$ accetta solo se $x in {0^n 1^n}$) quindi $<M,w> in A_"TM" arrow.double.r.l <M'> in "REG"$
  ]
)

Adesso abbiamo che
$ <M,w> in A_"TM" arrow.double.r.l f(<M,w>) in "REG"_"TM" $

Dimostriamolo:
- $arrow.double.r$ Sia $<M,w> in A_"TM"$ allora $M(w)="ACC"$ quindi $<M'> in "REG"_"TM"$
- $arrow.double.l$ Se $<M,w> in.not A_"TM"$ allora $M(w)="REJ"$ o LOOP. Allora $L(M')={0^n 1^n | n gt.eq 0}$ pertanto $<M'> in.not "REG"_"TM"$

== I Teoremi di Gödel
Introduciamo il concetto di *sistema di prova*

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
  title: [*Definizione* - Sistema di Prova],
  [
    Un sistema di prova $Pi$ è tale che:
    - Per ogni affermazione vera o falsa esiste una sua rappresentazione come stringa $<x>$ finita.
    - Per ogni dimostrazione esiste una rappresentazione come stringa $<Pi>$ finita
    - Esiste TM $V$ decisore tale che $forall(<x,w>) in Sigma^*$ si ha $<x,w> in L(V) arrow.double.r.l w "è una dimostrazione per" x$ in $Pi$
  ]
)

Un'affermazione $<x>$ è detta *dimostrabile* se $exists <w> in Sigma^*$ tale che $<w,x> in L(V)$.

Si dice invece, *indipendente* se né $x$ né $not x$ sono dimostrabili in $Pi$.

$Pi$ deve essere *computabile* ovvero $forall A "assioma"$ in $Pi$, $A in "DEC"$

Infine un sistema di prova $Pi$ è detto:
- *Consistente*: Se per ogni affermazione $<x>$ al piú uno tra $x$ e $not x$ è dimostrabile.
- *Valido*: Se ogni affermazione dimostrabile è vera.
- *Completo*: Se $forall <x>$ almeno uno tra $x$ e $not x$ è dimostrabile
- *Incompleto*: Se esiste un'affermazione indipendente.

#showybox(
  frame: (
    border-color: gray.lighten(60%),
    title-color: gray.lighten(60%),
    body-color: gray.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Osservazioni*],
  [
    - Valido $arrow.double.r$ consistente
    - $Pi$ consistente e completo $arrow.double.r$ Per ogni $x$ solo uno tra $x$ e $not x$ è dimostrabile
    - $Pi$ valido e completo $arrow.double.r$ Per ogni $x$ solo uno tra $x$ e $not x$ è dimostrabile e quindi vero
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
    Sia $Pi$ un sistema di dimostrazione abbastanza potente da comprendere l'aritmetica allora $Pi$ non puó essere sia valido che completo.
  ]
)

*Dimostrazione* - Sia $L={<x> | x "è dimostrabile in" Pi}$ definiamo la TM $R_Pi$ che prova a decidere $L$:

$R_Pi$ = Data la stringa $<x>$ in input:
- $forall k = 1,2,3,...$:
  - $forall w in Sigma^*$ con $|w|=k$:
    - Se $V(<x,w>)="ACC"$ allora $R_Pi$ accetta
    - Se $V(<not x, w>)="ACC"$ allora $R_Pi$ rifiuta

Ora supponiamo per assurdo $Pi$ valido e completo. Allora una tra $x$ e $not x$ deve essere vera, allora abbiamo che:
- $x$ è vera $arrow.double.r.l exists "dim" w "t.c." V_Pi (<x,w>)="ACC"$ quindi $<x> in L(R_Pi)$
- $not x$ è vera $arrow.double.r.l exists "dim" w "t.c." V_Pi (<not x, w>)="ACC"$

Quindi $R_Pi$ è un decisore e $L(R_Pi)={<x> | x "vera"}$

Data una TM $M$ e un input $y in Sigma^*$ consideriamo la seguente affermazione: $ phi_(M,y)=M(y) "termina" $

Definiamo la TM $D(<M,y>)=R_Pi(<phi_M>)$

Visto che $P_Pi$ è un decisore anche $D$ lo è. Tuttavia $L(D) = "HALT"_"TM"$ che sappiamo essere non decidibile. Otteniamo una contraddizione infatti $Pi$ non può essere sia valido che completo. 

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
  title: [*Lemma*],
  [
    Sia $Pi$ un sistema di dimostrazione abbastanza potente da comprendere l'aritmetica. Sia $M$ una TM e $x in Sigma^*$ un input.

    Se $M(x)$ ha una traccia di esecuzione il cui comportamento è noto allora esiste una dimostrazione in $Pi$ che la descrive.
  ]
)

=== Primo Teorema di Incompletezza
Sia $Pi$ un sistema di dimostrazione abbastanza potente da comprendere l'aritmetica. Se $Pi$ è consistente allora $Pi$ non è completo.

*Dimostrazione* - L'idea è che se $Pi$ è abbastanza potente da comprendere l'aritmetica allora può descrivere il funzionamento di una TM.

Consideriamo l'affermazione $phi_M=M(<M>)"termina"$

Definiamo la TM $R_Pi$ che data la stringa $<x>$ in input:
- $forall k = 1,2,3,...$
  - $forall w in Sigma^*$ t.c. $|w|=k$
    - Se $V(<phi_R_Pi,w>)="ACC"$ allora $R_Pi$ va in loop. Significa che $w$ è la dimostrazione di $phi_R_Pi$ quindi "termina" è dimostrabile e la TM va in loop
    - Se $V(<not phi_R_Pi,w>)="ACC"$ allora $R_Pi$ termina. Significa che "non termina" è dimostrabile e la TM termina.

*Claim* - Se $phi_R_Pi$ o $not phi_R_Pi$ è dimostrabile allora $Pi$ è inconsistente.

*Dimostrazione Claim* - Supponiamo che $not phi_R_Pi$ sia dimostrabile. Allora esiste una dimostrazione $w$ t.c. $V(<not phi_R_Pi, w>)="ACC"$ ovvero $R_Pi(<R_Pi>)$ termina. Poichè l'esecuzione termina il comportamento della traccia è noto quindi esiste una dimostrazione che descrive la traccia di esecuzione di $R_Pi$ che è anche una dimostrazione per $phi_R_Pi$. Ha infatti dimostrato che $R_Pi(<R_Pi>)$ termina ovvero $phi_R_Pi$.

Supponiamo adesso che $phi_R_Pi$ sia dimostrabile. Allora esiste una dimostrazione $w$ t.c. $V_Pi(phi_R_Pi,w)$ accetti, ovvero $R_Pi(<R_Pi>)$ va in loop volontariamente. Poichè va in loop volontariamente il comportamento della traccia è noto e dunque esiste una dimostrazione che descrive la traccia di esecuzione di $R_Pi$, ovvero $R_Pi(<R_Pi>)$ non termina che sarebbe $not phi_R_Pi$, che è anche una dimostrazione per $not phi_R_Pi$.

Quindi, dato che $phi_R_Pi$ dimostrabile implica che lo sia anche $not phi_R_Pi$ e viceversa, $Pi$ è inconsistente.

*Fine dimostrazione teorema* - Adesso tornando al teorema, supponiamo $Pi$ consistente, ma dobbiamo necessariamente avere per il claim né $phi_R_Pi$ né $not phi_R_Pi$ dimostrabili, ovvero $Pi$ incompleto.

=== Secondo Teorema di Incompletezza
Sia $Pi$ un sistema di dimostrazione abbastanza potente da comprendere l'aritmetica. Se $Pi$ è consistente esso non può dimostrare l'affermazione "$Pi$ è consistente".

*Dimostrazione*

- Sia $R_Pi$ la TM definita tramite $phi_Pi$ come per il teorema precedente
- Valga lo stesso claim del teorema precedente e la sua dimostrazione
- Assumiamo $Pi$ consistente, quindi né $phi_R_Pi$ né $not phi_R_Pi$ dimostrabili in $Pi$.

Supponiamo per assurod che "$Pi$ è consistente" sia dimostrabile tramite $w in Sigma^*$. Unendo $w$ alla dimostrazione del claim, otteniamo una dimostrazione per l'affermazione "né $phi_R_Pi$ né $not phi_R_Pi$ dimostrabili in $Pi$".

Per costruzione di $R_Pi$ questa corrisponde ad una dimostrazione per $not phi_R_Pi$ in quanto implica che si sappia per certo che la TM va in loop. Questa è una contraddizione.

Quindi, "$Pi$ non è consistente" non è dimostrabile in $Pi$.