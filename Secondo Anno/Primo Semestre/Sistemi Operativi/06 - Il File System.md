# Visione d'Insieme

## I File
I file sono l'elemento principale per la maggior parte delle applicazioni, molto spesso l'input di un'applicazione è un file o anche l'output.

I file a differenza della RAM "sopravvivono" ad un processo.

Il file system è quindi una parte del SO che più interessa all'utente e delle proprietà che deve gestire il SO sono:
- Esistenza a lungo termine dei file
- Diversi processi utilizzano gli stessi file
- Strutturabilità ovvero un sistema di organizzazione per aiutare l'utente a trovare i file

## Gestione dei File
I file vengono gestiti da un insieme di programmi e librerie del kernel e questi vengono chiamati **File Management System** e sono eseguiti a livello kernel.

Le librerie vengono invocate come system call sempre in kernel mode.

Questi hanno a che fare con la memoria secondaria e in Linux anche con la RAM, possiamo gestirla come fosse un file.

Forniscono astrazione attraverso delle operazioni.

Per ogni file vengono mantenuti dei metadati come il proprietario, la dimensione, la creazione ecc...

## Operazioni sui File
- Creazione
- Cancellazione
- Apertura
- Lettura, solo su file aperti
- Scrittura, solo su file aperti
- Chiusura

> [!NOTE] Terminologia
> - Campo (field)
> - Record
> - File
> - Databse

## Campi e Record
I **campi** sono i dati di base e contengono valori singoli, sono caratterizzati da una lunghezza e un tipo di dato, un esempio di campo é un carattere ASCII.

Un insieme di Campi è un **record**, ad esempio Impiegato è caratterizzato da _nome, cognome, matricola, stipendio_.

## File e Database
I file sono visti come **insieme di record**, questi hanno un nome e possono implementare meccanismi di controllo dell'accesso, decidere quindi chi può accedere a cosa. Nei moderni SO ogni record è un solo campo con un byte.

I database sono collezioni di file, esistono dei DBMS che sono dei processi che gestiscono database.

## Sistemi per la gestione dei File

![[Pasted image 20241209182306.png]]

Adesso ci occuperemo di _Directory Management, File System, Physical Organization_.

I File Management Systems sollevano i programmatori dal dover scrivere codice per gestire i file e forniscono servizi agli utente per l'uso di file.

**Obiettivi per un File Management System**:
- Rispondere alla necessità degli utenti riguardo alla gestione dei dati
- Garantire che i dati non si corrompano
- Ottimizzare le prestazioni
- Fornire supporto per diversi tipi di memoria secondaria come USB, CD, DVD...
- Minimizzare i dati persi o distrutti
- Fornire interfacce standard per processi utente
- Fornire supporto per I/O effettuato da più utenti in contemporanea

**Requisiti per i File Management System**:
- Ogni utente deve essere in grado di creare, cancellare e modificare un file
- Ogni utente deve poter accedere in modo controllato ai file di un altro utente
- Ogni utente deve poter leggere e modificare i permessi di accesso ai propri file
- Ogni utente deve poter ristrutturare i propri file in modo attinente al problema affrontato (nei moderni SO hanno rimosso l'organizzazione in campi record ecc... e i file sono soltanto una sequenza di byte, e sta a chi progetta l'applicazione decidere come interpretare i byte)
- Ogni utente deve poter muovere i dati da un file ad un altro
- Ogni utente deve poter mantenere una copia di backup dei propri file
- Ogni utente deve poter accedere ai propri file tramite nomi simbolici (scelti da lui)

_Continuare primo video File System_