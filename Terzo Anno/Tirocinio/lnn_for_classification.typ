#import "@preview/zebraw:0.6.3": *
#show: zebraw.with(numbering: false, lang: false)

= Linear Neural Network for Classification

== Softmax Regression
In questa sezione ci concentriamo sui problemi di _classificazione_ ovvero rispondere alla domanda _quale categoria?_

Nel mondo del machine learning la parola _classification_ viene associata a due problemi distinti:
- Assegnare una singola categoria ad un elemento (hard assignment)
- Assegnare in percentuale tutte le categorie ad un elemento (soft assignment)

Questa distinzione non é molto chiara dato che spesso anche quando dobbiamo fare hard assignment vengono usati dei soft. Oppure ci sono casi dove piú categorie sono vere ad esempio un articolo di giornale che copre diversi temi, questo problema prende il nome di *multi-label classification*.

== Classification
Iniziamo con una semplice image classification dove ogni input consiste in un'immagine $2 times 2$ in scala di grigi. Possiamo rappresentare ogni pixel con un singolo scalare ottenendo quindi 4 features $x_1, x_2, x_3, x_4$ e assumiamo che queste immagini appartengano a 4 categorie _"cat", "chicken", "dog"_.

Dobbiamo scegliere come rappresentare le labels e abbiamo due scelte. La piú naturale sarebbe scegliere $y in {1,2,3}$ dove gli interi rappresentano ${"dog", "cat", "chicken"}$. Se le categorie avessero un ordine allora avrebbe senso ad esempio trasformare il problema in un _ordinal regression problem_. In generale peró i problemi di classification non hanno le classi ordinate in base a qualcosa. C'é peró un metodo per rappresentare queste classi, il _one-hot encoding_ ovvero un vettore contenente tanti componenti quanti le categorie dove l'elemento corrispondente alla categoria é impostato a $1$ e tutti gli altri a $0$. Nel nostro esempio una label $y$ sará un vettore tridimensionale dove $(1,0,0)$ corrisponde a "cat", $(0,1,0)$ corrisponde a "chicken" e $(0,0,1)$ a "dog".

=== Linear Model
Per stimare la probabilitá di ogni classe abbiamo bisogno di un modello con un numero di output pari al numeri di classi. Per affrontare la classificazione con modelli lineari avremo bisogno di tante funzioni affini quanti sono gli output, in realtá ne serve solo una in meno dato che la categoria finale deve essere la differenza tra $1$ e la somma delle altre categorie. Ogni output corrisponde alla propria funzione affine. Nel nostro caso poiché abbiamo $4$ features e $3$ categorie in output, abbiamo bisogno di $12$ scalari per rappresentare i pesi e di $3$ scalari per rappresentare i bias, ottenendo: $ o_1 &= x_1 w_11 + x_2 w_12 + x_3 w_13 + x_4 w_14 + b_1 \
 o_2 &= x_1 w_21 + x_2 w_22 + x_3 w_23 + x_4 w_24 + b_2 \ o_3 &= x_1 w_31 + x_2 w_32 + x_3 w_33 + x_4 w_34 + b_3 $

Il diagramma corrispondente sará: #align(center, image("/assets/image-95.png", width: 40%))

Utilizziamo infatti sempre un singolo layer e siccome il calcolo di ogni otuput dipende da ogni input, l'output layer puó essere descritto come un _fully connected layer_. Per una notazione piú concisa utilizziamo $bold(o)=bold(W x) + bold(b)$.

=== The Softmax
Supponendo di avere una funzione di loss adatta potremmo teoricamente tentare di minimizzare direttamente la differenza tra l'output del modello $bold(o)$ e le labels $bold(y)$, tuttavia trattare la classificazione come un normale problema di regressione presenta due limiti:
- Gli output $o_i$ non garantiscono di sommare a $1$
- Gli output $o_i$ non sono necessariamente non negativi e non é detto che non superino il valore di $1$.

Questi aspetti rendono il problema molto instabile e sensibile ai valori anomali (outliers). Ci possono essere appunto dei valori che facciano esplodere le probabilitá oltre l'unitá e per questo serve un meccanismo per "comprimere" gli output.

