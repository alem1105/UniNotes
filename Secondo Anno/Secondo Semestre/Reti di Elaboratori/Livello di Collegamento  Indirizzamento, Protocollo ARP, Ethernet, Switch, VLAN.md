# Indirizzi MAC
Gli indirizzi IP individuano i punti di Internet dove sono collegati gli host, quando però un datagramma passa dal livello di rete al livello di collegamento questo viene incapsulato in un frame con un'intestazione che contiene gli indirizzi di collegamento della sorgente e della destinazione. Questi sono gli indirizzi MAC e sono composti da 48bit, ovvero 6 byte rappresentati in esadecimale.

Ogni adattatore LAN (ad es. scheda di rete) ha un indirizzo MAC univoco.

Quando una società vuole costruire degli adattatori deve comprare un blocco di indirizzi alla IEEE.

A differenza degli indirizzi IP che devono essere aggiornati quando si passa da una rete all'altra gli indirizzi MAC dipendono soltanto dall'adattatore e rimane sempre uguale da rete a rete.

Come vengono determinati gli indirizzi di collegamento dalla sorgente alla destinazione? Con **Address Resolution Protocol (ARP)**

# Protocollo per la Risoluzione di indirizzi ARP
Come si fa quindi a determinare un indirizzo MAC conoscendo soltanto l'indirizzo IP?
- Ogni nodo IP nella LAN ha una tabella ARP che contiene la corrispondenza tra indirizzi IP e MAC in dei record con il seguente formato:

```
<Indirizzo IP; Indirizzo MAC; TTL>
```

Il TTL indica il Time To Live ovvero quando eliminare quella voce dalla tabella.

_Esempio di tabella ARP_

![[Pasted image 20250516100157.png|400]]

Cosa succede se A vuole inviare un datagramma a B senza avere il suo indirizzo MAC nella sua tabella?
- Viene inviato un pacchetto broadcast di richiesta ARP contenente l'indirizzo IP di B

In questo modo tutti i nodi della rete ricevono il pacchetto di richiesta ARP ma soltanto il nodo con l'indirizzo IP specificato risponde, quindi B risponde ad A comunicandogli il proprio indirizzo MAC.

Da notare che la risposta ARP non viene inviata tramite broadcast ma in un pacchetto standard ed in unicast direttamente all'indirizzo MAC del mittente.

> [!info] ARP plug-and-play
> La tabella ARP di un nodo si costruisce automaticamente e non c'è quindi bisogno di un intervento da parte dell'amministratore di sistema.

## Formato del pacchetto ARP
![[Pasted image 20250516161743.png|500]]

I pacchetti ARP sono incapsulati direttamente all'interno di un frame di livello di collegamento:

![[Pasted image 20250516162612.png|500]]

---
## Indirizzamento
Come avviene l'invio di dati verso un nodo esterno alla sottorete?

![[Pasted image 20250516162956.png|500]]

Grafico sul flusso di pacchetti che avviene nella sorgente (A):

![[Pasted image 20250516163052.png|500]]

- Il livello applicazione ricava con i DNS l'indirizzo di Gabriele al livello di rete. Questa richiesta viene inviata a livello di trasporto e incapsulata quindi in un segmento
- Il segmento passa a livello di rete dove tramite l'indirizzo a livello di rete e la tabella ARP (prima si deve trovare il prossimo hop tramite la tabella d'inoltro) si ricava l'indirizzo MAC di Gabriele (quello a livello di collegamento). Il segmento viene quindi incapsulato in un datagramma a livello di collegamento.
- Infine il datagramma viene incapsulato in un Frame e passato al livello fisico.

Cosa accade invece nel Router R1?

![[Pasted image 20250516163412.png|500]]

Dobbiamo risalire lo stack fino al livello di rete:
- Riceviamo il frame dal livello fisico, prendiamo quindi i due indirizzi MAC del frame e decapsuliamo il frame passandolo a livello di collegamento ottenendo quindi il datagramma.
- Tramite l'indirizzo IP ottenuto dal datagramma otteniamo grazie alla tabella d'inoltro il prossimo indirizzo IP che grazie all'ARP possiamo convertire in un indirizzo di collegamento MAC da passare al nuovo frame anche andiamo a creare.

Flusso di pacchetti alla destinazione B:

![[Pasted image 20250516163818.png|300]]

Dobbiamo semplicemente risalire lo stack fino a ricavare la richiesta del livello applicazione.

# LAN cablate: Ethernet
Nel 1985 è stato creato dalla IEEE Computer Society un progetto chiamato **Progetto 802** con l'obiettivo di definire uno standard di interconnessione tra dispositivi di produttori differenti.

