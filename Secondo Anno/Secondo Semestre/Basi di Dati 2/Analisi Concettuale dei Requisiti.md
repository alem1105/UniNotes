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

Cosa accade se Alice volesse prenotare una seconda volta presso h1? Non potremmo permetterlo perché avremmo due link uguali e quindi indistinguibili ma non permettere una seconda prenotazione sarebbe inadeguato, come risolviamo?

Creiamo una nuova classe prenotazione in modo da rendere le prenotazione con "vita propria".

![[Pasted image 20250227104827.png]]

In questo modo ogni utente effettuerà delle prenotazioni che avranno sempre un identificativo diverso e questa li metterà in relazione con l'hotel, abbiamo quindi sempre delle coppie hotel - prenotazione e prenotazione - utente diverse.

Ad esempio se Alice prenota due volte presso "La pergola" una prenotazione avrà identificativo p1 mentre la seconda p2.

## Vincoli di molteplicità sulle Associazioni e sugli Attributi

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
> Aggiungere attributi alla relazione non ci permette comunque di avere più link fra gli stessi oggetti, quindi anche nel caso avessimo lo stesso studente in due link con lo stesso modulo e attributi diversi nel link, **non** sarebbe comunque ammesso

Un'associazione di questo tipo è anche chiamata **association class** dato che a sua volta può essere collegata con altre associazioni, e come prima non ci permette comunque di avere due o più link uguali anche se con attributi o relazioni associate diversi, _ad esempio_:

![[Pasted image 20250304175008.png]]

Con questo schema se avessimo due link sullo stesso studente e sullo stesso modulo con `voto, data` e `Docente` diversi non sarebbe comunque ammesso.

## Tipi di dato Concettuali
Per ogni attributo dobbiamo sempre scegliere un tipo ma ricordiamo che non vogliamo fare scelte tecniche, solo concettuali, quindi scegliamo dei **tipi concettuali** che siano realizzabili in qualsiasi linguaggio / tecnologia.

Quindi useremo dei tipi base come: Stringa, Intero, Reale, Booleano ecc... ma definiamo anche dei nostri tipi.

Ad esempio nello schema usato per i voti non vogliamo poter assegnare un qualsiasi intero o reale dato che potremmo avere anche numeri negativi o con la virgola.

### Tipi di dato specializzati
Forniamo un range di valori ammessi, ad esempio `Intero > 0, Reale <= 0, 18..30, 0..100` ecc...

### Tipi Enumerativi
Se abbiamo un insieme piccolo e finito di valori ammessi allora possiamo usare gli enumerativi che definiscono in modo esplicito l'insieme dei valori ammessi. Ad esempio: `{maschio, femmina}, {Africa, America, Antartide, Asia, Europa, Oceania}` ecc...

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

Un'altra tipologia di vincolo è il **vincolo di identificazione di classe**, questo ci permette di scegliere un insieme di attributi per i quali non possono esistere due o più istanze che hanno simultaneamente dei valori uguali su questi attributi. Prendiamo questo schema come esempio:

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

### Generalizzazioni
Tramite il costrutto della generalizzazione possiamo definire istanze di una classe che sono istanze di più classi figlie secondo **uno stesso criterio concettuale**.

_Esempio_

![[Pasted image 20250313090147.png|350]]

Otteniamo quindi:
- Studente is-a Persona
- Lavoratore is-a Persona
- Il concetto secondo cui una Persona è uno Studente o un Lavoratore è quello dell'occupazione.

Resta possibile per un oggetto essere istanza sia di Studente che di Lavoratore, vediamo come modificare queste cose.

---

Possiamo avere più di un criterio per ogni classe:

![[Pasted image 20250313090410.png|350]]

- Secondo il criterio del **genere** le persone possono essere uomo e/o donna
- Secondo il criterio dell'**occupazione** le persone possono essere Studente e/o Lavoratore

Possiamo fare alcune considerazioni per introdurre i successivi vincoli:
- Una Persona può essere sia Uomo che Studente? Si
- Una Persona può essere istanza né di Uomo né di Donna? Si
- Una Persona può essere istanza sia di Uomo che di Donna? Si

Vediamo come risolvere questi comportamenti indesiderati.

#### Vincoli Generalizzazioni - disjoint
Se rendiamo una generalizzazione disgiunta stiamo dicendo che un oggetto può essere istanza soltanto di una classe fra quelle della generalizzazione.

_Esempio_

![[Pasted image 20250313090957.png|350]]

Adesso in questo schema **non** è più possibile avere una Persona che è istanza di Uomo e Donna contemporaneamente, ma è ancora possibile avere una Persona istanza né di Uomo né di Donna.

#### Vincoli Generalizzazioni - Complete
Con questo vincoli andiamo a evitare che un oggetto possa essere istanza di nessuna classe della generalizzazione.

_Esempio_

![[Pasted image 20250313091305.png|350]]

In questo caso abbiamo che un'istanza di Persona deve essere istanza almeno di una classe della generalizzazione genere. Quindi non possiamo più avere classi che sono istanza né di Uomo né di Donna. (Ma, in questo caso, è possibile averla sia di Uomo che di Donna).

#### Vincoli uniti - complete e disjoint
Possiamo unire i vincoli visti prima per risolvere i casi ambigui.

_Esempio_

![[Pasted image 20250313091533.png|350]]

Quindi in questo modo un'istanza di Persona deve essere **almeno** istanza di **una soltanto** delle classi delle due generalizzazioni.

---

