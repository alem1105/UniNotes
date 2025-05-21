Raccolta di esercizi svolti con la tecnica backtracking, si basa sull'osservare l'albero che produciamo con il nostro algoritmo e "tagliare" i rami che non ci interessano per ridurre la complessità

# Esercizio 1
Progettare un algoritmo che prende come parametro un intero $n$ e stampa tutte le stringhe binarie lunghe $n$.

Ad esempio per $n=3$ l'algoritmo deve stampare $2^3=8$ stringhe.

Notiamo che:
- Le stringhe da stampare sono $2^n$
- Per stampare una stringa lunga $n$ dobbiamo pagare $\Theta(n)$
- Quindi il meglio che possiamo ottenere da un algoritmo simile è $\Omega (2^n \cdot n)$

L'albero delle scelte possibili è il seguente:

![[Pasted image 20250521095847.png|500]]

Scriviamo un algoritmo per risolvere il problema:

```python
def bk(n, sol = None):
	if sol is None:
		sol = []

	if len(sol) == n:
		print(''.join(sol))
		return

	sol.append('0')
	bk(n, sol)
	sol.pop()

	sol.append('1')
	bk(n, sol)
	sol.pop()
```

Abbiamo ottenuto un algoritmo efficiente, infatti è uguale alla soglia minima descritta prima:
- L'albero ha $2^n - 1$ nodi interni e $2^n$ foglie
- Ciascun nodo richiede $O(1)$
- Ciascuna foglia richiede $O(n)$ per essere stampata
- In totale abbiamo $O(2^n \cdot n)$

# Esercizio 2
Progettare un algoritmo che prende come parametro due interi $n$ e $k$ con $0\leq k \leq n$ e stampa tutte le stringhe binarie lunghe $n$ che contengono al più $k$ 1.

Ad esempio per $n=4, k=2$ delle $2^4=16$ stringhe lunghe $n$ dobbiamo stampare soltanto le seguenti 11 strighe:
- 0000, 0001, 0010, 0100, 1000, 0011, 0101, 1001, 0110, 1010, 1100

Analizziamo l'albero delle scelte possibili e vediamo quali rami tagliare se $n=4$ e $k=1$:

![[Pasted image 20250521101506.png|500]]

> In verde sono indicate le foglie che vanno stampate

In generale possiamo non percorrere i seguenti percorsi:

![[Pasted image 20250521101616.png|500]]

Analizziamo il tetto minimo per la complessità di un algoritmo che risolve il problema, in generale un buon algoritmo dovrebbe avere una complessità proporzionale al numero delle stringhe da stampare quindi $O(S(n,k)\cdot n)$, dove con $S(n,k)$ indichiamo il numero di stringhe da stampare.

Nel caso di $k=2$ si ha che:

$$
S(n,k)=1+n+\binom{n}{2}=\Theta(n^2)
$$

- $\binom{n}{2}$ indica le stringhe che hanno 2 uni al loro interno
- $n$ le stringhe che hanno un solo 1
- 1 è la stringa senza 1

Vediamo una soluzione che non fa uso del backtracking:

```python
def bk1(n, k, sol = None):
	if sol is None:
		sol = []

	if len(sol) == n:
		if sol.count('1') <= k:
			print(''.join(sol))
		return

	sol.append('0')
	bk1(n, k, sol)
	sol.pop()

	sol.append('1')
	bk1(n, k, sol)
	sol.pop()
```

Questa soluzione ha una complessità di $\Theta(2^n\cdot n)$ perché non tagliamo i rami che non ci servono, esploriamo tutto l'albero e ad ogni foglia controlliamo se va bene stamparla oppure no.

Vediamo invece come evitare di controllare rami inutili alla soluzione, ovvero quelli che contengono più di $k$ 1:

```python
def bk2(n, k, tot1 = 0, sol = None):
	if sol is None:
		sol = []
	
	if len(sol) == n:
		print(''.join(sol))
		return
		
	sol.append('0')
	bk2(n, k, tot1, sol)
	sol.pop()

	if tot1 < k:
		sol.append('1')
		bk2(n, k, tot1 + 1, sol)
		sol.pop()
```

In questo modo evitiamo di percorrere i rami inutili visti nell'immagine prima.

> [!info] Attenzione
> Ci serve una variabile per contare gli 1, non possiamo fare `count('1')` altrimenti ogni stringa avrebbe costo $O(n)$ 

Tempi delle due soluzioni a confronto con $n=24, k=2$:

![[Pasted image 20250521104822.png|500]]

