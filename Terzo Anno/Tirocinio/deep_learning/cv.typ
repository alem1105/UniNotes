#import "@preview/zebraw:0.6.3": *
#show: zebraw.with(numbering: false, lang: false)

= Computer Vision

== Image Aumentation
Abbiamo visto come grandi dataset sono un prerequisito per il successo delle reti neurali. L'aumento delle immagini genera esempi di addestramento simili ma distinti dopo una serie di modifiche casuali alle immagini di addestramento, ampliando così la dimensione del set di addestramento. Ad esempio, possiamo ritagliare un'immagine in modi diversi per far apparire l'oggetto di interesse in posizioni diverse, riducendo così la dipendenza di un modello dalla posizione dell'oggetto. Possiamo anche regolare fattori quali la luminosità e il colore per ridurre la sensibilità di un modello al colore.

=== Common Image Augmentation Methods
==== Flipping and Cropping
Flippare l'immagine a destra e sinistra non cambia la categoria dell'oggetto, quiesto è uno dei primi metodi di augmentation, di base cerchiamo di farla nel $50%$ dei casi di esempio. Un altra tecnica invece è quella di ritagliare l'immagine per far apparire l'oggetto da riconoscere in punti diversi.


==== Changing Colors
Possiamo cambiare 4 valori dell'immagine: luminosità, contrasto, saturazione e tonalità.

==== Combining Multiple Image Augmentation Methods
Di solito si combinano più tecniche ...

Questo si fa principalmente durante il training del modello e non durante l'inferenza.

== Fine-Tuning
Spesso nelle applicazioni di Computer Vision ci si trova a dover risolvere problemi di classificazione delle immagini su dataset di dimensioni ridotte. Se si tentasse di addestrare una rete neurale complessa da zero su poche centinaia di immagini, il modello andrebbe incontro ad un grave overfitting a causa dell'enorme differenza tra il numero di parametri della rete e il numero ridotto di esempi.

Per superare questo ostacolo, la pratica standard nel deep learning si avvale del _transfer learning_. L'idea fondamentale consiste nel prendere un modello addestrato su un dataset enorme e trasferire la conoscenza appresa su un compito specifico caratterizzato da un dataset più piccolo. La tecnica di transfer learning più diffusa ed efficace è il _fine-tuning_.

=== Passaggi del Fine-Tuning
La procedura di fine-tuning è composta da 4 fasi:
1. *Pre-addestramento sul modello sorgente*: Si addestra una rete neurale su un grande dataset per consentire all'architettura di apprendere rappresentazioni visive di carattere generale come bordi, trame, forme ecc...
2. *Copia dell'architettura e dei pesi*: Si crea un nuovo modello di rete neurale copiando la struttura e tutti i parametri appresi dal modello sorgente con l'unica eccezione dello strato finale di output.
3. *Inizializzazione dello strato di output*: Si aggiunge al modello target un nuovo strato di output la cui dimensione corrisponde esattamente al numero di classi presenti nel dataset target e se ne inizializzano i pesi in modo casuale.
4. *Addestramento sul dataset target*: Si addestra l'intera rete target sul nuovo dataset. In questa fase, lo strato di output viene ottimizzato a partire da zero, mentre i parametri di tutti gli strati precedenti vengono affinati a partire dai pesi ereditati dal modello sorgente.

Da notare inoltre che l'addestramento della nuova rete richiede una gestione attenta dei learning rate. Poichè lo strato d'uscita è stato inizializzato casualmente, i suoi pesi necessitano di un tasso di apprendimento relativamente elevato per convergere rapidamente. Al contrario gli strati convoluzionali pre-addestrati contengono già rappresentazioni visive di alta qualità, pertanto i loro pesi devono essere aggiornati con un tasso di apprendimento significativamente più piccolo. Impostare un tasso di apprendimento piccolo sugli strati convoluzionali serve appunto a non distruggere le features generali già apprese.

