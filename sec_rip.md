
**Proprietà CIA**
- Confidenzialità
- Integrità
- Availability
Poi sono state introdotte anche
- Accountability
- Autenticità

**Classificazione degli attacchi**
Possiamo classificarli per la loro provenienza:
- Interno
- Esterno
E per la tipologia di attacco:
- Attivi
- Passivi

I danni possiamo classificarli in:
- Unauthorized Disclosure: Vengono rese pubbliche informazioni riservate
- Deception: Un utente non autorizzato si impossessa di informazioni riservate
- Disruption: Danneggiamento del sistema
- Usurpation: Prendere il controllo del sistema

**Principi di Sicurezza**
- Least Privilege: Ogni utente deve avere il minimo livello di permessi richiesti per svolgere le sue attività
- Open Source: La sicurezza non deve basarsi sulla segretezza del codice ma su regole matematiche
- Fail-Safe: Di base il sistema deve rifiutare
- 2FA
- Multilayer di sicurezza
- Ogni accesso va tracciato
- Sistemi piccoli e semplici

**Cryptographic Tools**
- Cifratura Simmetrica: A e B utilizzano la stessa chiave
- Cifratura Asimmetrica: A e B utilizzano una coppia di chiavi

**Cifratura Simmetrica**
Garantisce confidenzialità ma i due host devono scambiarsi una chiave K in modo sicuro e utilizzare un forte algoritmo di cifratura.
Si attacca principalmente con _bruteforce_ o tecniche di _criptoanalisi_

Gli algoritmi principali sono:
- DES
- 3DES
- AES

Il DES si basa su un meccanismo chiamato _Reti di Feistel_, il testo viene diviso in blocchi da cifrare, ogni blocco viene diviso in due e la parte a destra viene cifrata poi messa in XOR con quella sinistra e poi le due parti vengono invertite. Questo passaggio viene ripetuto per 16 round su ogni blocco.
Il 3DES ripete semplicemente il DES 3 volte. 

L'AES è l'algoritmo più avanzato utilizzato ancora oggi, utilizza blocchi da 128bit e chiavi da 128/192/256 bit. Questo si basa invece su l'architettura di **Rijndael**.
Anche l'AES utilizza dei round e in base alla lunghezza della chiave abbiamo:
- 128bit -> 10 round
- 192bit -> 12 round
- 256bit -> 14 round
All'interno di un round i 16byte (128bit) vengono visti come una matrice _State_ che inizialmente viene riempita con il testo in chiaro. Le varie fasi sono:
- Vengono generate delle sottochiavi, una per ogni round
- Fase 1 - Round Iniziale (Round 0): _AddRoundKey_, la matrice iniziale viene combinata con la chiave tramite uno XOR
- Fase 2 - Round 1 - 9: Ogni round è composto da 4 operazioni:
	- Sostituzione byte a byte tramite una tabella, serve a dare confusione
	- ShiftRows: Le righe della matrice vengono traslate
	- MixColumns: Ogni colonna della matrice viene presa e moltiplicata per una matrice fissa
	- AddRoundKey: Viene eseguito uno XOR tra la matrice attuale e una sottochiave di round
- Fase 3 - Round finale (round 10), identico ai precedenti ma salta il passaggio di MixColumns
- Otteniamo il blocco cifrato nella matrice state.

**Metodi di Cifratura**
Esistono 2 tipi principali:
- Block Cipher: Cifrano un blocco alla volta
- Stream Cipher: Cifrano continuamente byte per byte

Per i block cipher esistono diverse modalità:
- ECB: Il metodo classico, divide il testo in blocchi uguali e li cifra con l'algoritmo scelto
- CBC: Divide il testo in blocchi uguali ma dopo aver cifrato un blocco lo mette in XOR con il precedente cifrato, il primo blocco utilizza un vettore IV di inizializzazione.
- CFB: Qui il testo in chiaro non viene mai dato all'algoritmo di cifratura, si cifra un vettore di inizializzazione o il testo cifrato del blocco precedente e il risultato viene poi combinato in XOR con il testo. Si cifra un byte alla volta.
	- Riempiamo uno shift register da 128bit con IV e lo cifriamo
	- Prendiamo i primi _s_ bit dall'output e li mettiamo in XOR con gli 8 bit del testo in chiaro e otteniamo i primi 8 bit cifrati.
	- Lo shift register viene traslato a sinistra di 8 bit e negli ultimi 8 bit a destra inseriamo i nuovi 8 bit appena ottenuti dalla cifratura
