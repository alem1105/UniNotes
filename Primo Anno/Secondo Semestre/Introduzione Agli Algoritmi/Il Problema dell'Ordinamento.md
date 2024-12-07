Esistono diversi tipi di algoritmi di ordinamento alcuni di questi sono molto semplici ma per migliorare l'efficienza dovremo pensare a cose più complesse:

**Algoritmi semplici**:
- Selection Sort
- Insertion Sort
- Bubble Sort

**Algoritmi più complessi**:
- Mergesort
- Quicksort
- Heapsort

# Selection Sort
Seleziona iterativamente l'elemento più piccolo dell'array non ordinato e lo sposta nella posizione corretta dell'array ordinato.

Una possibile implementazione è:

```python
def SelectionSort(A):
	n = len(A)
	for i in range(n-1):
		min = i
		for j in range(i+1, n):
			if A[j] < A[min]:
				min = j
		A[i], A[min] = A[min], A[i]
```

Questo algoritmo **non ha distizione** tra caso migliore e peggiore e abbiamo un costo computazionale di $\theta(n^2)$.

# Insertion Sort
Abbiamo l'array diviso in due parti una ordinata e una non, l'algoritmo prende un elemento dalla parte non ordinata, lo sposta nella parte ordinata e le confronta con tutti gli elementi ordinati fino a che non trova la sua posizione corretta.

Possibile implementazione:

```python
def InsertionSort(A):
	n = len(A)
	for i in range(1, n):
		x = A[i]
		j = i-1
		while j>=0 and A[j]>x:
			A[j+1] = A[j]
			j -= 1
		A[j+1]=x
```

Nel caso di una lista già ordinata abbiamo una complessità di $\theta(n)$

In un caso generale abbiamo una complessità di $\theta(n^2)$

# Bubble Sort
Controlla gli elementi due a due partendo da destra e ordinandoli, quindi alla prima "passata" avremo sistemato l'elemento maggiore, alla seconda il precedente al maggiore e così via fino a quando non avremo ordinato la lista.

Possibile implementazione:

```python
def BubbleSort(A):
	n = len(A)
	for i in range(n-1):
		for j in range(n-i-1):
			if A[j] > A[j+1]:
				A[j],A[j+1] = A[j+1],A[j]
```

Non abbiamo distinzioni per casi migliori o peggiori, in ogni caso abbiamo un costo computazionale di $\theta(n^2)$

# La complessità dell'ordinamento
Come facciamo a stabilire un limite sotto al quale nessun algoritmo di ordinamento basato su confronti fra coppie di elementi possa andare?

Possiamo utilizzare uno strumento chiamato **albero di decisione** che permette di rappresentare tutte le strade che la computazione di un algoritmo può intraprendere.
Per gli algoritmi di ordinamento basati sui confronti, ogni test può prendere due strade, minore o maggiore.
Quindi un albero di decisione relativo ad un algoritmo di ordinamento basato su confronti ha queste proprietà:
- É un albero binario che rappresenta tutti i confronti possibili
- Ogni nodo rappresenta un confronto e i figli gli esiti
- Ogni foglia rappresenta una possibile soluzione del problema la quale è una permutazione della sequenza in ingresso

Il percorso che facciamo dalla radice alla foglia rappresenta l'esecuzione dell'algoritmo e la lunghezza di tale cammino rappresenta il numero di confronti necessari.
Il **percorso più lungo rappresenta il caso peggiore**.

**Cerchiamo quindi di capire se possiamo trovare una limitazione peggiore**
Dato che come soluzione abbiamo una possibile permutazione della sequenza in ingresso, l'albero deve contenere nelle foglie tutte le permutazioni possibili che per un problema di $n$ elementi sono $n!$.
Inoltre un albero di altezza $h$ non può contenere $2^h$ foglie.

Quindi possiamo dire che l'altezza $h$ di un qualunque albero di questo tipo deve essere:

$$
2^h\geq n! \ \ ; \ \ h\geq log_2(n!)
$$