Per fare in modo che i valori siano non negativi e compresi tra $0$ e $1$ si utilizza una funzione esponenziale $P(y=i) prop "exp" o_i$. Questa rispetta il requistio per cui la probabilitá aumenta all'aumentare di $o_i$, é monotona e produce solo valori non negativi. Per fare in modo che la somma di tutte le probabilitá sia esattamente $1$ si divide ciascun valore per la loro somma totale, questo processo é chiamato _normalizzazione_.

Unendo tutti questi passaggi si ottiene la formula della funzione *softmax*: $ hat(y)_i  = ("exp"(o_i)) / (sum_j "exp"(o_j)) $

=== Vectorization
Per migliorare l'efficienza di calcolo, vettoriziamo i calcoli in minibatches. Assumiamo di avere una minibatch $bold(X) in RR^(n times d)$ di $n$ examples con dimensionalitá $d$ (numero di input) con infine $q$ categorie di output. Allora abbiamo che $bold(W) in RR^(d times q)$ e i bias $bold(b) in RR^(1 times q)$. $ bold(O) &= bold(X W) + bold(b) \ bold(hat(Y)) &= "softmax" (bold(O)) $

In questo modo l'operazione principale viene fatto tramite un prodotto matrice-matrice $bold(X W)$, inoltre siccome ogni riga $bold(X)$ rappresenta un example l'operazione di softmax puó essere calcolata _rowwise_: per ogni riga di $bold(O)$ viene calcolata una funzione esponenziale e normalizzate con la somma.

== Loss Function
Adesso che abbiamo uan funzione che mappa le features $bold(x)$ nelle probabilitá $bold(hat(y))$ ci serve un modo per ottimizzare l'accuracy di questo mapping. Ci affideremo alla stima della massima verosimiglianza.

=== Log-Likelihood
Il softmax restituisce un vettore $bold(hat(y))$ che possiamo interpretare come probabilitá condizionate per ogni classe dato un certo input $bold(x)$, quindi $hat(y)_1 = P(y = "cat" | bold(x))$. Supponendo che le label $bold(Y)$ siano rappresentate in formato _one-hot encoding_ possiamo valutare quanto il nostro modello sia coerente con la realtá calcolando la probabilitá complessiva di osservare tutte le etichette del dataset: $ P(bold(Y) | bold(X)) = product_(i=1)^n P(y^((i)) | bold(x)^((i))) $

Questo prodotto si puó fare assumendo che ogni esempio del dataset sia indipendente dagli altri. Massimizzare un prodotto di tantissimi numeri decimali piccolissimi é computazionalmente difficile e rischia di causare problemi di precisione numerica, per ovviare a questo problema si applica il logaritmo negativo e grazie alle proprietá dei logaritmi il prodotto si trasforma in una somma: $ - log P(bold(Y) | bold(X)) = sum^n_(i=1) -log P(y^((i)) | bold(x)^((i))) = sum^n_(i=1) l(bold(y)^((i)), hat(bold(y)))^((i)) $

L'obiettivo di massimizzare la verosimiglianza diventa cosí l'obiettivo equivalente di minimizzare la negative log-likelihood.

A questo punto la loss $l$ diventa: $ l(bold(y), hat(bold(y))) = - sum_(j=1)^q y_j log hat(y)_j $

Dato che il vettore delle labels $bold(y)$ é in formato _one-hot_ tutti i termini della sommatoria si annullano tranne quello corrispondente alla classe corretta, di conseguenza la loss si riduce semplicemente a prendere il logaritmo negativo della probabilitá che il modello ha assegnato alla classe vera: $- log hat(y)_"corretta"$

=== Softmax and Cross-Entropy Loss
Sfruttando le proprietá dei logaritmi e il fatto che per un vettore one-hot la somma delle componenti é pari a $1$, l'espressione iniziale si semplifica in: $ l(bold(y), hat(bold(y))) = log sum_(k=1)^q "exp"(o_k) - sum^q_(j=1) y_i o_j $

Per capire come il modello impara, consideriamo la derivata della loss rispetto a un qualsiasi logit in input $o_j$: $ partial_(o_j) l(bold(y), hat(bold(y))) = ("exp"(o_j)) / (sum^q_(k=1) "exp"(o_k)) - y_j = "softmax"(bold(o))_j - y_j $

