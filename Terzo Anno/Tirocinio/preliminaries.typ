#import "@preview/zebraw:0.6.3": *
#show: zebraw.with(numbering: false, lang: false)

= Linear Algebra
== Scalars
I numeri che utilizziamo tutti i giorni prendono il nome di *scalari*, li indicheremo con lettere _lower-case_ come $x,y,z$ e lo spazio di tutti gli scalari *reali* $RR$.

Implementiamo gli scalari come dei tensor da un solo elemento, vediamo un esempio di assegnamento e delle operazioni:

```python
x = torch.tensor(3.0)
y = torch.tensor(2.0)

x + y, x * y, x / y, x**y
# Output
# (tensor(5.), tensor(6.), tensor(1.5000), tensor(9.))
```

== Vectors
Possiamo vedere i vettori come degli array di scalari con lunghezza fissa, gli scalari saranno gli _elementi_ del vettore. Quando li utilizzeremo per rappresentare problemi reali avremo che ogni elemento indica un parametro di cosa stiamo analizzando. Indichiamo i vettore con lettere lowercase bold come *$x,y,z$*.

Ci riferiamo agli elementi di un vettore con la lettera del vettore e l'indice dell'elemento in basse, $x_2$ indica l'elemento con indice 2 nel vettore *$x$*. Normalmente li visualizziamo impilando gli elementi verticalmente:

$ bold(x) = vec(x_1,dots.v,x_3, delim: "[") $

Per indicare che un vettore contiene $n$ elementi scriviamo che $bold(x) in RR^n$, formalmente diciamo che $n$ è la *dimensione* dell'array, questa nel codice corrisponde appunto alla lunghezza del tensor che possiamo richiamare con `len(x)` oppure tramite l'attributo `x.shape`.

Per fare chiarezza indichiamo con:
- *Order*: Numero degli assi di un vettore
- *Dimensionality*: Numeri dei componenti

== Matrici
Gli scalari sono tensor di ordine 0, i vettori sono tensor di ordine 1 e le matrici sono di ordine 2. Le indichiamo con lettere upper case bold, quindi *$X,Y,Z$* e le rappresentiamo nel codice con vettori con due assi. Con l'espressione $bold(A) in RR^(m times n)$ indichiamo che una matrice $bold(A)$ contiene $m times n$ valori reali ordinati in $m$ righe e $n$ colonne. Quando $m = n$ diciamo che la matrice è _quadrata_. Possiamo illustrarla come una tabella e per indicare un elemento usiamo il doppio pedice, quindi $a_(i,j)$ indica l'elemento nella i-esima riga e alla j-esima colonna di $bold(A)$.

$ bold(A) = mat(delim: "[", a_11, a_12, dots.h, a_(1n);
a_21, a_22, dots.h, a_(2n);
dots.v, dots.v, dots.down, dots.v;
a_(m 1), a_(m 2), dots.h, a_(m n)) $

É possibile invertire gli assi ovvero scambiare righe con colonne, il risultato é la *matrice trasposta*, la indichiamo con $bold(A)^top$. Otteniamo che se $bold(B)=bold(A)^top$ allora $b_(i j)= a_(j i)$ per ogni $i,j$. Inoltre la trasposta di una matrice $m times n$ sará una matrice $n times m$.

Le matrici *simmetriche* sono un sottoinsieme delle matrici quadrate, sono matrici uguali alla loro trasposta, quindi $bold(A) = bold(A)^top$

== Tensors
I tensors ci danno modo di rappresentare array di ordine $n$. Li indichiamo con lettere maiuscole X,Y,Z e per gli elementi utilizziamo lo stesso meccanismo di indici delle matrici. I tensors diventeranno piú importanti quando lavoreremo con le immagini, ognuna infatti é rappresentata da un tensor di ordine 3 dove gli assi corrispondono a _altezza, larghezza e canali_. Una collezione di immagini sará quindi un tensor di ordine 4.

=== Basic Properties of Tensor Arithmetic
Scalari, vettori, matrici e tensors hanno delle proprietá, ad esempio le operazioni _elementwise_ producono output della stessa forma degli operandi.

```python
A = torch.arange(6, dtype=torch.float32).reshape(2, 3)
B = A.clone()  # Alloca nuova memoria per B
A, A + B

# Output
# (tensor([[0., 1., 2.],
#          [3., 4., 5.]]),
#  tensor([[ 0.,  2.,  4.],
#          [ 6.,  8., 10.]]))
```

Il prodotto _elementwise_ di due matrici si chiama *Hadamard Product*, lo indichiamo con $dot.o$. Gli elementi saranno quindi:

