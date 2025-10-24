#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= Open API
La Specifica OpenAPI è una specifica per file di interfaccia utilizzata per descrivere servizi web RESTful. Un documento OpenAPI rappresenta una descrizione formale di un'API, che può essere utilizzata da diversi strumenti per generare codice, documentazione, test case e altro ancora.

Durante il corso utilizzeremo l'editor online _swagger_.

_Esempio di una specifica OpenAPI_:

(Lo metto in modo che può tornarmi utile in futuro come base per altre API :P)

```yaml
openapi: 3.0.0
info:
  title: API Nasoni di Roma
  description: |
    API per la gestione e la consultazione delle fontane (Nasoni) di Roma.
    Permette di registrare nuove fontane, aggiornarne lo stato e filtrare
    per posizione geografica.
  version: 1.0.0
servers:
  - url: https://api.nasoniroma.it/v1
    description: Server principale dell'API

# ===============================================
# SEZIONE 1: ANALISI E SCHEMI (components)
# ===============================================
components:
  schemas:
    # Nuovo Schema per l'ID, ora riutilizzato in Fountain e FountainID Parameter
    FountainIdSchema:
      type: integer
      format: int64
      description: ID univoco assegnato dal server.
      readOnly: true
      example: 12345

    # Schemi riutilizzabili per Latitudine e Longitudine
    Latitude:
      type: number
      format: float
      description: Latitudine in gradi decimali.
      minimum: -90
      maximum: 90
      example: 41.89025

    Longitude:
      type: number
      format: float
      description: Longitudine in gradi decimali.
      minimum: -180
      maximum: 180
      example: 12.49237

    Range:
      type: number
      format: float
      description: Raggio (in metri o km) per il filtro di vicinanza.
      minimum: 0

    # Task 1.1: Definizione dello Schema "Fountain"
    Fountain:
      title: Dettagli Fontana
      description: Rappresentazione completa di una risorsa Fontana (Nasone).
      type: object
      properties:
        # USA IL RIFERIMENTO ALLO SCHEMA ID
        id:
          $ref: '#/components/schemas/FountainIdSchema'
        state:
          type: string
          description: Stato di funzionamento della fontana.
          enum:
            - good
            - faulty
          example: good
        latitude:
          $ref: '#/components/schemas/Latitude'
        longitude:
          $ref: '#/components/schemas/Longitude'
      required:
        - state
        - latitude
        - longitude

    Error:
      type: object
      properties:
        code:
          type: string
          example: "NOT_FOUND"
        message:
          type: string
          example: "La risorsa richiesta non è stata trovata."

  parameters:
    # Task 1.2: Definizione del Parametro "FountainID"
    FountainID:
      name: id
      in: path
      description: ID univoco della fontana (Nasone) nel percorso.
      required: true
      # USA IL RIFERIMENTO ALLO SCHEMA ID
      schema:
        $ref: '#/components/schemas/FountainIdSchema'
      # L'esempio del parametro è definito nello schema referenziato.
      
  responses:
    NotFound:
      description: Risorsa non trovata (404 Not Found)
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          examples:
            fountainNotFound:
              value:
                code: "NASONE_404"
                message: "Nessuna fontana trovata con l'ID specificato."
    BadRequest:
      description: Richiesta non valida (400 Bad Request)
      content:
        application/json:
          schema:
            $ref: '#/components/schemas/Error'
          examples:
            invalidInput:
              value:
                code: "VALIDATION_ERROR"
                message: "I dati forniti non sono validi. Controllare vincoli e campi richiesti."


# ===============================================
# SEZIONE 2: DEFINIZIONE DEI PATH
# ===============================================
paths:
  # Task 2.1: Operazioni sulla Collezione (/fountains)
  /fountains:
    post:
      operationId: createFountain
      summary: Creazione di una Nuova Fontana
      description: Registra una nuova fontana nel sistema. L'ID viene assegnato dal server.
      requestBody:
        description: Dati della nuova fontana. L'ID non deve essere incluso.
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Fountain'
      responses:
        '201':
          description: Fontana creata con successo
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Fountain'
        '400':
          $ref: '#/components/responses/BadRequest'

    get:
      operationId: listFountains
      summary: Elenco delle Fontane (con Filtri di Vicinanza)
      description: Restituisce l'elenco delle fontane. Può essere filtrato per vicinanza a un punto specifico.
      parameters:
        - name: latitude
          in: query
          description: Latitudine del punto di riferimento per il calcolo della vicinanza.
          required: false
          schema:
            $ref: '#/components/schemas/Latitude'
        - name: longitude
          in: query
          description: Longitudine del punto di riferimento per il calcolo della vicinanza.
          required: false
          schema:
            $ref: '#/components/schemas/Longitude'
        - name: range
          in: query
          description: Raggio in metri (o unità definite) entro cui cercare le fontane (richiede latitude e longitude).
          required: false
          schema:
            $ref: '#/components/schemas/Range'
      responses:
        '200':
          description: Elenco delle fontane restituito con successo
          content:
            application/json:
              schema:
                type: array
                items:
                  $ref: '#/components/schemas/Fountain'
        '400':
          $ref: '#/components/responses/BadRequest'

  # Task 2.2: Operazioni sulla Risorsa Specifica (/fountains/{id})
  /fountains/{id}:
    parameters:
      - $ref: '#/components/parameters/FountainID'

    put:
      operationId: updateFountain
      summary: Aggiornamento Completo di una Fontana
      description: Sostituisce completamente la risorsa fontana con l'ID specificato con i dati forniti.
      requestBody:
        description: Dati completi della fontana per la sostituzione (l'intero oggetto).
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/Fountain'
      responses:
        '200':
          description: Risorsa fontana aggiornata e restituita.
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Fountain'
        '404':
          $ref: '#/components/responses/NotFound'
        '400':
          $ref: '#/components/responses/BadRequest'

    delete:
      operationId: deleteFountain
      summary: Eliminazione di una Fontana
      description: Elimina la risorsa fontana con l'ID specificato.
      responses:
        '204':
          description: Fontana eliminata con successo (No Content)
        '404':
          $ref: '#/components/responses/NotFound'

    patch:
      operationId: partialUpdateFountain
      summary: Aggiornamento Parziale di una Fontana
      description: Applica aggiornamenti parziali ai campi forniti (es. solo lo stato).
      requestBody:
        description: Proprietà della fontana da aggiornare (solo i campi specificati vengono modificati).
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                state:
                  $ref: '#/components/schemas/Fountain/properties/state'
                latitude:
                  $ref: '#/components/schemas/Latitude'
                longitude:
                  $ref: '#/components/schemas/Longitude'
      responses:
        '200':
          description: Aggiornamento parziale applicato con successo
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Fountain'
        '404':
          $ref: '#/components/responses/NotFound'
        '400':
          $ref: '#/components/responses/BadRequest'
```

