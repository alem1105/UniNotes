# Diagrammi UML delle classi e degli oggetti

## Oggetti e Classi

Nella fase di analisi ci concentriamo di più sulle classi, gli oggetti infatti servono di più per descrivere degli elementi significativi o esempi. Molto simile quindi alla programmazione a oggetti, noi definiamo un insieme di classi, gli oggetti verranno poi creati e distrutti durante l'esecuzione del programma.

Vediamo comunque come viene indicato un oggetto in UML:

![[Pasted image 20250227102123.png|200]]

Viene identificato univocamente tramite **l'identificatore di oggetto** ed è un'istanza di una classe ovvero la più specifica perché, come vedremo, un oggetto può essere istanza di più classi.

- `div_comm` è l'identificatore di oggetto, viene scelto dall'analisti per riferirsi all'oggetto all'interno dello schema.
- `Libro` è la classe più specifica di cui l'oggetto è istanza.
- Importante anche la <ins>sottolineatura</ins>

---

Una classe invece modella un insieme di oggetti (istanze) ai quali sono associati delle proprietà (attributi) e dinamiche (operazioni). Ogni classe è descritta da: 
- Nome
- Insieme di proprietà, queste sono in comune fra gli oggetti istanza.

![[Pasted image 20250227103242.png]]

È possibile avere due oggetti identici ovvero con gli stessi attributi purché abbiano diversi identificatori. Quindi ad esempio possiamo avere due libri con titolo _"La divina commedia"_ ma questi dovranno avere un diverso identifcatore.

## Link e Associazioni

Un'associazione modella la possibilità che due o più oggetti abbiano dei legami. Le istanze delle associazioni si chiamano **link**, quindi se $A$ è un'associazione tra le classi $C1$ e $C2$, una istanza di $A$ è un link tra due oggetti, uno di $C1$ e l'altro di $C2$.

![[Screenshot 2025-02-27 alle 10.39.21.png]]

I link, al contrario degli oggetti non hanno identificatori, quindi, vengono identificati implicitamente dalla coppia di oggetti, **non** è quindi possibile avere due link uguali.

Tra più classi inoltre è possibile definire più associazioni che modellano diversi legami, ad esempio la classe libro può avere due relazioni con la classe persona una chiamata Autore e un Editore.

---

**Esempio** - Progettiamo un'applicazione che permette a dei clienti di prenotare hotel.

![[Pasted image 20250227104353.png|500]]

Creiamo adesso un link di prenota.

![[Pasted image 20250227104545.png]]

Cosa accade se alice volesse prenotare una seconda volta presso h1? Non potremmo permetterlo perché avremmo due link uguali e quindi indistinguibili ma non permettere una seconda prenotazione sarebbe inadeguato, come risolviamo?

Creiamo una nuova classe prenotazione in modo da rendere le prenotazione con "vita propria".

![[Pasted image 20250227104827.png]]

In questo modo ogni utente effettuerà delle prenotazioni che avranno sempre un identificativo diverso e questa li metterà in relazione con l'hotel, abbiamo quindi sempre delle coppie hotel - prenotazione e prenotazione - utente diverse.

Ad esempio se Alice prenota due volte presso "La pergola" una prenotazione avrà identificativo p1 mentre la seconda p2.

## Vincoli di molteplicità sulle Associazioni e Attributi

UML permette di definire dei **vincoli di integrità** in un diagramma delle classi ovvero ulteriori restrizioni, vediamo quelle di molteplicità.

![[Pasted image 20250227105601.png|500]]

In questo modo stiamo dicendo che un qualsiasi oggetto della classe Impiegato può essere associato soltanto ad un oggetto di Città, infatti nel mondo reale una persona non può essere nata in più di 1 città. Più nello specifico:

`1 .. 1` - Ogni istanza di impiegato deve essere coinvolta in un numero di link dell'associazioni nascita che va da 1 a 1, quindi un'istanza di Impiegato può essere associata ad un'istanza di città solo una volta tramite l'associazione nascita.

`0 .. *` - Ogni istanza di Città deve essere coinvolta in un numero di link dell'associazione nascita che da 0 all'infinito, quindi un'istanza di città può essere associata ad un qualunque numero di istanze di Impiegato tramite nascita.

### Associazioni sulla stessa Classe

Supponiamo di voler modellare i sovrani di un regno ed i loro predecessori, scriviamo la classe Sovrano:

![[Pasted image 20250227111202.png|100]]

Come indichiamo adesso il concetto di predecessore?

Creiamo l'associazione `successione` che va dalla classe Sovrano alla classe Sovrano, sappiamo però che i link delle associazioni sono coppie di oggetti di Sovrano e quindi siamo obbligati a dare esplicitamente dei nomi distinti ai due ruoli che assume Sovrano:

![[Pasted image 20250227111631.png|500]]

Adesso la classe Sovrano, nell'associazione successione assume il ruolo di predecessore e successore e quindi un'istanza dell'associazione diventa una coppia etichettata (predecessore:s1, successore:s2).

Possibile esempio di link:

![[Pasted image 20250227111823.png]]



