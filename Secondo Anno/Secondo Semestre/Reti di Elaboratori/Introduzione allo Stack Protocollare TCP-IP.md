Dobbiamo far collaborare sia hardware che software facendo rispettare dei protocolli.

> [!info] Protocollo
> Un protocollo definisce le regole che il mittente e il destinatario e tutti i sistemi coinvolti devono rispettare per poter comunicare. In alcune situazioni sono necessari più protocolli, uno per ciasun livello (**layer**) e quindi si parla di **layering di protocolli**.

_Esempio_ - Due amiche vogliono parlarsi per posta e assicurarsi che nessun altro possa leggere i loro messaggi, dovranno usare anche dei corrieri per spedire le lettere:

![[Screenshot 2025-03-12 alle 12.28.37.png]]

Notiamo che ad ogni livello sembrerà di parlare soltanto con il livello simmetrico dall'altro lato, diciamo quindi che non conoscono tutta la struttura che esiste oltre a loro.

# Strutturazione a Livelli
Si basa sul fatto di dividere un compito complesso in compiti più semplici e soprattuto **rendere modulare** la comunicazione in questo modo se ad esempio vogliamo cambiare protocollo di crittografia o altro dovremmo soltanto cambiare le macchine che si occupano di quel compito, lasciando intatto il resto.

- Separazione tra servizi e implementazione: un livello usa servizi dal livello inferiore e offre servizi al livello superiore indipendentemente dall'implementazione.

## Principi della strutturazione a Livelli
Quando abbiamo bisogno di una comunicazione bidirezionale ciascun livello deve essere in grado di effettuare il compito in ciascuna direzione ad esempio crittografare e decrittografare.

Inoltre gli oggetti sotto ciascun livello devono essere identici, quindi prendendo come esempio sempre la crittografia avremo che al livello che si occupa della crittografia ci occuperemo sempre di messaggi criptati.

- Collegamento logico: I livelli logicamente sono collegati, ovvero è come se si parlassero soltanto fra loro due:

![[Pasted image 20250312125850.png]]

Come funziona in Internet?

# Stack Protocollare TCP - IP
È composto da 5 livelli:

1) Applicazione - Livello 5 il più vicino all'utente
2) Trasporto
3) Rete
4) Collegamento
5) Fisico - Livello 1

- **Applicazione** - È dove si trovano le applicazioni di rete come server HTTP, SMTP, FTP, DNS. Qui i pacchetti prendono il nome di **messaggi**.
- **Trasporto** - Si occupa di trasferire i messaggi dell'applicazione tra il client e il server, troviamo ad esempio i due protocolli UDP e TCP.
  Il TCP è più sicuro ma meno veloce e i pacchetti prendono il nome di segmenti mentre UDP è meno sicuro ma più veloce, qui i pacchetti prendono il nome di datagramma utente.
- **Rete** - Si occupa di trovare un percorso che metta in collegamento il nodo di origine e il nodo di arrivo, usiamo il protocollo IP e altri di instradamento. Qui i pacchetti prendono il nome di datagrammi.
- **Link (collegamento)** - Molto simile alla rete ma non si occupa del percorso origine - destinazione ma del come far comunicare due nodi all'interno del percorso quindi ad esempio se usare una connessione ethernet o un Wi-Fi. I pacchetti prendono il nome di frame.
- **Fisico** - È il trasferimento vero e proprio dei bit

Abbiamo quindi che i livelli applicazione - trasporto sono più a livello software mentre link - fisico più hardware. Il livello rete rimane abbastanza neutro.

## Comunicazione in una Internet
I vari dispositivi che necessitano di comunicare implementano tutto lo stack, i router invece non hanno bisogno dei livelli più alti dato che devono solo gestire la parte meno vicina all'utente:

![[Screenshot 2025-03-12 alle 13.18.49.png]]

In questo modo, introducendo solo i livelli necessari, andiamo a ridurre la complessità della rete.

## Gerarchia dei Protocolli
La rete come detto prima è organizzata a **layer** costruiti l'uno sull'altro, lo scopo di ogni layer è quello di offrire servizi agli strati superiori nascondendo i dettagli implementativi.

Un layer N di un PC quindi deve essere in comunicazione con il layer N di un altro PC ma non direttamente fra loro due, dovranno passare fra gli altri layer. Il come comunicano viene definito dai **protocolli**.

Le entità che formano questi strati prendono il nome di **peer**, quindi ad esempio due layer di **collegamento** formano un peer.

## Servizi e Protocolli
**Servizio** - insieme di primitive che uno strato offre a quello superiore, definisce quindi quali operazioni si possono usare ma non il come ovvero l'implementazione.

**Protocollo** - È un insieme di regole che controllano il formato e significato dei pacchetti o in generale i messaggi che vengono scambiati all'interno dello strato.

## Incapsulamento e Decapsulamento
Quando un layer riceve un pacchetto dal livello superiore questo lo incapsula aggiungendo un header in modo da renderlo leggibile al livello con cui è in peer.

Il router è quel dispositivo che dovrà effettuare sia incapsulamento che decapsulamento dato che è collegato a due link.

Aggiungendo questi header permettiamo quindi ad ogni livello di riconoscere su quali pacchetti devono agire, se ad esempio il livello di trasporto aggiunge come header `4`, gli altri livelli di trasporto sanno che dovranno leggere soltanto i pacchetti con header `4`.

