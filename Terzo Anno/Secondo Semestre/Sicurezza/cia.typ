#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= CIA - Key Objective / Requirements

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
  title: [*Sicurezza Informatica - NIST*],
  [
    Le misure che garantiscono *confidenzialità, integrità e disponibilità* di un sistema informatico nel sua interezza quindi hardware, software, firmware, le informazioni che memorizza, processa e comunica
  ]
)

Queste tre proprietà vengono indicate nella *triade CIA* e significano:
- *Confidenzialità*: Garantire che le informazioni private non vengano divulgate a persone non autorizzate e garantire anche che ogni utente abbia il controllo su quali dei suoi dati personali vengono memorizzati nel sistema o a chi vengono inviati. L'utente deve quindi essere in grado di gestire la sua *privacy*.
- *Integrità*: Assicurare che i dati o il sistema vengano modificati solo in modo autorizzato.
- *Disponibilità*: Garantire l'accesso affidabile alle informazioni e ai servizi, non devono esserci interruzioni del servizio.

La triade è in costante conflitto con usabilità e costi del sistema, il lavoro di un esperto di sicurezza è quindi quello di trovare il giusto compresso fra queste variabili.

Nei sistemi moderni, ai tre pilastri della triade, si aggiungono:
- *Autenticità*: La garanzia che un messaggio o un utente provengano effettivamente dalla fonte dichiarata.
- *Accountability*: La capacità di tracciare in modo univoco le azioni di un'entità, è utile per indagini forensi, isolare i guasti e la *nonrepudiation* ovvero quando qualcuno nega di aver compiuto un'azione.

== Levels of Impact
Possiamo classificare l'impatto di eventuali violazioni:
- _Basso_: Danni minori o perdite finanziare limitate, il sistema continua comunque a funzionare anche se magari in modo ridotto.
- _Moderato_: Danni significativi alle capacità operative e perdite finanziare importanti.
- _Alto_: Il sistema non funziona più, danni finanziari enormi e ci sono rischi catastrofici o letali per le persone.

== Computer Security Challenges
La sicurezza informatica presenta diverse sfide che la rendono complessa:
1. Non è semplice per chi si trova alla prime armi e spesso le procedura di sicurezza risultano controintuitive
2. Richiede una gestione di *informazioni riservate* e anche una decisione su dove posizionare le difese.
3. Dagli utenti viene vista come *un ostacolo* e dai manager come uno spreco di risorse fino a quando non subiscono un attacco.
4. Spesso viene aggiunta alla fine dell'implementazione di un sistema come un "ripensamento" invece di essere implementata dall'inizio.

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
  title: [*Dilemma del Difensore*],
  [
    Chi difende deve eliminare *tutte le debolezze* di un sistema (praticamente impossibile), mentre a chi attacca ne basta una sola.
  ]
)

== Un modello per la Sicurezza

#align(center, image("/assets/image-4.png", width: 70%))

Nel diagramma sono indicati:
- *Asset (Risorsa)*: È quello cha ha un valore nel sistema (Hardware, software, Dati ecc...)
- *Vulnerabilità (di un asset)*: Una debolezza nel sistema che può essere sfruttata. Ne esistono di diversi tipi:
  - *Corrupted*: Dati alterati
  - *Leaky*: Dati trapelati
  - *Unavailable*: Sistema non disponibile
- *Threat*: Una qualsiasi "situazione" che potrebbe causare danni di qualsiasi tipo.
- *Attack*: Quando un _Threat Agent_ ovvero un avversario sfrutta attivamente una vulnerabilità.
- *Countermeasure*: Tecniche o dispositivi utili a prevenire gli attacchi o a ridurne gli effetti.

Possiamo anche calcolare il rischio grazie alla formula:

$ R = P times D $

Dove:
- $P$: Probabilità che l'evento si verifichi
- $D$: Impatto dell'evento

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
  title: [*Nota*],
  [
    L'obiettivo delle contromisure *non è azzerare il rischio* dato che sarebbe troppo costoso o comunque impossibile, ma è quello di portarlo ad un livello accettabile definito *Rischio Residuo*.
  ]
)

= Classificazione degli Attacchi

La prima distinzione che possiamo fare è quella della provenienza dell'attacco, o dall'interno (*insider*) o dall'esterno (*outsider*). Gli attacchi si dividono poi in:
- *Passivi*: L'attaccante osserva e raccoglie informazioni senza alterare il sistema, questi sono molto difficile da rilevare e l'unica difesa è la *prevenzione*. Ne esistono di due tipi:
  - _Release of Message Contents_: Leggere il contenuto di un messaggio
  - _Traffic Analysis_: Anche se il messaggio è cifrato, l'attaccante osserva chi sta parlando con chi e guardando anche la dimensione del messaggio, la frequeunza e altri dati può ricavare qualche informazione.
- *Attivi*: L'attaccante altera i dati o il funzionamento del sistema:
  - _Replay_: Catturare un dato e reinviarlo successivamente per ottenere accesso.
  - _Masquerade_: Fingersi qualcun altro
  - _Modification of Messages_: Alterare parti legittime di un messaggio o ritardarlo.
  - _Denial of Service (DoS)_: Interrompere il servizio di un sistema sovraccaricandolo di richieste.

