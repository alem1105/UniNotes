Un blocco hardware con input e output si chiama modulo, ne esistono di 2 tipi:
- Comportamentale: Descrive cosa fa un modulo
- Strutturale: Descrive come è costruito un modulo, partendo da moduli più semplici 

**Esempio**
```verilog
module nomemodulo(input logic a, b, c, output logic y);
	assign y = ~a & ~b & ~c | a & ~b & ~c | a & ~b & c;
endmodule
```

Con la sintassi _module - endmodule_ iniziamo e chiudiamo un modulo;
_Input e output_ indicano rispettivamente gli input e output del blocco hardware e con _assign_ definiamo l'espressione booleana da assegnare all'output.

_Operatori Utilizzati:_
- ~ not
- | or
- & and

**Esempio**
```verilog
module nuovomodule(input logic a, b, c, output logic y);
	assign y = ~b & ~c | a & ~b
endmodule
```

---

I linguaggi di descrizione hardware (*HDL*) hanno due principali obiettivi: *Sintesi e Simulazione*.
- Nella Simulazione forniamo valori di ingresso al modulo e controlliamo se il modulo fornisce le giuste uscite.
- Nella sintesi la descrizione del modulo viene tradotta in rete di porte logiche.

**Esempio di Sintesi**
Modulo originale:
```verilog
module funzione(input logic a, b, c, output logic y);
	assign y = ~a & ~b & ~c | a & ~b & ~c | a & ~b & c;
endmodule
```

Il circuito sintetizzato sarà
![[es sistemi - page 4.png|]]

***Definizione***
Una classe di componenti logiche prende il nome di _idioma_.
## Logica Combinatoria
Gli operatori a singolo bit (*bitwise*) agiscono su segnali costituiti da bit singoli o su bus multibit.

**Esempio di not collegato a bus 4 bit:**
```verilog
module neg(input logic [3:0] a, output logic [3:0] y);
	assign y = ~a
endmodule
```
In questo caso la variabile _a_ rappresenta un bus a 4 bit infatti $[3:0]$ indicano i bit dal più significativo al meno significativo infatti potevamo rappresentarlo anche con $[4:1]$ o $[0:3]$
Come output produciamo il complemento di ogni bit del bus.

**Esempio**
```verilog
module porte(input logic [3:0] a,b,
					output logic [3:0] y1, y2, y3, y4, y5)
	assign y1 = a & b;
	assign y2 = a | b;
	assign y3 = a ^ b; //XOR
	assign y4 = ~(a & b); //NAND
	assign y5 = ~(a | b); //NOR
endmodule
```

Ogni _y_ output sarà un altro bus da 4 bit 

**Sintesi del Circuito**
Gli operatori di riduzione sono costituiti da porte logiche a tanti ingressi che producono un'unica uscita.

_Esempio AND a 8 ingressi_
```verilog
module and8(input logic [7:0] a, output logic y);
	assign y = &a;
	//&a equivale a scrivere a[7] & a[6] & a[5] ecc...
endmodule
```


## Assegnamento Condizionale (MUX)
Un MUX seleziona l'uscita da generare tra varie alternative sulla base di un ingresso chiamato condizione.
**Esempio MUX 2:1 a 4 bit di ingresso che fa uso di assegnamento condizionale**
```verilog
module mux2(input logic [3:0] d0, d1, input logic s,
				output logic [3:0] y);
	assign y = s ? d1 : d0;
endmodule	
```

L'operatore condizionale _?_ seleziona sulla base della prima espressione, la seconda o la terza espressione. In questo caso se _s = 1_ scegliamo _d1_ se _s = 0_ scegliamo _d0_.

**Esempio MUX 4:1**
```verilog
module mux4(input logic [3:0] d0, d1, d2, d3
			   input logic [1:0] s,
			   output logic [3:0] y);
	assign y = s[1] ? (s[0] ? d3 : d2) : (s[0] ? d1 : d0)
endmodule
```

In questo caso abbiamo due bit di scelta quindi 4 combinazioni (00, 01, 10, 11), quindi con _s\[1\]_ scegliamo se andare in _0x_ o _1x_ e poi con _s\[0\]_ scegliamo se andare in _x0_ o _x1_.

## Variabili Locali 
Le variabili locali sono utilizzate solo all'interno del modulo

**Esempio**
```verilog
module sommatore(input logic a, b, rin,
					output logic s, rout);
	logic p, g;

	assign p = a ^ b;
	assign g = a & b;
	assign s = p ^ rin;
	assign rout = g | (p & rin);
endmodule
```