- OCB: Garantisce sia riservatezza che autenticità e integrità tramite un MAC. L'OCB cerca di risolvere il problema facendo tutto in un passaggio. L'idea si basa sull'uso di un offset derivato da una Nonce (numero usato una sola volta) e della key. Prendiamo un blocco e seguiamo le seguenti operazioni:
	- Prende il blocco e applica XOR con un offset specifico per quel blocco
	- Cifra il risultato con l'algoritmo di cifratura
	- Prende l'output e applica XOR con lo stesso offset
	Con questo trucco anche due blocchi identici avranno un risultato diverso.
	A questo punto si calcola il tag, mentre cifra i blocchi:
	- Calcola lo XOR di tutti i blocchi in chiaro
	- Cifra il risultato finale (con un offset)
	- Il risultato è il MAC
- CTR: Per ogni blocco di testo si crea un altro blocco composto da un valore _Nonce_ che è unico per ogni sessione e un _Contatore_ che parte da 0 e aumenta ad ogni blocco. Per la cifratura si cifra questo blocco appena creato e poi si mette in XOR con il blocco in chiaro.

Per quanto riguarda invece gli stream cipher vediamo un algoritmo importante ovvero il _RC4_:
Si utilizza una chiave variabile da 1 a 256bytes per inizializzare uno state array da 256bytes, questo array avrà sempre una permutazione di tutti i numeri a 8 bit. Quando dobbiamo cifrare un byte, prendiamo un valore da S e lo utilizziamo per cifrare, poi rimescoliamo S. Nello specifico:
- S è ordinato, si inizializza un altro vettore T andandoci ad inserire la chiave all'interno
- Per la prima permutazione, inizializziamo una variabile j, e per ogni S\[i\] calcoliamo j = j + S(i) + T(i) e poi invertiamo S(i) con S(j)
- A questo punto possiamo generare le chiavi da utilizzare, quando dobbiamo cifrare un byte cicliamo su S:
	- i + 1
	- Sommiamo a j cosa troviamo in S(i)
	- Scambiamo S(i) con S(j)
	- La somma S(i) + S(j) sarà l'indice che useremo per cifrare il prossimo byte.

**Message Authentication**
Per garantire integrità e autenticità utilizziamo i MAC, si calcolano utilizzando il messaggio e la chiave.
Un altro meccanismo per garantire soltanto integrità sono le funzioni di Hash, infatti non richiedono una chiave ma eseguono calcoli matematici sul messaggio, per utilizzarle anche per garantire autenticazione possiamo:
- Cifrare il digest con una chiave simmetrica
- Cifrare il digest con chiave asimmetrica
- Non cifrare ma usare un secret value da aggiungere prima e dopo il messaggio

Vediamo alcune delle principali funzioni di Hash:
- Simple Hash Functions: Esegue un semplice XOR fra tutti i blocchi, efficace soltanto per garantire integrità
- HMAC: Garantisce sia integrità che autenticità dato che utilizza una chiave. Va scelta una funzione di Hashing e poi:
	- Viene fatto lo XOR fra la chiave K e un valore _ipad_, il risultato viene inserito prima del messaggio.
	- Viene eseguito un primo Hash
	- Viene fatto lo XOR fra la chiave K e un valore _opad_ e viene inserito dopo l'output del primo hash
	- Viene eseguito un altro hash
	La potenza dell'algoritmo dipende dalla funzione di hash utilizzata.
- SHA-512: 
	- Fase 1: Il messaggio deve essere un multiplo di 1024 viene quindi inserito un padding nel seguente modo:
		- Si aggiunge un 1 subito dopo la fine del messaggio
		- Si aggiunge una serie di 0
		- Gli ultimi 128 bit sono riservati per scrivere la lunghezza del messaggio originale
		La lunghezza dopo aver aggiunto il padding deve essere 896(mod.1024) in modo che appunto aggiungendo gli ultimi 128 bit si ottenga un multiplo di 1024
	- Fase 2: Inizializzazione dei registri, si utilizzano 8 registri grandi 64bit (parte frazionaria delle radici quadrate dei primi 8 numeri primi)
	- Fase 3: Ciclo dei round, ogni singolo blocco viene elaborato per 80 round dove i valori dei registri vengono mescolati con:
		- Funzioni logiche non lineari
		- Costanti di round
		- Parole del messaggio
		I valori finali dei registri vengono sommati con i valori iniziali e passati al round successivo
	- Fase 4: La concatenazione di tutti questi registri compone il nostro risultato da 512 bit.

