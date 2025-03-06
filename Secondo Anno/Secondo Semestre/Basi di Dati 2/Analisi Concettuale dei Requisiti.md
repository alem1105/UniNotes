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

## Associazioni con Attributi
Prendiamo come esempio un sistema che gestisce gli esiti dei test superati dagli studenti di vari moduli, se volessimo assegnare un voto a questi non sarebbe adeguato né nella classe Studente dato che il voto non è una caratteristica unica di uno studente ma neanche in modulo per lo stesso motivo. Possiamo aggiungere degli attributi alla relazione che c'è tra Studente e Modulo.

![[Screenshot 2025-03-04 alle 17.44.04.png|350]]

In questo modo lo stesso studente può partecipare più volte alla relazione `test_superato` e possiamo assegnare ad ogni link un voto ed una data diversi.

> [!bug] Att.
> Aggiungere attributi alla relazione non ci permette comunque di avere più link fra gli stessi oggi, quindi anche nel caso avessimo lo stesso studente in due link con lo stesso modulo e attributi diversi nel link, **non** sarebbe comunque ammesso

Un'associazione di questo tipo è anche chiamata **association class** dato che a sua volta può essere collegata con altre associazioni, e come prima non ci permette comunque di avere due o più link uguali anche se con attributi o relazioni associate diversi, _ad esempio_:

![[Pasted image 20250304175008.png]]

Con questo schema se avessimo due link sullo stesso studente e sullo stesso modulo con `voto,data` e `Docente` diversi non sarebbe comunque ammesso.

## Tipi di dato Concettuali
Per ogni attributo dobbiamo sempre scegliere un tipo ma ricordiamo che non vogliamo fare scelte tecniche, solo concettuali, quindi scegliamo dei **tipi concettuali** che siano realizzabili in qualsiasi linguaggio / tecnologia.

Quindi useremo dei tipi base come: Stringa, Intero, Reale, Booleano ecc... ma definiamo anche dei nostri tipi.

Ad esempio nello schema usato per i voti non vogliamo poter assegnare un qualsiasi intero o reale dato che potremmo avere anche numeri negativi o con la virgola.

### Tipi di dato specializzati
Forniamo un range di valori ammessi, ad esempio `Intero > 0, Reale <= 0, 18..30, 0..100` ecc...

### Tipi Enumerativi
Se abbiamo un insieme piccolo e finito di valori ammessi allora possiamo usare gli enumerativi che definisce in modo esplicito l'insieme dei valori ammessi. Ad esempio: `{maschio, femmina}, {Africa, America, Antartide, Asia, Europa, Oceania}` ecc...

Dobbiamo però fare attenzione ad utilizzarli dati che se in futuro abbiamo bisogno di altri valori potrebbe essere difficile modificare la base di dati.

### Definiti dall'utente
UML ci permette di definire dei tipi da usare liberamente nello schema, ad esempio possiamo creare il tipo `Genere = {maschio, femmina}` e usarlo in uno schema in questo modo:

![[Pasted image 20250304180827.png|350]]

Possiamo inoltre creare anche dei tipi di dato composti da più campi chiamati **tipi record**, ad esempio possiamo definire:

- `Indirizzo = (via:Stringa, civico:Intero>0, cap:Intero>0)`
- `Genere = {maschio, femmina}`

ed usarli in uno schema:

![[Screenshot 2025-03-04 alle 18.10.45.png|350]]

---


> [!info] Molteplicità degli Attributi
> Anche gli attributi possono avere una molteplicità, pensiamo ad esempio ad un sito web che per ogni utente ci permette di memorizzare più di un indirizzo email o numero di telefono. Si utilizza la seguente sintassi:
> 
> ![[Screenshot 2025-03-04 alle 18.12.45.png|350]]
> 

## Vincoli di Identificazione di Classe
A volte potrebbe servirci definire ulteriori vincoli, ad esempio abbiamo visto per i **vincoli di integrità**, i vincoli di molteplicità sulle associazioni.

Un'altra tipologia di vincolo è il **vincolo di identificazione di classe**, questo ci permette di scegliere un insieme da attributi per i quali non possono esistere due o più istanze che hanno simultaneamente dei valori uguali su questi attributi. Prendiamo questo schema come esempio:

![[Pasted image 20250306090412.png|250]]

In questo caso non possiamo avere due o più istanze di Persona che hanno simultaneamente uguali il campo `cf` e neanche gli attributi `nome, cognome, nascita` (a gruppo). Inoltre ogni attributo può partecipare a più gruppi identificativi.

### Vincolo di identificazione con ruolo
Un vincolo di identificazione di classe può coinvolgere anche i ruoli della classe.

Prendiamo questo schema come esempio:

![[Pasted image 20250306092329.png|350]]

In questo caso possono esistere due o più studenti con la stessa matricola ma non all'interno della stessa Università.

> [!danger] Attenzione
> Non possiamo definire come ID degli attributi o ruoli se questi non hanno molteplicità 1..1

## Relazione is-a tra classi
Molte volte è necessario rappresentare il fatto che due classi abbiano una relazione di **sottoinsieme**, possiamo farlo con il concetto di **relazione is-a** tra classi.

![[Pasted image 20250306092640.png|250]]

Questo significa che ogni istanza della classe Studente è anche istanza della classe Persona, dove Studente è sottoclasse e Persona è superclasse. Non è vero il viceversa, non tutte le persone sono studenti.

### Ereditarietà
In presenza della relazione **is-a** esiste il meccanismo dell'ereditarietà questo significa che ogni sottoclasse avrà anche gli attributi presenti nella superclasse.

Quindi per esempio nello schema sopra avremo che ogni Studente ha anche i campi per gli attributi `nome, genere` oltre che a `matricola`.

Inoltre possiamo avere anche relazione is-a a più livelli usando il concetto di **transititivà**.

![[Pasted image 20250306101017.png|350]]

In questo caso abbiamo che ogni Persona ha i campi `nome, genere`, inoltre ogni Studente eredita questi campi e memorizza in più anche `matricola`, StudenteStraniero invece non aggiunge nulla di nuovo ma eredita sia da Persona che da Studente.

Inoltre stiamo rappresentando anche le relazione delle varie sottoclassi, ovvero, ad ogni Persona è associata una città di nascita questo significa che anche Studente e StudenteStraniero parteciperanno ad un link di `nascita`. Poi abbiamo studente che partecipa a `tutor_stud` e quindi ci parteciperà anche StudenteStraniero ma **non Persona**.

StudenteStraniero infine partecipa da solo a `naz_stud` (da solo nel senso non le sue superclassi).
### Classi Specifiche di un Oggetto
Un oggetto quindi può essere istanza di più classi. (ma una classe non può essere sottoclasse di più classi)

Possiamo quindi indicare le **classi più specifiche** di un oggetto, queste sono le classi di cui l'oggetto è istanza che non sono a loro volta superclassi di atre classi dell'oggetto.

_Esempio_

![[Screenshot 2025-03-06 alle 10.17.36.png|350]]

In questo caso abbiamo che l'oggetto `anna` è istanza di Persona, Studente e Lavorate mentre l'insieme delle classi specifiche è formato da: Studente e Lavoratore in quanto non sono superclassi di altre classi di cui `anna` è istanza.



