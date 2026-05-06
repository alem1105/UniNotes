#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= Access Control
Sono le regole che ci permettono di dare determinati poteri agli utenti: _A *subject* is permitted to access an *object* in a particular *mode* and only such authorized accesses are allowed_.

Notiamo quindi che l'access control si basa su 3 elementi principali:
- *Object*: Una risosa sulla quale dobbiamo fare access control, di solito sono entità che vengono usate per ricevere ed inviare informazioni.
- *Subject*: Un'entità in grado di accedere agli oggetti
- *Access Mode*: Descrive in che modo il subject può accedere ad un oggetto (scrittura, lettura, esecuzione...)

== Access Policies (AP)
Guidano l'implementazione dei meccanismi di access control. Quindi si parte da un'idea (l'access policy) su quali accessi dovrebbero essere approvati e in quali circostanze e poi si implementa il meccanismo di access control sul sistema, spesso tramite una tabella.

Proteggere gli objects prevede anche altri obiettivi complementari:
- _Check every access right periodically_: I privilegi degli utenti cambiano nel tempo e in futuro potrebbe essere possibile che ad un utente vadano rimossi dei permessi o aggiunti di nuovi.
- _Enforce least privilege_: Il principio del *least privilege* prevede che un subject abbia accesso al più piccolo numero di object necessari per svolgere i suoi tasks.
- _Verify Acceptable Usage_: Anche se a un utente vengono garantiti dei permessi è importante che utilizzi bene quest'ultimi, ad esempio la navigazione su internet.

Ma implementare una corretta policy non significa aver terminato il lavoro, spesso queste vanno riviste o comunque controllate per vedere se stanno lavorando come previsto, magari ualche utente ha memorizzati tanti accessi a cose di cui ormai non ha più bisogno. Questo si chiama *tracking*.

Un altro concetto importante è la *granularity*, ovvero quanto vogliamo "accurato" il nostro access control.
Più è alta la granularity e quindi più è alto il controllo che abbiamo sui file più sarà alto il numero di decisioni da fare e quindi abbasseremo anche le performance.
Tipicamente un file, un programma o dei dati sono l'unità più piccola che si considera per l'access control.

Per un amministratore è importante vedere cosa hanno fatto gli utenti, è per questo che si utilizza l'*access log*, chiamato anche *audit log*.
Ci sono vari motivi per cui è importante effettuare analisi sui log di questo tipo:
- Aiutano a vedere quali risorse sono utilizzate di più e quindi quali hanno bisogno di upgrade.
- Se il sistema crasha, i record possono mostrare quali accessi erano in corso e aiutare a identificare la causa del crash.
- Se un utente utilizza in modo scorretto delle risorse possiamo vederlo.
- Se subiamo un attacco informatico i log possono aiutarci a vedere da dove gli attaccanti sono entrati nella rete e a quali dati hanno avuto accesso.

Ultimo passo è il *limited privilege* ovvero restringere i poteri di utenti e processi in modo che i danni che possono causare sono limitati.
Ovviamente non possiamo limitare al massimo gli utenti ma nemmeno lasciargli completa libertà, quello che cerchiamo è quindi il giusto compromesso fra i due.

== Implementing Access Control
Spesso viene implementato dal Sistema Operativo stesso ad esempio proteggendo i file necessari a lui per funzionare, le funzionalità offerte dal sistema operativo però non bastano quindi l'AC viene implementato o dall'applicazione o dalla rete.

#showybox(
  frame: (
    border-color: green.lighten(60%),
    title-color: green.lighten(60%),
    body-color: green.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Reference Monitor*],
  [
    L'Access Control dipende da una combinazione di hardware e software che deve essere:
    - Sempre disponibile in modo da poter validare ogni tentativo di accesso.
    - Immune alle manomissioni.
    - Corretta.

    Il Reference Monitor non è uno strumento plug and play ma un concetto e per renderlo efficace dobbiamo convertire in modo giusto le AC policies.
  ]
)

Adesso vediamo diversi modelli per gestire l'AC sfruttando anche il reference monitor.

=== Access Control Directory
Immaginiamo di dover proteggere dei files da degli utenti di un sistema, ogni file ha un proprietario che ha il controllo sul file, ogni utente ha una file directory che elenca tutti i file a cui l'utente ha accesso.