_p, g_ non sono valori accessibili fuori dal sommatore e vengono usati solo all'interno per effettuare calcoli.

---
## NOTAZIONI

- E' importante utilizzare le parentesi per specificare le precedenze delle operazioni.
- I numeri possono essere spezzati con i _ 111_232323_424 ha lo stesso valore di 111232323424
- In Verilog _4'bxxxx_ è una notazione per rappresentare un bus di 4 bit con tutti i valori impostati al valore x corrispondente.
- Concatenazione di bit: Dobbiamo assegnare al bus y il valore a 9 bit
  c2c1d0d0d0c0101:
  ```verilog
  assign y = {c[2:1], {3{d[0]}}, c[0], 3'b101}
```

- Con _{3{d\[0\]}}_ indico 3 volte il valore _d\[0\]_

- assign {ab, bb, cb} = ~{a, b, c} significa che:
	- ab = ~a
	- bb = ~b
	- cb = ~c
---
## Porte Logiche con Ritardi
E' possibile assegnare dei ritardi alle istruzioni da svolgere:

```verilog
`time scale 1ns/1ps
module esempio(input logic a, b, c, output logic y);
	logic ab, bb, cb, n1, n2, n3;

	assign #1 {ab, bb, cb} = ~{a, b, c};
	assign #2 n1 = ab & bb & cb;
	assign #2 n2 = a & bb & cb;
	assign #2 n3 = a & bb & c;
	assign #4 y = n1 | n2 | n3;
endmodule
```

In questo caso come unità di misura abbiamo _1 nanosecondo con precisione 1 picosecondo_, con _assign \#x_ indichiamo dopo quante volte l'unità di misura viene svolta l'operazione.
Quindi rispettivamente le righe verranno svolte dopo:
1. 1ns
2. 2ns
3. 2ns
4. 2ns
5. 4ns

## Modellazione Strutturale
Costruiamo un MUX 4:1 usando tre MUX 2:1

Definiamo un modulo per il MUX 2:1
```verilog
module mux2(input logic [3:0] d0, d1, input logic s,
		output logic [3:0] y);
	assign s ? d1 : d0;
endmodule
```

Il MUX 4:1 sarà formato da un MUX 2:1 che sceglie fra altri due MUX 2:1, utilizziamo quindi il modulo _mux2_ 3 volte passando ogni volta parametri diversi.

```verilog
module mux4(input logic [3:0] d0, d1, d2, d3, 
			   input logic [1:0] s, output logic [3:0] y);
	logic [3:0] basso, alto;

	mux2 muxbasso(d0, d1, s[0], basso)
	mux2 muxalto(d2, d3, s[0], alto)
	mux2 muxuscita(basso, alto, s[1], y)
endmodule
```

![[es sistemi - page 4 1.png]]

Quindi se _s1 = 1_ scelgo l'output del MUX_BASSO mentre se _s1 = 0_ scelgo il MUX_ALTO e loro faranno la stessa cosa con _s0_ e i loro input _dx_.

## Logica Sequenziale

**Flip Flop D**
```verilog
module flop(input logic clk, input logic [3:0] d,
			   output logic [3:0] q);
	always_ff @(posedge clk)
		q <= d;
endmodule
```

_always_ff_ indica il flip flop, _posedge clk_ indica su che fronte d'onda si attiva l'istruzione _q <= d_, in questo caso quando l'onda è positiva.

In generale un'istruzione always ha la forma:
```verilog
always @(sensitivity list)
	istruzione
```

Abbiamo anche varie istruzione _always:_ _always_ff, always_latch, always_comb_.

Le istruzioni always possono essere usate quando abbiamo bisogno di una memorizzazione, mentre istruzioni assign vengono ogni volta rieseguite da capo.

**Registro resettabile in modo asincrono/sincrono**
```verilog
module flopr(input logic clk, input logic reset,
				input logic [3:0] d, output logic [3:0] q);
	always_ff @(posedge clk or posedge reset)
		if (reset) q <= 4'b0;
		else q <= d;
endmodule
```

```verilog
module flopr(input logic clk, input logic reset,
				input logic [3:0] d, output logic [3:0] q);
	always_ff @(posedge clk)
		if (reset) q <= 4'b0;
		else q <= d;
endmodule
```

Il primo registro (Asincrono) può essere resettato anche quando il clock è a 0, il secondo (Sincrono) controlla il reset soltanto quando il clock = 1.

**Registri con abilitazione (enable)**
Questi reagiscono al clock soltanto se la linea _enable è attiva_
```verilog
module flopen(input logic clk,
					 input logic reset,
					 input logic en,
					 input logic [3:0] d,
					 output logic [3:0] q);
	always_ff @(posedge clk, posedge reset)
		if (reset) q <= 4'b0;
		else if (en) q <= d;
