#import "@preview/showybox:2.0.4": showybox

= Algebre e Strutture Dati Induttive

Questa tipologia di Algebre ci servirà a dare un significato alla struttura dei programmi, ovvero la *semantica*, sono inoltre
la base matematica di strutture dati come _alberi, liste ecc..._, ci serviranno anche per fare induzione su altre strutture e non solo su sistemi numerici, questa è chiamata *induzione strutturale*.

Ci serviranno delle strutture universali, proviamo ad esempio a descrivere i numeri naturali $NN$ attraverso delle regole, gli *Assiomi di Peano*.

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
    title: [*Assiomi di Peano*],
    [- $0 in NN$
    - $n in NN arrow.r.double "succ"(n) in NN$
    - $exists.not n " t.c. " 0 = "succ"(n)$
    - $forall n,m " se " "succ"(n)="succ"(m)arrow.double.r n=m$
    - $forall S subset.eq NN (0 in S and n in S arrow.r.double "succ"(n) in S) arrow.double.r S = NN$
    
    Grazie a queste regole possiamo "staccarci" dagli elementi dei numeri naturali, abbiamo descritto la loro *struttura*.
    ]
)

L'ultimo degli assiomi viene anche chiamato *assioma di Induzione*, infatti è molto simile al *principio di induzione*.

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
    title: [*Principio di Induzione*],
    [Data una proprietà $P$ che vale per un $n=0$, la assumiamo vera per un $n in NN$ e dimostriamo che è vera anche per $n+1$, se riusciamo abbiamo dimostrato che $P$ vale $forall n in NN$. 
    
    In simboli:
    $ P(0) and (P(n) arrow.double.r P(n+1)) arrow.r.double forall m in NN P(m) $]
)

= Algebre

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
    title: [*Proprietà ed Insiemi*],
    [Dire che un elemento appartiene ad un insieme o che soddisfa una proprietà possiamo vederla come la stessa cosa.]
)

Quando definiamo un'algebra dobbiamo definire l'insieme dei suoi elementi le operazioni che ne fanno parte, ad esempio: $(A, Gamma)$ e le sue operazioni possono essere: $ Gamma = {Gamma_1, Gamma_2, Gamma_3, ...} $

Questo serve perché sullo stesso insieme possiamo definire più algebre.

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
    title: [Esempio],
    [Prendiamo come insieme di elementi delle liste di numeri naturali e due operazioni:
    - *append*: Prende in input due liste e restituisce la lista che concatena le due prese in input.
    - *cons*: Prende in input un numero da $NN$ ed una lista e inserisce il numero all'inizio della lista.
    
    Graficamente abbiamo che:
    #align(center, image("img/Senza titolo-2025-09-25-0928.svg", width: 70%))

    - $"append"(<3,4,7>, <2,5>)=<3,4,7,2,5>$
    - $"cons"(5, <3,4,7>)=<5,3,4,7>$
    ]
)

Notiamo che come risultato *abbiamo sempre un elemento dell'algebra*.

Come input possiamo avere anche elementi estranei, se questo accade allora l'algebra prende il nome di *Algebra Eterogenea*.

== Chiusura rispetto ad una funzione

Data un'algebra $A$ prendiamo $S subset.eq A$ e una funziona $f:A arrow.r S$

- $S$ è *chiusa* rispetto a $f$ quando $ x in S arrow.double.r f(x) in S $

Quindi se prendo come input un elemento da $S$ devo tornare in $S$, questo deve funzionare anche se prendo come input più elementi.

- Se abbiamo ad esempio un insieme $B subset.eq.not A$ e $S subset.eq A$ allora: $ forall y in B \ x in S arrow.r.double f(x,y) in S $

- Ultimo caso da tenere in mente è quando come input non abbiamo elementi di $S$, in questo caso la funzione $S$ è comunque chiusa rispetto ad $f$ dato che stiamo negando la prima parte dell'implicazione.

Adesso, con questo concetto in mente possiamo parlare di Algebre Induttive.

== Algebre Induttive

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
        Un Algebra $(A, Gamma)$ si dice induttiva quando:
    - Tutte le $Gamma_i$ sono induttive
    - Tutte le $Gamma_i$ hanno immagini disgiunte
    - $forall S subset.eq A$ se $S$ è chiuso rispetto a tutte le $Gamma_i$ allora $S=A$
    ]
)

Proviamo a costruire un'algebra induttiva con i numeri naturali usando queste 3 regole e gli assiomi di Peano.

I primi due assiomi di Peano:
- $0 in NN$
- $n in NN arrow.double.r "succ"(n) in NN$

Ci danno la segnatura dell'algebra:

$ (NN, underbrace({0, "succ", "zero"}, Gamma)) $

La funzione nullaria $"zero"$ ci serve per rappresentare l'elemento 0.

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
    title: [*Funzione Nullaria*],
    [Prendiamo come esempio la coppia $(7,3)$ questa sarà elemento di $NN^2$ mentre $(7,3,5)$ sarà elemento di $NN^3$ ma allora $()$ sarà elemento di $NN^0$ e sarà anche l'*unico*. Indichiamo con $bb(1)$ questo insieme.
    $ NN^0 = {()} = bb(1) $
    
    Quindi una funzione nullaria su un insieme $A$ avrà una segnatura del tipo $bb(1) arrow.r A$.

    Una funzione nullaria su un insieme $A$ può essere vista come un elemento di $A$.
    ]
)

Vediamo se rispettiamo le proprietà delle algebre induttive:
- Entrambe le funzioni sono induttive, $"zero"$ è nullaria mentre $"succ"$ rispetta l'induzione:
    - Vale per 0
    - Se vale per $n$ vale anche per $n+1$

- Le due funzioni hanno immagini disgiunte, una ha solo 0 come immagine mentre l'altra ha $NN - {0}$.
- Prendiamo un $S subset.eq NN$ e supponiamo che sia chiuso su entrambe le funzione $"succ", "zero"$ questo implica che:
    - $0 in S$ per $"zero"$
    - $n in S arrow.r.double n+1 in S$ per $"succ"$
Quindi se $S$ è chiuso su entrambe allora abbiamo preso $NN$ e l'algebra è induttiva perché rispettiamo le 3 proprietà.

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
    title: [5 Assiomi - Algebra Induttiva],
    [I 5 Assiomi di Peano sono quindi un caso particolare di Algebra Induttiva con le operazioni $"zero e succ"$.
    
    Quando un'algebra è induttiva le sue operazioni $Gamma_i$ si chiamano *costruttori dell'algebra*.]
)