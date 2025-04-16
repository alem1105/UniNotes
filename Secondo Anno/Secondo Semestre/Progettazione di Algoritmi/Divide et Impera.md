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

Questa procedura che tripartisce la lista può però restituire una partizione massimamente sbilanciata in cui si ha ad esempio $|A1|=0,|A2=n-1|$ ovvero quando il perno è l'ultimo elemento della lista.

Se poi questo caso si ripete ad ogni partizione creata dall'algoritmo allora la complessità di questo sarebbe catturata da:

$$
\begin{align*}
T(n)&=T(n-1)+\Theta(n) \\
T(n)&=\Theta(n^2)
\end{align*}
$$

In generale la complessità superiore dell'algoritmo è data da:

$$
T(n)=T(m)+\Theta(n)
$$

Dove $m=max\{ |A1|,|A2| \}$

Quindi se avessimo una scelta del perno che garantisca sempre un equilibrio fra le liste che crea l'algoritmo avremo che:

$$
m=max\{ |A1|,|A2| \}\approx \frac{n}{2}
$$

E quindi la complessità diventa:

$$
\begin{align*}
T(n)&=T\left( \frac{n}{2} \right) + \Theta(n) \\
T(n)&=\Theta(n)
\end{align*}
$$

Ovviamente avere sempre un perno che divide a metà le liste è troppo, osserviamo che in realtà possiamo accontentarci di una qualsiasi frazione $n$ anche piuttosto vicina ed ottenere sempre $T(n)=\Theta(n)$.

Ad esempio se $m=max\{ |A1|,|A2| \} \approx \frac{3n}{4}$ abbiamo:

$$
T(n)\leq T\left( \frac{3}{4}n \right)+\Theta(n)
=\Theta(n)
$$

---


Proviamo quindi a scegliere il perno a caso in modo equiprobabile tra gli elementi della lista, in questo modo anche se la scelta non produce una lista perfettamente bilanciata avremo comunque una complessità lineare.

```python
def selezione2R(A, k):

	if len(A)==1
		return A[0]
	perno = A[randint(0, len(A) - 1)]
	A1, A2 = [], []
	for x in A:
		if x < perno:
			A1.append(x)
		elif x > perno:
			A2.append(x)
	if len(A1) >= k:
		return selezione2R(A1, k)
	elif len(A1) == k - 1:
		return perno
	return selezione2R(A2, k - len(A1) - 1)
```

Con questo algoritmo abbiamo che con alta probabilità il costo è lineare mentre al caso peggiore, che accade con una probabilità molto piccola è di $O(n^2)$.

---

C'è in realtà un algoritmo deterministico che garantisce una complessità di $O(n)$ anche al caso pessimo.

Questo modo noto come **mediano dei mediani** garantisce che il perno scelto produce sempre due sottoliste A1 e A2 ciascuna delle quali ha non più di $\frac{3}{4}n$ elementi.

1) Dividi l'insieme A da $n$ elementi in gruppi da 5, ovviamente l'ultimo potrebbe non averne 5. Si prendono in considerazione soltanto i primi $\left\lfloor  \frac{n}{5}  \right\rfloor$ gruppi.
2) Si trova il mediano all'interno di ciascuno di questi gruppi
3) Si calcola il mediano $p$ dei mediani precedenti
4) Si usa $p$ come pivot per $A$

```python
def selezione(A, k):
	if len(A) <= 120:
		A.sort()
		return A[k - 1]
	B = [sorted(A[5*i:5*i+5])[2] for i in range(len(A)//5)]
	perno = selezione(B, ceil(len(A)/10))
	A1, A2 = [], []
	for x in A:
		if x < perno:
			A1.append()
		elif x > perno:
			A2.append()
	if len(A1) >= k:
		return selezione(A1, k)
	elif len(A1) == k - 1:
		return perno
	return selezione(A2, k - len(A1) - 1)
```

Questo algoritmo quindi risolve il problema in modo lineare anche al caso pessimo, però a causa delle grandi costanti nascoste nell'$O(n)$, in realtà l'algoritmo random di prima si comporta meglio.