== Object Detection and Bounding Boxes
Ci siamo sempre concentrati in problemi di classificazione ovvero identificare la categoria dell'oggetto contenuto nell'immagine. Tuttavia, in numerose applicazioni è indispensabile determinare non solo quale oggetto è presente ma anche individuare la posizione esatta di ciascun oggetto all'interno della scena. Questo compito prende il nome di _object detection_.

Nel rilevamento degli oggetti, la rete deve identificare simultaneamente tutte le regioni di interesse d'impatto semantico e predire per ciascuna di esse sia la classe di appartenenza sia la delimitazione spaziale. La posizione e l'estensione spaziale di un oggetto vengono descritte matematicamente tramite un _bounding box_, ovvero un rettangolo orientato in modo parallelo agli assi dell'immagine che racchiude esattamente i contorni esterni dell'oggetto identificato. Un boundig box può essere rappresentato numericamente attraverso due convenzioni o formati:
1. *Corner Format*: Il rettangolo viene definito specificando le coordinate spaziali dell'angolo in alto a sinistra e dell'angolo in basso a destra.
2. *Cetner Format*: Il rettangolo viene definito specificando le coordinate del suo punto centrale, unitamente al valore della sua larghezza $w$ e della sua altezza $h$.

Le coordinate possono essere convertite analiticamente da un formato all'altro mediante semplici trasformazioni algebriche. Dato un bounding box espresso in corner format $(x_"min", y_"min", x_"max", y_"max")$, la conversione nel center format $(x_"center", y_"center", w, h)$ si calcola come: $ x_"center" &= (x_"min" + x_"max") / 2,& space y_"center" &= (y_"min" + y_"max") / 2 \ w &= y_"max" - y_"min",& space h &= y_"max" - y_"min" $

Viceversa ...

Un aspetto fondamentale per la loro rappresentazione, riguarda la scala delle coordinate. Le coordinate dei bounding box possono essere espresse in valori assoluti in pixel oppure in valori normalizzati nell'intervallo $[0,1]$.

La normalizzazione si ottiene dividendo le coordinate orizzonatli e la larghezza per la larghezza totale dell'immagine $W$ e le coordinate verticali e l'altezza per l'altezza totale dell'immagine $H$. Utilizzare coordinate normalizzate rende la rappresentazione geometrica invariante rispetto alle variazioni di risoluzione o al ridimensionamento dell'immagine in input.

== Anchor Boxes
Gli algoritmi di object detection campionano solitamente un elevato numero di regioni all'interno dell'immagine d'ingresso, determinano se tali regioni contengono oggetti di interesse e aggiustano progressivamente i confini di ciascuna regione per predire con accuratezza i bounding boxes reali. Le regioni di riferimento campionate preventivamente prendono il nome di _anchor boxes_.

Si consideri un'immagine d'ingresso di altezza $h$ e larghezza $w$. Supponiamo di voler generare anchor box aventi dimensioni e proporzioni differenti centrati su ciascun pixel dell'immagine.

Siano $s in (0,1]$ la scala dell'anchor box rispetto all'immagine e $r gt 0$ l'aspect ratio (rapporto fra larghezza e altezza). La larghezza e l'altezza dell'anchor box vengono calcolate come: $ w_"anchor" = w dot s sqrt(r), space h_"anchor" = h dot s / (sqrt(r)) $

Se definiamo un insieme di $n$ scale distinte $S = {s_1, ..., s_n}$ e un insieme di $m$ rapporti di formati distinti $R = {r_1, ..., r_m}$, la combinazione esaustiva di tutte le scale e di tutti i rapporti di forma su ciascun pixel genererebbe un totale di $h dot w dot n dot m$ anchor box. Per un'immagine ad alta risoluzione, questo numero diventa eccessivamente elevato, comportando un costo computazionale insostenibile.

Per ridurre la complessità mantenendo un'adeguata copertura spaziale, si adotta solitamente la tencica di combinazione ristretta: si combinano tutte le sclale $s_1, ..., s_n$ esclusivamente con il primo rapporto di forma $r_1$ e tutti i rapporti di forma $r_1,...,r_m$ esclusivamente con la prima scala $s_1$.