**Cifratura a chiave Asimmetrica**
La cifratura a chiave asimmetrica è molto importante per lo scambio di chiavi e anche l'autenticazione, l'algoritmo principale è l'1.
Questo algoritmo si basa sui numeri primi, dato un messaggio numerico compreso tra 0 e un valore $n-1$ indichiamo con C il messaggio cifrato e con M il messaggio in chiaro: $$ C = M^e \text{ mod }n$$ $$ M = C^d \text{ mod } n$$

Per funzionare, mittente e destinatario devono conoscere $n,e$ mentre soltanto il destinatario deve conoscere $d$. Infatti la chiave pubblica sarà composta da $\{e,n\}$ mentre la chiave privata da $\{d, n\}$.
Vanno soddisfatte 3 proprietà:
- Deve essere possibile trovare $e,d,n$ tali che $M^{ed} \equiv_{\text{n}} M$ per ogni $M < n$
- Deve essere facile calcolare $M^e$ e $C^d$ per ogni $M<n$
- Deve essere impossibile trovare $d$ dato $n$ ed $e$

Per funzionare quindi dobbiamo trovare una relazione: 
$$M^{ed} \equiv_{n} M$$
Per soddisfarla deve essere vero:
$$ed \equiv_{\phi(n)}1$$
Dove con $\phi(n)$ indichiamo il numero di interi $<n$ relativamente primi a $n$ ovvero che non hanno divisori in comune con $n$.
Per semplificare questo calcolo ci basta prendere $n=pq$ con $p$ e $q$ due numeri primi, in questo modo abbiamo che $\phi(n)=(p-1)(q-1)$

Per cifrare seguiamo quindi questa procedura:
- Scegliamo un $n$ utilizzando due numeri primi
- Scegliamo $e$ a caso in modo che non abbia divisori in comune con $\phi(n)$, abbiamo la chiave pubblica
- Scegliamo $d$ in modo che $ed \equiv_{\phi(n)}1$
- A questo punto per cifrare eleviamo alla $e$ e prendiamo il resto della divisione con $n$ mentre per decifrare utilizziamo $d$.

Ci sono delle buone pratiche da seguire:
- p, q devono avere lunghezza simile e non devono essere piccoli
- $(p-1)(q-1)$ deve avere fattori primi grandi
- $MCD(p-1,q-1)$ deve essere piccolo
- Se $e<n$ e $d<n^{1/4}$ allora $d$ può essere facilmente determinato con degli algoritmi.

I principali metodi per attaccare RSA sono:
- Bruteforce
- Timing Attacks (Vedere quanto tempo impiega il sistema a decifrare )
- Chosen Ciphertext
- Attacchi Matematici:
	- Fattorizzare $n$ e trovare $\phi(n)$ e $d$
	- Determinare $d$ con $\phi(n)$ senza $p,q$
	- Determinare direttamente $d$

**Digital Signatures**
Cifratura asimmetrica e funzioni hash sono alla base dei certificati digitali, per garantire autenticità infatti dobbiamo:
- Calcolare l'hash del messaggio
- Cifrarlo con la nostra chiave privata
- Inviarlo insieme al messaggio non cifrato
Come ci assicuriamo che chi ci ha dato la sua chiave pubblica sia veramente chi afferma di essere? Utilizziamo i certificati digitali, questi sono composti da:
- Chiave pubblica da distribuire
- A chi è stato rilasciato il certificato
- Ente che lo ha firmato
- Informazioni sul certificato

Per prepararne uno:
- Genero coppia di chiavi
- Preparo un certificato da inviare alla CA con la mia chiave pubblica all'interno
- La CA fa l'hash e lo cifra con la sua chiave privata
- Il certificato può essere rilasciato

