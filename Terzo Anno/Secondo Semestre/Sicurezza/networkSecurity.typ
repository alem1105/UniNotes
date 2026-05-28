#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= Network Security

== Interception
Le comunicazioni di rete possono essere intercettate in vari modi a seconda del mezzo trasmissivo utilizzato.
- *Sniffing*: Viene utilizzato con i cavi di rame e consiste nell'installazione di dispositivi appositi, _pachet sniffer_, per catturare i pacchetti su una LAN. Questi dispositivi si inseriscono nella rete attraverso il *Cable Splicing* ovvero il taglio fisico del cavo per inserire lo sniffer oppure l'uso delle radiazioni elettromagnetiche, *radiation*, emesse dal cavo per intercettare il segnale. I cavi in fibra ottica non emettono radiazioni elettromagnetiche e inoltre sono molto difficili da tagliare per inserire dispositivi esterni, questo li rende praticamente immuni agli attacchi precedenti.
- *Microonde*: Questi segnali non sono confinati, li rende facilissimi da intercettare utilizzando dei dispositivi nel raggio di azioni. Per le comunicazioni satellitari (LEO, MEO, GEO) è ancora più semplice visto il loro enorme campo d'azione sulla terra (footprint).

== Network Security Attacks
Le minacce si dividono in 3 categorie principali:
- *Intercettazione*: Perditá di confidenzialità (eavesdropping)
- *Modifica*: Perdità di integrità
- *Denial of Service*

=== Intercettazione

Per quanto riguarda l'intercettazione le principali contromisure sono:
- Cifratura
- Sicurezza Fisica, ovvero la protezione delle linee di comunicazione
- Linee dedicate
- Controlled Routing, assicurarsi che la comunicazione passi solo in determinati nodi

Quali sono invece i motivi che espongono una rete maggiormente a questo pericolo?
- Anonymity: A differenza di intrusioni fisiche, in una rete un attaccante può lanciare un attacco da chilometri di distanza senza mai entrare in contatto con il sistema permettendo quindi a chi intercetta i dati di nascondere la propria identità.
- Più punti di accesso e condivisione risorse: Il principale obiettivo delle reti è quello di condividere le risorse tra tantissimi dispositivi e ogni dispositivo in una rete rappresenta un potenziale punto di accesso.
- Complessità del sistema: Visto che in una rete possono esserci moltissimi dispositivi, tutti completamente diversi fra loro sia in hardware che in software, è molto difficile garantire sicurezza.
- Più percorsi possibili e sconosciuti: Quando inviamo un messaggio non abbiamo alcun controllo dell'instradamento di questo, anche se sappiamo che un host è compromesso non abbiamo modo di evitare che il nostro pacchetto passi per quel nodo.

Per tutti questi motivi la cifratura rimane il metodo principale di sicurezza nelle trasmissioni.

=== Data Corruption

Avviene quando una comunicazione viene modificata durante la trasmissione, può avvenire in più modi:
- Modificare i dati mentre sono sul percorso (Modification Attack)
- Creare nuove comunicazioni (Insertion Attack)
- Ripetere una vecchia comunicazione (Replay Attack)

I due approcci principali ai modification Attacks sono:
- *Sequencing*: Avviene quando un attaccante riesce a far arrivare un frammento di dati più recente prima di un frammento precedente sfasando l'ordine della comunicazione. Anche se il protocollo TCP è progettato per garantire il corretto ordine, le applicazioni non sempre lo sono aprendo la strada a vulnerabilità.
- *Substitution*: Consiste nel prendere un pezzo di comunicazione e inserirlo all'iterno di un'altra. È più semplice da effettuare quando le comunicazioni hanno una formattazione ovvero una struttura rigida.

Per quanto riguarda i reply attack invece, avvengono quando una comunicazione legittima, di solito anche senza nessuna modifica, viene riutilizzata da un attaccante anche senza rompere la cifratura.
Le principali contromisure in questo caso sono:
- Utilizzo di numeri di sequenza in modo che il server accetti soltanto il messaggio più recente