Che in notazione asintotica vale a dire $\ohm(nlogn)$.


> [!info] Costo Computazionale di un ordinamento basato su confronti
> Il costo computazionale di un qualunque algoritmo di ordinamento basato su confronti è $\ohm(nlogn)$

# Merge Sort
È un algoritmo ricorsivo che adotta la tecnica _divide et impera_ ovvero:
- Divide il problema in sottoproblemi
- Risolve i sottoproblemi ricorsivamente
- Combina le soluzioni per risolvere il problema originale

Nello specifico il merge sort funziona nel seguente modo:
- Divide la sequenza di $n$ elementi in due sottosequenze da $\frac{n}{2}$ elementi
- Ordina ricorsivamente le sottosequenze
- La ricorsione termina quando la sottosequenza è costituita da un solo elemento e quindi è già ordinata
- Le due sottosequenze ormai ordinate vengono fuse in un'unica sequenza ordinata

![[Pasted image 20240410154655.png]]

Per scrivere un codice abbiamo bisogno di due funzioni, la funzione _Merge_Sort_ che spezza in due le sequenze e si occupa quindi della ricorsione e la funzione _Fondi_ che unisce due sequenze ordinate

_Esempio Codice_

```python
def Merge_Sort(A, i, j):
	if i < j:
		m = (i + j) // 2         # Costo 1
		Merge_Sort(A, i, m)      # Costo n/2
		Merge_Sort(A, m + 1, j)  # Costo n/2
		fondi(A, i, m, j)        # Costo di fondi S(n)
```

Quindi abbiamo una complessità di:

$$
\begin{align}
&T(n) = \theta(n/2) + S(n)\\
&T(1) = \theta(1)
\end{align}
$$

La _funzione fondi_ si basa sul fatto che le due sottosequenze sono ordinate, inizia a unire gli elementi delle due sequenze scegliendo il minimo fra i due e poi continuando con il prossimo minimo sugli elementi rimanenti delle due sottosequenze, infine copierà gli elementi della lista non terminata.

```python
def fondi(A, i, m, j):
	a, b = i, m+1
	B = []
	while a <= m and b <= j:
		if A[a] <= A[b]:
			B.append(A[a])
			a += 1
		else:
			B.append(A[b])
			b += 1
	while a <= m: # La prima sottolista non è terminata
		B.append(A[a])
		a += 1
	while b <= j: # La seconda sottolista non è terminata
		B.append(A[b])
		b += 1
	for x in range(len(B)): # Ricopio in A gli elementi in B
		A[i+x] = B[x]
```

_Costo di fondi_
- Il primo ciclo while varia da un minimo di $n/2$ a $n$ quindi è $\theta(n)$
- Il secondo e il terzo non vengono mai eseguiti entrambi e in ogni caso si ricopia in B gli eventuali elementi rimanenti quindi $O(n)$
- Nell'ultimo for copiamo il vettore B in A, quindi $\theta(n)$
Costo Totale:

$$
S(n)=\theta(1)+\theta(n)+O(n)+\theta(n)=\theta(n)
$$


> [!info] Costo totale Merge Sort
> $$
> \begin{align}
> &T(n)=2T(n/2)+\theta(n)\\
> &T(1)=\theta(1)\\
> \\
> &T(n)=\theta(nlogn)
> \end{align}
> $$

> [!danger] Spazio e Tempo
> L'operazione di fusione non si può effettuare senza creare un nuovo vettore B senza incorrere in un aumento del costo.
> Infatti se vogliamo fare spazio al nuovo minimo dovremmo spostare tutta la sequenza ordinata che costerebbe $\theta(n)$ per ciascun elemento da ordinare che porterebbe la nostra equazione di ricorrenza a:
> $$
> \begin{align}
> &T(n)=2T(n/2)+\theta(n^2)\\
> &T(1)=\theta(1)\\
> \\
> &T(n)=\theta(n^2)
> \end{align}
> $$
> Risparmiamo quindi memoria ma non tempo

