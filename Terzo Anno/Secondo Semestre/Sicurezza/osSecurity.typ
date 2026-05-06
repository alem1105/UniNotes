#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= OS Security
Il sistema operativo è la prima linea di difesa in un computer questo infatti serve a:
- Proteggere gli utenti l'uno dall'altro
- Proteggere le aree di memoria da processi non autorizzati
- Esegue identificazione e autenticazione delle operazioni
- Garantisce una condivisione equa delle risorse hardware

Proprio perché è la prima linea di difesa peró, è anche uno dei principali bersagli degli attacchi.
Ci sono diverse funzionalitá dei sistemi opearitivi che coinvolgono la sicurezza informatica:
- *Enforced Sharing*: Garantisce l'integritá e la coerenza quando le risorse vengono rese disponibili agli utenti.
- *Comunicazione Interprocesso e sincronizzazione*: Il Sistema Operativo fa da ponte per le richieste asincrone tra i processi mediando la comunnicazione tramite tabelle di controllo degli accessi.
- *Protezione dei dati critici del sistema*: Se i dati attraverso cui l'OS fa rispettare la sicurezza non sono protetti allora crolla l'intero sistema.
- *Garantire un servizio equo*: Tramite algoritmi di scheduling si assicura un controllo che previene la "starvation" dei processi
- *Interfacciamento protetto all'hardware*: Controlla l'accesso ai dispositivi I/O e al file system.
- *Autenticazione Utente*
- *Protezione della memoria e autenticazione*: Mantiene separati lo spazio utente e quello di sistema per garantire la condifenzialitá e l'integritá.

Gli oggetti che l'OS deve proteggere includono la memoria, reti, i dati, file condivisibili e l'hardware.
L'architettura tipica di protezione si basa su una *visione a strati (layered view)* dove l'hardware fisico é avvolto da un livello di sicurezza detto *security kernel* circondato a sua volta dal kernel generico dell'OS e infine dai servizi e processi utente.

#align(center, image("/assets/image-58.png", width: 50%))

Il Sistema Operativo, data la sua natura multicomponente, deve integrare moduli di diversa provenienza per proteggersi e non sempre questi sono sicuri, questo significa che l'OS deve proteggersi sia da programmi utente che da moduli o add-on difettosi.
Se l'OS é scritto per un hardware specifico allora la protezione potrebbe essere implementata direttamente su quest'ultimo, cosa invece non possibile se ;'OS deve girare su hardware generico.

Per fare questo l'OS utilizza dei meccanismi software:
- *ACL, Access Control List*
- *Events Logging*: L'OS registra numerosi eventi in file di log che sono essenziali per mostrare cosa é successo durante un attacco informatico e pianificare le difese future.
- *Virtualizzazione*: Permette all'OS di presentare a ogni utente solo le risorse pertinenti tramite Macchine Virtuali. L'*hypervisor* agisce da filtro eseguendo le istruzioni privilegiate e l'accesso alla memoria in modo controllato.
- *Sandbox*: Sono degli ambienti isolati dove i processi non fidati hanno un impatto inferiore sulle risorse esterne.
- *Honeypot*: Sono delle vere e proprie esche che si offrono agli attaccanti per monitorarli e studiarli in tempo reale, spesso vengono utilizzate nel networking ma é possibile anche negli OS tramite VM.

== Separation and Sharing
L'OS gestisce la concorrenza tra utenti attraverso i due concetti di *separazione e condivisione*. La separazione puó avvenire in 4 modi:
- Fisica: Utilizzando dispositivi distinti
- Temporale: Eseguendo processi a rischio in momenti differenti
- Logica: Confinando gli accessi in modo che ogni processo abbia l'illusione di operare da solo
- Crittografica: Cifrando i dati per renderli illegibili da altri processi.

La separazione peró é solo una faccia della medaglia, vogliamo anche poter condividere alcuni oggetti fra gli utenti.
In scenari complessi si utilizza una condivisione che limita gli accessi o che limita l'uso di un oggetto

== Hardware Protection of Memory
Per proteggere la memoria si utilizzano meccanismi hardware specifici:

- *Fence*: Impongono limiti hardware statici o dinamici (tramite i Fence Register) per definire dove finisce l'OS e dove inizia lo spazio utente.

Per quelli statici abbiamo una situazione simili a questa:
#align(center, image("/assets/image-59.png", width: 50%))

Ovvero impongono una *limitazione hardware fissa*, quindi il confine tra memoria del ssitema e lo spazio dei programmi utente é stabilito a un indirizzo di memoria specifico e immutabile.

Nei Fence Register dinamici abbiamo questa situazione:

#align(center, image("/assets/image-60.png", width: 50%))

Utilizza uno specifico registro hardware chiamato *Address Limit Register* che memorizza l'indirizzo di confine, questo indirizzo peró puó cambiare permettendo al limite tra lo spazio di sistema e quello utente di variare nel tempo.

- *Base/Bound registers*: Sono coppie di registri utilizzati per tracciare l'indirizzo di base e il limite superiore consentito.

#align(center, image("/assets/image-61.png", width: 50%))

Questa foto illustra il meccanismo base ovvero:
- Il _Base Register_ memorizza l'indirizzo di memoria da cui inizia lo spazio assegnato a uno specifico programma utente.
- Il _Bounds Register_ memorizza l'indirizzo che stabilisce il limite superiore di tale spazio. Ogni volta che il programma tenta di accedere alla memoria, l'hardware verifica che l'indirizzo richiesto tra il valore base e il valore bound.

