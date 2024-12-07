Calcoleremo il costo degli algoritmi utilizzando il **criterio della misura di costo uniforme**.
Il costo computazionale lo possiamo vedere come una funzione **monotona non decrescente** che rappresenta il tempo di esecuzione in base alla dimensione dell'input.
Come prima cosa dobbiamo quindi definire la dimensione del nostro input che può essere il numero di elementi di una lista da ordinare, i nodi di un albero o il numero di elementi da cercare.

**Il costo computazionale è ritenuto valido solo asintoticamente, ovvero attraverso la notazione asintotica.**

## Pseudocodice
Per valutare il costo computazionale non si scrive il codice in un linguaggio specifico ma lo **pseudocodice** ovvero un linguaggio di programmazione informale:
- si usano i costrutti di base come _for, while, if_
- si può usare la nostra lingua naturale per specificare passaggi
- si possono omettere molti dettagli al fine di rappresentare soltanto la soluzione vera e propria

## Regole per valutare la complessità di un algoritmo
- Le **istruzioni elementari** hanno costo $\theta(1)$ (aritmetiche, lettura, assegnazione, if, stampa)
- Le **istruzioni iterative** hanno un costo pari alla somma dei costi massimi di ciascuna delle iterazioni, da notare che viene valutata anche la condizione (es. while) e che questa viene valutata una volta in più rispetto al numero delle iterazioni, ovvero quando l'iterazione termina.

## Dipendenza del costo dall'input
Un algoritmo potrebbe avere tempi di esecuzione diversi a seconda dell'input, in questo caso dobbiamo individuare prima di tutto i **casi migliore e peggiore**, capire quindi quale input è più vantaggioso e quale no.
É molto importante, a prescindere dall'input, trovare il tempo di esecuzione del caso peggiore in termini di $\theta$ o se non possibile arrotondarlo a $\ohm$ oppure $O$.

_Esempio: Troviamo il massimo in una lista di n valori_

```python
m = A[0] #Costo 1
for i in range(A): #Costo Θ(lunghezzaA)
	if i > m: #Costo 1
		m = i #Costo 1
print("Il valore massimo è: " + m) #Costo 1
```

$T(n) = \theta(1) + n[\theta(1) + \theta(1)] + \theta(1) = \theta(n)$

_All'interno dell'iterazione le operazione hanno tutte lo stesso costo quindi possiamo svolgere il prodotto_

In realtà la complessità sarebbe $lunghezza-1$ ma le costanti non le consideriamo nel calcolo dei limiti asintotici.

## Variazione dei tempi di esecuzione di un algoritmo in funzione del suo costo computazionale
Ipotizziamo di avere a disposizione una macchina in grado di svolgere un'operazione in un nanosecondo ($10^9$ operazioni al secondo) e supponiamo che la dimensione del problema sia $n=10^6$:
- Tempo di computazione $O(n)$ **1 millesimo di secondo**
- Tempo di computazione $O(nlogn)$ **20 millesimi di secondo**
- Tempo di computazione $O(n^2)$ **1000 secondi = 16 minuti**

E se il costo cresce esponenzialmente $O(2^n)$?
Anche se abbassassimo $n=100$ con la stessa macchina vista prima avremo un costo pari a $\frac{2^{100}}{10^9}=\frac{2^{{10}^{10}}}{10^{3^3}}=\frac{1024^{10}}{1000^3}=\frac{1000^{10}}{1000^3}=10^{21}\text{ secondi}$ ovvero circa $10^{10}$ **secoli**. 


> [!NOTE] Un algoritmo con una complessità esponenziale non serve a molto
> Anche con un avanzamento tecnologico un algoritmo del genere non è molto conveniente, ad esempio prendendo una macchina estremamente veloce in grado di risolvere un problema simile con $n=1000$ e prendendone un'altra 1000 volte più veloce, nello stesso periodo T riusciremo a risolvere soltanto un problema con $n=1010$, non abbiamo quindi fatto grandi progressi.

