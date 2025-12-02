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

== Problemi indecidibili della Teoria dei Linguaggi:
Prima abbiamo visto l'indecidibilità di $A_"TM"$, ovvero il problema di determinare se una macchina di Turing accetta un dato input. Adesso consideriamo il problema $"HALT"_"TM"$ ovvero quello di determinare se una macchina di Turing si ferma su un dato input, va bene sia un accettazione che un rifiuto. Questo è noto come il *problema della fermata*.

Utilizziamo l'indecidibilità di $A_"TM"$ per dimostrare l'indecidibilità di $"HALT"_"TM"$, riducendo $A_"TM"$ a $"HALT"_"TM"$.

Sia:

$ "HALT"_"TM" = {<M,w> | M "è una TM e" M "si ferma su input" w} $

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
    $"HALT"_"TM"$ è *indecidibile*.
  ]
)

Dimostriamo per assurdo il teorema, assumiamo $"HALT"_"TM"$ decidibile ed utilizziamo questa assunzione per dimostrare che $A_"TM"$ è decidibile, ottenendo quindi una contraddizione. Dobbiamo quindi mostrare che $A_"TM"$ è riducibile da $"HALT"_"TM"$.

Supponiamo di avere una TM $R$ che decide $"HALT"_"TM"$, utilizziamo $R$ per verificare se $M$ si ferma su $w$, se $R$ indica che $M$ non si ferma su $w$, rifiutiamo perché $<M,w>$ non è in $A_"TM"$; se invece $R$ indica che $M$ si ferma su $w$ possiamo fare la simulazione senza rischiare di ciclare.

Se la TM $R$ esistesse, potremmo decidere $A_"TM"$ ma sappiamo che $A_"TM"$ è indecidibile, abbiamo una contraddizione e possiamo quindi dire che $R$ non esiste, quindi $"HALT"_"TM"$ è indecidibile.

*Dimostrazione* - Ricapitolando, per ottenere una contraddizione assumiamo che la TM $R$ decide $"HALT"_"TM"$, costruiamo la TM $S$ per decidere $A_"TM"$ che opera come segue:

- $S=$ "Su input $<M,w>$, una codifica di una TM $M$ ed una stringa $w$":
  1. Esegue la TM $R$ su input $<M,w>$
  2. Se $R$ rifiuta, rifiuta
  3. Se $R$ accetta, simula $M$ su $w$ finché non si ferma
  4. Se $M$ ha accettato, accetta altrimenti rifiuta.

Se $R$ decide $"HALT"_"TM"$ allora $S$ decide $A_"TM"$, poiché $A_"TM"$ è indecidibile allora anche $"HALT"_"TM"$ deve essere indecidibile.

_Vediamo altri teoremi e le loro dimostrazioni come esempi per utilizzare la riducibilità per dimostrare l'indecidibilità_

Sia:

$ E_"TM" = {<M> | M "è una TM e" L(M) = emptyset} $

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
    $E_"TM"$ è *indecidibile*
  ]
)

*Idea* - Come prima assumiamo $E_"TM"$ decidibile e mostriamo che $A_"TM"$ è decidibile ottenendo quindi una contraddizione.

Sia $R$ una TM che decide $E_"TM"$, utilizziamo $R$ per costruire la TM $S$ che decide $A_"TM"$, come deve agire $S$ su input $<M,w>$?

$S$ esegue $R$ su input $<M>$ e vede se $R$ accetta, se lo fa sappiamo che $L(M)$ è vuoto e quindi che $M$ non accetta $w$. Se $R$ rifiuta allora sappiamo che $L(M)$ non è vuoto e di conseguenza $M$ accetta qualche stringa ma non sappiamo se $w$ fa parte di queste.

Cambiamo approccio, invece di eseguire $R$ su $<M>$, eseguiamo $R$ su una modifica di $<M>$, ovvero modifichiamo $M$ in modo da garantire che $M$ rifiuta tutte le stringhe tranne $w$, ma su $w$ funziona come al solito. Adesso possiamo utilizzare $R$ per determinare se la macchina modificata riconosce il linguaggio vuoto. Infatti l'unica stringa che adesso la macchina può accettare è $w$, per cui il suo linguaggio sarà non vuoto se e solo se accetta $w$. Se $R$ accetta quando riceve in input la descrizione della macchina modificata, sappiamo che la macchina modificata non accetta nulla e che $M$ non accetta $w$.

*Dimostrazione* - Descriviamo la macchina modificata e chiamiamola $M_1$:

