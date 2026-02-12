Skippo parte su automi finiti, mi sembra che non ci siano dimostrazioni

# Linguaggi Regolari
Un linguaggio si dice regolare se esiste un automa che lo riconosce.

## Chiusura per Unione
Supponiamo di avere due automi $M_{1} = (Q_{1}, \Sigma, \delta_{1}, q_{1}, F_{1}), M_{2}=(Q_{2}, \Sigma, \delta_{2}, q_{2}, F_{2})$ che riconoscono, rispettivamente, i linguaggi $A_{1},A_{2}$. Costruiamo un DFA $M$ che riconosce il linguaggio $A_{1} \cup A_{2}$ dove $M=(Q,\Sigma,\delta,q_{0},F)$. 

$M$ sarà composto da:
- $Q = \{(r_{1}, r_{2})|r_{1} \in Q_{1} \wedge  r_{2} \in Q_{2}\}$ ovvero il prodotto cartesiano $Q_{1} \times Q_{2}$
- $\Sigma$ é l'alfabeto, per semplicità assumiamo lo stesso degli altri automi
- $\delta$ é la funzione di transizione definita come:

$$\delta((r_{1},r_{2}),a)=(\delta_{1}(r_{1},a),\delta_{2}(r_{2},a))$$

Quindi la funzione prende in input una coppia di stati e un carattere e restituisce un'altra coppia di stati.
- $q_{0}$ é la coppia $(q_{1},q_{2})$
- $F$ é l'insieme delle coppie dove almeno uno stato fa parte degli stati accettanti di $M_1$ o $M_2$

La costruzione dell'automa, essendo molto semplice, basta come dimostrazione, in altri casi va fatta una dimostrazione piú approfondita.

# Non Determinismo
In un automa non deterministico possono esistere diverse scelte per lo stato successivo in ogni punto.

Un NFA é definito come una quintupla composta da:
- $Q$ insieme finito degli stati
- $\Sigma$ alfabeto finito
- $\delta: Q \times \Sigma_{\epsilon} \to \mathcal{P} (Q)$
- $q_{0} \in Q$ é lo stato iniziale
- $F \subseteq Q$ é l'insieme degli stati di accettazione

L'NFA si troverà in un insieme di stati e ad ogni transizione va in un nuovo insieme di stati.

## Equivalenza fra NFA e DFA
Dobbiamo mostrare che per ogni NFA esiste un DFA equivalente, il DFA dovrà ricordare tutti gli stati in cui si trova l'NFA quindi se ad esempio l'NFA ha $k$ stati allora il DFA ne avrà $2^k$.

Sia $N=(Q,\Sigma,\delta,q_{0},F)$ l'NFA che riconosce un linguaggio $A$ costruiamo un DFA $M=(Q',\Sigma,\delta',q_{0}', F')$ che riconosce $A$. Prima di costruirlo interamente consideriamo il caso in cui non ci sono $\epsilon-archi$:

1. $Q' = \mathcal{P}(Q)$, quindi ogni stato di $M$ corrisponde ad un insieme di stati di $N$
2. La funzione di transizione é definita come:

$$\delta' (R,a) = \bigcup_{r \in R} \delta(r,a)$$

Con $R \in Q'$ e $a \in \Sigma$, quindi ogni transizione simula l'NFA su tutti gli stati $r$ con input $a$ e restituisce come risultato l'insieme somma di questi stati.
3. $q_{0}' = \{q_{0}\}$
4. $F'=\{R \in Q' | \text{R contiene uno stato accettante di N} \}$

Per considerare anche gli $\epsilon-archi$ introduciamo altre notazioni, per ogni stato $R$ di $M$ definiamo $E(R)$ come la collezione di stati che possono essere raggiunti dagli elementi di $R$ proseguendo solo con $\epsilon-archi$ includendo anche gli elementi stessi. Formalmente per $R \subseteq Q$ abbiamo:

$$E(R)=\{q | q \text{puó essere raggiunto da R attraverso 0 o piú } \epsilon-archi\}$$

Adesso modifichiamo anche la funzione di transizioni considerando appunto tutti gli stati raggiungibili tramite epsilon archi:

$$\delta' (R,a) = \bigcup_{r \in R} E(\delta(r,a))$$

## Chiusura per Unione (con NFA)
Presi due linguaggi regolari $A_{1}, A_{2}$ vogliamo provare che $A_{1} \cup A_{2}$ é regolare, l'idea é quella di prendere due NFA $N_{1},N_{2}$ che riconoscono rispettivamente i linguaggi $A_{1},A_{2}$ e comporli in un nuovo NFA $N$.

L'NFA $N$ deve accettare il suo input se $N_{1} \ o \ N_{2}$ accetta questo input, questa macchina avrá un nuovo stato iniziale che tramite due epsilon-archi si collega agli stati iniziali dei due precedenti NFA, se una di queste accetta allora anche $N$ accetta.