Ovviamente nessun utente ha accesso in scrittura sulla file directory, è quindi compito del sistema operativo quello di gestirle tutte in base ai comandi che riceve dai possessori dei file.

_Esempio_

#align(center, image("/assets/image-46.png", width: 80%))

Un vantaggio di questo sistema è sicuramente la facile implementazione, infatti dobbiamo soltanto fare una lista per ogni utente in base a cosa può accedere.
Ci sono anche diversi contro però:
- La lista potrebbe avere dimensioni enormi se abbiamo tantissimi file.
- Revocare gli accessi è costoso se un utente A vuole rimuovere accesso a tutti gli utenti, inoltre se A da un permesso a B e B lo trasferisce a C allora A non sa niente di questo trasferimento. *propagation of access rights problem*.
- Gli pseudonimi sono un problema. Se A possiede F e anche B possiede un file chiamato F ed entrambi danno accesso a C su questo file allora bisogna tenere traccia di due files diversi per C.
- Rinominare un file è un problema perchè si potrebbero creare inconsistenze nei permessi.

=== Access Control Matrix
È una tabella dove sulle righe abbiamo gli utenti mentre sulle colonne le risorse a cui devono accedere, all'interno delle celle abbiamo i poteri corrispondenti, ad esempio:

#align(center, image("/assets/image-47.png", width: 50%))

Questa implementazione viene usata raramente dato che cercare i permessi all'interno di questa struttura è spesso inefficiente.

=== Access Control List
Questa rappresentazione corrisponde alle colonne della Control Matrix, c'è una lista per ogni oggetto e questa mostra per tutti gli utenti quali permessi hanno su quel file:

#align(center, image("/assets/image-49.png", width: 50%))

Anche se sembra simile, in realtà è molto diverso dalla directory list, qui infatti abbiamo una access control list per oggetto che porta molti vantaggi.
Ad esempio possiamo implementare dei permessi di default all'interno della access control list del file senza senza andare a creare una entry per ogni utente (ad esempio per file pubblici.) 

In questa struttura è inoltre permesso l'utilizzo delle wildcards ('\*') ovvero un "segnaposto" che sta a indicare "tutti gli utenti" o comunque la categoria in cui viene messa, ad esempio in Linux abbiamo la divisioni in permessi per utente-gruppo-world.
Quando le liste vengono ordinate prima appariranno tutti i record con dei nomi validi e poi le wildcard, in questo modo non andiamo a perdere i match.

=== Priviledge List
Questa invece è una riga della access matrix che mostra quindi tutti i privilegi di un utente, un vantaggio di questa implementazione è la facilità nel rimuovere i permessi, se un utente viene rimosso dal sistema allora la privilege list che mostra a quali oggetti ha accesso può essere rimossa dall'oggetto.

== Capability (non ho capito molto dal libro / slide)
Abbiamo visto soltanto implementazioni che lasciano tutto il lavoro e la responsabilità al sistema, possiamo lasciare del lavoro anche all'utente ad esempio fornendogli un ticket o un pass necessario ad effettuare l'accesso.
Definiamo come *capability* un token non falsificabile che fornisce al suo possessore dei permessi su un oggetto.
La rappresntiamo come una tripla di soggetto, oggetto e permessi

#align(center, image("/assets/image-50.png", width: 50%))

Come rendiamo il token non falsificabile?
1) Fornirlo direttamente al SO o al meccanismo di AC e non all'utente:
- Il SO mantiene tutti i token per gli utenti
- Il SO ritorna all'utente una sua struttura interna che è collegata all'utente
- Può essere creato solo da una specifica richiesta dall'utente al sistema operativo e ciascuno di questi identifica un accesso.
2) Tramite cifratura con una chiave disponibile soltanto al SO o al sistema di AC.

Tramite la capability introduciamo il transferimento o la propagazione dei permessi.
Un utente con permessi di propagazione può passare copie di capabilities ad altri utenti. Ad esempio l'utente A può passare la copia di una capability a B che poi può passarla a C. B può prevenire ulteriori propagazione omettendo il permesso di propagazione alla copia che sta passando a C.

Come funziona invece per la revoca dei permessi?

Quando un utente toglie una capability non devono essere permessi ulteriori accessi con quella capability, una tabella dovrebbe contenere puntatori alle capabilities attive nate da questa revocata in modo che il SO può tracciarle e vedere quali accessi eliminare.

