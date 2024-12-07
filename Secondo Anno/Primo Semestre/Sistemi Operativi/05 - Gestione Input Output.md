Il problema principale della gestione Input Output è che ci sono tantissimi dispositivi e tutti molto diversi fra loro, inoltre c'è anche una grande varietà di applicazioni che utilizzano questi dispositivi. 

Scrivere un S.O. in grado di gestirli tutti è quindi molto difficile.

Possiamo dividere i dispositivi in 3 categorie:
- Leggibili dall'utente
- Leggibili dalla macchina
- Dispositivi di comunicazione

## Dispositivi Leggibili dall'Utente
Sono i dispositivi utilizzati per la comunicazione con l'utente, come:
- Stampanti
- Terminali Hardware: Monitor, Tastiera, Mouse.
  Da non confondere con i terminali software dove eseguiamo comandi

In generale tutto quello che usa l'utente per dare informazioni al computer

## Dispositivi Leggibili dalla Macchina
Dispositivi per la comunicazione leggibili in modo elettronico quindi ad esempio:
- Dischi
- Chiavette USB
- Sensori
- ecc...

## Dispositivi di Comunicazione
Utilizzati per la comunicazione con altri dispositivi:
- Modem
- Schede Wi-Fi
- Schede Ethernet

# Funzionamento dei Dispositivi I/O
Si chiamano così perché appunto servono a scambiare informazioni con un elaboratore.

Un **dispositivo di input** è fatto in modo per essere interrogato sul valore di una grandezza al suo interno, ad esempio:
- Il mouse può essere interrogato sul suo ultimo spostamento effettuato
- La tastiera viene interrogata sul codice Unicode dei tasti premuti
- Il disco vi dice i valori dei bit in una certa posizione

Un processo che effettua una _syscall_ `read` su un dispositivo vuole conoscere questo dato per poi eseguire delle azioni.

---

Un **Dispositivo di Output** prevede di cambiare il valore di una certa grandezza fisica al suo interno. Ad esempio:
- Un monitor prevede di cambiare il valore RGB dei suoi pixel
- Una stampante il file da stampare
- Un disco il valore dei bit da sovrascrivere in una certa posizione

Un processo che effettua una _syscall_ `write` vuole cambiare qualche valore all'interno del dispositivo.

---

Il sistema operativo deve quindi offrire due _syscall_: `read,write` e tra i loro argomenti ci sarà l'identificativo del dispositivo interessato, su Linux c'è il _file descriptor_.

Se avviene una syscall, entra in gioco il kernel che comanda l'inizializzazione del trasferimento di informazioni in lettura o scrittura a seconda del caso, mette il processo in blocked e passa ad altro. A questo punto al resto ci pensa il dispositivo I/O.

La parte del kernel che gestisce un particolare dispositivo I/O si chiama **driver**, questo quindi fornisce gli opportuni comandi al S.O. per controllare il dispositivo, spesso sono istruzioni macchina.

