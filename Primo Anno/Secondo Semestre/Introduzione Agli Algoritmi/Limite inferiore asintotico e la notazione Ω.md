  Date due funzioni asintoticamente positive $f(n)$ e $g(n)$ si dice che **$f(n)$ è in $Ω(g(n))$ se esistono due costanti $c>0$ e $n_0\geq0$ tali che $f(n)\geq cg(n)$ per ogni $n\geq n_0$**
  In $Ω(g(n))$ troviamo tutte le funzioni che **dominano** la funzione $g(n)$.
  ![[Pasted image 20240226191324.png]]
  _Esempio:_
  Provare che 
  
  $$\frac{n}{\log_e n}\inΩ(\sqrt{n}\log_en)$$
  
Per provarlo possiamo utilizzare il metodo del rapporto dei limiti ricordando che $f(n)\inΩ(g(n))$ se il $lim \rightarrow +\infty$ del rapporto fra $f(n)$ e $g(n)$ $\neq 0$.
Nel nostro caso otteniamo:

$$\lim_{n\rightarrow+\infty}\frac{\sqrt{n}}{\log^2n}=+\infty$$

Ricordando che la radice cresce più velocemente del logaritmo

### Altri Esempi
  ![[Pasted image 20240226193809.png]] ![[photo_2024-02-26_19-48-32.jpg]]