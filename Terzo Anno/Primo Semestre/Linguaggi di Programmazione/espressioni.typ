#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *

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
    [Conssideriamo la grammatica: $ M,N ::= 5|7|M+N|M*N $
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
    - $"free"(M+N))="free"(M) union "free"(N)$
    - $"free"("let x = M in N")="free(M)" union {"free(N) - {x}"}$]
)