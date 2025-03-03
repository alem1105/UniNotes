Il grafo è una struttura dati che indichiamo con $G(V,E)$ dove $V$ è un insieme di nodi e $E$ è un insieme di archi che collegano i nodi.

Indichiamo con:
- $|V|=n$
- $|E|=m$

![[Pasted image 20250301220737.png]]

Possiamo fare due distinzioni:
- **Grafo Diretto** - $0\leq m \leq n(n-1)=O(n^2)$
- **Grafo non Diretto** - $0\leq m\leq \frac{n(n-1)}{2}=O(n^2)$ 

Un grafo è diretto quando gli archi hanno una direzione mentre non diretto quando non la hanno e quindi possiamo "percorrere" l'arco in entrambe le direzioni.

Altre distinzioni che possiamo fare sono:
- **Grafo Sparso** - Si dice sparso se $m=O(n)$ quindi il numero di archi è al massimo uguale al numero di nodi.
- **Grafo Denso** - Si dice denso se $m=\Omega(n^2)$ quindi il numero di archi è almeno uguale al quadrato del numero di nodi. In questo tipo di grafi possiamo fare ulteriori distinzioni in:
	- **Grafo Completo** - Se ha tutti gli archi e quindi $m=\Theta(n^2)$
	- **Torneo** - Se il grafo è **diretto** e se tra ogni coppia di nodi c'è esattamente un arco e quindi $m=\Theta(n^2)$


> [!info] Nota
> 
> ![[actually.png|150]]
> 
> Si usa $\Omega (n^2)$ per i grafi densi perché siccome il numero massimo di archi è dato da $\frac{n(n-1)}{2}$ in asintotica otteniamo comunque $n^2$, questo anche per i grafi non orientati con $2$ al denominatore.
> 
> Inoltre da notare che un grafo non sparso non è necessariamente denso dato che potrebbe avere ad esempio $\Theta(n\log n)$ archi.

**Esempio 1** - Un esempio di grafo sparso è l'[[Strutture Dati#^b1d110|albero]], questo è un grafo sparso e senza cicli, inoltre ha **sempre** $m=n-1$ archi e si può provare per induzione

**Esempio 2** - Altri grafi non sparsi sono i **grafi planari**, sono dei grafi che possono essere disegnati sul piano senza che gli archi si intersechino, ovviamente se disegnato nel modo corretto, infatti:

![[Pasted image 20250301221219.png]]


> [!info] Nota
> 
> ![[actually.png|150]]
> 
> Da notare che gli alberi sono un sottoinsieme dei grafi planari, inoltre se un grafo è un albero allora è sicuramente planare ma non è vero il contrario.
> 


> [!info] Teorema Eulero
> Un grafo planare di $n>2$ nodi ha al più $3n-6$ archi
> 
> ![[Pasted image 20250301221513.png]]
> 
> Osservando la tabella deduciamo quindi che da $n=5$ in poi esistono di certo grafi non planari, essenzialmente la tabella mi dice che se ad esempio ho 5 nodi e disegno 10 archi è impossibile avere un grafo planare ma se ne disegno 9 ho la possibilità di fare un grafo planare.
> 

Altre definizioni sui grafi:

> [!info] Grafo Connesso
> Presa una qualsiasi coppia di nodi questi sono connessi fra loro tramite un qualsiasi percorso, possiamo trovare anche un sottografo di un grafo con questa proprietà, questo prende il nome di **componente connessa**.
> 
> Un concetto legato alla connessione è la raggiungibilità ovvero un'operazione tra due nodi che ci dice se da uno possiamo raggiungere l'altro.
> 
> Da notare che in futuro introdurremmo la **connessione forte** per i grafi diretti dato che questa semplice non ha molto senso per quest'ultimi infatti se abbiamo un nodo A che porta ad un nodo B non è detto che il nodo B ci porti al nodo A.
> 

# Grafi tramite Matrici Binarie
Presi due nodi $i,j$ usati come coordinate per accedere alla matrice, il valore $M[i][j]=1$ se e solo se c'è un arco diretto da $i$ a $j$ altrimenti $0$.

Questa prende il nome di **matrice di adiacenza**.

_Esempio_:

![[Pasted image 20250301222357.png]]

Otteniamo la matrice:

$$
\begin{array}{|c|c|c|c|c|c|}
\hline 0 & 0 & 1 & 0 & 0 & 1 \\
\hline 0 & 0 & 0 & 0 & 0 & 1  \\
\hline 1 & 0 & 0 & 0 & 1 & 1  \\
\hline 0 & 0 & 0 & 0 & 1 & 0   \\
\hline 0 & 0 & 1 & 1 & 0 & 1 \\
\hline 1 & 1 & 1 & 0 & 1 & 0 \\
\hline
\end{array}
$$

Infatti ogni riga ci indica un nodo quindi la prima sarà il nodo 0, la seconda il nodo 1 ecc...

All'intersezione fra riga e colonna troviamo il valore 1 se il nodo $i$ della riga punta al nodo $j$ della colonna.