# Algoritmi Ricorsivi
Una funzione si dice ricorsiva quando chiama se stessa.
- Deve avere un caso base
- E un meccanismo di calcolo ricorsivo, ovvero come posso calcolare il valore successivo conoscendo quello che ho

In ambito informatico di solito con la ricorsione risolviamo tanti piccoli sottoproblemi e combinando le soluzioni otteniamo la soluzione al problema originale.

**Le chiamate a sottoproblemi devono sempre convergere ad un caso base per permettere la terminazione del programma**

Ogni funzione, ricorsiva o non, richiede una certa quantità di memoria per:
- Caricare il codice
- Passare i parametri
- Memorizzare il valore delle variabili

In generale le funzioni ricorsive hanno maggiori esigenze in termini di memoria delle funzioni non ricorsive

**Qualsiasi problema risolvibile con un algoritmo ricorsivo può essere risolto anche con un algoritmo iterativo**
Quando conviene quindi utilizzare un algoritmo ricorsivo?

- Quando permette di scrivere una soluzione in modo più chiaro e simile alla natura del problema
- Non conviene quando esiste una soluzione iterativa semplice e chiara
- Non conviene utilizzare la ricorsione quando è importante avere una buona efficienza

![[Pasted image 20240311230307.png]]

Abbiamo un costo elevato di spazio perchè ogni volta che andiamo in ricorsione creiamo una copia della lista con un elemento in meno, possiamo ottimizzare il codice passando un indice invece che delle copie della lista: 

![[Pasted image 20240311230422.png]]

**Costo di fibonacci iterativo e ricorsivo**

![[Pasted image 20240311230740.png]]

Il calcolo di Fibonacci ricorsivo ha costo in memoria molto elevato e vedremo più avanti un costo in tempo di $\theta(n^2)$ mentre la sua versione iterativi ha spazio $\theta(1)$ e in tempo $\theta(n)$
Questo perchè nella versione ricorsiva eseguiamo tantissimi calcoli che abbiamo già svolto precedentemente

## Equazione di ricorrenza
Calcolare la complessità di un algoritmo ricorsivo è più complesso ad uno iterativo infatti questo da luogo ad una funzione di costo anch'essa ricorsiva.
Trovarla è abbastanza semplice ma questa va riformulata in modo da non renderla ricorsiva altrimenti ci sarà impossibile quantificare il costo asintotico.
Per riformulare la funzione di costo si imposta una **equazione di ricorrenza** costituita dalla _formulazione ricorsiva_ e dal _caso base_.

![[Pasted image 20240314164240.png]]

L'equazione deve essere sempre costituita dalla somma di almeno due addendi, uno contiene la parte ricorsiva mentre l'altro il costo di tutto quello che avviene al di fuori della chiamata ricorsiva.
**DEVE ESSERE SEMPRE PRESENTE UN CASO BASE**

Per risolvere le equazioni di ricorrenza abbiamo a disposizione 4 metodi:
- **metodo iterativo**
- **metodo dell'albero**
- **metodo di sostituzione**
- **metodo principale**

## Metodo Iterativo
In questo metodo sviluppiamo l'equazione in modo da esprimerla come somma di termini dipendenti da $n$ e dal caso base.
**Contro:** Maggiore quantità di calcoli algebrici rispetto agli altri metodi.

_Esempi:_
![[Pasted image 20240314164709.png]]

![[Pasted image 20240314164904.png]]

![[Pasted image 20240314165113.png]]

**Calcolo di Fibonacci**
![[Pasted image 20240314170905.png]]
![[Pasted image 20240314171009.png]]
![[Pasted image 20240314171048.png]]

Non siamo quindi riusciti a trovare la crescita asintotica precisa ma abbiamo comunque potuto approssimarla e notare che il calcolo di un numero di Fibonacci in modo ricorsivo ha costo esponenziale.

## Metodo dell'albero
In questo metodo rappresentiamo graficamente lo sviluppo ricorsivo e vediamo il costo passo per passo.

