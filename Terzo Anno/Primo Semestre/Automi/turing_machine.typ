#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= Macchine di Turing
Sono simili agli automi ma con una memoria illimitata e senza restrizioni, sono dei modelli molto più precisi dei computer ma anche loro non sono in grado di risolvere tutti i tipi di problemi, quest'ultimi vanno oltre i limiti teorici della computazione. Come memoria utilizzano un nastro ed hanno una testina posizionata su questo nastro, inizialmente questo contiene soltanto la stringa in input, per scrivere e leggere informazioni sposta la testina. La macchina può raggiungere gli stati di accettazione o rifiuto ma potrebbe anche non raggiungerli andando avanti per sempre.

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
  title: [*In breve*],
  [
    - Possono leggere e scrivere sul nastro
    - Il nastro è infinito
    - La testina si può muovere a destra e sinistra
    - Gli stati di accettazione e rifiuto hanno effetto immediato
  ]
)

Proviamo a costrutire una macchina di Turing $M_1$ che testa l'appartenenza di una stringa al linguaggio $B={w\#w | w in {0,1}^*}$.

La macchina deve quindi capire se l'input è formato da due stringhe uguali separate da un \#. L'idea è di leggere un carattere per stringa e vedere se sono uguali contrassegnandoli, se arriviamo fino alla fine allora siamo in $B$ altrimenti appena troviamo un carattere che non combacia siamo in uno stato di riufiuto.

#align(center, image("img/tm.png", width: 80%))

Questa immagina e la descrizione sopra però illustrano soltanto il funzionamento della macchina ma non tutti i dettagli, possiamo fornire delle descrizione formali analoghe a quelle degli automi finiti e a pila che specificano ogni parte della TM. In pratica però non vengono quasi mai fornite dato che tendono ad essere molto lunghe.

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
  title: [*Definizione Formale*],
  [
    Una macchina di Turing è un 7-tupla $(Q, Sigma, Gamma, delta, q_0, q_"accept", q_"reject")$ dove $Q, Sigma, Gamma$ sono insiemi finiti e:
    - $Q$ è l'insieme degli stati
    - $Sigma$ è l'alfabeto di input non contente il simbolo *blank* $union.sq$
    - $Gamma$ è l'alfabeto del nastro con $union.sq in Gamma$ e $Sigma subset.eq Gamma$
    - $delta: Q times Gamma arrow.r Q times Gamma times {L,R}$ è la funzione di transizione
    - $q_0 in Q$ è lo stato iniziale
    - $q_"accept" in Q$ è lo stato di accettazione
    - $q_"reject" in Q$ è lo stati di rifiuto con $q_"accept" eq.not q_"reject"$ 
  ]
)

La funzione di transizione ci dice come la TM effettua un passo, se abbiamo:

$ delta(q,a) = (r,b,L) $

La TM si trova in un certo stato $q$ e la testina punta alla casella contenente un simbolo $a$, la transizione avviene scrivendo il simbolo $b$ al posto di $a$ e passa allo stato $r$, la componente $L$ o $R$ indica se la testina si muove a sinistra o destra.

Come avviene la computazione? Inizialmente la TM riceve il suo input $w=w_1 w_2 ... w_n in Sigma^*$ sulle $n$ celle più a sinistra del nastro, il resto del nastro è composto dal simbolo `blank`. La TM segue la funzione di transizione scrivendo e leggendo valori e spostando la testina, da notare che se ci troviamo ad un estremo e cerchiamo di spostare la testina oltre allora questa rimarrà ferma. La TM si ferma se raggiunge uno stato di accettazione o rifiuto altrimenti va avanti per sempre.

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
  title: [*Configurazione di una Turing Machine*],
  [
    Per configurazione intendiamo l'impostazione di:
    - Stato corrente
    - Contenuto del nastro
    - Posizione della testina
    Per uno stato $q$ e due stringhe $u,v$ sull'alfebto $Gamma$ scriviamo $u q v$ per indicare la configurazione dove $q$ è lo stato dove ci troviamo mentre il contenuto del nastro è $u v$ e la posizione attuale della testina è il primo simbolo di $v$.

    Ad esempio la configurazione $1011 q_7 01111$ rappresenta la configurazione dove il nastro contiene $101101111$, lo stato corrente è $q_7$ e la testina è posizionata sul secondo 0
  ]
)

Formalizziamo il concetto di *computazione*:
Si dice che la configurazione $C_1$ *produce* la configurazione $C_2$ se la TM può passare da $C_1$ a $C_2$ in un unico passo.
Supponiamo di avere $a,b,c in Gamma$ e $u,v in Gamma^*$ e gli stati $q_i , q_j$ e quindi $u a q_i b v$ e $u q_j a c v$ sono due configurazioni. Diciamo che:

$ u a q_i b v " produce " u q_j a c v $