Vediamo adesso le conseguenze e i tipi di attacco che le producono (secondo lo standard RFC4949):
- *Unauthorized Disclosure*: Vengono divulgati dati da persone non autorizzate, attacchi possibili:
  - _Exposure_: Esposizione diretta
  - _Interception_
  - _Inference_: Deduzione di dati da altri segnali
  - _Intrusion_
- *Deception*: Vengono fornite informazioni ad un utente non autorizzato
  - _Masquerade_: Fingersi un'altra persona
  - _Falsification_: Alterari i dati per ingannare
  - _Repudiation_: Negare di aver compiuto un'azione
- *Disruption*: Interruzione delle funzionalità del sistema:
  - _Incapacitation_: Disabilitare un componente
  - _Corruption_: Alterare i dati che permettono il funzionamento del sistema
  - _Obstruction_: Ostacolare i servizi
- *Usurpation*: Viene preso il controllo del sistema da parte di utenti non autorizzati.
  - _Misappropriation_: Prendere il controllo logico o fisico di una risorsa
  - _Misuse_: Utilizzare un componenete per svolgere operazioni dannose.

== Requisiti di Sicurezza
Le contromisure alle vulnerabilità e minacce possono essere classificate e categorizzate in differenti modi, possiamo classificarle in funzione dei requisiti funzionali, il FIPS 200 le divide in:
- *Requisiti di Sicurezza Tecnici*: Ad esempio controllo degli accessi, autenticazione e integrità del sistema.
- *Funzionali*: Formazione del personale, valutazione dei rischi, sicurezza fisica
- *Misti*: Gestione della configurazione, risposta agli incidenti e protezione dei media.

== Principi fondamentali di Design per la sicurezza
Questi principi sono fondamentali per chi progetta architetture di rete o sviluppa software:
- *Economy of Mechanism*: I sistemi di sicurezza devono essere piccoli e semplici, più codice scrivi e più bug introduci.
- *Fail-safe default*: L'accesso deve basarsi sui permessi e non sulle esclusioni, se qualcosa va storto il sistema deve bloccarsi in uno stato sicuro negando l'accesso.
- *Complete Mediation*: Ogni singolo accesso a una risorsa deve essere verificato senza fidarsi ciecamente della cache.
- *Open Design*: La sicurezza non deve basarsi sulla segretezza del codice ma sulla forza dell'algoritmo o delle chiavi.
- *Separation of Privilige*: Richiedere più condizioni per sblcocare un'azione (2FA).
- *Least Privilege*: Utenti e processi devono avere solo i permessi strettamente necessari per fare il loro lavoro.
- *Layering*: Usare ostacoli multipli e sovrapposti, se l'attaccante buca il firewall deve trovare altri blocchi.

#showybox(
  frame: (
    border-color: blue.lighten(60%),
    title-color: blue.lighten(60%),
    body-color: blue.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Esempio Fail-Safe*],
  [
    Prendiamo questo esempio in pseudocodice:
    ```c
    DWORD dwRet = IsAccessAllowed(...);
    if (dwRet == ERROR_ACCESS_DENIED) {
      // Security check failed
    } else {
      // Security check OK
    }
    ```

    Questo codice non va bene perché se per qualsiasi motivo la funzione `IsAccessAllowed()` fallisce e ritorna un dato non previsto noi stiamo garantendo l'accesso al sistema.
  ]
)

== Superfici e Alberi di Attacco
Per difendere un sistema è utile capire come possiamo attaccarlo.

Definiamo come *Attack Surface* l'insieme di tutte le vulnerabilità raggiungibili in un sistema, si divide in:
- _Rete_: Porte aperte e server esposti
- _Software_: Bug nel codice
- _Umana_: Social engineering o errore del personale
Il nostro obiettivo è quello di ridurre il più possibile questa superficie.

Per analizzare le debolezze del sistema possiamo costrutire un *albero di attacco* ovvero un albero che rappresenta le minacce al nostro sistema:
- Il nodo radice è l'obiettivo dell'attaccante
- I nodi intermedi sono i sotto-obiettivi
- Le foglie sono gli attacchi che può fare per colpire un sotto-obiettivo.
I sotto-obiettivi possono essere in AND o OR fra di loro.

Questi alberi sono utilizzati dai team di sicurezza per capire qual è il percorso "più economico" o "più facile" per un attaccante, questo permette quindi di posizionare le difese (layering) dove sono più necessarie.

_Esempio di albero_:

#align(center, image("/assets/image-5.png", width: 70%))


== Computer Security Strategies
Come si gestisce quindi la sicurezza a livello aziendale?
- *Specification / Policy (Cosa Fare?)*: Le regole che indicano cosa deve fare il sistema (es. lunghezza minima di una password). Queste devono bilanciare il costo della sicurezza col costo di un eventuale attacco.
- *Implementation / Mechanisms (Come Farlo?)*: Le tecnologie usate per prevenire, rilevare, rispondere e ruperare i dati.
- *Assurance ed Evaluation (Funziona?)*: Il livello di confidenza che i meccanismi implementati rispettino effettivamente le policy. Questo si ottiene tramite test, certificazioni e analisi.