In questo caso il grafo non è diretto quindi troviamo se c'è un arco in generale non interessandoci della direzione, nel caso avessimo avuto un grafo diretto ci saremmo preoccupati del senso dell'arco.


> [!info] Nota
> 
> ![[actually.png|150]]
> 
> Da notare che nella diagonale sono presenti soltanto $0$ dato che non ci sono archi che nascono e muoiono su se stessi.
> 

Possiamo memorizzare queste matrici con una lista di liste $G$ che ha tanti elementi quanti sono i nodi del grafo dove $G[x]$ è una lista contenente i nodi adiacenti al nodo $x$ ovvero quelli raggiunti a partire da $x$. Quindi:

```python
G = [
	[2,5],
	[5],
	[0,4,5],
	[4],
	[2,3,5],
	[0,1,2,4]
]
```

Questo tipo di rappresentazione ci fa risparmiare molto spazio nel caso di grafi sparsi, inoltre vedere se due nodi sono connessi o no può costare anche $O(n)$

## Trovare un Pozzo
In un grafo un pozzo è un **nodo senza archi uscenti**, inoltre si dice **pozzo universale** se un nodo è un pozzo e inoltre tutti gli altri nodi hanno un arco che punta verso di lui.

![[Pasted image 20250301223743.png]]

In questo caso 0 e 3 sono dei pozzi.

![[Pasted image 20250301223756.png]]

Qui invece 5 è un pozzo universale.

 - Come possiamo trovare un pozzo facilmente? - Ci basta controllare la matrice di adiacenza e trovare un nodo la cui lista non contiene valori 1 ovvero non ha archi uscenti.
 - Se vogliamo trovare **il** (pozzo universale unico) pozzo universale? Oltre a controllare che il nodo sia un pozzo come visto sopra dobbiamo controllare se la colonna di quel nodo abbia invece tutti valori 1 (tranne su se stesso) ovvero che tutti gli altri nodi puntino verso di lui.

Quindi cerchiamo questo:

![[Pasted image 20250301224028.png|400]]

Possiamo usare un algoritmo che ha costo $\Theta(n)$ per verificare se un grafo ha un pozzo universale, questo algoritmo prende due nodi del grafo e controlla il valore della loro intersezione, quindi ad esempio:

- Prendiamo i nodi $i,j$ e controlliamo:

$$
M[i][j]=\begin{cases}
1 \quad \text{i non é pozzo} \\
0 \quad \text{j non é pozzo universale}
\end{cases}
$$

Questo perché se la cella vale 1 allora $i$ ha un nodo verso $j$ ma allora non può essere pozzo dato che ha un arco uscente, inoltre se troviamo uno 0 allora $j$ non è pozzo universale dato che non tutti i nodi (in questo caso $i$) hanno un arco verso di lui, potrebbe ancora essere pozzo.

Con ogni test eliminiamo un nodo dai possibili pozzi universali, dopo $n-1$ test ci rimane un solo nodo da controllare.

```python
def pozzoU2(M):
    '''restituisce True se il grafo M ha pozzo universale, False Altrimenti'''
    L=[x for x in range(len(M))]
    while len(L)>1:
        a=L.pop()
        b=L.pop()
        if M[a][b]:
            L.append(b)
        else:
            L.append(a)
    x=L.pop()
    for j in range(len(M)):
        if M[x][j]: return False
    for i in range(len(M)):
        if i!=x and M[i][x]==0: return False
    return True
```

Il primo while lascia nella lista L soltanto un candidato a pozzo universale facendo i test visti prima. Una volta trovato si controlla che lui non abbia archi uscenti verso altri nodi e che tutti gli archi escluso se stesso abbiano un arco entrante verso di lui.

# Grafi tramite Liste di Adiacenza
Un altro modo per rappresentare i grafi è quello delle liste di adiacenza, utilizziamo un dizionario che ha come chiavi i nodi e come valore una lista contenente tutti i nodi collegati a quel nodo valore.

Questa a differenza della matrice ci permette di inserire i nodi anche in modo non consecutivo e presenta alcuni vantaggi e svantaggi a seconda del grafo:

Per quanto riguarda lo spazio questa occupa $O(n+m)$ che per grafi sparsi ci fa risparmiare spazio rispetto alla matrice mentre se abbiamo un grafo denso abbiamo lo stesso costo dato che otteniamo $O(n+n^2)=O(n^2)$ uguale alla matrice.

In grafi sparsi non ci costa molto scorrere la lista alla ricerca di un arco ma nel caso peggiore ovvero in grafi densi può costarci anche $O(n)$ mentre per la matrice abbiamo sempre tempo costante anche in grafi densi.

# In generale chi e quando scegliere?

- Matrice

Se abbiamo un numero di archi vicino a $n^2$ ovvero un grafo denso e se dobbiamo controllare frequentemente l'esistenza di archi o in generale vogliamo accessi costanti.

- Lista di adiacenza

