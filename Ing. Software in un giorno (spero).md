
> [!info] Info
> ![[actually.png|200]]
> Si sappiamo che dovremmo studiare seriamente ma se mi metti 45 secondi a domanda e le domande sono livello elementari allora anche noi la studiamo in 45 secondi e non seriamente.

# Esercizio Rischio

![[Pasted image 20260108103011.png]]

Basta fare le formule inverse:
- $P = \frac{R}{C}$
- Calcoli logaritmo naturale $\log_{e}(P)$
- Dividi il risultato per $b$ e cerchi la risposta più simile

# Markov | Iterazioni o uscire da una fase

![[Pasted image 20260108103259.png]]

Quando chiede **numero atteso di iterazioni** basta fare

$$
\frac{\text{prob. rimanere}}{\text{prob. uscire}}
$$

Nell'esempio sopra:

$$
\frac{0.35}{0.65} = 0,538462
$$

Altro tipo di esercizio ma simile é:

![[Pasted image 20260108104953.png]]

Ovvero se chiede **numero transizioni necessario per lasciare** e qui facciamo

$$
\frac{1}{\text{prob. uscire}}
$$

In questo caso:

$$
\frac{1}{0.6}=1.66667
$$

# Valore minimo di p

![[Pasted image 20260108103530.png]]

In teoria il risultato finale é sempre dato da $p * 0.7 * 0.7$ o comunque il percorso totale per arrivare alla fine senza ripetizioni, quindi basta sostituire $p$ con tutte le soluzioni e vedere quale ci porta piú vicini a $0.5$

# Funzioni di transizione e UML

![[Pasted image 20260108103739.png]]

Capita anche che viene dato l'UML e dobbiamo scegliere la funzione.
Il primo switch é sullo stato e il secondo sulle transizioni, boh sembra sempre abbastanza intuitivo *tranne quando mette i numeri sugli archi a cazzo de cane pd*.

> [!danger] pd
> ![[Pasted image 20260108111506.png]]
> ![[Pasted image 20260108111711.png|200]]


# Codice e Architettura

![[Pasted image 20260108103920.png]]

Come sopra sempre semplici tranne quando scrive i numeri malissimo sugli archi. Potrebbe uscire anche invertito quindi dalle immagini trovare il codice.

Per velocizzare conviene contare il numero di archi e vedere se combacia con il numero di istruzioni, spesso si scartano 1/2 opzioni.

# Transition / State Coverage

![[Pasted image 20260108104022.png]]

Qui stare attenti se sta chiedendo la coverage degli **stati** o delle **transizioni**. In ogni caso per fare prima basta contare il totale e capire fra le soluzioni quale é l'unico numero sensato.
Tipo qua sono 20 archi, e l'unico numero possibili é $\frac{6}{20}=0.300$

![[Pasted image 20260108105906.png]]

Qui invece chiede gli stati che sono 8 in totale quindi unica soluzione possibile é

$$
\frac{6}{8}=0.750
$$

# Path Coverage

![[Pasted image 20260108104213.png]]

Uguale a sopra ma i casi possibili sarebbero tutti i return, in questo caso 5 quindi l'unica soluzione sensata é $\frac{3}{5}=0.600$

# Descrizione software e struttura

![[Pasted image 20260108104337.png]]

dai....

# Markov | Percorso

## 600

![[Pasted image 20260108104901.png|1000]]

Se esce 600, intendiamo che ci sono 2 ripetizioni

Si calcola il percorso completo, si moltiplica per gli archi 3 -> 2 e 2 -> 1 e si sommano, la risposta é sicuramente più alta di quel valore e quasi sempre sta in ordine di grandezza 0.0...

Nell'esempio sopra
$$
\begin{align*}
\text{percorso base} &= 0.95*0.92*0.86 = 0.75164 \\
\text{prima stima} &= 0.75 * 0.05 + 0.75 * 0.04 = 0.0675
\end{align*}
$$

Se non basta, per andare piú vicini ma sempre abbastanza veloci si puó fare la media dei costi dei self-loop e considerare tutte le combinazioni. Quindi costo medio alla seconda perché lo prendiamo due volte e moltiplichiamo per 6 ovvero tutte le combinazioni dei 3.

$$
\begin{align*}
\text{media} &= (0.05 + 0.04 + 0.04) / 3 = 0.13 / 3 = 0.043 \\
\text{stima} &= 0.0675 + 0.75 * 0.043 * 0.043 * 6 = 0.06833205
\end{align*}
$$

## 500

![[Pasted image 20260108105507.png]]

Se esce 500, intendiamo percorso con **una ripetizione**.
Per ora funziona sempre fare

$$
\text{percorso base} * \text{somma costi self-loop}
$$

Ed esce un numero abbastanza simile al risultato vero.
Nel caso sopra ad esempio:

$$
\begin{align*}
\text{base} &= 0.95*0.92*0.86=0.75164 \\
\text{somma self-loop}&= 0.05+0.04+0.04 = 0.14 \\
\text{prodotto}&= 0.75164*0.14=0,1052296
\end{align*}
$$

## 400

Se esce 400 per ora a noi é sempre stato uguale al percorso base:

![[Pasted image 20260108105212.png]]

# Matrice

![[Pasted image 20260108104739.png]]

$A[i][j]$ indica la probabilitá di muoversi da $i$ a $j$ mentre il vettore $Y$ indica i return dei vari stati. Per fare prima conviene controllare prima i return di ogni opzione e scartare quelle sbagliate.

# Assert

![[Pasted image 20260108105126.png]]

Basta non imbrogliarsi sul fatto che $x2,x1$ sono il passato.

# WBS

![[Pasted image 20260108105327.png]]

Spero si possano fare gli screenshot all'esame.
Per ora la cosa che sembra piú utile é controllare prima le precedenze e poi vedere se vengono rispettare tutte le effort.

# Processo di sviluppo

![[Pasted image 20260108110021.png]]

Non sembrano difficilissimi quelli usciti, basta ragionarci un po'

# Probabilitá

![[Pasted image 20260108110602.png]]

Anche qui basta fare qualche conto stupido.

![[Pasted image 20260108110640.png]]

In generale dovrebbe essere

$$
\text{somma costo operazioni} + \text{costo rischio}
$$

Nel primo caso:

$$
(1000 + 1000) + (1000*0.5 + 1000*0.5)
$$

Dato che  ogni operazioni costa 1000 e ognuna viene ripetuta con rischio $0.5$

Mentre nel secondo:

$$
(10.000 + 10.000) + (10.000 * 0.4) 
$$

Ovvero il costo totale delle operazioni piú il rischio di ripetere la prima dato che la seconda ci porta subito alla fine.

## Altra tipologia

![[Pasted image 20260108111249.png]]

Anche qui spesso sono conti stupidi, qui dovevamo mettere 1+ perché almeno una volta le eseguirai sicuramente tutte le fasi.

![[Pasted image 20260108111344.png]]

Oppure anche questi ma molto easy.

# Codice

![[Pasted image 20260108111144.png]]

Anche qui va ragionato un attimo, noi avevamo sbagliato a contare il modulo.

# Domande Teoriche

Alcune sembrano banali, altre tocca studiare misá, sembrano sempre le stesse peró.
