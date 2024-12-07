Come operazioni svolgeremo sottrazione ed **addizione** con una piccola accortezza, **possiamo trasformare ogni sottrazione in un'addizione** facendo attenzione ai segni degli addendi.
- Se sommiamo **due positivi** dobbiamo ottenere un **positivo**
- Se sommiamo **due negativi** dobbiamo ottenere un **negativo**
- Se sommiamo due numeri con **segno diverso** dobbiamo ottenere lo stesso **segno del numero maggiore**
- Dobbiamo sempre **ignorare il riporto**, chiamato **carry**

## Addizione ++
![[Pasted image 20231021130830.png]]
## Addizione +-
![[Pasted image 20231021131112.png]]

## Addizione -- (esempio underflow)
![[Pasted image 20231021131932.png]]
In questo caso sommando due numeri negativi abbiamo ottenuto un numero positivo, non abbiamo quindi abbastanza bit per rappresentare il nostro risultato.

Se sommando due positivi otteniamo un negativo ci troviamo in **overflow**; analogamente sommando negativi se otteniamo un positivo ci troviamo in **underflow**.
Per avere abbasta bit ci basta complementare i nostri numeri in rappresentazione CA2, se un numero è negativo complementiamo con tanti 1 quanti necessari, se positivo con gli 0. ^8be6d5

Esempio, passiamo da 4 bit a 8, numero positivo:
$$0100 \rightarrow 0000\ 0110$$
Numero negativo:
$$1100 \rightarrow 1111 \ 1100$$