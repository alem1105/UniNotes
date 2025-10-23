#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/xarrow:0.3.1": xarrow

#let nonumeq = math.equation.with(block: true, numbering: none)
#let dm(x) = box[#nonumeq[#x]]
#let dfrac(x,y) = math.frac(dm(x),dm(y))

= Espressioni

Definiamo un linguaggio $L$ come un insieme di stringhe. Per descrivere la sintassi di linguaggi formali (la grammatica), usiamo la *BNF (Backus-Naur Form)*, con questa sintassi: $ "<simbolo> ::= __espressione__" $

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
    [Consideriamo la grammatica: $ M,N ::= 5|7|M+N|M*N $
    Le espressioni che rispettano questa grammatica sono del tipo:
    - "5" o "7"
    - Un'espressione del tipo $M + N, M* N$ che rispetta a sua volta la grammatica.

    Introduciamo una funzione $"eval":L arrow.r NN$ che valuta le espressioni del linguaggio:
    - $"eval"(5)=5$
    - $"eval"(7)=7$
    - $"eval"(M+N)="eval"(M)+"eval"(N)$
    - $"eval"(M* N)="eval"(M)* "eval"(N)$
    ]
)

Notiamo che nell'esempio precedente l'algebra $(L, "eval")$ non è induttiva, infatti una stringa $5+7*5$ potrebbe essere stata generata in due modi diversi: $(5+7)*5$ e $5+(7*5)$.

Possiamo però considerare $5,7,+,*$ come costruttori dell'algebra e in questo modo $(5+7)*5 eq.not 5+(7*5)$, si potrebbe quindi dimostrare come $(L,5,7,+,*)$ è un'algebra induttiva.

= Linguaggio Exp

In questo semplice linguaggio indichiamo le espressioni con $ M,L,N,... ::= 0 | 1 | ... | x | y | z | ... | M + N | "let x = M in N" $

Quando usiamo $"let x = M in N"$ stiamo assegnando un valore alla variabile $x$ all'interno dell'espressione $N$. Al di fuori di quell'espressione $x$ avrà altri significati.

Ad esempio:
- $"let x = 3 in x + x"$ vale 6
- $"let x = 2 in 10"$ vale 10

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
    title: [*Funzione Free*],
    [La funzione $"free: Exp" arrow.r italic(P) ("Var")$, prende in input un'espressione e restituisce l'insieme delle variabili libere, ovvero quelle che non hanno un valore assegnato e sono quindi inutili al calcolo dell'espressione.
    
    _Esempi_:
    - $"free"(0)={}$
    - $"free"(k)={}$ con $k$ una qualsiasi costante
    - $"free"(x)={x}$
    - $"free"(M+N)="free"(M) union "free"(N)$
    - $"free"("let x = M in N")="free(M)" union {"free(N) - {x}"}$]
)

== Sintassi e Semantica Astratta
Assumiamo che siano un dati un insieme _Var_ di variabili ed un insieme di costanti entrambi numerabili:
- Utilizziamo $x,y,...$ per indicare le variabili
- $k_1, k_2,...$ per le costanti 
- $M,N$ per i termini del linguaggio 

L'insieme di tutti questi termini è definito induttivamente dalla sintassi astratta:
$ k ::= 5|40|... \ M::= k|x|M+N|"let x" = M "in" N $

L'operatore _let_ ha segnatura: $ "let":"Var" times "Exp" times "Exp" arrow.r "Exp" $

Questo operatore (termine) rappresenta un segmento di codice che definisce la variabile locale $x$, la inizializza al valore dell'espressione $M$ all'interno del corpo $N$ che può contenere o no dei riferimenti ad $x$. _Ad esempio:_ $ "let" x = 3+2 "in" x+x = 10 $

Nell'esempio precedente la variabile $x$ compare due volte in $N$, si dice che ci sono duie *occorrenze* della variabile, per la $x$ che invece compare subito dopo il _let_ si parla di *dichiarazione*.

Se però prendiamo ad esempio l'espressione: $ "let" x = 3 "in" x + "let" x = 2 "in" x+x $ Quante occorrenze di $x$ troviamo? *Dipende*.

L'espressione contiene due variabili con lo stesso nome e dobbiamo quindi capire quante volte compare ciascuna di esse ad esempio specificando meglio la struttura dell'espressione attraverso l'uso di parentesi: $ "let" x = 3 "in" (x + (("let" x = 2 "in" x)+x)) $

In questo caso ci aspettiamo una valutazione di 8 e:
- La $x$ con valore 3 ha 2 occorrenze
- La $x$ con valore 2 ha 1 occorrenza

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
    title: [*Espressioni Alfa-Equivalenti*],
    [Due espressioni si dicono *alfa-equivalebti* se sono identiche a meno di ridenominazione di variabili legate, ad esempio:
    $ "let x"=1 "in" x+1 $ è alfa equivalente a: $ "let y"=1 "in" y+1 $]
)

