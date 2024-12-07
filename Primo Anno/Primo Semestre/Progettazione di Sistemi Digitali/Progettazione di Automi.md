Realizziamo un automa per una macchina distributrice
Come input abbiamo monete da 10 e 20 centesimi
Prendiamo in analisi due casi
1 - Diamo l'output quando raggiungiamo 50 centesimi e memorizziamo il resto
2 - Diamo un secondo output con il resto

1)
**Realizziamo la tavola degli stati**
![[Pasted image 20231119122804.png]]

**Diagramma di Mealy**
![[Pasted image 20231119122826.png]]

**Codifichiamo gli input e gli stati**
![[Pasted image 20231119123553.png]]
In questo caso dovremmo utilizzare 3 flip flop


## Automa Riconoscitore
Progettare un automa che prende in input i caratteri O S T e produce 1 in uscita se riconosce STO e OTO con sovrapposizioni

**Costruiamo la tavola degli stati**
![[Pasted image 20231119131145.png]]

Possiamo quindi semplificare ulteriormente il nostro automa e disegnare il diagramma di Moore:
![[Pasted image 20231119131242.png]]

**Codifichiamo gli input e gli stati**
![[Pasted image 20231119131303.png]]

In questo caso abbiamo deciso di utilizzare un FF SR e un FF JK, ricaviamo quindi le loro espressioni booleane
![[Pasted image 20231119131635.png]]![[Pasted image 20231119131644.png]]

Possiamo disegnare quindi lo schema del circuito:
![[Pasted image 20231119132247.png]]

Realizziamo il **Diagramma Temporale** della tabella, rispetto ad una sequenza in ingresso ad esempio *"SSTOTO"*

Dobbiamo rappresentare:
- Clock
- Input (Codifica Binaria) S: 11, T: 10, O: 01
- Stati (Codifica Binaria)
- Uscite
![[Pasted image 20231119132436.png]]
