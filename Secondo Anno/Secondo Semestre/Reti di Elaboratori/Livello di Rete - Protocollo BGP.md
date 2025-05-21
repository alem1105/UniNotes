Come viene eseguito il routing in Internet? È impossibile usare un solo protocollo di routing, infatti per ora abbiamo visto piccole reti tutte composte da router indistinguibili ma nella realtà:

Ci sono più di 200 milioni di destinazioni e questo significa che:
- Si dovrebbe usare una grande quantità di memoria per archiviare le informazioni d'instradamento per ciascuna destinazione su ciascun host.
- Se si usa LS, il traffico dati generato non lascerebbe spazio al traffico dei veri dati da trasmettere.
- DV non convergerebbe mai

Ogni rete è amministrata in modo diverso.

Ogni ISP è un'autorità amministrativa quindi usa le sottoreti che vuole e impone le politiche sul traffico che vuole.

# Instradamento Gerarchico
Ogni ISP è un **sistema autonomo (AS)** e quindi può eseguire un qualsiasi protocollo di routing a seconda delle sue esigenze.

I router all'interno di un AS però eseguono lo stesso protocollo:
- Se un protocollo è interno ad un AS si dice **intra-AS** o intradominio o interior gateway protocol **IGP**.
- I router appartenenti ad AS differenti possono eseguire protocolli d'instradamento intra-AS diversi

All'esterno degli AS usiamo i protocolli inter-dominio che gestiscono quindi il routing tra i vari AS, dobbiamo averne soltanto uno. Possiamo indicarli con diversi nomi: inter-AS, inter-dominio o Exterior Gateway Protocol **EGP**.

Questi i protocolli di routing inter-AS vengono usati dai **router gateway** ovvero quei router che mettono in contatto diversi AS e che hanno quindi il compito di inoltrare i pacchetti verso destinazioni esterne.

# Sistemi Autonomi
Ogni ISP è un sistema autonomo, a questi viene assegnato un numero identificativo univoco a 16 bit chiamato **Autonomous number - ASN** dall'ICANN.

Hanno dimensione variabile e vengono classificati in base a come si connettono ad altri AS:
- **AS stub** - Ha un solo collegamento verso un altro AS. Il traffico può solo essere generato o destinato allo stub ma non può transitarci all'interno. (ad esempio le aziende)
- **AS multihomed** - Ha più di una connessione con altri AS ma non consente il transito del traffico. (aziende che usano più di un network provider ma non forniscono connettività ad altri AS)
- **AS di transito** - È collegato a più AS e consente il traffico al suo interno (ad esempio i network provider e le dorsali)

## Sistemi Autonomi Interconnessi
Ogni sistema autonomo sa come inoltrare i pacchetti sul percorso ottimo verso qualsiasi destinazione interna al gruppo:

![[Screenshot 2025-05-07 alle 09.35.00.png|400]]

Se i 3 sistemi sono connessi non significa che utilizzino lo stesso protocollo di routing intra-AS.

In questo esempio abbiamo che i router 3a, 1c, 1b e 2a sono router gateway.

# Routing Inter Dominio
Per questo tipo di routing usiamo il protocollo **BGP - Border Gateway Protocol**.

![[Pasted image 20250507093942.png|400]]

Quindi come detto prima ogni router sa come raggiungere tutte le destinazioni presenti all'interno del suo stesso AS ma non sa come raggiungere quelle di altri AS.

Il protocollo BGP serve appunto a determinare le coppie origine-destinazione che interessano più AS.

BGP è un protocollo **path vector** quindi simile al distance vector ma nel vettore non salviamo le distanze ma i percorsi. Questo protocollo ci permette di:
- Ottenere informazioni sulla raggiungibilità delle sottoreti da parte di AS confinanti.
- Propagare le informazioni ricevute a tutti i router interni ad un AS.
- Determinare percorsi buoni verso le sottoreti sulla base delle informazioni di raggiungibilità e delle politiche dell'AS.

Il BGP è quindi quel protocollo che permette ad una sottorete di comunicare al resto di Internet la sua esistenza.

## Patch Vector Routing
I protocolli LS e DS che abbiamo visto si basano sul costo minimo di un percorso ma non sempre è l'obiettivo primario, ad esempio si potrebbe voler evitare di far transitare i dati su determinati router e i protocolli basati su costo minimo non permettono di applicare questo tipo di politiche.

Con i path vector invece la sorgente può controllare il percorso:
- Applicare politiche
- Evitare nodi

Come gli altri protocolli si basa comunque su delle tabelle che vengono diffuse nella rete, quando un nodo ne riceve una deve aggiornare la sua in base alle politiche scelte e poi trasmetterla:

![[Pasted image 20250507094755.png|400]]

Quindi cosa succede quando C riceve una copia del path vector di B?

![[Pasted image 20250507094830.png|400]]

## eBGP e iBGP
Per permettere l'instradamento corretto su ogni router è necessario installare su tutti i border router dell'AS una variante del BGP chiamata **BGP esterno** o eBGP, tutti i router invece dovranno usare un'altra variante chiamata **BGP interno** o iBGP.

In conclusione quindi i router di confine dovranno eseguire 3 protocolli di routing:
- intra-dominio
- eBGP
- iBGP

Mentre gli altri router soltanto due: iBGP e intra-dominio

