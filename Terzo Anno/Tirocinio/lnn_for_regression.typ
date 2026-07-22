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

Quindi date le features di un training set $bold(X)$ e le corrispondenti labels $bold(y)$, l'obiettivo della linear regression è quello di trovare un vettore di pesi $bold(w)$ e il bias $b$ in modo che, date delle nuove feature in input, il modello riesca a predirre la label con l'errore più basso possibile.

Ovviamente non è possibile che il nostro modello riesca a prevedere ogni valore, ci saranno dataset di $n$ examples dove $y^((i))$ non vale esattamente $bold(w)^top bold(x)^((i))+b$ per tutti gli examples. Una principale differenza potrebbe essere ad esempio lo strumento utilizzato per raccogliere i dati.

Adesso, prima di andare a cercare i migliori _parametri_ $bold(w)$ e $b$ del modello ci servono ancora due cose:
- Una metrica per misurare la qualità del modello.
- Una procedura per aggiornare il modello e migliorarne la qualità.

== Loss Function
La _Loss Function_ quantifica la distanza tra il valore target reale e quello predetto dal modello. Tipicamente è un numero non-negativo dove i valori piccoli sono a nostro vantaggio e una loss pari a 0 indica una previsione perfetta. Per i problemi di regression la loss function più comune è la _squared error_. Quando la predizione per l'example $i$ è $hat(y)^((i))$ e la corrispondente label reale è $y^((i))$ allora la squared error è data: $ l^((i))(bold(w),b) = 1/2 (hat(y)^((i)) - y^((i)))^2 $

La divisione $1/2$ non fa realmente differenza ma è comoda dato che poi si va a cancellare quando viene calcolata la derivata.

Vediamo l'adattamento di un modello di linear regression su dati monodimensionali:

#align(center, image("/assets/image-93.png", width: 30%))

Da notare che le grandi differenze fra i valori stimati dal modello e quelli target comportano contributi ancora più grandi alla loss per via della sua forma quadratica, quest'ultima porta si il modello a evitare errori enormi ma potrebbe anche comportare un'eccessiva sensibilità ai dati anomali.

Per misurare la qualità di un modello sul training set basta calcolare la media della loss su quest'ultimo: 

$ L(bold(w), b)=1/n sum^n_(i=1) l^((i)) (bold(w),b) = 1/n sum^n_(i=1) 1/2 (bold(w)^top bold(x)^((i)) + b - y^((i)))^2 $

Quando addestriamo un modello stiamo cercando i parametri $(bold(w)^*, b^*)$ che minimizzano la loss totale in tutti gli examples di training: $ bold(w)^*, b^* = limits("argmin")_(bold(w),b) space L(bold(w), b) $

== Analytic Solution
Rispetto a molti altri problemi, la linear regression si può risolvere in modo molto semplice, possiamo infatti trovare i parametri ottimali applicando una semplice formula. Per prima cosa possiamo includere il bias $b$ nei pesi $bold(w)$ aggiungendo una colonna di tutti $1$ alla design matrix. A questo punto il nostro problema diventa quello di minimizzare la formula $||bold(y) - bold(X w)||^2$, finché la design matrix $bold(X)$ ha rango pieno e quindi nessuna feature è linearmente dipendente dalle altre ci sarà un solo punto critico nella loss e corrisponderà al minimo in tutto il dominio della funzione. Prendiamo quindi la derivata della loss rispetto a $bold(w)$ e minimizziamo a 0: $ partial_bold(w) ||bold(y) - bold(X w)||^2 = 2bold(X)^top (bold(X w) - bold(y)) = 0 "quindi" bold(X)^top bold(y) = bold(X)^top bold(X w) $

Risolvendo per $bold(w)$ la soluzione per il nostro problema di ottimizzazione: $ bold(w)^* = (bold(X)^top bold(X))^(-1) bold(X)^top bold(y) $

Da notare che questa soluzione è unica quando la matrice $bold(X)^top bold(X)$ è invertibile ovvero quando le colonne della design matrix sono linearmente indipendenti.

Inoltre una soluzione semplice come questa non dobbiamo aspettarcela per tutti i problemi che ci ritroveremo ad affrontare.

== Minibatch Stochastic Gradient Descent
La miglior tecnica per ottimizzare i parametri di un modello consiste nel ridurre l'errore in step aggiornando i parametri in modo da diminuire sempre di più la loss function, questo algoritmo è chiamato _gradient descent_. L'applicazione più semplice è quella di calcolare la derivata della loss function che non è altro che la media della loss calcolata su ogni example del dataset, questo procedimento però può risultare estremamente lento dato che per ogni cambiamento dovremmo prima iterare sull'intero dataset.

Possiamo provare a considerare l'idea completamente opposta ovvero aggiornare i pesi ad ogni example, l'algoritmo che otteniamo, il _stochastic gradient descent (SGD)_ può essere si buono anche su grandi dataset ma ha dei lati negativi. Il primo, di calcolo, è che i processori sono molto più veloci a fare operazioni piuttosto che muovere dati nelle memorie, è molto più efficente effettuare una moltiplicazione matrice-vettore piuttosto che tante moltiplicazioni vettore-vettore. Questo significa che è molto più lento processare un example alla volta rispetto a una batch completa. Un altro problema è che alcuni layer del modello, funzionano soltanto quando osserviamo più examples alla volta.