Vediamo alcune informazioni e best practices per Open API.

1) Il campo *required* definisce le regole di validazione del payload e non il comportamento delle API, ovvero se un campo è required significa che nel payload in ingresso deve essere presente.

I campi opzionali, ovvero quelli non required, e quelli in sola lettura (hanno _readOnly: true_) dovrebbero essere ben gestiti negli esempi in modo da fornire più informazioni possibile agli sviluppatori.

- Se abbiamo un *requestBody (POST)* e un *id opzionale* allora non lo inseriamo nell'esempio, lo sviluppatore deve capire qual è la richiesta minima che può inviare.

- Se abbiamo un *responseBody (201 Created)* allora l'esempio deve includere il campo *id* anche se opzionale in modo che lo sviluppatore possa capire la richiesta più completa che può ricevere.

2) Gli URI rappresentano delle risorse e non delle azioni quindi andrebbero usati dei sostantivi e non dovrebbero mai includere dei verbi. L'azione è definita dai metodi HTTP. Per collezioni di risorse va bene usare anche sostantivi al plurale.

3) Per esprimere la gerarchia nelle relazioni tra risorse si utilizzano gli slash '/', se si inserisci lo '/' anche alla fine allora stiamo indicando una collezione di risorse:
- _system/admin_
- _system/users/_

4) Gestione errore e filtri: Molti errori possono essere mappati direttamente a dei codici di stato HTTP:
- Parametri mancanti o valori non validi: 400 Bad Request
- Risorsa non trovata: 404 Not Found
- Successo: 200 OK, 201 Created, 204 No Content

E' possibile anche inserire dei corpi agli errori per fornire dettagli aggiuntivi, ad esempio delle strutture in JSON.

5) I filtri servono per impaginare i dati mostrando solo quelli di interesse per l'utente, si utilizzano i *query string* della URI. *Mai* usare il body della richiesta o l'URI del percorso. _Esempio_: _managed-devices/?region=USA_

6) Dati binari - Per inviare dati non è consigliabile incorporare grandi dati binari direttamente all'interno del JSON per motivi di efficienza. La strategia consigliata è:
1) *Invio (Client -> Server)*:
  - Usare _multipart/form-data_ per inviare JSON e il file in un'unica richiesta
  Oppure
  - Caricare il file in un'API dedicata (*POST \/images\/*) e poi si usa l'URL dell'immagine nella richiesta JSON principale.

2) *Ricezione (Server -> Client)*:
  - Restituisce un JSON con l'informazione strutturata e l'URL per accedere al file con un endpoint separato, ad esempio _/images/{identifier}_