=== Denial of Service
Per interruzione del servizio non intendiamo necessariamente un blocco totale ma anche parziale di solo alcune funzioni. I principali motivi dei blocchi sono:
- Hardware Failures: Qui la difesa principale è la ridondanza dei dispositivi, se uno fallisce deve esserci sempre un backup pronto.
- Routing: I protocolli di instradamento servono a garantire un uso efficiente della rete, se queste regole di routing sono configurate in modo errato o manipolate il traffico non raggiunge più la destinazione.
- Excessive Demand: Sono i classici attacchi DoS, il traffico totale in entrate non è gestibile dal server.
- Guasti introdotti da malware: Alcuni software possono colpire componenti specifici mandando in crash applicazioni o esaurendo le risorse del sistema.

== Port Scanning
Serve ad effettuare una prima "perlustrazione" su un indirizzo IP per vedere quali porte rispondono a delle query per programmare poi i successivi attacchi. Per fare questo si utilizzano i *Port Scanner* come _Nmap_, questo ci fornisce un output simile a questo:

#align(center, image("/assets/image-68.png", width: 50%))

Dove un attaccante può capire: porte aperte, sistema operativo utilizzato, applicazioni esposte con le relative versioni. È inoltre possibile effettuare dei ping sui dispositivi della rete e tramite la latenza capire se si trovano nello stesso segmento o no, una latenza simile significa appunto che i dispositivo molto probabilmente si trovano nello stesso segmento di rete.

I port scanners sono un pericolo quindi?
- In realtà no dato che le porte aperte sono un'informazioni che possiamo ricavare anche senza di questi.

Andrebbero proibiti in qualche modo?
- Sarebbe troppo tardi per implementare delle regole simili dato che un qualsiasi programmatore con una conoscenza dei protocolli di rete potrebbe scriverne uno basico in poco tempo.

Questi non causano problemi di DOS e inoltre possono anche essere utilizzati per amministrazione e aumentare la sicurezza della rete.

== Wireless Security
Le trasmissioni WiFi avvengono tramite *frame*, questi contengono tre campi principali:
- MAC header
- Payload (i dati)
- FCS (una sequenza di controllo)

#align(center, image("/assets/image-69.png", width: 50%))

Il MAC Header contiene dei campi con lunghezza fissa, fra cui:
- Frame Type: Control, Management, Data. Ad esempio per il tipo management possiamo fare 2 distinzioni:
  - _Beacon_: Ogni Access Point manda periodicamente un beacon frame per annunciare la sua presenza nella rete.
  - _Authentication_: Viene mandato quando una scheda di rete vuole interagire con un Access Point, invia appunto un authentication frame con informazioni riguardo la sua identitá. Dopo di questo vengono mandati altri frame dalla NIC per accordarsi con l'AP riguardo i parametri della connessione e la cifratura da utilizzare.
- ToDS, FromDS: Indica la direzione del frame, se va verso l'Access Point o viene da esso.
- Bits per il controllo di sequenza
- WEP (Wired Equivalency Privacy) bit: Encryption, spiegata meglio dopo
- Fino a 4 indirizzi MAC, 2 per mittente e destinatario e altri 2 opzionali per dei punti di filtraggio.

In una rete i vari Access Point si identificano tramite l'*SSID (Service Set Identifier)*, questo viene inviato all'interno dei beacon frame e viene utilizzato appunto dalle NIC per collegarsi. In una determinata area deve essere quindi univoco per ogni AP.

Le principali vulnerabilità WiFi riguardano:
- *Integrtià*: Un attaccante in questo caso non fa in tempo a ricevere, modificare e reinviare un segnle prima che l'originale arrivi a destinazione, però può comunque prendere il controllo della comunicazione andando ad inserire nella comunicazione un segnale radio più forte, le antenne WiFi infatti fra due segnali preferiranno quello più potente.
- *Availability*: Oltre ai classici errori Hardware e Software, la disponibilità WiFi è minacciata anche da eventi atmosferici che causano interferenze e quindi la perdita di pacchetti. Possiamo trovare anche gli hotspot pubblici che si offrono un servizio ma spesso sono molto deboli per quanto riguarda la sicurezza degli utenti.

Vediamo le 3 fasi di accesso ad una rete WiFi e le sue debolezze:
1. L'AP invia un beacon broadcast per annunciare la sua presenza. La minaccia qui è che chiunque può intercettarlo e rispondere.
2. Il client risponde chiedendo l'autenticazione. Spesso l'autenticazione non è rigorosa e l'AP accetta qualsiasi dispositivo lo contatti.
3. Il client chiede di stabilire la connessione. Qualsiasi AP può negoziare e accettare l'associazione.