In generale per garantire autenticità devo sempre firmare con la mia chiave privata, mentre per cifrare messaggi da inviare ad altre persone cifro con la loro chiave pubblica

**Digital Envelopes**
Dato che la cifratura asimmetrica consuma molto, si utilizza soltanto per spedire la chiave simmetrica:
- Preparo un messaggio e lo cifro con chiave simmetrica
- Cifro la chiave simmetrica con la chiave pubblica del destinatario
- Invio il messaggio

**Diffie-Hellman**
Algoritmo ancora oggi utilizzato per scambiare chiavi in modo sicuro.
- Si scelgono in modo pubblico, un numero primo $q$ e un altro numero $\alpha < q$ con $\alpha$ radice primitiva di $q$
- A genera le sue chiavi selezionando la privata $X_A < q$ e la pubblica $Y_{A}=\alpha^{X_{A}}$
- B fa la stessa cosa
- Si scambiano la loro chiave pubblica e poi possono calcolare la chiave che dovranno utilizzare per comunicare: $$A \rightarrow K = Y_{B}^{X_{A}} \text{mod q}$$$$B \rightarrow K = Y_{A}^{X_{B}} \text{mod q}$$
Da notare che hanno radici primitive soltanto i numeri $2,4,p^k, 2p^k$ con $p$ numero primo dispari.

Il problema è che questo algoritmo è vulnerabile al MITM

**Key Distribution**
Un altro metodo per distribuire le chiavi è quello di utilizzare altri host che si fidano.
Ad esempio se A deve inviare un messaggio a B ed entrambi hanno una connessione sicura con C allora possono sfruttarlo per passarsi la chiave. Esistono due tipi di chiave in questa tecnologia:
- Session Key: Una chiave utilizzata per una sessione da A e B, alla fine viene distrutta.
- Permanent Key: Viene utilizzata per distribuire le session key.
Inoltre ci sono due dispositivi principali:
- Key Distribution Cente: Invia la session Key
- Security Service Module: Ottiene le session key ed effettua la cifratura dei messaggi
La procedura è la seguente:
- A chiede di parlare con B
- Il SSM chiede al KDC
- Il KDC genera la session key e la invia al SSM utilizzando la permanent key
- I due host adesso possono comunicare.

**Cryptanalysis**
Uno dei principali metodi per attaccare sistemi di cifratura. Dipende da cosa conosce l'attaccante, supponendo che conosca l'algoritmo utilizzato:
- Ciphertext Only: Conosce soltanto il testo cifrato, può effettuare bruteforce sulla chiave o trovare pattern nel testo.
- Known Plaintext: Conosce il testo in chiaro e può effettuare la cifratura, può dedurre la chiave in base a come viene trasformato il testo
- Chosen Plaintext: Usa un testo con dei pattern per vedere somiglianze nel testo cifrato output.
- Chosen Ciphertext: Invia un testo cifrato ad-hoc e vede il risultato per cercare di dedurne la chiave.
- Chosen Text: Può effettuare sia cifratura che decifratura, sono gli ultimi due insieme.

**User Authentication**
Ci sono due fasi principali:
- Identificazione
- Autenticazione, questa si basa su diversi fattori:
	- Something you know: password
	- Something you are: dati biometrici, i sensori in questo caso devono fare attenzione a 4 valori:
		- Sensitivity
		- Specificity: Veri negativi / Tutti i negativi
		- Accuracy: Veri positivi / Tutti i positivi
		- Prevalence: Situazioni più comuni
	- Something you have: token, sono:
		- Attivi: Cambiano informazioni nel tempo
		- Passivi: Non cambiano mai

Si utilizzano anche sistemi FIM (Federated Identity Management) dove si fa l'autenticazione una sola volta e poi abbiamo tutti i servizi collegati, lo SPID è un esempio di FIM. Esiste anche il Single Sign On che invece è come il "Accedi con Google".

Questa può essere attaccata in vari modi:
- Client Attack (fa finta di essere autorizzato)
- Host Attack: Si attacca il punto dove sono salvate le password
- Eavesdropping: Ruba la password
- Trojan Horse
- Replay Attacks
- DoS

**Access Control**
Si basa su 3 elementi:
- Object: Cosa vogliamo proteggere
- Subject: Chi accede agli Object
- Access Mode: Permessi