...

=== Intersection over Union (IoU)
Per valutare quantitivamente il grado di sovrapposizione geometrica tra un anchor box generato $A$ e un bounding box reale di riferimento $B$, si utilizza la metrica *Intersection over Union (IoU)*, nota anche come _indice di Jaccard_. L'IoU è definita come il rapporto tra l'area dell'intersezione dei due rettangoli e l'area della loro unione: $ J(A,B) = ("Area"(A inter B)) / ("Area"(A union B))$

L'IoU assume valori compresi nell'intervallo $[0,1]$:
- Un valore pari a $0$ indica l'assenza completa di sovrapposizione tra i due box.
- Un valore pari a $1$ indica una sovrapposizione perfetta e coincidente delle due regioni.

== Semantic Segmentation
Per ora abbiamo affrontato soltanto il problema della classificazione delle immagini e il rilevamento di oggetti. Tuttavia esistono numerosi applicazioni nelle quali delimitare un oggetto tramite un retangolo risulta del tutto insufficiente. In questi ambiti è indispensabile determinare i contorni esatti e la categoria di ciascun singolo pixel dell'immagine. Questo compito prende il nome di _image segmentation_.

#align(center, image("/assets/image-105.png", width: 50%))

=== Image Segmentation and Instance Segmentation
È fondamentale distinguere tra tre concetti distinti che appartangono alla famiglia della segmentazione:
1. *Image Segmentation*: Rappresenta il processo generico di partizionamento di un'immagine d'ingresso in molteplici regioni disgiunte basandosi su criteri di omogeneità cromatici, di tessitura o di luminanza. Questo approccio tradizionale non assegna necessariamente un significato alle regioni individuate.
2. *Semantic Segmentation*: Consiste nel classificare ciascun pixel dell'immagine assegnandolo a una determinata categoria semantica (persona, auotmobile, cane, gatto, sfondo ecc...). Un aspetto caratteristico della segmentazione semantica è che essa *non distingue* tra istanze individuali della medesima categoria. Se all'interno dell'immagine sono presenti cinque persone distinte, tutti i pixel appartenenti a ciascuna di esse verranno contrassegnati con il medesimo valore di classe intero corrispondente alla categoria persona.
3. *Instance Segmentation*: Fusione tra il rilevamento degli oggetti e la segmentazione semantica. non soltanto individua la classe di appartenenza di ciascun pixel ma separa e distingue nettamente ogni singola istanza individuale appartenente alla medesima categoria. Riprendendo l'esempio precedente quindi la segmentazione delle istanze assegnerà etichette distinte ai pixel delle cinque persone.

=== The Pascal VOC2012 Semantic Segmentation Dataset
Uno dei dataset più importanti per la segmentazione semantica è il Pascal VOC2012. In questo caso le label non sono dei semplici numeri ma sono anch'esse delle immagini dove ogni pixel prende un colore e quel colore indica di cosa fa parte quel pixel.

Avremo quindi un colore per lo sfondo e uno per ogni classe di oggetti, più un altro colore speciale utilizzato come delimitatore fra le classi.

#align(center, image("/assets/image-106.png", width: 50%))

=== Mappatura dalla Color Map agli Indici di Classe
Per poter essere elaborata da una rete neurale, la maschera di etichetta in input espressa come immagine RBG $H times W times 3$ deve essere convertita in una matrice bidimensionale di interi $H times W$ in cui il valore di ciascun elemento compreso nell'intervallo $[0,20]$ corrisponde direttamente all'indice numerico della classe semantica associata. Questa trasformazione viene realizzata costruendo una lookup table che mappa in modo biunivoco ciascuna tripletta di valori cromatici nell'indice intero corrispondente.

=== Data Augmentation
Durante la fase di caricamento dei dati per la segmentazion semantica, le tecniche tradizionali di ridimensionamento e augmentation presentano una complessità aggiuntiva rispetto alla semplice classificazione.

