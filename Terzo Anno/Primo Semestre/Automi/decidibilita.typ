#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= Decidibilità
Vediamo esempi di problemi relativi ad automi finiti.

Definiamo:

$ A_"DFA" = {<B,w> | B "è un DFA che accetta la stringa di input" w} $

Questo linguaggio contiene tutte le codifiche di tutti i DFA con le stringhe che essi accettano. Il problema di verificare se un DFA $B$ accetta l'input $w$ coincide con il problema di verificare se $<B,w>$ è un elemento del linguaggio $A_"DFA"$, mostrare che il linguaggio è decidibile equivale a mostrare che il problema computazione è decidibile.

Con il seguente teorema mostriamo che $A_"DFA"$ è decidibile quindi stiamo anche mostrando che il problema di verificare se un dato automa finito accetta una determinata stringa è decidibile.

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
    $A_"DFA"$ è un linguaggio decidibile.
  ]
)

Per dimostrarlo abbiamo bisogno di una TM $M$ che decide $A_"DFA"$:

- $M$ = "Su input $<B,w>$ dove $B$ è un DFA e $w$ è una stringa":
  1. Simula $B$ su input $w$.
  2. Se la simulazione termina in uno stato di accettazione, accetta altrimenti rifiuta.

La dimostrazione è semplicemente una simulazione di $B$ su input $w$, se $B$ termina in uno stato di accettazione allor $M$ accetta altrimenti rifiuta.

Possiamo dimostrare un teorema simile anche per automi a stati finiti non deterministici:

$ A_"NFA" = {<B,w> | B "è un NFA che accetta la stringa di input" w} $

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
    $A_"NFA"$ è un linguaggio decidibile.
  ]
)

Per dimostrarlo prendiamo una TM $N$ che decide $A_"NFA"$ e potremmo progettare $N$ in modo che operi $M$ ovvero simulando un NFA invece che un DFA. Per cambiare però progettiamo $N$ in modo che usi $M$ come sottoprocedura quindi $N$ prima converte l'NFA in DFA e poi lo passa ad $M$ dato che questa lavora sui DFA.

- $N$ = "Su input $<B,w>$ dove $B$ è un NFA e $w$ è una stringa:"
  1. Converte l'NFA $B$ in un DFA $C$ equivalente
  2. Esegue la TM $M$ su input $<C,w>$
  3. Se $M$ accetta, accetta. Altrimenti rifiuta.

Infine, in modo analogo si può determinare se un'espressione regolare genera una determinata stringa:

$ A_"REX" = {<R,w>|R "è un'espressione regolare che genera la stringa" w} $

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
    $A_"REX"$ è un linguaggio decidibile.
  ]
)

Per dimostrarlo progettiamo la TM $P$:

- $P$ = "Su input $<R,w>$ dove $R$ è un'espressione regolare e $w$ è una stringa:"
  1. Converte l'espressione regolare $R$ in un NFA $A$ equivalente
  2. Esegue la TM $N$ su input $<A,w>$
  3. Se $N$ accetta, accetta. Altrimenti rifiuta.

Con questi 3 teoremi possiamo quindi dire che, ai fini della decidibilità, è equivalente presentare alla macchina di Turing un DFA, un NFA o un'espressione regolare perché la macchina è in grado di convertire una codifica nell'altra.

Affrontiamo adesso un problema diverso, il *test del vuoto* per il linguaggio di un automa finito. Consideriamo:

$ E_"DFA" = {<A> | A "è un DFA e" L(A) = emptyset} $

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
    $E_"DFA"$ è un linguaggio decidibile.
  ]
)

*Dimostrazione* - Il DFA accetta almeno una stringa se e solo se dallo stato iniziale può raggiungere uno stato di accettazione percorrendo il verso delle frecce del DFA. Per verificarlo progettiamo una TM $T$ che utilizza un algoritmo di marcatura.

