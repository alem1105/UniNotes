#import "@preview/ilm:2.1.1": *

#set text(lang: "it")

#show: ilm.with(
  title: [Appunti Tirocinio],
  authors: "Alessio Marini",
  abstract: [Appunti presi per il mio Tirocinio interno presso il Vision-Lab.],
  listing-index: (enabled: false),
  figure-index: (enabled: false),
  table-index: (enabled: false),
  table-of-contents: []
)

#set math.equation(numbering: none)

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

$ bold(A) = mat(delim: "[", a_11, a_12, dots.h, a_1n;
a_21, a_22, dots.h, a_2n;
dots.v, dots.v, dots.down, dots.v;
a_(m 1), a_(m 2), dots.h, a_(m n)) $