Si voleva definire le funzioni del livello fisico e di collegamento dei protocolli LAN.

È stato ottenuto lo standard **IEEE 802**.

## IEEE 802
Ci sono diversi standard per le LAN, questi includono gli standard per:
- Specifiche generali del progetto - 802.1
- Logical Link Control LLC - 802.2 (rilevazione errori, controllo flusso, parte del framing)
- CSMA / CD - 802.3
- Token bus - 802.4, destinato a LAN per automazione industriale
- Token ring - 802.5
- DQDB - 802.6, destinato alle MAN
- WLAN - 802.11

I vari standard differiscono a livello fisico e nel sottolivello MAC ma sono compatibili a livello data link. (poco chiaro, da capire.)

## Ethernet
È stata la prima LAN ad alta velocità ed è sempre al passo con il tasso trasmissivo, è più semplice e meno costosa di Token Ring, FDDI e ATM.

### Ethernet Standard
![[Pasted image 20250516165057.png|500]]

- **Ethernet Standard (10Mbps) - Formato dei Frame**

![[Pasted image 20250518184508.png]]

- Il preambolo serve ad "attivare" le NIC dei riceventi e sincronizzare i loro orologi con quello del trasmittente, a livello fisico fa parte dell'header.
- SFD è un byte ed è un flag che indica l'inizio del frame, gli ultimi due bit (11) indicano l'inizio dell'header MAC (livello di collegamento)
- Indirizzi sorgente e destinazione - Quando una NIC riceve un pacchetto che contiene il suo indirizzo come indirizzo di destinazione oppure quello broadcast lo trasferisce al livello di rete. Tutti gli altri pacchetti vengono ignorati.
- Tipo - Indicano il protocollo usato nel pacchetto incapsulato nel frame, ovvero il protocollo usato nel livello superiore dello stack.
- Dati - Contiene un datagramma del livello di rete. Se il campo è più piccolo di 46byte viene riempito di 0 fino a raggiungere la dimensione (padding)
- CRC - Consente alla NIC ricevente di rilevare la presenza di un errore nei bit sui campi indirizzo, tipo e dati.

Questo tipo di Ethernet non è orientato alla connessione e quindi non c'è nessun tipo di handshake, inoltre non è affidabile dato che non ci sono riscontri, come IP e UDP.

### Indirizzi
Tutte le stazioni che fanno parte di una ethernet sono dotate di una Network Interface Card o scheda di rete, la NIC infatti fornisce un indirizzo di rete di livello di collegamento (indirizzo MAC). Gli indirizzi vengono trasmessi da sinistra verso destra, byte per byte, ma per ciascun byte il bit meno significativo viene inviato per primo e quello più significativo per ultimo. [Ordine dei byte](https://it.wikipedia.org/wiki/Ordine_dei_byte)

# Fasi Operative del Protocollo CSMA / CD
1) **Framing** - La NIC riceve un datagramma di rete dal nodo cui è collegato e prepara un frame ethernet.
2) **Carrier Sense e Trasmissione** - Se il canale è inattivo (lo si capisce vedendo il livello di energia sul mezzo trasmissivo) inizia la trasmissione, se invece risulta occupato allora si resta in attesa fino a quando non è inattivo.
3) **Collision Detection** - Verifica, durante la trasmissione, la presenza di segnali provenienti da altre NIC, se non ci sono allora il pacchetto viene spedito.
4) **Jamming** - Se vengono rilevati segnali da altre NIC interrompe la trasmissione del pacchetto e invia un segnale di disturbo (jam)
5) **Backoff Esponenziale** - La NIC rimane in attesa, quando riscontra la n-esima collisione consecutiva stabilisce un valore $k$ tra $\{ 0,1,2,\dots,2^{m}-1 \}$ dove $m$ è il minimo tra $n$ e $10$. La NIC aspetta un tempo pari a $k$ volte 512 bit  e ritorna la Passo 2.

- Il **jam** è grande 48 bit e il suo obiettivo è quello di avvisare della collisione tutte le altre NIC che sono in fase trasmissiva
- L'obiettivo del backoff esponenziale è quello di stimare quanti sono gli adattatori coinvolti.
	- Alla prima collisione si sceglie K tra 0,1 e quindi un tempo di attesa pari a K volte 512 bit
	- Dopo la seconda collisione si sceglie un K tra 0,1,2,3
	- Dopo dieci collisioni si sceglie K tra 0,1,2,3,4,...,1023

## Fast Ethernet (100Mbps)
È l'evoluzione dello standard ethernet ma rimane comunque compatibile con esso.