> [!info] Fondamenti di BGP
> - Coppie di router si scambiano le informazioni di instradamento usando TCP sulla porta 179.
> - I router che si scambiano questo tipo di messaggi prendono il nome di **peer BGP** e la connessione dove avvengono questi scambi di messaggi **sessione BGP**.
> - Le linee di sessione BGP non sempre corrispondono a collegamenti fisici.

### eBGP
Due **border router** in due AS diversi formano una coppia di peer BGP e si scambiano messaggi.

_Esempio_

![[Pasted image 20250507095621.png|500]]

Le informazioni che questi router si scambiano però non sono complete, infatti:
- I router di confine sanno come instradare i pacchetti soltanto verso AS vicini (ad. es. AS2 -> AS1, AS3 -> AS1 ecc...)
La soluzione è l'utilizzo di iBGP

### iBGP
Questo crea una sessione tra ogni possibile coppia di router all'interno di un AS, in queste sessioni non tutti hanno qualcosa da inviare ma sicuramente da ricevere:

![[Pasted image 20250507100111.png|500]]

Non avviene soltanto questo scambio, ad esempio R1 dopo aver ricevuto informazioni da R2 combina informazioni sulla raggiungibilità di AS3 con quelle che già aveva e invia un nuovo messaggio da inviare a R5. Questo processo continua finché non ci sono più informazioni da propagare.

Le informazioni fornite da iBGP ed eBGP vengono combinate ed usate per creare le tabelle dei percorsi.

# Tabelle di Percorso
Finito lo scambio di messaggi otteniamo queste tabelle:

![[Screenshot 2025-05-07 alle 10.09.25.png|400]]

![[Pasted image 20250507101013.png|400]]

Queste tabelle non sono le "finali", queste infatti vengono inserite nelle **tabelle di routing** intra-dominio generate ad esempio da RIP o OSPF.

# Tabelle di Routing
Per generarle possiamo individuare due casi:
- AS stub - Abbiamo un solo router di confine che aggiungerà quindi come regola di default alla fine della tabella di routing il router che si trova all'altro estremo del peer eBGP.
- AS di transito - Oltre ad aggiungere il contenuto alle tabelle va anche aggiunto il costo, si imposta pari a quello per raggiungere il primo AS nel percorso.

Quindi per i router di confine negli stub abbiamo:

![[Pasted image 20250507101731.png|400]]

Mentre per quelli di transito:

![[Pasted image 20250507101912.png|400]]

---

Quando un router annuncia una rotta per una rete (prefisso) per una sessione BGP include anche un certo numero di **attributi BGP**. La combinazione di prefisso e attributi forma la "rotta".

Due dei più importanti attributi sono:
- **AS-PATH** - Serve a selezionare i percorsi. Elenca tutti gli AS attraverso i quali è passato l'annuncio del prefisso ovvero gli hop intermedi della rotta. Tutti gli AS, ad eccezione degli stub, hanno un identificativo univoco, evitiamo gli stub per non avere cicli.
- **NEXT-HOP** - L'indirizzo IP dell'interfaccia sul quale viene inviato il pacchetto, ricordiamo infatti che un router ha più indirizzi IP, uno per ogni interfaccia.

Quando un router gateway riceve un annuncio di rotta, utilizzando le sue **politiche di importazione** decide se accettare o filtrare la rotta, ad esempio:
- L'AS può non voler inviare traffico in qualche AS presente in AS-PATH.
- Il router conosce una rotta migliore di quella ricevuta.

## Selezione dei percorsi BGP
Un router può ricavare più di una rotta verso un router e deve quindi scegliere, usiamo le **regole di eliminazione**:
1) Assegnamo alle rotte un attributo **preferenza locale**, selezioniamo le rotte che hanno valore più elevato su questo attributo.
2) Si seleziona la rotta con valore AS-PATH più breve.
3) Si seleziona la rotta dove il router NEXT-HOP ha costo minore. (**hot potato routing**)
4) Se rimangono ancora delle scelte da fare allora il router si basa sugli **identificatori BGP**.

# BGP: Advertisement Ristretto
Gli ISP vogliono instradare solo il traffico delle loro customer network.

![[Pasted image 20250507103315.png|400]]

- A annuncia il percorso Aw a B e a C
- B non annuncia BAw a C
	- B non ha un vantaggio nell'instradare CBAw dato che nessuno tra C, A e w sono clienti di B
	- C quindi non scopre il percorso CBAw
- Per arrivare a w C instraderà soltanto CAw senza passare per B

Da notare che ad esempio x essendo un dual-homed non vuole che il traffico transita, avremo quindi che x non annuncerà la sua rotta per C a B e viceversa.

# Messaggi BGP
Abbiamo visto che vengono scambiati tramite TCP, ci sono diversi tipi di messaggi:
- **OPEN** - Apre la connessione TCP e permette l'autenticazione del mittente
- **UPDATE** - Annuncia il nuovo percorso o cancella quello vecchio
- **KEEPALIVE** - Mantiene la connessione attiva in mancanza di UPDATE
- **NOTIFICATION** - Riporta gli errori del precedente messaggio oppure viene usato per chiudere il collegamento.

> [!info] Perché inter-AS e intra-AS sono protocolli diversi?
> Si vuole una diversa gestione delle politiche, negli inter-AS si vuole avere controllo di come si muove il traffico e chi lo muove. Negli intra-AS c'è un unico controllo amministrativo e quindi le scelta delle politiche è meno impattante.
> 
> Per quanto riguarda le prestazioni negli intra-AS vogliamo appunto più prestazioni mentre negli inter-AS le politiche possono prevalere sulle prestazioni.


