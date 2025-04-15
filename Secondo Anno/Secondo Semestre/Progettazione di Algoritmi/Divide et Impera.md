Per spiegare la tecnica usiamo come esempio il problema della selezione:

Data una lista A di $n$ interi distinti ed un intero $k$ con $1\leq k\leq n$ vogliamo sapere quale elemento occuperebbe la posizione $k$ se il vettore venisse ordinato.

Individuiamo alcuni casi particolari:
- Per $k=1$ abbiamo il minimo di $A$
- Per $k=n$ avremo il massimo di $A$
- Per $k=\left\lceil  \frac{n}{2}  \right\rceil$ avremo il mediano di $A$

Un semplice algoritmo potrebbe essere:

```python
def selezione1(A, k):
	A.sort()
	return A[k-1]
```

Che ha come costo $\Theta(n\log n)$.

Usando però il divide et impera avremo un costo di $\Theta(n)$ nel caso generale, dimostreremo quindi che il problema della selezione è computazionalmente più semplice di quello dell'ordinamento che richiede tempo $\Omega(n\log n)$

Approccio basato sul Divide et Impera:
- Scegli nella lista A l'elemento in posizione $A[0]$ che chiamiamo **perno**
- A partire da $A$ costruisci due liste $A_{1},A_{2}$, la prima contiene gli elementi di $A$ minori del perno e la seconda i maggiori
- Dove si trova l'elemento di rango $k$?
	- Se $|A_{1}|\geq k$ allora l'elemento di rango $k$ è nel vettore $A_{1}$
	- Se $|A_{1}|=k-1$ allora l'elemento di rango $k$ è proprio il perno
	- Se $|A_{1}|<k-1$ allora l'elemento di rango $k$ è in $A_{2}$, è l'elemento di rango $k-|A_{1}|-1$ in $A_{2}$

Implementazione:

```python
def selezione2(A,k):
	if len(A) == 1:
		return A[0]
	perno = A[0]
	A1, A2 = [], []
	for i in range(len(A)):
		if A[i] < perno:
			A1.append(A[i])
		else:
			A2.append(A[i])
	if len(A1) >= k:
		return selezione2(A1, k)
	elif len(A1) == k-1:
		return perno
	return selezione2(A2, k - len(A1) - 1)
```

_Continuare slide 6 con studio del caso pessimo ovvero lista completamente sbilanciata_

