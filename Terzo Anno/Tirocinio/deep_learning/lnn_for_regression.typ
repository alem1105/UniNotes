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

= Generalization
Per capire meglio questo concetto immaginiamo due studentesse che devono prepararsi per un esame, Ellie ha una memoria incredibile e riesce a ricordare praticamente ogni domanda di ogni esame passato ma questo significa che potrebbe comunque bloccarsi su una nuova domanda mai vista prima. Irenre invece non riesce a ricordare nulla ma è bravissima a trovare schemi ricorrenti. Se l'esame consistesse veramente in solo domande riciclate allora Ellie supererebbe facilmente Irene, infatti anche se quest'ultima ottenesse un buonissimo 90% andrebbe comunque a perdere contro il 100% di Ellie, se però l'esame consistesse interamente in domande nuove allora Irene manterrebbe comunque il suo punteggio del 90% mentre Ellie fallirebbe completamente.

Il nostro obiettivo è quello di trovare dei pattern, ma come siamo sicuri di averne trovato uno invece di aver memorizzato tutti i dati di addestramento? Non abbiamo bisogno di prevedere i prezzi delle azioni di ieri o riconoscere malattie già diagnosticate, dobbiamo trovare pattern in situazioni mai viste prima. Questo problema della generalizzazione è il problema fondamentale del machine learning e di tutta la statistica.

Il fenomeno in cui l'adattamento risulta più vicino al training set che alla distribuzione sottostante è chiamato _overfitting_ e le tecniche per contrastarlo sono chiamate _regularization methods_.

== Training Error and Generalization Error
In un ambiente standard assumiamo che training set e test set siano presi in modo indipendente dalla stessa distribuzione, questa di solito viene chiamata _IID Assumption_. Da notare che senza questa assunzione non andremmo da nessuna parte, infatti per quale motivo dei dati presi da una distribuzione $P(X,Y)$ dovrebbero dirci come fare previsioni su dati generati da una diversa distribuzione $Q(X,Y)$? Per fare questi passaggi è necessario formulare ipotesi solide su come le due distribuzioni siano collegate. Prima però basiamoci sula caso in cui sono uguali ovvero nella IID.

Iniziamo distinguendo il _training error_ $R_"emp"$ che è calcolato sul training set e il _generalization error_ $R$ che invece è quello che ci aspettiamo dalla distribuzione. Possiamo vedere il generalization error come quello che vedremmo se applichiamo il nostro modello ad una sequenza infinta di dati presi dalla stessa distribuzione. Formalmente il training error è espresso come una somma: $ R_"emp" [bold(X \, y),f] = 1/n sum_(i=1)^n l(bold(x)^((i)), y^((i)), f(bold(x)^((i)))) $

Mentre il generalization error è espresso come un integrale: $ R[p,f]=E_((bold(x),y)tilde.op P) [l(bold(x),y,f(bold(x)))] = integral integral l(bold(x),y,f(bold(x))) p(bold(x),y) d bold(x) d y $

