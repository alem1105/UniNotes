Sappiamo che i Flip Flop sono delle celle di memoria da 1 bit, per incrementare la capacità di memoria dobbiamo utilizzare dei gruppi di Flip Flop, questi prendono il nome di _Registri_.
Un registro da, ad esempio, 4 bit sarà formato quindi da 4 Flip Flop.
Vediamo un esempio con 4 FF D:

![[Pasted image 20240118180938.png]]

Il Clock è l'ingresso a sinistra ed è collegato a tutti i registri contemporaneamente.
Siccome abbiamo degli ingressi per ogni FF, questo significa che ad ogni fronte positivo del clock il nostro registro cambia valore e perdiamo quello precedente.
Per non far cambiare continuamente valore al registro abbiamo bisogno di una linea di controllo aggiuntiva chiamata _load_ che fa cambiare il registro soltanto quando è attiva.
Esistono due tipi di _load_:
1. **Sincrono**: Il registro cambia valore soltanto quando sono attivi sia _clock_ che _load_
2. **Asincrono**: Il registro cambia valore ogni volta che il _load_ è attivo anche con il clock spento
![[Pasted image 20240118181551.png]]

# Inserimento e Trasferimento dei Dati

I dati all'interno di un registro possono essere inseriti o estratti in due modi:
- _Seriale_: 1 bit alla volta
- _Parallelo_: Tutti i bit in una sola volta

![[Pasted image 20240119124125.png]]
# Classificazione dei Registri

Possiamo classificare i registri in base a più parametri:
- **Input / Output**
	- _SISO (Serial Input Serial Output)_
	- _SIPO (Serial Input Parallel Output)_
	- _PISO (Parallel Input Serial Output)_
	- _PIPO (Parallel Input Parallel Output)_
- **Utilizzo**
	- _Shif Register_: Vogliamo far scorrere i bit da un FF ad un altro
	- _Storage Register_: Ci interessa soltanto memorizzare i valori


# Shif Register (SISO)
Questi si dividono in altre due categorie:
- _Right Shift:_ Scorrimento a destra
- _Left Shift:_ Scorrimento a sinistra

![[Pasted image 20240119125540.png]]

In questo tipo di registri se vogliamo caricare un dato, ad esempio _1111_, dobbiamo individuare il _LSB (less significant bit)_ e _MSB (most significant bit)_ e inserire in ordine dall'LSB al MSB tutti i bit, con questo esempio otterremo degli stati come questi:

![[Pasted image 20240119130311.png|500]]

Abbiamo bisogno quindi di 4 fronti positivi di clock per memorizzare il dato, in un caso reale però per trasmettere appunto 4 bit abbiamo usato un solo cavo dato che l'output è seriale, se avessimo avuto un output parallelo avremmo avuto bisogno di 4 cavi, aumentando notevolmente il costo.
Per lunghe distanze conviene quindi utilizzare un approccio _SISO_.

# Shif Register (SIPO & PIPO)

Un problema dell'output seriale è che se per esempio abbiamo avuto bisogno di 4 cicli di clock per memorizzare il dato avremo bisogno di altrettanti cicli per estrarlo, dato che abbiamo una sola uscita.
Quindi con un registro _SIPO_ otteniamo una situazione simile a questa:

![[Pasted image 20240120183550.png]]

In un registro _PIPO_ invece avremo una situazione come questa:

![[Pasted image 20240120183828.png]]

Quindi in un solo fronte d'onta avremo registrato il nostro dato, è importante quindi inviare i dati prima dell'arrivo del fronte d'onda.
Questo prende il nome anche di _Buff Register_ proprio per questa azione di _Buffer_ ovvero se diamo in input 1011 nel nostro registro finirà esattamente 1011.

# Shift Register (PISO)

In questo tipo di registri abbiamo bisogno di caricare in modo parallelo i nostri input.
Questi possono funzionare in due modi:
- _Load Mode:_ Quando abbiamo bisogno di caricare i dati
- _Shift Mode:_ Quando dobbiamo mandare in output i dati
Vediamo come costruire il circuito e poi analizziamolo:

![[Pasted image 20240120190455.png]]

Quindi abbiamo 2 casi, _Shift = 1 OPPURE Load = 1_

> [!note] _LOAD = 1_
>Le porte _AND 1 - 3 - 5_ valgono 0 dato che entra il _load = 0_ mentre le porte _AND 2 - 4 - 6_ valgono quando gli input _B_ quindi nei registri entra il valore dell'input corrispondente


> [!NOTE] _SHIFT = 1_
>Le porte _AND 2 - 4 - 6_ valgono 0 mentre le porte _AND 1 - 3 - 5_ valgono quanto l'uscita dell'FF precedente, questo significa che ogni FF prenderà il valore del precedente e il valore dell'ultimo FF verrà mandato in output

# Bidirectional Shift Register

Prima di analizzare il circuito vediamo cosa succede quando "shiftiamo" dei bit a destra o a sinistra:

> [!warning] Attenzione
>Se prendiamo la sequenza _11_ in un totale di 3 bit in realtà stiamo considerando _011_ che in decimale vale 3
>**Cosa succede se la spostiamo a sinistra?**
>_011 -> 110_ che non vale più 3 ma bensì 6, abbiamo **moltiplicato il valore per 2**
>**E se shiftiamo la sequenza verso destra?**
>_110 -> 011_ che da 6 prende il valore 3, abbiamo quindi **diviso per 2**
>

Nei registri bidirezionali possiamo scegliere se shiftare i valori a destra o a sinistra, analizziamo il circuito:

![[Pasted image 20240121161430.png]]

Vediamo il caso in cui *M = 1 e !M = 0*
> [!NOTE] **M = 1**
>Quando M = 1 siamo nell'operazione di shift a destra, vediamo perché.
>In questo caso le porte _2 - 4 - 6 - 8_ valgono 0 dato che hanno fra gli input _M negato che vale 0_, mentre le porte _1 - 3 - 5 - 7_ hanno come input 1 e l'output del Flip Flop alla loro sinistra, quindi prenderanno come input lo stato del Flip Flop.
>Ovviamente il Flip Flop 3 non ha altri FF alla sua sinistra quindi prende un input seriale esterno


> [!NOTE] **M = 0**
> In questo caso abbiamo che _M negato = 1_ quindi disabilitiamo le porte and _1 - 3 - 5 - 7_ e abilitiamo le porte _2 - 4 - 6 - 8_ che avranno come input lo stato del Flip Flop alla loro destra tranne per il Flip Flop 0 che prenderà un input seriale esterno.
> Otteniamo quindi l'operazione di shift a sinistra.

***E' importante quindi ricordare il suo utilizzo per effettuare moltiplicazioni e divisioni per 2***

# Universal Shift Register
Per ottenere un registro universale dobbiamo rispettare questi 2 requisiti:
1. **Shift Bidirezionale**
2. **Caricamento Parallelo dei dati**

![[Pasted image 20240121170533.png]]

Non c'è molto di nuovo da spiegare dato che il circuito universale riesce a fare tutte le operazioni viste precedentemente, infatti può:
- **Avere Input seriale o parallelo**
- **Output seriale o parallelo**
- **Shift a destra o sinistra**