![[Pasted image 20251228164848.png|250]]

Siano:
- $N_{1} = (Q_{1}, \Sigma, \delta_{1},q_{1},F_{1})$ che riconosce $A_1$
- $N_{2}=(Q_{2},\Sigma,\delta_{2},q_{2},F_{2})$ che riconosce $A_2$

Costruiamo $N=(Q,\Sigma,\delta,q_{0},F)$ che riconosce $A_{1} \cup A_{2}$
- $Q = \{q_{0}\} \cup Q_{1} \cup Q_{2}$, infatti abbiamo solo un nuovo stato iniziale
- L'insieme degli stati accettanti é $F=F_{1} \cup F_{2}$ ovvero tutti gli stati accettanti degli NFA $N_{1},N_{2}$
- Definiamo $\delta$ in modo che per ogni $q \in Q$ e ogni $a \in \Sigma_{\epsilon}$:

$$
\delta(q,a)=
\begin{cases}
\delta_{1} (q,a) \quad q \in Q_{1} \\
\delta_{2} (q,a) \quad q \in Q_{2} \\
\{q_{1},q_{2}\} \quad q = q_{0} & a=\epsilon \\
\emptyset \qquad\ \ \ \ \ \ \  q = q_{0} & a \not = \epsilon
\end{cases}
$$

## Chiusura per Concatenazione
Ricordiamo che la concatenazione di due linguaggi é data da:

$$
L_{1} \circ L_{2} = \{xy : x \in L_{1} \wedge y \in L_{2}\}
$$

L'idea é, presi due linguaggi $A_{1},A_{2}$ e vogliamo provare che $A_{1} \circ A_{2}$ é regolare. Prendiamo due NFA $N_{1},N_{2}$ per $A_{1},A_{2}$ e li combiniamo in nuovo NFA $N$.
Poniamo come stato iniziale di $N$ lo stato iniziale $N_{1}$, gli stati accettanti di $N_{1}$ hanno degli ulteriori epsilon archi che ci portano in $N_{2}$ ogni volta che $N_{1}$ é in uno stato accettante indicando che ha trovato un pezzo iniziale dell'input che corrisponde ad una stringa di $A_{1}$.
Quindi gli stati accettanti di $N$ sono soltanto quelli di $N_{2}$, perché prima riconosciamo una stringa di $N_{1}$ e poi ci spostiamo in $N_{2}$.

![[Pasted image 20251228175053.png]]

Siano:
- $N_{1}=(Q,\Sigma,\delta_{1},q_{1},F_{1})$ che riconosce $A_{1}$
- $N_{2}=(Q_{2},\Sigma,\delta_{2},q_{2},F_{2})$ che riconosce $A_{2}$

Costruiamo $N=(Q,\Sigma,\delta,q_{1},F_{2})$ per riconoscere $A_{1} \circ A_{2}$:
- $Q = Q_{1} \cup Q_{2}$
- Lo stato iniziale é $q_{1}$ uguale a quello di $N_{1}$
- Gli stati accettanti sono uguali a quelli di $N_{2}$
- Definiamo $\delta$ in modo che per ogni $q \in Q$ e ogni $a \in \Sigma_{\epsilon}$:

$$
\delta(q,a) = 
\begin{cases}
\delta_{1} (q,a) &  q \in Q_{1} & q \not \in F_{1} \\
\delta_{1} (q,a)  &  q \in F_{1} & a \not = \epsilon \\
\delta_{1} (q,a) \cup \{q_{2}\}  &  q \in F_{1} & a = \epsilon \\
\delta_{2} (q,a)  &  q \in Q_{2}
\end{cases}
$$

## Chiusura per operazione Star
Abbiamo un linguaggio regolare $A_{1}$ e vogliamo provare che anche $A_{1}^*$ é regolare.
Prendiamo un NFA $N_{1}$ per $A_{1}$ e lo modifichiamo per riconoscere $A_{1}^*$, l'NFA $N$ risultante accetterà il suo input quando può essere diviso in varie parti ed $N_{1}$ accetta ogni parte.

Possiamo costruire $N$ come $N_{1}$ ma con degli epsilon-archi che dagli stati accettanti ritornano allo stato iniziale, in questo modo quando l'elaborazione per una parte che $N_{1}$ accetta, la macchina $N$ ha la scelta di tornare indietro per provare a leggere un'altra parte. Inoltre dobbiamo anche far in modo che $N$ accetti $\epsilon$.

Per fare questo ci basta aggiungere un nuovo stato iniziale che con un epsilon-arco si collega al vecchio stato iniziale, gli stati accettanti invece rimangono collegati al vecchio stato iniziale.

![[Pasted image 20251228181928.png]]

Sia:
- $N_{1}=(Q_{1},\Sigma,\delta_{1},q_{1},F_{1})$ che riconosce $A_{1}$
Costruiamo:
- $N=(Q,\Sigma,\delta,q_{0}, F)$ per riconoscere $A_{1}^*$