Se nella funzione di transizione abbiamo $delta(q_i, b) = (q_j, c, L)$ nel caso di uno spostamento a sinistra, se invece avviene uno spostamento a destra diciamo che:

$ u a q_i b v " produce " u a c q_j v $

se $delta(q_i, b) = (q_j, c, R)$

Esiste il caso particolare dove la testina si trova ad una delle estremità, se siamo a sinistra $q_i b v$ produce $q_j c v$ se la transizione comporta una mossa a sinistra e produce $c q_j v$ se comporta una mossa destra. Per l'estremità destra la configurazione $u a q_i$ è equivalente a $u a q_i union.sq$ e possiamo gestirla come prima ma invertita quindi se fa un movimento a destra non si muove mentre a sinistra si.

Definiamo, con input $w$:
- $q_0 w$ come *configurazione iniziale*
- *Configurazione di accettazione* quella dove lo stato è $q_"accept"$
- *Configurazione di rifiuto* quella dove lo stato è $q_"reject"$

Queste ultime due sono dette *configurazioni di arresto* e non producono ulteriori configurazioni.

L'insieme di stringhe che una TM $M$ accetta rappresenta il *linguaggio di $M$* denotato con $L(M)$

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
  title: [*Turing-Riconoscibile*],
  [
    Un linguaggio si dice *turing-riconoscibile* se esiste una macchina di Turing che lo riconosce.
  ]
)

Come detto prima le TM oltre a rifiutare potrebbero anche andare in loop per alcuni input, potrebbe risultare difficile in alcuni casi distinguere una macchina in loop da una che richiede molto tempo, preferiamo per questo delle TM che si fermano ad ogni input e che non ciclano mai, queste sono dette *decisore* perchè in ogni caso prende una decisione o di accettazione o di rifiuto. Un decisore *decide* un certo linguaggio se riconosce tale linguaggio.

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
  title: [*Turing-Decidibile*],
  [
    Un linguaggio si dice *turing-decidibile* o decidibile se esiste una macchina di Turing che lo decide.
  ]
)

= Macchina di Turing Multinastro
È come una normale macchina di Turing ma ha vari nastri ognuno con la propria testina, l'input si trova sul nastro 1 mentre tutti gli altri sono vuoti. Modifichiamo la funzione di transizione per garantire le operazioni su $k$ nastri:

$ delta: Q times Gamma^k arrow.r Q times Gamma^k times {L,R,S}^k $

L'espressione:

$ delta(q_i, a_1, ..., a_k) = (q_j, b_1, ..., b_k, L, R, ..., L) $

Significa che se la macchina si trova in $q_i$ e le testine da $1$ a $k$ leggono i simboli da $a_1$ ad $a_k$ la macchina va in $q_j$ e scrive i simboli da $b_1$ a $b_k$ e muove ogni testina a sinistra, destra o la restare ferma.

Queste macchine multinastro potrebbero sembrare più potenti della classiche macchine di Turing ma in realtà sono equivalenti, riconoscono quindi lo stesso linguaggio.

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
  title: [*Teorema*],
  [
    Per ogni macchina di Turing multinastro esiste una macchina di Turing a nastro singolo equivalente.
  ]
)

*Dimostrazione* - Indichiamo con $M$ una macchina multinastro e con $S$ una a nastro singolo, vogliamo simulare $M$ tramite $S$, quindi se $M$ ha $k$ nastri dobbiamo fare in modo di memorizzare tutte le informazioni di questi nastri su un singolo nastro, utilizziamo il simbolo $\#$ come delimitatore per separare i contenuti dei nastri. Dobbiamo però memorizzare anche la posizione delle testine e lo facciamo scrivendo $\^$ sopra ai simboli puntati da una testina.

Esempio di simulazione di 3 nastri in un singolo nastro:

#align(center, image("img/multinastro.png", width: 80%))

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
  title: [*Corollario*],
  [
    Un linguaggio è Turing-Riconoscibile se e solo se qualche macchina di Turing multinastro lo riconosce.

    Un linguaggio è Turing-Riconoscibile allora è riconosciuto da una macchina di Turing ordinaria che è un caso particolare di una multinastro.

    L'altro verso del corollario, ovvero una macchina multinastro riconosce un linguaggio allora questo è turing riconosbile è dato dal teorema che ci dice che macchine multinastro e a singolo sono equivalenti.
  ]
)

== Macchina di Turing non Deterministica
In qualsiasi punto della computazione la macchina può procedere effettuando più di una scelta, la funzione di transizione diventa:

$ delta: Q times Gamma arrow.r cal(P)(Q times Gamma times (L,R)) $

La computazione quindi è un albero dove i rami corrispondono alle scelte effettuate, se un ramo porta ad uno stato di accettazione allora la macchina accetta.

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
  title: [*Teorema*],
  [
    Per ogni macchina di Turing non deterministica esiste una macchina di Turing deterministica equivalente.
  ]
)

