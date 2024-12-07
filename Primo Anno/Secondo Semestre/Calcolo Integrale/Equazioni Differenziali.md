# Equazioni Differenziali

Le equazioni differenziali sono equazioni dove **l'incognita è una funzione** e in cui sono presenti una o più derivate della funzione incognita

_Esempio_

$$
f(x)+f'(x)=x
$$

Dobbiamo quindi trovare una funzione da sostituire con $f(x)$ che soddisfa l'equazione.
Quindi in questo caso le soluzioni saranno tutte le funzioni del tipo $y=f(x)$ che sommate alla loro derivata prima danno come risultato $x$.
Infatti spesso al posto di $f(x)$ si utilizza la notazione $y, y'$:

$$
y'+y=x
$$

_Esempio 2_

$$
f'''(x)+3f''(x)=9x
$$

Qui, anche se non compare esplicitamente $f(x)$, compaiono delle sue derivate e dobbiamo comunque trovare una $f(x)$ che rispetti l'equazione.
Quindi possiamo scrivere:

$$
y'''+3y''=9x
$$

E la soluzione è data quindi da tutte le funzioni del tipo $y=f(x)$ la cui derivata terza sommata a 3 volte la derivata seconda danno come risultato $9x$

> [!info] Ordine
> L'ordine di un'equazione differenziale è il massimo ordine di derivazione che compare

**Per risolvere le equazioni differenziali non esiste un metodo standard ma bisognerà analizzare caso per caso e trovare il metodo più adatto.**

_Esempio 3_

$$
f'(x)=x
$$

Quindi abbiamo un'equazione differenziale del **primo ordine**.
Per risolverla dobbiamo chiederci, **quali sono le funzioni la cui derivata prima è uguale a x?**

In questo caso possiamo ad esempio risolvere l'integrale indefinito 

$$
\int x\ dx=\frac{x^2}{2}+c
$$

per trovare così la famiglia delle primitive che danno come derivata prima $x$, quindi il risultato è l'insieme delle funzioni $\{\frac{x^2}{2}+c\}$, abbiamo ottenuto quindi un insieme di soluzioni che variano in base al parametro $c$.

_Esempio 4_

Non sempre il risultato è così immediato

$$
f'(x)=2-\sqrt{f(x)}
$$

In questo caso non possiamo utilizzare lo stesso metodo di prima perché otteniamo un calcolo come questo:

$$
f(x)=\int f'(x)\ dx=\int[2-\sqrt{f(x)}]\ dx
$$

Ma per calcolare questo integrale dobbiamo conoscere $f(x)$, impareremo a risolverlo più avanti.

---

Le equazioni differenziali del primo ordine si dividono in diverse categorie:
- _Equazioni Differenziali Elementari_
- _Equazioni Differenziali a Variabili Separabili_
- _Equazioni Differenziali Lineari_

---

## Equazioni Differenziali Elementari

Sono quelle equazioni differenziali che possono essere risolte in modo abbastanza immediato

**Tipologia 1**

$$
y'=f(x)
$$

In questo caso basta integrare:

$$
y=\int f(x)\ dx=F(x)+c
$$

_Esempio_

$$
y'=3e^{2x}
$$

Integriamo:

$$
\int3e^{2x}dx=3\int e^{2x}dx=\frac{3}{2}\int2e^{2x}dx=\frac{3}{2}e^{2x}+c
$$


**Tipologia 2**

$$
y''=f(x)
$$

In questo caso, in modo molto simile a prima ci basta integrare 2 volte:

$$
y'=\int f(x)dx=F(x)+c
$$

$$
y=\int F(x)+c_1 \ dx=\int F(x)dx+c_1x+c_2
$$

_Esempio_

$$
\begin{align*}
y''&=2-\cos(x)\\
y'&=\int2-\cos(x)\ dx=2x-\sin(x)+c_1\\
y&=\int2x-\sin(x)+c_1\ dx \\
&= \int2x\ dx-\int\sin(x)\ dx+\int c_1 \ dx \\
&= 2\cdot\frac{x^2}{2}+\cos(x)+c_1x+c_2=x^2+\cos(x)+c_1x+c_2
\end{align*}
$$


