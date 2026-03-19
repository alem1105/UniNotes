#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= User Authentication
Il processo di autenticazione per gli utenti avviene in due step:
- *Identification*: Identificare la persona
- *Authentication*: Provare che questa persona è realmente chi dice di essere.
Ovviamente utilizziamo il termine persona ma questa potrebbe tranquillamente essere un altro sistema.

L'autenticazione può basarsi su:
- *Something the individual knows*: Ad esempio una password, risposte a delle domande o un PIN
- *Something the individual possesses*: Chiavi elettroniche, smart cards, ci si riferisce a questi strumenti come _token_
- *Something the individual is*: Dati biometrici come impronta digitale o retina.
- *Something the individual does*: Si basa sempre su dati biometrici ma includono azioni come ad esemmpio parlare, scrivere o il ritmo di scrittura.

== Authentication with something you know
Le password offrono sicurezza nell'autenticazione ma questa viene compromessa dal comportamento umano, le principali difficoltà nel loro utilizzo sono:
- Per garantire la massima sicurezza andrebbe utilizzata una password diversa per ogni "oggetto" al quale accediamo ma è scomodo.
- Se qualcuno di non autorizzato viene a conoscenza della password sarà necessario cambiarla e informare altri utenti autorizzati del cambio avvenuto.
- La password potrebbe andare persa e gli amministratori di sistema dovranno fornirne un'altra.

In alcuni studi hanno indicato i 12 step che, di solito, un attaccante usa per violare una password:
- Inserire una password vuota
- Password uguale allo user ID
- Se è derivata dal nome dell'utente
- Contenuta in un piccolo dizionario di password
- Contenuta in un dizionario completo Inglese
- Contenuta in un dizionario non inglese
- Contenuta in un dizionario inglese considerando anche lettere grandi o sostituzioni con numeri, ad esempio O-0, E-3...
- Ottenuta tramite brute force con tutte le combinazioni alfanumeriche
- Ottenuta tramite brute force con tutte le combinazioni dal set di caratteri completo.

Il principali ostacolo è quello del tempo richiesto per indovinare la password, infatti qualsiasi password può essere indovinata e quello che ci protegge è il numero di tentativi richiesti.

I principali attacchi alle password sono:
- *Dictionary Attack*: Sono delle raccolte di parole e frasi provenienti ad esempio da film, serie TV, mitologia ecc... che spesso vengono utilizzate anche come password. Questi dizionari non vengono soltanti usati da parte degli attaccanti ma anche dagli amministratori di sistema per individuare utenti che inseriscono password deboli.

Per indovinare una password si può provare anche a rimpicciolire il set di possibilità andando ad analizzare l'utente, infatti è molto probabile che una password sia un dato personale come ad esempio il nome di un animale domestico o che derivi da queste informazioni.

Per verifica un utente il sistema operativo controlla che ID e password forniti dall'utente combacino all'interno del suo database, questa tabella potrebbe essere letta da utenti malintenzionati e per questo i sistemi operativi non salvano le password in chiaro ma una versione cifrata di queste.
Quindi quando un utente prova ad autenticarsi il sistema operativo applica la stessa funzione di cifratura all'input e verifica che combaci con quello memorizzato da lui. (non sempre si usa la cifratura ma comunque operazioni simili.) Questo ovviamente non ci protegge da attacchi brute force ma è possibile renderli più difficili ad esempio inserendo un tempo di attesa tra una password e un'altra.

- *Rainbow Table*: Cifrare le password ha comunque una vulnerabilità ovvero che password identiche avranno la stessa password cifrata, quindi se un utente si impossessa di una tabella con password cifrata può comunque capire chi sta utilizzando la stessa password, anche se non sa quale sia.
Per risolvere questo problema si utilizza il *salt* ovvero aggiungere dei dati insieme alla password prima di cifrarla, questi dati possono essere ad esempio il momento di iscrizione o altri dati randomici.