Altre vulnerabilità strutturali del WiFi si basano sul SSID, o meglio, come la sua gestione comporta dei rischi, possiamo configurarlo in due modi:
- *Open Mode*: L'AP dichiara pubblicamente il suo SSID, chiunque può quindi vedere la rete.
- *Closed Mode*: L'SSID rimane nascosto, in questo caso sono i client che devono inviare dei beacon alla ricerca dell'AP, questo però espone i client, un attaccante potrebbe essere in ascolto e capire quali parametri sono necessari per creare un falso AP e ingannare la vittima.

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
  title: [*Mac Spoofing*],
  [
    Alcuni AP potrebbero consentire direttamente la connessione ad alcuni dispositivi se questi hanno il MAC address incluso in una whitelist. Un attaccante però se conosce almeno uno di questo indirizzi potrebbe cambiare l'indirizzo sul suo dispositivo (Mac Spoofing) e connettersi bypassando i principali sistemi di sicurezza.
  ]
)

Come detto prima il protocollo WEP veniva inizialmente utilizzato ma in realtà è completamente inefficace per garantire privacy e autenticazione:
- *IV Collision*: Il protocollo utilizza chiavi da 64 o 128bit ma i primi 24 sono un vettore di Inizializzazione (IV) trasmesso in chiaro nel pacchetto, questo significa che i bit reali di crittografia sono solamento 40 o 104. Inoltre dato che il vettore ha solo 24bit significa che dopo circa 16milioni di pacchetti genererà obbligatoriamente dei doppioni, questo ciclo crea appunto le IV Collisions che permettono di ricavare la chiave crittografica della rete.
- Non utilizza controlli di integrità avanzati e quindi non rileva alterazione dei pacchetti in transito.

Per risolvere questi problemi viene introdotto il *WPA (WiFi Protected Access)*:
- Introduce il *TKIP* ovvero un sistema che cambia la chiave in modo dinamico per ogni pacchetto e inoltre stabilisce una chiave per ogni sessione fra AP e dispositivo.
- Per l'autenticazione utilizza *EAP (Extensible Authentication Protocol)* in modo che l'autenticazione possa essere effettuata tramite password, token, certificati ecc...
- Utilizza un algoritmo di cifratura più potente, l'AES, anche se supporta ancora il RC4 del WEP.
- Garantisce integrità con un controllo a 64bit cifrato.
- Utilizza il *four-way handshake* per generare chiavi ad ogni sessione da utilizzare anche per la cifratura.

Nonostante questo, non rimane immune ad alcune tipologie di attacchi, tipo il *Man-In-The-Middle*:
-  Sfruttando il MAC spoofing l'attaccante impersona il vero AP e invia un frame di "disassociazione" al client costringendolo a disconnettersi. Il client quindi è costretto a rinegoziare la connessione ma nel mentre l'attaccante cambia il suo MAC fingendosi il client e rubandogli la sessione con l'AP. Questo è possibile perchè a differenza del più avanzato WPA2 questi frame non hanno protezione dell'integrità.

Altri attacchi sono *Incomplete Authentication*, il client infatti deve dimostrare la sua identità all'AP ma l'AP non deve dimostrarla al client, un finto AP può quindi ingannare l'utente e sottrarre dati sensibili di autenticazione.

Infine c'è l'*Exhaustive Key Search e Chopchop*, infatti se si utilizzano password semplici basta un attacco a dizionario per trovarla. Il chopchop invece sfrutta una vulnerabilità dei controlli di integrità, l'attaccante tronca e sostituisce un byte alla volta in un pacchetto e analizza la reazione della rete a queste piccole modifiche, da queste può ricavare il pacchetto decifrato ed iniettarne di propri nella rete.

Tutti questi attacchi sono inutili contro l'ultimo protocollo WPA3.

