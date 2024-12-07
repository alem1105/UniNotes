Esegue:
- Operazioni logiche su singoli bit o su sequenze di bit (bitwise)
- Operazioni aritmetiche:
	- Addizioni e Sottrazioni
	- Moltiplicazioni
	- Divisioni
![[Pasted image 20231105130622.png]]

### w - overflow
![[Pasted image 20231105130827.png]]

### c - riporto in uscita
![[Pasted image 20231105131013.png]]

### z - risultato zero
Utilizziamo un comparatore logico che confronta il risultato con zero

### n - risultato negativo
E' il bit più significativo del risultato


## Esempio di una ALU
- Addizionatore
- 3 linee di controllo:
	- $c_1 = 0$ pone l'operando A a 0
	- $c_0=1$ complemento di B
	- $r = 1$ incrementa di 1
![[Pasted image 20231105132216.png]]

Quindi:
![[Pasted image 20240122204640.png]]

