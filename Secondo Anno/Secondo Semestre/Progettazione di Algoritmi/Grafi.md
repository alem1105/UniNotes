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
> Da notare che gli alberi sono un sottoinsieme dei grafi planari
> 


> [!info] Teorema Eulero
> Un grafo planare di $n>2$ nodi ha al più $3n-6$ archi
> 
> ![[Pasted image 20250301221513.png]]
> 
> Osservando la tabella deduciamo quindi che da $n=5$ in poi esistono di certo grafi non planari, essenzialmente la tabella mi dice che se ad esempio ho 5 nodi e disegno 10 archi è impossibile avere un grafo planare ma se ne disegno 9 ho la possibilità di fare un grafo planare.
> 

# Grafi tramite Matrici Binarie
Presi due nodi $i,j$ usati come coordinate per accedere alla matrice, il valore $M[i][j]=1$ se e solo se c'è un arco diretto da $i$ a $j$ altrimenti $0$.

Questa prende il nome di **matrice di adiacenza**.

_Esempio_:

![[Pasted image 20250301222357.png]]

Otteniamo la matrice:

$$
\begin{array}{|c|c|c|c|c|}
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

Il primo while lascia nella lista L soltanto un candidato a pozzo universale facendo i testi visti prima. Una volta trovato si controlla che lui non abbia archi uscenti verso altri nodi e che tutti gli archi escluso se stesso abbiano un arco entrante verso di lui.