_Esempio:_
$T(n) = 2T(\frac{n}{2})+\theta(n)$ e come caso base $T(1)=\theta(1)$

![[Pasted image 20240314173120.png]]

Quindi ogni nodo ha costo $\theta(n)$ e sommando tutti i valori che sono equivalenti a $logn$ otteniamo $\sum\limits_{i=0}^{logn}\theta(n)=\theta(n)\sum\limits_{i=0}^{logn}1=\theta(n)*logn=\theta(nlogn)$

## Master Theorem

Questo metodo è molto meccanico ma non sempre applicabile, infatti possiamo utilizzarlo solo quando nella funzione di ricorrenza andiamo in ricorsione su un $n/x$.

Più nello specifico definiamo questa forma:

$T(n)=a\cdot T(\frac{n}{b}) + f(n)$

- Se $f(n)$ = $O(n^{log_ba-\epsilon})$ per qualche costante $\epsilon>0$ allora $T(n)=\theta(n^{lob_ba})$
- Se $f(n)=\theta(n^{log_ba})$ allora $T(n)=\theta(n^{log_ba}\cdot logn)$
- Se $f(n)=\ohm(n^{log_ba+\epsilon})$ per qualche costante $\epsilon>0$ e se $a\cdot f(\frac{n}{b})\leq c\cdot f(n)$ per qualche costante $c<1$ e per $n$ sufficientemente grande allora $T(n)=\theta(f(n))$.

![[Pasted image 20240319214845.png]]
![[Pasted image 20240319214900.png]]

## Metodo di sostituzione

Con questo metodo non andiamo a trovare una soluzione ma ne dovremmo ipotizzare una e dimostrare che questa sia vera.

_Esempio:_

$$
\begin{align}
&T(n)=T(n-1)+\theta(1)\\
&T(1)=\theta(1)
\end{align}
$$

Per utilizzare questo metodo è necessario eliminare la notazione asintotica dall'equazione di ricorrenza, ottenendo quindi:

$$
\begin{align}
&T(n)=T(n-1)+b\\
&T(1)=a
\end{align}
$$

Per due costanti $a$ e $b$ fissate.

Ipotizziamo la soluzione $T(n)=O(n)$, ossia $T(n)\leq c\cdot n$ dove $c$ è una costante che dobbiamo ancora determinare.

**Caso Base**:
$T(1)=a\leq c$ che sarà vera per $c\geq a$

**Induzione**
Sostituendo nella formulazione ricorsiva otteniamo 

$$
T(n)\leq c(n-1)+b=c\cdot n-c+b\leq c\cdot n
$$

Ottenendo quindi che la disequazione è vera quando $c\geq b$

Abbiamo quindi dimostrato che $T(n)$ è effettivamente un $O(n)$ poiché è possibile trovare un valore $c$ per il quale si ha $T(n)\leq c\cdot n$ infatti basta prendere $c=max\{a,b\}$.

---

**Troviamo adesso la notazione asintotica omega**

Adesso dobbiamo ipotizzare una funzione che viene dominata da $T(n)$ quindi troviamo una costante $c$ tale che $T(n)\geq c\cdot n$

Come fatto prima sostituiamo nel **caso base**

$T(1)=a\geq c$ che viene soddisfatta quando $c\leq a$ 

Sostituiamo nell'equazione di ricorrenza usando l'**ipotesi induttiva**

$$
T(n)\geq c\cdot(n-1)+b = c\cdot n -c+b\geq c\cdot n
$$

Che risulta vera nel caso in cui scegliamo $c\leq b$

Abbiamo quindi dimostrato che $T(n)$ è un $\ohm(n)$ dato che possiamo trovare un valore $c$ tale che $T(n)\geq c\cdot n$ ovvero basta prendere $c=min\{a,b\}$

---

_Esempio più complesso_

![[Pasted image 20240321205902.png]]
![[Pasted image 20240321205915.png]]

# Sommatorie Notevoli

![[Sommatorie Notevoli.pdf]]