== Denial of Service
Un attacco DoS non è sempre un blocco totale ma può anche indicare un forte rallentamento del servizio, tra i principali metodi di attacco abbiamo:
- *Ping of Death / Flooding*: Se l'attaccante possiede più banda della vittima può saturare la rete inviando innumerevoli richieste di ping
- *Smurf Attack*: L'attaccante invia un pacchetto broadcast finto (con l'IP della vittima) alla rete, tutti i computer quindi rispondono contemporaneamente verso l'indirizzo della vittima congestionandola.
- *Echo-Chargen*: Instaura un loop infinito: #align(center, image("/assets/image-70.png", width: 50%))
- *SYN-flood (TCP)*: Il protocollo TCP prevede un _three-way_ handshake ($"SYN" arrow.r "SYN-ACK" arrow.r "ACK"$). L'attaccante manda tantissime richieste SYN fornendo un IP falso, il server risponde con SYN-ACK ma l'ACK di conferma non arriverà mai lasciando la porta del server aperta in attesa ed esaurendo velocemente le risorse disponibili. #align(center, image("/assets/image-71.png", width: 50%))
- *Teardrop (IP Fragmentation)*: Spesso le comunicazioni in datagrammi li dividono in frammenti, il ricevente tramite le informazioni dei frammenti ovvero il loro inizio e quanto sono lunghi sono in grado di riassemblarli, un attaccante può inviare frammenti che si sovrappongono fra loro rendendo impossibile la ricostruzione e causando un rallentamento nel sistema.

Ci sono altri attacchi a livello Applicativo e di Routing ovvero:
- DNS Poisoning e Spoofing: Il poisoning avviene quando un attaccante inietta dati fittizzi nella cache dei DNS, quindi se ad esempio il computer chiede google.com molto probabilemente avrá l'indirizzo nella cache ma questa é stata compromessa inserendo un IP voluto dall'attaccante. Lo spoofing invece funziona come un Man In The Middle infatti l'attaccante intercetta la risposta DNS e invia prima la sua alla vittima, mandandolo in siti trappola.
Questi attacchi sono appunto Top-Levl Domain Attack e intaccano l'availability dell'utente dato che non gli permettono di risolvere indirizzi IP.

- Session Hijack: L'attaccante monitora l'handshake e invia un pacchetto con i numeri di sequenza e ACK corretti, in questo modo può inviare comandi ed escludere la vera sorgente dalla connessione. #align(center, image("/assets/image-72.png", width: 50%))

=== Routing Attacks
Si possono manipolare le routing tables per rendere possibile il reinstradamento del traffico verso un router specifico, infatti dato che:
- I router si fidano l'uno dell'altro in modo implicito
- Ogni router comunica agli altri quali reti può raggiungere e in quanti hops
- Un router R può dire agli altri che è in grado di raggiungere tutte le reti nel miglior percorso possibile.
Questo rende possibili 2 attacchi:
- MiM attack: R riceve tutto il traffico e può quindi agire da MiM
- DoS attack: R viene saturato per via di tutte le richieste che riceve.

=== Distributed Denial of Service
Questo tipo di attacchi cambiano il "bilanciamento" tra vittima e attaccante, quest'ultimo infatti infetta altre macchine con dei virus che non per forza porta dei danni effettivi alla macchina, anzi questa deve rimanere operativi, e utilizza queste macchine per coordinare un attacco verso una vittima. Questa rete di "zombie" prende il nome di *botnet*. Questa botnet non ha un collegamento diretto fra attaccante e bot ma segue una struttura a cascata ridondante pensate per proteggere chi ha organizzato l'attacco ma anche di funzionare in caso di crash di alcune porzioni della rete.
L'attaccante invia i comandi ad un primo livello di macchine chiamate Server Master questi a loro volta li inviano ai server C&C che sono quelli a stretto contatto con i bot.
I bot possono ricevere i comandi in due modi:
- Push: Il comando viene inviato dal server al bot
- Pull: È il bot che periodicamente controlla se ci sono comandi in attesa.
#align(center, image("/assets/image-73.png", width: 50%))

Come ci si difende da questi attacchi?
- Autonomous Mobile Protective Agents: Un programma simile a quelli usati dagli attaccanti ovvero un Trojan Horse che però ha il compito di diffondere una "controinfezione" per disabilitare il vero Trojan Horse.
- Risolvere continuamente le vulnerabilità
- Alcune tecniche come *tuning* dei server attivi, *load balancing*, *shunning* (ridurre il numero di richieste ricevibili da alcuni range di indirizzi), *blacklisting* (rifiutare la connessione da determinati indirizzi).