Se abbiamo un grafo sparso, vogliamo risparmiare memoria e dobbiamo iterare sui nodi adiacenti di un nodo.

# Visite nei Grafi
Dato un grafo $G$ ed un suo nodo $u$ vogliamo sapere quali nodi del grafo sono raggiungibili da $u$.

_Esempio_

![[Pasted image 20250303095051.png]]

- Raggiungibili da $(0,G)=\{ 0,1,2,3,4,5,6 \}$
- Raggiungibili da $(6,G)=\{ 2,4,6 \}$
- Raggiungibili da $(5,G)=\{ 5 \}$

## Visita tramite Matrice di Adiacenza
Possiamo usare il seguente algoritmo che ha un costo di $O(n^ 2)$, questo scorre in modo ricorsivo la matrice verso i valori che hanno valore 1 ovvero per quei nodi dove abbiamo un arco entrante da parte del nodo $v$

```python
def DFS(u, M):

	def DFSr(u, M, visitati):
		visitati[u] = 1
		for i in range(len(M)):
			if M[u][i] == 1 and not visitati[i]:
				DFSr(i, M, visitati)

	n = len(M)
	visitati = [0] * n
	DFSr(u, M, visitati)
	return [x for x in range(n) if visitati[x]]
```

## Visita tramite Liste di Adiacenza
Possiamo passare poi ad un algoritmo che ha costo $O(n+m)$ ma un costo di spazio di $O(n)$

```python
def DFS(u, G):

	def DFSr(u, G, visitati):
		visitati[u] = 1
		for v in G[u]:
			if not visitati[v]:
				DFSr(v, G, visitati)

	n = len(G)
	visitati = [0] * n
	DFSr(u, G, visitati)
	return [x for x in range(n) if visitati[x]]
```

I costi sono dovuti al fatto che la creazione della lista `visitati` costa $\Theta(n)$ mentre la funzione di ricerca costa $\Theta(m)$ dato che stiamo pagando con il `for` un costo pari alla somma fra le cardinalità degli insiemi dei nodi adiacenti a ciascun nodo ovvero il numero totale degli archi $m$. Quindi in totale $O(m+n)$.

Per lo spazio è la lista `visitati` che occupa $n$.

Da notare infatti che calcolare il grado di un nodo con la matrice ci costerà sempre $\Theta(n)$ dato che dobbiamo sommare tutti i valori 1 presenti nella lista di quel nodo mentre per la lista di adiacenza ci costa $\Theta(1)$ nella maggior parte dei casi e solo nel caso pessimo $\Theta(n)$ infatti accediamo alla lista tramite il valore con costo 1 e poi calcoliamo la lunghezza della lista sempre con costo 1.

---

È possibile ovviamente avere anche una versione iterativa:

```python
def DFS_iterativo(u,G):
	visitati = [0] * len(G)
	pila = [u]
	while pila:
		u = pila.pop()
		if not visitati[u]:
			visitati[u] = 1
			for v in G[u]:
				if not visitati[v]:
					pila.append(v)
	return [x for x in range(len(G)) if visitati[x]]
```

Questo inizializza la pila inserendo il nodo di partenza poi finché nella pila c'è qualcosa e questo non si trova nei nodi visitati allora lo inseriamo nei visitati rimuovendolo dalla pila e andiamo a controllare nella matrice alla lista corrispondente tutti i nodi collegati e li aggiungiamo alla pila.

Con questo tipo di visite gli archi del grafo si bipartiscono in quelli percorsi dalla visita e quelli non, il percorso che effettuiamo andrà a creare un albero detto **albero DFS**.

Ad esempio prendiamo il grafo a sinistra ed eseguendo delle visite dai nodi 9, 4 e 3 otteniamo gli alberi accanto:

![[Pasted image 20250303113247.png]]

Un albero DFS può essere memorizzato tramite il **vettore dei padri**.

> [!info] Vettore dei Padri
> Il vettore dei padri $P$ di un albero DFS di un grafo di $n$ nodi ha $n$ componenti:
> - Se $i$ è nodo dell'albero DFS allora $P[i]$ contiene il padre del nodo $i$
> - Se $i$ non è nodo dell'albero allora $P[i]$ per convenzione contiene $-1$

_Esempi di rappresentazione con vettore dei padri_

![[Pasted image 20250303114411.png]]

È possibile modificare l'algoritmo di visita DFS e fare in modo che restituisca il vettore dei padri radicato nel nodo da cui siamo partiti.

```python
def Padri(u, G):

	def DFSr(x, G, P):
		for y in G[x]:
			if P[y] == -1:
				P[y] = x
				DFSr(y, G, P)

	n = len(G)
	P = [-1] * n
	P[u] = u
	DFSr(u,G,P)
	return P
```

Avremo che $P[v]$ contiene $-1$ se $v$ non è stato visitato altrimenti contiene il padre di $v$ nell'albero DFS.

_Esempi applicazione_:

_Forse va riorganizzato qualcosa sopra :(_