# QuickSort
L'algoritmo di quicksort ha costo $O(n^2)$ nel caso peggiore ma spesso è la soluzione migliore per grandi valori di $n$ perché il suo tempo di esecuzione medio è $\theta(nlogn)$ e permette un ordinamento _in loco_ quindi con poco utilizzo di memoria.
Anche il quicksort è ricorsivo con la tecnica _divide et impera_, nello specifico funziona nel seguente modo:
- Nella sequenza di $n$ elementi si selezione un **pivot** nella sua giusta posizione in modo da ottenere due sottosequenze, quella degli elementi minori o uguali al pivot e quella degli elementi maggiori.
- Le due sottosequenze vengono ordinate ricorsivamente
- La ricorsione termina quando le sottosequenze sono formate da un solo elemento
- Non occorre combinare i risultati dato che viene effettuata in loco

![[Pasted image 20240410162117.png]]

_Pseudocodice_

```python
def Quick_sort(A, i, j):
	if i < j:
		p = Partition(A, i, j)
		Quick_sort(A, i, p - 1)
		Quick_sort(A, p + 1, j)
```

In questa implementazione utilizziamo una funzione _Partition_ che sceglie nel sottovettore di A che va dalla posizione $i$ alla posizione $j$ un elemento detto _pivot_ e posiziona tutti gli elementi in modo che a sinistra ci siano i minori o uguali e a destra i maggiori o uguali.
In questo modo il pivot si trova nella posizione corretta  e tutto questo viene svolto senza utilizzare spazio ausiliario, la funzione **restituisce la posizione del pivot**.

```python
def partition(A, a, b):
	pivot = A[a] # Seleziona il pivot
	i = a + 1 # Inizializza il punto di divisione
	for j in range(a+1,b+1):
		if A[j] < pivot:
			A[j], A[i] = A[i], A[j]
			i += 1
	A[a], A[i-1] = A[i-1], A[a]
	# Posizionati tutti gli elementi
	return i-1 # Restituisce posizione del pivot
```

Sia $n$ la porizione di array da partizionare, la complessità di _Partition_ è $\theta(n)$

$$
\begin{align}
&T(n) = T(k)+T(n-1-k)+\theta(n)\\
&T(1) = \theta(1)\\
\\
&\text{dove } 0\leq k < n
\end{align}
$$

Il caso peggiore è quindi quando il vettore è composto da elementi distinti già ordinati in modo crescente o decrescente mentre il caso migliore si verifica quando ad ogni passo la dimensione dei due sotto-problemi è identica.

**Caso Migliore:** $\theta(nlogn)$
**Caso Peggiore:** $\theta(n^2)$

# Heap Sort
L'algoritmo di Heap Sort ha un costo computazionale di $O(nlogn)$ anche nel caso peggiore e ordina in loco senza utilizzare memoria aggiuntiva.
Sfrutta una **struttura dati** chiamata **Heap**.

Supponiamo di avere una lista $A$ di $n$ elementi su cui nel tempo dovremo effettuare un certo numero di determinate operazioni:
- _Estrazione del Minimo_
- _Aggiunta di un Elemento_

Per la struttura dati Heap abbiamo questo costo delle operazioni:
- _Crea struttura ->_ $\theta(n)$
- _Estrazione del minimo ->_ $O(log|n|)$
- _Aggiunta di un elemento ->_ $O(log|n|)$

Vedremo successivamente il motivo dietro questi costi e come funziona nello specifico la struttura dati.

In _Python_ la struttura _Heap_ viene implementata con la libreria **heapq** che ci mette a disposizione alcuni metodi:
- _heapify(A):_ Crea la struttura prendendo come parametro una lista
- _heappop(A):_ Rimuove e restituisce l'elemento minimo della lista e ristabilisce le proprietà della struttura heap
- _heappush(A,x):_ Inserisce l'elemento $x$ in modo che l'heap mantenga le sue proprietà

L'algoritmo di Heap Sort si basa sull'organizzare gli elementi in A come un **heap minimo**, estrarre gli elementi uno alla volta ed accodarli ad un nuovo vettore B, restituire il vettore B.
Ad ogni estrazione infatti si estrae da A il valore minimo quindi in B gli elementi verranno aggiunti in ordine crescente.