Notiamo che la derivata é semplicemente la differenza tra la probabilitá stimata dal modello $(hat(y_j))$ e l'etichetta reale $(y_j)$. Il gradiente é esattamente uguale a quello riscontrato nella regressione lineare dove l'errore é dato dalla stima meno l'osservazione, questo rende il calcolo dei gradienti estremamente rapido e pulito.

== Information Theory Basics
Spieghiamo alcuni termini della teoria dell'informazione utili per comprendere meglio alcuni concetti di deep learning.

=== Entropy
L'idea centrale della teoria dell'informazione é quantificare la quantitá di informazione contenuta nei dati. Questo pone un limite alla nostra capacitá di comprimere i dati. Per una distribuzione $P$, la sua entropia $H[P]$ é definita come: $ H[P]=sum_j - P(j)log P(j) $

Uno dei teoremi fondamentali della teoria dell'informazione afferma che per codificare dati estratti casualmente dalla distribuzione $P$ abbiamo bisogno di almeno $H[P]$ _"nats"_ per codificarli. Un nat é l'equivalente di un bit quando si utilizza un codice con base $e$ anziché base $2$, dunque un nat vale $1/ log(2) approx 1.44 "bit"$. L'entropia misura quindi l'imprevedibilitá o il "contenuto informativo" di una variabile casuale, se un evento é altamente prevedibile allora la sua entropia é bassa, se é molto incerto allora sará alta.

=== Surprisal
Immaginiamo di avere un flusso di dati che vogliamo comprimere, se per noi é sempre facile prevedere il token successivo, allora questi dati sono facili da comprimere. Prendiamo l'esempio estremo in cui ogni token nel flusso assume sempre lo stesso valore. Questo é un flusso di dati molto noioso e soprattutto facile da prevedere. Poiché i token sono sempre gli stessi non dobbiamo trasmettere alcuna informazione per comunicare il contenuto del flusso.

Tuttavia se non riusciamo a prevedere perfettamente ogni evento, potremmo occasionalmente essere sorpresi. La sorpresa é maggiore quando a un evento viene assegnata una probabilitá inferiore. Shannon ha stabilito che $log 1/(P(j))= -log P(j)$ serve a quantificare il grado di _suprisal_ nell'osservare un evento $j$ cha una probabilitá soggettiva $P(j)$. L'entropia definita prima é quindi la _sorpresa attesa_ quando vengono assegnate le giuste probabilitá che corrispondono realmente al processo di generazione dei dati.

=== Cross-Entropy Revisited
Se l'entropy é il livello di sorpresa provato da qualcuno che conosce la vera distribuzione di probabilitá allora cos'é la _cross-entropy_? La cross-entropy da $P$ a $Q$ indicata con $H(P,Q)$ é la surprisal attesa da parte di un osservatore con probabilitá soggettive $Q$ quando osserva dati che sono stati generati secondo le probabilitá $P$. Questa é data da: $ H(P,Q)=sum_j - P(j) log Q(j) $

La cross-entropy piú bassa possibile si ottiene quando $P=Q$, in questo caso la cross-entropy da $P$ a $Q$ é $H(P,P)=H(P)$.

Per capire meglio dobbiamo identificare i ruoli di $P$ e $Q$:
- $P$ é la realtá e rappresenta la vera distribuzione dei dati
- $Q$ é il modello e rappresenta la probabilitá soggettiva stimata dalla rete neurale.

Se la semplice entropia $H(P)$ misura la sorpresa di chi conosce perfettamente la veritá, la cross-entropy $H(P,Q)$ misura quanto viene sorpreso un modello $Q$ di fronte ai dati reali $P$:
- Se il modello $Q$ é imperfetto e fa previsioni sballate, $H(P,Q)$ sará molto alta.
- Man mano che il modello impara e si avvicina alla realtá, la sorpresa diminuisce.
- Il valore minimo assoluto si raggiunge quando il modello riflette perfettamente la realtá $(Q=P)$ e in quel punto la cross-entropy diventa uguale all'entropia naturale dei dati.