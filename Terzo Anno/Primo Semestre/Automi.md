# Linguaggi Regolari
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