- $M_1$ = "Su input $x$":
  1. Se $x eq.not w$ rifiuta
  2. Se $x = w$ esegue $M$ su input $w$ e accetta se $M$ accetta.

La macchina ha $w$ come parte della sua descrizione, verifica se $x = w$ confrontando carattere per carattere con $w$ per determinare se coincidono. Assumiamo che la TM $R$ decide $E_"TM"$ e costruiamo la TM $S$ che decide $A_"TM"$ nel seguente modo:

- $S = $ "Su input $<M,w>$, una codifica di una TM $M$ e una stringa $w$":
  1. Usa la descrizione di $M$ e $w$ per costruire la TM $M_1$ vista sopra.
  2. Esegue $R$ su input $<M_1>$
  3. Se $R$ accetta, rifiuta; se $R$ rifiuta, accetta

Se $R$ fosse un decisore per $E_"TM"$ allora $S$ lo sarebbe per $A_"TM"$ ma questo non può esistere, quindi $E_"TM"$ è indecidibile.

Un altro problema è quello di determinare se una macchina di Turing riconosce un linguaggio che può essere riconosciuto anche da un modello di calcolo più semplice. Ad esempio sia $"REGULAR"_"TM"$ il problema di determinare se una macchina di Turing ha un automa finito equivalente, che equivale a determinare se la TM riconosce un linguaggio regolare. Sia:

$ "REGULAR"_"TM" = {<M> | M "è una TM ed" L(M) "è un linguaggio regolare" } $

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
    $"REGULAR"_"TM"$ è *indecidibile*
  ]
)

*Idea* - Anche in questo caso riduciamo da $A_"TM"$, assumiamo che $"REGULAR"_"TM"$ sia deciso da una TM $R$ e costruiamo una TM $S$ che decide $A_"TM"$.

L'idea è che $S$ prenda il suo input $<M,w>$ e modifichi $M$ in modo che la risultante TM riconosca un linguaggio regolare se e solo se $M$ accetta $w$. Chiamiamo $M_2$ la macchina così modificata e progettiamo $M_2$ in modo che riconosca il linguaggio non regolare ${0^n 1^n | n gt.eq 0}$ se $M$ non accetta $w$ e riconosca il linguaggio regolare $Sigma^*$ se $M$ accetta $w$. 
Va specificato come $S$ può costruire una tale $M_2$ da $M$ e $w$.
La TM $M_2$ non è costruita con lo scopo di essere eseguita su qualche input ma soltanto per dare in input la sua descrizione al decisore per $"REGULAR"_"TM"$ che assumiamo esista. Quando il decisore da la sua risposta possiamo usarla per rispondere se $M$ accetta $w$ o meno, possiamo quindi decidere $A_"TM"$, contraddizione.

*Dimostrazione* - Definiamo $R$ come una TM che decide $"REGULAR"_"TM"$ e costruiamo una TM $S$ che decide $A_"TM"$, funzionamento di $S$:

- $S = $"Su input $<M,w>$ dove $M$ è una TM e $w$ è una stringa:"
  1. Costruisce la seguente TM $M_2$
    $M_2 = $"Su input $x$":
      1. Se $x$ ha la forma $0^n 1^n$, accetta
      2. Se $x$ non ha tale forma, esegue $M$ su input $w$ e accetta se $M$ accetta $w$
  2. Esegue $R$ su input $<M_2>$
  3. Se $R$ accetta, accetta altrimenti rifiuta

Un altro problema indecidibile è quello di dimostrare se due macchine di Turing sono equivalenti.

Sia:

$ "EQ"_"TM" = {<M_1, M_2> | M_1 "ed" M_2 "sono TM ed" L(M_1) = L(M_2)} $

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
    $"EQ"_"TM"$ è *indecidibile*.
  ]
)

Dimostriamolo facendo una riduzione da $E_"TM"$.

*Idea* - Mostriamo che se $"EQ"_"TM"$ fosse decidibile allora anche $E_"TM"$ lo sarebbe ottenendo quindi una contraddizione.
$E_"TM"$ é il problema di determinare se il linguaggio di una TM é vuoto mentre $"EQ"_"TM"$ quello di determinare se i linguaggi di due TM sono uguali, se uno di questi due é vuoto allora ci ritroviamo con il problema di determinare se il linguaggio dell'altra macchina é vuoto cioé $E_"TM"$

