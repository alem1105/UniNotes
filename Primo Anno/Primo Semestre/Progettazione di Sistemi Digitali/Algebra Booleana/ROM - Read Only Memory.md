Si realizza con un decodificatore e un codificatore in cascata
- Le linee in uscita dal decodificatore si chiamano **Connessioni** e rappresentano i **mintermini** della nostra espressione
- I collegamenti verticali (*or*) tra le connessioni si chiamano **Collegamenti** (_Link_)

**Esempio:**
$F(A,B,C) = sum[m(1,2,4,5)]$ ovvero l'OR dei mintermini 1 2 4 5

![[Pasted image 20240122115007.png]]


> [!info] Nota
> In questo caso abbiamo 9 connessioni (uscite del decoder + OR) e 4 collegamenti (porte OR)

## Andiamo a semplificare la funzione usando soltanto le variabili AB e scegliendo l'entrata in base a C

![[Pasted image 20240122120102.png]]

Possiamo adesso realizzare il circuito collegando le uscite del decodificatore ad un MUX 2:1 che ha come linea di scelta C.

![[Pasted image 20240122120849.png]]

Quindi:
- Se abbiamo in ingresso 4 input, dal decoder avremo in uscita 16 output + la funzione avremo 17 connessioni
- Utilizzando un multiplexer e un decoder passiamo a 3 ingressi nel decoder con 8 uscite + 2 per il multiplexer, otteniamo quindi 10 connessioni, **7 in meno**
- Potremmo anche passare ad un multiplexer con 4 entrate e 2 linee di controllo e arrivare a **8 connessioni**
- ***Attenzione però il numero di link rimane sempre lo stesso***

**Pattern di riduzione connessioni:**
$i$ = linee del decoder, $j$ = linee di selezione del mux
**Connessioni**: $2^i + 2^j$
**Link**= $2^i * 2^j$
