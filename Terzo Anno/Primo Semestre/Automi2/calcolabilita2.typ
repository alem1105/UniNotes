#import "@preview/showybox:2.0.4": showybox
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#show raw: set block(fill: none)
#show raw.where(block: false): set box(fill: none)

= Calcolabilità
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