# Shell
La Shell è un interprete di comandi quindi un programma che serve ad eseguire altri comandi, ne esistono vari tipi:

- Thompson / Bourne shell: sh
- Bourne-Again shell: bash
- KornSheel: ksh

# Prompt
Una volta aperta la shell questa scrive un prompt all'utente in attesa di ricevere un comando, un prompt tipi ha la seguente struttura:

- `nomeutente@nomemacchina:~cammino$` dove `cammino` indica il path dalla directory home fino alla directory attuale.

Quindi se ad esempio ci troviamo nella home allora troveremo soltanto la tilde ~, se invece non ci troviamo nel sottoalbero radicato nella home allora troveremo il path assoluto.

# Comandi
Ogni comando viene eseguito nel seguente modo:

- `comando [opzioni] argomenti_obbligatori`

Ci deve essere almeno un argomento se questo viene indicato fra le parentesi graffe, ad esempio ci può essere fornita una scelta di argomenti tra graffe e almeno uno dobbiamo selezionarlo.

Se i parametri si trovano tra le quadre invece indicano argomenti opzionali, questi potremmo sceglierne più di uno e in questo caso vanno separati con un carattere speciale indicato dal comando come può essere la `,` o altro.

Oggi le opzioni vengono indicato con `-carattere`oppure `--parola` seguito dal nome dell'opzione, ad esempio:

- `-i / --interactive`
- `-r / --recursive`

Queste opzioni possono anche avere degli argomenti, ad esempio:

- `-k1`   `-k 1`   `--key=1` (tutte lo stesso significato)

Le opzioni che non hanno argomento sono raggruppabili, quindi se ad esempio abbiamo 3 opzioni `-b -r -c` possiamo scrivere:

- `-brc`

Esistono anche delle opzioni **BSD-style** che si scrivono senza trattino:

- `tar xfz nomefile.tgz`

# Gli Utenti
Durante un'installazione di Linux sarà necessario specificare almeno un utente anche se alcune versione ne creano uno di default.

Non tutti gli utenti sul sistema possono eseguire il login, ad esempio l'utente **root** che è l'utente con poteri di amministratore non può farlo ma un altro utente può acquisire i poteri di root mediante il comando **su** o **sudo**.

Gli utenti inoltre sono organizzati in gruppi, ogni utente fa parte almeno di un gruppo, questi permettono di gestire in modo più semplice i vari permessi.

## Sudo
Gli utenti che possono eseguire questo comando fanno parte del gruppo dei **sudoer** questi possono eseguire comandi da super utente (root) usando il comando `sudo comando`.

Oppure se sappiamo di dover eseguire vari comandi in modalità root possiamo usare `su` per passare all'utente root ed eseguire i comandi.

La differenza è quindi che `sudo` prende come input un comando e garantisce dei permessi aggiuntivi all'utente che deve eseguire quel comando, una volta fatto l'utente torna con i suoi normali privilegi. Con `su` invece cambiamo utente infatti si apre una nuova shell in modalità root. 

## Creazione di Utenti
Per creare utenti usiamo il comando

- `adduser nuovoutente`

Di base questo non farà parte del gruppo sudo, possiamo aggiungere l'utente al gruppo sudoer con il comando

- `adduser nuovoutente gruppo`

Se invece vogliamo cambiare utente utilizziamo:

- `su [- | -l | --login] nomeutente`

Che tipicamente viene utilizzato per diventare root con, ad esempio: `su -l root`

