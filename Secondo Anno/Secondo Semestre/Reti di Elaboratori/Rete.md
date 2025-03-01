Possiamo vedere una rete come un collegamento fra più host, nel mezzo del percorso troviamo anche altri nodi, che sono altri dispositivi di rete come switch e router.

![[Pasted image 20250228091901.png]]

In una rete quindi abbiamo due tipi di dispositivi:
- **Host** - Di solito una macchina di proprietà degli utenti come portatili o computer desktop che eseguono applicazioni.
- **Server** - Un computer ad elevate prestazioni destinato ad offrire servizi a diverse applicazioni utente.

Nel mezzo della rete troviamo i **dispositivi di interconnessione** che in genere rigenerano / modificano il segnale e si dividono in:
- **Router** - Sono dispositivi che collegano una rete ad altre reti
- **Switch** - Collegano più terminali all'interno di una stessa rete
- **Modem** - Trasformato i segnali in varie codifiche, ad esempio ricevono il segnale telefonico dall'esterno e lo convertono in un segnale digitale con il quale usare anche internet

I dispositivi di rete vengono collegati utilizzando mezzi cablati o wireless chiamati **link**, per i collegamenti cablati abbiamo:
- Rame
- Fibra Ottica
Mentre per i wireless:
- Onde elettromagnetiche
- Satellite

# Mezzi Trasmissivi

In questi mezzi viaggiano le informazioni sotto forma di **bit**
## Cablati

Abbiamo il **doppino intrecciato** che si distingue in:
- Due fili di rame distinti come il cavo telefonico ad esempio
- Intreccio di quattro coppie di fili ovvero l'Ethernet

Abbiamo anche il **Cavo Coassiale** - Composto da due conduttori in rame concentrici ed usato per cablare delle reti locali. Permette scambio di informazioni bidirezionale ed è molto resistente alle interferenze.

Infine troviamo la **Fibra Ottica** che ormai ha sostituito il cavo coassiale - Questa trasmette impulsi di luce ad altissima frequenza riuscendo a raggiungere velocità da 10 a 100 Gbps. Ha un bassissimo tasso di errore e quando serve il segnale viene rigenerato con dei ripetitori. Essendo luce è anche immune alle interferenze.

In tutti questi mezzi, essendo cablati, il segnale è guidato da una destinazione all'altra.

## Wireless

Nei mezzi wireless invece i segnali si propagano nello spazio esterno e sono quindi "liberi". Il vantaggio principale è il non dover creare un'infrastruttura per il passaggio dei cavi ma ovviamente abbiamo come svantaggio gli effetti dell'ambiente circostante come la riflessione del segnale, le interferenze o le ostruzioni da parte di ostacoli.

Vediamo alcuni esempi di canali radio:
- Microonde terrestri - Canali fino a 45 Mbps
- LAN - Ad esempio Wifi IEEE802.11 (11 Mbps / 54 Mbps)
- WideArea - Quindi reti cellulari come 3/4/5G
- Satellitari - Canali fino a 45 Mbps ma con ritardi elevati punto a punto, circa 300ms

# Classificazione delle Reti

| Scale    | Type                                    | Example                     |
|----------|-----------------------------------------|-----------------------------|
| Vicinity | PAN (Personal Area Network)           | Bluetooth (e.g., headset)  |
| Building | LAN (Local Area Network)              | WiFi, Ethernet             |
| City     | MAN (Metropolitan Area Network)       | Cable, DSL                 |
| Country  | WAN (Wide Area Network)               | Large ISP                  |
| Planet   | The Internet (network of all networks) | The Internet!              |
## Reti LAN

Solitamente si tratta di reti private che collegano terminali di un singolo ufficio (inteso come abitazione, azienda, università...), ogni terminale nella LAN ha un proprio indirizzo che lo identifica in modo univoco nella rete. Inizialmente era nata per condividere informazioni tra terminali nella stessa rete ma oggi viene usata principalmente per connettersi ad altre LAN o WAN e consentire comunicazioni col resto del mondo.

Un tipo di LAN ormai non più utilizzato è la **LAN con cavo condiviso (broadcast)**, un terminale invia un pacchetto e tutti gli altri lo ricevono ma solo il destinatario lo elabora. In queste reti è importante che trasmette un solo dispositivo alla volta, altrimenti si creano delle collisioni.

![[Pasted image 20250228094610.png]]

Poi si è passati alla **LAN con switch di interconnessione**, qui i dispositivi non sono collegati direttamente fra loro ma abbiamo in mezzo uno switch. Quando un dispositivo invia un pacchetto questo viene ricevuto dallo switch che lo indirizza verso il destinatario. Qui invece più di 1 PC possono trasmettere nello stesso momento, sarà lo switch a serializzare i messaggi e non creare collisioni.

## Reti WAN

È una rete molto grande di solito utilizzate per connettere intere città, regioni o nazioni, vengono gestite dagli ISP (Internet Service Provider) che forniscono servizi a chi le usa, ne esistono di due tipi.

- **WAN Punto-Punto** - Collega fra loro due reti tramite un mezzo di trasmissione.

![[Pasted image 20250228100416.png]]

- **WAN a Commutazione** - Collega fra loro più reti, è quindi molto utilizzata nelle dorsali di Internet.

![[Pasted image 20250228100505.png]]

## Internetwork

Oggi è difficile trovare LAN o WAN isolate, di solito sono connesse fra loro per formare una internetwork o internet (internet è quindi un insieme di reti mentre con Internet indichiamo il nostro Internet che collega il mondo).

_Esempio_ - Un'azienda vuole mettere in comunicazione due uffici in diverse città, in ciascun ufficio esiste una LAN e per mettere in comunicazione queste due l'azienda acquista una WAN punto-punto da un ISP realizzando quindi una internet privata.

