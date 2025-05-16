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

_slide 22_