Se si applica un'operazione di ridimensionamento con interpolazione bilioneare su un'immagine di maschera contenente indici discreti, l'interpolazione genererà valori intermedi non esistenti. Di conseguenza, nelle pipeline di addestramento per la segmentazione semantica:
1. L'immagine di input originale viene ridimensionata mediante inerpolazione bilineare, mentre la maschera viene ridimensionata esclusivamente mediante _Nearest Neighbor Interpolation_.
2. Per evitare di alterare le proporzioni degli oggetti, per fare data augmentation si utilizza il _random cropping_. Questa operazione deve essere eseguita in modo sincronizzato sia sull'immagine di input sia sulla maschera, ritagliando esattamente la medesima regione da entrambe le matrici.

== Transposed Convolution
Abbiamo visto come le CNN riducano progressivamente la risoluzione spaziale delle feature map mediante l'impiego di strati convoluzionali con stride superiore a uno o strati di pooling. Questa contrazione spaziale consente alla rete di espandere il receptive field delle unità e di estrarre rappresentazioni semantiche ad alto livello d'astrazione.

Tuttavia in compiti come la segmentazione semantica è indispensabile compiere il percorso inverso ovvero incrementare la risoluzione spaziale di una feature map a bassa risoluzione per ripristinare le dimensioni originali dell'immagine in input.

L'operazione standard ideata per eseguire questo sovracampionamento apprendibile prende il nome di _transposed convolution_.

=== Operazione di Base
Mentre una convoluzione standard riduce o mantiene la dimensione spaziale sommando i prodotti pesati degli elementi coperti dal kernel in un singolo valore d'uscita, la convoluziona trasposta funziona espandendo ciascun elemento dell'input attraverso il filtro.

Nella sua forma bidimensionale, data una matrice d'ingresso di dimensione $H_"in" times W_"in"$ e un kernel di dimensione $k_h times k_w$:
1. Si prende ciascun singolo elemento scalare dell'input e lo si moltiplica elemento per elemento per l'intera matrice del kernel.
2. Si colloca la matrice $k_h times k_w$ risultante nella corrispondente posizione della griglia d'uscita.
3. Le regioni sovrapposte generate dal calcolo dei diversi elementi dell'input vengono sommate tra loro elemento per elemento.

#align(center, image("/assets/image-107.png", width: 50%))

=== Padding, Strides e Canali Multipli
Gli hyperparameters di padding e stide nella convoluzione trasposta regolano l'espansione spaziale dell'output, ma agiscono in modo inversamente speculare rispetto alla convoluzione standard.

Nella convoluzione trasposta il padding viene interpretato come il numero di righe e colonne rimosse dai bordi esterni del risultato finale dell'output. Se si applica un padding $p_h$ sulle regihe e $p_w$ sulle colonne, la dimensione dell'output si riduce di $2 p_h$ in altezza e $2 p_w$ in larghezza.

Lo stride invece nella convoluzione trasposta determina il fattore di incremento spaziale dell'output. Se si applica uno stride $s_h$ sulle righe e $s_w$ sulle colonne, l'operazione posiziona le sottomatrici risultanti dalla moltiplicazione del kernel a una distanza di $s_h$ righe e $s_w$ colonne l'una dall'alatra nell'output. Equivalentemente, questo corrisponde all'inserimento di $s-1$ zeri tra gli elementi adiacenti dell'input prima di applicare la convoluzione.

=== Canali Multipli
Quando l'input comprende $C_"in"$ canali in input e si desiderano produrre $C_"out"$ canali d'uscita, la struttura del tensore dei pesi del kernel ha forma $C_"in" times C_"out" times k_h times k_w$. Si noti la differenza di ordinamento rispetto alla convoluzione standard. Per ciascun canale d'uscita, risultati parziali calcolati su tutti i canali d'ingresso vengono sommati.

=== Origine del termine
Il termine "Convoluzione Traspsota" deriva dal fatto che questa operazione equivale a moltiplicare il vettore input per la matrice trasposta dei pesi di una corrispondente convoluzione standard. Ma è anche importante sottolineare che la convoluzione trasposta non è l'inversa matematica della convoluzione standard.