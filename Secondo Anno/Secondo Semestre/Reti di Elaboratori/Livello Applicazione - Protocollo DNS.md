# Identificazione degli Host
Gli Host Internet hanno dei nomi che sono facili da ricordare anche per noi umani, ad esempio `www.google.com`, il problema è che forniscono poche informazioni sulla loro posizione nella Interne.

Utilizziamo quindi gli **Indirizzi IP**

## Indirizzi IP
Sono composti da 32 bit e vengono usati per indirizzare i datagrammi, per noi umani sono più scomodi da usare ma sono più adatti alla macchine.

Possiamo rappresentarlo come una stringa dove ogni byte (4 byte = 32 bit) rappresenta un numero decimale compreso tra 0 e 255 ed ognuno di questi 4 numeri è separato da un `.`, ad esempio: `121.34.230.94`

Questo formato serve anche a creare una gerarchia negli indirizzi infatti vedremo che tramite l'indirizzo IP possiamo ricavare la rete di appartenenza e l'indirizzo del nodo.

Ma quindi come facciamo da un indirizzo IP a ricavare un hostname facilmente utilizzabile da noi umani? Utilizziamo il **DNS (Domain Name System)**.

# DNS
Il protocollo DNS serve quindi ad associare ad un indirizzo IP un nome host, notiamo però che con l'indirizzo IP possiamo rappresentare $2^{32}$ indirizzi in totale e tutte queste coppie devono essere accessibili, ma come fa il DNS a memorizzarli tutti?

Per quanto riguarda la memorizzazione:
- Si utilizza un **database distribuito** su una gerarchia di server DNS
Per quanto riguarda l'accessibilità:
- Si usa un **protocollo a livello applicazione** che consente agli host di interrogare i database dei server ed eseguire le traduzioni

Il DNS viene utilizzato anche dagli altri protocolli di livello applicazione per tradurre gli hostname e utilizza come protocollo per il trasporto l'UDP dato che ci serve più velocità che sicurezza per questo tipo di dati, di base utilizza la porta 53.

Utilizziamo UDP perché come vedremo più avanti abbiamo meno overhead ovvero pacchetti aggiuntivi utilizzati non per trasmettere dati ma per gestire le connessioni. Infatti i messaggi DNS sono molto corti e una connessione TCP richiede più tempo, inoltre questa connessione verrebbe usata per scambiare un solo messaggio.

_In generale (Esempio con HTTP)_:
1) Un client HTTP richiede un URL ad esempio `www.google.com`
2) Il browser prende il nome dell'host dall'URL e lo passa al lato client DNS
3) Il client DNS invia una query ad un server DNS
4) Il client DNS riceve una risposta che contiene l'indirizzo IP corrispondente all'hostname
5) Adesso il browser può dare inizio alla connessione TCP verso il server HTTP localizzato a quell'indirizzo IP

Il DNS quindi non è un'applicazione vera e propria utilizza dall'utente, la usa ma non direttamente diciamo che non sa di usarla.

Il DNS offre anche altri tipi di servizi oltre a questa traduzione.

## Servizi DNS: Aliasing
Questo permette di associare un nome (o più di uno) più semplice ad un nome più complesso, ad esempio `server1.euw.azienda.com` potrebbe avere dei sinonimi più semplici come `azienda.com`.

Quindi il primo, più "complesso" è l'**hostname canonico** mentre il secondo si chiama **alias**. Il funzionamento è uguale a quello per la traduzione tra indirizzo IP e nome host, quindi un client se chiede un alias riceverà nome canonico e indirizzo IP.

Di solito questo servizio viene utilizzato per i server mail delle aziende dove sia mail che web server hanno lo stesso alias ma nomi canonici diversi.

## Servizi DNS: Distribuzione del Carico
Spesso le grandi aziende non hanno un unico server perché potrebbe rallentare notevolmente il servizio che offrono.

Anche in questo caso il DNS può aiutarci, l'azienda può creare più server uguali sparsi per il mondo tutti con indirizzi IP diversi e a tutti questi viene associato lo stesso hostname canonico.

Quando un server DNS viene interrogato questo restituisce tutti gli indirizzi ma in ordine diverso in modo da spartire il traffico su più server, inoltre se uno non è funzionante possiamo sempre collegarci ad un altro

