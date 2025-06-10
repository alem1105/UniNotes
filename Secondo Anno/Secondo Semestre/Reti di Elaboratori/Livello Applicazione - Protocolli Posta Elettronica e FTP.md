# FTP
Viene usato per trasferire file da / a un host remoto, va effettuata la connessione tramite il comando:
- `ftp NomeHost` e vengono richiesti nome utente e password
- `ftp > get file1.txt` per trasferire un file da un host remoto
- `ftp > put file2.txt` per trasferire un file verso l'host remoto

Anche FTP usa il modello client / server dove il server è la macchina che mantiene i dati e il client quello che richiede o invia.

Quando il client richiede una connessione il server verifica le credenziali e stabilisce una connessione sulla porta 21.

In realtà vengono stabilite due connessioni:
- **Connessione di controllo**: Si occupa delle informazioni di controllo del trasferimento e usa regole semplici. È quella utilizzata per scambiare i comandi come ad esempio il cambio di directory.
- **Connessione dati**: Si occupa del trasferimento dei file vero e proprio, questa viene aperta sulla porta 20 e viene chiusa alla fine di ogni trasferimento.

Possiamo quindi dire che la connessione di controllo è persistente mentre la connessione dati no.

## Comandi e Risposte FTP
Ogni comando eseguito corrisponde ad una risposta da parte del server, le risposte sono molto simili a quelle già viste in HTTP.

Alcuni comandi comuni:
- `USER username`
- `PASS password`
- `LIST`: elenca i file nella directory corrente, questa viene inviata in una nuova connessione dati.
- `RETR filename` recupera un file dalla directory corrente
- `STOR filename` memorizza un file nell'host remoto

Alcuni codici di ritorno delle risposte:
- `331 username OK, password required`
- `125 data connection already open; transfer starting`
- `425 Can´t open data connection`
- `452 Error writing file`

Notiamo che qui le risposte sono composte da un codice e una parte testuale supplementare per informazioni aggiuntive

_Esempio_

![[Pasted image 20250318211203.png]]

# Posta Elettronica
Vediamo i principali componenti utilizzati per la comunicazione mail:

![[Pasted image 20250319111249.png]]

- User Agent: Utilizzato per scrivere, leggere e inviare messaggi
- Message Transfer Agent: Usato per trasferire il messaggio attraverso Internet
- Message Access Agent: Usato per leggere la mail in arrivo

## User Agent
Questo viene attivato da un timer o dall'utente e informa quest'ultimo di nuove mail in arrivo. Serve appunto a leggere, scrivere e inviare messaggi. Un Programma che possiamo prendere come esempio è Thunderbird o Outlook.

In messaggi in uscita o in arrivo vengono memorizzati sul server e quelli da inviare passano per il Mail Transfer Agent, ma come comunicano con questo?

Tramite i **server di posta** che hanno una mailbox contenente tutti i messaggi in arrivo per gli utenti e la **coda di messaggi** da trasmettere, questi provano a venire inviati ogni $x$ minuti.

Sia per inviare messaggi tra i server che tra User Agent mittente e destinatario si usa il protocollo **SMTP** (Simple Mail Transfer Protocol).

## SMTP
Questo protocollo utilizza una connessione TCP dal client al server sulla porta 25 per trasferire i messaggi. Il trasferimento è diviso in 3 fasi:
- Handshaking: Quando i due server devono "riconoscersi"
- Trasferimento di Messaggi
- Chiusura

Vediamo un esempio di trasmissione tra due persone, Alice e Roberto.
1) Alice usa il suo agente per comporre il messaggio da inviare alla mail di Roberto
2) L'agente di Alice invia il messaggio al server di posta di Alice, questo viene inserito nella coda dei messaggi
3) Il lato client SMTP apre una connessione TCP con il server di posta di Roberto
4) Il client SMTP invia il messaggio di Alice sulla connessione TCP
5) Il server di posta di Roberto riceve il messaggio e lo pone nella casella di posta di Roberto
6) Roberto invoca il suo agente utente per leggere il messaggio

![[Pasted image 20250319132436.png]]

Dal client mittente fino al server del destinatario si usa il protocollo SMTP poi il destinatario per scaricare la mail sul suo client può usare IMAP o POP.