![[Pasted image 20250228101220.png]]

_Esempio_ - Rete più complessa composta da quattro WAN e tre LAN

![[Pasted image 20250228101529.png]]


> [!info]- WAN: la rete GARR
> La rete GARR interconnette ad altissima velocità grandi centri di ricerca come università, biblioteche, musei ecc...
> Si estende su circa 15.000km di fibra ottica tra dorsali e collegamenti di accesso.
> Oggi la capacità della dorsale arriva a 100Gbps mentre nei singoli punti di accesso fino a 40Gbps in base alle necessità
> 
> ![[Pasted image 20250228102132.png]]

# Commutazione (Switching)

Una internet è una combinazione di link e dispositivi che si scambiano informazioni, questi comunicano fra loro per mezzo di switch e router che si trovano nel percorso, esistono due tipi di reti basate su switch:

- **A commutazione di circuito**
- **A commutazione di pacchetto**

## Reti a commutazione di circuito

Tra due dispositivi è sempre disponibile un collegamento chiamato **circuito** che viene usato per tutta la trasmissione, durante quest'ultima vengono riservate delle risorse per garantire il corretto funzionamento e sono mantenute fino alla fine, una volta terminata vengono rilasciate. Possono esistere quindi anche più percorsi tra due punti ma durante una trasmissione ne verrà usato soltanto uno.

![[Pasted image 20250228103433.png]]

Quanto è efficiente questo tipo di rete? - Prendiamo come esempio la rete telefonica con la seguente struttura:

![[Pasted image 20250228103535.png]]

Se 4 persone da un lato parlano con 4 dall'altro allora la rete è completamente utilizzata, se invece solo una persona sta parlando viene usato 1/4 della rete e quindi è inefficiente perché il resto non viene utilizzato.

Le risorse di rete, come la larghezza di banda, vengono suddivise in pezzi e ciascun pezzo associato ad un collegamento.

La banda ad esempio può essere suddivisa i due modi, **FDM (Frequency Division Multiplexing) e TDM (Time Division Multiplexing)** che rispettivamente dividono le frequenza della banda e il tempo di tramissione:

![[Pasted image 20250228103833.png]]

## Rete a Commutazione di Pacchetto (Store and Forward)

La comunicazione avviene trasmettendo blocchi di dati chiamati pacchetti, quindi non si ha più una comunicazione continua. Non vengono riservate delle risorse per la comunicazione dato che i router o switch hanno delle code con le quali memorizzano i pacchetti che poi dovranno inviare.

![[Pasted image 20250228104422.png]]

In questo caso quindi i pacchetti possono seguire anche percorsi diversi e arrivare in ordine diverso, per questo è importante numerarli in modo da poter ricostruire il messaggio una volta ricevuto. Inoltre in caso di pacchetti persi il mittente dovrà rinviare il messaggi completo.

![[Pasted image 20250228104539.png]]

La coda nei router serve a memorizzare i pacchetti in caso di traffico sulla linea, in questo modo il router può aspettare il momento adatto per inviare i pacchetti.

# Internet

Si è detto che una internet (con i minuscola)  è costituita da due o più reti interconnesse, la più famosa è Internet (I maiuscola) composta da migliaia di reti, questa è una rete a commutazione di pacchetto.

Rappresentazione concettuale di Internet:

![[Pasted image 20250228104903.png]]

Le dorsali sono quindi "lo scheletro" principale della rete alla quale si collegano i sottonodi.

Una delle prime reti è la **ARPANET** (Advanced Research Projects Agency Network) nata per condividere materiale di ricerca fra alcune Università, è stata la prima rete a commutazione di pacchetto ad implementare il protocollo TCP / IP. Evoluzione nel tempo:

![[Pasted image 20250228105129.png]]

## Accesso a Internet

Internet è una rete che permette a chiunque di farne parte, l'utente deve collegarsi tramite un ISP, solitamente con una WAN punto-punto, questo collegamento è detto **rete di accesso**.

Questo accesso può avvenire in vari modi:
- Tramite rete telefonica
	- Dial-up tramite Modem
	- DSL
- Reti Wireless
	- Wifi
	- Cellulare
- Collegamento diretto
	- Aziende di grandi dimensioni possono diventare delle ISP locali affittando reti WAN dagli operatori

### Accesso con Rete Telefonica

Possiamo collegarci ad internet modificando la linea telefonica fra la sede del dispositivo che si vuole collegare e la centrale telefonica con una WAN punto-punto.

**Servizio dial-up** - Dobbiamo inserire un modem che converte il segnale analogico della linea telefonico in segnale digitale comprensibile dal computer e anche viceversa, questo tipo di accesso è molto lento e non permette le navigazione in Internet durante una telefonata.

![[Pasted image 20250228105718.png]]

**Servizio DSL (Digital Subscriber Line)** - Questa tecnologia supporta velocità più elevate sulla linea telefonica e divide il collegamento tra abitazione e ISP in tre bande di frequenza non sovrapposte, permette navigazione e telefonate nello stesso momento.

![[Pasted image 20250228105822.png]]

### Accesso tramite Ethernet

Ci si collega col proprio terminale direttamente allo switch tramite cavo, lo switch è poi collegato ad un router che a sua volta è connesso ai router della dorsale.

### Accesso Wireless

Ci colleghiamo tramite WiFi all'access point locale collegate ai vari router, ha ovviamente un raggio d'azione limitato. Oppure possiamo utilizzare la rete cellulare che si basa sugli access point della compagnia telefonica, hanno raggi di azioni molto più elevati rispetto ai classici accesso point WiFi.
