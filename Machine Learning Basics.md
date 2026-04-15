## Learning Algorithms
Un algoritmo di machine learning è in grado di **imparare** dai dati. Ma cosa intendiamo con _imparare_?

> [!quote] Mitchell (1997)
> A computer program is said to learn from experience _E_ with respect to some class of tasks _T_ and performance measure _P_, if its performance at tasks in _T_, as measured by _P_, improves with experience _E_.

## The Task, _T_
Il Machine Learning ci permette di affrontare _tasks_ che sarebbero troppo difficili con dei semplici programmi.
Cercando di dare la definizione di tasks è importante notare che il processo di apprendimento **non** è la task ma il mezzo con il quale otteniamo le capacità di svolgere il task.

Gli algoritmi di machine learning di solito vengono descritti in base a come dovrebbero processare un **example**. Un example è una collezione di **features** che sono state misurate da un oggetto o evento che vogliamo far processare all'algoritmo.
Rappresentiamo l'example come un vettore $x \in \mathbb{R}^n$ dove ogni valore $x_{i}$ è una feature.
_Ad esempio, le features di un'immagine sono i pixel che la compongono_.

Con algoritmi di machine learning possiamo risolvere tantissimi tipi di tasks, tra i più importanti:
- **Classification**: Viene chiesto all'algoritmo di specificare a quali $k$ categorie appartiene l'input.
  In generale viene chiesto all'algoritmo di produrre una funzione $f:\mathbb{R}^n \to \{1,\dots,k\}$, quando $y=f(x)$ il modello assegna all'input descritto da $x$ la categoria identificata da $y$.
  Un esempio di classification è il riconoscimento di oggetti, quindi come input abbiamo un'immagine e come output un codice numerico che identifica l'oggetto nell'immagine.

- **Classification with missing inputs**: La classification diventa più difficile se l'algoritmo non è sicuro di trovare tutti i dati nel suo vettore di input. _Ad esempio in campo medico non sempre abbiamo a disposizione tutte le visite possibili magari perché sono troppo invasive o costose._
  L'algoritmo deve quindi essere in grado di lavorare anche quando manca qualche dato, per fare questo l'algoritmo non deve più definire una singola funzione ma un **set di funzioni**, ogni funzione corrisponde a mappare l'input $x$ se manca un sottoinsieme di dati.
  Quindi se abbiamo $n$ variabili in ingresso l'algoritmo dovrà mappare $2^n$ funzioni ma spesso è inefficiente e su alcuni sistemi impossibile, per risolvere il problema l'algoritmo dovrà imparare la **distribuzione di probabilità congiunta** di tutte le variabili.
  In pratica deve creare una mappa che mette in relazione fra loro tutte le variabili (_ad es. malattie, visite e sintomi_) le loro dipendenze e quanto spesso si verificano insieme, quando un dato manca il modello **marginalizza** il dato ovvero "elimina" l'impatto della variabile mancante calcolando una media ponderata di tutti i possibili valori che l'esame avrebbe potuto avere basandosi sulle altre variabili presenti.

- **Regression**: Viene chiesto all'algoritmo di predire un valore numerico dato un input. In questo caso viene chiesto all'algoritmo di fornire una funzione $f:\mathbb{R}^n \to \mathbb{R}$.
  _Ad esempio nelle compagnie di assicurazioni o in algorithmic trading_.

- **Transcription**: Qui viene chiesto all'algoritmo di osservare la rappresentazione, non strutturata, di alcuni dati e trasformarla in testo.
  _Ad esempio viene fornita una foto con del testo e vogliamo che ci venga fornito il testo in output come caratteri, oppure il riconoscimento vocale delle parole._

- **Machine Translation**: In questo caso l'input è già in forma di testo, semplicemente viene fornito in una lingua e l'algoritmo deve convertirlo in un'altra.

- **Structured Output**: Comprendono ogni tasks dove l'output è un vettore e dove le relazioni tra gli elementi sono molto importanti. Qui non ci basta una semplice risposta tipo "La mail è spam o no?" ma vogliamo delle risposte strutturata e complesse.
  Alcuni esempi sono **parsing** ovvero una sorta di analisi grammaticale dove l'algoritmo deve classificare ogni parola (verbo, aggettivo, avverbio...), la **segmentazione delle immagini** ovvero indicare ogni pixel a cosa appartiene (strada, prato, macchina....) oppure le **didascalie per immagini (image captioning)** ovvero forniamo all'algoritmo un'immagine e lui ci fornisce un testo che la descrive.
  In sintesi in questi problemi gli algoritmi non devono soltanto indovinare dei valori ma produrre valori che hanno senso relazionati fra loro.

- **Anomaly Detection**: L'algoritmo riceve una serie di eventi od oggetti e identifica quali fra quelli sono diversi dal solito. _Un esempio di utilizzo è per rilevare i furti di carte di credito o simili._