== Domini Semantici
La semantica di _Exp_ viene rappresentata usando la nozione di *ambiente*, un ambiente è una funzione *parziale* (non necessariamente definita su tutto il dominio) che associa dei valori ad un insieme finito di variabili:

$ "Env" = "Var" xarrow(f i n) "Val" $

Indichiamo gli ambienti come insiemi di coppie, per esempio l'ambiente $E$ dove $z$ vale $3$ e $y$ vale $9$ lo scriviamo come ${(z,3),(y,9)}$.

Il dominio di un ambiente è sempre un sottoinsieme finito di _Var_, in questo caso il dominio è ${x,y}$

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
    title: [*Concatenazione di Ambienti*],
    [
        Dati due ambienti $E_1, E_2$, la loro concatenazione indicata da $E_1 E_2$ il cui dominio è $"dom"(E_1) union "dom"(E_2)$ è definita come: $ (E_1 E_2)(x) = cases(E_2(x) "se" x in "dom"(E_2) \ E_1(x) "altrimenti") $
        Ha quindi la precedenza il dominio più a destra.
    ]
)

== Semantica Operazionale

La *semantica operazionale* di _Exp_ è una relazione: $ arrow.squiggly.r subset.eq "Env" times "Exp" times "Val" $

Un'asserzione di appartenenze $(E,M,v) in arrow.squiggly.r$ viene chiamata *giudizio operazionale* e si scrive $E tack.r M arrow.r.squiggly v$. Viene letta "_nell'ambiente E, M viene valutato come $v$"_.

_(Indichiamo dei generici valori con la variabile $v$)_

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
    title: [*Regola di Inferenza*],
    [
        Date delle proposizioni $P_1,...,P_n,C$ indichiamo la seguente proposizione: $ P_1 and ... and P_n and ((P_1 and ... and P_n) arrow.double.r C) $ che può essere scritta con la seguenta notazione alternativa detta *regola di inferenza*: $ frac(P_1 quad ... quad P_n, C) $
        Dove $P_1,...,P_n$ vengono dette *premesse* e $C$ viene detta *conclusione*.
    ]
)

I giudizi operazionali hanno delle regole:

1.
$ E tack.r k arrow.r.squiggly k $

2. 
$ E tack.r x arrow.r.squiggly v quad ("se" E(x)=v) $

3.
$ frac(E tack.r M arrow.squiggly.r v quad E tack.r N arrow.squiggly.r w, E tack.r M + N arrow.squiggly.r u) quad ("se" u=v+w) $

4.
$ frac(E tack.r M arrow.squiggly.r v quad E{(x,v)} tack.r N arrow.squiggly.r v', E tack.r "let" x=M "in" N arrow.r.squiggly v') $

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
    title: [*Attenzione!*],
    [
        Quali triple non appartengono a $arrow.r.squiggly$? Quelle che preso un qualsiasi ambiente non possono restituire il valore fissato.

        Per tripla intendiamo $(M,E,k) in arrow.squiggly.r$, che leggiamo _"L'espressione $M$ nell'ambiente $E$ vale $v$"_. Ma se ad esempio prendiamo la tripla $(5, [E], 7)$ con $E$ un qualsiasi ambiente questa non apparterrà mai a $arrow.squiggly.r$, infatti in qualsiasi ambiente $5$ non potrà mai valere $7$.
    ]
)

Per valutare le espressioni possiamo usare *l'albero di derivazione*, proviamo a risolvere: $ "let" x=3 "in" (["let" x=("let" y=2 "in" x+y) "in" x+7]+x) $

Costruiamo l'albero di derivazione:

$ dfrac(emptyset tack.r 3 arrow.squiggly.r 3 quad dfrac(dfrac(dfrac((x,3)tack.r 2 arrow.r.squiggly 2 quad frac((x,3)(y,2)tack.r x arrow.r.squiggly 3 quad (x,3)(y,2) tack.r y arrow.r.squiggly 2, (x,3)(y,2) tack.r x+y arrow.r.squiggly 5),(x,3) tack.r "let" y=2 "in" x+y arrow.r.squiggly 5 )quad (x,3)(x,5)tack.r x+7 arrow.r.squiggly 12,(x,3) tack.r "let" x=("let" y=2 "in" x+y) "in" x+7 arrow.r.squiggly 12) quad (x,3)tack.r x arrow.r.squiggly 3, emptyset tack.r "let" x=("let" y=2 "in" x+y) "in" x+7]+x arrow.r.squiggly 15),emptyset tack.r "let" x=3 "in" (["let" x=("let" y=2 "in" x+y) "in" x+7]+x) arrow.squiggly.r 15) $

Quindi, seguendo le regole definite prima, si valuta per prima $N$ e poi $M$.

Questo è un approccio di tipo *eager* con scoping *statico*, questo significa che appena troviamo un'espressione la valutiamo in modo da poterla utilizzare dopo, ma se questa espressione dopo non ci servisse?