*Dimostrazione* - Consideriamo una TM $R$ che decide $"EQ"_"TM"$ e costruiamo la TM $S$ che decide $E_"TM"$:
- $S=$ "Su input $<M>$, dove $M$ é una TM":
  - Esegue $R$ su input $<M, M_1>$ dove $M_1$ é una TM che rifiuta ogni input
  - Se $R$ accetta, accetta altrimenti rifiuta

Se $R$ decide $"EQ"_"TM"$, $S$ decide $E_"TM"$. Ma sappiamo che $E_"TM"$ é indecidibile quindi anche $"EQ"_"TM"$ é indecidibile.

== Riducibilitá tramite funzione
Essere in grado di ridurre il problema A al problema B utilizzando una riduzione mediante funzione significa che esiste una funzione calcolabile che trasforma istanze del problema A in istanze del problema B. Questa funzione se esiste si chiama *riduzione* e ci permette di risolvere le istanze di A risolvendo le istanze di B.

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
  title: [*Funzione Calcolabile*],
  [
    Una funzione $f:Sigma^* arrow.r Sigma^*$ é una *funzione calcolabile* se esiste una macchina di Turing M che su qualsiasi input $w$ si ferma avendolo solo $f(w)$ sul nastro.
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
  title: [*Riducibilitá tramite Funzione*],
  [
    Un linguaggio $A$ si dice *riducibile mediante funzione* al linguaggio $B$, e si denota con $A attach(lt.eq, br:m) B$, se esiste una funzione calcolabile $f:Sigma^* arrow.r Sigma^*$ dove per ogni $w$:
    $ w in A arrow.double.r.l f(w) in B $
    La funzione $f$ é chiamata *riduzione* da $A$ a $B$.
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
    Se $A attach(lt.eq,br:m) B$ e $B$ è *decidibile* allora $A$ è decidibile.
  ]
)

*Dimostrazione* - Siamo $M$ il decisore per $B$ ed $f$ la riduzione da $A$ a $B$. Descriviamo un decisore $N$ per $A$ come segue:
- $N=$ Su input $w$:
  - Computa $f(w)$
  - Esegue $M$ su input $f(w)$ e restituisce lo stesso output di $M$

Quindi se $w in A$ allora $f(w) in B$ perché $f$ é una riduzione da $A$ a $B$. Quindi, $M$ accetta $f(w)$ ogni volta che $w in A$.

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
    Se $A attach(lt.eq,br:m) B$ e $B$ è *Turing-Riconoscibile* allora $A$ è Turing-Riconoscibile.
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
    Se $A attach(lt.eq,br:m) B$ e $A$ non è *Turing-Riconoscibile* allora $B$ non è Turing-Riconoscibile.
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
    $"EQ"_"TM"$ non é né Turing-Riconoscibile né co-Turing riconoscibile
  ]
)

*Dimostrazione* - Per prima cosa dimostriamo che $"EQ"_"TM"$ non é Turing-Riconoscibile, lo facciamo dismotrando che $A_"TM"$ é riducibile a $overline("EQ"_"TM")$. La funzione di riduzione $f$ opera nel seguente modo:
- $F=$ Su input $<M,w>$ dove $M$ é una TM e $w$ una stringa:
  - Costruisce le seguenti due macchine $M_1, M_2$
    - $M_1$ = Su ogni input Rifiuta
    - $M_2$ = Su ogni input eseuge $M$ su $w$, se accetta, accetta
  - Restituisce $<M_1, M_2>$

Quindi $M_1$ non accetta alcuna stringa e se $M$ accetta $w$ allora $M_2$ accetta qualsiasi stringa, le macchine non sono equivalenti. Viceversa se $M$ non accetta $w$ allora $M_2$ non accetta alcuna strina e le macchine sono equivalenti. Questo significa che $f$ riduce $A_"TM"$ a $overline("EQ"_"TM")$.
Adesso per dimostrare che $overline("EQ"_"TM")$ non é Turing-Riconoscibile diamo una riduzione da $A_"TM"$ a $"EQ"_"TM"$, in questo modo dimostriamo che $A_"TM" attach(lt.eq,br:m) "EQ"_"TM"$. Costruiamo la TM $G$ che calcola la riduzione $g$ nel seguente modo:
- $G=$ Su input $<M,w>$ dove $M$ é una TM e $w$ é una stringa:
  - Costruisce le seguenti due macchine $M_1, M_2$:
    - $M_1$ accetta su ogni input
    - $M_2$ esegue $M$ su $w$ e se accetta, accetta.
  - Restituisce $<M_1, M_2>$

