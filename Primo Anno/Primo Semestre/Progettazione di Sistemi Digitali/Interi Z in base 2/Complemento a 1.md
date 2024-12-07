Per passare in rappresentazione *Complemento a 1* dobbiamo:
1) Aggiungere il **bit del segno** nella posizione più significativa, 1 se numero negativo 0 se positivo
2) Complementare tutti i bit, quindi se abbiamo un 1 scriveremo uno 0 e se abbiamo uno 0 scriveremo un 1
3) Ricordiamoci che **se un numero è positivo non** dobbiamo **fare nessuna operazione** ma soltanto aggiungere uno 0 per il bit del segno.
$$(+11)_{10}=(1011)_2 \xrightarrow{\text{C.A.1}}01011$$
$$(-11)_{10}=(1011)_2 \xrightarrow{\text{C.A.1}}10100$$
In complemento ad 1 i bit non hanno il classico valore delle potenze di 2, infatti il bit più significativo vale $-2^N +1$. Proprio per questo con ad esempio 5 bit possiamo rappresentare i valori da -15 a +15 con una doppia rappresentazione dello zero, una con tutti 1 ed una con tutti 0.
![[Pasted image 20231021120818.png]]