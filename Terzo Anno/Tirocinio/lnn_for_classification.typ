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

= Generalization in Classification
Finora ci siamo concentrati su come risolvere problemi di classificazione addestrando reti neurali lineari con diversi output e una funzione softmax. Interpretando gli output del nostro modello come previsioni probabilistiche abbiamo motivato e derivato la cross-entropy loss function che calcola la negative log likelihood che il nostro modello assegna alle labels. Ricordiamo che il nostro obiettivo rimane quello di imparare pattern generali da dati che non abbiamo mai visto prima, un'accuracy alta sul set di addestramento non significa nulla. Ogni volta che il nostro input è unico possiamo raggiungere un'accuratezza perfetta memorizzando il set di dati durante la prima epoca di addestramento e successivamente cercando l'etichetta ogni volta che vediamo una nuova immagine però, memorizzare le etichette degli esempi di addestramento non ci dice come classificare nuovi esempi, in assenza di ulteriori indicazioni potremmo dover ricorrere a ipotesi casuali ogni volta che incontriamo nuovi esempi.

Dobbiamo porci delle domande:
1. Quanti esempi di test ci servono per ottenere una buona stima dell'accuracy del nostro classificatore?
2. Cosa succede se continuiamo a valutare i modelli sullo stesso test set più volte?
3. Perchè dovremmo aspettarci che l'adattamento del modello lineare al set di training dia risultati migliori rispetto al nostro schema di memorizzazione?

Scopriremo che la statistica ci garantisce per molti modelli che questi funzioneranno sui dati futuri prima ancora di addestrarli:
- $epsilon$ è il massimo errore di differenza tollerato tra le prestazioni del modello sui dati di addestramento e le prestazioni nel mondo reale.
- $n$ è la dimensione del dataset. La teoria afferma che fissato $epsilon$ è possibile calcolare esattamente di quanti dati $n$ abbiamo bisogno per garantire matematicamente che l'errore del modello rimanga entro quel margine, a prescindere da quale sia il dominio o la distribuzione dei dati.

Sfortunatamente però si scopre che sebbene questo tipo di garanzie sono molto limitate nella pratica del deep learning, perché servirebbe comunque un numero assurdo di esempi (trilioni o più) anche quando riscontriamo che in molti compiti che ci interessano le reti neurali profonde generalizzano bene anche con molti menso esempi, nell'ordine delle migliaia.

Per questo chi sviluppa reti neurali:
- Rinuncia alle garanzie matematiche iniziali.
- Utilizza architetture, iperparametri e tecniche di regolarizzazione che in passato hanno funzionato su problemi simili.
- La validità e capacità di generalizzazione del modello vengono provate solo dopo o durante l'addestramento misurando direttamente le prestazioni su un set di validazione o test nascosto.

== The Test Set
Vogliamo capire quanto deve essere grande il test set per essere certi che l'errore misurato sia davvero affidabile.

Supponiamo di avere un classificatore $f$ e un set di test $cal(D)={(x^((i)), y^((i)))}^n_(i=1)$ mai visto durante l'addestramento. L'errore empirico $epsilon_cal(D) (f)$ è la percentuale di errori commessa dal modello sul nostro dataset di test $cal(D)$: $ epsilon_(cal(D)) (f) = 1/n sum^n_(i=1) 1(f(x^((i))) eq.not y^((i))) $

Abbiamo poi l'errore di popolazione $epsilon (f)$ ovvero l'errore reale atteso se applicassimo il modello all'intera popolazione ideale di dati possibili $P(X,Y)$: $ epsilon(f) = E_((x,y)approx P) 1 (f(x)eq.not y) $

Siccome non possiamo misurare la popolazione intera usiamo l'errore empirico come stimatore statistico dell'errore reale.

Il teorema del limite centrale ci dice che la media campionaria converge verso il valore reale a una velocità proporzionale a $cal(O)(1/sqrt(n))$, questo implica una regola fondamentale sulla dimensione del test set:
- Per raddoppiare la precisione sulla stima dell'errore dobbiamo moltiplicare per $4$ la dimensione del test set.
- Per ridurre l'incertezza di un fattore $100$ dobbiamo raccogliere $10.000$ volte più dati di test.

