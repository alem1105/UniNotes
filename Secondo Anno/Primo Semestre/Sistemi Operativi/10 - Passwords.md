# Passwords in Linux
Linux usa due file per gestire le passwords degli utenti:
- `/etc/passwd`
- `/etc/shadow`

Sono entrambi dei file di testo, originariamente esisteva soltanto il file `passwd` che conteneva anche la password di ogni utente scritta in chiaro. Per ovvi motivi è stato cambiato il metodo.

Adesso per ogni entry nel file `passwd`, ovvero per ogni utente, esiste una entry nel file `shadow` che indica la sua password ma non scritta in chiaro.

## File passwd
Questo file scritto in chiaro contiene l'intera lista di utenti presenti nel sistema, include anche gli account "speciali" di sistema come ad esempio l'utente `nobody` che serve a dare il minimo numero di permessi disponibili ad un processo.

Di default ha i seguenti permessi:

```
-rw-r--r-- 1 root root 2659 Dec 22 12:21 /etc/passwd
```

---

Ciascuna riga del file indica informazioni su un utente del sistema ed ha il seguente formato:

![[Pasted image 20250121170948.png]]

1) Username: nome dell'utente per il login, è una stringa da 32 caratteri
2) Password: oggi è inutilizzato, infatti la `x` indica che l'hash della password si trova nel file `shadow`
3) User ID (uid): ogni utente nel sistema ha uno user id numerico assegnato, alcuni di questi hanno significati speciali ad esempio lo 0 indica l'utente root, 1-999 sono riservati per account di sistema.
4) Group ID (gid): una volta creato ogni utente viene assegnato ad gruppo primario, questo gruppo viene assegnato ai file creati da quell'utente. La descrizione di ogni gruppo si trova in `/etc/group`
5) GECOS: Campo descrittivo che contiene informazioni generali sull'utente
6) Home directory: Path assoluto della home directory dell'utente
7) Shell: path assoluto alla command shell usata dall'utente

Le ultime due servono appunto a reindirizzare ad esempio un terminale dopo aver effettuato il login.

## File Shadow
È un file scritto in chiaro dove sono presenti, per ciascun utente del sistema, l'hash della sua password e altre informazioni:
- Data l'importanza delle informazioni presenti, decifrare questo file è uno degli obiettivi principali di un attaccante e per questo ha dei permessi più restrittivi del file `passwd`

Di default:

```
-rw-r----- 1 root root 2659 Dec 22 12:21 /etc/shadow
```

---

Le righe hanno questa struttura:

![[Pasted image 20250121172352.png]]

1) Username dell'utente a cui appartiene la password
2) Password dell'utente salvata usando il **Modular Crypt Format**
3) Last Changed: Data dell'ultimo cambiamento della password espresso in giorni trascorsi da [**Unix Epoch**](https://it.wikipedia.org/wiki/Tempo_(Unix)) (01/01/1970)
4) Min Age: minimo numero di giorni dall'ultimo cambio prima che la password possa essere nuovamente cambiata
5) Max Age: Massimo numero di giorni dopo il quale è necessario cambiare la password
6) Warn: Quanti giorni prima della scadenza della password va avvisato l'utente

## Modular Crypt Format
È il formato usato nello shadow file per salvare gli hash delle password:

$$
\text{\$ID\$salt\$hash}
$$

- ID: Algoritmo di hashing usato per questa password (MD5, blowfish, SHA256)
- salt: salt usato nel processo di hashing
- hash: hash della password calcolato con l'algoritmo ID e salt

### Hash Functions
Trasforma un input di lunghezza variabile in un output di lunghezza fissa in maniera deterministica. Quindi la stessa stringa in input darà la stessa stringa in output.

Una funzione hash è detta crittografica se:
- È computazionalmente difficile calcolare l'inverso della funzione hash
- È computazionalmente difficile dato un input `x` ed il suo hash `d` trovare un altro input `x1` che abbia lo stesso hash `d`
- È computazionalmente difficile trovare due input diversi di lunghezza arbitraria `x1 e x2` che abbiano lo stesso hash `d`

> [!info] Salt nella funzione di hash
> Usare il salt significa aggiungere un testo alla nostra password, infatti se per esempio usiamo la funzione su due password uguali otteniamo lo stesso hash.
> 
> Se però ad entrambe aggiungiamo dei caratteri casuali allora sia le due password che i loro hash saranno diversi

Si usa l'hash al posto della cifratura perché se un attaccante entra in possesso della chiave di cifratura allora ottiene anche tutte le password. Le funzioni hash invece non permettono di tornare indietro una volta eseguite su una password quindi se l'attaccante ottiene la password in hash non può scoprire che password l'ha generato (tranne casi particolari).

# Attacchi a Password
Le hash sono comunque attaccabili, ad esempio:
- Attacco Dizionario
- Attacco Rainbow Table

## Attacco Dizionario
Ci sono un numero infinito di password che possono risultare nello stesso hash code, come facciamo a scoprire quella giusta? Fortunatamente per gli attaccanti gli utenti sono pigri e quindi:
- Usano password corte per ricordarle meglio
- Usano una sola password in più servizi

L'attacco dizionario si basa quindi sul fatto che molti utenti usano la stessa password ed è possibile quindi compilare una lista di password molto utilizzate e fare **bruteforce**.

Quindi dato una hash `d` che voglio invertire:
1) Per ogni `x` nella mia lista di password calcolo il suo hash.
2) Ripeto finché l'hash che ottengo non è uguale a quello che voglio invertire

Esistono anche oggi diversi dizionari di password [rockyou.txt](https://www.kaggle.com/datasets/wjburns/common-password-list-rockyoutxt)

Questo attacco è quindi molto semplice da effettuare e anche da automatizzare con diversi tool, ma allo stesso tempo la password potrebbe non essere nel dizionario o comunque potrebbe volerci molto tempo.

## Attacco Rainbow Table
Dato che le funzioni di hash sono deterministiche l'hash di una password presente in un dizionario sarà sempre lo stesso, quindi perché computarlo durante l'attacco, possiamo farlo prima.

La rainbow table è quindi un dizionario di coppie composte da password e valore hash, questo viene usato per trovare velocemente quale password corrisponde ad un hash.

Migliora quindi l'attacco dizionario ma è ancora più rigido dato che il valore hash presente è valido per un solo algoritmo.

Per salvarci da questi attacchi viene usato il `salt` visto prima, quindi aggiungere caratteri casuali in ogni password. Questo non rende comunque immuni dagli attacchi bruteforce.

# Sviluppi Futuri
Creare grandi dizionari di password non è semplice e anche sfruttarli al massimo non è facile. Però data una password comune spesso gli utenti fanno piccole modifiche ad esempio `password` diventa `Password1` oppure `passw0rd`.

I tool usati per fare bruteforcing applicano in automatico delle regole per creare delle varianti per ciascuna password e generalmente si usano regole generali che si applicano a tanti utenti, infatti è difficile trovare regole specifiche per gruppi di utenti.

Si può usare machine learning per imparare a generare password realistiche, infatti ML e Deep Learning sono ideali per imparare a riconoscere pattern