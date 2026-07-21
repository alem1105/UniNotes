#import "@preview/zebraw:0.6.3": *
#show: zebraw.with(numbering: false, lang: false)

= Linear Neural Networks for Regression
I problemi di _regression_ sono quei problemi dove vogliamo fare una previsione di un valore numerico come ad esempio un prezzo. Come esempio prendiamo appunto quello di voler stimare il prezzo di una casa in base alla sua dimensione ed età. Per sviluppare un modello in grado di fare questo abbiamo bisogno di dati, un machine learning il dataset prende il nome di _training set_ dove ogni riga si chiama _example_ e quello che vogliamo indovinare _label_. Le variabili su cui si basa la previsione prendono il nome di _features_.

== Basics
La _Linear Regression_ è uno dei problemi più semplici e popolari nei problemi di regression. La prima assunzione che si fa è che la relazione fra le featurex $bold(x)$ e la label $y$ sia principalmente lineare, ovvero che il valore atteso $E[Y | X= bold(x)]$ può essere espresso come una somma pesata delle features $bold(x)$. Indichiamo con $n$ il numero di examples del nostro dataset, ed usiamo indici in alto per indicare il numero di example o label e indici in basso per numerare le feature di un example. Quiondi $bold(x)^i$ indica l'$i$-esimo example e $x_j^((i))$ indica la sua $j$-esima feature.

== Model
Con l'assunzione fatta prima sulla linearità abbiamo detto che il valore atteso del prezzo può essere espresso come somma pesata delle features: $ "price" = w_"area" dot "area" + w_"age" dot "age" + b $

Dove $w_"area"$ e $w_"age"$ sono chiamati _weights_ e $b$ _bias_. I pesi determinano l'influenza di ogni feature sulla nostra predizione, il bias determina il valore della predizione quando tutte le features sono a zesro. Anche se non è praticamente possibile avere ad esempio una casa con area uguale a 0 abbiamo comunque bisogno di un bias che ci permette di esprimere tutte le funzioni lineari delle nostre features.

Dato un dataset quindi il nostro obiettivo è quello di scegliere i giusti pesi $bold(w)$ e il biasi $b$ in modo che, in media, il modello faccia giuste predizioni.

In machine learning lavoreremo spesso con dataset di grandi dimensioni dove conviene utilizzare notazioni algebriche più compatte. Quando il nostro input consiste di $d$ features assegnamo un index a ciascuna ed esprimiamo la nostra predizione $hat(y)$ come: $ hat(y) = w_1 x_1 + dots + w_d x_d + b $

Raccogliendo tutte le features in un vettore $bold(x) in RR^d$ e tutti i pesi in un altro vettore $bold(w) in RR^d$ possiamo esprimere il modello in modo più compatto: $ hat(y) = bold(w)^top bold(x) + b $

In questo caso il vettore $bold(x)$ corrisponde alle features di un singolo example. Spesso ci conviene fare riferimento alle features dell'intero dataset di $n$ examples tramite la _design matrix_ $bold(X) in RR^(n times d)$, in quest'ultima ogni riga rappresenta un example e ogni colonna una feature. Per una collezione di features $bold(X)$, la predizione $bold(hat(y)) in RR^n$ può essere espressa tramite il prodotto matrice-vettore: $ bold(hat(y)) = bold(X w) + b $