$ bold(A) dot.o bold(B) = mat(delim:"[", a_11 b_11, a_12 b_12, dots.h, a_(1n) b_(1n) ; a_21 b_21, a_22 b_22 , dots.h, a_(2n) b_(2n) ; dots.v, dots.v, dots.down, dots.v ; a_(m 1) b_(m 1), a_(m 2) b_(m 2) , dots.h, a_(m n) b_(m n)) $

Andando invece a sommare o moltiplicare un tensor con uno scalare otteniamo un tensor con la stessa forma di quello originale ma su ogni elemento viene applicata l'operazione specificata.

=== Reduction
Spesso ci capiterá di dover calcolare la somma di tutti gli elementi di un tensor. Matematicamente possiamo esprimerla come $sum_(i=1)^n x_i$ ma nel codice esiste una funzione dedicata:

```python
x = torch.arange(3, dtype=torch.float32)
x, x.sum()

# Output
# (tensor([0., 1., 2.]), tensor(3.))
```

La funzione `sum()` va bene anche per tensors di ordine maggiore. Di base chiamare la funzione somma, _riduce_ il tensor su tutti i suoi assi producendo, in alcuni casi, uno scalare. Possiamo specificare su quali assi effettuare la somma e quell'asse ovviamente sparirá dalla dimensione del tensor:

```python
A.shape, A.sum(axis=0).shape
# Output
# (torch.Size([2, 3]), torch.Size([3]))

A.shape, A.sum(axis=1).shape
# Output
# (torch.Size([2, 3]), torch.Size([2]))
```

In alcuni casi peró potrebbe essere utile si calcolare la somma, ma anche mantenere intatto il tensor, in questi casi impostiamo:

```python
sum_A = A.sum(axis=1, keepdims=True)
sum_A, sum_A.shape

# Output
# (tensor([[ 3.],
#         [12.]]),
# torch.Size([2, 1]))
```

=== Dot Products
È una delle operazioni principali, dati due vettori $bold(x), bold(y) in RR^d$ il loro _dot product_ é dato da $bold(x)^top bold(y)$, ovvero la somma dei prodotti degli elementi nella stessa posizione: $ bold(x)^top bold(y) = sum_(i=1)^d x_i y_i $

```python
y = torch.ones(3, dtype = torch.float32)
x, y, torch.dot(x, y)

# Output
# (tensor([0., 1., 2.]), tensor([1., 1., 1.]), tensor(3.))
```

In modo perfettamente equivalente possiamo calcolare un dot product effettuando prima un prodotto elementwise e poi una somma.

I dot product sono fondamentali in questo ambito. Ad esempio dato un set di valori in un vettore $bold(x) in RR^n$ e un set di pesi $bold(w) in RR^n$; la _weighted sum_ di $bold(x)$ in base ai pesi $bold(w)$ può essere espressa come il dot product $bold(x)^top bold(w)$.

Quando i pesi sono non negati e la loro somma é uguale a $1$, il dot product rappresenta una _weighted average_. Inoltre, dopo aver normalizzato due vettori in modo da avere una lunghezza unitaria (pari a $1$) il dot product esprimerá il coseno dell'angolo compreso fra loro.

=== Matrix - Vector Products
Adesso possiamo vedere il prodotto fra una matrice $m times n space bold(A)$ e un vettore $n$-dimensionale $bold(x)$. Per prima cosa visualizziamo la matrice come vettori riga:

$ bold(A) = mat(delim: "[", a_1^top ; a_2^top; dots.v; a_m^top) $

Dove ogni $bold(a)_i^top in RR^n$ é un vettore-riga che rappresenta la $i$-esima riga di $bold(A)$.

Il prodotto matrice-vettore *$A x$* é semplicemente un vettore colonna di lunghezza $m$ dove l'elmento $i$ é il dot product $bold(a)_i^top bold(x)$:

$ bold(A x) = vec(delim: "[", a_1^top, a_2^top, dots.v, a_m^top) bold(x) = vec(delim: "[", a_1^top bold(x), a_2^top bold(x), dots.v, a_m^top bold(x)) $

Possiamo vedere quindi la moltiplicazione con una matrice $bold(A) in RR^(m times n)$ come una transformazione che porta i vettori da $RR^n$ a $RR^m$. Queste transformazioni sono molto utili infatti sono l'operazione principale usata in ogni layer dove, dato l'output del layer precedente, viene calcolato l'output attuale.