== Contromisure

=== Network Criptography
Esiste una grande differenza architetturale.

*Link Encryption*:

#align(center, image("/assets/image-74.png", width: 50%))

Il pacchetto viene cifrato all'origine poi decifrato e ricifrato a ogni singolo router intermedio, questo autentica i nodio ma espone parzialmente i dati in chiaro in quei passaggi.

*End-to-End Encryption*:

#align(center, image("/assets/image-75.png", width: 50%))

Il pacchetto rimane cifrato fino alla fine rendendo illeggibile il contenuto in tutti i router intermediari.

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
  title: [*SSH Encryption*],
  [
    Secure Shell (SSH) fornisce un collegamento autenticato e cifrato alla shell del sistema da un'altra macchina. Il protocollo SSH permette ai due terminali di stabilire:
    - Algoritmo di cifratura da utilizzare
    - Autenticazione (chiavi pubbliche)
  ]
)

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
  title: [*SSL and TLS Encryption*],
  [
    È un protocollo di cifratura utilizzato per proteggere i dati trasmessi in internet, principalmente per proteggere la confidenzialità. Può utilizzare tanti algoritmi di cifratura e certificati per l'autenticazione e lo scambio di chiavi. È implementato al quarto livello OSI e opera fra le applicazioni e il protocollo TCP/IP.

    Nel tempo si è evoluto da SSL1.0 fino a SSL3.0 chiamato appunto TLS, quando si parla di HTTPS si intende infatti HTTP + TLS.
  ]
)

=== IPsec
È uno standard progettato per gestire i dati crittografati e affrontare principalmente 3 minacce: spoofing, intercettazione e il session hijacking.
Dato che opera al livello di rete (3 del modello OSI) significa che tutto quello che viaggia ai livelli superiori quindi anche i dati di controllo TCP e UDP vengono incapsulati e protetti automaticamente senza che le applicazioni si preoccupino di nulla.

Vediamo i concetti principali della sua architettura.

*Security Association* - Sono tutti i parametri che i due terminali devono scambiarsi e sono necessari a stabilire una connessione sicura:
- Algoritmo di cifratura e la relativa chiave crittografica
- I parametri di crittografia come il vettore di inizializzazione
- Protocollo e chiave per l'autenticazione
- La durata dell'associazione ovvero il periodo dopo il quale le chiavi devono essere rinnovate
- Livello di sensibilità dei dati

*Gestione delle chiavi* - Il punto critico della crittografia è quello di scambiarsi le chiavi in modo sicuro, IPsec risolve il problema utilizzando l'architettura *ISAKMP (Internet Security Association Key Management Protocol)* implementata operativamente tramite il protocollo *IKE (ISAKMP Key Exchange)*, questo processo avviene in più fasi:
1. Si utilizza lo schema di Diffie-Hellman per generare matematicamente un "segreto condiviso" tra le due parti senza mai trasmetterlo sulla rete.
2. Utilizzando questo segreto le due parti si scambiano le proprie identità e i rispettivi certificati digitali per autenticarsi a vicenda.
3. Derivano la vera chiave crittografica e instaurano la Security Association definitiva.

*Modalità di Funzionamento* - IPsec deve alterare il pacchetto originale per proteggerlo, può farlo in due modi a seconda della modalità di funzionamento:
- *Transport Mode*: È la normale modalità operativa tra i due host, solo il payload viene blindato e inserito all'interno del campo crittografato ESP. L'IP Header originale rimane in chiaro permettendo ai router intermedi di leggere l'indirizzo del destinatario e instradare quindi il pacchetto. #align(center, image("/assets/image-76.png", width: 50%))
- *Tunnel Mode*: Offre una sicurezza più elevata per mascherare anche la topologia della rete nascondendo infatti l'indirizzo del vero destinatario. In questa modalità l'intero pacchetto originale viene cifrato e infilato nel campo ESP. IPsec aggiunge però un nuovo IP Header in chiaro all'esterno che punta ad un dispositivo remoto che si occuperà di ricevere il pacchetto, rimuovere la crittografia e smistare il pacchetto originale verso la vera destinazione interna. #align(center, image("/assets/image-77.png", width: 50%))

