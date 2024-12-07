Date due funzioni asintoticamente positive $f(n)$ e $g(n)$ si dice che **$f(n)$ è in $Θ(g(n))$ se esistono tre costanti $c_1,c_2>0$ e $n_0\geq0$ tali che $c_1g(n)\leq f(n)\leq c_2g(n)$ per ogni $n\geq n_0$**
Quindi in $Θ(g(n))$ troviamo tutte le funzioni che hanno lo stesso ordine asintotico di $g(n)$.

![[Pasted image 20240226200901.png]]
![[Pasted image 20240226201137.png]]

_Esempio:_
Prova che 

$$\log_an\inΘ(\log_bn)$$

per ogni $a,b>1$

Ricordiamo che $f(n)\inΘ(g(n))$ se il limite per $n\rightarrow+\infty$ del rapporto $\frac{f(n)}{g(n)} = k$ con $k$ costante diversa da zero.
Nel nostro caso otteniamo:

$$\lim_{x\rightarrow+\infty}\frac{f(n)}{g(n)}=\lim_{x\rightarrow+\infty}\frac{\log_an}{\log_bn}$$


Applicando il cambio di base dei logaritmi otteniamo che 

$$\log_an=\frac{\log_bn}{\log_ba}$$


Quindi:

$$\lim_{x\rightarrow+\infty}\frac{\log_bn}{\log_ba}*\frac{1}{\log_bn}=\lim_{x\rightarrow+\infty}\frac{1}{\log_ba}=\frac{1}{\log_ba}$$

Ovvero una costante maggiore di 0


> [!info] Cambio di base
> Il cambio di base è dunque asintoticamente irrilevante ed è per questo che nella notazione asintotica la base del logaritmo viene spesso omessa e si scrive ad esempio semplicemente $\log_an\inΘ(\log n)$.