La differenza tra $f,g$ si trova in $M_1$, in $f$ rifiuta sempre mentre in $g$ rifiuta sempre mentre sia in $f$ che $g$ $M$ accetta $w$ se e solo se $M_2$ accetta ogni input, in $g$ $M$ accetta $w$ se e solo se $M_1$ e $M_2$ sono equivalenti ed é per questo che $g$ é una riduzione da $A_"TM"$ a $"EQ"_"TM"$

= Teoremi di Incompletezza di Godel
Uno dei più grandi problemi della matematica è stato quello di volerla formalizzare attraverso la logica in modo tale che fosse:
- *Consistente*: Non può generare contraddizioni
- *Completo*: In grado di dimostrare ogni affermazione vera.
- *Decidibile*: Esiste un algoritmo per determinare la verità o la falsità di ogni affermazione.

Questo è noto come *problema di Hilbert* ma in un solo giorno Godel dimostrò che non era possibile creare un sistema logico abbastanza complesso per contenere l'intera aritmetica, questo è noto come *primo teorema di incompletezza*.

In poco tempo Godel dimostrò anche il *secondo teorema di incompletezza* secondo cui nessun sistema consistente può dimostrare la propria consistenza. Dobbiamo quindi soltanto sperare che il sistema logico attualmente in uso, ZFC, sia consistente.

Le dimostrazioni fatte da Godel sono molto complesse ma grazie a Turing possiamo semplificarle, introduciamo un sistema di prova $Pi$:
- Per ogni affermazione vera o falsa esiste una sua rappresentazione come stringa $<x>$ di lunghezza finita.
- Per ogni dimostrazione esiste una rappresentazione $<Pi>$ come stringa di lunghezza finita.
- Esiste $V in "TM"$ decisore t.c. $forall(<x,w>) in Sigma^*$ si ha che $<x,w> in L(V)$ se e solo se $w$ è una dimostrazione per $x$ in $Pi$.

Un'affermazione $<x>$ è detta *dimostrabile* se $exists <w> in Sigma^*$ t.c. $<x,w> in L(V)$, è detta *indipendente* se né $x$ né $not x$ sono dimostrabili in $Pi$.
Ma $Pi$ deve anche essere *computabile* ovvero gli assiomi devono essere riconoscibili, o meglio dato $A in Pi$ un assioma, $A$ deve essere decidibile.

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
    Sia $Pi$ un sistema di prova. Diremo che:
    - $Pi$ è *consistente* se $forall <x>$ (per ogni affermazione) al più uno tra $x$ e $not x$ è dimostrabile
    - $Pi$ è *valido* se ogni affermazione vera è dimostrabile
    - $Pi$ è *completo* se $forall <x>$ almeno uno tra $x$ e $not x$ è dimostrabile
    - $Pi$ è *incompleto* se esiste un'affermazione indipendente
  ]
)

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
  [
    - Se un sistema è valido è anche consistente infatti se $x$ è dimostrabile allora è anche vera implicando che $not x$ è falsa.
    - Un sistema consistente però non implica che sia valido
    - Se un sistema è valido e completo allora $forall <x>$ solo uno tra $x$ e $not x$ è dimostrabile
    - Se un sistema è consistente e completo allora $forall <x>$ solo uno tra $x$ e $not x$ è dimostrabile.
    Quindi tutto e solo ciò che è vero è dimostrabile.
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
    Sia $Pi$ un sistema di dimostrazione abbastanza potente da comprendere l'aritmetica allora $Pi$ non può essere sia valido che completo
  ]
)

*Dimostrazione* - Sia $L={<x>:x "è dimostrabile in" Pi}$ e definiamo la TM $R_Pi$ che prova a decidire $L$:
- $R_Pi=$ Data la stringa $<x>$ in input:
  - Ripeti per ogni $k=1,2,3...$:
    - Ripeti per ogni $w in Sigma^*$ con $|w|=k$:
      - Se $V(<x,w>)="ACC", R_Pi$ accetta
      - Se $V(<x,w>)="REJ", R_Pi$ rifiuta

Quindi:
- Se $Pi$ è valido, quando $R_Pi$ termina fornisce una risposta corretta ma non è detto che termini.
- Se $Pi$ è completo allora $R_Pi$ è un decisore, infatti se $R_Pi (<x>)="loop"$ allora né $x$ né $not x$ sono dimostrabili (non è completo).
- Se $Pi$ è valido e completo allora $R_Pi$ è un decisore tale che $forall <x>$ se $x$ è vera $R(<x>)="ACC"$ e se $x$ è falsa $R(<x>)="REJ"$