Per continuare a far funzionare correttamente il CSMA / CD mantenendo una dimensione minima del frame di 512 bit però dobbiamo modificare la lunghezza della rete, infatti se la trasmissione è 10 volte più veloce e il frame è di 512 bit allora dovremmo rilevare le collisioni 10 volte più velocemente, la rete deve quindi essere 10 volte più corta.

### Prima Soluzione
Abbandonare la topologia a stella e utilizzare un hub passivo e fissare la dimensione massima della rete a 250 metri invece che 2500.

![[Pasted image 20250518200605.png|400]]

L'hub è un dispositivo che opera a livello fisico sui singoli bit:
- Quando arriva un bit l'hub lo riproduce incrementandone l'energia e trasmettendolo in tutte le sue altre interfacce. (Anche se su queste è presente un segnale)
- Non implementa la rilevazione della portante né CSMA / CD
- Trasmette in broadcast, quindi ciascuna NIC può sondare il canale per verificare se è libero e rilevare una collisione mentre trasmette.

### Seconda Soluzione
Si usa uno switch di collegamento con connessione full duplex per ogni host e con un buffer che memorizza i frame. Dato che il mezzo trasmissivo è privato per ciascun host non c'è bisogno di usare CSMA/CD in quanto non c'è più competizione.

Quindi appena lo switch riceve un frame, lo memorizza nel buffer, verifica l'indirizzo di destinazione e lo invia nell'interfaccia corrispondente.

### Switch
Lo switch è un dispositivo del livello link più intelligente di un hub e che opera in modo attivo:
- Filtra e inoltra i pacchetti Ethernet
- Esamina l'indirizzo di destinazione e lo invia all'interfaccia corrispondente
- È trasparente ovvero gli host non sono consapevoli della sua presenza.

![[Pasted image 20250518201337.png|500]]

Lo switch quindi consente più trasmissioni simultanee senza collisioni

> [!info] Gigabit Ethernet
> È l'evoluzione del precedente Ethernet, anche qui non ci sono collisioni perché si usano switch e la massima lunghezza del cavo dipende solo dall'attenuazione del segnale. Si arriva anche a velocità sui 10Gbps.

### Autoapprendimento degli switch
Inizialmente gli switch venivano configurati in modo statico mentre adesso c'è un meccanismo dinamico di auto-apprendimento, senza configurazione sono in grado di creare una tabella di commutazione per associare indirizzi MAC alle interfacce.

Lo switch apprende quali nodi possono essere raggiunti attraverso determinate interfacce, quando arriva un pacchetto segna nella tabella l'indirizzo del mittente e da quale interfaccia è arrivato:

![[Screenshot 2025-05-18 alle 20.18.39.png|300]]

![[Pasted image 20250518201906.png|300]]

Quando poi il frame va inviato allora ci sono due strade:
- Se la destinazione è ignota allora il pacchetto viene inviato in tutta la rete (flood)
- Se invece si conosce la destinazione allora si manda nell'interfaccia corrispondente

### Proprietà degli Switch
- Sono dispositivi plug-and-play ovvero non richiedono interventi da parte dell'amministratore di rete.
- Eliminano le collisioni bufferizando i frame
- Interconnettono link eterogenei ovvero che operano a diverse velocità.
- Aumentano la sicurezza della rete e migliorano il network management.

# VLAN - Lan Virtuali
A cosa servono?

Supponiamo di avere uno switch che collega 3 LAN e 3 gruppi di lavoro.

![[Pasted image 20250518202233.png|400]]

Cosa succede se una persona del primo gruppo viene spostata?

Oppure, se avessimo 10 gruppi composti da poche persone, avremmo bisogno di 10 switch? Oppure di uno singolo che però non rispetta le varie separazioni fra gruppi?

Le VLAN risolvono questi problemi, sono delle reti locali configurate tramite software e non tramite cablaggio fisico. Una LAN viene suddivisa in segmenti logici anziché fisici e può essere divisa in più VLAN. Il gruppo di appartenenza di un host è definito dal software:

![[Pasted image 20250518202533.png|400]]

Quindi se uno switch crea delle VLAN possiamo vederlo come più switch messi insieme:

![[Pasted image 20250518202657.png|400]]

![[Pasted image 20250518202711.png|400]]

La creazione delle VLAN avviene tramite software assegnando ad ogni porta dello switch una VLAN, ci sarà quindi una tabella che associa VLAN - interfaccia.

Se abbiamo dei gruppi di lavoro sparsi in più zone possiamo effettuare il **VLAN Trunking** ovvero configurare una porta speciale su ogni switch che viene usata per interconnettere più switch, questa porta appartiene a tutte le VLAN e riceve i frame indirizzati a tutte le VLAN

![[Pasted image 20250518202919.png|400]]

Quindi è come "condividere" la tabella VLAN su più switch
