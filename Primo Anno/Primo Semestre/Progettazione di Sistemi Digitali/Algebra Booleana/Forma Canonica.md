Fissiamo prima due concetti:

## Mintermini e Maxtermini
- *Mintermine*: Termine *Prodotto* in cui compaiono tutti i letterali
- *Maxtermine*: Termine *Somma* in cui compaiono tutti i letterali

## Forma Canonica
- *Forma Canonica SoP:* Tutti i termini prodotto sono Mintermini
- *Forma Canonica PoS:* Tutti i termini somma sono Maxtermini

Queste forme canoniche sono facilmente ricavabili dalla tavola di verità di un'espressione
![[Pasted image 20231021184032.png]]

Non sempre però abbiamo a disposizione la tavola quindi per portare un'espressione in forma canonica:
1) Portiamo in forma normale
2) Se SoP, moltiplico il termine prodotto in cui manca la variabile x per $(x+\overline{x})$
3) Se PoS, sommo il termine somma in cui manca la variabile x per il prodotto $(x*\overline{x})$
4) Applico la proprietà distributiva
5) Elimino eventuali termini ripetuti