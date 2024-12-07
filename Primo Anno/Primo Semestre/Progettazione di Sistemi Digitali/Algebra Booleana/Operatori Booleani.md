Lavorano con l'insieme di supporto {0,1}

- **Not** $\overline{x}$
  ![[Pasted image 20231021171438.png]]
- **And** $x * y$
  ![[Pasted image 20231021171540.png]]
- **Or** $x + y$
 ![[Pasted image 20231021171625.png]]

Esempio di circuito:
![[Pasted image 20231021171845.png]]
Quando usciamo da una porta logica il nostro valore deve stabilizzarsi e richiederà quale millisecondo 
![[Pasted image 20231021172128.png]]

E' quindi importante costruire un circuito con meno porte logiche possibili.


## XOR (Or Esclusivo)
Tavola di verità $x\oplus y$
![[Pasted image 20231021191739.png|250]]
Lo XOR restituisce quindi 1 se e solo se è posta ad 1 una sola variabile, quindi:
$$x\oplus y = \overline{x}y+x\overline{y}$$
Quanto vale la sua negazione?
$$\overline{x\oplus y}=(x+\overline{y})(\overline{x}+y)$$
Prendiamo come esempio l'espressione $s=\overline{a}\overline{b}c+\overline{a}b\overline{c}+a\overline{b}\overline{c}+abc$
Utilizzando proprietà e lo XOR:
$$s=c(\overline{a}\overline{b}+ab)+\overline{c}(\overline{a}b+a\overline{b{}})$$
$$s=c\overline{(a\oplus b)}+\overline{c}(a\oplus b)$$
$$s=c\oplus(a\oplus b)$$



## Operatori Universali NAND e NOR
![[Pasted image 20231022121324.png]]
Come vediamo indicano la **negazione delle porte AND e OR**, le loro tavole di verità saranno quindi invertite rispetto alle loro.
Con ognuna di queste porte siamo in grado di **rappresentare tutti i 3 operatori fondamentali** AND, NOT e OR
Vediamo come fare per ognuna delle due:
![[Pasted image 20231022122113.png|500]]
![[Pasted image 20231022122703.png]]

Vediamo invece come utilizzare le porte NAND per rappresentare espressioni SoP, quindi AND to OR
![[Pasted image 20231022123313.png]]

***Nelle forme SOP utilizzo porte NAND
Nelle forme POS utilizzo porte NOR***