Va effettuato seguendo delle best practices:
- Tracking dei permessi nel tempo (modificarli)
- Least Privilege
- Assicurarsi che gli utenti utilizzino i permessi nel modo corretto

Dobbiamo anche definire un certo livello di _granularity_ dei permessi per garantire un certo livello di accuratezza e controllare gli audit log nel tempo. 

Esistono diverse implementazioni dell'Access Control
- Access Control Directory: Ogni utente ha un file che dice a cosa può accedere e con quali permessi, questo porta però vari problemi:
	- Propagation dei permessi
	- Dimensioni enormi
	- Pseudonimi di file
- Access Control Matrix: Una matrice dove le righe indicano gli utenti e le colonne i files. Viene considerata inefficiente dato che molte celle rimarrebbero vuote.
- Access Control List: In questo caso ogni oggetto ha una lista che mostra quali utenti hanno accesso e con quali permessi
- Priviledge List: Come prima ma incentrato sugli utenti, ogni utente ha una lista degli oggetti a cui ha accesso e con quali permessi

Inoltre possiamo seguire due metodologie principali per l'access control:
- Role-Based Access Control: Ci sono due tabella, una che per ogni utente indica a che ruoli appartiene e una per ogni ruolo che indica che permessi ha.
- Attribute-Based Access Control: Si basa su 3 pilastri fondamentali:
	- Attributi: definiscono caratteristiche dei soggetti, oggetti e ambiente
	- Policy Model: L'insieme di regole che utilizzano gli attributi di prima per regolare gli accessi
	- Architecture Model: Definisce come i vari componenti software collaborano per prendere una decisione

**Programs and Programming**
Nella programmazione dei software possiamo andare in contro a:
- Errori: Di natura umana
- Fault: Un passaggio scorretto
- Failure: Il comportamento del sistema non rispetta i requisiti
- Flaw: Omissione di controlli da effettuare

Questi errori se sfruttati da attaccanti possono portare a:
- Buffer Overflow: si contrasta con:
	- Controlli input
	- Scelta del linguaggio
	- Canary
- Time-of-Check / Time-of-Use: Sfruttare il tempo che passa fra il controllo di un'autorizzazione e l'effettivo utilizzo di quel file
- Incomplete Mediation: Autorizzare qualcosa senza effettuare controlli approfonditi
- Backdoor
- Race Condition

**Malware**
Ne esistono di diversi tipi, possiamo classificarli in base a:
- Come si propagano:
	- Virus: Infetta altri programmi e possono vivere o con il SO _resident_ o con il programma stesso _transient_
	- Worm: Crea sue copie nella rete e può farlo in diversi modi, casuale, lista prefatta, topologica, sottorete.
	- Trojan Horse
- Oppure in base a cosa fanno:
	- Logic Bomb: Si attivano in determinate condizioni
	- Ransomware
	- Spyware
	- Rootkit: Si nascondono in zone privilegiate del SO.

Hanno diverse proprietà:
- Harm: Distruttivi e non distruttivi
- Propagazione: Setup, file allegati, autorun, iniezione
- Attivazione: Zero-day, boot sector, processi attivi
- Stealth: Gli antivirus riconoscono la firma e si possono nascondere con tecniche di steganografia, ci sono inoltre virus poliformici che cambiano la loro struttura e virus cifrati

Le contromisure sono:
- Educare l'utente
- Modularità
- Incapsulamento
- Mutual Suspicion: I programmi non devono fidarsi fra loro
- Genetic Diversity: Evitare troppo prodotti della stessa fonte

Per fare testing:
- Blackbox: Vedere input e output
- ClearBox: Vedere anche il codice interno
- Pentesting

Evitare:
- Penetrate and Patch
- Security by Obscurity

**Internet Security**
- Browser Attacks
	- Man in the browser
	- Keystroke logger
	- Page in the middle
	- Program download Substitution
	- User in the middle (CAPTCHA bot)
	- Web Bug (GIF 1x1)
	Il problema principale è l'autenticazione che dipende da:
	- Usabilità e Accuracy che vanno in conflitto
	- Manomissione dei dati presenti sul pc
	- software malevoli che osservano come avviene l'autenticazione
	Come si fa quindi in modo sicuro?
	- Share Secret
	- One-Time Password
	- 2FA
	Le principali contromisure sono:
	- Integrity Checksum
	- Signed Code (alcune aziende verificate sono comunque malevole)
