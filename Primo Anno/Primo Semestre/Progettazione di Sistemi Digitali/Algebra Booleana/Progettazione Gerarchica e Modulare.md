Per progettare un addizionatore abbiamo bisogno di:
- _Half - Adder:_ Circuito che somma 2 bit
- _Full - Adder:_ Circuito che somma 3 bit

Un **Half-Adder** prende in ingresso 2 bit e restituisce una somma e il riporto:

> [!NOTE] **HALF - ADDER**
>![[Pasted image 20240121182528.png]]
>Dove **S** indica l'unita della somma e **C** il riporto
>

Un **Full-Adder** prende in ingresso 3 bit, 2 sono gli addendi mentre il terzo e il riporto generato precedentemente, i Full-Adder infatti vanno utilizzati in sequenza.

> [!NOTE] **FULL - ADDER**
>![[Pasted image 20240121184722.png]]
>Dove **i** indica la posizione attuale

> [!warning] **Possiamo realizzare un FULL ADDER anche con 2 HALF ADDER**
>![[Pasted image 20240121190836.png|500]]

# Ripple Carry Adder
Questo è la tipologia di addizionatore più semplici ma anche più lenta che possiamo realizzare, _l'addizionatore a propagazione di riporto_.

![[Pasted image 20240121201055.png]]

L'ultimo riporto non è altro che il **bit di  [[Operazioni in base 2#^009da1|overflow]].

# Operazioni in CA2
Possiamo anche eseguire operazioni con numeri negativi, l'importante è ricondurre tutto ad una somma, ad esempio:
$A-B = A+(-B) \rightarrow A+(\overline{B}+1)$

Possiamo utilizzare un _RPA_ ma sostituiamo il primo _HA_ con un _FA_ e aggiungiamo un linea di selezione _SEL_ che useremo per scegliere se sommare _B_ o _B negato_.

![[Pasted image 20240121201805.png]]

Questa _"tecnica"_ di utilizzare le porte _AND_ con delle _linee di selezione_ prende il nome di **GATING**.
Questo è l'addizionatore più lento che possiamo costruire dato che deve aspettare la propagazione del riporto

# [[Decodificatore e Codificatore]]
# [[PLA - Programmable Logic Array]]
# [[Multiplexer - MUX]]
# [[ROM - Read Only Memory]]
# [[Demultiplexer - DEMUX]]
# [[Transcodificatore]]
# [[Comparatore]]
# [[ALU]]
