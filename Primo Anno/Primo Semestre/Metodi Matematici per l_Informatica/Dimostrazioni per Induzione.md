In una dimostrazione per induzione dobbiamo usare come ipotesi il **caso base** $P(n)$ della proprietà che vogliamo dimostrare.
Se questa è verificata allora deve verificarsi anche per $P(n+1)$, questo passaggio prende il nome di **passo induttivo**.

Quindi:
- ***Caso Base $P(n)$:*** dimostrare che la proprietà vale per il più piccolo valore possibile
- ***Passo Induttivo $P(n+1)$:*** se $P(n)$ allora $P(n+1)$ se per dimostrare il passo induttivo utilizzo il caso base aggiungendo qualcosa, ho completate la dimostrazione.

*Esempio 1*
Dimostrare che per $n$ punti passano $\frac{n(n+1)}{2}$ segmenti
- $P(n)$ caso base: supponiamo che la proprietà valga.
- $P(n+1)$ passo induttivo: per ipotesi induttiva la proprietà vale per il caso base, quindi per $n+1$ passeranno tutti i segmenti che passano per $n$ + tutti i nuovi segmenti che collegano il nuovo punto ai precedenti ovvero $n$ stesso.
  La nostra formula diventa quindi $\frac{n(n+1)}{2}+n$, abbiamo ottenuto il caso baso sommato a qualcosa.