![[Screenshot 2025-03-12 alle 13.36.07.png]]

I nomi che diamo ai pacchetti nei vari livelli dipendono appunto dall'header presente:
- Messaggio - nessuna intestazione
- segmento o datagramma utente - header trasporto + messaggio
- datagramma - header rete + segmento
- frame - header collegamento + datagramma

## Multiplexing e Demultiplexing
Dato che il TCP-IP prevede l'uso di più protocolli nello stesso livello è necessario eseguire multiplexing alla sorgente e demultiplexing alla destinazione, ovver:
- **Multiplexing**: Un protocollo può incapsulare i pacchetti ottenuti da più protocolli di livello superiore
- **Demultiplexing**: Un protocollo può decapsulare e consegnare i pacchetti a più protocolli del livello superiore

Va ovviamente dedicato un campo nell'header per identificare a quale protocollo appartengono i pacchetti incapsulati.

Abbiamo che ad esempio il protocollo TCP può incapsulare pacchetti di tipo FTP, HTTP mentre UDP può incapsualre DNS e SNMP, grazie agli header riusciamo a capire a quale protocollo appartiene un pacchetto (demultiplexing):

![[Pasted image 20250312134652.png]]

## Indirizzamento nel modello TCP - IP
Dato che utilizziamo una comunicazione logica tra coppie di livelli abbiamo bisogno di due indirizzi, uno per la sorgente e uno per la destinazione.

Ad ogni livello associamo dei nomi diversi per gli indirizzi:

![[Pasted image 20250312134842.png]]

---


> [!info] Layering - vantaggi e svantaggi
> Tra i vantaggi troviamo quindi la modularità che ci garantisce facilità di design e la possibilità di modificare dei moduli in modo trasparente agli altri moduli. Come svantaggio abbiamo che alcune volte potrebbe essere necessario scambiare informazioni fra livelli non adiacenti e quindi non rispetteremmo il principio della stratificazione.

---

# Modello OSI
Il modello OSI è stato presentato dalla ISO (International Organization for Standardization) ed è stato presentato come alternativa al TCP-IP.

Questo ha 7 livelli ed è stato creato per permettere la comunicazione fra qualsiasi tipo di dispositivo.

![[Pasted image 20250312135245.png|400]]

Mettendoli a confronto otteniamo:

![[Pasted image 20250312135329.png|500]]

Il modello OSI non ha fatto molta strada per vari motivi:
- Molte infrastrutture usavano già il modello TCP-IP e fare un cambio avrebbe comportato troppi costi.
- Per alcuni livelli è stata fornita poca documentazione e quindi non sono mai stati creati software appositi
- Non furono mai state dimostrate delle prestazioni così migliori da convincere le aziende a sostituire il TCP-IP

---

Pezzo storia internet, misà non si mette 😼

---

# Modello TCP-IP
Introduciamo il livello di applicazione, qui troviamo applicazioni come server web e HTTP, oppure anche server di posta elettronica con SMTP, POP3 o anche server DNS.

Questo livello serve ad offrire dei servizi agli utenti finali.

La comunicazione viene eseguita sempre tramite collegamenti logici, quindi i due livelli applicazione che comunicano penseranno di star parlando tramite un canale unico.

---

I protocolli usati ormai sono veramente tanti dato che anche la flessibilità della rete permette di aggiungerne sempre di nuovi con molta facilità. Possiamo individuare:

- Protocolli Standard - Sono diversi protocolli standardizzati e documentati dagli enti responsabili della gestione Internet. Ognuno di questi protocolli è costituito da una coppia di programmi che interagiscono con l'utente e con il livello di trasporto per offrire un servizio. Troviamo ad esempio applicazioni web con protocollo HTTP.
- Protocolli non standard - È possibile scrivere applicazioni non standard scrivendo due programmi che forniscono servizi agli utenti facendo uso dei servizi di trasporto. in questo caso non serve  chiedere autorizzazioni dato che ogni azienda può sviluppare il proprio software che utilizza il proprio protocollo di comunicazione.

## Creare applicazioni di Rete
Dobbiamo scrivere programmi in grado di girare su sistemi diversi e che comunichino attraverso la rete.

Se vogliamo crearne una dobbiamo porci delle domande:
- Che tipo di architettura si vuole creare? Vogliamo un'app client-server o peer-to-peer?
- Come comunicano i processi dell'applicazione?
- Che tipo di servizi di rete richiede l'applicazione? Abbiamo bisogno di più banda o di più sicurezza?
- I due programmi devono essere entrambi in grado di richiedere ed offrire servizi? Oppure ciascuno ha un solo compito?

### Paradigma Client - Server
Troviamo due entità:
- Client - È il componente che richiede il servizio, può essercene più di uno e vanno in esecuzione soltanto quando richiesto.
- Server - È quello che offre i servizi, è quindi sempre in esecuzione in attesa di richieste.

In questo caso quindi il ruolo delle due entità è ben distinto e una non può svolgere il ruolo dell'altra.

> [!info] Svantaggi
> Abbiamo bisogno di un server molto potente dato che è lui che gestirà tutto il carico di lavoro e per avere dei server potenti abbiamo bisogno di server farm costose.