Per rappresentare questi prodotti nel codice usiamo la funzione `mv`. Per effettuarla é importante che la dimensione di $A$ sia la stessa di $x$. In Python inoltre abbiamo un operatore pensato sia per prodotti matrix-matrix che matrix-vector che é `@`:

```python
A.shape, x.shape, torch.mv(A, x), A@x

# Output
# (torch.Size([2, 3]), torch.Size([3]), tensor([ 5., 14.]), tensor([ 5., 14.]))
```

=== Matrix - Matrix Multiplication
Il concetto é molto simile a quello dei dot product. Prendiamo due matrici $bold(A) in RR^(n times k)$ e $bold(B) in RR^(k times m)$:

$ bold(A) = mat(delim: "[", a_11, a_12, dots.h, a_(1k);
a_21, a_22, dots.h, a_(2k);
dots.v, dots.v, dots.down, dots.v;
a_(n 1), a_(n 2), dots.h, a_(n k)), bold(B) = mat(delim: "[", b_11, b_12, dots.h, b_(1m);
b_21, b_22, dots.h, b_(2m);
dots.v, dots.v, dots.down, dots.v;
a_(k 1), a_(k 2), dots.h, a_(k m)) $

Sia $bold(a)_i^top in RR^k$ il vettore-riga che rappresenta la $i$-esima riga della matrice $bold(A)$ e sia $bold(b)_j in RR^k$ il vettore-colonna che rappresenta la $j$-esima colonna della matrice $bold(B)$:

$ bold(A) = vec(delim: "[", bold(a)_1^top, bold(a)_2^top, dots.v, bold(a)_n^top), bold(B)=mat(delim: "[", bold(b)_1, bold(b)_2, dots.h, bold(b)_m) $

Per formare la matrice $bold(C) in RR^(n times m)$ calcoliamo ogni elemento $c_(i j)$ come il dot product tra la $i$-esima riga di $bold(A)$ e la $j$-esima colonna di $bold(B)$:

$ bold(C) = bold(A B) = vec(delim: "[", bold(a)_1^top, bold(a)_2^top, dots.v, bold(a)_n^top) mat(delim: "[", bold(b)_1, bold(b)_2, dots.h, bold(b)_m) = mat(delim: "[",
    bold(a)_1^top bold(b)_1,bold(a)_1^top bold(b)_2, dots.h, bold(a)_1^top bold(b)_m;
    bold(a)_2^top bold(b)_1, bold(a)_2^top bold(b)_2, dots.h, bold(a)_2^top bold(b)_m;
    dots.v, dots.v, dots.down, dots.v;
    bold(a)_n^top bold(b)_1, bold(a)_n^top bold(b)_2, dots.h, bold(a)_n^top bold(b)_m
) $

Possiamo pensare ad una moltiplicazione matrix-matrix $bold(A B)$ equivalente ad effettuare $m$ prodotti matrix-vector o $m times n$ dot products per mettere insieme i risultati e ottenere una matrice $n times m$.

== Norms
Di base la _norm_ di un vettore ci dice "quanto é grande". Ne esistono diverse, ad esempio la $l_2$ misura la lunghezza Euclidea di un vettore.

La norm é una funzione $||dot||$ che mappa un vettore in uno scalare e soddisfa le 3 seguenti proprietá:
1. Dato un array $bold(x)$, se scaliamo tutti i suoi elementi per uno scalare $a in RR$ anche la norm scala: $ ||a bold(x)|| = |a| ||bold(x)|| $

2. Dati due vettori $bold(x)$ e $bold(y)$, la norm soddisfa la _triangle inequality_: $ ||bold(x) + bold(y)|| lt.eq ||bold(x)|| + ||bold(y)|| $

3. La norm di un vettore é non-negativa e si annulla soltanto se il vettore é zero: $ ||bold(x)|| gt 0 "for all" bold(x) eq.not 0 $

Esistono diverse funzioni valide come norms e diverse norms rappresentano diversi concetti di grandezza. La norm Euclidea corrisponde alla radice quadrata della somma dei quadrati di un vettore, questa é chiamata norm $l_2$ e possiamo esprimerla come: $ ||bold(x)||_2 = sqrt(sum_(i=1)^n bold(x)_i^2) $ 

Nel codice possiamo chiamare semplicemente il metodo `norm`:

```python
u = torch.tensor([3.0, -4.0])
torch.norm(u)

# Output
# tensor(5.)
```

Un'altra norm comune é la $l_1$ anche chiamata _Manhattan distance_, questa somma i valori assoluti degli elementi del vettore: $ ||bold(x)||_1 = sum_(i=1)^n |x_i| $

