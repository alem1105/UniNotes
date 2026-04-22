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