> [!Info] Parametri Soluzione
> Se l'equazione differenziale è di ordine $n$ ci aspettiamo infinite soluzioni parametrizzate da $n$ parametri.
> Infatti nelle equazioni di primo ordine abbiamo ottenuto una sola $c$ mentre in questa equazione di secondo ordine abbiamo ottenuto due parametri $c_1, c_2$ diversi.

## Problema di Cauchy
Alcune volte le equazioni differenziali possono essere accompagnate da delle **condizioni iniziali**, in questi casi ci troviamo davanti ad un **problema di Cauchy**.
Risolvere un problema di Cauchy significa trovare tra le infinite soluzioni dell'equazione differenziale quella che soddisfa le condizioni iniziali.

$$
\begin{cases}
y'=-e^{-x} \\
y(0)=3
\end{cases}
$$

1) Per prima cosa risolviamo l'equazione differenziale come sempre, quindi integrando otteniamo:

$$
y =\int-e^{-x}\ dx=e^{-x}+c
$$

2) Sfruttiamo la condizione iniziale per trovare il parametro $c$, quindi sostituendo $y$ e $x$:

$$
3 = e^{-0}+c \rightarrow c=2
$$

Quindi la soluzione del problema di Cauchy è:

$$
y(x)=e^{-x}+2
$$

E non è più un'insieme di infinite soluzioni, ma una funzione soltanto

_Esempio_

![[Pasted image 20240506165303.png]]


> [!info] Condizioni e Parametri
> Notiamo che il numero di condizioni iniziali deve essere uguale al numero di parametri $c$ che differenziano la nostra funzione, inoltre devono fissare i valori della funzione o sue derivate in uno stesso punto, guardando l'esempio precedente tutte le condizioni fissano le funzioni in $x=0$.

## Equazioni Differenziali a Variabili Separabili
Sono equazioni differenziali del primo ordine riconducibili alla seguente forma:

$$
y'=f(x)\cdot g(y)
$$

_Esempi_

$$
y'=y\ln x \ \ | \ \ y'=e^xy\ln y
$$
In entrambi gli esempi compare un "pezzo" in funzione di $y$ un altro in funzione di $x$.


> [!info] Come si risolvono?
> Dobbiamo separare le variabili $x$ ed $y$, integriamo ciascun membro rispetto alla variabile da cui dipende e infine ricaviamo $y(x)$

_Esempio 1_

![[Pasted image 20240511195741.png]]

_Esempio 2_

![[Pasted image 20240511200805.png]]

Non sempre è facile eseguire questi passaggi, potrebbe accadere di incontrare qualche integrale più complesso.


> [!info] Soluzioni Costanti
> Come successo nel primo esempio dobbiamo controllare se oltre alle soluzioni trovate l'equazione differenziale ammette soluzioni costanti.
> Data un'equazione differenziale $y'=f(x)\cdot g(y)$ se esiste un numero $\overline{y}$ tale che $g(\overline{y})=0$ allora $y(x)=\overline{y}$ è una soluzione dell'equazione differenziale.
> Nel primo esempio infatti ponendo $y(x)=0$ azzeravamo il termine a destra rendendo sempre vera l'equazione.

## Equazioni Differenziali Lineari del Primo Ordine
Sono tutte quelle equazioni differenziali della forma:

$$
y'(x)+a(x)\cdot y(x)=f(x)
$$

Quindi sono equazioni dove compare la derivata prima più la funzione che vogliamo moltiplicare moltiplicata per una funzione di $x$, tutto questo uguale ad un'altra funzione di $x$.

_Esempi_

$$
y'-xy=2x \ \ | \ \ y'+\frac{1}{x}\cdot y=4x^2
$$

Notiamo subito due cose:
- Se $a(x)=0$ e quindi non compare nell'equazione ricadiamo in quelle che abbiamo definito **equazioni differenziali elementari**
- Se $f(x)=0$ cadiamo invece in un'**equazione differenziale a variabili separabili**

