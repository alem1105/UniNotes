# Codificatore
E' un componente che dato un input da $2^n$ bit restituisce un output da $n$ bit

![[Pasted image 20240121215214.png]]

> [!INFO] Nota
> E' formato quindi da un insieme di _porte OR_ e da tanti input di cui **Soltanto uno vale 1** otteniamo un numero minore di output

# Decodificatore
Nel decodificatore **soltanto 1 delle uscite vale 1**, ed è quella associata alla combinazione in input.
Qui infatti se abbiamo un input da $n$ bit in output abbiamo un numero da $2^n$ bit

![[Pasted image 20240121220159.png]]

> [!INFO] Nota
> E' formato quindi da un insieme di _porte AND_ e da un numero minore di input possiamo ottenere un maggior numero di output

# Esempio di utilizzo
Codificatore e Decodificatore sono utili per diminuire il numero di ingressi e uscite utilizzati, per esempio un input da 8 bit possiamo passarlo in un codificatore per farlo diventare da soli 3 bit, trasportarlo nel circuito e quando abbiamo bisogno di utilizzarlo lo mettiamo in un decodificatore per riottenere il dato iniziale

![[Pasted image 20240121221147.png]]

Qui ad esempio ci entra l'input numero 5 con 8 bit, passato nel codificatore diventa 101 ma da soli 3 bit e una volta andato nel decodificatore con ingresso 101 facciamo uscire il dato 5.