Non possiamo mai calcolare esattamente il generalization error $R$, nessuno infatti ci dirà mai la forma precisa della funzoine di densità $p(bold(x),y)$. Inoltre, non possiamo esaminare una sequenza infinita di dati. Nella pratica quindi dobbiamo fare una stima del generalization error applicando il nostro modello su un test set indipendente su una collezione di esempi $bold(X')$ e di labels $bold(y)'$ che non sono presenti nel dataset.

== Model Complexity
Di solito quando lavoriamo con tanti dati, il training e il generalization error tendono ad essere simili, quando però lavoriamo con modelli più complessi o con pochi examples ci aspettiamo che il training error scenda ma il generalization error sia abbastanza distante o che salga e questo non ci deve sorprendere. Immaginiamo un modello che, per ogni dataset di $n$ esempi, riesce a trovare un set di parametri che si adattano perfettamente alle labels anche se assegnate in modo randomico, in questo caso anche se il modello si comporta benissimo nel training come possiamo capire qualcosa sul generalization error? Per quel che sappiamo il generalization error potrebbe anche essere peggiore di sparare a caso.

In generale, in assenza di restrizioni sul modello, basandoci soltanto su come il modello si è adattato al training set non possiamo concludere che abbia trovato un pattern generalizzabile.

Quando un modello è in grado di riconoscere delle labels, un basso training error non implica obbligatoriamente anche un basso generalization error ma nemmeno un alto generalization error. Le reti neurali profonde non ci permettono di trarre conclusioni basandoci esclusivamente sull'errore di addestramento, in questi casi dobbiamo fare maggiore affidamento sull'errore di validazioni ovvero quello calcolato su altri examples rispetto al training.

== Underfitting or Overfitting
Quando compariamo training e validation error dobbiamo stare attenti a due situazioni particolari. Per prima cosa vogliamo vedere se i due errori sono abbastanza grandi ma c'è una leggera differenza fra i due. Se il nostro modello non riesce a ridurre il training error allora il modello è troppo semplice per riuscire a individuare un pattern, inoltre, dato che il gap tra training e generalization error è piccolo significa che possiamo usare un modello più complesso per ottenere risultati migliori. Questo fenomeno prende il nome di *underfitting*.

Per seconda cosa vogliamo controllare se il training error è decisamente inferiore del validation error, questo indica *overfitting*. Da notare che l'overfitting non è sempre una brutta cosa. Soprattutto nel deep learning, i migliori modelli ottengono spesso risultati superiori nel training rispetto alla validazione. Il nostro obiettivo finale è solamente che l'errore di generalizzazione sia basso, se poi c'è un gap con l'errore di addestramento non ci interessa, a meno che questo gap non sia talmento alto da non permettere una discesa dell'errore di validazione. Da notare che se l'errore di addestramento è zero allora il gap di generalizzazione è esattamente uguale all'errore di generalizzazione e quindi l'unico modo per ridurlo è ridurre il gap attraverso tecniche specifiche.

== Model Selection
Di solito scegliamo il nostro modello finale soltanto dopo aver valutato diversi modelli, questo passo è chiamato appunto _model selection_.

Non dovremmo toccare il nostro set di test finché non abbiamo scelto gli hyperparameters, infatti se dovessimo usare il test set durante la scelta del modello rischiamo di andare in overfitting. Infatti andare in overfitting nel training non è un problema dato che abbiamo poi la valutazione che ci garantisce affidabilità, ma se overfittiamo i dati di test non ce ne accorgeremmo.

Non dobbiamo quindi mai basarci sui dati di test per la scelta del modello, ma non possiamo nemmeno affidarci soltanto a quelli di training perché non siamo in grado di stimare l'errore di generalizzazione su questi. Nelle applicazioni pratiche la questione è ancora più confuso, infatti dovremmo utilizzare i dati di test una sola volta per valutare il modello migliore o per confrontare un numero limitato di modelli ma nella realtà i dati di test raramente vengono scartati dopo un solo utilizzo.

La prassi è quella di dividere il dataset in tre parti, includendo un set di validazione oltre al set di addestramento e di test. Il risultato è che la differenza tra set test e validation è molto ambigua, per questo spesso si utilizza soltanto training e validation.

== Cross-Validation
Quando i dati per l'addestramento sono pochi non siamo in grado di separare abbastanza dati per creare un buon validation set. Una soluzione comune è il $K-"fold cross-validation"$ dove il training set viene diviso in $K$ sottoinsiemi con nessun elemento in comune, poi l'addestramento e la valutazione vengono effettuati $K$ volte, ogni volta addestrando su $K-1$ sottoinsiemi di training e valutando su l'ultimo sottoinsieme che viene preso come validation. Infine, l'errore di training e validation sono stimati facendo la media dei $K$ risultati.

= Weight Decay
Dato che abbiamo introdotto il problema dell'overfitting, possiamo introdurre la prima _regularization technique_. Ricordiamo però che possiamo sempre ridurre l'overfitting aggiungendo più dati di addestramento ma ovviamente potrebbe richiedere tanto tempo o spesa oppure potrebbe essere impossibile in determinati casi. Assumiamo quindi di avere già abbastanza dati e di qualità.

Una prima tecnica è quella di limitare il numero di feature, tuttavia limitarsi a scartare feature è un metodo troppo grossolano.

== Norms and Weight Decay
Invece di manipolare il numero di parametri, il weight decay si basa sul restringere i valori che i parametri possono prendere. Viene anche chiamata $l_2$ regularization fuori dal mondo del deep learning. La tecnica si basa sul fatto che fra tutte le funzioni $f$, la funzione $f=0$ è la più semplice, possiamo quindi misurare la complessità di una funzione in base alla distanza dei suoi parametri da zero. Ma quanto precisi dobbiamo essere mentre misuriamo questa distanza? Non c'è una risposta giusta.

Una semplice interpretazione potrebbe essere quella di misurare la complessità di una funzione lineare $f(bold(x))=bold(w)^top bold(x)$ con qualche norma dei suoi pesi, ad esempio $||bold(w)||^2$. Il metodo più comune per garantire che il vettore dei pesi sia di piccole dimensioni consiste nell'aggiungere la sua norma come termine di penalizzazione al problema di minimizzazione della loss. Il nostro obiettivo quindi non è più quello di minimizzare la prediction loss sulle training labels ma minimizzare la somma della prediction loss e il penalty term. A questo punto se il vettore dei pesi cresce troppo, l'algoritmo di apprendimento potrebbe concentrarsi sul minimizzare la norma dei pesi piuttosto che minimizzare l'errore di training e questo è esattamente quello che vogliamo. Significa infatti che l'algoritmo si trova costretto a fare un compromesso:
- Se tenta di abbassare troppo l'errore nel training ingrandendo i pesi allora la norma diventa alta.
- L'algoritmo allora preferirà accettare un errore di training leggermente più alto pur di mantenere i pesi piccoli e contenuti. La loss originariamente l'avevamo espressa come: $ L(bold(w),b) = 1/n sum_(i=1)^n 1/2 (bold(w)^top bold(x)^((i)) + b - y^((i)))^2 $

Dove ricordiamo che: $bold(x)^((i))$ sono le features, $y^((i))$ sono le label di ogni example $i$ e $(bold(w),b)$ sono i pesi e il bias. Per penalizzare il vettore dei pesi dobbiamo aggiungere $||bold(w)||^2$ alla loss, ma come fa il modello a bilanciare la loss standard con questa nuova penalità? Lo facciamo tramite la _regularization constant_ $lambda$, un hyperparameter non negativo il cui valore ottimale viene scelto valutando le prestazioni sul set di validazione. La nuova funzione diventa quindi: $ L(bold(w),b)+ lambda / 2 ||bold(w)||^2 $

In questo modo otteniamo:
- Se $lambda = 0$ la penale si azzera e si torna alla funzione di loss originale.
- Se $lambda gt 0$ stiamo imponendo un vincolo che forza la magnitudo di $||bold(w)||$ a rimanere contenuta, più grande è $lambda$ e più severa sarà la penalità per pesi grandi. Si eleva al quadrato sempre per semplicità algebrica per il calcolo delle derivate.

Perché si sceglie la norma $l_2$, e non ad esempio la $l_1$? Differenze comportamentali:
- La norma $l_2$ eleva al quadrato ogni singolo peso $w_j$, di conseguenza assegna una penalità sproporzionalmente alta ai pesi di grande valore. In questo modo spinge l'algoritmo ad evitare singoli pesi giganti e a distribuire il carico in modo uniforme. Inoltre rende il modello più robusto, se una singola variabile in input contiene rumore o un errore di misurazione, il suo impatto sul risultato sarà limitato perché il peso associato a questa è piccolo.
- La norma $l_1$ penalizza i pesi in modo proporzionale al loro valore assoluto senza accentuare i valori grandi. Questo porta i pesi ad azzerarsi completamente e il modello concentra tutta la sua capacità solo su un piccolo sottoinsieme di feature. Il vantaggio è che funziona come un meccaniscmo automatico di selezione delle variabili, se un peso diventa zero allora quella specifica feature non serve più per fare la predizione e questo permette di risparmiare memoria, calcolo e risorse nella fase di raccolta, archiviazione o trasmissione dei dati futuri.

La formula con minibatch stochastic gradient descent con regolarizzazione $l_2$ diventa quindi: $ bold(w) arrow.l (1-eta lambda) bold(w) - eta / (|cal(B)|) sum_(i in cal(B)) bold(x)^((i)) (bold(w)^top bold(x)^((i)) + b - y^((i))) $

Notiamo che i termini dell'equazione sono:
- $(1 - eta lambda) bold(w)$: sia $eta$ che $lambda$ sono numeri piccoli e positivi e quindi questo termine è un numero leggermente inferiore a $1$, ad ogni passo di addestramento il peso viene prima "ristretto" ovvero moltiplicato per questo numero.
- Il resto è la classica correzione basata sull'errore commesso dal modello.

Si chiama weight decay perché se azzeriamo l'errore del modello sui dati allora l'aggiornamento dei pesi sarebbe soltanto $ bold(w) arrow.l (1 - eta lambda) bold(w) $

E questo significa che i pesi decadrebbero esponenzialmente verso lo zero ad ogni iterazione.

Notiamo che per il bias $b$ non viene fatta nessuna penalizzazione, questo perché sono i pesi che controllano la pendenza e la reattività delle singole variabili di input e causare quindi overfitting se troppo grandi, il bias invece sposta semplicemente la funzione in alto o in basso e non aggiunge oscillazioni al modello.

Infine notiamo che la $l_2$ regularization e il weight decay potrebbero non essere perfettamente eqeuivalenti per altri algoritmi di ottimizzazione.
- Nella SGD aggiungere $||bold(w)||^2$ alla loss o moltiplicare i pesi per $(1-eta lambda)$ produce la stessa identica operazione matematica.
- Con ottimizzatori più complessi però questo non è vero, ad esempio con _Adam_. Infatti esistono varianti come _AdamW_ che utilizzano anche il weight decay.