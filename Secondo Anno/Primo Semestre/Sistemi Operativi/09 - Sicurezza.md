La sicurezza vuole raggiungere 3 obiettivi principali:
- Integrità
- Disponibilità
- Confidenzialità 
In realtà ce ne sono altri 2, ma possiamo vederli come secondari:
- Autenticità
- Tracciabilità

**Integrità**: Si riferisce ai dati, questi non devono essere modificati da chi non ha le autorizzazioni per farlo.

**Confidenzialità**: I dati non devono essere letti da chi non ha le autorizzazioni

**Disponibilità**: I servizi devono essere offerti senza interruzioni

**Autenticità**: Si riferisce agli utenti che devono essere chi dichiarano di essere, stessa cosa vale per i messaggi e i dati.

# Minacce
Basandoci sullo standard **RFC 2828** possiamo descrivere 4 minacce informatiche:
- Accesso non autorizzato - **Unauthorized disclosure**
- Imbroglio - **Deception**
- Interruzione - **Disruption**
- Usurpazione - **Usurpation**

## Accesso non Autorizzato
Qualcuno riesce ad ottenere accesso a dati per i quali non ha autorizzazione, è quindi una minaccia alla confidenzialità.

Attacchi che riguardano questo problema sono:
- Esposizione (intenzionale o per errore)
- Intercettazione
- Inferenza, quando effettivamente non si ha accesso a dei dati ma possiamo comunque ricavarli da altri.
- Intrusione

## Deception
Avviene quando un'entità autorizzata riceve dati falsi ma crede che siano veri, è quindi una minaccia all'integrità

Attacchi:
- Mascheramento, ovvero quando un attaccante riesce ad entrare in possesso di alcune credenziali autorizzate.
- Falsificazione, qualcuno che modifica i dati
- Ripudio, un utente nega di aver ricevuto o inviato dati

## Interruzione
Impedisce il corretto funzionamento dei servizi è quindi una minaccia alla disponibilità.

Attacchi:
- Incapacitazione, viene rotta qualche componente del sistema
- Ostruzione: Attacco DoS (Denial of Service) che riempie il sistema di richeste.
- Corruzione, alterazione dei servizi

## Usurpazione
Quando qualcuno riesce a fingersi qualcun altro, è una minaccia all'integrità del sistema

Attacchi:
- Appropriazione indebita, ovvero diventare amministratori di una macchina non nostra. Un esempio sono le macchine "zombie" delle botnet che vengono utilizzate per eseguire attacchi DoS.
- Uso non appropriato, viene installato un virus che cancella file o in generale fa danni.

# Asset
Gli asset sono le risorse che dobbiamo proteggere nel nostro sistema, possiamo considerare asset:
- Hardware
- Software
- Dati
- Linee di comunicazione e reti

> Relazione tra Asset e Obiettivi della Sicurezza

![[Pasted image 20250121131825.png]]

Cosa possiamo fare quindi, a livello di sistema operativo, a rendere la vita più difficile agli attaccanti?

# Autenticazione
Un primo step è quello di autenticare chi accede al sistema e si basa su due passi:
- Identificare chi vuole accedere
- Verificare che possa accedere

Oltre a determinare se può accedere dobbiamo verificare anche i suoi privilegi, questo rende inoltre possibile anche il **discretionary control access** che permette ad un utente di decidere a quali altri utenti concedere determinati permessi.

Come possiamo realizzare l'autenticazione? Abbiamo 3 modi:
- Qualcosa che sai (password)
- Qualcosa che hai (chiave, badge, RFID)
- Qualcosa che sei (biometrica come retina o altro)

