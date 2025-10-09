#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()
#import "@preview/ilm:1.4.1": *

= HTTP (HyperText Transfer Protocol)
E' un protocollo a livello applicazione nello stack TCP / IP. La sua variante più sicura si chiama *HTTPS*.

Si basa sul concetto di *client e server*, il client è chi richiede dei servizi o risorse mentre il server è chi le offre.

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
  title: [*User Agent (UA)*],
  [
    E' una qualsiasi applicazione del client che avvia una richiesta, ad esempio il browser web, un'app ecc...
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
  title: [*Origin Server (O)*],
  [
    Un programma che può originare risposte autorevoli per una data risorsa, ad esempio un sito web.
  ]
)

#showybox(
  frame: (
    border-color: blue.lighten(60%),
    title-color: blue.lighten(60%),
    body-color: white
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Esempio di Richiesta*],
  [
    ```http
    GET /hello.txt HTTP/1.1
    User-Agent: curl/7.64.1
    Host: [www.example.com](https://www.example.com)
    Accept-Language: en, it
    ```
    - La prima è la *linea di richiesta* dove viene indicato il metodo HTTP, in questo caso GET, l'URI della risorsa e la versione del protocollo.
    - Vari campi di intestazione, ad esempio *User-Agent*.
    - Corpo del messaggio opzionale.
  ]
)

#showybox(
  frame: (
    border-color: blue.lighten(60%),
    title-color: blue.lighten(60%),
    body-color: white
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Esempio di Risposta*],
  [
    ```http
    HTTP/1.1 200 OK
    Date: Mon, 27 Jul 2009 12:28:53 GMT
    Server: Apache
    Last-Modified: Wed, 22 Jul 2009 19:15:56 GMT
    ETag: "34aa387-d-1568eb00"
    Accept-Ranges: bytes
    Content-Length: 51
    Vary: Accept-Encoding
    Content-Type: text/plain
    Hello World! My content includes a trailing CRLF.
    ```
    - In questo caso abbiamo un codice che indicato lo stato della richiesta.
    - Contenuto, opzionale.
  ]
)

Ci sono altri due elementi che possiamo trovare in una connessione HTTP:

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
  title: [*Intermediari*],
  [
    Sono altri nodi presenti tra il client e il server, ad esempio dei proxy.
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
  title: [*Cache*],
  [
    E' una archivio di vecchi messaggi di risposta. Quindi se ad esempio un nodo che si trova in mezzo ad una comunicazione già conosce la risposta ad una richiesta può subito inviarla.

    Per fare in modo che i client memorizzino le risposte il server deve inviare delle risposte con l'header *cacheable*.

    Dispositivi come i proxy possono memorizzare risposte mentre i *tunnel* no.
  ]
)

== Metodi HTTP 
I metodi che possiamo utilizzare con il protocollo sono:
- GET
- HEAD
- POST
- PUT
- DELETE
- CONNECT
- OPTIONS
- TRACE
- PATCH

I metodi hanno delle proprietà:
- *SAFE*: Un metodo che non ha effetti collaterali sulla risorsa, agisce in sola lettura. Può comunque cambiare lo stato dei server ad esempio creando nuovi file (log). GET, HEAD, OPTIONS e TRACE sono metodi SAFE.
- *IDEMPOTENT*: Richieste identiche multiple con quel metodo hanno lo stesso effetto di una sola richiesta. Ad esempio PUT e DELETE sulle stesse risorse sono idempotenti.
- *CACHEABLE*: Sono i metodi che permettono ad una cache di memorizzare una risposta. GET, HEAD e POST sono CACHEABLE (ma non sempre).

=== PUT
Serve a creare una nuova risorsa nel server, va specificata nella richiesta. Se questa risorsa già esiste allora la sovrascrive.

Come detto prime è IDEMPOTENTE quindi qualsiasi PUT identica e successiva ad un'altra non modifica la risorsa.

Non è sicuro e non è nemmeno salvabile in cache.

```http
PUT /course-descriptions/web-and-software-architecture
```