*Header IPSec* - I campi aggiunti dal protocollo difendono dagli attacchi specificati prima:
- Crypto Num: Contiene le informazioni sulla suite crittografica concordata dai terminali
- Seq Num: L'inserimento di numeri di sequenza è la contromisura diretta contro i Replay Attack
- Auth Data: Un blocco dedicato alla gestione dell'autenticazione assicurando che i dati provengano effettivamente dal mittente dichiarato e non siano stati alterati.

#align(center, image("/assets/image-78.png", width: 50%))

== Firewalls
Il primo concetto principale è quello della segmentazione della rete in sottoreti, ognuna gestita da un router, in questo modo se una viene compromessa non significa che anche le altre debbano cadere automaticamente.

#align(center, image("/assets/image-79.png", width: 50%))
- Nell'immagine `a` tutti gli host sono visibili e una vulnerabilità può propagarsi
- Nella `b` le reti sono separate, rimangono quindi esposte a vulnerabilità ma queste non si espandono fra le reti.

Questo meccanismo però controlla soltanto il movimento dei dati e non risolve il problema del controllo degli accessi. Per questo è necessario un *firewall*.

Un firewall è un dispositivo che esegue un codice per filtrare tutto il traffico tra una rete interna e una esterna, un firewall ben progettato deve rispettare i tre principi del *Reference Monitor*:
- Always Invoked: Deve essere l'unico punto di passaggio obbligato per il traffico
- Tamperproof: A prova di manomissione, solitamente infatti è implementato su un computer dedicato ed isolato in modo da essere altamente immune alle modifiche esterne.
- Small and Simple: Deve far girare un sistema operativo ridotto con servizi minimi, meno codice c'è e più sarà facile da analizzare per trovare falle offrendo anche meno strumenti di attacco ad un attaccante.

Il firewall decide cosa passa e cosa no basandosi su un set di regole, per creare queste regole gli amministratori si basano sue due filosofie:
- *Default Permit*: Tutto quello che non è esplicitamente vietato è permesso.
- *Default Deny*: Tutto ciò che non è esplicitamente permesso è vietato.

_Esempio di regole_: #align(center, image("/assets/image-80.png", width: 50%))

Il firewall legge le regole dall'alto verso il basso, nell'esempio quindi prima vengano permesse le connessioni sulla porta 80 o 25 verso certi IP per poi avere una regola che blocca tutte le connessioni.

=== Tipologie di Firewall

Possiamo classificare i firewall in base al livello di profondità con cui ispezionano i pacchetti:
- *Packet / URL Filtering*: Il più semplice e veloce, analizza un pacchetto per volta guardando soltanto gli indirizzi IP e le porte senza memoria del passato.

#align(center, image("/assets/image-81.png", width: 50%))

- *Circuit Level Gateway*: Opera al livello 5 OSI, il firewall verifica e autorizza la connessione logica nel momento in cui viene creata, ma una volta stabilita lascia passare i dati successivi senza ispezionarli. Viene utilizzato per collegare due reti di cui ci si fida, ad esempio nelle VPN.

#align(center, image("/assets/image-82.png", width: 50%))

- *Stateful Inspection*: Mantiene in memoria lo "stato" della connessione. Correla le informazioni dei pacchetti precedenti con quelli successivi, riuscendo a bloccare complessi schemi coma una scansione di porte anche estesa nel tempo.

#align(center, image("/assets/image-83.png", width: 50%))

- *Deep Packet Inspection (DPI)*: Oltre agli indirizzi IP, ispeziona attivamente il contenuto dei pacchetti, può anche alterare i dati in uscita ad esempio anonimizzando il traffico.

- *Application Proxy Gateway (Bastion Host)*: Lavora al livello più alto ovvero quello di Applicazione. Si comporta come un intermediario infatti dall'esterno sembra lui la destinazione finale, riceve i dati, li analizza in base a come si comporta l'app e poi crea una nuova connessione verso la macchina interna. Offre molta sicurezza ma è lento.

#align(center, image("/assets/image-84.png", width: 50%))

