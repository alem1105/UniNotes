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
- Frame Type: Control, Management, Data
- ToDS, FromDS: Indica la direzione del frame, se va verso l'Access Point o viene da esso.
- Bits per il controllo di sequenza
- WEP (Wired Equivalency Privacy) bit: Encryption, spiegata meglio dopo
- Fino a 4 indirizzi MAC, 2 per mittente e destinatario e altri 2 opzionali per dei punti di filtraggio.