## Notazione "o piccolo"
Si chiama $o(h^n) \ (n\in\mathbb{N})$ una qualsiasi quantità tale che $$\lim_{h\rightarrow 0}{\frac{o(h^n)}{h^n} = 0}$$
Quindi una qualsiasi quantità "più veloce" di $h^n$
**Esempi**
$h^2$ è $o(h)$? Si perché $\lim_{h\rightarrow 0}{\frac{h^2}{h}} = 0$
$h$ è $o(h)$? No perché $\lim_{h\rightarrow 0}{\frac{h}{h}} = 1$ 

#### Proprietà
- $h^k * o(h^n)=o(h^{n+k})$
- $o(h^k)*o(h^n) = o(h^{n+k})$
- $o(h^n)\pm o(h^n)=o(h^n)$
- $M\in\mathbb{R} \ \ \ Mo(h^n)=o(h^n)$

Per come utilizzeremo questa notazione ci conviene scrivere: $$\lim_{x_0\rightarrow 0}{\frac{o((x-x_0)^n)}{(x-x_0)^n}} = 0$$
Una funzione $f$ è derivabile in $x_0$ **se e solo se** $f(x)=f(x_0)+f'(x_0)(x-x_0)+o((x-x_0)^1)$
*Nella formula utilizziamo una sola derivata perché l'esponente di $x-x_0$ è 1.*
***Caso Generale***
$f(x)=P_n(x;x_0)+o((x-x_0)^n)$

**Quindi**
$f(x) = f(x_0)+f'(x_0)(x-x_0) \rightarrow$ Questa parte ci indica la tangente nel punto $x_0,f(x_0)$
$+o((x-x_0)^1)$ un infinitesimo

Otteniamo che
Se $f(x)$ è derivabile in $x_0$, $f(x)$ = Polinomio di 1° grado ($f(x_0)+f'(x_0)(x-x_0)$) + infinitesimo di ordine superiore a 1 ovvero $o((x-x_0))$

Nel caso in cui avessimo $f(x)$ = polinomio di 2° grado più infinitesimo di ordine superiore a 2 ovvero $$f(x) = f(x_0)+f'(x_0)(x-x_0)+\frac{f''(x_0)}{2}(x-x_0)^2+o((x-x_0)^2)$$
E se arriviamo al terzo grado?
$$f(x) = f(x_0)+f'(x_0)(x-x_0)+\frac{f''(x_0)}{2!}(x-x_0)^2+\frac{f'''(x_0)}{3!}(x-x_0)^3+o((x-x_0)^3)$$
Quindi in realtà il denominatore è il *fattoriale del grado* e non il grado stesso

## Teorema - Formula di Taylor
$$f(x) = \sum_{k=0}^{n}\frac{f^{(k)} x_0}{k!}(x-x_0)^k+o((x-x_0)^n)$$
Quindi ogni iterazione aggiungiamo un polinomio di grado $\leq n$ e un infinitesimo di ordine superiore a $n$.

#### Esempi
$f(x) = x^3 + x^2 + x + 2$
$T_1(f(x);0) = ?$

**Cerco un polinomio di primo grado tale che**
$f(x) = T_1(f(x);0)+o(x^1)$
**Quindi**
$f(x) = o(x) + o(x) + x + 2 = 2+x+o(x)$
Gli o piccoli li prendiamo dalle x di grado superiore al primo

## Teorema
Il polinomio di Taylor di ordine n di un polinomio di grado n è il polinomio stesso.

## Sviluppi di Taylor
$$sen(x) = \sum_{k=0}^{n}{\frac{(-1)^kx^{2k+1}}{(2k+1)!}+o(x^{2n+1})}$$
$$cos(x) = \sum_{k=0}^n{\frac{(-1)^kx^{2k}}{(2k+!}+o(x^{2n})}$$
$$e^x=\sum_{k=0}^n{\frac{x^k}{k!}}+o(x^n)$$
**Quindi**
$sen(x) = x-\frac{x^3}{3!}+\frac{x^5}{5!}-\frac{x^7}{7!}+\frac{x^9}{9!} - ...$
$cos(x) = 1-\frac{x^2}{2!}+\frac{x^4}{4!}-\frac{x^6}{6!}+\frac{x^8}{8!}-...$


## Esercizi
Per svolgere gli esercizi dobbiamo arrivare ad ottenere un polinomio di grado uguale o inferiore al polinomio di Taylor + un o piccolo di x elevata al grado del polinomio.