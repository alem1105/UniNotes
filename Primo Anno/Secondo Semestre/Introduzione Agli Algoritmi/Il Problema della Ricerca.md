Generalizziamo i problemi di ricerca in questo modo:
- **Input**: Una list di $n$ numeri ed un valore $v$ da cercare
- **output**: un indice $i$ tale che $lista[i]=v$ oppure $None$ se il valore $v$ non è presente nella lista.

# La Ricerca Sequenziale
L'algoritmo più semplice si basa sul controllare uno alla volta gli elementi del vettore e se confrontandolo con $v$ vediamo che sono uguali restituiamo l'indice $i$ altrimenti se non troviamo nessuna corrispondenza restituiamo $None$.
In questo modo otteniamo una complessità di $O(n)$ infatti nel:
- **Caso peggiore** ovvero quando $v$ non è nella lista abbiamo $O(n)$
- **Caso migliore** ovvero quando $v$ è il primo elemento abbiamo $\theta(1)$

In questo caso non abbiamo trovato una stima del costo per tutti i casi per questo utilizziamo la notazione $O(n)$, per indicare che ci sono input che rispettano questo dato ma anche input che scendono molto sotto.

Per trovare il caso medio in questo tipo di algoritmi faccio l'ipotesi che l'elemento $v$ possa apparire con la stessa probabilità in ogni posizione del vettore allora il numero medio di iterazioni del ciclo è dato da 

$$
\sum_{i=1}^ni*\frac{1}{n}=\frac{1}{n}*\frac{n(n+1)}{2}=\frac{n+1}{2}
$$

Quindi il costo computazionale nel caso medio è di $\theta(n)$

# Ricerca Binaria
Nel caso in cui gli elementi nel vettore sono ordinati possiamo implementare un algoritmo molto più efficiente, possiamo controllare a metà e se il valore è minore procediamo a controllare nella parte a destra mentre se il valore è maggiore controlliamo nella parte a sinistra, o se siamo stati fortunati abbiamo trovato il valore desiderato.

In questo modo ad ogni iterazione dimezziamo il numero di elementi da controllare

- Dopo $i$ iterazioni il numero di elementi su cui ricercare sarà $\frac{n}{2^i}$
- Quindi $2^i=n$ -> $i=\log n$

Il numero di iterazioni quindi cresce come $log n$

Possiamo distinguere però i due casi:
- **Caso peggiore**: $\theta(log n)$
- **Caso migliore**: $\theta(1)$

Siccome sono diversi vediamo come calcolare il caso medio.
Quindi con una iterazione raggiungiamo soltanto $n/2$, con due iterazioni controlliamo $n/4$ e $3n/4$ con tre iterazioni $n/8, 3n/8, 5n/8, 7n/8$ 
Quindi la probabilità di trovare un elemento sono nelle posizione toccate dalle iterazioni sono $\frac{2^{i-1}}{n}$ e quindi il numero medio di iterazioni è 

![[Pasted image 20240308172904.png]]


