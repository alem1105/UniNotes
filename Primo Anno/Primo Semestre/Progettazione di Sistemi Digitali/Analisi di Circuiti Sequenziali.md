Per effettuare un'analisi:
- Scrivere le espressioni booleane in ingresso ai Flip Flop, chiamate *Funzioni di Eccitazione* e quelle delle uscite
- Stendere le tavole di verità, che prende il nome di *Tavola degli stati futuri*: dove inseriamo input, funzioni di eccitazione, uscite, stati attuali e stati futuri
- Disegniamo il diagramma della rete sequenziale: ***Automa a Stati Finiti (FSM - Fining State Machine)***

Vediamo qualche esempio:
![[Pasted image 20231111092015.png]]

*Espressioni Booleane:*
$d1 = xy_1 + xy_0$
$d0 = x\overline{y_1}$
$z = \overline{x}(y_1+y_0)$

*Ricordando la tavola del D Flip Flop stendiamo la tavola degli stati*
![[Pasted image 20231111092330.png]]
![[Pasted image 20231111092912.png]]
*Disegniamo adesso il diagramma degli stati*
![[Pasted image 20231111093328.png]]
Questo prende il nome di **Diagramma di Mealy**

Codifichiamo Gli stati e stiliamo la tabella del diagrmma:
![[Pasted image 20231111093843.png]]
- - - - - - -
Facciamo un altro esempio
![[Pasted image 20231111100712.png]]

- *Scriviamo le espressioni booleane*
$S = \overline{x_1}$
$R = x_0x_1$
$z_0 = y\overline{x_1}$
$z_1=\overline{y}+x_0$

- *Tavola degli stati*
![[Pasted image 20231111101350.png]]

- *Diagramma di Stato*
![[Pasted image 20231111101834.png]]
- *Tabella del diagramma*
![[Pasted image 20231111102256.png]]
![[Pasted image 20231111102950.png]]

Il diagramma precedente prende invece il nome di **Diagramma di Moore** dove le uscite sono associate agli stati

### Definizione di Automa a Stati Finiti (Finite State Automation)

Abbiamo bisogno di:
- $\Sigma$ - Alfabeto, insieme finito dei simboli (input)
- $Q$ - Insieme finito degli stati
- $\delta$ - Funzione di Transizione (archi dei diagrammi)
	- Definita così: $\delta:Q\times \Sigma \rightarrow Q$
		- Infatti la funzione è definita per tutte le combinazioni di stati e input che ci danno come output un altro stato
- $U$ - Insieme finito di simboli in uscita
	- $\lambda_{Mealy} : Q \times \Sigma \rightarrow U$
		- Nel diagramma di Mealy le uscite sono associate ad ogni input per ogni stato
	- $\lambda_{Moore} : Q \rightarrow U$
		- Nel diagramma di Moore le uscite sono associate agli stati


### Tavole di verità dei Flip Flop utili per la sintesi
![[Pasted image 20231111104316.png]]