endmodule
```

**Registri multipli: sincronizzatore**
```verilog
module sync(input logic clk,
				   input logic d,
				   output logic q);
	logic n1;
	always_ff @(posedge clk)
		begin
			n1 <= d;
			q <= n1;
		end
endmodule
```

![[Senza titolo-2024-01-09-1640.png]]


Il costrutto _begin / end_ è necessario perché ci sono più istruzioni che vanno eseguite con l'always.
Negli esempi precedenti il costrutto _if / else_ corrisponde ad una sola operazione quindi il costrutto begin / end non era necessario.

**Latch D**
Quando il clock è alto non interferisce e fa passare gli input, mentre quando il clock è basso mantiene lo stato ottenuto in precedenza.
```verilog
module latch(input logic clk, input logic [3:0] d,
					output logic [3:0] q);
	always_latch
		if (clk) q <= d;
endmodule
```

Con _always_latch_ descriviamo un latch.
Questo viene valutato ogni volta che clk o d cambiano. Se _clk_ è alto, _d_ attraversa i latch e arriva a _q_ altrimenti _q_ mantiene il valore precedente.

**Negatore di always**
```verilog
module neg(input logic [3:0] a, output logic [3:0] y);
	always_comb
		y = ~a;
endmodule
```

_always_comb_ rivaluta le istruzioni all'interno dell'istruzione always ogni volta che i segnali a destra di _<= / =_ cambiano.
Quindi ogni volta che cambia _y_ neghiamo _a_.

***Il simbolo = nell'istruzione always e' chiamato assegnamento bloccante, rispetto all'assegnamento non bloccante <=.
E' buona norma usare assegnamenti bloccanti in logica combinatoria e assegnamenti non bloccanti in logica sequenziale***.

**Sommatore Completo**
```verilog
module sommatore(input logic a, b, rin,
					output logic s, rout);
	logic p, g;

	always_comb
		begin
			p = a ^ b;
			g = a & b;
			s = p ^ rin;
			rout = g | (p & rin);
		end
endmodule
```

**Istruzione case**
```verilog
module sette_segmenti(input logic [3:0] dati,
						  output logic [6:0] segmenti);
	always_comb
		case(dati)
			0: segmenti = 7'b111_1110;
			1: segmenti = 7'b011_0000;
			2: segmenti = 7'b110_1101;
			3: segmenti = 7'b111_1001;
			4: segmenti = 7'b011_0011;
			//ecc
			5: segmenti = 7'b111_1110;
			6: segmenti = 7'b111_1110;
			7: segmenti = 7'b111_1110;
			8: segmenti = 7'b111_1110;
			9: segmenti = 7'b111_1110;
			default: segmenti = 7'b000_0000;
		endcase
endmodule
```

Il caso appena visto non è il vero e proprio metodo, vediamo un caso reale

**Decoder 3:8**
```verilog
module decoder3_8(input logic [2:0] a,
						output logic [7:0] y);
	always_comb
		case(a)
			3'b000: y = 8'b00000001;
			3'b001: y = 8'b00000010;
			3'b010: y = 8'b00000100;
			3'b011: y = 8'b00001000;
			3'b100: y = 8'b00010000;
			3'b101: y = 8'b00100000;
			3'b110: y = 8'b01000000;
			3'b111: y = 8'b10000000;
			default: y = 8'bxxxxxxxx;
		endcase
endmodule
```

Quindi se _a_ vale 000 _y_ diventa 00000001

Se ho bisogno di utilizzare il valore _don't care_ posso usare il costrutto _casez_ e _?_ come don't care

```verilog
module circprio_indiff(input logic [3:0] a,
						  output logic [3:0] y);
	always_comb
		casez(a)
			4'b1???: y = 4'b1000;
			4'b01??: y = 4'b0100;
			4'b001?: y = 4'b0010;
			4'b0001: y = 4'b0001;
			default: y = 4'b0000;
		endcase
endmodule
```

Il _default_ è il campo che viene eseguito se non rientriamo in nessuno dei casi precedenti.

---
## Assegnamenti bloccanti e non bloccanti

**Usare always_ff @(posedge clk) e assegnamenti non bloccanti per modellizzare logica sequenziale sincrona**
```verilog
always_ff @(posedge clk)
	begin
		n1 <= d;
		q <= n1;
	end
```

**Usare assegnamenti continui per logica combinatoria semplice**
```verilog
assign y = s ? d1 : d0
```

**Usare always_comb e assegnamenti bloccanti per logica combinatoria complessa**
```verilog
always_comb
	begin
		p = a ^ b;
		g = a & b;
		s = p & rin;
		rout = g | (p & rin);
	end