Vediamo adesso come costruire password forti e resistenti anche ad *exhaustive attack* ovvero quando l'attaccante prova tutte le combinazioni possibili:
- Utilizzare anche i numeri oltre alle lettere a-z e usare anche varianti maiuscole, in questo modo portiamo a 62 il set di caratteri disponibili per ogni carattere della password.
- Altra roba ma non credo serva per il corso.

== Authentication Based on Biometrics: Something you are
Qui utilizziamo caratteristiche biometriche dell'utente per autenticarlo, ad esempio:
- Impronta digitale
- Geometria della mano
- Retina
- Voce
- Scrittura
- Riconoscimento facciale

Uno dei vantaggi rispetto alle password è che i dati biometrici non possono essere persi, rubati, dimenticati e sono sempre disponibili.
Questi però presentano anche alcuni difetti:
- Sono molto invasivi e non tutti sono d'accordo sul condividere questo tipo di dati.
- Hanno costi di implementazione molto alti.
- Possono diventare un _single point of failure_, infatti con le password se questa viene dimenticata o altro possiamo cambiarla o resetterla ma questo non avviene per i dati biometrici, se il sensore legge male le impronte allora l'utente rimane bloccato.
- Tutti i sensori implementano dei _threshold_ per l'accettazione dei dati e anche funzionalità per riconoscere volti o altro anche se questi sono inclinati o altre variazioni.
- Possono verificarsi _falsi positivi_ ovvero quando un utente viene accettato quando non dovrebbe e _falsi negativi_ ovvero quando un utente viene rifiutato quando non dovrebbe. Spesso ridurre i falsi positivi porta ad un aumento dei falsi negativi e viceversa.
Un sistema dobrebbe avere un rate di falsi positivi dello 0.001% e un rate di falsi negativi dell'1%.
Anche queste piccole percentuali se usate con tantissimi utente potrebbero però portare a problemi.

I test di screening devono essere in grado di valutare il grado di efficacia dei loro _matching_, devono quindi poter determinare se stiano identificando efficacemente le persone ricercate senza danneggiare coloro che non lo sono. Quando un sistema confronta un dato in suo possesso con un dato che sta misurando sta effettuando quello che chiamiamo _dichotomus test_: o c'è un match o non c'è.
Possiamo descrivere questo test usando un Reference Standard, lo standard di riferimento è l'insieme di regole che determina quando un test positivo corrisponde a un risultato positivo. L'obiettivo è evitare due tipi di errori: i falsi positivi e i falsi negativi.

Possiamo misurare il successo dell'analisi usando 4 misure standard: *sensitivity, prevalence, accuracy e specificity*, per vedere come funzionano assegnamo delle variabili ai match in questo modo:

#align(center, image("/assets/image-46-1.png", width: 80%))

- Sensitivity: È il grado di sensibilità con il quale il sensore fa match o no. Rappresenta la proporzione di risultati positivi tra tutti i possibili match corretti e si calcola come: $ a / (a+c) $
- Specificity: Misura la proporzione di risultati negativi fra tutte le persone non ricercate in quel momento, si calcola come: $ d / (b+d) $
- Accuracy: Misura la sensibilità con la quale il test identifica correttamente le analisi, si misura come: $ (a+d) / (a+b+c+d) $
- Prevalence: Misura quanto è comune una certa condizione, si misura come: $ (a+c) / (a+b+c+d) $

Sensitivity e specificity sono inversamente proporzionali, se una sale allora l'altra scende, per questo infatti non possiamo semplicemente dire che vogliamo rimuovere i falsi positivi, questo porterebbe ad un aumento dei falsi negativi, va trovato il giusto bilanciamento fra i due.
Per aiutarci calcoliamo il _positive predictive value_ del test, un numero che ci dice quante volte un match positivo rappresenta effettivamente l'autenticazione della persone cercata in quel momento. Questo si calcola come: $ a / (a+b) $

