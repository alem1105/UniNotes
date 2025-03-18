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

