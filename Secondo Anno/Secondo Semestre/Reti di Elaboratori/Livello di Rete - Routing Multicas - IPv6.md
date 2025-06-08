# Broadcast

> [!info] Unicast
> È la comunicazione tra una sorgente e una destinazione abbiamo quindi la coppia indirizzo IP sorgente e indirizzo IP destinazione.

Quando parliamo di broadcast intendiamo l'invio di un pacchetto da un nodo sorgente a tutti i nodi della rete:
- Comunicazione 1 a N dove N sono i nodi
- Abbiamo la coppia indirizzo IP sorgente - indirizzo IP broadcast

Come possiamo eseguire broadcast?
- Uncontrolled flooding
- Controlled flooding
	- Sequence number
	- Reverse path forwarding

## Uncontrolled Flooding
Quando un nodo riceve un pacchetto da inviare in broadcast lo duplica e lo invia a tutti i vicini tranne a chi gli ha inviato il pacchetto.

Se il grafo che rappresenta la rete ha cicli, una o più copie del pacchetto rimarranno all'infinito nella rete. Risolviamo questo problema con il controlled flooding

## Sequence number controlled flooding
Non si spediscono pacchetti già ricevuti e inoltrati, manteniamo quindi una lista (indirizzo IP, \#seq) dei pacchetti già ricevuti, duplicati e inoltrati. Quando si riceve un pacchetto quindi prima si controlla la lista e poi si decide se inviarlo o no.

## Reverse path forwarding (RPF)
Il pacchetto viene spedito soltanto se è arrivato dal link che è sul suo shortest path (unicast) verso la sorgente.

![[Pasted image 20250507105615.png|300]]

- Elimina il problema di avere troppi pacchetti sulla rete
- Non elimina completamente il problema dei pacchetti ridondanti
	- Ad esempio B, C, D, E, F ricevono più pacchetti ridondanti
	- Ogni nodo dovrebbe ricevere soltanto una copia del pacchetto broadcast

Per risolvere questi problemi costruiamo lo **spanning tree** prima di inviare i pacchetti broadcast.

### Spanning Tree (center - based)
Prendiamo un nodo come centro, in questo caso E. Ogni nodo invia un messaggio di join in unicast verso il centro, i messaggi vengono inoltrati finché:
1) arrivano a un nodo che già appartiene all'albero
2) arrivano al centro

Quindi otteniamo:

![[Pasted image 20250507110244.png|400]]

Se facciamo broadcast sullo spanning tree eliminiamo il problema dei pacchetti duplicati.

# Multicast
In questo caso abbiamo una comunicazione tra una sorgente e un gruppo di destinazioni.

Il multicast è più efficiente di un unicast multiplo:

![[Pasted image 20250507110523.png|400]]

## Instradamento Multicast
Molte applicazioni richiedono il trasferimento di pacchetti da uno o più mittenti ad un gruppo di destinatari, ad esempio:
- Streaming ad un gruppo di utenti
- Giochi multiplayer
- Trasferimento di aggiornamenti software

## Problema dell'Indirizzamento
Come facciamo a far comunicare due host che si trovano nello stesso gruppo multicast ma su reti diverse? L'indirizzo IP di destinazione infatti deve essere solo uno.

Utilizziamo un solo indirizzo per tutto il gruppo ovvero **indirizzo multicast**

_Esempio di gruppo multicast_

![[Pasted image 20250507111239.png|400]]

### Indirizzi multicast
È un blocco di indirizzi riservati al multicast, per l'IPv4 abbiamo:

- 224.0.0.0/4, quindi
- 1110 ---identificatore gruppo--- (da 224.0.0.0 a 239.255.255.255)
- Abbiamo quindi $2^{28}$ gruppi

## Gruppi Multicast
L'appartenenza ad un gruppo quindi non ha alcuna relazione con il prefisso associato alla rete, ogni host che appartiene a un gruppo avrà infatti un indirizzo aggiuntivo e separato da quello della rete.

Come fa un router a sapere quali host appartengono a un gruppo? Il router deve scoprire quali gruppi sono presenti nelle sue interfacce e propagare questa informazioni agli altri router.

## Protocolli Multicast
Per ottenere il multicast sono necessari due protocolli:
- Uno per raccogliere informazioni sull'appartenenza a gruppi
- Uno per diffondere queste informazioni

