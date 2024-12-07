E' un circuito combinatorio che seleziona informazioni binarie da 1 degli input e la manda sulla linea in uscita

![[Pasted image 20240121224845.png|500]]

*Vantaggi:*
- Riduce il numero di cavi
- Riduce complessità del circuito e costo
- Molti circuiti utilizzano il MUX

Nel dettaglio per scegliere quale input mandare in output utilizza delle linee di scelta, infatti abbiamo diversi tipi di MUX ma in generale un MUX da $2^n$ ingressi ha $2$ linee di scelta e sempre un solo output.
Si usa la notazione _Input:1_ quindi un MUX da 4 input sarà _4:1_

![[Pasted image 20240121225408.png]]

La voce _I_ indica quindi quale input entra nel MUX e va nell'uscita _Y_


> [!INFO] In realtà il MUX e' un insieme di porte AND che finiscono in una porta OR
> ![[Pasted image 20240121230736.png]]
