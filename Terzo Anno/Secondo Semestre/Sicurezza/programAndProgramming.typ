#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= Programs And Programming
Vediamo i problemi di sicurezza legati alla programmazione, per prima cosa diamo delle definizioni:
- *Error*: Un errore umano compiuto da uno sviluppatore
- *Fault*: Un passaggio, un comando, un processo o definizione di dati scorretti all'interno di un programma.
- *Failure*: Quando il comportamento del sistema non rispetta i requisti richiesti.
- *Flaw*: Indica un'omissione non intenzionale di controlli da effettuare.

I difetti di un programma possono causare un *fallimento di integrità* andando ad intaccare non solo la correttezza ma anche l'accuratezza e la consistenza dei dati.

Un difetto nato per cause innocue come un semplice errore di distrazione può trasformarsi in una vulnerabilità se un malintenzionato scopre come sfruttarlo per manipolare il comportamento del programma.
Tra le falle più comuni troviamo: *Buffer Overflow, Incomplete Mediation, TOCTTOU, Backdoor, Race Condition, ecc...*

== Buffer Overflow
Si verifica quando un programma tenta di memorizzare dati che eccedono lo spazio per-allocato per il buffer, nonostante sia un problema noto da molti anni è diffusissimo ancora oggi.

Vediamo come funziona fissando alcuni concetti:
- *Data as Code*: Per il processore, codice e dati non sono altro che sequenze di bit in memoria. Un attaccante sfrutta questo concetto causando un overflow dei dati nello spazio di memoria adiacente andando ad immettere in queste regioni dei dati specifici li renderemo delle istruzioni valide per il processore.
- *Gestione dello Stack*: Quando una funzione ne chiama un'altra tutti i suoi parametri, indirizzi di ritorno e vecchio puntatore dello stack vengono salvati nello stack, se un utente malintenzionato causa un overflow sullo stack può sovrascrivere il vecchio puntatore o l'indirizzo di ritorno, in questo modo a fine funzione il programma non tornerà nel punto di prima ma eseguirà del codice dannoso scelto dall'attaccante.
- *Stack Smashing*: Si utilizza l'*Heap* per fare overflow sullo stack. L'heap è l'area di memoria in cui le variabili vengono create e crescono in modo dinamico, se non controllato l'heap può espandersi in maniera anomala finendo per collidere con lo stack e schiacciarlo.

In che modo possiamo combattere lo stack overflow?
- *Contromisure di base*: Controllare sempre le lunghezze dei dati prima di effettuare scritture, confermare i limiti degli array, usare utilità di gestione stringhe sicure e limitare i privilegi assegnati ai programmi.
- *Scelta del linguaggio*: Linguaggio come C e C++ permettono libero accesso alla memoria mentre linguaggi come Java o Python controllano automaticamente i limiti.
- *Tecnica del Canary*: A livello di Sistema Operativo viene applicato un livello protettivo attorno al frame dello stack inserendo un valore esca chiamato _canary_.
Se avviene un overflow che tenta di arrivare all'indirizzo di ritorno o al _program counter_, inevitabilmente sovrascriverà prima il canary. Il codice di terminazione della procedura controllerà questo valore e se è stato modificato fermerà l'esecuzione.
Questo funziona finché l'attaccante non sa come falsificare anche quel valore.

== Incomplete Mediation
La "mediazione" è l'atto di verificare l'autorizzazione di un soggetto a eseguire un'azione, la falla avviene quando questo controllo non è esaustivo. Un esempio è un sito di e-commerce che usa URL in chiaro per i parametri d'acquisto (_&qy=20&price=10_).
Il server si affida al browser dell'utente per questi dati quindi se l'utente modifica l'URL mettendo _&price=1_ e il backend non convalida questi dati l'attaccante pagherà di meno i prodotti.
Per risolvere questo problema dobbiamo sempre convalidare i dati che riceviamo con quelli che abbiamo nel nostro database.

== Time-of-Check to Time-of-Use - TOCTTOU
Sfrutta l'intervallo di tempo tra il momento in cui un sistema controlla un'autorizzazione e il momento in cui usa effettivamente il file, è noto anche come *Bait and Switch*.
Un esempio non nel mondo dell'informatica è quando un malintenzionato mette sul banco dei soldi per pagare e mentre il cassiere è distratto tu togli delle monete, il cassiere convinto ancora che ci siano i soldi di prima li prende e viene truffato.
Come contromisura dobbiamo implementare una *integrità seriale* ovvero senza interruzioni tra il check e l'utilizzo, oppure copiare i dati dell'utente in un'area sicura dell'OS ed eseguire la validazione direttamente sulla copia, in questo modo l'utente non potrà modificarli in corso d'opera.

== Undocumented Access Point / Backdoor
Durante lo sviluppo software gli sviluppatore lasciano spesso delle "porte di servizio" o modalità di esecuzione veloci per testare il software che non passano per i controlli di sicurezza.
Il problema nasce quando si scordano di rimuoverle nella versione in produzione, questo sono molto pericoloso dato che *non sono documentate* e di conseguenza non appaiono in nessun manuale o specifica di sistema e passano inosservate anche a chi esegue revisioni tecniche.
Queste possono anche venir lasciate da utenti malintenzionati dopo aver eseguito un attacco e ottenuto accesso alla macchina.

== Race Condition
É un difetto di sincronizzazione e si verifica quando l'esito di un programma dipende dalla sequenza temporale con cui vengono eseguiti due o più processi che competono verso la stessa risorsa.
- É un problema difficile da rilevare perchè il bug non è costante e si manifesta in base al carico del sistema, alla memoria occupata e alla priorità in quel preciso istante.
- Un esempio classico è il sistema di prenotazione, se non ci sono meccanismi di "lock" due utenti possono vedere lo stesso posto come disponibile in contemporanea e prenotarlo simultaneamente andando a creare conflitti.
Questo causa un *fallimento di integrità*.