Questa, rispetto alla $l_2$, é meno sensibile ai valori anomali, per calcolarla combiniamo i metodi per il valore assoluto e la somma:

```python
torch.abs(u).sum()

# Output
# tensor(7.)
```

Sia la $l_2$ che la $l_1$ sono dei casi speciali della norm generica $l_p$: $ ||bold(x)||_p = ( sum_(i=1)^n |x_i|^p )^(1/p) $

Per quanto riguarda le matrici peró le cose si fanno piú complicate. Possiamo vedere le matrici sia come insiemi di singoli elementi sia come oggetti che agiscono su vettori transformandoli in altri vettori. Possiamo chiederci ad esempio quanto il prodotto matrice-vettore $bold(X v)$ puó essere lungo rispetto al vettore $bold(v)$, questo ci porta alla _spectral norm_.
Peró vediamo la _Frobenius norm_ che é piú semplice da calcolare ed é definita come la radice quadrata della somma dei quadrati degli elementi della matrice: $ ||bold(X)||_F = sqrt( sum_(i=1)^m sum_(j=1)^n x_(i j)^2 ) $

Questa si comporta come se fosse una norma $l_2$ di un vettore a forma di matrice.

Nel deep learning spesso cerchiamo di risolvere problemi di ottimizzazione, massimizzare la probabilitá assegnata ai dati osservati, massimizzare il guadagno associato ad un modello di raccomandazione, minimizzare la distanza tra la rappresentazioni delle foto della stessa persona. Queste distanze sono spesso espresse come norme.

= Calculus
== Derivatives and Differentiation
Molto semplicemente, la derivata é il tasso di variazione di una funzione rispetto alle variazioni dei suoi argomenti. Le derivate ci dicono quanto velocemente una _loss function_ cresce o decresce quando incrementiamo o decrementiamo ciascun parametro. Formalmente per delle funzione $f : RR arrow.r RR$ che mappano scalari in altri scalari, la derivata di $f$ nel punto $x$ é definita come: $ f'(x) = lim_(h arrow.r 0) (f(x+h) - f(x))/h $

Quando $f'(x)$ esiste, $f$ si dice _differenziabile_ in $x$ e quando $f'(x)$ esiste per ogni $x$ in un range di valori, come ad esempio $[a,b]$, diciamo che $f$ é differenziabile su questo set. Non tutte le funzioni sono differenziabili comprese alcune che vorremmo ottimizzare. Tuttavia dato che il calcolo della derivata é fondamentale in quasi tutti gli algoritmi di addestramento, spesso ottimizziamo un surrogato differenziabile.

Possiamo interpretare la derivata $f'(x)$ come il _tasso di variazione istantaneo_ di $f(x)$ rispetto ad $x$. Facciamo degli esempi, definiamo una funzione $u=f(x)=3x^2 - 4x$:

```python
def f(x):
    return 3 * x ** 2 - 4 * x
```

Impostando $x=1$ notiamo che $(f(x+h)-f(x))/h$ si avvicina a $2$ quando $h$ si avvicina a $0$. Non abbiamo una dimostrazione matematica rigorosa ma possiamo facilmente notare che $f'(1)=2$:

```python
for h in 10.0**np.arange(-1, -6, -1):
    print(f'h={h:.5f}, numerical limit={(f(1+h)-f(1))/h:.5f}')

# Output
# h=0.10000, numerical limit=2.30000
# h=0.01000, numerical limit=2.03000
# h=0.00100, numerical limit=2.00300
# h=0.00010, numerical limit=2.00030
# h=0.00001, numerical limit=2.00003
```

Esistono tantissime notazioni per indicare la derivata di una funzione. Data $y=f(x)$ tutte le seguenti espressioni sono equivalenti: $ f'(x)=y'= (d y)/(d x) = (d f)/(d x) = d/(d x) f(x) = D f (x)= D_x f(x) $ 

I simboli $d/(d x)$ e $D$ sono _differentiation operators_. Vediamo inoltre alcune derivate di funzioni note:
$ 
d/(d x) C &= 0 "per ogni costante" C \
d/(d x) x^n &= n x^(n-1) "per" n eq.not 0 \
d/(d x) e^x &= e^x \
d/(d x) ln x &= x^(-1)
$ 

Funzioni composte da funzioni differenziabili sono anch'esse differenziabili. La seguente regola é utile quando lavoriamo con composizioni di qualsiasi funzioni differenziabili $f$ e $g$ e una costante $C$.

$
  
$