Abbiamo:
- $Q=\{q_{0}\} \cup Q_{1}$, abbiamo i vecchi stati più un nuovo stato iniziale
- Lo stato $q_{0}$ é il nuovo stato iniziale
- $F=\{q_{0}\}\cup F_{1}$, gli stessi stati accettanti ma più il nuovo stato iniziale
- La funzione $\delta$ é definita in modo che per ogni $q\in Q$ e ogni $a\in \Sigma_{\epsilon}$:

$$
\delta(q,a)=\begin{cases}
\delta_{1}(q,a) & q \in Q_{1} & q \not \in F_{1} \\
\delta_{1}(q,a) & q \in F_{1} & a \not = \epsilon \\
\delta_{1}(q,a)\cup \{q_{1}\} & q \in F_{1} & a = \epsilon \\
\{q_{1}\} & q=q_{0} & a=\epsilon \\
\emptyset  & q=q_{0}  & a\not = \epsilon
\end{cases}
$$


# Espressioni Regolari
Possiamo usare le operazioni regolari per costruire espressioni che descrivono linguaggi, queste sono chiamate **espressioni regolari**, ad esempio:

$$(0 \cup 1) 0^*$$

In questo caso il valore é il linguaggio che consiste in tutte le stringhe che iniziano per 0 o 1 e sono seguite da un numero qualsiasi di 0.
L'ordine delle operazioni nelle espressioni regolari é:
- Star
- Concatenazione
- Unione
Ovviamente bisogna seguire prima la precedenza fornita dalle parentesi.

_Definizione Formale_:
Diciamo che $R$ é un'espressione regolari se R é:
- $a$ per qualche $a$ nell'alfabeto $\Sigma$
- $\epsilon$
- $\emptyset$
- $(R_{1} \cup R_{2})$ dove $R_{1}$ ed $R_{2}$  sono espressioni regolari
- $(R_{1} \circ R_{2})$ dove $R_{1}$ ed $R_{2}$  sono espressioni regolari
- $(R_{1}^*)$ dove $R_{1}$ é un'espressione regolare

Vengono definite quindi in termini di altre espressioni regolari sempre piú piccole, questo tipo di definizione é chiamata **definizione induttiva**.

Denotiamo inoltre con $R^+$ l'espressione $RR^*$ ovvero tutte le stringhe che sono concatenazione di 1 o piú stringhe di $R$, la differenza con $R^*$ sta nel fatto che quest'ultima contiene la concatenazione di 0 o piú stringhe e quindi anche la stringa vuota.
Denotiamo anche con $R^k$ la concatenazione di $k$ copie di $R$ insieme.

Inoltre per differenziare un'espressione regolare $R$ e il linguaggio che descrive indichiamo questo con $L(R)$

## Equivalenza con gli automi finiti
Le espressioni regolari e gli automi finiti sono equivalenti, ogni espressione regolare può essere trasformata in un automa finito che riconosce il linguaggio che essa descrive e viceversa.

_Dimostrazione - Parte 1_
Se un linguaggio é descritto da un'espressione regolare allora esso é regolare.

Supponiamo di avere un'espressione regolare $R$ che descrive un linguaggio $A$, mostriamo come trasformare $R$ in un NFA che riconosce $A$, in questo modo dimostriamo che $A$ é regolare dato che é riconosciuto da un NFA.

Per creare l'NFA consideriamo i sei casi per costruire un'espressione regolare:
1. $R=a$ per qualche $a \in \Sigma$ allora $L(R)=\{a\}$ e il seguente NFA riconosce $L(R)$

![[Pasted image 20260102174635.png]]

Formalmente abbiamo che $N=(\{q_{1},q_{2}\}, \Sigma, \delta, q_{1},\{q_{2}\})$ e descriviamo $\delta$ con $\delta(q_{1},a)=\{q_{2}\}$ e $\delta(r,b)=\emptyset$ per $r \not = q_{1}$ o $b \not = a$

2. $R=\epsilon$, allora $L(R)=\{\epsilon\}$ e il seguente NFA riconosce $L(R)$:

![[Pasted image 20260102174920.png]]

Formalmente abbiamo che $N=(\{q_{1}\},\Sigma,\delta,q_{1},\{q_{1}\})$ dove $\delta(r,b)=\emptyset$ per ogni $r,b$

3. $R=\emptyset$, allora $L(R)=\emptyset$ e il seguente NFA riconosce $L(R)$

![[Pasted image 20260102175119.png]]

Formalmente abbiamo che $N=(\{ q \}, \Sigma,\delta,q,\emptyset)$ e $\delta(r,b)=\emptyset$ per ogni $r,b$

4. $R=R_{1} \cup R_{2}$
5. $R=R_{1} \circ R_{2}$
6. $R=R_{1}^*$

Per questi ultimi 3 utilizziamo i teoremi che ci dicono che i linguaggi regolari sono chiusi rispetto alle operazioni di unione, concatenazione e star.

