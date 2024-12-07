L'elemento base per la memorizzazione è chiamato **LATCH**
![[Pasted image 20231108172311.png]]

Con *reset* il nostro output *Q* sarà uguale a 0 mentre con *set* sarà uguale a 1, vediamo perché con la tavola di verità della porta NOR:
![[Pasted image 20231108173328.png]]

***LA COFIGURAZIONE CON R = 1 e S = 1 NON E' AMMESSA***

## Clock
![[Pasted image 20231108174407.png]]

I segnali di clock ci serviranno per far funzionare i circuiti *FLIP FLOP* che vedremo successivamente, alcuni sono sensibili alla salita ovvero quando il clock vale 1 mentre altri alla discesa ovvero quando vale 0.

Questo perché per alcuni input avremo li stessi output e vogliamo usare questi output in tempi diversi.

***Duty Cycle: Per quanto tempo il segnale è 1 rispetto al tempo totale***

## Differenze tra Latch e FLIP FLOP

In un *Latch* i nostri input potrebbero cambiare accidentalmente quindi abbiamo bisogno di un input di controllo per memorizzare gli output fino a quando ne abbiamo bisogno, vediamo come aggiungere un controllo:
![[Pasted image 20231108175551.png]]
Quindi quando il nostro segnale En è 1 il nostro circuito funzione come Latch.
Se come segnale di controllo utilizziamo un clock per rendere il nostro circuito sensibile alla salita o alla discesa avremo un **Flip Flop**.
***Il Latch è sensibile ai livelli (0, 1) mentre il Flip Flop è sensibile ai cambiamenti del clock***

## SR Flip Flop
![[Pasted image 20231108181834.png]]

Quindi quando il CLOCK è a 0 il nostro circuito non funziona e utilizza sempre i vecchi output come input

## D Flip Flop (Data Flip Flop)
Notiamo che nella tabella dell'SR Flip Flop gli input S e R sono sempre uno il complemento dell'altro quando non siamo in stato di memorizzazione, possiamo quindi utilizzare un solo input:
![[Pasted image 20231108183422.png]]
Questa la sua tabella di verità:
![[Pasted image 20231108183631.png]]

## JK Flip Flop
Ci sono alcuni lati negativi che ci spingono a passare ai JK Flip Flop.
In SR Flip Flop abbiamo 4 combinazioni ma una (S = 1 e R = 1) non possiamo utilizzarla, con JK Flip Flop diventa utilizzabile.
![[Pasted image 20231108184642.png]]
![[Pasted image 20231108184741.png]]

Quindi la configurazione 1 1 complementa entrambi gli output

## Master - Slave Flip Flop
Si ottiene con due Flip Flop in serie collegati allo stesso clock ma complementato nel secondo:
![[Pasted image 20231108210056.png]]
Quindi quando il master è operativo non lo è lo slave
![[Pasted image 20231108210616.png]]
Lo Slave prenderà i valori del master in ritardo dandoci il tempo di leggerli

Quando il clock è 1 e anche i nostri input J e K l'output sarà $\overline{Qn}$

Il nostro output non cambia continuamente in un periodo della frequenza del clock ma cambia una sola volta (**Toggling**)

## T Flip Flop
Quando abbiamo 1 e 1 in input nei JK Flip Flop si verifica il Toggling ovvero quando controlliamo il cambio di output tra 0 1 o 1 0.
Se vogliamo solo l'azione di toggling utilizziamo il T Flip Flop dove complementiamo il clock:
![[Pasted image 20231108211845.png]]