```

**Non fare assegnamenti allo stesso segnale in più  di un'istruzione always o più di un'istruzione di assegnamento continuo.**

---

**Sommatore completo con assegnamenti non bloccanti**
```verilog
module sommatore(input logic a, b, rin,
						 output logic s, rout);
	logic p, g;

	always_comb
		begin
			p <= a ^ b;
			g <= a & b;
			s <= p ^ rin;
			rout <= g | (p & rin);
		end
endmodule
```

**Contatore modulo 11, conta fino a 10**
Mi servono 4 bit per implementarlo:
```verilog
module contatore(input logic [3:0] count, input logic clk
						input logic reset,
						output logic next_count);
	always_ff @(posedge clk or posedge reset)
		if (reset) count <= 4'b0000;
		else if (count == 4'b1010) count <= 4'b0000;
		else next_count <= count + 1
endmodule
```

**Macchine a stati finiti**
Implementazione di una macchina a stati finiti che riconosce una sequenza, è previsto un segnale di reset asincrono. MOORE

```verilog
module sequenzeMoore(input logic clk,
					input logic reset,
					input logic a,
					output logic y);
	typedef enum logic [1:0] {S0, S1, S2} tipostato;
	tipostato stato, statopross;

	always_ff @(posedge clk, posedge reset)
		if (reset) stato <= S0;
		else stato <= statopross;
		
	always_comb
		case (stato)
			S0: if (a) statopross = S0;
				else statopross = S1;
			S1: if (a) statopross = S2;
				else statopross = S1;
			S2: if (a) statopross = S0;
				else statopross = S1;
			default: statopross = S0;
		endcase

	assign y = (stato == S2);
endmodule
```

- L'istruzione _typedef_ definisce _tipostato_ come valore di tipo logico a due bit con tre possibilità: _S0, S1, S2_. _stato e statopross_ sono due segnali di tipo _tipostato_. Quindi _stato_ è di tipo _tipostato_ che è un _enum_ formato da due bit e può valere S0 S1 o S2.
- Le codifiche enumerative seguono l'ordine numerico quindi S0 = 00, S1 = 01, S2 = 10.
- Dal momento che la logica di stato prossimo deve essere combinatoria è necessaria la clausola default
- Manda 1 come output quando riconosce la sequenza S2.
- ***MOORE: uscita dipende solo dallo stato presente. MEALY: uscita dipende da ingresso e stato presente.***

**Esempio Mealy**
```verilog
module sequenzeMealy(input logic clk,
					input logic reset,
					input logic a,
					output logic y);
	typedef enum logic [1:0] {S0, S1, S2} tipostato;
	tipostato stato, statopross;

	always_ff @(posedge clk, posedge reset)
		if (reset) stato <= S0;
		else stato <= statopross;

	always_comb
		case (stato)
			S0: if (a) statopross = S0;
				else statopross = S1;
			S1: if (a) statopross = S2;
				else statopross = S1;
			S2: if (a) statopross = S0;
				else statopross = S1
			default: statopross = S0;
		endcase

	assign y = (a & stato == S1);
endmodule
```

---
# ESEMPI

---

```verilog
module es(input logic clk, input enum logic [1:0] {A, L, F, F} x, 
			  output logic [1:0] z);

	type def [1:0] {SIN, SA, SAL, SALF} tipostato;
	tipostato stato, statopross;

	always_ff @(posedge clk)
		stato <= statopross

	always_comb
		case (stato)
			SIN: if (x == A) statoprossimo = SA
					else statoprossimo = SIN
			SA: if (x==A) statoprossimo = SA
				else if (x==L) statoprossimo = SAL
				else statoprossimo = SIN
			SAL: if(x==A) statoprossimo = SA
				 else if (x==L) statoprossimo = SIN
				 else statoprossimo = SALF
			SALF: if (x==A) statoprossimo = SA
					else statoprossimo = SIN
			default: statoprossimo = SIN
		endcase

	assign z[1] = (stato == SAL & x == A)
	assign z[0] = (stato == SALF & x == A)
endmodule
```

```verilog
module mux2(input d0, d1, s, output logic y);
	assign y = s ? d1 : d0

module mux4(input logic d0, d1, d2, d3, s1, s0, output logic y);
	logic muxalto, muxbasso
	mux2(d0, d1, s1, muxalto)                 
	mux2(d1, d2, s1, muxbasso)
	mux2(muxalto, muxbasso, s0, y)
endmodule
```