_Esempio_ - Costruiamo l'automa che riconosce l'espressione regolare $(ab \cup a)^*$:

![[Pasted image 20260102180043.png]]

_Dimostrazione - Parte 2_
Se un linguaggio é regolare allora é descritto da un'espressione regolare.

Se $A$ é regolare allora esiste un DFA che lo descrive, descriviamo quindi una procedura per trasformare un DFA in un'espressione regolare. Per fare questo usiamo un nuovo tipo di automa chiamato **automa finito non deterministico generalizzato** GNFA.

---

Come trasformiamo un DFA in un GNFA? Nei GNFA gli archi delle transizioni possono avere espressioni regolari come etichette quindi questi leggono blocchi di simboli dall'input. Per comodità però vogliamo che i GNFA abbiano sempre una forma che soddisfi le seguenti condizioni:
- Lo stato iniziale ha archi di transizione uscenti verso un qualsiasi altro stato ma nessun arco entrante proveniente da un qualsiasi altro stato.
- Esiste un solo stato accettante ed esso ha solo archi entranti provenienti da un qualsiasi altro stato ma nessun arco uscente verso un qualsiasi altro stato. Lo stato accettante non é uguale allo stato iniziale.
- Eccetto che per lo stato iniziale e lo stato accettante, un arco va da ogni stato ad ogni altro stato e anche da ogni stato in sé stesso.

Per trasformare un DFA in GNFA possiamo aggiungere un nuovo stato iniziale con un epsilon arco che entra nel vecchio stato iniziale e un nuovo stato accettante con epsilon archi entranti da tutti i vecchi stati accettanti.
Se alcuni archi hanno più etichette oppure ci sono più archi che collegano due stati allora li sostituiamo con un unico arco la cui etichetta é l'unione delle precedenti etichette.
Infine aggiungiamo archi con etichetta $\emptyset$ tra stati che non hanno archi.

Adesso vediamo come trasformare un GNFA in un'espressione regolare.

Supponiamo che il GNFA abbiamo $k$ stati ma siccome quello iniziale e quello accettante sono sicuramente diversi allora $k\geq 2$. Se $k > 2$ allora costruiamo un GNFA equivalente con $k-1$ stati e questo passo può essere ripetuto sul GNFA successivo fino a quando esso é ridotto a due stati.
Se $k=2$ allora il GNFA ha un solo arco che  va dallo stato iniziale allo stato accettante e l'etichetta di questo arco é l'espressione regolare equivalente.

Per rimuovere uno stato dobbiamo sceglierne uno, rimuoverlo e fare in modo che la macchina riconosca comunque il linguaggio, può essere scelto un qualsiasi stato tranne quello iniziale e quello accettante.

Chiamiamo $q_{rip}$ lo stato rimosso, dopo averlo rimosso modifichiamo la macchina cambiano le espressioni regolari nelle etichette dei restanti archi in modo che controbilancino l'assenza di $q_{rip}$. La nuova etichetta che va da uno stato $q_{i}$ a uno stato $q_{j}$ é un'espressione regolare che descrive tutte le stringhe che porterebbero la macchina da $q_i$ a $q_{j}$ o direttamente o tramite $q_{rip}$, _ad esempio:_

![[Pasted image 20260103180807.png]]

In questo caso possiamo andare da $q_{i}$ a $q_{j}$ o con tutto il percorso tramite $q_{rip}$ e quindi le stringhe composte da $R_{1}\circ R_{2}^* \circ R_{3}$ oppure con quello precedente ovvero $R_{4}$.

Più formalmente abbiamo che, nella vecchia macchina se:
1. $q_{i}$ va a $q_{rip}$ con un arco etichettato $R_{1}$
2. $q_{rip}$ va in sé stesso con un arco etichettato $R_{2}$
3. $q_{rip}$ va a $q_{j}$ con un arco etichettato $R_{3}$
4. $q_{i}$ va a $q_{j}$ con un arco etichettato $R_{4}$

allora nella nuova macchina l'arco da $q_{i}$ a $q_{j}$ riceve l'etichetta:

$$
(R_{1})(R_{2})^*(R_{3})\cup (R_{4})
$$

Facciamo questa modifica per ogni arco che va da un qualsiasi stato $q_{i}$ a un qualsiasi stato $q_{j}$ includendo il caso $q_{i}=q_{j}$, la nuova macchina riconosce il linguaggio di partenza.

_Dimostrazione_
Definiamo prima di tutto il nuovo tipo di automa, questo é simile ad un automa finito deterministico tranne che per la funzione di transizione che ha la forma:

$$
\delta:(Q-\{ q_{accept} \})\times(Q-\{ q_{start} \}) \to (\mathcal R)
$$