> [!info] Come si risolvono?
> Si utilizza un metodo chiamato **fattore integrante**:
> - Trovo una primitiva di $a(x)$
> - Moltiplico entrambi i membri per $e$ elevato alla primitiva $A(x)$ ottenendo quindi $y'(x)e^{A(x)}+a(x)e^{A(x)}y(x)=f(x)e^{A(x)}$ e notiamo che nel membro a sinistra abbiamo ottenuto $[y(x)e^{A(x)}]'$
> - Integriamo entrambi i membri e quindi otteniamo:
> $$
> y(x)e^{A(x)}=\int f(x)e^{A(x)}\ dx+c
> $$
> - Infine ricaviamo $y(x)$ moltiplicando entrambi i membri per $e^{-A(x)}$
> $$
> y(x)=e^{-A(x)}\int f(x)e^{A(x)}\ dx+ce^{-A(x)}
> $$

_Esempio 1_

![[Pasted image 20240511214212.png]]

Anche in questo caso i passaggi sono facilmente eseguibili se troviamo integrali non troppo complessi durante il metodo risolutivo.

## Equazioni Differenziali del Secondo Ordine a Coefficienti Costanti Omogenee

Si presentano come equazioni differenziali del tipo:

$$
ay''(x)+by'(x)+cy(x)=0
$$

Dove $a, b, c$ sono numeri Reali.

Le soluzioni di questo tipo di equazioni hanno una particolarità, se prendiamo una soluzione e la moltiplichiamo per una costante otteniamo allora un'altra soluzione dell'equazione e se prendiamo due soluzioni qualsiasi e le sommiamo (anche moltiplicate per altre costanti), la funzione risultato della somma è ancora risultato.

Le soluzioni saranno quindi nella forma:

$$
y(x)=c_{1}y_{1}(x)+c_{2}y_{2}(x)
$$

Quindi le funzioni ci danno la base mentre i parametri $c$ ci torneranno utili per trovare soluzioni uniche nei problemi di Cauchy.

Per trovare la soluzione dobbiamo risolvere nell'insieme dei numeri complessi $\mathbb{C}$ la **funzione caratteristica** $az^2+bz+c=0$ dove i parametri $a,b,c$ sono li stessi che compaiono nell'equazione differenziale iniziale, essendo un'equazione di secondo grado possono verificarsi 3 casi:
- 2 soluzioni reali e distinte $\lambda_1\neq\lambda_{2}$: Allora $y_1(x)$ e $y_2(x)$ saranno uguali, rispettivamente a $e^{\lambda_1x}$, $e^{\lambda_2x}$ e quindi abbiamo come **soluzione generale**:

$$
y(x)=c_1e^{\lambda_1x}+c_2e^{\lambda_2x}
$$

- 2 soluzioni reali coincidenti $\lambda_1=\lambda_{2}$: Allora $y_1(x)$ e $y_2(x)$ saranno uguali, rispettivamente a $e^{\lambda x}$, $xe^{\lambda x}$ e quindi abbiamo come **soluzione generale**:

$$
y(x)=c_1e^{\lambda x}+c_2xe^{\lambda x}
$$

- 2 soluzioni complesse $\lambda_{1,2}=\alpha \pm i\beta$: Allora $y_1(x)$ e $y_2(x)$ saranno uguali, rispettivamente a $e^{\alpha x}\cos(\beta x),e^{\alpha x}\sin(\beta x)$ e quindi abbiamo come **soluzione generale**:

$$
y(x)=c_1e^{\alpha x}\cos(\beta x)+c_2e^{\alpha x}\sin(\beta x)
$$
_Esempio 1_

![[Pasted image 20240519170438.png|500]]

_Esempio 2_

![[Pasted image 20240519172720.png]]

## Equazioni di secondo ordine non omogenee

^d56ed6

Sono equazioni del tipo:

$$
y''(t)+ay'(t)+by(t)=f(t)
$$

$f(t)$ è anche detta **forzante**.

