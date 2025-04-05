# Introduzione
Per logica intendiamo un linguaggio formale usato per rappresentare informazioni e derivare conseguenze.

Ogni logica è definita da una **sintassi e una semantica**

- Sintassi - È l'insieme delle sequenze finite di simboli ammesse dal linguaggio ovvero le **formule**, ogni simbolo usato nelle formule appartiene ad un insieme cioè l'**alfabeto**.
- Semantica - Definisce il significato di ogni formula della logica, ovvero la sua verità in diversi **mondi** possibili.

_Esempio - Il linguaggio dell'aritmetica_

Sintassi:
- $x+2\geq y$ è una formula ma $x 2+y\geq$ non lo è

Semantica:
- $x+2\geq y$ è vero se il valore di $x+2$ non è minore del valore di $y$
- $x+2\geq y$ è vero in un mondo dove $x=7$ e $y=1$
- $x+2\geq y$ è falso in un mondo dove $x=0$ e $y=6$

Dato mondo $m$ e la formula $\rho:m\models \rho$ se $\rho$ è vera nel mondo $m$ si dice che $m$ è modello di $\rho$

## Sintassi
La sintassi definisce la struttura delle formule, per definire la sintassi dobbiamo stabilire:
- Quali simboli appartengono all'alfabeto della logica
- Quali sequenze finite di simboli compongono il linguaggio (formule)

> La sintassi definisce soltanto quali sono le formule ma non il loro significato.
## Semantica
Definisci il significato delle formule ovvero la sua verità nei diversi mondi. In ogni mondo possibile una formula può essere vera o falsa.

Di solito si dà significato alle formule più semplici, quelle atomiche ovvero che non possono essere ridotte ulteriormente e poi usando le regole della logica si stabilisce un significato alla altre formule.

È quindi simile alla valutazione di un'espressione algebrica.