```python
def Heapsort(A):
	from heapq import heapify, heappop
	heapify(A) #O(n)
	B = []
	while A: # Eseguito n volte
		B.append(heappop(A)) #O(logn)
	return B
```

Quindi abbiamo un costo totale di $T(n) = O(n) + \theta(n) * O(logn) = O(nlogn)$.

## La struttura dati Heap
Nell'algoritmo abbiamo utilizzato i metodi proposti dalla libreria _heapq_ senza vedere la loro implementazione e senza conoscere le proprietà della struttura dati **heap**, vediamo ora come funziona.

_Cosa succede ad una lista quando viene trasformata in heap_

```python
import heapq
A = [12,3,8,4,18,16,11,15,17,10,1]
heapq.heapify(A)
print(A)
# [1,3,8,4,10,12,14,11,15,17,18,16]
```

Notiamo che la lista è **semi - ordinata**, infatti nella struttura heap i valori vengono ordinati per rispettare una forma debole di ordinamento chiamata **ordinamento verticale**, questo significa che guardando gli elementi come se fossero in un albero binario i nodi presenti in ogni cammino radice-foglia risultano ordinati in modo crescente.
In questo modo l'elemento minimo si troverà sempre alla radice.

**In generale**:
- Ogni nodo rappresenta un valore della lista
- La radice corrisponde ad A[0]
- Il figlio sinistro del nodo A[i], se esiste, corrisponde all'elemento A[2i+1] mentre il figlio destro a A[2i+2]
- Il padre del nodo A[i] corrisponde all'elemento $A[|\frac{i-1}{2}|]$

![[Pasted image 20240412184218.png]]

Quindi ogni nodo padre deve essere più piccolo dei figli


> [!info] Heap minimo e Heap massimo
> In questo caso stiamo utilizzando un heap minimo dove la radice è l'elemento minimo e ogni nodo deve essere più piccolo dei suoi figli, esiste anche la struttura heap massimo dove alla radice troviamo il valore più grande e quindi ogni nodo deve essere più grande dei suoi figli

**Proprietà**:
- Siccome tutti i livelli sono pieni tranne al più l'ultimo la sua altezza è $logn$
- Per ogni nodo vale che i suoi figli sono più grandi di lui
- L'elemento minimo si trova sempre alla radice quindi possiamo trovarlo in tempo $\theta(1)$

![[Pasted image 20240412184551.png]]

## Funzioni di heapq

**Funzione Heapify**
L'algoritmo di heapify si avvale di un'altra funzione heapify1 che ha lo scopo di mantenere le proprietà dell'heap, sotto l'ipotesi che nell'albero su cui viene eseguita sia garantita la proprietà eccette che per la radice.
La funzione infatti opera sulla radice confrontandola con i figli e posizionandola al posto giusto in modo ricorsivo

_Esempio Funzionamento_

![[Pasted image 20240412184845.png]]

_Codice_

```python
def Heapify1(A, i):
	n = len(A)
	L = 2*i + 1
	R = 2*i + 2
	indice_min = i
	if L < n and A[L] < A[indice_min]:
		indice_min = L
	if R < n and A[R] < A[indice_min]:
		indice_min = R
	if indice_min != i:
		A[i], A[indice_min] = A[indice_min], A[i]
		Heapify1(A, indice_min)
```

Dove tutto ha costo costante tranne la chiamata ricorsiva che ha costo pari al numero di nodi del sottoalbero di i che ha più nodi

**Funzione Heapify**
Serve a trasformare un qualunque vettore A in un heap chiamando ripetutamente _heapify1_ sugli opportuni nodi.
- Poiché _heapify1_ presuppone che entrambi i sottoalberi della radice siano heap, dobbiamo chiamarla scorrendo l'albero dal basso verso l'alto e quindi sul vettore da destra verso sinistra.
- Ogni foglia è già un heap quindi ci basta chiamare _heapify_ a partire dal nodo interno più a destra ovvero il padre del nodo ha posizione $n-1$ e che quindi avrà posizione $|\frac{n-2}{2}|$