Per risolvere dobbiamo prima di tutto studiare la sua forma omogenea con gli stessi passaggi che già conosciamo, la soluzione quindi sarà una famiglia di soluzioni parametrizzate da _c1 e c2_, questa famiglia la chiameremo $y_g(t)$ (generale).

Adesso dobbiamo cercare una soluzione **specifica** $y_p$ dell'equazione non omogenea, utilizziamo il **metodo di somiglianza**:

- Se $f(t)$ è un polinomio di grado _n_ cerchiamo una soluzione che sia sempre un polinomio di grado _n_:
  Basandoci sulle soluzioni $\lambda$ del polinomio caratteristico individuiamo questi casi:
  - $\lambda = 0$ **non è soluzione** del polinomio caratteristico, allora $y_p$ sarà un polinomio di grado _n_
  - $\lambda = 0$ **è soluzione** del polinomio caratteristico con **molteplicità 1**, allora $y_p$ sarà un polinomio di grado _n_ moltiplicato per $t$
  - $\lambda = 0$ **è soluzione** del polinomio caratteristico con **molteplicità 2**, allora $y_p$ sarà un polinomio di grado _n_ moltiplicato per $t^2$
- Se $f(t)=e^{\alpha t}P(t)$ con $P(t)$ di grado _n_:
	- Se $\alpha$ **non è soluzione** del polinomio caratteristico, $y_p=e^{\alpha t} \cdot$ Polinomio di grado _n_
	- Se $\alpha$ **è soluzione** di **molteplicità 1** del polinomio caratteristico, $y_p=te^{\alpha t} \cdot$ Polinomio di grado _n_
	- Se $\alpha$ **è soluzione** di **molteplicità 2** del polinomio caratteristico, $y_p=t^2e^{\alpha t} \cdot$ Polinomio di grado _n_
- Se $f(t)=P_{m}e^{\alpha t}\cos(\beta t)+Q_{n}e^{\alpha t}\sin(\beta t)$ con $P_m$ e $Q_n$ polinomi di grado _m,n_:
	- **NOTA:** se $\beta = 0$ ci troviamo nel caso di prima
	- Se $\alpha\pm i\beta$ **non è soluzione** del polinomio caratteristico, $y_p=e^{\alpha t}[A(t)\cos(\beta t)+B(t)\sin(\beta t)]$ dove $A, B$ sono polinomi di grado $max(n,m)$.
	- Se $\alpha\pm i\beta$ **è soluzione** del polinomio caratteristico, $y_p=te^{\alpha t}[A(t)\cos(\beta t)+B(t)\sin(\beta t)]$ dove $A, B$ sono polinomi di grado $max(n,m)$.

**Caso Particolare dell'ultimo**.
Quando $\alpha=0$ e $m=n=0$ abbiamo $f(t)=c_1\cos(\beta t)+c_2\sin(\beta t)$:
- Se $i\beta$ **non è soluzione** del polinomio caratteristico, $y_p=\gamma_1\cos(\beta t)+\gamma_2\sin(\beta t)$
-  Se $i\beta$ **è soluzione** del polinomio caratteristico, $y_p=t[\gamma_{1}\cos t+\gamma_{2}\sin t]$

Per calcolare i polinomi utilizziamo un'equazione, _esempi dopo_.

Una volta ottenuta anche una soluzione particolare, per ottenere la soluzione dell'equazione differenziale ci basta sommare la generale alla particolare.

_Esempio con f(t) Polinomio_

![[Pasted image 20240526101405.png]]

_Esempio con f(t) esponenziale per polinomio_

![[Pasted image 20240526105023.png]]

# Riassunto Esercizi

Per distinguere le equazioni differenziale dobbiamo individuare **ordine, linearità, coefficienti, omogenea o non.**

Prendiamo ad esempio questa equazione differenziale:

$$
y'+t^2y=0
$$

- L'**ordine** è dato dal grado massimo delle derivate che compaiono, in questo caso quindi è 3
- Si dice **lineare** se la funzione $y$ non compare come variabile di altre funzioni
- I **coefficienti** sono i coefficienti che moltiplicano la $y$ quindi possono essere costanti oppure variabili
- Si dice **omogenea** se = 0 altrimenti non omogenea