Ma di quanti ne abbiamo bisogno nella pratica? Ogni singola predizione è una variabile di Bernoulli: vale $1$ (errore) o $0$ (corretto), la varianza di una distribuzione Bernoulli è $sigma^2=epsilon.alt (f)(1- epsilon.alt(f))$ ed è massima quando la percentuale di errore è del $50% (epsilon.alt = 0.5)$ dove $sigma^2=0.25$. Da questo valore possiamo calcolare la deviazione standard massima della stima dell'errore $sqrt(0.25 / n)$. Applicando la regola dell'intervallo di confidenza:
1. Margine di $plus.minus 0.01$: Servono circa $2.500$ campioni
2. Confidenza al $95%$: Per garantire che l'errore misurato sia entro $plus.minus 0.01$ dall'errore reale con il $95%$ di confidenza risolviamo l'equazione $2 dot sqrt(0.25 / n)=0.01$ ottenendo $n=10.000$ campioni. Per questo in molti dataset famosi abbiamo appunto $10.000$ campioni.

Il Teorema del Limite Centrale è un risultato asintotico ovvero vale per $n arrow.r infinity$, per avere una garanzia matematica rigorosa valida anche su un numero finito di dati $n$ si applica la *Disuguaglianza di Hoeffding*: $ P(epsilon.alt_cal(D) (f) - epsilon.alt (f) gt.eq t) < "exp"(-2 n t^2) $

Impostando un margine $t=0.01$ e chiedendo una confidenza del $95%$ la formula indica che servono circa $15.000$ campioni.

== Test Set Reuse
Immaginiamo di avere un modello $f_1$, abbiamo usato il validation set per gli iperparametri e infine misurato l'errore reale su un test incontaminato. Successivamente scriviamo un nuovo modello $f_2$ con un diverso approccio, lo addestriamo e scegliamo i valori in base al validation set e vediamo che supera $f_1$. Ora possiamo valutare $f_2$ sul test set ma _matematicamente parlando_ non abbiamo più un test set valido.

Il primo problema è che quando valutiamo un singolo classificatore $f$ la statistica garantisce un intervallo di confidenza al $95%$ il che significa che c'è solo un $5%$ di probabilità che il risultato sia dovuto al caso. Se però iniziamo a valutare $k$ modelli differenti sullo stesso identico test set:
- La probabilità che almeno uno di questo ottenga un punteggio buono solo per pura fortuna cresce enormemente.
- Con 20 modelli valutati sullo stesso test set è quasi matematicamente certo che uno di essi mostrerà prestazioni sopravvalutate rispetto alla realtà.
- Questo fenomeno porta al problema della _false discovery_.

Il secondo problema è l'_Adaptive Overfitting_ ovvero:
- Tutte le garanzie matematiche viste precedentemente si basano sull'assunzione fondamentale che il modello sia stato scelto senza alcun contatto da parte del test set.
- Quando selezioniamo il modello $f_2$ dopo aver visto le prestazioni di $f_1$ sul test set, l'informazione contenuta nel test set è indirettamente trapelata nella mente del ricercatore.
- Questo fenomeno si chiama _Adaptive Overfitting_, il test set ha perso la sua neutralità e cessa di essere una misura imparziale del mondo reale.

Come ci si difende? Ci sono dei consigli pratici da seguire come consultare il test set il meno frequentemente possibile. Più il dataset è piccolo più bisogna essere rigidi. Nelle competizioni o nei progetti reali la prassi migliore è declassare il vecchio test set a semplice set di validazione ed estrarre un test set completamente nuovo per la valutazione finale.

== Statistical Learning Theory
Spesso i soli test set empirici ci lasciano insoddisfatti per due motivi:
- Raramente siamo i primi ad usare un test set quindi qualcuno ha già valutato i propri modelli su quel test set rendendolo di fatto parzialmente compromesso.
- Un test set ci dice soltanto a posteriori se un singolo modello ha funzionato ma non ci offre garanzie matematiche a priori sul perché un'intera classe di modelli dovrebbe funzionare.

Per colmare questo spazio nasce la *Statistical Learning Theory*, l'obiettivo principale è porre un limite superiore al divario di generalizzazione mettendo in relazione le proprietàa strutturali del modello con il numero di dati disponibili $n$.