- XSS: Cross Site Scripting, introdurre input di utenti in pagine senza sanitizzare.
- SQLi
- AppMobile: Sono vulnerabili dato che spesso sono eseguite in background, potrebbero avere componenti non aggiornati e problemi di crittografia. No Log
- Attacchi tramite Email: Usare crittografia PGP
	- Chiave di sessione simmetrica per confidenzialità cifrata con chiave pubblica
	- Hash cifrato con chiave privata per integrità e autenticazione
	- Distribuzione chiavi: Certificati fornite da CA in modo gerarchico

**OS Security**
Se non implementato a livello hardware va implementato dall'SO per HW generico:
- Access Control List
- Events Logging
- Virtualizzazione
- Sandbox
- Honeypot

Un principio da seguire è *Separation And Sharing* per gli utenti:
- Fisica (dispositivi distinti)
- Temporale: Processi in tempi diversi
- Logica: Processi pensano di essere soli
- Crittografica

Come si protegge invece la memoria con i meccanismi hardware?
- Fence: Limite per inizio e fine memoria SO e Utente
	- Statici: Non cambiano mai
	- Dinamici: In un registro è salvato l'indirizzo di confine ma può cambiare nel tempo
	- Bas / Bound Register: Coppie di registri per ogni programma che indicano inizio e fine
Un altro meccanismo è quello di separare il codice e la memoria del programma con in totale quindi 4 registri. Permette di utilizzare la _Tagged Architecture_ ovvero associare ad ogni word un'etichetta di permessi.

Un altro concetto per la separazione di memoria è la segmentazione e la memoria virtuale.
Possiamo vedere il programma come un insieme di blocchi che si trovano nella memoria fisica ma in zone diverse. Quando il programma richiede un dato si accede alla segmentation table che fornisce il vero indirizzo di inizio al quale poi viene aggiunto l'offset. Il problema è che questi segmenti hanno dimensioni diverse fra loro e il SO deve controllare che non sforino in altre zone, la soluzione è il paging ovvero dividere la memoria in zone tutte uguali e usare due tabelle.
Prima si passa per la tabella che ci dice l'indirizzo a quale pagina lo troviamo e poi con un'altra tabella vediamo in che zona di memoria si trova quella pagina, si aggiunge sempre l'offset alla fine.

Un SO si definisce sicuro, _Trusted System_ quando garantisce:
- Correttezza Funzionale
- Rispetta l'integrità

**TCB (Trusted Computing Base)**
Insieme di tutti i componenti di un computer la cui corretta esecuzione è indispensabile per garantire sicurezza. Il SO deve per forza fidarsi di questi componenti, da cosa è composta:
- Hardware: CPU, RAM, bus di sistema
- Firmware: BIOS
- Parti dell'SO con alti privilegi: Kernel, Driver dispositivo, processi di sistema
I tre principi della TCB:
- Complete Mediation: Ogni accesso va controllato
- Isolation: La TCB deve essere completamente isolata
- Verifiability: La TCB deve essere il più piccola e semplice possibile per poterla analizzare testare e verificare in modo semplice.
Il problema principale ad oggi è che le TCB sono enormi

**Network Security**
Le comunicazioni delle reti possono essere intercettate in vari modi:
- Sniffing: Dispositivi su cavi di rame
- Microonde
Gli attacchi sono:
- Intercettazione
	Le principali contromisure sono:
	- Cifratura
	- Sicurezza Fisica
	- Linee Dedicate
	- Controlled Routing
	Le debolezze:
	- Anonymity: L'attaccante si nasconde facilmente
	- Più punti di accesso con diversi dispositivi connessi
	- Tante route possibili sconosciute
- Modifica - Data Corruption
	Viene effettuata una modifica durante la trasmissione, nello specifico:
	- Modification Attack: Modifica durante
		- Sequencing: Nuovo messaggio arriva prima di uno precedente
		- Substitution: Comunicazione inserita in un'altra
	- Insertion Attack: Inserito un nuovo messaggio nella comunicazione
	- Replay Attack: Vengono riutilizzati vecchi messaggi