- *Guard*: Un proxy molto sofisticato, permette complesse regole programmabili. Un guard non si limita ad osservare il traffico ma interpreta a fondo i pacchetti e ne genera di nuovi identici o modificati per garantire maggiore sicurezza. In base allo storico delle richieste riesce a capire se autorizzare o meno determinate azioni, la sua caratteristica principale infatti è che è "limitato soltanto da ciò che è computabile", questo significa che teoricamente è in grado di applicare qualsiasi regola noi riusciamo a programmare. Alcuni esempi:
  - Controllo delle email: Limitare il numero di email che riceviamo da un determinato utente
  - Throttling: Limitare attivamente la velocità del traffico a disposizione di utente
  - Paywall: Gestire l'accesso a determinati servizi solo dopo un pagamento
  - Scansione antivirus: Può ispezionare i file che gli utenti stanno scaricando e passarli attraverso un antivirus direttamente sul firewall e bloccandoli prima ancora che arrivino sul PC del destinatario.
Tutta questa sua flessibilità porta ad un'altissima complessità e per questo motivo risulta difficile implementarne uno in modo accurato.

- *Sandbox*: Se il firewall nota un codice in entrata sospetto, lo esegue in ambiente isolato limitandogli l'accesso alle risorse. Se il codice non si comporta in modo strano allora l'amministratore può approvare l'ingresso.

#align(center, image("/assets/image-85.png", width: 50%))

Il firewall può essere posizionato in diversi punti in una rete, la topologia più recente è quella della *DMZ (Demilitarized Zone)*, qui si usano due firewall:
- Un primo firewall esterno che fa passare il traffico pubblico verso la DMZ ovvero un'area cuscinetto dove risiedono i server esposti al pubblico come quello Web o Email.
- Un secondo firewall interno più rigido che separa la DMZ dalla LAN privata proteggendo risorse come i Server Database.

#align(center, image("/assets/image-86.png", width: 50%))

=== Limitazioni dei Firewall
Ovviamente questi non risolvono tutti i problemi delle reti:
- Riescono a proteggere soltanto l'ingresso principale della rete, se un dipendente con dispositivi infetti si collegal wifi interno, ha bypassato tutto il firewall
- Una volta che i dati superano il firewall in modo legittimo per uscire non sono più protetti
- Essendo lo scudo principale ed anche visibile, sono uno dei principali bersagli degli attaccanti
- Richiedono una manutenzione costante da parte degli amministratori, anche una sola regola sbagliata rende inutile tutto il firewall. Per questi motivi si consiglia la *Defense in Depth* ovvero avere più strati di sicurezza interni per non basare tutto sulla sola resistenza del firewall.

=== Network Address Translation (NAT)
Viene spesso integrato nel firewall, serve a riscrivere gli indirizzi IP interni dei computer sostituendoli con l'IP pubblico del firewall verso l'esterno. Questo nasconde la vera topologia della rete privata impedendo agli attaccanti di conoscere, mappare e sfruttare direttamente gli IP interni.
Utilizzato anche per risolvere il problemi dei "pochi" indirizzi.

#align(center, image("/assets/image-87.png", width: 50%))

== Intrusion Detection and Prevention
Un IDS è un dispositivo dedicato esclusivamente a monitorare le attività per identificare eventi sospetti o malevoli, le sue funzioni includono:
- Monitoraggio degli utenti
- Auditing delle configurazioni per scovare vulnerabilità
- Controllo integrità dei file
- Analisi statistica per scovare comportamenti anomali e, se necessario, l'installazione di trappole per registrare informazioni sugli intrusi.

#align(center, image("/assets/image-88.png", width: 50%))

I suoi obiettivi principali sono l'essere veloce, accurato, semplice e operare in tempo reale nascondendo la propria presenza agli attaccanti. Il problema più grande che un IDS deve gestire è la sua *Accuratezza (Sensitivity)* misurata tramite due errori:
- *False Positive*: L'IDS lancia un allarme per un evento che non è un attacco, troppi falsi allarmi fanno si che gli amministratori perdano fiducia nel sistema portandoli a ignorare le vere emergenze
- *False Negative*: L'IDS non lancia l'allarme e un vero attacco passa inosservato. L'amministratore deve configurare attentamente la sensibilità dell'IDS per bilanciare questi due problemi.

Ci sono due principali metodologie di rilevamento.
- *Signature Based*: L'IDS esegue un pattern-matching cercando corrispondenze con "firme" (sequenze specifiche di dati) di attacchi noti.