=== GET
Richiede una risorsa dal server.

```http
GET /course-descriptions/web-and-software-architecture
```

E' safe dato che non modifica la risorsa, cacheable quindi non serve che il server la rispedisca ad ogni richiesta e questa memorizzazione può avvenire sotto determinate condizioni come ad esempio dei timer.
Non è idempotente, quindi richieste successive anche se identiche modificano la risorsa.

=== POST
Serve ad inviare dati al server o ad aggiornare quelli già presenti.

```http
POST /announcements/
POST /announcements/{id}/comments/
POST /users/{id}/email
```

La risposta può essere memorizzata in cache, ma non è sicuro nè idempotente.

=== DELETE
Si invia al server una richiesta per cancellare una determinata risorsa.

```http
DELETE /courses/web-and-software-architecture
```

Non è safe ma è idempotente.

=== Altri metodi
- HEAD: Funziona come il GET ma non trasferisce il contenuto della richiesta, soltanto gli header.
- CONNECT: Stabilisce un tunnel verso il server indicato dalla risorsa target.
- OPTIONS: Descrive le opzioni di comunicazione per la risorsa target.
- TRACE: Esegue un test di loop-back del messaggio in lungo tutto il percorso verso la risorsa target.

== Codici di Stato
Negli esempi precedenti abbiamo visto una risposta che iniziava con:

```http
HTTP/1.1 200 OK
```

Il codice serve a descrivere il risultato della richiesta. Tramite questo possiamo capire, ad esempio:
- Se la richiesta ha avuto successo
- Se ci sono contenuti allegati

I codici sono formati da 3 cifre nell'intervallo 100-599, la prima cifra indica la categoria generale.

- `1xx` (Informational): La richiesta è stata ricevuta ed è in esecuzione.
- `2xx` (Successful): La richiesta è stata ricevuta, compresa ed eseguita con successo.
- `3xx` (Redirection): Sono necessarie ulteriori azioni per completare la richiesta.
- `4xx` (Client error): La richiesta contiene sintassi errata oppure non può essere soddisfatta.
- `5xx` (Server error): Il server non è riuscito a soddisfare una richiesta apparentemente valida.

=== 2xx Successful
- `200 OK`: In una richiesta GET la risposta conterrà la risorsa richiesta. In una POST la risposta conterrà qualcosa che descrive il risultato dell'azione.
- `201 Created`: La richiesta è stata soddisfatta.
- `204 No Content`: Il server ha elaborato con successo la richiesta ma non sta restituendo dati.

=== 3xx Redirection
- `301 Moved Permanently`: Questa richiesta ma anche le successive dovrebbe essere reindirizzato all'URI fornito.
- `302 Found`: Visita un'altra URL.

=== 4xx Client Error 
- `400 Bad Request`: Errore del client
- `401 Unauthorized`: Serve un'autenticazione
- `403 Forbidden`: La richiesta è stata compresa dal server e quindi è valida ma l'azione richiesta non è permessa.
- `404 Not Found`: La risorsa non è stata trovata.
- `405 Method not Allowed`: Il metodo richiesto non è supportato.

=== 5xx Server Error 
- `500 Internal Server Error`: Errore del server 
- `501 Not Implemented`: Il metodo richiesto non è riconosciuto o il server non è in grado di soddisfare la richiesta.
- `502 Bad Gateway`: Un gateway o un proxy hanno ricevuto una risposta non valida dal server.
- `503 Service Unavailable`: Server sovraccarico o spento.
- `504 Gateway Timeout`: Il server non ha ricevuto una risposta in tempo dal server a monte.

= API Pubbliche
Ci permettono di capire come inviare delle richieste ad un server.

Tramite il comando `curl` possiamo effettuare richieste tramite il terminale. Se non indichiamo un metodo di default verrà utilizzato il GET.

```http
curl https://swapi.dev/api/people/1/
```

Se vogliamo ad esempio effettuare un POST:

```http
curl -X POST -H "Content-Type:
application/json" -d '{"title": "Test"}'
https://jsonplaceholder.typicode.com/posts
```