```python
def Heapify(A):
	for i in range((len(A)-2)//2, -1, -1):
		heapify1(A, i)
```

La funzione _Heapify_ effettua non più di $n$ chiamate a _Heapify1_ che sappiamo avere ciascuna $O(logn)$ quindi $T(n)=O(nlogn)$ ma con opportune dimostrazioni in realtà il cosot è di $T(n)=\theta(n)$

**Implementazione funzione heappop(A)**
- Salviamo in una variabile il minimo cioè $A[0]$
- Copiamo in $A[0]$ l'ultimo elemento $A[n-1]$ e cancelliamo l'ultimo
- Fuori posto ora abbiamo soltanto la radice che possiamo sistemare chiamando _heapify1(A, 0)_
- Restituiamo la variabile x

```python
def Heappop(A):
	x = A[0]
	A[0] = A[n - 1]
	A.pop()
	Heapify1(A, 0)
	return x
```

Dove l'unico costo non costante è la chiamata a _Heapify1_ che sappiamo costare $O(logn)$

**Implementazione funzione heappush(A, x)**
- Aggiungiamo l'elemento x all'ultimo posto nell'heap
- Facciamo risalire x nell'heap fino a che non risulta maggiore del padre o raggiunge la radice

```python
def Heappush(A, x):
	A.append(x)
	i = len(A) - 1
	while i > 0 and A[i]<A[(i-1)//2]:
		A[i], A[(i-1)//2] = A[(i-1)//2], A[i]
		i = (i-1)//2
```

La complessità è data dal ciclo while che è $O(logn)$ infatti il caso pessimo si ha quando l'elemento da inserire è il minimo e dobbiamo finire quindi alla radice ovvero $\theta(h)$ dove $h$ è l'altezza.
Poiché l'heap contiene $n$ elementi l'altezza dell'albero binario è $\theta(logn)$

# Ordinamenti Stabili
Un algoritmo di ordinamento si dice stabile se mantiene l'ordine relativo per gli elementi con stessa chiave. Questo significa che se due elementi hanno la stessa chiave, un algoritmo stabile deve garantire che l'elemento che compare prima nella lista non ordinata dovrà comparire prima anche nella lista ordinata.

Ad esempio nel _Selection Sort_ abbiamo un ordinamento non stabile dato che presa una lista $[2,2,1]$ se la ordiniamo otteniamo $[1,2,2]$ ma il 2 a posizione 0 è finito nell'ultima posizione, questo significa che abbiamo scambiato l'ordine dei 2 rispetto alla lista originale.

**Algoritmi stabili**:
- BubbleSort
- InsertionSort
- MergeSort
- TimSort
**Algoritmi non Stabili**:
- SelectionSort
- QuickSort
- HeapSort

# Ordinamenti Lineari
Finora abbiamo utilizzato algoritmi di ordinamento basati su confronti e sappiamo che questi hanno un costo computazionale di $\theta(nlogn)$, per ottenere degli algoritmi lineari dobbiamo rimuovere l'ipotesi che l'algoritmo sia _unicamente_ basato su confronti.

## Counting Sort

**Ipotesi**: Ciascuno degli $n$ elementi da ordinare è un intero nell'intervallo $[0,\ldots,k]$
**Idea**: Fare in modo che il valore di ogni elemento della sequenza determini direttamente la sua posizione nella sequenza ordinata.

Il costo computazionale è di $\theta(n+k)$.
Se $k=0$ allora l'algoritmo ordina $n$ elementi in tempo lineare.

Quindi nello specifico dobbiamo:
- Trovare l'elemento $k$ massimo dell'array $A$ da ordinare
- Inizializzare l'array $C$ coni i $k$ contatori delle occorrenze di $A$
- Scorrere $A$ e per ogni indice $i$ incrementiamo il contatore alla posizione $C[A[i]]$ delle occorrenze di $A[i]$
- Scorriamo $C$ e per ogni indice $i$ inseriamo $C[i]$ occorrenze all'elemento $i$ in $A$