- **Synthesis and sampling**: In questi problemi viene chiesto all'algoritmo di generare esempi simili a quelli che ha utilizzato in fase di allenamento. Questo può essere utile quando potrebbe essere molto noioso o costoso recuperare tanti dati per il modello.

- **Imputation of missing values**: Viene dato all'algoritmo un nuovo esempio $x \in \mathbb{R}^n$ ma con alcuni valori $x_{i}$ mancanti, l'algoritmo deve essere in grado di indovinare questi valori.

- **Denoising**: Viene dato all'algoritmo un esempio corrotto $\overline{x} \in \mathbb{R}^n$ ottenuto tramite un processo corrotto da un esempio pulito $x\in \mathbb{R}^n$. L'algoritmo deve indovinare l'esempio pulito $x$ dalla sua versione corrotto $\overline{x}$ o, in generale, indovinare la distribuzione di probabilità condizionata $p(x|\overline{x})$.

- **Density estimation or probability mass function estimation**: Viene chiesto all'algoritmo di imparare una funzione $p_{\text{model}}:\mathbb{R}^n \to \mathbb{R}$ dove $p_{\text{model}}(x)$ può essere interpretata come **funzione di densità di probabilità** se $x$ è continua oppure come **funzione di probabilità** se $x$ discreta.
  Stiamo chiedendo all'algoritmo di comprendere la "mappa" o le regole dell'universo di dati che sta osservando.
  Imparare quella funzione per l'algoritmo significa capire dove i dati si raggruppano e dove invece sono rari o impossibili.
  In realtà quasi tutti gli algoritmi di ML fanno questo implicitamente ma se riusciamo a calcolarla in modo esplicito per l'universo dei nostri dati possiamo risolvere tutti gli altri problemi, ad esempio per l'imputation se abbiamo già calcolato la mappa di come si comportano i pazienti $p(x)$ e arriva un paziente a cui manca un esame $x_{i}$ non abbiamo bisogno di un nuovo algoritmo, usiamo le regole della probabilità condizionata calcolando $p(x_{i}|x_{-i})$.
  
  Ovviamente calcolare questa mappa completa dei nostri dati è spesso computazionalmente intrattabile per problemi reali.

## The Performance Measure, _P_
Per valutare le performance di un algoritmo di ML dobbiamo creare una misura quantitativa, di solito una misura _P_ è specifica per una task _T_.
Per task come _classification, classification with missing inputs e transcription_, spesso si misura l'**accuracy** del modello ovvero la proporzione di esempi per i quali il modello produce output corretto. Otteniamo le stesse informazioni se ad esempio misuriamo l'**error rate** ovvero per quanti esempi fornisce output errato.

Per task come _density estimation_ non ha senso misurare l'accuracy o l'error rate ma va usata una metrica che fornisca un "punteggio continuo", vogliamo valutare quanto il modello sia coerente con la realtà:
- Se diamo al modello dati reali e lui aveva predetto che questi avevano un'alta probabilità di esistere -> voto alto.
- Se diamo dati reali e aveva stimato una bassa probabilità -> voto basso.

La soluzione è utilizzare la **average log-probability**:
1) Si prende un insieme di test.
2) Si chiede al modello, per ogni test, quale era la probabilità secondo la sua mappa.
3) Queste probabilità sono numeri molto piccoli e per non andare incontro a problemi di underflow si utilizza il logaritmo.
4) Si sommano tutte queste log-probabilità e si fa la media.

Un altro fattore importante è il come decidiamo di valutare l'algoritmo, _ad esempio_:
- Se deve fare trascrizioni e scrive "il ratto è sul tavolo" invece di "il gatto è sul tavolo" gli diamo un voto di 0 oppure un 80% dato che ha comunque indovinato 4 parole su 5?
- È meglio un algoritmo che sbaglia sempre di pochissimo oppure un algoritmo sempre preciso ma che quando sbaglia, anche se raramente, di valori enormi?

Tutto dipende a cosa servirà il sistema ma anche al budget o altre scelte di design.

## The Experience, _E_
Possiamo dividere gli algoritmi di ML in due categorie in base al tipo di experience che fanno durante il processo di apprendimento:
- **Unsupervised**
- **Supervised**

Molti algoritmi che vedremo hanno imparato da interi **dataset**, una collezione di examples (data points).
Uno dei dataset più vecchi è il **Iris dataset**, una collezione di misurazioni di diverse parti di 150 piante, ogni pianta corrisponde ad una example mentre le features di ogni example sono le misurazioni di ogni parte della pianta.

**Unsupervised learning algorithms** - Prendono il dataset ed imparano proprietà della struttura di quel dataset, in deep learning vogliamo imparare l'intera distribuzione della probabilità che ha generato il dataset.

**Supervised learning algorithms** - 