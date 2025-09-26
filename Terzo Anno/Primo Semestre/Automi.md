# Introduzione alla Terminologia
Alcune definizioni:
- **Alfabeto** - Insieme finito di simboli, ad es $\Sigma=\{ 0,1,x,y,z \}$
- **Stringa** - Una sequenza di simboli che appartengono ad un alfabeto

Ad esempio dati $w_{1},\dots,w_{n}\in \Sigma$ abbiamo $w=w_{1},\dots ,w_{n}$ come stringa dell'alfabeto.

- **Linguaggio** - Dato un alfabeto $\Sigma$ definiamo $\Sigma^*$ come linguaggio di $\Sigma$, ovvero l'insieme delle stringhe di quell'alfabeto.
- **Lunghezza di una stringa** - Data una stringa $w\in \Sigma^*$ definiamo $|w|$ come sua lunghezza ovvero quanti simboli contiene..
- **Concatenazione** - Data la stringa $x=x_{1},\dots,x_{n}\in \Sigma^*$ e la stringa $y=y_{1},\dots,y_{m}\in \Sigma^*$ definiamo come concatenazione di $x$ con $y$ la seguente stringa: $x_{1},\dots x_{n}y_{1},\dots,y_{m}$
- **Stringa vuota** - Indichiamo con $\epsilon$ la stringa vuota ovvero tale che:
	- $|\epsilon|=0$
	- $\forall w\in \Sigma^* \ w\cdot \epsilon=w$
	- $\Sigma^*\neq \emptyset\to w\in \Sigma^*$
- **Conteggio** - Data una stringa $w\in \Sigma^*$ e un simbolo $a\in \Sigma$ definiamo il conteggio di $a$ in $w$ come $|w|_{a}$ ovvero il numero di volte che compare il simbolo $a$ in $w$
- **Stringa Rovesciata** - Data una stringa $w=a_{1} \dots a_{n}\in \Sigma^*$, dove $a_{1},\dots,a_{n}\in \Sigma$, definiamo la stringa rovesciata con $w^R=a_{n}\dots a_{1}$
- **Potenza** - Data la stringa $w\in \Sigma^*$ e dato $n\in \mathbb{N}$ definiamo come potenza:

$$
w^n = 
\begin{cases}
\epsilon \ \ \ \ \ \ \ \ \ \ \ \ \text{se } n = 0 \\
ww^{n-1} \ \ \ \text{se } n > 0
\end{cases}
$$

# DFA
Il modello di computazione che useremo all'inizio è un **automa a stati finiti**, questo ha una memoria limitata e una gestione dell'input ma garantisce un'estrema semplicità.

_Esempio_ - Un sensore per una porta automatica, questo ha solo 2 stati ovvero _aperto e chiuso_ e a seconda dell'input del sensore cambia stato, se c'è qualcuno si apre altrimenti si chiude.

**Definizione - DFA** - Deterministic Finete Automaton

Un DFA è una tupla $(Q, \Sigma, \delta, q_{0},F)$ dove:
- $Q$ è l'insieme finito degli stati
- $\Sigma$ è l'insieme finito dei simboli in input
- $\delta: Q \times \Sigma \to Q$ ovvero la funzione di transizione degli stati
- $q_{0} \in Q$ è lo stato iniziale
- $F\subseteq Q$ E' l'insieme degli stati di accettazione dell'automa, ovvero gli stati dove l'automa si trova dopo aver letto una determinata stringa e consente la terminazione.

Se $M$ è un DFA allora l'insieme delle stringhe riconosciute da esso si denota con $L(M)$, in generale è il linguaggio conosciuto da $M$. Può anche accadere che $L(M)=\emptyset$.

_Esempio_ - Il DFA precedente del sensore della porta avrà un linguaggio $w$ dove $w$ contiene **almeno** i 3 simboli:
- $N$ - nessuno si trova nei due lati della porta
- $A$ - qualcuno si trova nel lato anteriore
- $P$ - qualcuno si trova nel lato posteriore

_Esercizio_ - Definire il linguaggio del seguente automa:

![[Pasted image 20250925093441.png]]

Per definire precisamente un linguaggio introduciamo la **funzione di transizione estesa**:

$$
\delta^*=Q \times \Sigma^* \to Q
$$

Questa è definita in modo ricorsivo da:

$$
\begin{cases}
\delta^*(q, \epsilon) = \delta(q, \epsilon)=q \\
\delta^*(q, aw) = \delta^*(\delta(q,a), w) \text{ con } w \in \Sigma^* \text{, e} \in \Sigma
\end{cases}
$$


> [!info] Configurazione
> Sia $D:=(Q,\Sigma,\delta,q_{0},F)$ un DFA definiamo la coppia $(q,w)\in Q\times \Sigma^*$ come configurazione di D.
>
>Dato $x\in \Sigma^*$, la **configurazione iniziale** è $(q_{0},x)$.


> [!info] Passo di Computazione
> Parte da una configurazione ad un'altra rispettando la funzione di transizione $\delta$. Il passaggio avviene rispettando la relazione binaria:
> 
> $$
> (p,ax) \vdash_{M} (q,x) \Leftrightarrow \delta(p,a)=q
> $$
> 
> Dove $p,q\in Q, a\in \Sigma, x\in \Sigma^*$
> 
> Quindi una transizione avviene soltanto se la funzione di transizione la permette.

Possiamo estendere questa relazione binaria con il simbolo $\vdash_{M}^*$ considerando anche la **chiusura riflessiva e transitiva** quindi:
- $(q,x) \vdash_{M}^* (q,x)$
- $(q,aby)\vdash_{M}(p,by)$ e $(p, by)\vdash_{M}(r,y) \Rightarrow (q,aby)\vdash_{M}^*(r,y)$
Dove:
- $q,p,r\in Q, a,b\in \Sigma,y\in \Sigma^*$

> [!info] Linguaggio Accettato
> Diciamo che $x\in \Sigma^*$ è accettato da $M=(Q,\Sigma,\delta,q_{0},f)$ se $\delta^*(q_{0},x)\in f$ oppure $(q_{0},x)\vdash_{M}^*(q,\epsilon)$ con $q\in f$
> 
> In altre parole quindi: $L(M)=\{ x\in \Sigma^*:\delta^*(q_{0},x)\in f \}$ ovvero le parole del linguaggio devono permetterci di arrivare ad uno stato di terminazione.

# Linguaggi Regolari

> [!info] Definizione
> $$
> REG = \{ L \subseteq \Sigma^* : \exists \text{ DFA M t.c. } L(M) = L\}
> $$
> 
> Ovvero è l'insieme dei linguaggi accettati da almeno un DFA

Uno dei nostri obiettivi, ad esempio, sarà quello di progettare dei DFA per dei linguaggi forniti.

_Esempio_ - Abbiamo il linguaggio $L=\{ x\in \{ 0,1 \}^* \text{ t.c } x=1y, y\in \{ 0,1 \}^* \}$

Un possibile DFA potrebbe essere:

![[Pasted image 20250926143505.png|300]]


Notiamo quindi che questo accetta soltanto le stringhe che iniziano con il carattere '1', infatti se riceve '1' entra nello stato $q_{1}$ e non esce più, mentre se riceve '0' entra nello stato $q_{2}$ senza più uscire.

> [!bug] Attenzione
> Lo stato $q_{2}$ dal quale non usciamo più, anche chiamato **stato pozzo**, è necessario infatti non possiamo toglierlo e inserire soltanto la transizione che da $q_{0}$ ricevendo '0' rimaniamo in $q_{0}$ come in questo caso:
> 
> ![[Pasted image 20250926143855.png|300]]
> 
> Progettando l'automa in questo modo infatti accetterà anche le stringhe che iniziano con '0'.
> 
> Una notazione che si usa se vogliamo non disegnare lo stato pozzo $q_{2}$ è quella di non indicare semplicemente la transizione, quindi:
> 
> ![[Pasted image 20250926144008.png|300]]
> 
> 

Adesso dobbiamo dimostrare che questo DFA accetta il linguaggio, quindi più formalmente:

$$
\text{DFA accetta } x \Leftrightarrow x \in L
$$

Iniziamo osservando che se ci troviamo in $q_{1}$ rimarremo sempre in $q_{1}$ e stessa cosa anche per $q_{2}$, formalmente:

