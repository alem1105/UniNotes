#import "@preview/zebraw:0.6.3": *
#show: zebraw.with(numbering: false, lang: false)
#import "@preview/showybox:2.0.4": showybox

= Convolutional Neural Networks
Le immagini, come informazione, sono rappresentate da griglie bidimensionali di pixel, sia che questa sia monocolore o a colori. Di conseguenza, ogni pixel corrisponde rispettivamente a uno o più valori numerici. Finora abbiamo ignorato questa struttura e trattato le immagini come vettori numerici non sfruttando quindi la relazione spaziale tra i pixel. Questo approccio era però necessario per usare gli MLP. Poiché queste reti sono invarianti rispetto all'ordine delle caratteristiche potevamo ottenere risultati simili indipendentemente dal fatto che conservassimo un ordine corrispondente alla struttura spaziale dei pixel o che permutassimo i parametri della MLP. Vorremmo invece sfruttare la nostra conoscenza a priori secondo cui i pixel vicini sono tipicamente correlati tra loro in modo da costruire modelli efficienti per l'apprendimento dei dati dalle immagini.

Vediamo quindi le _Convolutional Neural Networ (CNN)_, una potente famiglia di reti neurali progettate proprio per questo scopo.

Le moderne CNN devono il loro design a spunti tratti dalla biologia, dalla teoria dei gruppi e a una buona dose di sperimentazione pratica. Oltre alla loro efficienza nella realizzazione di modelli, le CNN sono anche efficienti dal punto di vista computazionale, sia perchè richiedono un numero inferiore di parametri rispetto alle fully connected, sia perchè le convoluzioni sono facili da parallelizzare tra i core delle GPU. Di conseguenza gli esperti applicano le CNN ogni volta che è possibile.

== From Fully Connected Layers to Convolutions
Ad oggi, i modelli di cui abbiamo parlato finora sono buoni quando abbiamo a che fare con dati tabulari ovveri dati costituiti da righe corrispondenti agli esempi e colonne per le features. Con i dati tabulari, potremme prevedere che i modelli che cerchiamo possano comportare interazioni tra le features, ma non ipotizziamo a priori alcuna struttura relativa al modo in cui le features interagiscono. Tuttavia per i dati percettivi ad alta dimensionalità, tali reti prive di struttura possono diventare difficili da gestire.

Ad esempio, tornando all'esempio sulla distinzione fra gatti e cani, supponiamo di svolgere un grande lavoro nella raccolta dei dati ottenendo un set di dati annotatno composto da fotografie da un megapixel, quindi ogni input della rete ha un milione di dimensioni. Anche una riduzione a mille dimensioni nascoste richiederebbe un fully connected layer da $10^6 times 10^3 = 10^9$ parametri. A meno che non si disponga di numerose GPU super ottimizzate, l'apprendimento dei parametri potrebbe essere irrealizzabile.

Si potrebbe pensare che non è necessaria una risoluzione di un Megapixel, tuttavia sebbene potremmo cavarcela con centomila pixel, il nostro hidden layer di dimensione $1000$ sottostima il numero di unità nascoste necessarie per apprendere buone rappresentazioni delle immagini, quindi un sistema pratico richiederà comunque miliardi di parametri. Inoltre, l'apprendimento di un classificatore mediante l'adattamento a cosí tanti parametri potrebbe richiedere la raccolta di un enorme set di dati. Oggi però sappiamo che i computer li distinguono abbastanza bene (cani e gatti). Ció è dovuto al fatto che le immagini presentano una struttura ricca che può essere sfruttata sia dagli esseri umani che dai modelli di apprendimento. Le CNN rappresentano un approccio creativo adottato dall'apprendimento automatico per sfruttra alcune delle strutture note presenti nelle immagini naturali.

== Invariance
Immaginiamo di voler individuare un oggetto in un'immagine. Sembra ragionevole che, qualunque sia il metodo utilizzato per riconoscere gli oggetti, esso non debba concentrarsi eccessivamente sulla posizione precisa dell'oggetto nell'immagine. Idealmente, il nostro sistema dovrebbe sfruttare questa conoscenza. Di solito i maiali non volano e gli aerei non nuotano. Ciononostante, dovremmo comunque riconoscere un maiale se ne comparisse uno nella parte superiore dell'immagine. Possiamo trarre ispirazione dal gioco "Dov'é Waldo?". Il gioco consiste in una serie di scene caotiche dove Waldo compare da qualche parte, in genere nascosto in luoghi improbabili, l'obiettivo è appunto individuarlo. Nonostante il suo abbigliamento caratteristico ció puó rivelarsi estremamente difficile a casua del gran numero di elementi di distrazione. Tuttavia, l'aspetto di Waldo non dipende dalla sua posizione, potremmo scansionare l'immagine con un "rilevatore di Waldo" in grado di assegnare un punteggio a ciascuna area, indicando la probabilità che tale area contenga Waldo. Infatti, molti algoritmi di rilevamento e segmentazione degli oggetti si basano su questo approccio. Le CNN sistematizzano questa idea di invarianza spaziale, sfruttandola per apprendere rappresentazioni utili con un numero minore di parametri.

Ora possiamo rendere più concrete queste intuizioni elencando alcuni requisiti che guidino la progettazione di un'architettura di rete neurale adatta alla Computer Vision:
1. Nei primi livelli, la nostra rete dovrebbe rispondere in modo simile allo stesso frammento, indipendentemente dalla sua posizione nell'immagine. Questo principio è chiamato _translation invariance_.
2. Gli strati più superficiali della rete dovrebbero concentrarsi sulle regioni locali, senza tenere conto dei contenuti dell'immagine nelle regioni distanti. Questo è il _locality principle_. Infine, queste rappresentazioni locali possono essere aggregate per effettuare previsioni a livello dell'intera immagine.
3. Man mano che procediamo, gli strati più profondi dovrebbero essere in grado di cogliere caratteristiche dell'immagine a più lungo raggio, in modo simile alla visione di livello superiore presente in natura.

Vediamo come convertire tutto questo in linguaggio matematico.

== Constraining the MLP
Per cominciare possiamo considerare un MLP con immagini bidimensionali $bold(X)$ come input e le loro rappresentazioni nascoste immediate $bold(H)$ rappresentate in modo simile tramite matrici dove $bold(X)$ e $bold(H)$ hanno la stessa forma. Immaginiamo ora che non solo gli input ma anche le rappresentazioni nascoste possiedano una struttura spaziale.

Indichiamo con $[bold(X)]_(i,j)$ e $[bold(H)]_(i,j)$ il pixel alla posizione $(i,j)$ nelle rispettive matrici. Per fare in modo che ogni hidden unit riceva input da ogni pixel in input, dobbiamo smettere di usare matrici dei pesi per rappresentare i parametri e dobbiamo usare tensori dei pesi $W$ di ordine $4$. Supponiamo che $bold(U)$ contenga i bias, possiamo quindi esprimere il fully connected layer come: $ [bold(H)]_(i,j)&=[bold(U)]_(i,j) + sum_k sum_l [W]_(i,j,k,l) [bold(X)]_(k,l) \ &= [bold(U)]_(i,j) + sum_a sum_b [V]_(i,j,a,b) [bold(X)]_(i+a,j+b) $

Dove $u_(i,j)$ rappresenta il termine di bias specifico della posizione $(i,j)$ e $W$ é un tensore a 4 dimensioni contenente i pesi che collegano il pixel di input nella posizione $(k,l)$ al nodo nascosto nella posizione $(i,j)$. Possiamo riformulare l'indicizzazione dei pesi esprimendo la posizione del pixel di input $(k,l)$ come uno spostamento relativo $(a,b)$ rispetto alla posizione di output $(i,j)$ ponendo $k=i+a$ e $l=j+b$.

Applichiamo quindi il primo vincolo: l'Invarianza per Traslazione. Se la risposta del rilevatore non deve dipendere dalla posizione assoluta $(i,j)$ nell'immagine allora i pesi $V$ non devono variare al variare di $i,j$. Pertanto $V_(i,j,a,b)$ diventa una funzione che dipende esclusivamente dagli offset relativi $a$ e $b$ cioé $[V]_(a,b)$ e il bias diventa una costante unica $u$: $ [H]_(i,j) = u + sum_a sum_b [V]_(a,b) [X]_(i+a,j+b) $ 

Ora applichiamo il secondo vincolo: la localitá. Se gli unici pixel che influenzano il nodo $(i,j)$ sono quelli situati in un piccolo intorno di raggio $D$ intorno a $(i,j)$ possiamo imporre che $[V]_(a,b)=0$ per tutti gli offset tali che $|a|>D$ oppure $|b| > D$. L'equazione diventa: $ [H]_(i,j) = u + sum^D_(a=-D) sum^D_(b=-D) [V]_(a,b) [X]_(i+a, j+b) $

Questa equazione definisce formalmente uno strato convoluzionale. Il tensore $V$ dei pesi non dipende più dalle dimensione dell'immagine ma solo dalle dimensioni del filtro locale (detto kernel o maschera di convoluzione), riducendo i parametri da ordine $cal(O) (H^2 W^2)$ ad appena $cal(O) (K^2)$ dove $K=2D + 1$ é la dimensione del kernel.

== Convoluzioni
In matematica la vera operazione di convoluzione bidimensionale tra una funzione discreta $X$ e un kernel $V$ prevede un ribaltamento degli indici. Tuttavia la formula vista prima implementa il segno più negli indici degli input, operazione nota in analisi dei segnali come _cross-correlation_. Nel deep learning si utilizza comunemente il termine "convoluzione" per riferirsi in realtà alla cross-correlazione. Questa imprecisione terminologica non ha alcun impatto pratico sulle prestazioni dell'algoritmo: poichè la matrice del Kernel V viene appresa dai dati tramite la discesa del gradiente, la rete apprenderà automaticamente i pesi ruotati o specchiati se necessario, rendendo l'operazione di ribaltamento matematico del tutto superflua durante il calcolo.

= Convolutions for Images
Adesso che sappiamo come lavorano le convoluzioni nella teoria vediamole nella pratica.

== The Cross-Correlation Operation
Per ora ignoramo i canali dell'immagine e vediamo come funzionano con dei dati bidimensionali e la loro hidden rappresentation. L'input è un tensore bidimensionale con un'altezza di 3 e un larghezza di 3. Abbiamo quindi come shape del tensor $3 times 3, (3,3)$. Sia altezza che larghezza del kernel valgono $2$. La shape o la _kernel window_ è data dall'altezza e dalla larghezza del kernel, quindi in questo caso $2 times 2$.

#align(center, image("/assets/image-100.png", width: 50%))

Nelle operazioni _cross-correlation_ bidimensionali iniziamo con la convolution window posizionata nell'angolo in alto a sinistra dell'input tensor e la spostiamo da sinistra verso destra e dall'alto verso il basso. Quando la convolution window si sposta in una posizione, il subtensor dell'inptu contenuto in quella finestra e il kernel tensor vengono moltiplicati elementwise e il risultato viene sommato fino ad ottenere un singolo valore scalare. Questo valore sará il risultato dell'output tensor in quella posizione.

Se la matrice di input possiede un'altezza $H$ e una larghezza $W$ e la matrice del kernel possiede un'altezza $k_h$ e una larghezza $k_w$, le dimensioni dell'output calcolato saranno pari ad un'altezza di $H-k_h + 1$ ed una larghezza di $W - k_w + 1$.

== Convolutional Layers
Un convolutional layer effetua una cross-correlation tra l'input e il kernel e aggiunge un bias scalare per produrre un output. I due parametri di un convolutional layer sono il kernel e il bias scalare. Quando si addestrano modelli basati su convolutional layer tipicamente si inizializzano i kernel in modo randomico.

== Feature Map and Receptive Field
La matrice bidimensionale prodotta in uscita da un convolutional layer prende il nome di _feature map_, indicando che ogni suo elemento rappresenta l'attivazione di uno specifico rilevatore di strutture estratte dal livello sottostante.

Per un qualsiasi elemento appartenente a una feature map situata ad un certo livello della rete, si definisce _receptive field_ l'insieme di tutti i pixel e di tutti gli elementi dei livelli precedenti che hanno contribuito a determinare il valore di quell'elemento. Il receptive field si espande progressivamente man mano che ci si addentra nella profonditá dell'architettura. Se si applica un primo kernel di dimensione $3 times 3$ su un'immagine d'ingresso, ogni elemento della prima feature map possiede un receptive field di dimensione $3 times 3$. Applicando un secondo strato convoluzionale con un ulteriore kernel $3 times 3$ al di sopra di questa mappa, ogni elemento del secondo livello possiederá un receptive field pari a $5 times 5$ pixel dell'immagine originale di partenza. La sovrapposizione di più strati convoluzionali con filtri piccoli permette di catturare dipendenze spaziali sempre più ampie mantenendo un numero ridotto di parametri.

= Padding and Stride
Vedremo alcune tecniche che ci garantiscono più controllo sulla dimensione dell'output. Notiamo infatti che siccome i kernel hanno larghezza e altezza maggiore di $1$ (di solito), dove averne applicati alcuni finiamo per avere un output molto più piccolo rispetto all'input originale. Se iniziamo con una foto $240 times 240$ pixel e applichiamo 10 layer convoluzionali $5 times 5$ riduciamo l'immagine a $200 times 200$ tagliando il $30%$ dell'immagine e ignorando ogni informazione presente ai bordi di questa. Il _padding_ è lo strumento più conosciuto per risolvere questo problema. In altri casi potremmo invece voler ridurre drasticamente la dimensionalità, le convoluzioni con stride variabile sono una tecnica molto diffusa che può rivelarsi utile in questi casi.

== Padding
Abbiamo detto appunto che i pixel ai bordi dell'immagine vengono persi quando applichiamo dei convolutional layer, vediamo un esempio: #align(center, image("/assets/image-101.png", width: 50%))

L'immagine ci mostra quante volte i pixel vengono riutilizzati con rispettivamente dei kernel grandi $1 times 1, 2 times 2, 3 times 3$.

Una soluzione semplice è quella di aggiungere dei pixel ai bordi dell'immagine tipicamente impostandoli a 0. Nelle CNN di solito si utilizzano finestre dei kernel e padding dispari per produrre output della stessa grandezza dell'input.

== Stride
Di base quando facciamo i calcoli per i convolutional layer ci spostiamo di una posizione alla volta. Tuttavia a vole sia per motivi di efficienza sia perchè desideriamo effettuare un downsampling, spostiamo la finestra di più di un elemento alla volta saltando le posizioni intermedie. Ciò è particolarmente utile se il kernel di convoluzione è di grandi dimensioni, poichè cattura un'ampia area dell'immagine sottostante.

Il numero di righe e colonne attraversate per ogni scorrimento viene definito _stride_. Possiamo effettuare degli stride sia sulle righe che sulle colonne e anche di dimensioni diverse fra loro.

= Multiple Input and Multiple Output Channels
Per ora abbiamo sempre assunto che le immagini in input avessero sempre e solo un canale tuttavia le immagini reali sono quasi sempre caratterizzate da più canali d'ingresso come ad esempio le classiche immagini RGB.

== Multiple Input Channels
Quando i dati di input contengono più canali d'ingresso occorre costruire un kernel convoluzionale con il medesimo numero di canali di input. Denotando con $C_"in"$ il numero di canali d'ingresso dell'immagine, il filtro deve essere rappresentato da un tensore tridimensionale composto da $C_"in"$ matrici bidimensionali di pesi. Per calcolare il risultato dell'operazione si esegue l'operazione di cross-correlation bidimensionale separatamente su ciascun canale, applicando la specifica matrice bidimensionale del kernel al relativo canale dell'input. Successivamente, si sommano elemento per elemento le $C_"in"$ matrici risultanti per ottenere un'unica matrice bidimensionale di output.

Dal punto di vista matematico se l'input $X$ ha dimensione $C_"in" times H times W$ e il kernel $K$ ha dimensione $C_"in" times k_h times k_w$, l'operazione di cross-correlation produce un output bidimensionale di dimensione $(H - k_h + 1) times (W - k_w + 1)$. In questo processo, le caratteristiche spaziali di ciascun canale d'ingresso vengono elaborate e fuse lungo la dimensione dei canali attraverso la somma pesata dei contributi individuali.

#align(center, image("/assets/image-102.png", width: 50%))

== Multiple Output Channels
Indipendentemente dal numero di canali in ingresso, l'utilizzo di un singolo set di filtri tridimensionali produce sempre una feature map bidimensionale a singolo canale. Tuttavia, nelle architetture reali è fondamentale apprendere molteplici rilevatori di struttura a ciascun livello per estrarre diverse tipologie di informazioni. Per generare un output contenente $C_"out"$ canali definiamo un tensore dei pesi del kernal quadridimensionale dotato di forma $C_"out" times C_"in" times k_h times k_w$. Ciascuno dei $C_"out"$ canali d'uscita possiede un proprio set di filtri di dimensione $C_"in" times k_h times k_w$. ...

== $1 times 1$ Convolutional Layer
Un convolutional layer con dimensione del kernel $1 times 1$ sembra privo di senso. Poichè la finestra ha dimensione $k_h = k_w = 1$ non aggrega informazioni provenienti dai pixel vicini, tuttavia, svolge un ruolo essenziale combinando le informazioni lungo la dimensione dei canali. Posizionando il kernel $1 times 1$ su una determinata posizione, l'operazione esegue il prodotto scalare tra il vettore delle att ivazioni di input di lunghezza presenti in quel singolo pixel e il vettore dei pesi del kernel.

Di conseguenza una convoluzione $1 times 1$ equivale ad applicare un MLP fully connected in modo indipendente ed identico su ogni singolo pixel dell'immagine. Gli unici parametri appresi sono le combinazioni lineari tra i canali di input. Questa proprietà rende le convoluzioni $1 times 1$ uno strumento potente e computazionalmente efficiente per modificare, ridurre o espandere il numero dei canali introducendo al contempo funzioni di attivazione non lineari senza alterare la risoluzione dell'immagine.

#align(center, image("/assets/image-103.png", width: 50%))

= Pooling
In alcuni casi il nostro obiettivo è quello di ottenere delle informazioni dall'immagine _globale_, come ad esempio, "contiene un gatto?", di conseguenza le unità nel nostro layer finale devono essere sensibili all'intero input. Aggregando gradualmente le informazioni, ottenendo mappe sempre più grossolane, raggiungiamo questo obiettivo di apprendere, in ultima analisi, una rappresentazione globale, pur mantenendo tutti i vantaggi degli strati convoluzionali negli strati intermedi dell'elaborazione. Più ci addentriamo nella rete, più ampio è il receptive field rispetto all'input a cui è sensibile ciascun nodo nascosto. La riduzione della risoluzione spaziale accelera questo processo, poichè i kernel di convolution coprono un'area effettiva più ampia.

Inoltre, quando si individuano features a livello inferiore come i bordi, spesso vogliamo che le rappresentazioni siano in qualche modo invarianti rispetto alla traslazione. Ad esempio, se prendiamo l'immagine X con una netta delimitazione tra bianco e nero e spostiamo l'intera immagine di un pixel a destra, l'output per la nuova immagine Z potrebbe risultare diverso. Il borso si sará spostato di un pixel.

Introduciamo quindi i _pooling layers_, servono a ridurre la sensibilità dei layer convoluzionali alla posizione e servono anche ad effettuare un downsampling spaziale delle rappresentazioni.

== Maximum Pooling and Average Pooling
Anche i pooling layers consistono di una window di forma fissa che viene fatta scorrere sull'immagine calcolando un unico valore per ciascuna posizione attraversata, anche chiamata _pooling window_. Tuttavia, a differenza dei convolutional kernel, quelli di pooling non hanno parametri (quindi non c'é un kernel). Gli operatori di pooling sono deterministici e calcolano tipicamente il valore massimo o quello medio degli elementi presenti nella finestra di pooling. Queste operazioni sono denominate rispettivamente _maximum pooling_ e _average pooling_.

= Convolutional Neural Networks (LeNet)
Combiniamo tutto quello che abbiamo visto per costruire una LeNet, una delle prime reti neurali convoluzionali per il riconoscimento delle cifre manoscritte nei servizi postali. La nascita di LeNet ha dimostrato empiricamente che l'integrazione di strati convoluzionali e strati di pooling consente di superare i limiti degli MLP nell'elaborazione delle immagini.

== LeNet
Questa architettura è composta da 2 parti fondamentali, un blocco convoluzionale iniziale dedicato all'estrazione delle features visive e un blocco fully connected finale dedicato alla classificazione.

#align(center, image("/assets/image-104.png", width: 80%))

Il blocco convoluzionale è organizzato in una struttura sequenziale che alterna due strati convoluzionali e due strati di sottocampionamento o pooling. Il primo strato convoluzionale accetta in ingresso un'immagine a canale singolo e applica sei filtri con kernel di dimensione $5 times 5$ e un padding di due pixel. Successivamente viene applicata una funzione di attivazione non lineare e uno strato di average pooling con finestra di dimensione $2 times 2$ e stride pari a due, che dimezza sia l'altezza che la larghezza delle feature maps.

Il secondo strato convoluzionale accetta le sei feature maps risultanti dal primo blocco e applica 16 filtri con kernel $5 times 5$ senza padding, riducendo le dimensioni spaziali. Segue un secondo strato di attivazione non lineare e un ulteriore strato di average pooling $2 times 2$ con stride 2, che riduce ulteriormente le dimensioni delle feature map in output.

Alla fine del blocco convoluzionale, le feature map bidimensionali risultanti di dimensione $16 times 5$ vengono appiattite in un unico vettore monodimensionale di $400$ elementi. Questo vettore viene passato al blocco completamente connesso, costituito da un primo strato denso con $120$ unità, un secondo strato denso con $84$ unità e uno strato di output finale con $10$ unità, corrispondenti alle $10$ classi di cifre o oggetti da classificare.
