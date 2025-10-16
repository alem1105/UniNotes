#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/xarrow:0.3.1": xarrow

#let nonumeq = math.equation.with(block: true, numbering: none)
#let dm(x) = box[#nonumeq[#x]]
#let dfrac(x,y) = math.frac(dm(x),dm(y))

= Linguaggio Fun
Questo linguaggio introduce anche delle funzioni, utilizzerà quindi: $ M,N ::= 5|x|M+N|"let" x=M "in" N|f n arrow.double.r M| M N $

Da notare che grazie alle funzioni possiamo escludere dal linguaggio alcuni simboli che possiamo rappresentare grazie alle funzioni, rimaniamo soltanto con: $ M,N ::= x|f n arrow.double.r M| M N $

Si dice che rendono il linguaggio *Turing Complete* (da approfondire prossima lezione, credo (?))

Prendiamo ad esempio la funzione successore $"fn" x arrow.double.r x+1$ che dato un intero in input restituisce il suo successore. Quando non diamo un nome ad una funzione, per usarla utilizziamo la notazione: $ ("fn" x arrow.double.r x+1)5 $ Ovvero scriviamo la funzione e a destra cosa gli stiamo passando in input.