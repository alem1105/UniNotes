L'alfabeto che utilizzeremo contiene dei simboli per rappresentare:
- *Variabili:* $a,b,c,a_1,a_k,...$
- *Simboli Funzionali:* hanno $n$ posti e si indicano con il termine arita', si indicano con $f(), g(), h()$ e all'interno delle parentesi inseriamo gli $n$ parametri
- *Simboli Predicativi:* Hanno 1 o 2 posti si indicano di solito con $P(), Q()$
- *Connettivi:* Servono a collegare fra loro formule $\neg,\wedge,\vee,\rightarrow,\leftrightarrow$
- *Quantificatori:* Servono a legare fra loro variabili $\vee,\exists$  
- Utilizziamo anche simboli come () e ,

### Termini
Variabili e costanti sono termini
Se $t_1,...,t_n$ sono termini allora $f(t_1,...,t_n)$ è un termine

### Formule
(Le formule possono assumere vero o falso, i termini no)

Se $P$ è un simbolo predicativo a $n$ posti e $t_1,...,t_n$ sono termini allora $P(t_1,...,t_n)$ è una formula

Se $A,B$ sono formule allora $\neg A, A\wedge B, A\vee B, A\rightarrow B, A\leftrightarrow B$ sono formule

Se $A$ è una formula e $x$ una variabile allora $\forall xA,\exists xA$ sono formule

*Per ogni formula dobbiamo considerare un dominio non vuoto, chiamato anche universo*

**Per modello di una formula indichiamo una sua interpretazione che la soddisfa**
L'interpretazione di una formula è la scelta delle varie variabili e predicati ecc..

### Esempi 

Scrivere "< ha un elemento minimo"

$\exists x(\forall y(x<y)\vee(x=y))$
- - - 
"< non ha un elemento massimo"

$\forall y[\forall x\neg(y<x)\vee(x=y)]$
- - - 
"< è denso, ovvero ogni coppia di elementi nella relazione < possiede un elemento intermedio"

$\forall x\forall y[(x<y)\wedge(x\neq y)]\rightarrow[\exists z(x<z)\wedge(z<y)]$

**IMPORTANTE**
La negazione di un esistenziale diventa un universale con proprietà negata:
$\neg\exists xP(x)$ diventa $\forall x\neg P(x)$