Il simbolo $\mathcal R$ é la collezione di tutte le espressioni regolari sull'alfabeto $\Sigma$ mentre $q_{start}$ e $q_{accept}$ sono gli stati iniziale e accettante.
Se $\delta(q_{i},q_{j})=R$ l'arco dallo stato $q_{i}$ a $q_{j}$ ha come etichetta l'espressione regolare $R$.
Il dominion della funzione di transizione é $(Q-\{ q_{accept} \})\times(Q-\{ q_{start} \})$ perché un arco collega ogni stato a un qualsiasi altro stato, tranne che nessun arco é uscente da $q_{accept}$ o é entrante in $q_{start}$.

> [!info] Definizione
> Un automa finito non deterministico generalizzato é una quintupla $(Q,\Sigma,\delta,q_{start},q_{accept})$ dove:
> - $Q$ é l'insieme finito degli stati
> - $\Sigma$ é l'alfabeto di input
> - $\delta:(Q-\{ q_{accept} \})\times(Q-\{ q_{start} \}) \to (\mathcal R)$ é la funzione di transizione
> - $q_{start}$ é lo stato iniziale
> - $q_{accept}$ é lo stato accettante

Un GNFA accetta una stringa $w$ in $\Sigma^*$ se $w=w_{1}w_{2}\dots w_{k}$ dove ogni $w_{i}$ é in $\Sigma^*$ ed esiste una sequenza di stati $q_{0},q_{1},\dots,q_{k}$ tale che:
1. $q_{0}=q_{start}$ é lo stato iniziale
2. $q_{k}=q_{accept}$ é lo stato accettante
3. Per ogni $i$ risulta $w_{i}\in L(R_{i})$ dove $R_{i}=\delta(q_{i-1},q_{i})$, ovvero $R_{i}$ é l'espressione sull'arco da $q_{i-1}$ a $q_{i}$

---

Adesso possiamo tornare alla seconda parte della dimostrazione del teorema. 

Sia $M$ il DFA per il linguaggio $A$ trasformiamo $M$ in un GNFA $G$ aggiungendo un nuovo stato iniziale e un nuovo stato accettante e i necessari archi di transizione supplementari.
Usiamo la procedura $CONVERT(G)$ che prende un GNFA e restituisce un'espressione regolare equivalente, questa procedura utilizza la ricorsione.

1. Sia $k$ il numero di stati in $G$.
2. Se $k=2$ allora $G$ deve consistere di uno stato iniziale, uno stato accettante e un singolo arco che li collega ed é etichettato con un'espressione regolare $R$. Restituisce l'espressione regolare $R$.
3. Se $k>2$ scegliamo un qualsiasi stato $q_{rip}\in Q$ diverso da $q_{start}$ e $q_{accept}$ e sia $G'$ il GNFA $(Q',\Sigma,\delta',q_{start},q_{accept})$ dove $Q'=Q-\{ q_{rip} \}$ e per ogni $q_{i} \in Q'-\{ q_{accept} \}$ e ogni $q_{j}\in Q'-\{ q_{start} \}$ poniamo

$$
\delta'(q_{i},q_{j})=(R_{1})(R_{2})^*(R_{3})\cup(R_{4})
$$

