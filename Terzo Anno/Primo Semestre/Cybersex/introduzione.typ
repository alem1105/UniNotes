#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *

= Definizione di Cybersecurity

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
  title: [*Definizione secondo il NIST (National Institute of Standards and Technology)*],
  [La prevenzione di danni, la protezione e il ripristino di computers, servizi di comunicazione, sia cablati che wireless e tutte le informazioni che trasportano al fine di garantire la loro disponibilità, integrità, autenticità e confidenzialità.]
)

Mentre una definizione di *Computer Security* potrebbe essere: _Misure e controlli che garantiscono la confidenzialità, l'integrità e la disponibilità di *assets* che includono hardware, software, firm-ware e tutte le informazioni che vengono processate, salvate e comunicate._

Per *asset* intendiamo quello che è importante per un sistema ovvero quello che vuole proteggere.

== Cosa dovrebbe essere protetto?

- Dati Personali
  - Nel nostro sistema cosa intendiamo per dati personali? Nome, Cognome, Email?
  - A che cosa servono questi dati nel sistema?
  - Chi può vedere questi dati?
  - Come ci assicuriamo che possano vederli soltanto le persone scelte?

- Dati dell'Azienda?
  - Dati Finanziari
  - Informazioni riservate riguardo a prodotti dell'Azienda
  - Dati personali dei dipendenti
  - Informazioni sull'infrastruttura di rete dell'Azienda

== Assets 

Per assets intediamo cosa è importante per una persona o azienda o in generale il sistema che dobbiamo rendere sicuro.

Ad esempio per un computer gli assets principali sono:
- Hardware
- Software 
- Dati 
- Comunicazioni e Reti

== Security Concepts e Relazioni

#image("image.png")

- Per il proprietario sono importanti gli *assets*, vuole minimizzare i rischi su quest'ultimi e quindi impone delle *contromisure* per ridurli.
- Gli attacanti vogliono danneggiare o rubare gli assets.

Vediamo i principali termini:
- *Threat Agent (Attacante)*: Chi fa o ha intenzione di svolgere attacchi
- *Countermeasure*: Un dispositivo o una tecnica di difesa
- *Risk*: Una situazione che mette a rischio un elemento del sistema
- *Threat*: Qualsiasi situazione o evento che potrebbe influenzare il sistema
- *Vulnerability*: Una debolezza nel sistema, può apparire in molte forme, ad esempio nel codice, nel personale, in qualche procedura ecc...

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
  title: [*Osservazione sulla Sicurezza*],
  [La sicurezza di un sistema, applicazione o altro è sempre relativa a:
  - Un insieme di proprietà
  - Un avversario con delle abilità specifiche

  Ad esempio, i permessi di accesso ai file su Linux o Windows non avranno effetto su un attaccante che accede al sistema tramite un CD.
  ]
)

== Threats

Per quanto riguarda le minacce, ci sono diversi tipi di attacchi:

- *Active Attack*: Un attacco che vuole alterare le risorse del sistema o influire sulle sue operazioni. Ne esistono di diversi tipi:
  - Replay
  - Masquerade
  - Modification on Messages
  - Denial of Service
- *Passive Attack*: Un attacco che mira a sfruttare le informazioni contenute in un sistema senza danneggiarlo. L'obiettivo è quindi quello di rubare informazioni per renderle pubbliche o ricattare oppure anche analizzare il sistema per un attacco futuro.
- *Inside Attack*: Un attacco iniziato da qualcuno all'interno del sistema, di solito quest'ultimo ha dei permessi nel sistema ma non completi.
- *Outside Attack*: Un attacco che inizia dall'esterno del sistema da una persona non autorizzata.

= Security Goals

Esistono 3 concetti fondamentali da considerare che possiamo indicare con l'acronimo *C.I.A.*:
- *Confidentiality*
- *Integrity*
- *Availability*

== Confidentiality

Evitare che dei non autorizzati accedano a delle informazioni riservate, per garantirla eistono diversi strumenti.

=== Encryption

Modificare le informazioni con dei *secret*, chiamati *encryption key*, in modo che diventino leggibili soltanto per chi ha un altro *secret* ovvero la *decryption key*. In alcuni casi le key combaciano mentre in altri no.

#image("image-1.png")

=== Access Control 

Sono delle regole che servono a determinare quali persone possono accedere a determinate informazioni o servizi.

Ad esempio possiamo garantire l'accesso ad una stanza soltanto ad un determinato gruppo di dipendenti.

=== Authentication

Identificare qualcuno e quali permessi ha, l'identificazione può avvenire in diversi modi, ad esempio:
- Un oggetto (tessere elettroniche, chiavi, ecc...)
- Password
- Impronta digitale, retina ecc...

=== Authorization

Determina se una persona autenticata può accedere a delle risorse, basandosi sulle regole dell'*accesso control*. Questa dovrebbe servire a prevenire il tentativo di "imbrogliare" il sistema da parte di attaccanti.

=== Physical Security

Delle barriere fisiche per non permettere l'accesso a delle zone protette, ad esempio le stanze dove ci sono i server con informazioni importanti.

== Integrity

Le informazioni non devono essere alterate senza permesso. Possiamo provare a garantirla con diversi strumenti:

- *Backups*: Degli "snapshot" di tutti i dati archiviati
- *Checksums*: Il risultato di un'operazione che mappa il contenuto di un file in un valore numerico. Queste sono fatte in modo che anche un piccolo cambiamento nel file cambi il risultato finale, in questo modo è molto rato che due file diversi abbiano lo stesso risultato.
- *Data correcting codes*: Sono dei metodi di mantenimento dei dati che rilevano anche dei piccoli cambiamenti e li correggono in automatico.

== Availability

I servizi offerti e le informazioni accessibili da chi ha il permesso di farlo devono essere sempre disponibili. Proviamo a garantirla con:
- *Physical Protections*: 
- *Computational redundancies*: Computer o dischi che servono come "fallback" nel caso di errori nei dispositivi principali.

== Other Security Concepts

Altri concetti importanti nella sicurezza informatica sono: *Authenticity, Accountability e Anonymity*.

=== Authenticity
Dobbiamo essere in grado di capire che un sistema, una persona o in generale qualcosa o qualcuno sia affidabile.

Uno strumento semplice come esempio è la firma o *digital signature*

=== Accountability
