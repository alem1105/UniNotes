#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= Internet Security
In questo capitolo ci si concentra sui pericoli con cui puó scontrarsi un utente su internet.
Iniziamo vedendo le criticitá dei browsers ovvero i software che permettono agli utenti di collegarsi ad internet, di base questi devono:
- Collegarsi a degli indirizzi web
- Ricevere i contenuti da mostrare
- Trasmettere eventuali dati dell'utente all'indirizzo

Giá da questi tre punti possiamo osservare diverse possibili criticità:
- Un browser spesso si connette anche ad altri indirizzi oltre a quello indicato nella barra di navigazione
- Il software del browser puó essere corrotto per eseguire azioni malevole
- Alcuni browser permettono l'installazione di estensioni di cui non possiamo fidarci al 100%.
- Altro...

Con altri tipi di programmi è possibile limitare i file a cui hanno accesso o togliere l'accesso ad internet esterno, queste limitazioni non sono applicabili ad un browser e, anche per questo, è uno dei principali vettori di attacco dove vengono anche scoperte molte vulnerabilità.

== Browser Attacks
Ci sono 3 principali modi per attaccare un browser:
- Modificare il sistema operativo in modo da compromettere il corretto funzionamento del browser.
- Modificare il browser o uno dei suoi componenti per alterarne il comportamento.
- Intercettare e/o modificare le comunicazioni da e verso il browser.

=== Man-in-the-Browser
In questo tipo di attacco si utilizza del codice per infettare il browser, questo codice puó leggere, copiare e condividere tutto quello che l'utente inserisce nel browser. Il pericolo qui é che l'attaccante puó recuperare le credenziali dell'utente, dati bancari o altre informazioni sensibili.
Uno dei più famosi è stato il *Silent Banker* nel 2008 dove questo trojan era presente in alcuni browser come "componente aggiuntivo" e quando rilevava che il browser era collegato a determinati siti bancari iniziava a registrare tutti gli input dell'utente e inviarli all'attaccante. Nemmeno la crittografia poteva proteggere i dati perché questi venivano intercettati prima di essere crittografati.
Inoltre, SilentBanker oltre a rubare i dati modificava anche le azioni compiute dall'utente, se ad esempio veniva effettuato un bonifico alla banca A allora il trojan modificava l'operazione per effettuare un bonifico alla banca B, dove magari era ospitato un conto dell'attaccante.

=== Keystroke Logger
Ha una funzione simile all'attacco di prima infatti non registra soltanto i tasti inseriti nel browser ma in tutto il sistema, per farlo però c'è bisogno di un dispositivo USB esterno inserito nel PC.

=== Page-in-the-Middle
In questo caso non viene alterato il browser ma la pagina web, questa potrebbe presentare ad esempio delle finte schermate di login per inviare i dati agli attaccanti.

=== Program Download Substitution
Si effettua insieme al page in the middle, infatti viene sotituito il link di download di un software con del software malevolo.

=== User-in-the-Middle
Molti siti si difendono dai bot utilizzando i CAPTCHA, dei piccoli test che i bot non sono in grado di risolvere.
Degli attaccanti magari vogliono un "esercito" di bot per acquistare biglietti o altro ma non possono mandare liberamente i loro bot per via dei captcha, allora creano dei siti che non riguardano l'attacco vero e proprio, magari per distribuire software o risorse gratuite e i bot, in automatico, inoltrano le foto dei captcha su questi siti per farle risolvere agli utenti ed inoltrare le risposte ai siti originali.
In questo modo l'utente umano crede di aver risolto il captcha per scaricare il software ma in realtà ha aiutato l'attaccante.
Per risolvere questi problemi i browser si sono spostati su tecnologie più nuove come i CAPTCHAv3 che non osservano più la risposta ma come l'utente si comporta.

== How Browser Attacks Succeed
La falla principali degli attacchi visti sopra è l'autenticazione non corretta, se _A_ non può assicurarsi che il mittente del messaggio sia veramente _B_ allora _A_ non può fidarsi dell'autenticità di nulla all'interno del messaggio.

