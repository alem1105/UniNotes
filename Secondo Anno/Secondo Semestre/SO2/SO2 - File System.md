È un modo di organizzare la memoria, si basa su **file e directory**, le directory possono contenere sia file che altre directory, entrambi si basano sugli **INODE** che vedremo più avanti o [[06 - Il File System#Inode]].

Le directory hanno una struttura gerarchica ad albero, i file invece sono delle sequenze di bit e sono ASCII o binari, dobbiamo quindi conoscere come sono organizzati questi bit per poterli leggere. Esistono anche file speciali o non regolari come ad esempio **i link**.

---

Linux ha un solo filesystem principale e la radice delle directory è `/` che si chiama **root**.

All'interno di una directory troviamo dei file speciali che vediamo indicati come:

- `.`: Indica la cartella corrente
- `..`: Indica la cartella precedente

Se ad esempio ci troviamo nella root allora entrambi indicheranno la root.

---

Ogni file o directory è raggiungibile dalla directory principale root mediante:
- **path assoluto**: Inizia dalla root ed è una sequenza di cartelle separate da `/`.

Di solito il percorso fino alla cartella utente viene sostituito da ~, quindi ad esempio:

- `/home/utente1/dir1/dir2/file.pdf`

Lo troveremo scritto come:

- `~/dir1/dir2/file.pdf`

> [!info] Conoscere la directory corrente (cwd)
> Per conoscere in che directory ci troviamo (cwd) possiamo usare il comando `pwd`. Per cambiare la cwd possiamo usare il comando `cd [path]` dove path può anche essere un percorso relativo. Nel path possiamo usare ad esempio `..` per tornare nella directory precedente.
> 
> Se non inseriamo un percorso torniamo alla directory home dell'utente loggato.

---

Per creare una directory usiamo il comando `mkdir` seguito dal percorso della directory:

- `mkdir [OPTION] DIRECTORY`

Se vogliamo creare un intero path e creare anche le cartelle che mancano usiamo l'opzione `-p`

Per creare i file invece possiamo usare `touch nomefile`, il vero utilizzo del comando touch è quello di modificare gli attributi temporali del file come data creazione, ultimo accesso in lettura ecc... però il comando se viene eseguito su un file che non esiste lo crea.

---

> [!info] Path relativo vs assoluto
> Un path assoluto inizia dalla root directory mentre quello relativo dalla cwd, current working directory.
> 
> Un path assoluto quindi è valido qualunque sia la cwd, mentre uno relativo se cambiamo cwd potrebbe non essere più valido.
> 

---

In una directory troviamo anche dei file nascosti come ad esempio:

- `.bash_history`: Contiene i precedenti comandi usati nella shell
- `.bashrc`: Contiene la configurazione della shell

Usiamo `ls -a / --all` per visualizzare anche i file nascosti

Se vogliamo visualizzare ad albero tutte le directory ed i file che contengono possiamo usare l'opzione `-R` per il comando `ls` oppure installare una utility esterna chiamata `Tree`.