$$
\begin{align*}
\delta^*(q_{1}, u) = q_{1} \quad \forall u\in \{ 0,1 \}^* \\
\delta^*(q_{2},u) = q_{2} \quad \forall u \in \{ 0,1 \}^*
\end{align*}
$$

Tenendo in mente questo ragionamento iniziamo la dimostrazione per induzione.

- **Case Base**

$$
\begin{align*}
&\text{Abbiamo }|x| = 0 \text{ quindi } x = \epsilon \\ \\
&\delta^*(q_{0}, \epsilon) = \delta(q_{0},\epsilon)=q_{0} \not \in f
\end{align*}
$$

Quindi con una stringa vuota rimaniamo sempre in $q_{0}$ che non è uno stato di accettazione del DFA.

- **Passo Induttivo**

In questo caso abbiamo quindi $|w|\leq n$ con $n>0$, e quindi la funzione di transizione estesa avrà questi risultati possibili:

$$
\delta^*(q_{0},w)=
\begin{cases}
q_{0} \text{ se } w = \epsilon \\
q_{1} \text{ se } w \text{ inizia con 1} \\
q_{2} \text{ se } w \text{ inizia con 2}
\end{cases}
$$

Adesso prendiamo una stringa $|x| = n+1$ e la pensiamo costruita come $x=au$ con $a\in \{ 0,1 \}$ e $u\in \{ 0,1 \}^*$, la funzione di transizione ci restituirà:

$$
\delta^* (q_{0},x) = \delta^* (q_{0},au) = \delta^* (\underbrace{\delta(q_{0},a)}_{\text{solo 2 soluzioni}},u)
$$

Le due soluzioni di quel passaggio sono:
- $\delta(q_{0},a)=q_{1}$ se $a=1$
- $\delta(q_{0},a)=q_{2}$ se $a=0$

Ma poi, ricordando cosa abbiamo detto all'inizio, sappiamo che sia che ci troviamo in $q_{1}$ o $q_{2}$ rimarremo sempre li, indipendentemente da come è fatta la stringa $u$.

## Operazioni sui Linguaggi

### Unione
$$
L_{1} \cup L_{2} = \{ x\in \Sigma^*:x\in L_{1} \vee x \in L_{2} \}
$$

### Intersezione

$$
L_{1} \cap L_{2} = \{ x\in \Sigma^*:x\in L_{1} \wedge x\in L_{2} \}
$$

### Complemento
$$
\overline L = \{ x\in \Sigma^*:x\not\in L \}
$$

### Concatenazione
$$
L_{1} \circ L_{2} = \{ xy:x\in L_{1} \wedge y \in L_{2} \}
$$

Da notare che non è commutativo, quindi:

$$
L_{1} \circ L_{2} \neq L_{2} \circ L_{1}
$$

### Potenza
Possiamo definirla ricorsivamente:

$$
\begin{cases}
L^0 = \epsilon \\
L^{n+1} = L^n \circ L
\end{cases}
$$


### Operatore "star" \*

$$
L^* = \bigcup_{n\geq 0} L^n = \{ \epsilon \} \cup L^1 \cup L^2 \cup \dots
$$

---

Adesso vogliamo studiare le **proprietà di chiusura** dei linguaggi naturali.

_Ad esempio_ - Se $L_{1},L_{2}\in REG$ possiamo dire che anche $L_{1} \cup L_{2} \in REG$? E la loro intersezione? E il complemento? ecc...

Dimostriamo tutti questi casi.

- **Teorema - Chiusura per unione**

Una prima idea è che:

$$
L_{1},L_{2}\in REG \Rightarrow \exists M_{1},M_{2} \in DFA \text{ t.c. } L(M_{1})=L_{1}, L(M_{2})=L_{2}
$$

Dobbiamo quindi definire un altro DFA $M$ t.c. $L(M)=L_{1} \cup L_{2}$. Ma dato una $x$ candidata non possiamo provare a vedere prima se $M_{1}(x)$ la accetta e poi controllare se la accetta $M_{2}(x)$ perché altrimenti l'automa $M$ perderebbe i suoi stati.

Il controllo va fatto in parallelo su entrambi e una volta controllato ogni carattere di $x$ aggiorniamo lo stato di $M$ di conseguenza.