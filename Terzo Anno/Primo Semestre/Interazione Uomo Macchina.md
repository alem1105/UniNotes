# Introduzione e storia delle User Interface

La **User Interface** è dove avviene l'interazione fra l'utente e la macchina, l'obiettivo dell'interfaccia è quello di permettere il controllo della macchina e fornire feedback all'utente per migliorare le decisione future.

L'interfaccia include sia la parte hardware (fisica) che software (logica), questa permette:
- Input, per permettere all'utente di manipolare il sistema
- Output, per permettere al sistema di mostrare all'utente gli effetti dei suoi input

> [!info] WIMP Interaction Paradigm
> Nel 1984 con Apple arriva l'**interfaccia grafica** e il paradigma WIMP: _Windows Icons Menu and Pointer_. Qui come input abbiamo la tastiera, il mouse, i menù e come output video e audio.

Dopo il WIMP sono arrivate interfacce **widget-less** basate ad esempio sulla voce, i gesti o controlli fisici.

- **Touch Screens**
	- Resistive - Sono usati in ristoranti, fabbriche ed ospedali per via della loro grande resistenza ai liquidi.
	- Capacitive - Percepiscono il tocco grazie al fatto che il corpo umano è un conduttore elettrico.
	- Infrared - Il dito interrompe dei segnali infrarossi presenti sullo schermo permettendo la registrazione del tocco.

> [!Example] Interfacce POST-WIMP
> - Gesture-based Interfaces - Hanno bisogno di qualcosa che possa tracciare i movimenti come sensori, image processing o dispositivi appositi
> - Voice user Interfaces - Hanno bisogno di un dispositivo che possa riconoscere la voce
> - Haptic user Interfaces - Hanno bisogno di hardware apposito
> - Tangible user Interfaces - Si basano sull'idea di dare una forma fisica alle informazioni digitali, questa forma che gli viene data viene utilizzata anche per controllare le informazioni quindi sia input che output
> - Natural user Interfaces - Un'interfaccia che è "invisibile" o lo diventa dopo che l'utente ha imparato ad usarla correttamente. *Natural* perché l'utente riesce ad imparare in fretta e in generale deve essere semplice da usare, appunto _Naturale_.
> - Organic user Interfaces - Qualsiasi forma possiamo dare ad un computer
> - Kinetic user Interfaces
> - Immersive user Interfaces - Interfacce basate sulla realtà aumentata o virtuale.
> - Brain Interfaces - Segnali catturati dal cervello umano e trasformati in informazione.

**From UI to UX** (Devo recuperare video lezione per le definizioni)

- **CLI** - _Command Line Interface_
	- Static
	- Abstract
	- High - low
	- Directed
	- Recall
- **GUI** - _Graphical User Interface_
	- Responsive
	- Indirect
	- Double Medium
	- Exploratory
	- Recognition
- **NUI** - _Natural User Interface_
	- Evocative
	- Direct
	- -
	- Contextual
	- Intuition
- **OUI** - _Organic User Interface_
	- Fluid
	- Extensive
	- Constant Zero
	- Anticipatory
	- Synthesis

# HCI
É un campo multidisciplinare che si occupa di **design, evaluation ed implementazione** di sistemi interattivi utilizzati da umani, si concentra infatti sulle due entità **computer ed umano** che si influenzano nel tempo.

Perché multidisciplinare?
- Psicologia: Capacità cognitive e di problem solving dell'utente
- Capacità fisiche dell'utente
- Sociologia: Capire il contesto dell'interazione
- Computer Science and Computer Engineering: Costruire Hardware e Software
- Business: Soddisfare le richieste del mercato
- Graphic Design: Realizzare l'idea dell'interfaccia
- Technical Writing: Documentazione, manuali, contenuti su schermo

> [!info] Obiettivi
> I 3 soggetti principali in HCI sono:
> - L'utente
> - Il computer
> - Le tasks da risolvere
>   
> Gli obiettivi:
> - Il sistema deve aiutare l'utente a compiere le tasks

# Models of Interaction
Cosa si intende per **Interazione** in HCI?

> [!info] Interaction
> É quella che determina il comportamento, nel tempo, di umano e computer che interagiscono fra loro.
> _Users, with their goals and pursuits, are the ultimate metric of interaction_

L'utente vuole raggiungere degli obiettivi (**goals**) in uno specifico **dominio**, ogni dominio ha un linguaggio specifico con un set di possibili processi e goals...

Le **tasks** sono operazioni che servono a manipolare i concetti di un determinato dominio.

Come avviene l'interazione?
- Il sistema processa gli **states** e "parla" un **core language**
- L'utente possiede uno state, che include la comprensione dello stato del sistema, e l'intenzione di svolgere un **task**. "Parla" il **task language**

