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

_Slide 8_