Vediamo ad esempio il caricamento di una fontana con le API dei nasoni insieme alla sua foto. Utilizziamo quindi _multipart/form-data_. Il corpo dell'immagine sarà:
- *Media Type*: `multipart/form-data`
- *Part 1 (Dati JSON)*: `Content-Disposition: name="fountain_data"`, contiene il JSON dei dati della fontana.
- *Part 2 (File Binario)*: `Content-Disposition: name="photo"` ovvero contiene i binari dell'immagine.

Invece per quanto riguarda la risposta del server, deve evitare di inviare direttamente il contenuto del binario del JSON. Ad esempio se un endpoint viene utilizzato soltanto per il file allora la risposta non è JSON, se usiamo `GET /images/fountain_123.jpg` ci aspettiamo una risposta del tipo:
- `Status: 200 OK`
- `Content-Type: image/jpeg`
- `Body:` Byte dell'immagine

Quindi quando recuperiamo le informazioni delle fontane o in generale una risorsa il JSON deve contenere un riferimento al file, ad esempio:

```yaml
"id": 1,
"state": "good",
"latitude": 41.89025,
"longitude": 12.49237,
"photo_url": "api/v1/images/fountain_123.jpg" // Riferimento al file
```

In questo modo il client può decidere *se e quando* scaricare l'immagine.

Con il comando *curl* possiamo semplificare questa operazione, ma in generale ci permette di effettuare delle richieste da terminale. Se inseriamo anche il parametro `-F / --form` allora `curl` esegue in automatico:
- Imposta l'intestazione a `Content-Type: multipart/form-data`
- Genera e imposta un valore di boundary unico per la richiesta
- Formatta il corpo della richiesta separando correttamente i dati.

Possiamo usarlo quindi per lo stesso esempio visto prima, aggiungere una fontana insieme alla sua foto.

Il comando `curl` richiede un parametro `-F` per ogni parte che deve essere inviata, quindi avremo:

Carica il contenuto di `data.json` e ne specifica il `Content-Type`:

```curl
-F "fountain_data=@data.json;type=application/json"
```

Carica il file binario `image.jpg`:

```curl
-F "fphoto=@image.jpg;type=image/jpeg"
```

Quindi per inviare la richiesta prepariamo un file `data.json` con i dati della fontana:

```json
{
  "state": "good",
  "latitude": 41.89925,
  "longitude": 12.49237
}
```

E poi chiamiamo curl:

```bash
curl -X POST https://api.nasoniroma.it/v1/fountains \
     -F "fountain_data=@data.json;type=application/json" \
     -F "photo=@/percorso/alla/foto.jpg;type=image/jpg"
```

In questo modo abbiamo creato una sola richiesta HTTP POST.

#showybox(
  frame: (
    border-color: red.lighten(60%),
    title-color: red.lighten(60%),
    body-color: red.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Restrizioni sul corpo*],
  [
    Nelle operazioni GET e DELETE, anche se possono avere un corpo è sconsigliato per evitare comportamenti indefiniti e complicazioni con l'idempotenza.
  ]
)

== Gestione delle sotto-collezioni

E' importante non scambiare il *nome della collezione* con un *elemento*, se una risorsa ha effetto solo sull'utente autenticato è importante non annidarla sotto la risorsa che rappresenta l'enetità target. Ad esempio se vogliamo mutare l'utente Bob è sbagliato fare `/users/{userid}/mute`. In questo modo potrebbe sembrare che stiamo mutando l'utente per tutti quando invece deve essere mutato soltanto per noi.

La soluzione corretta è trattare l'azione da fare come una collezione di risorse relative all'utente annidato. Ad esempio, se io voglio mutare Bob avrò una struttura del tipo: `/me/muted/{userid}`

Abbiamo che:
- Una POST/PUT mette in muto un utente
- DELETE smuta un utente

Questo apporccio garantisce che le operazioni siano *idempotenti*, che l'operazione di "unmuting" sia gestita di base dal DELETE e che la risorsa sia per l'utente autenticato.

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
  title: [*PUT vs PATCH*],
  [
    HTTP mette a disposizione due metodi per modificare delle risorse esistenti, PUT e PATCH.

    PUT:
    - Serve a sostituire completamente una risorsa, è idempotente, vuole in input un'intera risorsa. Viene utilizzata principalmente per delle modifiche complete a dei file. Se vogliamo ad esempio modificare un file ma non tutti i campi, dovremo comunque inviarli tutti.

    PATCH:
    - Applica delle modifiche parziali alla risorsa, non è idempotente a meno che il server non la implementi in modo idempotente, vengono richiesti *solo i campi da modificare*. 
  ]
)