- $T$ = "Su input $<A>$ dove $A$ è un DFA":
  1. Marca lo stato iniziale di $A$
  2. Ripete fino a quando non vengono più marcati nuovi stati:
    3. Marca qualsiasi stato che ha una transizione proveniente da uno stato già marcato
    4. Se nessuno stato di accettazione risulta marcato, accetta. Altrimenti rifiuta.

Un altro linguaggio deciidibile è:

$ E Q_"DFA" = {<A,B> | A "e" B "sono DFA e" L(A) = L(B)} $

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
    $E Q_"DFA"$ è un linguaggio decidibile.
  ]
)

*Dimostrazione* - Costruiamo un nuovo DFA $C$ a partire da $A$ e $B$ dove $C$ accetta solo quelle stringhe che sono accettate da $A$ o da $B$ ma non da entrambi, quindi se $A$ e $B$ riconoscono lo stesso linguaggio allora $C$ non accetterà nulla. Abbiamo quindi che:

$ L(C) = (L(A) inter overline(L(B))) union (overline(L(A)) inter L(B)) $

Questa espressione è anche denotata come *differenza simmetrica* di $L(A)$ e $L(B)$, questa è utile perché $L(C)= emptyset$ se e solo se $L(A) = L(B)$. Una volta costruito $C$ possiamo utilizzare il teorema precedente per verificare se $L(C)$ è vuoto o meno, infatti se è vuoto $L(A) = L(B)$.

- $F$ = "Su input $<A,B>$ dove $A$ e $B$ sono DFA":
  1. Costruisce il DFA $C$
  2. Esegue la TM $T$ del teorema precedente su input $<C>$
  3. Accetta se $T$ accetta, altrimenti rifiuta.

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
  title: [*Relazioni tra le classi di linguaggi*],
  [
    #align(center, image("img/rel_lin.png", width: 80%))
  ]
)

= Indecidibilità
Vediamo il primo teorema che stabilisce l'indecidibilità di un linguaggio con il seguente problema: Determinare se una macchina di Turing accetta una determinata stringa in input, chiamiamo tale linguaggio $A_"TM"$:

$ A_"TM" = {<M,w> | M "è una TM e" M "accetta" w} $

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
    $A_"TM"$ è indecidibile.
  ]
)

Prima di dimostrarlo osserviamo che $A_"TM"$ è *Turing-Riconoscibile*, questo teorema mostra quindi che i riconoscitori sono più potenti dei decisori infatti richiedere che una TM si fermi su ogni input limita le tipologie di linguaggi che possono essere riconosciuti. Costruiamo la TM $U$ che riconosce $A_"TM"$:

- $U$ = "Su input $<M,w>$ dove $M$ è una TM e $w$ è una stringa":
  1. Simula $M$ su input $w$
  2. Se durante la computazione $M$ entra nello stato di accettazione, accetta. Altrimenti rifiuta.

Questa macchina cicla su $<M,w>$ se $M$ cicla su $w$ e questo è il motivo per cui non decide $A_"TM"$ infatti se l'algoritmo avesse modo di determinare che $M$ non si ferma su $w$ allora sarebbe in grado di rifiutare $w$, dimostreremo che un algoritmo non ha modo di determinarlo.

Vogliamo dimostrare l'indecidibilità del linguaggio

$ A_"TM" = {<M,w> | M "è una TM ed" M "accetta" w} $

*Dimostrazione* - Assumiamo che $A_"TM"$ è decidibile e otteniamo una contraddizione. Supponiamo che $H$ sia un decisore per $A_"TM"$ e quindi su input $<M,w>$ dove $M$ è una TM e $w$ una stringa abbiamo che $H$ si ferma ed accetta se $M$ accetta $w$, si ferma e rifiuta se $M$ non accetta $w$. Assumiamo quindi che $H$ è una TM dove:

$ H(<M,w>) = cases("accetta" quad "se" M "accetta" w, "rifiuta" quad "se" M "non accetta" w) $

