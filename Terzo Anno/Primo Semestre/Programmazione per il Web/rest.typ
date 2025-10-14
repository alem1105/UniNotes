#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= REST (Representional State Transfer)
REST è uno stile architetturale pensato per trasferire *la rappresentazione* delle risorse da un componente ad un altro, ad esempio client e server.

Per risorsa intendiamo una qualsiasi informazione che può essere nominata, quindi documenti, immagini, servizi ecc...
Una risorsa è un insieme di elementi o valori che possono variare nel tempo e per questo, in un dato momento, due risorse potrebbero mappare gli stessi valori, ad esempio due versioni diverse dello stesso programma.

Per *rappresentazione* della risorsa intendiamo lo stato attuale o previsto ovvero il suo valore in un particolare momento, le rappresentazioni vengono usate dai *componenti REST* per eseguire azioni sulle risorse. Una rappresentazione è composta da *dati e metadati*, il formato dei dati è noto come *media type*.

Per identificare una risorsa utilizziamo gli *URI (Uniform Resource Identifier)* ovvero una sequenza unica di caratteri, ad esempio _"http://example.com/users"_

Per dare dei nomi alle URI esistono delle *best practices*:
- Usare sostantivi per rappresentare le risorse
- Utilizzare sostantivi singolari per una singola risorsa, ad esempio _"http://example.com/users/admin"_ 
- Utilizzare sostantivi plurali per una collezione di risorse, ad esempio _"http://example.com/users/"_

Inoltre ci sono anche delle convenzioni:
- Utilizzare *forward slash (/)* per esprimere le gerarchie, usare il _trailing slash_ solo se la risorsa non è una foglia
- Preferire i trattini agli underscore
- Utilizzare solo lettere minuscole
- Non utilizzare estensioni di file (verranno indicate negli header)
- Utilizzare la componente query per filtrare, ad esempio _"http://example.com/managed-devices/?region=USA"_

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
  title: [*Esempi di notazione*],
  [
    #align(center, image("img/image.png", width: 80%))
  ]
)

Le URI sono usate per identificare in modo univoco le risorse e non le azioni su di esse, infatti azioni diverse possono essere eseguite su una risorsa attraverso i metodo supportati ma sempre attraverso la stessa URI, possiamo usare ad esempio _GET, PUT, DELETE_ sulla URI _"http://example.com/managed-devices/{id}"_

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
  title: [*Esempio di richiesta in Python*],
  [
    ```python
    import requests

    base_url = "..."
    query_params = {
      "country": "Italy", "min_price": 50.00,
      "sort_by": "price_asc"
    }
    response = requests.Request("GET", base_url, params=query_params).prepare()
    print(f"URI generato con Query: {response.url}")
    ```

    _requests_ ci aiuta ad assemblare delle richieste, noi dobbiamo soltanto fornire tutti i dati e lui ci restituisce l'uri.
  ]
)

== Vincoli di un sistema RESTful
1. *Client - Server*: Il client si occupa della UI mentre il server dell'archiviazione dati, serve a migliorare la portabilità, la scalabilità e a separare le responsabilità.
2. *Stateless*: Ogni richiesta che fa il client deve contenere tutte le informazioni per essere compresa, non bisogna utilizzare dati già presenti sul server lasciati da richieste precedenti.
Lo stato della sessione è mantenuto interamente sul client mentre quello delle risorse sul server.
3. *Cacheable*: Il client può memorizzare e riutilizzare rappresentazioni delle risorse, la risorsa deve essere identificata come *cacheable* e nella risposta è indicato anche per quanto tempo può venire memorizzata.
4. *Uniform Interface*: Standardizzare l'interfaccia fra tutti i componenti anche andando a perdere efficienza, le interfacce presentano 4 vincoli:
- Identificazione delle risorse
- Manipolazione delle risorse tramite rappresentazione
- Messaggi auto-descrittivi
- _Hypermedia come motore dello stato dell'applicazione_, il client ha bisogno sono dell'URI iniziale, poi deve essere in grado di trovare le altre risorse tramite quello.
Ad esempio le API REST basate su HTTP utilizzano metodi standard come GET, POST, PUT e gli URI per identificare le risorse.
5. *Layered System*: In una comunicazione non troviamo soltanto client e server ma anche altri dispositivi come proxy, questi componenti possono agire sia da client che da server infatti possono inoltrare sia risposte che richieste. Ogni componente però può osservare soltanto i dispositivi adiacenti a lui e non cosa c'è oltre.

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
  title: [*Metodi HTTP vs REST*],
  [
    #align(center, image("img/image1.png", width: 80%))
    Gli URI identificano la *risorsa* che vogliamo manipolare mentre i metodi indentificano l'*azione* che vogliamo eseguire sulla risorsa.

    Per CRUD intendiamo le operazioni di base *Create, Read, Update, Delete*
  ]
)

*Codici di Successo*:
- *200 OK*: Utilizzato in richieste _PUT, GET, PATCH o DELETE_ eseguite con successo.
- *201 Created: MUST* Viene restituito da un _POST_ effettuato con successo, dovrebbe restituire anche la risorsa appena creata.
- *204 No Content*: L'azione ha avuto successo ma non ci sono dati nella risposta.

*Codici di errore client*:
- *400 Bad Request*: Richiesta non soddisfacibile per un errore del client, di solito errori di formattazione.
- *401 Unauthorized*: Manca l'autenticazione.
- *403 Forbidden*: Utente autenticato ma non ha i permessi per svolgere quell'azione.
- *404 Not Found*: Risorsa non esistente.

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
  title: [*Esempi*],
  [
    - *Ottenere dati*: Ottenere tutti i dati di prodotti in vendita
    ```http
    GET /products
    ```

    - *Creare una nuova risorsa*: Aggiungere un nuovo utente
    ```http
    POST /users
    ```
    Il corpo della richiesta conterrà i dati dell'utente. Come risposta ci aspettiamo la nuova risorsa appena creata e l'URI per accedervi.
  ]
)

Se un'azione però non è mappabile nelle operazioni CRUD, come ad esempio _"Pubblica un documento" o "Cambia una password"_ possiamo seguire due approcci:
- *Modellare l'azione come una risorsa*, ad esempio pubblicare un documento potrebbe diventare:
```http
POST /documents/{id}/publish
```
- *Utilizzare PATCH*, serve ad aggiornare un attributo di stato, ad esempio pubblicare un documento aggiornando lo stato:
```http
PATCH /documents/{id}
```
E inseriamo come corpo `{'status': 'published'}`

Il secondo approccio è preferito perché mantiene un modello più puro dove si agisce soltanto sullo stato della risorsa.