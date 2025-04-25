# Forwarding Datagrammi IP
Inoltrare un datagramma significa collocarlo sul giusto percorso che lo farà avanzare verso la destinazione finale.

Un host quindi quando invia un datagramma lo invia al router locale che quando lo riceve confronta la tabella di routing e trova l'hop successivo.

Un protocollo di routing deve scegliere il miglior percorso dato che ce ne sono molti possibili per raggiungere una destinazione, questi percorsi vanno aggiunti alla tabella di routing.

# Routing Intra-dominio: RIP

I protocolli intra dominio come il RIP si occupano di instradare i datagramma all'interno della stessa rete, successivamente vedremo quelli inter dominio ovvero che mettono in comunicazione reti diverse.

Possiamo vedere un rete come un grafo:

![[Pasted image 20250425202801.png|300]]

Indiamo il grafo con $G=(N,E)$ dove $N$ indica l'insieme dei nodi ovvero i router ed $E$ l'insieme degli archi ovvero i collegamenti.

Inoltre indichiamo per ogni arco un costo: $c(x,x')$ indica il costo del collegamento fra $x$ e $x'$.

Con il costo indichiamo possiamo indicare la lunghezza fisica del collegamento, la velocità del collegamento oppure il costo monetario associato ad esso.

È importante quindi riuscire a trovare il percorso che ha costo minimo.

## Algoritmo d'instradamento con vettore distanza (Distance Vector DV)
Questo algoritmo è:
- Distribuito - Ogni nodo riceve informazioni dai vicini e opera su quelle
- Asincrono - Non richiede che tutti i nodi operino al passo con gli altri

Questo si basa sull'equazione di Bellman - Ford e sul concetto di vettore di distanza.

### Equazione di Bellman - Ford
Definisce $D_{x}(y):=$ il costo del percorso a costo minimo dal nodo $x$ al nodo $y$

$$
D_{x}(y)=min_{v}(c(x,v)+D_{v}(y))
$$

Dove:
- $min_{v}$ riguarda tutti i vicini di $x$

Rappresentazione grafica:

![[Pasted image 20250425203433.png|400]]

### Vettore distanza
Un albero a costo minimo è una combinazione di percorsi a costo minimo dalla radice dell'albero verso tutte le destinazioni, un vettore di distanza è un array monodimensionale che rappresenta l'albero.

Questo vettore non ci fornisce quindi i percorsi da percorrere ma solo il costo della distanza minima:

![[Screenshot 2025-04-25 alle 20.37.08.png|400]]

Come creiamo questo vettore distanza?

Ogni nodo della rete quando viene inizializzato crea un vettore distanza iniziale con le informazioni che riesce ad ottenere dai vicini. Per fare questo invia dei messaggi di *hello* attraverso tutte le sue interfacce e scopre l'identità e il costo per raggiungere i suoi vicini.

Dopo che un nodo ha creato il suo vettore invia una copia ai suoi vicini.

A questo punto quando un nodo riceve un vettore da un suo vicino aggiorna il suo vettore applicando l'equazione di Bellman-Ford.

_Esempio_

![[Screenshot 2025-04-25 alle 21.44.00.png|400]]

Cosa succede quando B riceve una copia del vettore di A?

![[Pasted image 20250425214555.png|300]]

---

Quando un nodo riceve una copia di un vettore e questo porta a degli aggiornamenti all'interno del suo vettore, allora anche questo nodo rimanda il suo nuovo vettore a tutti i vicini.

Quindi, ciascun nodo:
- Attende un messaggio da parte di un vicino
- Effettua il calcolo
- Se il vettore cambia notifica i vicini e torna in attesa

Quindi possiamo costruire un algoritmo:

```
per tutte le destinazioni y in N:
	se y è un vicino
		D_x (y) = c(x,y)
	else
		D_x (y) = inf
per ciascun vicino w
	invia il vettore D_x = [D_x(y): y in N] a w
```

Questo algoritmo presenta però un problema, il problema del **conteggio all'infinito**:

![[Pasted image 20250425215144.png|400]]

Quindi ci vuole molto tempo prima che ci si renda conto di un guasto sulla rete, questo perché le informazioni devono propagarsi fra tutti e in questo algoritmo una "cattiva" notizia viaggia più lentamente di una "buona notizia".

Ci sono alcune soluzioni a questo problema:
- **Split Horizon** - Si invia solo una parte della propria tabella di routing, se il nodo B ritiene che il percorso ottimale per raggiungere un nodo X passi attraverso A, allora non deve fornire questa informazione ad A infatti lui la conosce già. Nell'esempio di prima quindi B dovrebbe eliminare la riga di X prima di inviare la tabella ad A.
- **Poisoned Reverse** - Si pone a infinito il valore del costo del percorso che passa attraverso il vicino a cui si sta inviando il vettore. Nell'esempio quindi B deve porre a infinito il costo verso X quando invia il vettore ad A.

## Protocollo RIP
In questo protocollo il costo dei collegamenti è dato dalla distanza misurata in hop da attraversare.

Al massimo si possono passare 15 hop, 16 indica infinito.

- Tabelle di Routing:

![[Pasted image 20250425215834.png|500]]

In questo protocollo ogni router, ad intervalli di tempo, invia la sua tabella di routing agli altri router. In questo modo gli altri possono aggiornare le proprie tabelle e notificare a loro volta altri router.

### Messaggi RIP
Il RIP si basa su una coppia di processi client - server e sul loro scambio di messaggi.

- **RIP Request** - Quando un router viene inserito nella rete invia una RIP request per ricevere informazioni di routing
- **RIP response (advertisements)** - Possono essere inviate o in risposta ad una request oppure periodicamente ogni 30 secondi.

Ma come sono strutturati i messaggi?

![[Pasted image 20250425220237.png|400]]

- Com - comando, indica se è una richiesta o una risposta
- Ver - versione del protocollo
- Family - Famiglia del protocollo, per TCP / IP il valore è 2
- Tag - Informazioni sul sistema autonomo
- Network Address - Indirizzo di destinazione
- Subnet Mask - Maschera di sottorete ovvero la lunghezza del prefisso
- Next - hop address - indirizzo del prossimo hop
- Distance - numero di hop fino alla destinazione

Il RIP inoltre utilizza alcuni timer:
- Timer periodico - Gestisce l'invio dei messaggi di aggiornamento, di solito ogni 25-35 secondi
- Timer di scadenza - Regola la validità dei percorsi (ogni 180 secondi), se non riceve aggiornamenti da un router entro lo scadere del timer imposta il costo verso esso a 16
- Timer per garbage collection - Elimina i percorsi dalla tabella (ogni 120 secondi), elimina i percorsi con costo 16.

---

Cosa succede quando si verifica un guasto nei collegamenti?
- Ci si accorge del guasto con il timer di scadenza
- RIP modifica la tabella d'instradamento locale
- Propaga la tabella ai router vicini
- I vicini inviano nuovi messaggi e l'informazioni si propaga nella rete
- Per evitare i loop si usa la poisoned reverse


> [!infi] Caratteristiche generali
> - Come visto prima evita i loop
> - **Triggered Updates** - Riduce il problema della convergenza lenta, quando una rotta cambia non si aspetta la fine del timer ma si inviano subito le tabelle
> - **Hold-down** - Fornisce robustezza, quando si riceve una informazione di una rotta non più valida si avvia un timer e tutti gli advertisement che arriveranno riguardanti quella rotta verrano ignorati.

---

Il protocollo RIP anche se protocollo di rete è implementato a livello applicazione, usa il protocollo UDP sulla porta 520.

Tramite un processo chiamato **routed** si mantengono le informazioni d'instradamento e lo scambio dei messaggi con i processi dei router vicini.

Dato che ci troviamo sul livello applicazione per quanto riguarda l'implementazione, possiamo inviare e ricevere messaggi su una socket standard e utilizzare un protocollo di trasporto standard.