Dove $R_{1}=\delta(q_{i},q_{rip})$, $R_{2}=\delta(q_{rip},q_{rip})$, $R_{3}=\delta(q_{rip},q_{j})$ e $R_{4}=\delta(q_{i},q_{j})$
4. Calcola $CONVERT(G')$ e restituisce questo valore

Proviamo che il valore ritornato é corretto

_Dimostrazione_
Per ogni GNFA $G$, $CONVERT(G)$ é equivalente a $G$
Dimostriamo per induzione sul numero $k$ di stati del GNFA

_Base_: Per $k=2$ stati il GNFA può avere un solo arco che va dallo stato iniziale a quello accettante, l'espressione regolare che é etichetta di quest'arco descrive tutte le stringhe che permettono a $G$ di raggiungere lo stato accettante. Quest'espressione é equivalente a $G$.

_Passo Induttivo_: Assumiamo che l'affermazione sia vera per $k-1$ stati. Mostriamo che $G$ e $G'$ riconoscono lo stesso linguaggio, supponiamo che $G$ accetti su input $w$, allora in un ramo accettante della computazione $G$ entra in una sequenza di stati:

$$
q_{start},q_{1},q_{2},\dots,q_{accept}
$$

Se nessuno di essi é lo stato rimosso $q_{rip}$ allora anche $G'$ accetta $w$.
Questo perché ciascuna delle nuove espressioni regolari che troviamo sugli archi di $G'$ contiene le vecchie espressioni regolari come parte di un'unione.

Se $q_{rip}$ é presente, eliminando ogni sequenza di stati $q_{rip}$ consecutivi creiamo una computazione accettante per $G'$, infatti gli stati $q_{i},q_{j}$ che raggruppano una tale sequenza hanno una nuova espressione regolare sull'arco tra essi la quale descrive tutte le stringhe che portano da $q_{i}$ a $q_{j}$ attraverso $q_{rip}$ in $G$. Quindi $G'$ accetta $w$.
_Per come costruiamo G' se togliamo rip abbiamo creato le etichette per sotituirlo_

Viceversa supponiamo che $G'$ accetti in input $w$, poiché ciascun arco tra due qualsiasi stati $q_{i},q_{j}$ in $G'$ descrive la collezione delle stringhe che portano da $q_{i}$ a $q_{j}$ in $G$ o direttamente o attraverso $q_{rip}$ allora anche $G$ deve accettare $w$.

Quindi $G$ e $G'$ sono equivalenti

L'ipotesi induttiva afferma che quando l'algoritmo chiama sé stesso ricorsivamente sull'input $G'$ il risultato é un'espressione regolare che é equivalente a $G'$ perché $G'$ ha $k-1$ stati, quindi anche questa espressione regolare é equivalente a $G$ e abbiamo provato che l'algoritmo é corretto.

# Linguaggi Non Regolari
Adesso proviamo che alcuni linguaggi non possono essere riconosciuti da nessun automa finito, capiamo quindi i limiti dei DFA.

Se prendiamo ad esempio il linguaggio $B=\{ 0^n 1^n | n \geq 0 \}$ non riusciremo a trovare un DFA che lo riconosce, la macchina ha bisogno di ricordarsi quanti simboli uguali a 0 ha visto mentre legge l'input, ma siccome il numero di 0 non é limitato non é possibile tenerne traccia con un numero finito di stati.

Però il fatto che il linguaggio sembra richiedere memoria non é una prova sufficiente

## Pumping Lemma per Linguaggi Regolari
Questo teorema afferma che tutti i linguaggi regolari hanno **una proprietá speciale**, se riusciamo quindi a mostrare che un linguaggio non la ha allora siamo sicuri che esso non é regolare.

La proprietá afferma che tutte le stringhe possono essere replicate se la loro lunghezza raggiunge almeno uno specifico valore speciale chiamato **lunghezza del pumping**. Significa che la stringa ha una parte che puó essere ripetuta un numero qualsiasi di volte ottenendo una stringa che appartiene ancora al linguaggio.

> [!info] Teorema
> Se $A$ é un linguaggio regolare, allora esiste un numero $p$ tale che se $s$ é una qualsiasi stringa in $A$ di lunghezza almeno $p$ allora $s$ puó essere divisa in tre parti $s=xyz$ soddisfacenti le seguenti condizioni:
> - per ogni $i\geq 0, xy^iz \in A$
> - $|y|>0$
> - $|xy|\leq p$

Quando $s$ é divisa in $xyz$, $x$ o $z$ potrebbe essere uguale a $\epsilon$ ma la condizione 2 dice che $y\not = \epsilon$, senza questa il teorema sarebbe banalmente vero.

_IDEA_ - Sia $M=(Q,\Sigma,\delta,q_{1},F)$ un DFA che riconosce $A$, assegniamo alla lunghezza del pumping $p$ il numero degli stati di $M$ e mostriamo che ogni stringa $s$ in $A$ di lunghezza almeno $p$ puó essere divisa nelle tre parti $xyz$, soddisfacenti le tre condizioni. Se nessuna stringa in $A$ é di lunghezza almeno $p$ allora il teorema diventa banalmente vero.

Se $s$ in $A$ ha lunghezza almeno $p$ consideriamo la sequenza di stati che $M$ attraversa nella computazione con input $s$. Supponiamo che $n$ sia la lunghezza di $s$, la sequenza di stati attraversati $q_{1},q_{3},q_{20},q_{9},\dots,q_{13}$ ha lunghezza $n+1$.
Poiché $n$ é almeno $p$ (la stringa é accettata) allora $n+1>p$, sappiamo che $p$ é il numero di stati e quindi la sequenza di stati ne contiene sicuramente uno che si ripete.

Vediamo graficamente cosa succede:

![[Pasted image 20260105163835.png]]

Dividiamo $s$ nelle 3 componenti, la componente $x$ é la parte di $s$ che compare prima di $q_{9}$, la componente $y$ é la parte tra le due occorrenze di $q_{9}$ e la componente $z$ é la parte restante di $s$ che viene dopo la seconda occorrenza di $q_{9}$. Perché questa divisione soddisfa le condizioni?

Supponiamo di eseguire $M$ su $xyyz$, sappiamo che:
- $x$ porta $M$ da $q_{1}$ a $q_{9}$
- Il primo $y$ lo porta da $q_{9}$ a $q_{9}$ ma anche il secondo
- $z$ lo porta a $q_{13}$ e poi $M$ accetta.
Analogamente accetterà per ogni $xy^iz$ con $i>0$

La condizione 2 $|y|>0$ é soddisfatta perché $y$ é la parte di $s$ tra due diverse occorrenze dello stato $q_{9}$

Per la condizione 3 ci assicuriamo che $q_{9}$ sia la prima ripetizione nella sequenza e per il principio della piccionaia i primi $p+1$ stati nella sequenza devono contenere una ripetizione quindi $|xy|\leq p$.

_Dimostrazione_
Sia $M=(Q,\Sigma,\delta,q_{1},F)$ un DFA che riconosce $A$ e sia $p$ il numero di stati di $M$.
- Sia $s=s_{1}s_{2}\dots s_{n}$ una stringa in $A$ di lunghezza $n\geq p$
- Sia $r_{1},\dots,r_{n+1}$ la sequenza di stati attraversati da $M$ mentre elabora $s$
Quindi abbiamo che $r_{i+1}=\delta(r_{i},s_{i})$ per $1\leq i \leq n$. Questa sequenza ha lunghezza $n+1$ che é almeno $p+1$.
Due tra i primi $p+1$ stati della sequenza devono essere lo stesso stato per il principio della piccionaia. (Infatti fino $p$ possono essere tutti diversi ma a $p+1$ no, ci sarà almeno una ripetizione).

Chiamiamo il primo di questi $r_{j}$ e il secondo $r_{l}$, poiché $r_{l}$ si presenta tra le prime $p+1$ posizioni in una sequenza che comincia in $r_{1}$ abbiamo che $l\leq p+1$.
Adesso siano
- $x=s_{1}\dots s_{j-1}$
- $y=s_{j}\dots s_{l-1}$
- $z=s_{l}\dots s_{n}$

Poiché
- $x$ porta $M$ da $r_{1}$ a $r_{j}$
- $y$ porta $M$ da $r_{j}$ a $r_{j}$
- $z$ porta $M$ da $r_{j}$ a $r_{n+1}$ che é uno stato accettante
$M$ deve accettare $xy^iz$ per $i\geq 0$, inoltre sappiamo che $j \not = l$ perciò $|y|>0$ e $l\leq p+1$ quindi $|xy|\leq p$. Sono rispettate tutte le condizioni del pumping.


> [!info] Usare il pumping lemma
> Per usare il pumping lemma per provare che un linguaggio $B$ non é regolare:
> - Si assume che $B$ sia regolare
> - Si usa il teorema per trovare una lunghezza $p$ tale che tutte le stringhe di lunghezza maggiore o uguale a $p$ in $B$ possano essere iterate.
> - Si dimostra che $s$ non puó essere iterata considerando tutti i modi di dividere $s$ in $xyz$ e per ognuna di queste divisioni trovare un valore $i$ tale che $xy^iz \not \in B$

# Linguaggi Context-Free
Le grammatiche contex-free sono un metodo piú potente per descrivere linguaggi, queste possono descrivere alcuni aspetti che hanno una struttura ricorsiva.
I linguaggi associati alle grammatiche contex-free sono chiamati **linguaggi context-free**, questi includono i linguaggi regolari ma anche molti altri.

Un esempio di grammatica context-free che chiamiamo $G_{1}$ é:
- $A\to 0A1$
- $A\to B$
- $B \to \#$

Una grammatica consiste di un insieme di **regole di sostituzione** chiamate **produzioni**.
Ogni regola é formata da:

$$
\text{simbolo} \to \text{stringa}
$$

Il simbolo é chiamato anche **variabile** mentre la stringa é composta da variabili e altri simboli chiamati **terminali**. Spesso le variabili sono rappresentate da lettere **maiuscole** mentre i terminali sono simboli dell'alfabeto in input e spesso sono rappresentati da lettere minuscole, numeri o simboli speciali. Una delle variabili é chiamata **variabile iniziale**, generalmente si trova sul lato sinistro della prima regola.

Una grammatica puó essere usata per descrivere un linguaggio generando ogni stringa del linguaggio nel seguente modo:
1. Scrivi la variabile iniziale
2. Trova una variabile che é stata scritta e una regola che inizia con quella variabile, sostituisce la variabile scritta con il lato destro di quella regola
3. Ripeti il passo 2 fino a quando non ci sono piú variabili

Ad esempio la grammatica $G_1$ genera la stringa $000\#111$, una sequenza di sostituzioni per ottenere una stringa é chiamata **derivazione** e in questo caso abbiamo come possibile derivazione:

$$
A \Rightarrow 0A1 \Rightarrow 00A 11 \Rightarrow 000A 111 \Rightarrow 000\#111
$$
Tutte le stringhe generate in questo modo costituiscono il **linguaggio della grammatica** che viene denotato con $L(G)$. Ogni linguaggio che puó essere generato da una grammatica context-free é chiamato **linguaggio context-free** (CFL)

_Definizione Formale di Grammatica Context Free_
Una grammatica context-free é una quadrupla $(V,\Sigma,R,S)$ dove:
1. $V$ é un insieme finito i cui elementi sono chiamati **variabili**
2. $\Sigma$ é un insieme finito, disgiunto da $V$, i cui elementi sono chiamati **terminali**
3. $R$ é un insieme finito di **regole** dove ciascuna regola é una variabile e una stringa di variabili e terminali.
4. $S \in V$ é la variabile iniziale.

Se $u,v,w$ sono stringhe di variabili e terminali e $A\to w$ é una regola della grammatica diciamo che $uAv$ **produce** $uwv$ e lo denotiamo con $uAv \Rightarrow uwv$.
Diciamo che $u$ **deriva** $v$ e le denotiamo con $u \Rightarrow^* v$ se $u=v$ oppure se esiste una sequenza $u_{1},u_{2},\dots,u_{k}$ con $k\geq 0$

> [!info] Ambiguitá
> Se una grammatica genera la stessa stringa in piú modi diversi diciamo che la stringa é derivata ambiguamente in quella grammatica. Se una grammatica genera alcune stringhe ambiguamente diciamo che la grammatica é ambigua.
> É importante notare peró che devono avere un diverso albero sintattico e non due diverse derivazioni, infatti due derivazioni possono differire solo nell'ordine in cui esse sostituiscono le variabili e non nella struttura complessiva.

Definiamo quindi delle regole per dare una nozione di ambiguitá.

Una derivazione di una stringa $w$ in una grammatica $G$ é una **derivazione a sinistra** se a ogni passo la variabile sostituita é quella che si trova piú a sinistra.

_Definizione_
Una stringa $w$ é derivata **ambiguamente** in una grammatica context-free $G$ se essa ha due o piú diverse derivazioni a sinistra. Una grammatica $G$ é ambigua se essa genera qualche stringa ambiguamente.

Qualche volta se abbiamo una grammatica ambigua posiamo trovare una grammatica non ambigua che genera lo stesso linguaggio, tuttavia esistono alcuni linguaggi context-free che possono essere generati solo da grammatiche ambigue questi sono chiamati **inerentemente ambigui**.

## Forma Normale di Chomsky
Quando si lavora con le grammatiche context-free é conveniente averle in forma semplificata, una delle piú semplici é la forma normale di Chomsky.

Una grammatica é in forma normale di Chomsky se ogni regola é della forma:

$$
\begin{align}
&A \to BC \\
&A \to a
\end{align}
$$

Dove $a$ é un terminale e $A,B,C$ sono variabili qualsiasi ma $B,C$ non possono essere la variabile iniziale. Permette anche regole dove $S\to \epsilon$ dove $S$ é la variabile iniziale.

_Teorema_
Ogni linguaggio context-free é generato da una grammatica context-free in formale normale di Chomsky.

_Dimostrazione_
1. Aggiungiamo una nuova variabile iniziale $S_{0}$ e la regola $S_{0}\to S$ dove $S$ era la variabile iniziale di partenza. In questo modo la variabile iniziale non compare sul lato destro di una regola.
2. Si eliminano le $\epsilon-regole$. Eliminiamo una $\epsilon-regola$ $A\to \epsilon$ dove $A$ non é la variabile iniziale poi per ogni occorrenza di $A$ sul lato destro di una regola aggiungiamo una nuova regola con quell'occorrenza cancellata.
Quindi se $R\to uAv$ é una regola in cui $u,v$ sono stringhe di variabili e terminali, aggiungiamo la regola $R\to uv$, facciamo questo per ogni occorrenza di $A$ in modo che la regola $R\to uAvAw$ genererá:
- $R\to uvAw$
- $R\to uAvw$
- $R\to uvw$
Se abbiamo la regola $R\to A$ aggiungiamo $R\to \epsilon$ a meno che non  avevamo precedentemente rimosso la regola $R\to \epsilon$.
1) Eliminiamo le regole unitarie, eliminiamo la regola $A\to B$ poi per ogni regola $B\to u$ aggiungiamo la regola $A\to u$ a meno che questa non sia una regola unitaria precedentemente cancellata. $u$ é una stringa di variabili e terminali.
2) Trasformiamo tutte le restanti regole nella forma appropriata, rimpiazziamo ogni regola $A\to u_{1}u_{2}\dots u_{k}$ dove $k \geq 3$ e ciascun $u_{i}$ é una variabile o un simbolo terminale con le regole $A\to u_{1}A_{1}; A_{1} \to u_{2}A_{2}; A_{2}\to u_{3}A_{3}\dots A_{k-2}\to u_{k-1}u_{k}$.
   Le $A_{i}$ sono nuove variabili. Rimpiazziamo ogni terminale $u_{i}$ nelle precedenti regole con la nuova variabile $U_{i}$ e aggiungiamo la regola $U_{i}\to u_{i}$

_Esempio_
La CFG iniziale $G_6$ é:
- $S \to ASA|aB$
- $A\to B|S$
- $B\to b|\epsilon$

Applichiamo il primo passo
- $S_{0}\to S$
- $S\to ASA|aB$
- $A\to B|S$
- $B\to B|\epsilon$