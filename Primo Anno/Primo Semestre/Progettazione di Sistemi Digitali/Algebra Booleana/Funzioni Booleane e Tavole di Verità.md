Fissiamo dei concetti:
- *Variabile:* Assume valori dell'alfabeto di supporto
- *Espressione:* Variabili legate da operatori
- *Funzione:* Cosa vogliamo rappresentare tramite delle espressioni

Esempio:
![[Pasted image 20231021175519.png]]
Notiamo che possiamo **rappresentare** una funzione in **più modi** ma **preferiamo** scegliere quella con **meno porte** o meno input letterali, in questo caso il circuito di sinistra

Andiamo a costruire la tavola di verità:
![[Pasted image 20231021175814.png|250]]
Costruire l'intera tabella è anche chiamato metodo **dell'induzione perfetta**.

## Dualità
Un'espressione E1 è la duale di un'espressione E2 se differisce per gli operatori (OR e AND sono invertiti) e per il valore delle costanti
$$x(y+z)=xy+zx \rightarrow (x+y)(x+z)$$

## Funzione complementare
Assiomi e proprietà possono essere applicati alle funzioni, calcoliamo ad esempio la funzione complementare di $f=x\overline{y}+z$
![[Pasted image 20231021181020.png|250]]
N.B. si può ottenere la funzione complementare anche passando alla duale e poi complementando ogni letterale