_Esempio Grafico:_

![[Pasted image 20240416183551.png]]

_Codice_

```python
def Counting_Sort(A):
	k = max(A) # Theta(n)
	n = len(A)
	C = [0] * (k + 1) # Theta(k)
	for i in range(n): # Theta(n)
		C[A[i]] += 1
	j = 0
	for i in range(len(C)): # Eseguito k + 1 volte
		for _ in range(C[i]): # Eseguito C[i] volte
			A[j] = i
			j += 1
	# I due ultimi for vengono eseguiti n volte
```

Quindi eseguendo le somme asintotiche otteniamo $T(n) = \theta(n + k)$

## Bucket Sort (k buckets)
**Ipotesi**: Gli $n$ elementi da ordinare appartengono all'intervallo $[0,\cdots,M]$ e non sono necessariamente interi ma _equamente distribuiti_ nell'intervallo.
**Idea**: Dividere l'intervallo $[0,\cdots,M]$ in $k$ sottointervalli detti **bucket** e distribuire i valori nei loro bucket per poi ordinarli separatamente.
Un elemento $x$ finisce nel bucket $\lfloor k\cdot \frac{x}{M+1}\rfloor$ 

Il costo computazionale dipenderà dall'algoritmo utilizzato per ordinare i vari buckets ma dato che gli elementi in input sono uniformemente distribuiti non ci si aspetta che molti elementi cadano nello stesso bucket, infatti in ognuno ci saranno circa $\frac{n}{k}$ elementi.

Se prendiamo $k=\frac{n}{c}$ dove $c$ è una opportuna costante allora in ogni bucket ci saranno $\frac{n}{n/c}=c$ elementi e quindi otteniamo un costo di ordinamento pari a $\theta(1)$

### BucketSort con numero di bucket pari a n

- Creiamo una lista di $n$ buckets vuoti
- Troviamo $M$ ovvero l'elemento massimo dell'array $A$ da ordinare
- Scorriamo $A$ e per ogni valore $x$ inseriamo $x$ nel bucket $B\left[\lfloor n \cdot \frac{x}{M+1}\rfloor\right]$
- Ordiniamo gli elementi di ciascun bucket
- Concateniamo gli elementi ordinati dei vari bucket

_Esempio Grafico_

![[Pasted image 20240416192633.png]]

_Codice_

```python
def Bucket_sort(A):
	# Creo lista di n buckets
	n = len(A)
	B = [[] for _ in range(n)] # Theta(n)
	# Distribuisco gli elementi nei buckets
	M = max(A)
	for x in A: # Theta(n)
		i = n * x // (M+1)
		B[i].append(x)
	# Ordino gli elementi di ogni bucket
	for i in range(n): # Somma dei costi di ord. di ogni bucket
		B[i].sort()
	# Concateno gli elementi dei buckets
	R = []
	for i in range(n): # Somma dei costi di ogni bucket
		R.extend(B[i])
	return R
```

Quindi otteniamo

$$
T(n) = \theta(n) + \sum_{i=0}^{n-1}\theta(\text{costo per ordinare }|B[i]| \text{ elementi})
$$

**Caso Pessimo**: Tutti gli elementi finiscono nello stesso bucket.
Otteniamo $T(n) = \theta(n)+\theta(\text{costo per ordinare n elementi})$ e quindi la complessità dipende dall'algoritmo di sort utilizzato.

**Caso Ottimo**: Gli elementi sono equidistribuiti nell'intervallo $[0,\cdots,M]$ e quindi in ogni bucket finiranno $\theta(1)$ elementi.
$T(n)=\theta(n)+\theta(\text{costo per ordinare }\theta(1)\text{ elementi})$ e quindi indipendetemente dall'algoritmo di sort otteniamo un costo complessivo di $T(n)=\theta(n)+\theta(n)\cdot\theta(1)=\theta(n)$