Gli errori che compie l'umano nell'interazione non devono **mai** essere considerati colpa sua, di solito sono il risultato di un design fatto male. Gli umani sono imprecisi, distratti e non onniscienti:
- Il sistema deve anticipare questi comportamenti
- Minimizzare la possibilità che accadano azioni non volute
- Massimizzare la possibilità di scoprire e riparare i danni di un'azione involontaria
- Permettere all'utente di comprendere lo stato del sistema

# Design Processes and Frameworks
Sono gli approcci che possiamo utilizzare per modellare il design process

> [!info] User-Centered Design (UCD)
> Evitare **software project failure**, si stima che il 50% di questi siano dovuti da un _non_ bravo sviluppatore o una cattiva comunicazione tra utente e client.
> - L'UCD prende i **needs, wants e limitations** dell'utente durante ogni fase del design process.
> - I benefici sono che il sistema è più semplice da imparare, più veloce, meno errori umani e incoraggia gli utenti a scoprire le funzionalità più avanzate. Evita di costruire il sistema sbagliato.
> - Il problema è: Come troviamo gli utenti? Quanti sono? Quanto sono motivati? Come estraiamo i needs, i business needs e le organizational implications?


> [!info] Participatory Design
> Ancora più incentrato sugli utenti rispetto all'UCD, qui sono direttamente coinvolti nel design dell'applicazione che dovranno usare.
> Con un gruppo di utenti:
> - Discussions
> - Creating Scenarios, sketches....
> - Creating lo-fi prototypes
> - Fa molto riferimento sulle skill dei moderatori del gruppo
> - More effective with more mature and prepared user populations


> [!info] Agile Interaction Design
> Si basa sul **evolutionary development**:
> - Il sistema è costruito a cicli, ad ogni ciclo vengono implementate nuove cose.
> - Rapid prototyping techniques
> - Si basa su low-cost many-iterations prototypes
> - Richiede usabilità semplice

# Human-Centered Design Process
Come progettare sistemi interattivi con un focus sull'usabilità

> [!info] Usability
> Misura come un sistema può essere utilizzato da degli utenti specifici per ottenere goals specifici con efficienza, in un contesto specifico.

- Gli utenti i goals e il contesto sono specifici perché vanno considerati come combinazione di questi 3 elementi nel contesto dove stiamo considerando l'usabilità
- Con la parola "usabilità" ci riferiamo anche ad altri concetti di design che contribuiscono all'usabilità expertise, engineering, testing ecc..

In generale quindi l'usabilità si riferisce a quanto bene gli utenti possono utilizzare le funzionalità del sistema. Si basa su:
- Usefulness: É qualcosa che gli utenti vogliono?
- Learnability: É facile da imparare?
- Memorability: Una volta imparato, é semplice da ricordare?
- Effectiveness: Permette di raggiungere il goal?
- Efficiency: Una volta imparato, é facile da usare?
- Visibility: Lo stato del sistema é visibile?
- Errors: Gli errori sono pochi e recuperabili?
- Satisfaction: É piacevole da usare?

Dobbiamo fare in modo che l'interfaccia sia più chiara possibile e faccia pensare il meno possibile l'utente.

![[Pasted image 20251216102110.png|500]]

Gli step principali sono:
- **Needfinding - what is wanted** - Cosa serve veramente? Attualmente le persone come stanno raggiungendo l'obiettivo?
- **Analisi** - Formalizzare i needs, creare scenari d'uso, storie, tasks. Comparare la situazione attuale con la nuova che ci aspettiamo.
- **Design**
	- Le scelte principali da fare per modellare il sistema
	- Regole, guidelines e principi di design
	- Considerare diversi tipi di utenti
	- Modellare e descrivere le interazioni
	- Layout
-  **Iteration and Prototyping**
	- Dobbiamo fare delle verifiche intermedie alle parti intermedie come i prototipi, è importante far partecipare anche gli utenti.
- **Implementation and deployment** - Implementazione hardware e software, comprende anche la scrittura della documentazione.

In generale:
1) Needfinding
2) Prototyping (Storyboarding)
3) Testing

# Needfinding
Dobbiamo capire i requisiti del sistema e i needs degli utenti.

Un need non è altro che qualcosa che manca al sistema, il needfinding è quindi la scoperta di nuove opportunità riconoscendo queste mancanze.

Capire cosa vuole un utente richiede anche:
- Capire chi sono gli utenti
- Come svolgono, adesso, l'attività?
- In quale contesto la stanno svolgendo?