- DoS
	Può anche essere parziale e fanno parte di questo diversi fallimenti:
	- HW failure
	- Routing
	- Excessive Demands
	- Malware
	Nota su Port Scanning

**Wireless Security**
Il componente principale nelle trasmissione WiFi è il _frame_, questo è composta da:
- MAC header
	Contiene il  _Frame Type_ che indica il tipo di frame:
	- Controllo
	- Management
		- Beacon
		- Authentication
	- Data
	Inoltre contiene
	- ToDS, FromDS
	- Controllo di sequenza
	- WEP
	- Indirizzi MAC che stanno comunicando
- Payload
- FCS (bit di controllo)

Le principali vulnerabilità nelle comunicazioni wireless sono:
- Integrità: Si possono inserire segnali radio più forti
- Availability: Anche eventi atmosferici non previsti possono interrompere le comunicazioni

Tra i principali attacchi:
- MAC Spoofing
- Il protocollo WEP è debole:
	- Usa chiavi piccole da 64/128 bit di cui 24 note (IV)
	- Non ci sono controlli di integrità avanzati
	Per questo viene introdotto il WPA
	- Cambia chiave per ogni pacchetto e mantiene una chiave per ogni sessione, per cifrare usa la chiave del pacchetto + un contatore
	  In WPA2/3 si usa la chiave di sessione ma dato che al pacchetto viene associato un numero e si usa AES, comunque due pacchetti uguali avranno un output diverso. Rimane comunque vulnerabile ad un MITM.
	  Il WPA è vulnerabile a chopchop e bruteforce, il chopchop consiste in:
		- I pacchetti WPA sono composti da
			- DAti reali
			- Codice di controllo per integrità
		- Quando il router riceve un pacchetto ricalcola il codice di controllo e se è giusto allora è integro altrimenti viene scartato, se modifico un bit nel messaggio posso calcolare il codice nuovo.
		- L'attaccante cattura un pacchetto cifrato e rimuove l'ultimo byte e il codice non sarà quindi corretto, il CRC per il codice è lineare e quindi può calcolare altri valori che avranno lo stesso checksum
		- Se il router scarta il pacchetto allora la sua ipotesi era errata altrimenti la sua correzione fatta è giusta e ha indovinato il byte rimosso
		- Si sceglie l'ultimo perchè usa RC4 come cifratore e quindi partendo dalla fine non modifichiamo a cascata tutti i valori dopo.
	Un altro problema infine è la _Incomplete Authentication_, l'AP non deve dimostrare chi è.
	Il nuovo WPA3 è immune.
- DoS: Esistono varie tecniche
	- Ping of Death / Flooding
	- Smurf Attack: Finto pacchetto broadcast per la vittima
	- Echo-Chargen: Loop infinito
	- SYN-flood: SYN con ip della vittima
	- Teardrop: Si mandano pacchetti con frammenti non ricomponibili fra loro
	- BotNet: Server Master, C&C, bot, agiscono in PULL o PUSH
- DnS poisoning e spoofing: Attacchi ai DNS o locali o a risposte
- Session Hijack: Si invia un pacchetto con ACK e seq giusto
- Routing Attacks: Si manipolano le routing table dei router per instradare il traffico

Ci si difende con:
- Trojan invertiti
- Risolvere le vulnerabilità
- Load balancing o blacklisting
- Network Cryptography
	- Link Encryption, cifrato all'origine ma decifrato ad ogni step. Più semplicità per l'utente e occultamento del traffico ma nodi intermedi vulnerabili
	- End-to-End: Cifrati da inizio a fine, il problema è che i metadati sono esposti, più carico sugli host

IPSec è il protocollo che gestisce i dati crittografati, serve a contrastare principalmente:
- Spoofing
- Intercettazione
- Session Hijack
Si appoggia a:
- Security Association: Sono i parametri che si scambiano due nodi per comunicare
- ISAKMP: Protocollo per scambiare le chiavi fra i nodi, le fasi sono:
	- Diffie Hellman per generare le chiavi
	- Si autenticano a vicenda utilizzando il segreto generato prima
	- Derivano la chiave crittografica

IPsec può incapsulare i pacchetti in due modi:
- Transport Mode: Si cifra soltanto il payload ma gli IP Header rimangono in chiaro
- Tunnel Mode: Si nascondono anche gli IP e si manda ad un dispositivo sicuro che poi si occuperà di mandarlo al vero IP