### Internet Group Management Protocol (IGMP)
Lavora tra un host e il router collegato ad esso, permette appunto all'host di informare il router del fatto che un'applicazione vuole partecipare ad un gruppo multicast.

Questo protocollo invia messaggi incapsulati in datagrammi IP con IP protocol number 2, vengono spediti con TTL a 1. Ci sono però diversi tipi di messaggi:
- **Membership query** - Messaggio che va dal router all'host e serve a determinare a quali gruppi hanno aderito gli host su ogni interfaccia.
- **Membership report** - Va da un host al router e serve ad informarlo sull'adesione ad un gruppo. Di solito vengono inviati in risposta ad una query ma non sempre
- **Leave group** - Va da un host al rouer e si manda quando si lascia un gruppo, questi messaggi sono opzionali, il router infatti può capire che non ci sono più adesioni quando non riceve report in risposta ad una query.

Un router multicast tiene una lista per ciascuna sottorete dei gruppi multicast (**multicast group membership**) con un timer per membership.
- Questa membership deve essere aggiornata con dei report prima dello scadere del timer
- Può anche essere aggiornata tramite messaggi di leave espliciti

## Problema routing multicast
Fra tutti i router soltanto alcuni dovranno ricevere traffico multicast, ovvero quelli collegati ad un host del gruppo, è necessario quindi un protocollo che coordini i router multicast in Internet ovvero che instradi i pacchetti multicast dalla sorgente alla destinazione.

![[Pasted image 20250507112919.png|400]]

Ci sono diversi approcci per identificare questo albero.

### Albero condiviso dal gruppo
Viene costruito un singolo albero d'instradamento condiviso da tutto il gruppo multicast, il router agisce da rappresentante per il gruppo, se il mittente del traffico multicast non è il centro dell'albero allora esso invierà il traffico al centro usando unicast, sarà poi il centro ad inviarlo al resto del gruppo:

![[Pasted image 20250507113843.png|300]]

### Albero basato sull'origine
Viene creato un albero per ciascuna origine nel gruppo multicast, ci saranno quindi tanti alberi quanti sono i mittenti del gruppo, per la costruzione si usa un algoritmo basato su reverse path forwarding con pruning (potatura).

![[Pasted image 20250507113951.png|300]]

## Instradamento multicast in Internet
Si utilizzano i seguenti protocolli

**Intra-dominio multicast** (in un AS)
- DVMRP: distance-vector multicast routing protocol
- MOSPF: multicast open shortest path first
- PIM: protocol independent multicast

**Inter-dominio multicast** (tra AS)
- MBGP: multicast border gateway protocol

# IPv6
È nato con lo scopo di aumentare il numero di possibili indirizzi rispetto ad IPv4, ridisegnare il formato dei datagrammi e rivedere alcuni protocolli come ICMP.

Gli indirizzi IPv6 sono lunghi 128 bit, hanno nuovi formati per l'header e le opzioni, più possibilità di espansione e sicurezza e maggiore efficienza per quanto riguarda la frammentazione nei nodi intermedi.

Come è fatto un datagramma IPv6?

![[Pasted image 20250507114336.png|500]]

Si pensava di migrare completamente all'IPv6 nel 2020, ma le tecnologie come NAT e DHCP hanno rallentato il passaggio.

La transizione a IPv6 è però già iniziata, per permettere il funzionamento di IPv6 e IPv4 ci sono diverse tecniche.

## Dual Stack

Gli host devono permettere una doppia pila di protocolli per la comunicazione ovvero sia IPv4 che IPv6.

Per determinare quale versione utilizzare l'host interroga il DNS e si usa il protocollo relativo all'indirizzo ritornato (se IPv4 o 6)

![[Pasted image 20250507114818.png|400]]

## Tunneling
Potrebbe accadere anche che due host IPv6 vogliono comunicare ma nel loro percorso ci sono nodi in IPv4, per permettere la comunicazione si incapsula il datagramma IPv6 nel payload di un datagramma IPv4. Questo datagramma IPv4 avrà come indirizzi IP agli estremi quelli del tunnel.

![[Pasted image 20250507115002.png|400]]

## Traduzione dell'intestazione
Un mittente IPv6 comunica con un destinatario IPv4, il datagramma viene tradotto prima di arrivare a destinazione:

![[Pasted image 20250507115107.png|400]]