Ci sono diversi punti possono portare ad una mancanta autenticazione:
- *Usability and Accuracy* possono andare in conflitto, un sistema più usabile potrebbe essere meno preciso ma gli utenti vogliono un sistema semplice.
- *Computer-to-computer interaction allows limited bases for authentication*. Computer Authentication è basata su qualcosa che il computer "conosce", questo significa che è memorizzata in qualche dato computabile, questi dati possono essere trovati da processi non autorizzati e calcolati anche da altri computer.
- *Malicious software can undermine authentication by eavesdropping* authentication data.

=== Successful Identification and Authentication
Ci sono, però, diversi modi per garantire un'identificazione ed un'autenticazione avvenute con successo.

*Shared Secret* - È un qualcosa che soltanto le due entità che si scambiano i messaggi dovrebbero conoscere, nessun altro che si intromette nella comunicazione deve saperlo.

*One-Time Password* - Sono dei codici validi una sola volta e che durano per un determinato periodo di tempo.

*Out-of-Band Communication* - Si tratta dell'autenticazione a due fattori (2FA) ovvero spezzare l'autenticazione in più mezzi diversi.

== Web Attacks Targeting Users
_(Gran parte di questi stanno descritti già prima non capisco come è organizzato sto libro di merda_ :D)
La prima categoria di attacchi riguarda i contenuti falsi mentre la seconda vuole danneggiare l'utente.

=== False or Misleading Content
L'attacco più semplice è il *Defaced Web Site* ovvero quando un attaccante rimpiazza o modifica il contenuto di una pagina web legittima.
Spesso l'obiettivo di questi attacchi è soltanto quello di "ridicolizzare" la vittima o mostrare le loro debolezze in campo di sicurezza, ad esempio mettendo messaggi di prese in giro nella pagina per mostrare che si è riusciti a bucare il sito.

=== Fake Web Site
Uguale a prima praticamente (?)

=== Fake Code
Si tratta di creare e distribuire software malevolo ma che compie anche le azioni che si aspetta l'utente.

==== Protecting Web Sites Against Change
Esistono diversi modi, oltre alla crittografia che qui non è adatta, per proteggere i siti web.

===== Integrity Checksums
È una funzione matematica che riduce un blocco di dati in un piccolo numero di bits. Cambiare, anche di poco, il blocco in input fa variare di molto il risultato rendendo praticamente impossibile cambiare i dati in modo che il risultato sia uguale a quello dei dati originali.
Utilizzando un checksum ci assicuriamo che i cambianti sul sito cambino anche il valore del checksum.

===== Signed Code or Data
Utilizzare un integrity checker aiuta l'amministratore del sito a verificare che i dati sono intatti, inoltre firmare il codice con un certificato da una CA garantisce integrità e autenticazione della fonte.
Bisogna fare attenzione però perché anche un'azienda malintenzionata può ricevere un certificato valido e distribuire quindi codice.

=== Web Bug
Si tratta di sfruttare un'immagine minuscola, spesso una GIF 1x1 trasparente invisibile all'utente per tracciare la sua navigazione e inviare i dati all'attaccante, nello specifico l'attaccante può sapere, ad esempio, se hai aperto la mail contente questa foto e sapere quindi che la tua casella di posta è attiva.

== Furto di Dati: Scripting e SQL Injection
Questi attacchi colpiscono la logica delle applicazioni web sfruttando le vulnerabilità nella validazione dell'input dell'utente.

- *Cross-Site Scripting (XSS)*: Sfruttano il fatto che le comunicazioni HTTP trasmettono in chiaro script incorporati, in questo modo costringono il browser o il server ad eseguire codice malevolo mascherato da contenuto legittimo. Un esempio è l'inserimento di uno script malevolo nei commenti di un blog, chiunque carichi quella pagina eseguirà lo script senza accorgersene.