Supponiamo per assurdo che $Pi$ sia valido e completo e quindi abbia un dimostratore in $V$.
Data $M in "TM"$ e $y$ input considero la seguente affermazione:

$ Phi_(M,y) = M(y) "termina" $

E definisco la TM $D(<M,w>)=R_Pi (<Phi_(M,y)>)$

Se $Pi$ è sia valido che completo allora $R_Pi$ è un decisore e di conseguenza lo è anche $D$ ma $L(D)="HALT"_"TM"$ che non è decidibile, contraddizione, $R_Pi$ non può essere sia valido che completo.

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
  title: [*Primo Teorema di Incompletezza*],
  [
    Sia $Pi$ un sistema di dimostrazione abbastanza potente da comprendere l'aritmetica. Se $Pi$ è consistente allora $Pi$ non è completo.
  ]
)

*Dimostrazione* - Consideriamo la seguente affermazione $Phi_M = \"M(<M>)" termina"\"$ e definiamo la TM $R_Pi$:
- $R_Pi=$ Data la stringa $<x>$ in input:
  - Ripeti per ogni $k=1,2,3...$:
    - Ripeti per ogni $w in Sigma^*$ con $|w|=k$:
      - Se $V(<Phi_R_Pi, w>)="ACC"$, $R_Pi$ va in loop
      - Se $V(<not Phi_R_Pi, w>)="ACC"$, $R_Pi$ termina

*Claim* - Se $Phi_R_Pi$ o $not Phi_R_Pi$ è dimostrabile allora $Pi$ è incosistente.

*Dimostrazione* - Supponiamo che $not Phi_R_Pi$ sia dimostrabile, allora esiste una dimostrazione $w$ t.c. $V(<not Phi_R_Pi, w>)="ACC"$ implicando che $R_Pi(<R_Pi>)$ termina.
Poiché l'esecuzione termina esiste una dimostrazione che descrive l'esecuzione di $R_Pi$. (uguale a $Phi_R_Pi$)
Allo stesso modo, supponiamo che $Phi_R_Pi$ sia dimostrabile allora esiste una dimostrazione $w$ t.c. $V(<Phi_R_Pi, w>)="ACC"$ implicando che $R_Pi(<R_Pi>)$ va in loop.
Siccome l'esecuzione va in loop, è noto il comportamento delal traccia, ed esiste dunque una dimostrazione che descrive l'esecuzione. Abbiamo dimostrato che ci basta dimostrare $Phi_R_Pi$ o $not Phi_R_Pi$ per rendere $Pi$ inconsistente.

Assumiamo $Pi$ consistente, allora per il claim né $Phi_R_Pi$ né $not Phi_R_Pi$ sono dimostrabili e dunque $Pi$ non è completo.

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
  title: [*Secondo Teorema di Incompletezza*],
  [
    Sia $Pi$ un sistema di dimostrazione abbastanza potente da comprendere l'aritmetica. Se $Pi$ è consistente allora $Pi$ non può dimostrare l'affermazione "$Pi$ è consistente".
  ]
)

*Dimostrazione* - Sia $Pi$ un sistema definito dal teorema, allora tale sistema è in grado di descrivere il funzionamento di una TM. Sia $R_Pi$ definita tramite $Phi_R_Pi$ come nel teorema precedente.

*Claim* - Se $Phi_R_Pi$ o $not Phi_R_Pi$ è dimostrabile allora $Pi$ è inconsistente

*Dimostrazione* - Uguale al teorema precedente

Assumiamo che $Pi$ è consistente, allora per il claim né $Phi_R_Pi$ né $not Phi_R_Pi$ sono dimostrabili. Supponiamo ora per assurdo che l'affermazione "$Pi$ è consistente" sia dimostrabile tramite $w in Sigma^*$, allora unendo $w$ alla dimsotrazione del claim otteniamo una dismotrazione per l'affermazione "né $Phi_R_Pi$ né $not Phi_R_Pi$ sono dimostrabili in $Pi$".
Tuttavia per costruzione di $R_Pi$, ciò corrisponde anche una dimostrazione per $not Phi_R_Pi$ in quanto è garantito che la TM va in loop creando una contraddizione.
"$Pi$ è consistente" non è dimostrabile in $Pi$.