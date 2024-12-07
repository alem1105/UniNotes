Date due funzioni asintoticamente non negative $f(n)$ e $g(n)$ si di che **$f(n)$ è in $g(n)$ se esistono due costanti $c > 0$ e $n_0 \geq 0$ tali che $f(n)\leq cg(n)$ per ogni $n\geq n_0$**
Quindi in $O(g(n))$ troviamo tutte le funzioni che risultano **dominate** dalla funzione $g(n)$.

![[Pasted image 20240226183902.png]]

_Esempio:_
É facile vedere che $\sqrt{n} = O(n)$ in quanto la funzione radice cresce meno della funzione lineare.
Per provarlo in modo formale possiamo utilizzare i limiti ricordando che $f(n)\in O(g(n))$ se $\lim_{x\rightarrow +\infty}\frac{f(n)}{g(n)} \neq +\infty$
Generalizzando il nostro caso otteniamo:

$$\lim_{x\rightarrow+\infty}\frac{n^\frac{1}{a}}{n^b}=0$$ 
Oppure = 1 se $a=b=1$

### Altri Esempi
![[Pasted image 20240226184036.png]]![[IMG_0007.jpg]]