C'è una differenza fondamentale tra valutare un modello fisso e addestrarne uno. Il modello fisso $f$ è facile da valutare su dati nuovi infatti l'errore sul test set è una stima non distorta dell'errore reale. Quando invece addestriamo un modello $f_S$ stiamo scegliendo una specifica funzione $f_S$ all'interno di uno spazio di funzioni possibili $cal(F)$. Poiché i parametri di un modello sono continui, questo spazio contiene un numero infinito di modelli $(|cal(F)| = infinity)$. Quando valutiamo un'intera famiglia di modelli infiniti sui dati di addestramento $cal(S)$ c'è un forte rischio di sceglierne uno che ottiene un valore di errore bassissimo sul training solo per puro caso e che poi si rivelerà un disastro nel mondo reale.

Affrontiamo ora il concetto di *Convergenza Uniforme*. Vogliamo dimostrare che con un'alta probabilità $(1 - delta)$, l'errore empirico di TUTTI i modelli presenti nella classe $cal(F)$ converga simultaneamente al loro errore reale nel mondo reale, entro un piccolissimo margine $alpha$. Tuttavia questo principio fallisce se la classe dei modelli è "troppo flessibile". Ci sono macchine che memorizzano tutto il training set e otterranno un errore empirico pari a $0$ ma sui dati reali nuovi avrà un errore altissimo.

- I modelli troppo flessibili (Alta Varianza) si adattano perfettamente al training set ma rischiano un gravissimo overfitting.
- I modelli troppo rigidi (Altro bias) generalizzano bene ma rischiano di non imparare nulla (underfitting).

La teoria dell'apprendimento cerca di misurare matematicamente dove si colloca un modello lungo questo spettro.

Utilizziamo la *Dimensione VC*, una misura formale della "complessità" o "flessibilità" di una classe di modelli. Questa è il numero massimo di punti dati che una classe di modelli può _shatterare_ ovvero la capacità del modello di separare o etichettare quei puntini in qualsiasi modo arbitrario possibile.
Ad esempio un modello lineare in $d$ dimensioni ha una dimensione VC pari a $d+1$. Nel piano $2D (d=2)$ una retta può separare qualsiasi combinazione di etichette per 3 punti, ma non per 4 punti, quindi la dimensione VC di una retta in 2D è 3. Uno dei contributi fondamentali è un limite tra la differenza fra errore empirico ed errore reale come funzione della VC dimension e il numero di sample: $ P(R[p,f] - R_"emp"[bold(X),bold(Y),f] < alpha) gt.eq 1 - delta "for" alpha gt.eq c sqrt(("VC" - log delta) / n) $

Dove:
- $R[p,f]$ errore reale
- $R_"emp"$ errore empirico sul dataset di addestramento
- $alpha$ il margine massimo del divario di generalizzazione
- $1- delta$ la probabilità di confidenza
- $n$ il numero di examples
- $"VC"$ la dimensione VC del modello
- $c$ una costante positiva dipendente dal tipo di loss

La formula dimostra che l'errore decade alla classica velocità $cal(O)(1/sqrt(n))$ tuttavia la teoria VC risulta drammaticamente troppo pessimista per le reti neurali moderne. Le reti neurali profonde hanno una dimensione VC enormemente alta, se applicassimo rigorosamente la formula servirebbero trilioni di dati per spiegare la loro generalizzazione. Eppure, nella pratica le reti neurali riescono a generalizzare bene anche con molti meno dati, questo rimane uno dei grandi misteri e ancora aperti del deep learning moderno.

= Environment and Distribution Shift
Fino ad ora abbiamo trattato i problemi di apprendimento assumendo che i dati di addestramento e i dati di test venissero estratti dalla stessa distribuzione di probabilità (IID). Tuttavia quando applichiamo i modelli nel mondo reale questa assunzione cade quasi sempre. I modelli vengono addestrati su dati passati per fare predizioni sul futuro oppure vengono sviluppati in un determninato ambiente e distribuiti in contesti completamente diversi. Comprendere come cambia l'ambiente e come la distribuzione dei dati si modifica nel tempo è fondamentale per progettare sistemi di machine learning robusti.

Formalmente indichiamo con $X$ le variabili di input e con $Y$ le variabili target. La distribuzione congiunta dei dati è espressa da $P(X,Y)$. Attraverso le regole della probabilità condizionata, possiamo scomporre $P(X,Y)$ in due modi equivalenti: $ P(X,Y)=P(Y | X) P(X) = P(X|Y) P(Y) $

Un *cambio di distribuzione* si verifica quando la distribuzione dei dati di addestramento $P_"train" (X,Y)$ differisce da quella di test $P_"test" (X,Y)$, esistono 3 casi principali: