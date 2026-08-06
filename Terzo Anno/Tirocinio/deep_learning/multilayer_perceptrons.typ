#import "@preview/zebraw:0.6.3": *
#show: zebraw.with(numbering: false, lang: false)
#import "@preview/showybox:2.0.4": showybox

= Multilayer Perceptrons
Introduciamo la prima deep network. Quelle piú semplici sono appunto chiamate _multilayer perceptrons_ e sono formate da piú strati di neuroni ciascuno dei quali é completamente connesso a quelli dello stato sottostante da cui riceve l'input e a quelli sovrastanti. Sebbene la differenziazione automatica semplifichi notevolemente l'implementazione degli algoritmi di deep learning, approfondiremo il modo in cui questi gradienti vengono calcolati nelle deep network. Esaminiamo quindi l'inizializzazione dei parametri, la regolarizzazione e la generalizzazione per non incorrere in overfitting.

Precedentemente abbiamo visto modelli di regressione lineare e la softmax regression, sebbene siano molto semplioci hanno una grande limitazione, assumono che la relazione tra le feature di input e il target finale sia strettamente lineare. Tuttavia il mondo reale non é lineare, per modellare pattern complessi abbiamo bisogno di classi di modelli piú flessibili: i *Multilayer Perceptrons (MLP)* che rappresentano l'architettura classica delle Neural Networks.

== Hidden Layers
I MLP superano le limitazioni dei modelli lineari mediante l'inserimento di uno o piú _Hidden Layers_ situati tra l'_Input Layer_ e l'_Output Layer_. Se definiamo la matrice di input come $bold(X) in RR^(n times d)$ dove $n$ é il numero di examples e $d$ il numero di feature, un hidden layer calcola una rappresentazione intermedia $bold(H) in RR^(n times h)$ con $h$ numero di neuroni nascosti.

#align(center, image("/assets/image-98.png", width: 50%))

$ bold(H) = bold(X W)^((1)) + bold(b)^((1)) $

L'output layer calcola poi il risultato finale $bold(O) in RR^(n times q)$ con $q$ uscite: $ bold(O) = bold(H W)^((2)) + bold(b)^((2)) $

Dove $bold(W)^((1)) in RR^(d times h)$ e $bold(W)^((2)) in RR^(h times q)$ sono le matrici dei pesi mentre $bold(b)^((1)) in RR^(1 times h)$ e $bold(b)^((2)) in RR^(1 times q)$ sono i vettori di bias.

Se peró ci limitassimo a concatenare queste trasformazioni lineari l'intero modello collasserebbe in una nuova singola trasformazione lineare: $ bold(O)=(bold(X W)^((1)) + bold(b)^((1))) bold(W)^((2)) = bold(X W)^((1)) bold(W)^((2)) + bold(b)^((1)) bold(W)^((2)) + bold(b)^((2)) = bold(X W)' + bold(b)' $

Per evitare questo collasso e introdurre una reale capacitá espressiva dobbiamo applicare elemento per elemento una _Activation Function_ non lineare $sigma(dot)$ agli output di ciascun hidden layer.

$ bold(H) &= sigma(bold(X W)^((1)) + bold(b)^((1)))  \ bold(O) &= bold(H W)^((2)) + bold(b)^((2)) $

Le Activation Functions decidono se e in che misura un neurone debba attivarsi, introducendo la non-linearitá che é indispensabile nel deep learning. Le tre funzioni piú comunemente utilizzate sono:

- _ReLU (Rectified Linear Unit)_: É la scelta standard nel deep learning moderno grazie alla sua semplicitá e velocitá di calcolo. $ "ReLU"(x) = "max"(x,0) $
Ovvero annulla tutti i valori negativi e lascia inalterati quelli positivi.

- _Sigmoid_: La funzione sigmoid trasforma qualsiasi input reale in un valore compreso nell'intervallo aperto $(0,1)$. $ "sigmoid"(x) = 1 / (1 + "exp"(-x)) $

- _Tanh (Hyperbolic Tangent)_: La funzione tanh trasforma l'input schiacciandolo nell'intervallo $(-1,1)$: $ "tanh"(x) = (1 - "exp"(-2x))/(1+"exp"(-2x)) $

#showybox(
  title-style: (
    color: green.darken(50%),
    weight: "bold",
    align: center,
    sep-thickness: 0pt
  ),
  frame: (
    border-color: green,
    title-color: green.lighten(80%),
    body-color: white,
    thickness: (left: 1pt, rest: 0pt),
    radius: 0pt,
  ),
  title: [*Universal Approximation Theorem*],
  [
    Un Multilayer Perceptron dotato anche di un solo Hidden Layer contenente un numero sufficiente di neuroni e una Activation Function non lineare è in grado di approssimare con qualsiasi grado di precisione desiderato qualunque funzione continua.
  ],
)

Questo teorema garantisce che, indipendentemente da quanto sia complessa o contorta la relazione tra gli input e i target, esiste sempre una configurazione di pesi e bias in un MLP in grado di modellarla.

= Forward Propagation, Backward Propagation, and Computational Graphs
Vogliamo capire a fondo come vengono ottimizzate le reti quando chiamiamo `loss.backward()`. Approndiamo quindi i tre concetti chiave dell'addestramento: _Forward Propagation, Computational Graph, Backpropagation_.

== Forward Propagation
La forward propagation si riferisce al calcolo e alla memorizzazione delle variabili intermedie per una Neural Network procedendo dall'Input Layer all'Output Layer. Consideriamo quindi un MLP a singolo Hidden Layer con norm $L_2$ (Weight Decay). Per semplicità assumiamo che non vi sia bias. Vediamo quindi in ordine i passaggi.

\

1. Dato un campione di input $bold(x) in RR^(d)$ il primo passaggio calcola l'input intermedio non attivato $bold(z)$ $ bold(z) = bold(W)^((1)) bold(x) $ Dove $bold(W)^((1)) in RR^(h times d)$ è la matrice dei pesi e $h$ è il numero di unità nascoste. 

2. Applicando la Activation Function $phi.alt$ elemento per elemento otteniamo il vettore delle attivazioni nascoste $bold(h) in RR^h$ $ bold(h)=phi.alt(bold(z)) $

3. L'attivazione $bold(h)$ viene quindi moltiplicata per la matrice dei pesi del secondo strato $bold(W)^((2)) in RR^(q times h)$ per generare il vettore di output non normalizzato $bold(o) in RR^(q)$ $ bold(o) = bold(W)^((2)) bold(h) $

4. Data l'etichetta target $y$ calcoliamo la Loss Function $L$ $ L = l(bold(o),y) $ 

5. In base alla regolarizzazione $L_2$ con iperparametro $lambda$ definiamo la penale $s$ $ s = lambda / 2 (||bold(W)^((1))||^2_F + ||bold(W)^((2))||^2_F) $ Dove $||dot||_F$ indica la norma di Frobenius della matrice. L'_Objective Loss_ finale $J$ da minimizzare è la somma tra la Loss del modello e la penale $ J = L+s $

== Computational Graph of Forward Propagation
Tracciare un Computational Graph ci aiuta a visualizzare il flusso delle operazioni e la dipendenza tra operatori e variabili in una Neural Network.
#align(center, image("/assets/image-99.png", width: 50%))

I nodi rappresentano le variabili o le operazioni matematiche mentre gli archi indicano le dipendenze computazionali tra i valori.

== Backpropagation
La Backpropagation si riferisce al metodo di calcolo dei gradienti dei parametri di una Neural Network. Questa attraversa la rete in ordine inverso rispetto alla Forward Propagation partendo quindi dall'Output Layer (la Loss) e andando verso l'Input Layer applicando la Chain Rule.

Sia $J = L+s$ l'Objective Function, vogliamo calcolare le derivate parziali di $J$ rispetto a ciascun parametro della rete $bold(W)^((1))$ e $bold(W)^((2))$. Vediamo quindi in ordine i passaggi della backpropagation.

...

== Training Neural Networks
Durante il training di una rete neurale, le due propagation sono strettamente interdipendenti. La Forward calcola il valore delle loss e salva in memoria tutte le variabili intermedie, la backward utilizza questi valori intermedi per valutare le derivate parziali e calcolare i gradienti tramite la Chain Rule. È per questo che l'addestramento richiede molta piú memoria dell'inferenza, durante ques'ultima infatti non abbiamo bisogno di memorizzare tutti i valori intermedi.

= Numerical Stability and Initialization
Quando addestriamo reti con decine o centinaia di strati, la stabilità numerica dell'algoritmo di Backpropagation diventa un fattore critico. Scelte errate nell'architettura o nell'inizializzazione dei pesi possono far si che i gradienti o le attvazioni intermedie crescano a dismisura fino all'overflow oppure svaniscano fino a zero (underflow). Esaminiamo quindi i due problemi principali -- *Vanishing Gradients* e *Exploding Gradients* -- per poi analizzare le strategie di *Paramater Initialization* progettate per garantire un addestramento stabile.

Consideriamo una Deep Neural Network con $L$ Hidden Layers. Durante il passaggio di Backpropagation, il gradiente della Loss Function rispetto ai pesi dei primi strati comporta la moltiplicazione a catena di $L$ matrici di pesi e di derivate delle Activation Functions $ partial_(bold(W)^((1))) J prop bold(M)^((L)) bold(M)^((L-1)) ... bold(M)^((2)) $

Dove ciascuna matrice $bold(M)^((l))$ dipende dalla matrice dei pesi $bold(W)^((l))$ e dalla derivata della Activation Function allo strato $l$.

*Vanishing Gradients* - Se i valori all'interno delle matrici o le derivate delle Activation Functions sono sistematicamente minori di $1$ allora il prodotto di $L$ di tali fattori decresce esponenzialmente al crescere della profondità di $L$; di conseguenza i pesi dei primi strati non ricevono alcun aggiornamento significativo e rimangono bloccati ai loro valori iniziali impedendo l'apprendimento della rete.

*Exploding Gradients* - Al contrario se i valori dei pesi sono sistematicamente maggiori di $1$ allora il prodotto a catena cresce esponenzialmente quindi i gradienti assumono valori enormi causando aggiornamenti instabili ed estremi dei parametri tramite la SGD; inoltre a livello computazionale questo porta ad un ovrflow della memoria.

== Symmetry Breaking
Un altro problema riguarda la scelta dell'inizializzazione dei parametri, se inizializzassimo tutti i pesi di una Neural Network allo stesso valore costante:
- Durante la Forward Propagation tutti i neuroni di un determinato hidden layer calcolerebbero esattamente lo stesso output intermedio.
- Durante la Backpropagation tutti i neuroni riceverebbero esattamente lo stesso identico gradiente.
Di conseguenza, l'aggiornamento dei parametri farebbe evolvere tutti i neuroni in modo identico. La rete neurale perde la capacità di far specializzare i vari neuroni su feature differenti riducendo l'intera capacità di un hidden layer a quella di un singolo neurone isolato.

== Parameter Inizialization Strategies
Per evitare tutti questi problemi, i pesi devono essere inizializzati casualmente ed essere scalati in modo che la varianza delle attivazioni e dei gradienti rimanga costante attraverso tutti gli strati.

*Xavier Initialization* - È progettate per strati con Activation Functions che si comportano in modo approssimativamente lineare attorno allo zero, come la Tanh.
...

*He / Kaiming Initialization* - Risponde al fatto che la ReLU annulla esattamente la metà degli input, dimezzando di fatto la varianza del segnale che passa attraverso lo strato. Per compensare questa perdita, la varianza dei pesi viene raddoppiata rispetto alla sola dimensione d'ingresso.

= Generalization in Deep Learning
Abbiamo visto il concetto di Generalization e dell'Overfitting e anche come il Bias-Variance Trade-off suggerisca un equilirbio: aumentare la capacità del modello dovrebbe, oltre una certa soglia, portare inevitabilmente a un grave overfitting. Tuttavia le reti neurali moderno sfidano questo concetto. Esse sono fortemente overparameterized ovvero possiedono molti più parametri rispetto al numero di campioni nel dataset di addestramento, riescono ad azzerare il training error eppure continuano a mostrare una generalization eccellente nei test.

== Revisiting Overfitting and Regularization
Per comprendere la generalization occorre considerare il teorema _No Free Lunch_. Questo dimostra che nessun algoritmo di apprendimento può superare qualsiasi altro su tutte le possibili distribuzioni di dati. Di conseguenza, ogni modello si basa su specifici bias induttivi ovvero preferenze verso determinate soluzioni che riflettono la struttura del problema da risolvere. Ad esempio, le reti neurali asumono implicitamente che funzioni complesse possano essere descritte tramite la composizione gerarchica di funzioni elementari più semplici.

Il gap di generalizzazione è definito come la differenza tra il training error e il test error, quando questo divario diventa troppo grande il modello si trova in uno stato di overfitting.

A differenza dei modelli statistici tradizionali, le reti neurali profonde possiedono una capacità espressiva talmente elevata da poter interpolare perfettamente qualsiasi dataset di dimensione finita, azzerando il training error anche con etichette casuali. Sorprendentemente l'aumento delle capacità del modello tramite l'aggiunta di strati o parametri non porta necessariamente a un peggioramento delle prestazioni sul test ma anzi, ne aumenta le capacità di generalizzazione. Questo comportamento rende inapplicabili le teorie basate sulla VC dimension le quali prevederebbero un limite teorico di errore piccolo o infinito per modelli fortemente sovrapparametrizzati.

== Inspiration from Nonparametrics
...

== Early Stopping
Nonostante le reti abbiano la capacità teorica di memorizzare dataset rumorosi o del tutto arbitrari, la dinamica temporale dell'addestramento mostra che esse non apprendono tutte le informazioni allo stesso ritmo. Gli studi mostrano che l'algoritmo di ottimizzazione tende ad apprendere prima i pattern generali lasciando la memorizzazione del rumore alle fasi finali.

Questa proprietà giustifica l'utilizzo dell'Early Stopping. Anzichè modificare direttamente la loss function aggiungendo termini di penalità sui pesi, si limita il numero di epoche di addestramento. Si valuta costantemente l'errore sul test set e si interrompe la procedura quando le prestazioni sul test set smettono di migliorare dopo un numero predefinito di epoche, preservando così la capacità di generalizzazione del modello prima che subentri la memorizzazione del rumore.

= Dropout
L'idea del dropout consiste nell'inserire del rumore durante il calcolo di ciascun strato interno nel corso del forward ed è diventata una tecnica standard per l'addestramento delle reti neurali. Il metodo si chiama dropout perchè durante l'addestramento appunto si escludono alcuni neuroni.

Nella regolarizzazione standard con dropout, si azzera una certa frazione dei nodi in ogni strato e poi si elimina il bias di ogni strato normalizzandolo in base alla frazione di nodi che sono stati mantenuti. In altre parole, con probabilità di dropout $p$, ogni attivazione intermedia $h$ viene sostituita da una variabile casuale $h'$ definita da: $ h' = cases(0 space &"with probability" p, h/(1-p) space &"otherwise") $

Grazie a questa tecnica, il calcolo dello strato di output non può dipendere eccessivamente da nessun singolo elemento degli hidden layer.

Tipicamente il dropout viene disattivato in fase di test, tuttavia esistono alcune eccezioni. Alcuni ricercatori utilizzato il dropout in fase di test come euristica per stimare l'incertezza delle previsioni della rete neurale, se le previsioni coincidono in molti output diversi generati dal dropout allora si potrebbe affermare che la rete è più sicura delle proprie previsioni. Ovvero che gli output, appunto, non dipendono eccessivamente da neuroni specifici ma qualsiasi spegnamo la rete riesce a generalizzare.