> [!info] In generale possiamo avere queste situazioni in base al vincolo sulla generalizzazione
> 
> ![[Image 13-03-25 at 09.17.jpg]]
> 
> - Foto rubata a [Exyss](https://github.com/Exyss)

### Ereditarietà Multipla
In UML possiamo rappresentare anche questo concetto, ovvero una classe può essere sottoclasse di più classi:

![[Pasted image 20250313092348.png|350]]

I linguaggi di programmazione però, in generale, non permettono di rappresentare questo concetto, infatti se siamo giunti ad una situazione simili probabilmente stiamo sbagliando qualcosa nel nostro schema.

## Operazione di Classe
Finora abbiamo utilizzato sempre proprietà statiche per le classi ovvero i cui valori cambiano soltanto dopo una esplicita modificati dei dati, in UML possiamo però definire delle **operazioni di classe** che sono delle **proprietà dinamiche** i cui valori vengono calcolati ogni volta che servono a partire da valori di altre proprietà. Possiamo quindi vederle come delle funzioni.

In generale una operazione della classe C indica che su ogni oggetto della classe C si può eseguire un calcolo per:
- Ricavare valore da altri dati
- Effettuare cambiamenti di stato, oltre alle proprietà dell'oggetto anche i link in cui è coinvolto e/o degli oggetti a lui collegati

_Esempio_

![[Screenshot 2025-03-13 alle 09.41.12.png|350]]

In generale come sintassi si usa:
- `nome_operazione(argomenti) : tipo_ritorno`
	- `argomenti` è una lista di elementi con la forma `nome_argomento : tipo_argomento`
	- `tipo_tirono` è il tipo del valore restituito dall'operazione
- I tipi di ritorno e degli argomenti possono essere tipi concettuali o anche classi del diagramma
- Un'operazione di classe può essere invocata solo su un oggetto di classe, in questo modo: `oggetto.operazione(argomenti)`

---

Il concetto di ereditarietà si applica anche alle operazioni di classe, quindi ad esempio:

![[Screenshot 2025-03-13 alle 09.47.19.png|350]]

In questo caso possiamo chiamare:
- `ss.media_fino_a(2/6/2023)` che restituisce `28.3`

Dato che StudenteStraniero essendo sottoclasse di Studente eredita anche le operazioni.

---

> [!info] Specifiche delle operazioni
> Il diagramma delle classi non definisce cosa calcolano le operazioni e nemmeno il come modificano i dati. Ad ogni diagramma andrà affiancato un documento che specifica per queste informazioni.

## Specializzazioni di Attributi
In una generalizzazione, una sottoclasse oltre ad avere proprietà aggiuntive potrebbe anche **specializzare** le proprietà ereditate dalla superclasse andando a **restringerne** il dominio (non può estenderlo).

_Esempio_

![[Pasted image 20250313095616.png]]

Lo schema a sinistra è ammesso perché l'articolo nuovo riduce il dominio di `anni_garanzia` richiedendo una garanzia di almeno 2 anni, la classe a destra non è ammessa perché estende il dominio da Interi a Reali.

## Specializzazione di Associazioni
Un'associazione con degli attributi abbiamo detto che si chiama **association class** ed essendo quindi una classe può anche essere radice di relazioni is-a e generalizzazioni.

_Esempio_

![[Pasted image 20250313095850.png|450]]

È importante che l'associazione `vend_nuovo` sia compatibile con l'associazione `venditore`, ovvero deve mettere in relazione oggetti che hanno lo stesso tipo degli oggetti messi in relazione dalla relazione padre (`venditore`). In questo caso è ok perché ArticoloNuovo è un ArticoloInVendita e un VenditoreProfessionale è anche un Utente.

_Esempio_

![[Pasted image 20250313100438.png|350]]

In questo caso il sistema deve rappresentare impiegati e il dipartimento a cui afferisce ogni impiegato con data di inizio del lavoro e il direttore del dipartimento (che è un impiegato). I direttori devono afferire al dipartimento che dirigono.

### Condizioni per la Correttezza
Le specializzazioni di associazioni hanno bisogno di particolare attenzione per quanto riguarda i vincoli di molteplicità.

_Esempio di prima modificato_

![[Pasted image 20250313101009.png]]

In questo caso stiamo dicendo che ArticoloNuovo può partecipare a infiniti link di vend_nuovo, ma questo va in contraddizione con l'associazione venditore che limita i link di ArticoloInVendita ad 1.

Ricordiamo infatti che un link vend_nuovo **è** un link venditore a tutti gli effetti.

Anche in questo caso quindi vogliamo soltanto restringere il vincolo, non possiamo espanderlo.

_Altri casi_

![[Pasted image 20250313101201.png]]

In questo caso siamo obbligati ad avere due link di vend_nuovo ma l'associazione venditore ci limita ad 1 e quindi vanno in contraddizione.

## Specializzazione di Operazioni di classe
Anche le operazioni possono essere oggetto di specializzazioni in sottoclassi.

Prendiamo come esempio uno schema per degli articoli in vendita, questi avranno un'operazione per calcolare il prezzo in base ad alcuni parametri, poi abbiamo una sottoclasse ArticoloInOfferta che eredita la stessa operazione ma la modifica ad esempio applicandoci uno sconto:

![[Pasted image 20250313101657.png|350]]

Anche in questo caso le operazioni devono essere **compatibili**:
- Stesso numero e tipo di argomenti
- Il tipo di ritorno dell'operazione nella sottoclasse è dello stesso tipo o sotto-tipo di quello dell'operazione nella superclasse.

Come detto prima avremo bisogno di un documento per specificare le operazioni che in questo caso saranno:

![[Pasted image 20250313101837.png|450]]

