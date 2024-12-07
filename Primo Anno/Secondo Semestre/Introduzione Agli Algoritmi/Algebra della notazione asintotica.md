Per semplificare il calcolo del costo computazionale asintotico degli algoritmi si possono sfruttare delle semplici regole.

## Regole sulle costanti moltiplicative

- **1A:** se $f(n)$ è un $O(g(n))$ allora anche $k*f(n)$ è un $O(g(n))$
- **1B:** se $f(n)$ è un $Ω(g(n))$ allora anche $k*f(n)$ è un $Ω(g(n))$
- **1C:** se $f(n)$ è un $Θ(g(n))$ allora anche $k*f(n)$ è un $Θ(g(n))$

**In generale, le costanti moltiplicative si possono ignorare**

## Regole sulla commutatività con la somma

Per ogni $f(n),d(n)>0$
- **2A:** se $f(n)$ è un $O(g(n))$ e $d(n)$ è un $O(h(n))$ allora $f(n)+d(n)$ è un $O(g(n)+h(n))=O(max(g(n),h(n)))$
- **2B:** se $f(n)$ è un $Ω(g(n))$ e $d(n)$ è un $Ω(h(n))$ allora $f(n)+d(n)$ è un $Ω(g(n)+h(n))=Ω(max(g(n),h(n)))$
- **3B:** se $f(n)$ è un $Θ(g(n))$ e $d(n)$ è un $Θ(h(n))$ allora $f(n)+d(n)$ è un $Θ(g(n)+h(n))=Θ(max(g(n),h(n)))$

**In generale, le notazioni asintotiche commutano con la somma.**

## Regole sulla commutatività con il prodotto

Per ogni $f(n),d(n)>0$
- **3A:** se $f(n)$ è un $O(g(n))$ e $d(n)$ è un $O(h(n))$ allora $f(n)*d(n)$ è un $O(g(n)*h(n))$
- **3B:** se $f(n)$ è un $Ω(g(n))$ e $d(n)$ è un $Ω(h(n))$ allora $f(n)*d(n)$ è un $Ω(g(n)*h(n))$
- **3C:** se $f(n)$ è un $Θ(g(n))$ e $d(n)$ è un $Θ(h(n))$ allora $f(n)*d(n)$ è un $Θ(g(n)*h(n))$

**In generale, le notazioni asintotiche commutano con la moltiplicazione.**

## Dimostrazioni
![[Screenshot 2024-02-29 alle 22.04.39.png]]

![[Screenshot 2024-02-29 alle 22.04.49.png]]

![[Screenshot 2024-02-29 alle 22.04.58.png]]