## Gli utenti
Chi sono gli utenti del sistema?
- Possiamo classificarli in diverse categorie e/o gruppi?
- Sono anziani? giovani? esperti nel contesto del sistema?
- Dobbiamo pensare il meno possibile a utenti "generici", cerchiamo di classificarli il più possibile.

Noi sviluppatori e designer del sistema **non** siamo utenti, _tranne in alcuni casi_. Se stiamo costruendo il sistema per un cliente, lui **non** è il nostro utente, il capo di un'azienda non conosce perfettamente i suoi dipendenti e il loro lavoro, _anche qui tranne in alcuni casi_.

Dobbiamo parlare, quindi, con gli utenti:
- Sondaggi
- Interviste
- Farli partecipare allo sviluppo
- Capire i loro comportamenti

Ma anche osservarli:
- Registrazioni
- Analizzare il loro lavoro

Se non sono disponibili utenti, possiamo "immaginarli":
- Immaginare il comportamento di una persona reale, anche se molto difficile
- Costruire quindi degli utenti immaginari, affidargli dei ruoli e delle descrizioni.

> [!example] Needfinding Methods
> - Observation, ethnographic research
> - Diaries
> - Interviews
> - Focus groups
> - Serveys
> - Contextual Inquiry

## Observation

**Ethnographic Observation**:
- Dobbiamo considerare anche l'ambiente, la cultura e i comportamenti che fanno parte dell'utente
- L'obiettivo è quello di ottenere i dati necessari per influenzare il design dell'interfaccia
- Imparare il linguaggio dell'utente e dell'ambiente
- Ascoltare ed osservare
- Registrazioni audio e/o video, prendere appunti
- In questa fase i rischi sono:
	- Interpretare male le osservazioni
	- Non considerare informazioni importanti

Dovremmo cercare di capire:
- In questo momento, cosa fanno le persone?
- Quali sono i loro obiettivi?
- Queste attività come sono incluse in sistemi più grandi?
- Similitudini e differenze tra le persone
- Altri tipi di contesti.

> [!info] Process vs Practice
> - Process: Come le cose **pensiamo** che vadano (come dovrebbero andare).
> - Practice: Un insieme di informazioni, metodi e in generale "trucchetti" imparati dall'esperienza che fanno parte dell'attività.

Esistono diversi tipi di Observation.

> [!info] Controlled Observation - Within a Lab environment
> - Facile da riprodurre
> - Facile da analizzare
> - Veloce da organizzare
> - **Hawthorne Effect**: Osservare qualcuno mentre svolge un'attività può cambiare il loro approccio nello svolgere quest'ultima.

> [!info] Naturalistic Observation - Studying the user "in the wild"
> - More reliable: Quando le persone usano un prodotto nella vita reale, è più facile che incontrino problemi (ma anche benefici) di un utilizzo reale, piuttosto che in un test con azioni determinate.
> - Più utile per nuove idee: Una ricerca qualitativa può produrre più idee rispetto ad una ricerca quantitativa.
> - Difficoltà nell'introdurre un sample rappresentativo: Dato che è più costosa da condurre limita molto la quantità di persone raggiunte. La cosa migliore da fare è usare questo approccio per pensare a nuove idee ma testare queste con altri tipi di observation.
> - Difficoltà nel replicarle
> - Difficoltà nel manipolare variabili esterne: Ad esempio se osserviamo un utente utilizzare lo smartphone mentre piove il suo comportamento sarà diverso e non abbiamo controllo sul meteo.

Oltre alle tipologie di observation, ci sono anche diversi modi per condurla e si differenziano in base a come ci "nascondiamo" agli utenti, **blending in**:

- **Becoming part of the wall** (Complete observer)
	- Evitiamo di essere intrusivi o modificare i comportamenti dell'utente, evitiamo registrazioni video o interruzioni
- **Becoming "one of them"** (Complete Participant)

Inoltre, anche la raccolta dei dati va suddivisa in:
- **Soggettiva**
	- Rating degli utenti
	- Scrittura di report
	- Impressions
- **Oggettiva**
	- Errori osservati ed eventuali workarounds
	- Errori più critici

## Diaries
Observation durante la routine giornaliera, con l'aiuto degli utenti.

 - Per un osservatore, non è possibile, condurre observations per lunghi periodi e in diverse zone.
 - I diaries sono tools (sia digitali che cartacei) che richiedono che l'utente prenda note delle sue azioni:
	 - O quando compie una determinata azione
	 - O a intervalli di tempo
 - Dovremmo assicurarci che l'utente sia motivato
 - L'analisi dei diaries va fatta off-line o nel contesto di un'intervista.