Quindi in questo caso abbiamo un'equazione differenziale del primo ordine, lineare, a coefficienti variabili e omogenea.

## Metodi Risolutivi 1° Ordine

In tutti i casi, se ho un problema di Cauchy devo sostituire i casi iniziali e ricavare la $c$.

### | Coefficienti Costanti Omogenee

$$
y'(t)+ay(t)=0 \qquad y(t)= c\cdot e^{-at},c\in\mathbb{R}
$$

### | Coefficienti Costanti non Omogenee

$$
y'(t)+ay(t)=f(t)
$$

- Moltiplicare entrambe le parti per $e^{at}$
- A sinistra otteniamo derivate del prodotto $e^{at}\cdot y(t)$, quindi integro entrambe le parti e divido per $e^{a}$:

$$
\begin{align*}
&e^{at}y(t)=\int f(t)e^{at}\ dt\\
&\text{Quindi:}\\ \\
&y(t)=\frac{\int f(t)e^{at}\ dt}{e^{at}}
\end{align*}
$$

### | Coefficienti Variabili non omogenee

$$
y'(t)+a(t)y(t)=f(t)
$$

- Calcolo $A(t)$ ovvero la primitiva di $a(t)$
- Moltiplico entrambi i membri per $e^{A(t)}$
- A sinistra ottengo la derivate del prodotto $y(t)e^{A(t)}$, quindi integro entrambe le parti e divido per $e^{A(t)}$

$$
y(t)=\frac{\int f(t)e^{A(t)} \ dt}{e^{A(t)}}
$$

### | Non Lineari di 1° Ordine

Vediamo esempio con P.b.C.

$$
\begin{cases}
y'(t)=g(t)f(y(t)) \qquad f\in C^0(S)\\
y(t_0)=y_{0}\qquad \qquad \quad \ \ g\in C^0(I)
\end{cases}
$$

- Controlliamo se i dati iniziali appartengono ai rispettivi domini, quindi se $y_{0}\in S$ e se $t_{0}\in I$
- Controlliamo se c'è una **soluzione stazionaria**, infatti se esiste un numero $y_{0}$ tale che $f(y_0)=0$ allora una soluzione sarà $y(t)=y_0$ ma non è detto che sia l'unica.
  Questo accade perché avendo 0 al secondo membro otteniamo la derivata di una costante che sarà sempre 0. (si fa alla fine)
- Studiamo il caso $f(y_{0})\neq0$, quindi studiamo la funzione finché $f(y_{t})$ non si annulla.
- Dividiamo per $f(y(t))$ entrambi i membri e integriamo le due parti:

$$
\int\frac{y'(t)}{f(y(t))}\ dt=\int g(t) \ dt
$$

- Sostituire dato iniziale per trovare $c$
- Calcolare il dominio per vedere dove si annulla

> [!hint]- Esempio
> ![[Pasted image 20240526125947.png]]

> [!hint]- Esempio
> ![[Pasted image 20240526133546.png]]

## 2° Ordine Omogenee

$$
ay''(t)+by'(t)+cy(t)=0
$$

- Scrivere il polinomio caratteristico $a\lambda^{2}+b\lambda+c=0$ e risolverlo
- In base alle soluzioni trovate scriviamo la soluzione generale:
	- $\lambda_{1}\neq\lambda_{2}$ -> $y(t)=c_1e^{\lambda_{1}t}+c_2e^{\lambda_{2}t}$
	- $\lambda_{1}=\lambda_{2}$ -> $y(t)=c_1e^{\lambda t}+c_2te^{\lambda t}$
	- $\lambda=\alpha\pm i\beta$ (2 zeri complessi coniugati) -> $y(t)=c_1e^{\alpha t}\cos(\beta t)+c_2e^{\alpha t}\sin(\beta t)$

## 2° Ordine non Omogenee

[[#^d56ed6|Stanno scritte sopra :(]]
