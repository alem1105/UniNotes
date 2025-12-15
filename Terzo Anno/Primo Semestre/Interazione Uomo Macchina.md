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
> _“extent to which a system, product or service can be used by
specified users to achieve specified goals with effectiveness, efficiency and
satisfaction in a specified context of use”_