Il trasferimento dei dati spesso si fa con il [[01 - 04 - Fino a Gestione Memoria#Accesso Diretto in Memoria (DMA)|DMA]].

A trasferimento completato arriva l'interrupt e il processo torna ready:
- L'operazione di trasferimento potrebbe fallire, ad esempio un disco difettoso
- Potrebbe essere necessario fare ulteriori trasferimenti

# Differenze tra Dispositivi I/O
Prima abbiamo detto che esistono tanti dispositivi di I/O, tutti diversi fra loro, vediamo quali sono i fattori che contribuiscono a questi cambiamenti:
- Data rate: Frequenza di accettazione / emissione di dati
- Applicazione: Il modo in cui vengono usati
- Difficoltà nel controllo
- Unità di trasferimento dati (caratteri oppure blocchi di dati)
- Rappresentazione dei dati
- Condizioni di errore

## Data Rate
È la velocità di trasferimento dei dati, ci sono dispositivi molto lenti e altri molto veloci

![[Pasted image 20241118115711.png|500]]

## Applicazioni
È il modo in cui vengono usati, ad esempio i dischi sono usati per memorizzare files e richiedono un software per la gestione di quest'ultimi. Ma possono anche essere utilizzati per la memoria virtuale.

Oppure un terminale come tastiera e mouse usato da un amministratore dovrebbe avere priorità più alta.

## Complessità del Controllo
- Tastiera e Mouse richiedono un controllo molto semplice.
- Una stampante è più complessa dato che deve muovere molti macchinari per la stampa.
- Il Disco è una delle cose più complesse da controllare.

Tutto questo non si fa solo software ma anche con hardware dedicato.

## Unità di Trasferimento Dati
I dati possono essere trasferiti:
- In blocchi di byte di lunghezza fissa, usato ad esempio per memorie secondarie come dischi, chiavi USB ecc...
- Flusso di byte (stream) o equivalentemente di caratteri, usato da qualsiasi cosa non sia memoria secondaria, quindi terminali hardware, dispositivi di comunicazione di rete ecc...

## Rappresentazione dei Dati
I dati sono rappresentati secondo codifiche diverse in dispositivi diversi, ad esempio tastiere possono usare ASCII o UNICODE o avere controlli di parità diversi.

## Condizioni d'Errore
La natura degli errori varia da dispositivo a dispositivo:
- Possono notificare gli errori in modo diverso
- Conseguenze degli errori, possiamo avere errori fatali o altri ignorabili
- Gestione degli errori

Ad esempio se abbiamo dei pixel rotti su un monitor non funzioneranno quelli e basta, ma se invece su un disco abbiamo degli errori potrebbe non avviarsi nemmeno il sistema operativo.

# Tecniche per effettuare I/O
In generale abbiamo diverse modalità di fare I/O:

![[Pasted image 20241118121629.png|500]]

## DMA
- Il processo delega le operazioni di I/O al modulo DMA.
- Il modulo trasferisce i dati direttamente da o verso la memoria principale
- Quando l'operazione è terminata, il modulo genera l'interrupt per il processore

**Modulo DMA:**

![[Pasted image 20241118121838.png|350]]

- Data Register: Contiene i dati da trasferire
- Control Logic: Decide cosa deve fare, contiene quindi informazioni sull'operazione da eseguire.

Le frecce che vanno verso l'esterno sono informazioni che il DMA da al S.O., le frecce verso di lui invece sono informazioni che riceve.

# Evoluzione della Funzione di I/O
Inizialmente il processore controllava il dispositivo esterno.

Successivamente è stato aggiunto un modulo di I/O direttamente sul dispositivo, abbiamo ottenuto il **I/O programmato, senza interrupt** ma il processore non si deve occupare di alcune cose del dispositivo.

Vengono introdotti **gli interrupt**, migliorano l'efficienza dato che il processore non deve aspettare che il dispositivo finisca.

Viene introdotto il **DMA**, i dati viaggiano direttamente tra dispositivo e memoria senza usare il processore, quest'ultimo agisce solo all'inizio e alla fine dell'operazione.

Viene migliorato il DMA, il modulo I/O diventa un processore separato chiamato **I/O Channel**, successivamente gli viene data anche una **RAM dedicata**. Quindi molti dispositivi di ultima generazione sono dei "mini computer" a tutti gli effetti.

## Come otteniamo l'efficienza?
La maggior parte dei dispositivi sono molto lenti rispetto alla RAM, come abbiamo visto dobbiamo sfruttare al meglio la multiprogrammazione per mettere in attesa programmi mentre altri sono in esecuzione.

L'I/O potrebbe comunque non riuscire a stare al passo della CPU, avremo quindi pochissimi processi ready.

È necessario quindi cercare soluzioni software dedicate a livello di S.O., come visto prima in particolare per il disco.

## Generalità
Un altro obiettivo è quello di gestire i dispositivi in modo uniforme, nascondere la maggior parte dei dettagli dei dispositivi nelle operazioni a basso livello.

Quindi non è bene avere diverse syscall _read_ per ogni dispositivo, è meglio averne una con parametri diversi.

Dobbiamo offrire diverse operazioni: _read, write, lock, unlock, open, close_.

Ad esempio leggere da tastiera o dal mouse è molto diverso ma il S.O. deve farle sembrare cose simili.

Come otteniamo questi obiettivi?

# Progettazione Gerarchica
Ogni livello si basa su quello che fa il sottostante ed offre servizi al sovrastante. Ogni livello contiene funzionalità simili per complessità, tempi e astrazione. Inoltre modificare un livello non dovrebbe causare effetti sugli altri.

Per l'I/O ci sono 3 macrotipi di progettazioni maggiormente usate.

## Dispositivo Locale
Usato per dispositivi locali, ad esempio stampante, monitor e tastiera.

![[Pasted image 20241118123352.png|100]]

A livello più in alto abbiamo il processo utente che ha richiesto un'informazione da un dispositivo. In fondo abbiamo l'hardware che fornisce istruzioni macchina e in mezzo abbiamo cosa deve fare il S.O.

- **logical I/O**: Da un'interfaccia logica al programma, l'utente quindi può chiedere di fare queste istruzioni. Lui le trasforma e le passa a
- **Driver I/O**: Trasforma le richieste logiche in comandi I/O.
- **Scheduling and Control**: Invia le vere e proprie richieste in linguaggio macchina

## Dispositivo di Comunicazione
È praticamente identico, al posto di Logical I/O abbiamo **Communication Architecture**, questo perché possiamo avere diverse architetture di comunicazione, ad esempio TCP/IP.

## File System
Ci concentreremo di più su questo. Si usa per i dischi come SSD, HDD, CD, DVD ecc...

![[Pasted image 20241118124539.png|100]]

Anche qui partiamo da processo utente e arriviamo all'hardware.

- **Directory Management** Definisce le operazioni sui file come crearli, cancellarli ecc...
- **File System** È la struttura logica dell'operazione quindi come dobbiamo aprirli, scriverli ecc...
- **Organizzazione Fisica** Si occupa di allocare e deallocare spazio sul disco

# Tecniche Input Output

## Buffering dell'I/O
Nell'attesa del completamento di un'operazione di I/O, alcune pagine devono rimanere in memoria principale per evitare un deadlock. Infatti:

Se un processo richiede un I/O su una sua zona di memoria, ma poi questo viene sospeso e sostituito da un altro processo, la richiesta per essere completata ha bisogno del processo in memoria, ma il processo per tornare in memoria ha bisogno del completamento della richiesta. Siamo in deadlock.

Una soluzione a questo problema è il buffering, ovvero effettuare trasferimenti di input in anticipo e di output in ritardo rispetto alle richieste. E quindi non eseguirle on-demand.

_Continuare da slide "Senza Buffer" con disegno_