Da notare che questi 3 fattori hanno delle problematiche, infatti [Nick Mathewson](https://en.wikipedia.org/wiki/Nick_Mathewson) notò come questi possono diventare:
- Qualcosa che hai dimenticato
- Qualcosa che avevi
- Qualcosa che eri

## Password
È quella più usata, l'unica nota importante è che non vengano memorizzate in chiaro ma criptate.

## Token
Sono oggetti fisici posseduti dall'utente, abbiamo ad esempio **memory card** e **smartcard**

### Memory Card
Possono memorizzare dati ma non elaborarli, ad esempio i bancomat tradizionali. Spesso vengono usati insieme a delle password o PIN, come svantaggio abbiamo che serve un lettore apposito e la possibilità di perdere il token.

### Smart Card
Hanno anche un microprocessore e delle porte I/O a differenza delle memory card e ne esistono di diversi tipi. Possono avere anche un vero e proprio protocollo di autenticazione dato che sono in grado di "reggere un dialogo".

## Biometrica
Inizialmente si basava soltanto su scansioni come faccia, impronta digitale, retina o altro. Ultimamente si sta sviluppando anche sulla scansione di azioni come ad esempio la scrittura a mano o riconoscimento vocale.

Quindi possiamo dividerla in autenticazione biometrica **statica e dinamica**.

- Statica: Include caratteristiche facciali, impronte, retina, iride ecc... E si basa sul riconoscimento di pattern. Questa è complessa e costosa
- Dinamica: I pattern possono cambiare e include quindi scrittura a mano, voce ecc...

![[Pasted image 20250121133323.png]]

Questo un grafico che rappresenta accuratezza e costo delle diverse tipologie di scansione biometrica.

# Controllo di Accesso
Grazie all'autenticazione è possibile il controllo dell'accesso.

Questo serve a determinare quali tipi di accesso sono ammessi e da chi, può essere:
- Discrezionale: un utente può concedere i suoi stessi privilegi ad altri utenti
- Obbligatorio: un utente non può concedere i suoi stessi privilegi ad altri (ad esempio ambienti militari)
- Basato su ruoli

Le 3 modalità possono essere presenti anche contemporaneamente, non sono quindi esclusive.

## Discrezionale

![[Pasted image 20250121152926.png]]

Questa tabella indica in modo semplice i poteri che hanno determinati soggetti su determinati oggetti.

![[Pasted image 20250121153211.png]]

Quindi ad ogni richiesta il sistema operativo controlla nella tabella, ovvero la zona chiamata _Access Matrix_, se chi l'ha mandata ha i ruoli necessari.

## Basato su Ruoli
Ogni ruolo ha un insieme di diritti e quando creiamo un utente questo viene assegnato ad uno o più ruoli che gli garantiscono i loro permessi.

Quindi a questo punto avremo bisogno di due tabelle, una per indicare i permessi per ogni ruolo e poi una come quella di prima che indica per ogni ruolo i suoi permessi.

## UNIX: Meccanismi di Protezione
In UNIX la sicurezza è basata sull'autenticazione, **User-Oriented Access Control** e i diritti sono associati dagli utenti stessi.

Ci sono anche altri meccanismi come:
- NIS
- LDAP
- Kerberos

Per ogni utente c'è un username e un UID, questo è utilizzato ogni volta che occorre dare un proprietario ad una risorsa. Ogni utente appartiene ad un gruppo ed ognuno di questi è identificato da un groupname alfanumerico ed un GID intero.

Sono presenti due file di sistema `/etc/group e /etc/passwd` che contengono informazioni su gruppi e utenti.

Va eseguito un login tramite terminale o tramite rete e richiede la coppia username e password, se queste corrispondono ad una entry nel file di sistema allora viene verificata anche la password tramite algoritmi di crittografia che non vediamo qui (in teoria dopo con approfondimenti sulle passwords).

---

Per i file invece ci sono 3 permessi: lettura, scrittura ed esecuzione, indichiamo i permessi nel modo seguente:

```
-rwx-xr-x        1 federico em 5120 Nov 7 11:03 a.out
-rw-r--r--       1 federico em 233 Nov 7 11:03 test.c
```

La prima terna indica i permessi per il proprietario del file, la seconda per il gruppo a cui lui appartiene e la terza per tutti gli altri utenti. Quindi ad esempio il primo file ha:
- Proprietario tutti i permessi
- Il gruppo soltanto esecuzione e lettura
- Tutti soltanto esecuzione

Il proprietario è lo stesso del processo che ha creato il file ma si può cambiare con `chown` e anche i diritti possono essere cambiati con `chmod`.

## SETUID e STGID
Ci sono dei casi in cui un utente deve poter modificare dei file di sistema, ad esempio se vuole modificare la sua password.

I pochi programmi che hanno bisogno di fare questo hanno il SETUID impostato, quindi nella loro terna al posto del permesso di esecuzione hanno una `s`.

```
-rwxr-xr-x 1 federico em 5120 Nov 7 11:03 a.out
-rw-r--r-- 1 root root 1715 Oct 12 2014 /etc/passwd
-r-sr-sr-x 1 root sys 21964 Apr 7 2002 /bin/passwd
```

Quindi se eseguiamo un file, il processo risulta avere proprietario me che ho lanciato il file, se però abbiamo una `s` invece di `x` per i permessi di esecuzione e quindi SETUID diventiamo, per quel momento, proprietari del file e quindi root. Quindi risultando root possiamo usare i permessi di amministratore.

Essenzialmente significa che uid o gid del processo non sono quelli di chi lo ha lanciato ma del suo proprietario.

Questo accade per comandi come `passwd` oppure può essere accordato solo da un utente amministratore con `chmod u+s nomefile e/o chmod g+s nomefile`.

Questo meccanismo va usato con cautela dato che è facile sfruttarlo per attacchi rootkit, attacchi dove dei software mascherano se stessi per ottenere l'accesso ad un sistema.