- *SQL Injection (SQLi)*: Sfrutta la scarsa sanitizzazione degli input per inviare comandi SQL direttamente al database backend. L'attacco interrompe prematuramente la stringa attesa dal database utilizzando il singolo apice `'` e aggiunge un nuovo comando, inserisce poi alla fine il simbolo del commento per omettere tutto il resto del codice legittimo.
  - *Inband Attacks*: Sfruttano lo stesso canale di comunicazione per iniettare l'attacco e ricevere i risultati, mostrandoli direttamente sulla pagina web.
  Questi comprendono tecniche di *tautology* ovvero che inseriscono una condizione sempre vera come `OR 1=1` per aggirare l'atuenticazione e le *Query Piggybacked* ovvero accodare una query distruttiva come `DROP table` a una query legittima.
  - *Inferential Attacks (Blind SQLi)*: Non c'è alcun trasferimento visibile di dati, l'attaccante inietta query specifiche e ricostruisce la struttura e il contenuto del database osservando i comportamenti del sistema o gli errori logici raccogliendo informazioni per futuri attacchi.
  - *Out-of-Band Attacks*: Utilizzati quando le informazioni non possono tornare indietro via HTTP ma il database possiede connettività in uscita vulnerabile per inviare i dati tramite altri canali.

La *contromisura principale* è la *sanitizzazione dell'input* che rimuove o codifica caratteri pericolosi prima di elaborarli, e il rigoroso controllo degli accessi sul server backend per limitare l'estrazione dei dati.

== Sicurezza delle Applicazioni Mobile (App)
A differenza dei siti web, le app risiedono fisicamente sul dispositivo ed interagiscono in profondità con hardware e software, inoltre *funzionano continuamente in background* e spesso raccolgono e trasmettono tanti dati senza dirlo all'utente.

Le vulnerabilità delle app derivano dal fatto che ci sono tantissimi utenti da sfruttare e l'architettura stessa di queste, l'utente infatti non sa cosa fanno realmente e possono ottenere privilegi enormi agendo come da _spyware_ esportando tantissimi dati non necessari al loro funzionamento.
Tra i problemi più comuni troviamo:
- *Insecure Direct Object References*: Le app non dovrebbero esporre la struttura interna delle risorse ma agire da intermediario traducendo i comandi dell'utente.
- *Mancanza di Logging e Monitoring*: L'app è l'unico ponte tra utente e risorse, se fallisce nel registrare e generare allarmi per attività sospette, blocca l'indagine sulla compromissione dei dati.
- *Problemi di Crittografia*: Un'errata gestione o memorizzazione delle chiavi crittografiche o il mancato utilizzo di funzioni di hashing per verificare l'integrità dei dati.
- *Componenti vulnerabili o non aggiornati*: Molte app si basano su librerie di terze parti, se una di queste è vulnerabile l'app diventa vulnerabile, o almeno finché lo sviluppatore non la aggiorna.
- *Errori di configurazione*: Mantenere la password predefinita o esporre informazioni involontariamente.

È necessario quindi che li sviluppatori implementino rigidi controlli automatizzati e utilizzino sistemi per l'analisi statica e strumenti di _Interactive Application Security Testing (IAST)_ per individuare i difetti durante l'esecuzione.

== Attacchi tramite Email e Messaggi
L'indirizzo email del mittente è facilmente falsificabile e gli attaccanti sanno che le persone riconoscono le mail false ma puntano sui grandi numeri, inviando milioni di mail basta una minima percentuale di vittime per generare profitti.

È importante utilizzare *Crittografia PGP (Pretty Good Privacy)* per garantire confidenzialità, integrità e autenticazione nelle comunicazioni.
- *Confidenzialità*: Il sistema genere una chiave di sessione casuale simmetrica per cifrare il corpo del messaggio, poi la chiave di sessione viene cifrata utilizzando la chiave pubblica del destinatario e viene allegata al messaggio.
- *Integrità e Autenticazione*: Viene creato un hash del messaggio che viene firmato cifrandolo con la chiave privata del mittente.
- *Distribuzione delle chiavi*: Si basa su certificati convalidati gerarchicamente (formato X.509) permettendo a mittente e destinatario di scambiarsi informazioni in sicurezza senza doversi scambiare materialmente le chiavi in anticipo, purché condividano un'autorità di certificazione (CA) fidata.