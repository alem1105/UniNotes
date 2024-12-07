Per rappresentare un numero binario in *complemento a 2*:
1) Aggiungiamo il **bit del segno** nella posizione più significativa
2) Complementiamo tutti i bit
3) Sommiamo 1
4) *Ricordiamoci sempre che se un numero è positivo dobbiamo soltanto aggiungere lo 0 come bit del segno*

$$(+35)_{10}=(100011)_2 \xrightarrow{\text{C.A.2}}0100011$$
$$(+35)_{10}=(100011)_2 \xrightarrow{\text{C.A.2}}1011101$$

In *complemento a 2* possiamo rappresentare i valori da $-2^N$ fino a $2^N-1$, in questa rappresentazione non abbiamo infatti la doppia rappresentazione dello 0.
Prendendo come esempio una rappresentazione con 7 bit possiamo rappresentare i numeri da -64 a +63
![[Pasted image 20231021130104.png]]

## [[Operazioni in Complemento a 2]]