Con lo stesso ragionamento possiamo calcolare il _negative predictive value_ come: $ d/(c+d) $

Il *receiver operating characteristic (ROC) curve* è una rappresentazione grafica del trade-off tra falsi negativi e falsi positivi, di base questo mostra il rate di falsi positivi (1 - specificity) sull'asse delle _x_ e il rate dei veri positivi (sensitivity oppure 1 - rate dei falsi negativi) sull'asse _y_.
Vogliamo cercare di rimanere il più a sinistra e il più in alto possibile, questo significa avere tanti veri positivi e un basso rate di falsi positivi. Nel grafico più l'area sotto la curva è grande più avviene quello scritto prima:

#align(center, image("/assets/image-47-1.png", width: 80%))

L'amministratore di sistema, in base all'utilizzo che verrà fatto di questo test deciderà il giusto compromesso tra i due valori.

== Authentication Based on Tokens: Something you have
Si basa appunti su degli oggetti che possediamo, possiamo dividere i token in:
- *Token passivi*: Sono semplici oggetti che non fanno nulla, foto è un esempio di token passivo che appunto contiene un'informazione che non cambia mai.
- *Token attivi*: Possono cambiare o anche interagire con l'ambiente, ad esempio un abbonamento elettronico per il trasporto pubblico che va usato sui tornelli.

Un'altra differenza è:
- *Static token*: I dati che contengono rimangono fissi. Questi sono deboli ad un tipo di attacco chiamato *skimming* ovvero utilizzare un dispositivo per copiare i dati di autenticazione del token ed inviarli all'attaccante.
- *Dynamic Token*: I dati cambiano nel tempo, ad esempio esistono dei dispositivi che generano dei codici a intervalli di tempo e questi codici vanno utilizzati per effettuare il login. Questo tipo di token elimina il problema dello skimming.

== Federated Identity Management (FIM)
È l'unione di diversi sistemi di autenticazione e identificazione, invece di mantenere diversi profili utente questi sistemi mantengono un singolo profilo con un solo metodo di autenticazione e i sistemi collegati a questo sistema non richiederanno autenticazione.

#align(center, image("/assets/image-48.png", width: 80%))

Ad esempio lo SPID fa parte di questi sistemi.

Un approccio simile invece è quello del *Single Sign On* questo permette ad un utente di accedere a diversi servizi utilizzando un solo set di credenziali, una volta loggati il sistema si "fida" e possiamo accedere a tutti i servizi collegati. Ad esempio quando facciamo il login con Google / Apple.

Infine troviamo la *multifactori authentication* che combina più autenticazioni prima di dare l'accesso all'utente. Esempio classico è quando facciamo login con email e password ma poi ci viene chiesto un codice inviato sul nostro telefono.
Sicuramente avere più fattori di autenticazione aiuta la sicurezza ma più che il numero di questo, quello che protegge è la sicurezza dei sistemi adottati. Possiamo avere anche un'autenticazione a 100 fattori ma se sono tutti uguali e deboli sono più inutili di un singolo fattore più sicuro.

== Authentication Security Issues
- *Client Attack*: L'attaccante fa finta di essere un utente autorizzato, cerca di ottenere i dati senza accedere all'host.
- *Host Attack*: È un attacco ai file dell'host dove sono memorizzati i dati di login degli utenti come ad esempio le password.
- *Eavesdropping Attack*: Un attaccante cerca di ottenere la password "studiando" l'utente
- *Trojan Horse Attack*: Un software o un dispositivo mascherato da applicazione autorizzata che in realtà ha lo scopo di rubare dati sensibili come password.
- *Replay Attack*: Un attaccante cattura la richiesta di un utente e la ripete.
- *Denial of Service Attack*: Disabilitare i sistemi andandoli a sovracaricare di richieste, ad esempio mandare offline il sistema di autenticazione con migliaia di richieste.