== Domain
È la collezione di oggetti ai quali i processi hanno accesso:
- La collezione di capabilities degli oggetti nel dominio definiscono il dominio.
I processi però vengono eseguiti per gli utenti e il dominio per un utente include programmi, files, dati e dispositivi di I/O.

#align(center, image("/assets/image-51.png", width: 50%))

Il dominio di una sottoprocedura non è per forza lo stesso di chi l'ha chiamata:
- La chiamante potrebbe passare soltanto alcuni oggetti al dominio della sottoprocedura
- La sottoprocedura potrebbe avere permessi diversi e quindi non poter accedere a tutti gli oggetti della chiamante.
- La chiamante potrebbe passare non tutti i suoi permessi di accesso.

== Capabilities at Work
Le capabilities sono un ottimo metodo per tenere traccia degli accessi da parte degli utenti durante l'esecuzione:
- Le capabilities richiedono l'utilizzo delle ACL o ACM
- La capability per un oggetto viene creata a runtime, ogni volta che un processo vuole utilizzare un nuovo oggetto il SO esamina la lista e determina se questo è accessibile, se si, crea la capability per quell'oggetto.

Le capabilities vanno salvate in zone di memoria non accessibie ai normali utenti.

== Procedure Oriented Access Control
Le procedure garantiscono che l'accesso agli oggetti siano effettuati tramite un'interfaccia sicura, ad esempio nessun utente e nemmeno il sistema operativo dovrebbero avere accesso diretto alla tabella degli utenti, l'unico accesso garantito dovrebbe essere quello attraverso le tre procedure di: aggiunta utente, cancellazione utente e verifica utente.
Ognuna di queste procedure avrà i suoi controlli per verificare che la chiamata sia legittima.

== Role-Based Access Control
Invece di basarsi su chi è l'utente, si basa più sul ruolo che copre questo utente, i permessi infatti vengono dati in base al ruolo e non agli utenti specifici.

#align(center, image("/assets/image-52.png", width: 50%))

Ogni ruolo dovrebbe contenere il minimo numero di permessi richiesti da quel ruolo (least privilege).

Per implementare questo meccanismo abbiamo quindi bisogno di una tabella che ci dice per ogni utente a che ruolo o ruoli appartiene e poi una ACM che per ogni ruolo indica quali poteri ha:

#align(center, image("/assets/image-53.png", width: 50%))

Esistono diversi modelli di Role-Based Access Control, ad esempio quello basato sull'ereditarietà:

#align(center, image("/assets/image-54.png", width: 50%))

Questo permette ad un ruolo di ereditare permessi da un altro ruolo.

Oppure ruoli basati sulla sessione, ad utente vengono forniti dei permessi in base a quello che deve fare in quel momento:

#align(center, image("/assets/image-55.png", width: 50%))

== Attribute-Based Access Control
Definisce condizioni sia sugli oggetti che sugli utenti, ad esempio prendiamo una configurazione dove ogni risorsa ha un attributo che identifica il soggetto che l'ha creata, in questo modo una singola regola può indicare il permesso di possesso per tutte le risorse rispetto a tutti i possessori.
Il punto forte dell'ABAC è infatti la flessibilità.

Ci sono 3 elementi chiave nel modello ABAC:
- Attributi
- Policy Model
- Architecture Model

Analizziamoli tutti

=== Attributes
Gli attributi definiscono caratteristiche del soggetto, oggetto o ambiente al quale sono assegnati, esistono infatti diversi tipi:
- *Subject Attributes*: Un soggetto è un'entità attiva, gli attributi in questo caso possono identificare ad esempio il suo ruolo, il dipartimento ecc...
- *Object Attributes*: In questo caso possono indicare ad esempio il tipo di file, il proprietario ecc...
- *Environment Attributes*: Ad esempio dove si trova, il livello di sicurezza della rete ecc...

ABAC verifica il l'accesso agli oggetti considerando le regole su tutti gli attributi.
Quando un utente prova ad accedere ad una risorsa la richiesta viene analizzata da un meccanismo di acccess control.
Questo meccanismo è guidato da delle regole definite dalle policy e basandosi su queste regole il meccanismo definisce gli attributi del soggetto, della risorsa e dell'ambiente per determinare l'autorizzazzione.

#align(center, image("/assets/image-56.png", width: 50%))