**Firewall**
Primo approccio: segmentare le reti ma non risolve il controllo degli accessi.

Deve rispettare il _Reference Monitor_:
- Always Invoked
- Tamperproof: protetto da manomissioni
- Small and Simple

I firewall possono seguire diversi approcci per gestire gli accessi:
- Default Permit
- Default Deny
- Le regole vengono sempre lette dall'alto in basso

Possiamo classificarli in base a:
- Dove vengono posizionati
	- DMZ: Ci sta un firewall esterno che fa entrare i dati nella DMZ poi da li un altro firewall decide chi può entrare nella LAN privata
- Cosa fanno
	- URL Filtering: Controllano soltanto gli indirizzi e non hanno memoria
	- Circuit Level: Viene invocato soltanto per stabilire la connessione (VPN)
	- Stateful Inspection: Ha memoria dei pacchetti precedenti
	- Deep packet inspection: Ispeziona anche il contenuto dei pacchetti
	- App Proxy Gateway: Sta a livello applicazioni ed è lui che riceve i dati in primis
	- Guard: Firewall super avanzato basato anche su algoritmi di ML, le regole si limitano a tutto ciò che è computabile.
	- Sandbox: Può vedere come si comportano i pacchetti in ambienti isolati.
- Limitazioni
	- Proteggono soltanto l'accesso principale
	- Sono il bersaglio principale
	- Se si fida di qualcosa non lo controlla
	- Manutenzione
- NAT

**Intrusion Detection System**
Dispositivo per monitorare gli utenti:
- Monitora Utenti
- Controlla file
- Audit Configurazioni
- Honeypot

Il problema principale è l'accuratezza (falsi positivi / negativi)

In che modo rileva delle intrusioni?
- Signature Based: Segue pattern matching su "firme" di attacchi conosciuti, ma se questa non è presente nel suo database non la può riconoscere.
- Non può tracciare IP teardrop e SYN flood, sarebbe troppo costoso mantenere memoria delle connessioni
- Heuristic Based: Costruisce un suo modello tramite tecniche di ML:
	- Inference Engine: Somma le azioni sospette di un host, quando supera il limite lo segnala
	- L'inference può avvenire State-Based (Automi a stati, se ci sta una transizioni vietata lo segnala) o Model-Based (Ha un suo modello di comportamento ideale)\
- Come PRO ha sicuramente la sua possibilità di adattarsi nel tempo ma come CONTRO abbiamo bisogno di buone informazioni per allenarlo.

Possiamo installarli:
- Host-Based
- Network-Based: Vantaggio possono andare in Stealth mode con una scheda di rete senza indirizzo

Per quanto riguarda il posizionamento in rete invece:
- Dietro il firewall esterno
	- Monitora attacchi che superano il firewall
	- Trova problemi nel firewall
	- Rileva traffico in uscita anomalo
- Tra firewall esterno e internet per monitorare il traffico non filtrato
- A difesa di reti interne
- Prima di specifiche sottoreti

Se un IDS può agire allora diventa un IPS (Prevention) e può rispondere in 4 modi:
- Monitor: Studia l'attaccante
- Call a Human
- Protect: Cambia la struttura della rete
- Signal: Manda allarme

**Defensive Programming**
Bisogna assumere che tutto andrà storto, nello specifico:
- Gli utenti commetteranno errori e/o inseriranno input assurdi
- Gli attaccanti cercheranno di inviare input malevoli
- Il software di terze parti potrebbe fallire o rispondere in modo inatteso
Dobbiamo assicurarci che il software funzioni sempre in modo sicuro o che fallisca in modo controllato.
Le regole d'oro degli sviluppatori sono:
- Mai fidarsi dell'input
- Gestione sicura delle eccezioni
- Least privilege per il programma
- Gestione corretta della memoria
Se si esagera ci sono dei contro:
- Overhead di prestazioni
- Iper-complessità del codice
- Nascondimento di bug gravi
Si possono effettuare i seguenti test:
- Test dei valori limite
- Test negativi (file errati) per assicurarsi che il sistema vada in crash controllato
- Fuzzing: Input casuali conosciuti per verificare condizioni di sistema