*Idea Dimostrazione* - L'idea è di simulare qualsiasi TM non deterministica $N$ con una TM deterministica $D$ ovvero provare tutte le possibili scelte che può fare $N$ durante la computazione non deterministica, se $D$ trova uno stato di accettazione su uno qualsiasi dei rami allora accetta.

Immaginiamo la computazione di $N$ su un input $w$ come un albero dove i rami rappresentano una scelta non deterministica e i nodi le configurazioni di $N$, la radice sarà quindi la configurazione iniziale. Dobbiamo quindi eseguire una ricerca su questo albero, la prima idea sarebbe una DFS ma in questo modo potrebbe finire ad esplorare un ramo infinito e non terminare mai più, dobbiamo utilizzare una BFS, una visita in ampiezza, in questo modo esploriamo prima tutti i rami alla stessa profondità.

*Dimostrazione* - Costruiamo una TM $D$ con 3 nastri (sappiamo che è equivalente ad averlo soltanto uno):
- Il nastro 1 contiene la stringa in input e non viene mai modificato
- Il nastro 2 mantiene una copia del nastro di $N$ corrispondente a qualche diramazione della sua computazione non determinisitca.
- Il nastro 3 tiene traccia della posizione di $D$ nell'albero delle computazioni di $N$.

Consideriamo la rappresentazione dei dati sul terzo nastro. Ogni nodo può avere al massimo $b$ figli dove $b$ è la dimensione del più grande insieme di scelte possibili date dalla funzione di transizione di $N$.
Assegniamo ad ogni nodo un indirizzo ovvero una stringa nell'alfabeto $Gamma_b = {1,2,...,b}$, assegneremo ad esempio l'indirizzo $231$ al nodo a cui si arriva partendo dalla radice, spostandosi sul secondo figlio poi da lui al terzo figlio ed infine al primo figlio. *Ogni simbolo ci indica quindi il successivo figlio da considerare*.

Gli indirizzi sono *non validi* se un simbolo non corrisponde a nessuna scelta, invece una stringa vuota indica l'indirizzo della radice.

Descriviamo quindi $D$:
- Il nastro 1 contiene l'input $w$ e i nastri 2 e 3 sono vuoti.
- Copia il nastro 1 sul nastro 2 ed inizializza la stringa sul nastro 3 a $epsilon$
- Utilizza il nastro 2 per simulare $N$ con input $w$ su una ramificazione della sua computazione non deterministica. Prima di ogni passo però consulta il simbolo successivo sul nastro 3 per determinare quale scelta fare tra quelle consentite dalla funzione di transizione di $N$. Se non rimangono simboli o se non sono validi interrompe il cammino andando alla fase successiva. Si va alla fase successiva anche in caso di rifiuto, se invece troviamo un caso accettante allora accettiamo.
- Sostituisce la stringa sul nastro 3 con la stringa successiva rispetto all'ordine delle stringhe, simula la ramificazione successiva della computazione di $N$ andando al passo 2.ù

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
  title: [*Corollario*],
  [
    Un linguaggio è Turing-Riconoscibile se e solo se esiste una macchina di Turing non deterministica che lo riconosce.
  ]
)

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
  title: [*Corollario*],
  [
    Un linguaggio è decidibile se e solo se esiste una macchina di Turing non deterministica che lo decide.
  ]
)

#showybox(
  frame: (
    border-color: blue.lighten(60%),
    title-color: blue.lighten(60%),
    body-color: blue.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Storia degli Algoritmi*],
  [
    Lo metto perché sembra interessante.

    Inizialmente non c'era una definizione formale di algoritmo, si consideravano un insieme di istruzioni da eseguire per l'esecuzione di un compito. Nel 1900, il matematico *David Hilbert* identificò 23 problemi matematici e li pose come sfida per il secolo successivo, il decimo di questi problemi riguardava proprio gli algoritmi.

    Il problema consiste nell'ideare un algoritmo per verificare se un polinomio abbia o meno una radice intera, lui non usò il termine _algoritmo_ ma _"un processo in base al quale esso può essere determinato da un numero finito di operazioni"_.

    Noi adesso sappiamo che non esiste un algoritmo per risolvere questo problema, ma al tempo per dimostrare che non esisteva c'era bisogno di una definizione formale di algoritmo, questa arrivò nel 1936 da *Alonzo Church* ed *Alan Turing*.

    Church utilizzò un sistema di notazione chiamato $lambda$-calcolo mentre Turing con le sue "macchine", è stato dimostrato che queste definizioni sono equivalenti e adesso la definizione è chiamata *Tesi di Church-Turing*.

    Nel 1970 fu dimostrato che non esiste algoritmo capace di verifcare se un polinomio ha radici intere.
  ]
)