Proviamo ad usare un approccio *lazy* con scoping *dinamico*, questo significa che se abbiamo: $ "let" x = M in N $ prima calcoliamo $N$ e se ci serve $x$ allora calcoliamo $M$.

Con scoping intendiamo l'istante di valutazione delle variabili, statico viene effettuato subito (a tempo di compilazione) mentre dinamico solo se serve (in esecuzione).

Usando un approccio lazy, le regole della somma e delle costanti rimangono uguali, ma quella del _let_ e delle variabili cambia:

Il let diventa: $ frac(E(x,M) tack.r N arrow.squiggly.r v, E tack.r "let" x=M "in" N arrow.squiggly.r v) $

Le variabili: $ frac(E tack.r M arrow.squiggly.r v, E tack.r x arrow.squiggly.r v) quad "Se" E(x)=M $

Mettiamo i due approcci a confronto sulla stessa espressione, proviamo prima un approccio eager:

$ dfrac(dfrac(dfrac((x,2)tack.r x arrow.r.squiggly 2 quad (x,2) tack.r 1 arrow.r.squiggly 1,(x,2) tack.r x+1 arrow.r.squiggly 3) quad dfrac((x,2)(y,3) tack.r 7 arrow.r.squiggly 7 quad (x,2)(y,3)(x,7) tack.r y arrow.r.squiggly 3,(x,2)(y,3)tack.r "let" x=7 "in" y arrow.r.squiggly 3),emptyset tack.r 2 arrow.r.squiggly 2 quad (x,2) tack.r "let" y=x+1 "in let" x=7 "in" y arrow.r.squiggly 3), emptyset tack.r "let" x =2  "in let" y=x+1 "in let" x=7 "in" y arrow.squiggly.r 3) $

Con un approccio lazy:

$ dfrac(dfrac(dfrac(dfrac(dfrac(dfrac(E tack.r 7 arrow.r.squiggly 7,E tack.r x arrow.r.squiggly 7 )quad E tack.r 1 arrow.r.squiggly 1,(x,2)(y,x+1)(x,7) tack.r x+1 arrow.r.squiggly 8),(x,2)(y,x+1)(x,7) tack.r y arrow.r.squiggly 8),(x,2)(q,x+1) "let" x=7 "in" y arrow.r.squiggly 8),(x,2)tack.r "let" y=x+1 "in let" x=7 "in" y arrow.r.squiggly 8),emptyset tack.r "let" x=2 "in let" y=x+1 "in let" x=7 "in" y arrow.squiggly.r 8) $

Con $E=(x,2)(y,x+1)(x,7)$

Notiamo che otteniamo un risultato diverso, diciamo che lo consideriamo "errato" rispetto a quello che vogliamo. Per questo introduciamo il *lazy con scoping statico*, ci "portiamo dietro" insieme alle variabili da valutare anche l'ambiente in cui dovevamo valutarle in questo modo possiamo comunque calcolarle solo se necessario ma senza subire gli effetti dello scoping dinamico.

Utilizziamo quindi la formula: $ frac(E(x,M,E) tack.r N arrow.r.squiggly v, E tack.r "let" x=M "in" N arrow.r.squiggly v) $

Sviluppiamo l'albero: $ dfrac(dfrac(dfrac(dfrac(dfrac(dfrac(emptyset tack.r 2 arrow.r.squiggly 2, (x,2,emptyset) tack.r x arrow.r.squiggly 2) quad (x,2,emptyset) tack.r 1 arrow.r.squiggly 1,(x,2,emptyset)tack.r x+1 arrow.r.squiggly 3),E(x,7,E)tack.r y arrow.r.squiggly 3),(x,2,emptyset)(y,x+1,(x,2,emptyset)) tack.r "let" x=7 "in" y arrow.r.squiggly 3),(x,2,emptyset) tack.r "let" y=x+1 "in let" x=7 "in" y arrow.squiggly.r 3),emptyset tack.r "let" x=2 "in let" y=x+1 "in let" x=7 "in" y arrow.r.squiggly 3) $

Notiamo che in questo modo otteniamo lo stesso risultato.

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
    title: [*Scoping statico e dinamico*],
    [
        La differenza tra un approccio eager e lazy è che nell'approccio eager le variabili vengono valutate subito mentre nel lazy soltanto se necessario.

        Lo scoping dinamico o statico invece cambia il "con cosa" valutiamo le variabili, nello scoping dinamico lo facciamo con l'ambiente che abbiamo in quel momento mentre con quello statico con l'ambiente "originale" ovvero quello a cui fa riferimento quella parte di espressione.
    ]
)

Per vedere una differenza fra scoping dinamico e statico anche in approcci eager, dobbiamo complicare un po' il linguaggio andando a rendere la semantica e la sintassi più estese. Introduciamo il linguaggio *Fun*.