La soluzione sta nel mezzo, invece di prendere una batch intera o un solo example, prendiamo delle _minibatch_. La dimensione di questa dipende da diversi fattori come la quantità di memoria, i layers, la grandezza totale del dataset ecc... Di solito però una potenza di 2 compresa tra 32 e 256 è un buon inizio. Questo ci porta al _minibatch stochastic gradient descent_.

Nella sua forma più semplice, in ogni iterazione $t$, prendiamo una minibatch casuale $cal(B)_t$ con $|cal(B)|$ examples del training set. Calcoliamo poi la derivata della loss rispetto ai pesi del modello. Infine moltiplichiamo la derivata (gradiente) appena ottenuto per un valore positivo $eta$ prestabilito chiamato _learning rate_ e sottraiamo il risultato dai parametri attuali. Possiamo esprimere l'aggiornamento in questo modo: $ (bold(w),b) arrow.l (bold(w),b) - eta/(|cal(B)|) sum_(i in cal(B)_t) partial_(bold(w),b) l^((i))(bold(w),b) $

L'algoritmo esegue quindi:
1. Inizializza i valori dei parametri del modello, di solito in modo casuale.
2. Itera su minibatch casuali del dataset e aggiorna i parametri verso la direzione negativa del gradiente.

Dato che prendiamo una minibatch $cal(B)$ dobbiamo normalizzare per la sua grandezza $|cal(B)|$. Di solito la grandezza della minibatch e il learning-rate sono prestabili dall'utente, questi parametri che non vengono modificati durante il training si chiamano _hyperparameters_. Possono essere comunque ottimizzati attraverso diverse tecniche come la Bayesian optimization. Infine, la qualità del modello ottenuto viene misurata su un set di dati separato e mai visto dal modello chiamato _validation set_.

Dopo aver allenato il modello per un determinato numero di iterazioni, salviamo i parametri del modello che in questo caso denotiamo con $bold(hat(w)), hat(b)$. Da notare che anche se la nostra funzione è completamente lineare, questi parametri non saranno gli esatti minimizzatori della loss function e non saranno nemmeno deterministici.

In generale il problema principale del deep learning non è trovare parametri ottimali per il dataset di training ma trovare dei parametri ottimiali che forniscano buoni risultati su dati mai visti prima, questo è il problema della _generalizzazione_.

== Predictions
Dato il modello $bold(hat(w))^top bold(x) + hat(b)$ possiamo iniziare a fare previsioni su nuovi example. Nel deep learning di solito questa fase si chiama _inferenza_ ma in realtà è un termine un po' improprio dato l'inferenza si riferisce a una qualsiasi conclusione raggiunta sulla base di prove, inclusi sia i valori dei parametri sia l'etichetta probabile per un'istanza non vista. Nella letteratura statistica l'inferenza fa riferimento all'inferenza dei parametri, per evitare confusione la chiameremo "previsione".

== Vectorization for Speed
Quando addestriamo il modello vorremmo processare minibatches in modo simultaneo, per farlo abbiamo bisogno di vettorizzare i calcoli e sfruttare librerie di algebra lineare veloci invece di scrivere dei semplici loop in Python. Per vedere l'impatto di questo consideriamo due metodi per sommare vettori, per prima cosa inizializziamo due vettori da $10.000$ elementi, come primo metodo facciamo un loop sui vettori.

```python 
n = 10000
a = torch.ones(n)
b = torch.ones(n)
```

Adesso possiamo verificare i tempi andando a fare la somma con il primo metodo:

```python 
c = torch.zeros(n)
t = time.time()
for i in range(n):
    c[i] = a[i] + b[i]
f'{time.time() - t:.5f} sec'

# Output
# '0.17802 sec'
```

Se invece utilizziamo l'operatore `+`:

```python 
t = time.time()
d = a + b
f'{time.time() - t:.5f} sec'

# Output
# '0.00036 sec'
```

Il secondo metodo è estremamente più veloce, questo infatti somma uno ad uno gli elementi in modo parallelo.

== Linear Regression as a Neural Network
Le reti neurali sono abbastanza potenti da comprendere i modelli lineari e rappresentarli come reti dove ogni feature è rappresentata da un neurone di ingresso e sono tutti collegati in modo diretto all'output. Quindi: #align(center, image("/assets/image-94.png", width: 40%))

Gli input sono $x_1, dots, x_d$, ci riferiamo a $d$ come numero di inputs oppure la dimensione delle features nel layer di input, l'output è $o_1$ ed è uno soltanto dato che stiamo provando a prevedere un solo valore. Dato che il neurone calcolato è soltanto uno e gli altri sono tutti dati possiamo pensare alla linear regression come una fully connected linear network.