Adesso costruiamo una nuova TM $D$ avente $H$ come sottoprocedura, questa nuova TM chiama $H$ per determinare cosa fa $M$ quando l'input di $M$ è la sua stessa descrizione $<M>$, una volta che $D$ ha determinato questa informazione, fa il contrario, quindi rifiuta se $M$ accetta e viceversa. Descriviamo $D$:
- $D$ = "Su input $<M>$ dove $M$ è una TM":
  1. Esegue $H$ su input $<M,<M>>$
  2. Dà in output l'opposto di ciò che $H$ dà in input, rifiuta se $H$ accetta e viceversa.

Quindi:

$ D(<M>) = cases("accetta" quad "se" M "non accetta" <M>, "rifiuta" quad "se" M "accetta" <M>) $

E cosa succede quando eseguiamo $D$ con la sua stessa descrizione $<D>$?

$ D(<D>) = cases("accetta" quad "se" D "non accetta" <D>, "rifiuta" quad "se" D "accetta" <D>) $

Quindi indipendentemente da ciò che fa $D$, essa è costretta a fare il contrario ed è quindi una contraddizione, nè la TM $D$ nè la TM $H$ possono esistere.

Si utilizza la tecnica della diagonalizzazione quando si esaminano le tavole del comportamento delle TM $H,D$, in queste tavole si indicizzano le righe con tutte le TM $M_1, M_2 ...$ e le colonne con le descrizioni $<M_1>,<M_2>,...$ e le entrate dicono se la macchina di una determinata riga accetta l'input di una data colonna.

Se aggiungiamo $D$ alla tabella, dato che deve comparire, cosa inseriamo quando $D$ riceve come input $<D>$?

#align(center, image("img/diag.png", width: 80%))

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
    Un linguaggio è decidibile se e solo se è Turing-Riconoscibile e coTuring-Riconoscibile.

    Un linguaggio è coTuring riconoscibile se $overline(L)$ è Turing-Riconoscibile.
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
  title: [*Corollario*],
  [
    Se $L$ non è decidibile, allora almeno uno tra $L$ ed $overline(L)$ non è Turing-Riconoscibile.
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
  title: [*Corollario*],
  [
    $overline(A_"TM")$ non è Turing-Riconoscibile
  ]
)

*Dimostrazione* - Sappiamo che $A_"TM"$ è Turing-Riconoscibile, se lo fosse anche $overline(A_"TM")$ allora $A_"TM"$ sarebbe decidibile. Sappiamo però, dai teoremi precedenti, che $A_"TM"$ non è decidibile e quindi $overline(A_"TM")$ non può essere Turing-Riconoscibile.

= Riducibilità
Una riduzione è un modo di convertire un problema in un altro problema in modo tale che una soluzione al secondo problema può essere usata per risolvere il primo problema.

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
  [
    $f: Sigma^* arrow.r Sigma^*$ è *calcolabile* se $exists$ TM $M$ che calcola $f quad forall w in Sigma^*$.
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
  title: [*Definizione - Mapping Reduction*],
  [
    $A$ è *riducibile* tramite funzione a $B$ ($A lt.eq_m B$) se $exists f: Sigma^* arrow.r Sigma^*$ calcolabile tale che $forall w in Sigma^*$:

    $ w in A arrow.double.r.l f(w) in B $
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
    Se $A lt.eq_m B$ e $B$ è *decidibile* allora $A$ è decidibile.
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
  title: [*Corollario*],
  [
    Se $A lt.eq_m B$ e $A$ è *indecibile* allora $B$ è indecidibile.
  ]
)

*Dimostrazione Corollario* - Se $B$ fosse decidibile allora $A$ sarebbe decidibile per il teorema.

*Dimostrazione teorema* - Sia $M$ la TM che decide $B$ e sia $F$ la TM che calcola la mapping reduction $f$ da $A$ a $B$. Costruiamo il decisore $M'$ per $A$:
- Su input $w$ calcola $f(w)$ usando $F$
- Poi computa $M$ su $f(w)$ e accetta se e solo se $M$ accetta.

$M'$ è decisore perché $M$ lo è e $F$ termina sempre. Inoltre:
$ M'(w) = "acc" arrow.double.l.r.long cases(M(f(w)) = "acc", f(w) in B, w in A) $