Perché andiamo a risparmiare così tanto tempo?

Si consideri un algoritmo di enumerazione basato sul backtracking dove l'albero di ricorsione ha altezza $h$, il costo di una foglia è $g(n)$ e il costo di un nodo interno è di $O(f(n))$. 

Se l'algoritmo gode della seguente proprietà:
- Un nodo viene generato solo se ha la possibilità di portare ad una foglia da stampare

Allora la complessità dell'algoritmo è proporzionale al numero di cose da stampare $S(n)$, più precisamente:

$$
O(S(n)\cdot h \cdot f(n)+ S(n)\cdot g(n))
$$

- Il costo totale dei nodi foglia sarà $O(S(n)\cdot g(n))$ perché verranno generate soltanto le foglie da stampare
- I nodi interni dell'albero che verranno generati saranno $O(S(n)\cdot h)$ perché se un nodo esiste allora appartiene ad un percorso che porta ad una foglia, quindi abbiamo foglie $\times$ altezza 

# Esercizio 3
Progettare un algoritmo che, presi due interi $n$ e $k$ con $0\leq k\leq n$ stampi tutte le stringhe che contengono esattamente $k$ uni.

Ad esempio per $n=6, k=3$ delle $2^6=64$ stringhe lunghe $n$ bisogna stampare soltanto le seguenti 20:

![[Pasted image 20250521105524.png|300]]

```python
def bk3(n, k, tot1 = 0, sol = None):  
    if sol is None:  
        sol = []  
  
    if len(sol) == n:  
        print(''.join(sol))  
        return  
  
    #remain = n - len(sol) - 1 caratteri che mi rimangono da aggiungere  
    if n - len(sol) - 1 + tot1 >= k:  
        sol.append('0')  
        bk3(n, k, tot1, sol)  
        sol.pop()  
  
    if tot1 < k:  
        sol.append('1')  
        bk3(n, k, tot1 + 1, sol)  
        sol.pop()
```

# Esercizio 4 (settembre 2020)
Progettare un algoritmo che, dato un intero $n$, stampi tutte le stringhe sull'alfabeto dei 3 simboli $a,b,c$ in cui il numero delle $b$ supera quello di ciascuno degli altri due simboli.

Ad esempio per $n=2$ l'algoritmo deve stampare la sola stringa $bb$ mentre per $n=3$ le stringhe da stampare sono:
- $bbb,abb,bab,bba,cbb,bcb, bbc$

```python
def bk4(n, na = 0, nc = 0, sol = None):  
    if sol is None:  
        sol = []  
  
    if len(sol) == n:  
        print(''.join(sol))  
        return  
  
    sol.append('b')  
    bk4(n, na, nc, sol)  
    sol.pop()  
  
    # Caratteri che mi mancano da aggiungere sono maggiori del numero della  
    # stringa con un carattere a aggiunto    
    if n - (na + nc + 1) > na + 1:  
        sol.append('a')  
        bk4(n, na + 1, nc, sol)  
        sol.pop()  
  
    # Caratteri che mi mancano da aggiungere sono maggiori del numero della  
    # stringa con un carattere c aggiunto    
    if n - (na + nc + 1) > nc + 1:  
        sol.append('c')  
        bk4(n, na, nc + 1, sol)  
        sol.pop()
```

# Esercizio - Marzo 2023
Dati tre interi $n,k,T$ positivi con $T\leq nk$ definiamo valida una sequenza di lunghezza $n$ con interi tra $0$ e $k$ la somma di cui elementi è $T$.

Ad esempio per $n=6,k=4,T=12$ allora la sequenza $132042$ è valida mentre $121213$ non è valida.

Progettare un algoritmo che dati gli interi $n,k,T$ stampi tutte le sequenze valide.

L'algoritmo deve avere complessità $O(n\cdot k\cdot S(n,k))$ dove $S(n,k)$ è il numero di sequenze valide esistente.

```python
def bk(n, k, T, somma = 0, sol=[]):  
  
    if len(sol) == n:  
        print(''.join(sol))  
        return  
  
    for new_char in range(k + 1):  
        if new_char + somma + (n - len(sol)-1) * k >= T and somma + new_char <= T:  
            sol.append(str(new_char))  
            bk(n, k, T, somma + new_char, sol)  
            sol.pop()
```

- Con la prima condizione dell'if sto controllando se aggiungendo il nuovo elemento posso comunque raggiungere il valore T con i restanti elementi.
- La seconda mi permette di non superare T