Poi abbiamo un altro meccanismo che usa questi registri:

#align(center, image("/assets/image-62.png", width: 50%))

In questo caso lo spazio utente non viene piú trattato come un blocco unico ma viene diviso e protetto da due coppie distinte di registri:
- _Program Base e Program Bounds_: Delimitano unicamente l'area di memoria in cui risiede il codice eseguibile.
- _Data Base e Data Bounds_: Delimitano un'area separata in cui risiedono i dati (le variabili dei programmi).

Qusto meccanismo permette al SO di trattare le aree di memoria in modo indipendente garantendo una sicurezza maggiore, ad esempio gli permette di imporre regole piú precise.

- *Tagged Architecture*: Associa a ogni singola parola di memoria una etichetta di permessi esplicita.
Questo concetto ci porta alla *Virtual Memory* e alla *Segmentazione*, vediamo cosa succede ad un programma utente:

#align(center, image("/assets/image-63.png", width: 50%))

Il programma "logicamente" é un insieme di blocchi contigui ma nella memoria fisica questi vengono posizionati in aree diverse. Questo approccio permette di dividere il programma in porzioni aventi diritti di accesso differenti l'una dall'altra.
Alla base della segmentazione c'é la "traduzione degli indirizzi", quando il programma in esecuzione fa una richiesta l'indirizzo fisico reale in cui si trova quel dato é nascosto al programma e l'operazione passa per la *Segmentation Translation Table*:

#align(center, image("/assets/image-64.png", width: 50%))

La tabella fornisce l'indirizzo di partenza del dato, nella foto viene richiesta la ventesima parola del segmento `DATA_SEG`, la tabella sa che il segmento inizia nella cella `h`, una volta posizionatosi all'inizio della cella somma l'offset richiesto, in questo caso $20$.

Il fatto che ogni indirizzo passi attraverso il SO prima di toccare la memoria comporta molti benefici alla sicurezza:
- Ogni riferimento in memoria é controllato per assicurarsi che non superi la dimensione del segmento stesso.
- Dati diversi all'interno della stessa applicazione possono ricevere diversi livelli di protezione
- Due o piú utenti possono condividere l'accesso a un determinato segmento pur avendo diritti di accesso diversi
- L'utente non puó in alcun modo generare l'accesso verso un segmento che non é autorizzato a vedere.
- Il SO puó spostare i segmenti a piacimento o rimuoverli dalla memoria se non sono in uso.

Un grande difetto peró risiede nella *dimensione del segmento*, essendo i segmenti di dimensione variabile il sistema é costretto a eseguire complessi controlli per verificare continuamente che l'indirizzo generato non vada oltre la fine del segmento correntemente in uso. Per risolvere questo problema introduciamo il concetto di *paging*.

Con questa tecnica il programma logico non viene piú diviso in segmenti variabili ma in _pagine_ tutte uguali, anche la memoria fisica viene divisa in _page frames_ della stessa misura delle pagine.
Il processo di traduzione é simile ma vengono mappate pagine logiche su pagine fisiche, questo approccio offre gli stessi vantaggi visti nella segmentazione ma con una gestione della memoria piú efficiente.

#align(center, image("/assets/image-65.png", width: 50%))

In realtá peró si utilizza un meccanismo piú robusto chiamato *Paged Segmentation* unendo i due concetti ovvero concatenando le due tabelle:

#align(center, image("/assets/image-66.png", width: 50%))

Quando chiediamo l'indirzzo `DATA_SEG, 20` la prima tabella non punta piú direttamente alla memoria ma ad una seconda tabella dedicata unicamente al segmento `DATA_SEG`. Il sistema poi converte l'offset in un numero di pagina in base a quanto é grande una pagina, in questo caso la posizion 20 si trova all'interno della pagina 0. A questo punto possiamo vedere dove si trova la pagina 0 del segmento dati nella memoria fisica, in questo caso all'indirizzo `l` e poi sommarci l'offset residuo.

== Security in the Design of Operating System
La sicurezza nei Sistemi Operativi va implementata rispettando dei principi:
- Semplicitá
- Design a layer
- *Least Privilege*
- Reference Monitor per la mediazione delle richieste.

Un Sistema Operativo progettato in modo sicuro é definito *Trusted System*, questi sono capaci di garantire:
- *Correttezza Funzionale*: Fa quello per cui é stato programmato.
- *Rispetta l'integritá*: É impossibile eludere i privilegi.

A questo scopo si crea la *Trusted Computing Base (TCB)* ovvero l'insieme di tutti i meccanismi, hardware e processi primitivi racchiusi in un guscio protetto il cui unico scopo é far rispettare la policy di sicurezza.
La TCB deve ispezionare l'attivazione dei processi, i cambi di dominio, la protezione della memoria e l'I/O. Inserire troppe funzionalitá nella TCB peró distruggerebbe la modularitá del SO e ostacolerebbe la capacitá di analizzarne il codice, l'approccio ideale é quello di sviluppare prima un piccolo *Security Kernel* interfacciato con l'hardware e poi costruirci intorno il resto delle funzionalitá.

#align(center, image("/assets/image-67.png", width: 50%))