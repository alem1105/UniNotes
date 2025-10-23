#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/xarrow:0.3.1": xarrow

#let nonumeq = math.equation.with(block: true, numbering: none)
#let dm(x) = box[#nonumeq[#x]]
#let dfrac(x,y) = math.frac(dm(x),dm(y))

= Linguaggio Fun
Questo linguaggio introduce anche delle funzioni, utilizzerà quindi: $ M,N ::= 5|x|M+N|"let" x=M "in" N|f n arrow.double.r M| M N $

Definiamo ogni termine:
- $k in {0,1,...}$ è una costante
- $x in "Var" = {x,y,z,...}$ è una variabile
- $+:"Fun" times "Fun"$ è la somma fra due espressioni
- $"let":"Var" times "Fun" times "Fun" arrow.r "Fun"$ assegna alla variabile $x$ l'espressione $M$ all'interno della valutazione $N$, all'interno di $N$ abbiamo che $x$ prende il nome di *variabile locale*.
- $"fn":"Var" times "Fun" arrow.r "Fun"$ restituisce una funzione avente un parametro il quale influenza l'espressione valutata dalla funzione.
- Data l'espressione $"fn" x arrow.double.r M$ definiamo la coppia $(x,M) in "Var" times "Fun"$ come *chiusura* di tale espressione.
- $dot: "Fun" times "Fun" arrow.r "Fun"$ la quale applica il termine sinistro al termine destro, è necessario che il termine sinistro sia una funzione.
- $"Val" = {0,1,...} union {"Var" times "Fun"}$ è l'insieme dei valori in cui un'espressione può essere valutata, ossia costanti e chiusure.

Qualche esempio:
- $("fn" x arrow.double.r x + 1) 7$ viene valutata $8$ dato che la funzione a sinistra viene applicata al termine destro.
- L'epsressione $("fn" x arrow.double.r x space 3) space 7$ non è valutabile dato che passiamo 7 come parametro $x$ della funzione ma poi non possiamo applicare 7 a 3.
- L'espressione $("fn" x arrow.double.r x space 3)("fn" x arrow.double.r x+1)$ viene valutata come 4, passiamo la funzione a destra come parametro $x$ della funzione a sinistra e poi applichiamo questa funzione a 3 ottenendo 4.

#showybox(
  frame: (
      border-color: green.lighten(60%),
      title-color: green.lighten(60%),
      body-color: green.lighten(95%)
  ),
  title-style: (
      color: black,
      weight: "regular",
      align: center,
      boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Osservazione*],
  [
    Nel caso in cui abbiamo un'espressione con doppio operatore di applicazione, quindi del tipo $M N L$ questa verrà valutata come $(M N)L$.

    Ad esempio, le seguenti espressioni sono equivalenti

    $ ("fn" x arrow.double.r x space 3)("fn" x arrow.double.r x+1)7 $

    $ [("fn" x arrow.double.r x space 3)("fn" x arrow.double.r x+1)]7 $
  ]
)

Dato che il linguaggio Fun è un'estensione di Exp, eredita le regole semantiche di Exp.

Vediamo le regole del linguaggio Fun *eager dinamico*:
- L'insieme _Env_ viene ridefinito come:

$ "Env" = {f | f : "Var" xarrow("fin") "Val"} $

- Dato $E in "Env"$, per le funzioni si ha che:

$ E tack.r "fn" x arrow.double.r M arrow.r.squiggly (x, M) $

- Dato $E in "Env"$, per le applicazioni si ha che:

$ frac(E tack.r M arrow.r.squiggly (x, L) quad E tack.r N arrow.r.squiggly v' quad E{(x, v')} tack.r L arrow.r.squiggly v, E tack.r M N arrow.r.squiggly v) $

Se utilizziamo un approccio *eager* con *scoping statico*:

- L'ambiente _Env_ viene ridefinito:

$ "Env" = {f | f : "Var" xarrow("fin") "Val" times "Env"} $

- Dato $E in "Env"$, per le funzioni si ha:

$ E tack.r "fn" x arrow.double.r M arrow.r.squiggly (x, M, E) $

- Dato $e in "Env"$, per le applicazioni si ha:

$ frac(E tack.r M arrow.squiggly.r (x, L, E') quad E tack.r N arrow.r.squiggly v' quad E'{(x, v')} tack.r L arrow.squiggly.r v, E tack.r M N arrow.r.squiggly v) $

#showybox(
  frame: (
      border-color: green.lighten(60%),
      title-color: green.lighten(60%),
      body-color: green.lighten(95%)
  ),
  title-style: (
      color: black,
      weight: "regular",
      align: center,
      boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Osservazione*],
  [
    Come detto nel linguaggio _Exp_, abbiamo usato il linguaggio _Fun_ per vedere un comportamento diverso con approccio eager ma scoping diverso, infatti:
    
    $ "Fun eager dinamico" equiv.not "Fun eager statico" $

    Per dimostrarlo basta prendere un'espressione che resituisce un risultato diverso con i due scoping, ad esempio:
    
    $ "let" x = 7 "in" (("fn" y arrow.double.r "let" x = 3 "in" y x)("fn" z arrow.double.r x)) $
  ]
)

Vediamo invece le regole operazionali nel caso del linguaggio _Fun_ *lazy dinamico*:

- L'insieme _Env_ viene ridefinito:

$ "Env" = {f | f : "Var" xarrow("fin") "Fun"} $

- Dato $E in "Env"$, per le funzioni si ha:

$ E tack.r "fn" x arrow.double.r M arrow.squiggly.r (x, M) $

- Dato $E in "Env"$, per le applicazioni si ha che:

$ frac(E tack.r M arrow.squiggly.r (x, L) quad E{(x, N)} tack.r L arrow.r.squiggly v, E tack.r M N arrow.r.squiggly v) $

Mentre le regole operazionali nel caso del linguaggio _Fun_ *lazy statico* diventano:

- L'insieme _Env_ viene ridefinito:

$ "Env" = {f | f : "Var" xarrow("fin") "Fun" times "Env"} $

- Dato $E in "Env"$, per le funzioni si ha:

$ E tack.r "fn" x arrow.double.r M arrow.squiggly.r (x, (M, E)) $

- Dato $E in "Env"$, per le applicazioni si ha che:

$ frac(E tack.r M arrow.squiggly.r (x, (L, E')) quad E'{(x,( N, E))} tack.r L arrow.r.squiggly v, E tack.r M N arrow.r.squiggly v) $

#showybox(
  frame: (
      border-color: green.lighten(60%),
      title-color: green.lighten(60%),
      body-color: green.lighten(95%)
  ),
  title-style: (
      color: black,
      weight: "regular",
      align: center,
      boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Osservazione*],
  [
    Come per il linguaggio _Exp_ abbiamo che:

    $ "Fun lazy dinamico" equiv.not "Fun lazy statico" $
  ]
)

#showybox(
  frame: (
      border-color: red.lighten(60%),
      title-color: red.lighten(60%),
      body-color: red.lighten(95%)
  ),
  title-style: (
      color: black,
      weight: "regular",
      align: center,
      boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Espressione $omega$*],
  [
    Nel linguaggio _Fun_ definiamo come *espressione omega* indicata con $omega$ l'espressione: 

    $ omega := ("fn" x arrow.double.r x x)("fn" x arrow.double.r x x) $ 

    Questa espressione è *invalutabile* per qualsiasi semantica.
  ]
)

Nel linguaggio _Fun_ *non esistono due semantiche equivalenti*.