## Gerarchia Server DNS
Inizialmente il DNS doveva tradurre pochi indirizzi e in poche reti, era sufficiente quindi salvarli in un file di testo che veniva aggiornato ogni notte.

Adesso è un'applicazione che gira su un gran numero di server sparsi per il mondo, ma non può essere centralizzato?

No, per vari motivi:
- Se crasha il server, Internet diventa praticamente inutilizzabile
- Troppe richieste da gestire per un singolo server
- Un solo server non potrà mai essere vicino ad ogni client del mondo e quindi rallenterebbe le persone più lontane
- Il server va aggiornato spesso per aggiungere nuovi nomi e con uno singolo sarebbe molto difficile anche mantenerlo online

Un server centralizzato, in questo caso, **non è scalabile**.

Come detto prima, si utilizza una gerarchia di server, in questo modo:
- Nessun server deve mantenere tutti le coppie hostname - indirizzo IP
- Mapping (traduzione) distribuito su svariati server
- Ma come memorizziamo le $2^{32}$ coppie in modo da renderle velocemente accessibili da tutti i client?

Raggruppiamo i nomi in base al dominio, ad esempio:
- `www.uniroma1.it
- `www.google.com`
- `www.unipi.it`
- `www.cnr.it`
- `www.umass.edu`

Possiamo quindi raggruppare in un server solo gli indirizzi `.it` in uno solo quelli `.com` e così via...

Organizziamo i server in 3 livelli:
1) Root
2) Top-level Domain (TLD)
3) Authoritative

Infine troviamo i server locali delle applicazioni che sono quelli che fanno le richieste.

![[Pasted image 20250316103130.png]]

Quindi se ad esempio richiediamo la pagina `www.amazon.com`:
1) La richiesta arriva al server root il quale gli dirà dove trovare il server `.com`
2) Il server TLD gli dirà dove trovare il server `amazon.com`
3) Il server di amazon gli dirà dove trovare `www.amazon.com`

> [!info] Server DNS nel mondo
> In Internet ci sono 13 server DNS radice e dato che sono replicati in totale abbiamo 247 server.
> 
> ![[Pasted image 20250316103516.png]]

### Server TLD
Sono i server che si occupano dei domini `com, org, net, edu...`, ad esempio in Italia abbiamo il `Registro.it` che ha sede a Pisa nel CNR e gestisce il dominio `.it`

> [!info]- Etichette dei domini
> ![[Pasted image 20250316103827.png]]
### Server di Competenza (authoritative server)
Ogni organizzazione avrà il suo authoritative server in modo da rendere pubblici i suoi hostname, questi sono gestiti direttamente dall'organizzazione e di solito ce ne sono due, uno primario e uno secondario.

### Server DNS locale
Questo non appartiene direttamente alla gerarchia dei server dato che sono interni agli ISP o organizzazioni, questo è anche detto **default name server**. Quando un host effettua una richiesta DNS la query viene inviata al suo server DNS locale, questo agisce come un proxy e inoltra la query in una gerarchia di server.

---

Ci sono diversi modi in cui possiamo gestire le query all'interno della gerarchia

## Query Iterativa
Con questo meccanismo, l'host che fa la richiesta la inoltra al server DNS locale il quale farà gran parte del lavoro, ovvero chiederà prima al server root il quale gli dirà dove trovare il TLD poi questo gli dirà dove trovare il server authoritative dove finalmente troverà la pagina e la restituirà all'host:

![[Pasted image 20250316104854.png|400]]

Notiamo che per fare la mappatura di un hostname sono stati inviati 8 messaggi.

## Query Ricorsiva
In questo modo alleggeriamo il server locale e lasciamo il compito della traduzione all'ultimo server contattato:

![[Pasted image 20250316105019.png|400]]

## DNS: Caching
Anche con questa tecnologia possiamo effettuare caching per aumentare le prestazioni e ridurre il ritardo facendo diminuire il numero di messaggi che rimbalzano per l'Internet.

Dopo che un server ha eseguito una mappatura questa viene mantenuta per un certo periodo di tempo, spesso infatti i server locali memorizzano i server TLD o locali e quelli root vengono visitati poco.

## DNS: record e messaggi
Il mapping è mantenuto all'interno di server sottoforma di **resource record (RR)**, ognuno di questi mantiene un mapping tra hostname, indirizzo IP, alias, nome canonico e altro.

I server quindi si scambiano questi record attraverso i messaggi DNS, un messaggio può contenere più RR.

### Record DNS
Questi sono memorizzati all'interno del database e vengono trasportati dai messaggi, hanno questa struttura:

- `(Name, Value, Type, TTL)`  dove:
	- TTL è il tempo residuo di vita
	- Type ha vari valori e a seconda di questi fa cambiare il significato di `name` e `value`

Se Type vale `A`:
- Allora il record contiene una mappatura Hostname -> IP **a**ddress e quindi troveremo sul campo `name` l'hostname e sul campo `value` l'indirizzo IP

Se Type vale `CNAME`:
- Si tratta di una traduzione fra alias e nome canonico, avremo su `name` l'alias e su `value` il nome canonico

Se Type vale `NS`:
- Il record mappa un dominio in un name server quindi avremo su `name` il dominio come ad esempio `uniroma1.it` e su `value` il nome dell'host del server authoritative di quel dominio come ad esempio `di.uniroma1.it`

Se Type vale `MX`:
- Si sta mappando Alias -> nome canonico del mail server, quindi avremo che `value` è il nome canonico del server di posta associato a `name`

In generale:

![[Pasted image 20250316110630.png]]

### Messaggi DNS
Le query e le risposte hanno lo stesso formato nel protocollo DNS.

Abbiamo un'intestazione da 12 byte che comprende:
- Identificazione: numero di 16 bit per la domanda e la risposta usa lo stesso numero
- Flag che indicano:
	- Domanda o Risposta
	- Richiesta di ricorsione
	- Ricorsione disponibile
	- Risposta di competenza (se il server non è competente per quel nome)
- Numero di:
	- Domande
	- RR di risposta
	- RR autorevoli
	- RR addizionali

Fuori l'intestazione troviamo i blocchi per le informazioni che ci erano state date nella sezione "**numero di**".

- Domande: Campi per il nome richiesto e il tipo di domanda (A, MX, NS...)
- Risposte: RR per la risposta, se abbiamo replicati ci saranno più RR
- Competenza: Record per i server di competenza
- Informazioni aggiuntive: Informazioni extra che possono essere utili come ad esempio in una risposta MX dove il campo risposta contiene il record MX con il nome canonico del server di posta mentre in questo campo aggiuntivo c'è un record di tipo A con l'indirizzo IP relativo all'hostname canonico del server di posta.

![[Pasted image 20250316112019.png]]

## Inserire record nel database DNS
Se ad esempio abbiamo appena creato una nuova società chiamata `Network Stud` e vogliamo registrare il nostro dominio all'interno di un DNS dobbiamo contattare un registrar ovvero delle aziende accreditate dall'ICANN che verificherà la disponibilità del nome e lo inserirà nel database.

Ma come avviene questa registrazione?

1) Prima cosa dobbiamo fare quanto detto prima e contattare un registrar
2) Inseriamo in un nostro server DNS che sarà il server di competenza (ad esempio `dns1.networkstud.it`) un record di tipo `A` per `www.networkstud.it` e un record di tipo `MX` per `networkstud.it` 

Otteniamo quindi:
- **A Record**: `www.networkstud.it` -> `150.160.15.12` per il server web
- **MX Record**: `networkstud.it` -> `mail.networkstud.it` per la posta
- **CNAME Record**: `mail.networkstud.it` -> `mail.google.com` se si usa Gmail

3) A questo punto possiamo fornire al registrar i nomi e gli indirizzi dei nostri server DNS primari e secondari
4) Il Registrar inserirà due RR nel server TLD `.it`:
	- `(networkstud.it, dns1.networkstud.it, NS)`
	- `(dns1.networkstud.it, 212.212.212.1, A)`

_Esempio_

![[Pasted image 20250316113231.png]]

---

Si possono interrogare i server DNS con il comando `nslookup` dal terminale ad esempio:
 - `nslookup www.di.uniroma1.it` - per cercare nei server DNS impostati di default gli indirizzi associati a `www.di.uniroma1.ti`
 - `nslookup -type=NS uniroma1.it` - per restituire soltanto i tipi di record `NS` associati a `uniroma1.it`
 - `nslookup -type=NS .` - per restituire i record `NS` del server radice ovvero `.`