## Interviewing
Le classifichiamo in due tipi:
- **Di persona**
	- Richiedono più tempo
	- Structured vs Unstructured
	- One-to-one vs Focus groups
- **Questionari**
	- Veloci ma più superficiali
	- Set di domande con delle risposte prestabilite
	- Online o su carta

> [!danger] Attenzione!
> Gli utenti **non sanno** cosa vogliono
> - Ci diranno cosa pensano che noi vogliamo sentire, soprattutto per prodotti nuovi
> - Non hanno creatività o la conoscenza tecnica per capire il nuovo prodotto
> - Non dobbiamo chiedere agli utenti cosa vogliono.

Come scegliamo i partecipanti delle interviste?
- Rappresentanti degli utenti target
- Utenti di sistemi simili
- Anche non utenti se stiamo creando un prodotto nuovo
- Diamo incentivi, motivazione e "small gifts"

Mentre per lo svolgimento:
- Dobbiamo fissare un orario ed un luogo con l'utente
- Ci presentiamo e spieghiamo l'obiettivo dell'intervista
- Iniziamo con domande aperte e non finalizzate allo scopo dell'intervista
- Diamo abbastanza tempo per rispondere alla domanda, spesso la seconda risposta è più interessante della prima.
- Possiamo fare dei _follow-up_ a delle domande per approfondire di più uno specifico argomento.

### Linee guida per le domande
- Domande strutturate sono più semplici da rispondere mentre non strutturate portano a più commenti e spunti
- Se facciamo domande aperte cerchiamo di continuare la discussione
- Se facciamo domande quantitative (ad esempio dare un punteggio da 1 a 5) chiediamo sempre cosa intendono per il valore che ci forniscono
- Parliamo il linguaggio dell'utente
- Proviamo prima le domande con un piccolo gruppo di test

_Esempi di domande aperte_
-  ‘Tell me about your typical day.’
- 'Tell me three good things about. .. ’
- ‘and three bad things.’
- ‘What has gone wrong with the application recently? How did you cope?’
- ‘What else should we have asked about?’

_Domande da evitare_
- La feature 'x' è importante per te?
- Cosa ti piacerebbe avere nell'app 'x'?
- Cosa faresti in questa situazione?
- Quanto spesso fai 'x'?
- Domande con risposte si o no
- Raccontami una storia su di te
- Evitiamo di dare possibili risposte facendo altre domande.

## Questionari

**Online**:
- Sono più semplici da fare
- I risultati sono più facili da visualizzare 
- Possono raggiungere più persone

Prima di iniziare a scrivere il questionario è importante stabilire gli obiettivi e le modalità di questo, ma anche capire di quali grafici e dati abbiamo bisogno.

Quali sono i rischi che possiamo incontrare se scegliamo i questionari?
- Sono utili per un'analisi non profonda
- Non possiamo fare domande di follow-up
- I dati potrebbero avere dei BIAS se le risposte si basano sulla memoria dell'utente o su problemi "sensibili" (emozioni, denaro, ecc...)
- Trovare il target del questionario

Il questionario va strutturato in modo tale che ci siano:
- Gli obiettivi del questionario, perché abbiamo bisogno dell'utente, e anche questo tempo in media ci metterà a compilarlo
- Una o più sezioni con le domande specifiche
- Informazioni generali sull'utente

Per informazioni generali sull'utente intendiamo:
- Anni, genere, origini, che lingua parla, educazione, lavoro ....
- Esperienza con i computer
- Che tipo di responsabilità ha nel suo lavoro
- Qualcosa sulla sua personalità
- Perché non gli piace utilizzare una determinata interfaccia

Che tipo di domande possiamo fare? E come vanno impostate?
- **Open-ended**
	- Vanno comunque poste in modo specifico per evitare risposte troppo generiche
	- Richiedono più tempo per analizzare le risposte
- **Closed-ended**
	- Una sola risposta, possono esserci scale di valori, o comunque una risposta tra più scelte preimpostate.

Per le risposte a scelta multipla dobbiamo scegliere quando dare un ordine a queste e quando no, in generale:
- Per risposte scritte e non numeriche non diamo un ordine

Inoltre, quando impostiamo un range numerico:
- 4 livelli se vogliamo capire se l'utente è d'accordo o meno con un concetto
- 5 livelli, i livelli estremi è molto raro che vengano scelti
- range con estremo destro dispari evitano risposte neutre, ad esempio 1-5, 1-7, 1-9.

> [!warning] Attenzione
> - Meglio usare due domande semplici piuttosto che una complessa
> - Evitiamo parole negative nelle domande
> - Domande con BIAS comportano risposte con BIAS

# Task Analysis