### Scambio di messaggi nel dettaglio
1) Il client SMTP (server posta in invio) fa stabilire una connessione sulla porta 25 verso il server SMTP ricevente
2) Client e Server effettuano handshaking ovvero il client indica indirizzo email di mittente e destinatario
3) Il client invia il messaggio
4) Il messaggio arriva al server destinatario
5) Se ci sono altri messaggi si usa la stessa connessione, questa infatti è persistente, altrimenti si chiude.

_Esempio di Interazione SMTP_

![[Pasted image 20250319161814.png]]

## Formato dei Messaggi di Posta Elettronica
Abbiamo due componenti principali:
- Intestazione, composta da:
	- To: Indirizzo/i destinatari
	- From: Indirizzo del mittente
	- Cc: Indirizzo di uno o più destinatari a cui si invia per conoscenza
	- Bcc: È come Cc ma i veri destinatari non sanno che anche questi in Bcc hanno ricevuto il messaggio
	- Subject: Argomento del messaggio
	- Sender: Chi materialmente effettua l'invio, ad esempio il dipendente dell'azienda.
- Corpo: il messaggio vero e proprio composto soltanto da caratteri ASCII

### Protocollo MIME
Come facciamo a inviare messaggi in formati non ASCII? Convertendo i dati prima di inviarli.

Per fare questo si usano intestazioni aggiuntive, il MIME è un protocollo che aggiunge delle estensioni di messaggi di posta.

![[Pasted image 20250319162809.png]]

# Protocolli di Accesso alla Posta
Il client dell'utente finale può usare diversi protocolli per accedere al server della posta, infatti SMTP viene usato per trasferire i messaggi fra i server ma non può essere usato dall'utente, questo infatti ha bisogno di eseguire azioni di **pull** mentre SMTP svolge soltanto **push**.

Possiamo usare diversi protocolli:
- POP3 (Post Office Protocol - v.3): Autorizzazione e download
- IMAP (Internet Mail Access Protocol): Permette più funzioni e manipolazione di messaggi sul server
- HTTP: Servizi come gmail, hotmail ecc...

## POP3
Questo permette al client di aprire una connessione TCP verso il server di posta sulla porta 110, poi si procede in 3 fasi:
1) Autorizzazione: L'agente utente si identifica
2) Transazione: L'agente utente recupera i messaggi
3) Aggiornamento: Dopo che il client ha finito e chiusa la connessione vengono cancellati i messaggi marcati per la rimozione

Comandi utilizzabili con POP3, possiamo distinguerli in due fasi della comunicazione:
- Fase di Autorizzazione
	- `user` dichiara il nome dell'utente
	- `pass` password
	- Il server può rispondere con `+OK` o `-ERR`
- Fase di Transazione
	- `list` elenca i numeri dei messaggi
	- `retr` ottiene i messaggi in base al numero
	- `dele` cancella
	- `quit`

_Esempio_

![[Pasted image 20250319165519.png|300]]

Con il POP3 quindi, usando la modalità "scarica e cancella" non possiamo rileggere le mail se cambiamo client, queste infatti non saranno più disponibili sul server.

L'utente infatti non può nemmeno creare cartelle o altro sul server, va tutto creato in locale sul proprio computer.

## IMAP
Con IMAP la situazione cambia, infatti queste consente ad esempio di creare cartelle anche sul server e di organizzare quindi i messaggi.

IMAP a differenza di POP mantiene lo stato delle sessioni dell'utente.

Il protocollo per fare questo associa a una cartella ogni messaggio arrivato dal server e poi fornisce agli utenti dei comandi per:
- Creare cartelle e spostare messaggi da una cartella all'altra
- Effettuare ricerche nelle cartelle del server
Mantengono informazioni su:
- Nomi cartelle
- Associazioni messaggi - cartelle

Inoltre vengono forniti comandi per ottenere le componenti dei messaggi:
- Intestazione
- Corpo del messaggio

## HTTP
Alcuni mail server consentono l'accesso tramite web ovvero tramite HTTP, in questo caso l'agente utente diventa il browser e comunica con il suo mailbox tramite HTTP e anche il ricevente usa HTTP per accedere alla mailbox.
