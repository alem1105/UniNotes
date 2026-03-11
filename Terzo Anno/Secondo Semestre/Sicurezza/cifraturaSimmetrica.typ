#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= Cifratura Simmetrica
È conosciuta come il metodo convenzionale di cifratura, ha *5 componenti* principali:
- *Plaintext*: Il testo in chiaro da dare all'algoritmo.
- *Encryption Algorithm*: Algoritmo che effettua _sostituzioni e traformazioni_ al plaintext.
- *Secret Key*: Anche questa viene data in input all'algoritmo e da questa dipendono tutte le trasformazioni effettuate nell'algoritmo.
- *Ciphertext*: Il testo di output dell'algoritmo, per ogni testo se utilizziamo chiavi diverse dobbiamo ottenere risultati diversi.
- *Dectryption Algorithm*: L'algoritmo di cifratura inverso, dato il ciphertext e la chiave deve fornire in output il plaintext.

== Cryptographics Systems
Sono meccanismi che utilizzano algoritmi, chiavi e protocolli per proteggere la *confidenzialità, l'integrità, l'autenticazione* e la *non ripudiabilità*.

Vengono classificati su 3 _dimensioni_
- Tipo di operazioni utilizzate per cifrare il plaintext
  - *Sostituzione*: Prende un insieme di byte e li rimpiazza con altri byte.
  - *Trasposizione*: I byte del testo vengono mischiati fra di loro.
  Queste sono indipendenti dalla chiave e vengono ripetute un certo numero di volte (_round_) sul testo.
  Nell'effettuare queste operazioni non dobbiamo *perdere informazione*, questo significa che le operazioni devono essere invertibili.

- Tipo di chiave utilizzata:
  - *Simmetrica* o *asimmetrica*

- Modo in cui viene trattato il testo in chiaro:
  - *Block*: Viene processato un blocco alla volta. Quindi da un blocco in input otteniamo un blocco in output.
  - *Stream*: L'input viene continuamente processato, ogni elemento produce un elemento in output.

=== Block Cipher
I meccanismi di cifratura simmetrici a blocchi consistono in una *serie di round* composti da *sostituzioni e permutazioni* basati su una chiave.

Una delle strutture più famose è la *Feistel Cipher Structure* utilizzata anche nell'algoritmo DES.

In questa struttura dobbiamo tenere a mente che:
- È divisa in round e ogni round effettua le stesse operazioni.
- Si parte con una chiave ma poi a partire da questa vengono generate più chiavi, nello specifico una diversa per ogni round.

A ogni round il testo viene diviso in due parti uguali, la funzione _F_ prende in input la parte destra ed effettua delle sostituzioni, l'output della funzione viene poi messo in _XOR_ con la parte sinistra del testo. A questo punto viene effettuata una sostituzione tra le due parti ovvero mettiamo quella sinistra a destra e quella di destra a sinistra, in questo modo il round successivo effettua le stesse operazioni perché si troverà a destra la parte non cifrata e a sinistra quella cifrata.

#align(center, image("/assets/image-28.png", width: 50%))

Per progettare una struttura di cifrario a blocchi dobbiamo considerare diversi parametri:
- *Block Size*: Se il blocco è grande ho più sicurezza ma meno velocità nelle operazioni, un tradeoff ottimale è 128-bit.
- *Key Size*: Più è grande e più è alta la sicurezza ma riduciamo la velocità delle operazioni. Un tradeoff ottimale è 128 - 256-bits.
- *Numero di round*: Aumenta la sicurezza ad aumentare il numero di round. Anche qui dobbiamo trovare un giusto tradeoff che è 16 round.
- Algoritmo di *generazione delle sottochiavi*: Più è complesso, più è difficile fare *cryptanalysis* 
- *Funzione* utilizzata nei *round*: Stesso ragionamento dell'algoritmo di generazione delle sottochiavi.
- *Velocità dell'algoritmo* di cifratura e decifratura.
- L'algoritmo deve essere *facile da analizzare*: Serve ad individuare meglio le vulnerabilità però le componenti dell'algoritmo devono essere tali che anche se conosciute da chi fa cryptanalysis sia impossibile invertire le operazioni senza la chiave.

#showybox(
  frame: (
    border-color: green.lighten(60%),
    title-color: green.lighten(60%),
    body-color: green.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Cryptanalysis*],
  [
    Processo utilizzato per cercare di scoprire il testo in chiaro o la chiave, sfruttando soltanto la conoscenza dell'algoritmo di cifratura, conoscendo quest'ultimo ed i suoi punti deboli si cerca di risalire al testo in chiaro.
  ]
)

==== DES - Data Encryption Standard
Il DES era un algoritmo complesso da analizzare.

Il *processo di cifratura* era composto da:
- Block cipher con blocchi da 64-bits e chiave da 56-bits.
- Utilizzava una variante della struttura Feistel a 16 rounds.
- Dalla chiave a 56 bit venivano generate 16 sottochiavi

Il *processo di decifratura* era semplicemente l'inverso della cifratura, questo ha in input il ciphertext e poi utilizza in ordine inverso rispetto alla cifratura le sottochiavi generate dalla chiave.

Per i moderni processori di oggi la chiave a 56-bits è considerata obsoleta e si è passati al 3DES.

==== 3DES
- Si estende la chiave fino a 168-bits che veniva suddivisa in 3 chiavi da 56-bits
- Si cifra con le tre chiavi in modo sequenziale, ovvero applicare il DES 3 volte.
- Per decifrare si fa l'opposto.

Nello specifico definiamo come:
- _E_ funzione di cifratura
- _D_ funzione di decifratura

Per effettuare una cifratura con 3DES si applica:
- $C = E(K_3, D(K_2, E(K_1, P)))$
Mentre per la decifratura:
- $P = D(K_1, E(K_2, D(K_3, C)))$

_Graficamente_:

#align(center, image("/assets/image-29.png", width: 50%))

Utilizzare la funzione di decifratura come secondo step in 3DES non offre vantaggi in termini di crittografia ma permette la retrocompatibilità con il DES classico, o meglio permette a chi usa 3DES di decriptare anche messaggi cifrati con DES.

Per migliore sicurezza si è passati poi all'AES.

==== AES - Advanced Encryption Standard
AES utilizza blocchi da 128-bits e chiavi da 128, 192 o 256-bits, negli esempi più avanti la assumiamo da 128.
È strutturato in questo modo:

Vuole come input un blocco da 128-bit, questo blocco viene rappresentato come una matrice di byte. Durante l'esecuzione dell'algoritmo, questo blocco viene copiato nello *State array* che viene modificato ad ogni stage di cifratura o decifratura. Dopo l'ultimo stage l'array viene copiato in una matrice di output.
Anche la chiave viene rappresentata in una matrice di bytes, questa chiave viene estesa in un array di words, ogni words è composta da 4 bytes e l'array in totale contiene 44 words, ovviamente aumentando i bit della chiave aumentiamo anche le words nell'array.

L'ordine usato nelle matrici è per colonne, quindi ad esempio i primi 4 bytes del plaintext occuperanno la prima colonna della matrice:
#align(center, image("/assets/image-21.png", width: 50%))

In questo algoritmo i round:
- Non seguono architettura Feistel.
- La chiave iniziale viene estesa in un array di 44 words da 32bit, 4 words (128 bit) costituiscono una chiave utilizzabile in un round.
- Vengono utilizzati 4 diversi stage, 1 di permutazione e 3 sostituzioni:
  - *Substitute bytes*: Utilizza delle tabelle per fare sostitutizioni byte-a-byte.
  - *Shift Rows*: Permutazione effettuata sulle righe.
  - *Mix Columns*: Sostituzione che altera ogni byte in una colonna andandoli a smistare sulle restanti colonne.
  - *Add Round Key*: Un semplice _XOR_ del blocco corrente con la chiave del round corrente.

#align(center, image("/assets/image-30.png", width: 50%))

La struttura è relativamente semplice sia per la cifratura che la decifratura.
La cifratura inizia con una _Add Round Key_ seguita da 9 round contenenti tutti gli stage visti sopra, seguiti infine da un round di tre stage.

Nella figura sono rappresentati tutti gli stage di un round:

#align(center, image("/assets/image-31.png", width: 80%))
- Solo lo stage _Add Round Key_ utilizza la chiave e per questo viene svolto all'inizio e alla fine della cifratura, tutti gli altri stage applicati all'inizio o alla fine sono invertibili senza conoscenza della chiave e non aggiungerebbero sicurezza.
- Anche gli altri sono utili però perchè servono a creare confusione nei dati, ma come detto prima da soli non bastano perchè non utilizano la chiave.
- L'algoritmo di decifratura utilizza le funzioni inverse degli stage e per la chiave basta fare lo _XOR_ come per la cifratura, inoltre va anche utilizzata la chiave estesa ma in ordine inverso.
- Dato che tutti gli stage sono invertibili, noteremo che allo stesso _livello verticale_ nello _state array_ avremo sempre lo stesso array.

Vediamo adesso i principali passaggi:
#align(center, image("/assets/image-22.png", width: 80%))

1. Effettuiamo una *Substitute Bytes*, una sostituzione byte a byte del blocco attraverso una tabella. Ovviamente esiste anche la matrice per la decifratura e queste due devono essere progettate in modo che ci sia poca correlazione fra byte in input e di output. Inoltre non deve essere possibile definire una relazione matematica per capire l'output dall'input.

La tabella è nella forma:
#align(center, image("/assets/image-23.png", width: 80%))

I primi 4 bit vengono usati per la coordinata _x_ mentre gli ultimi 4 per la _y_. Ad esempio il byte con rappresentazione esadeciamale _95_ viene tradotto in _2A_ ovvero il byte presente alla riga 9, colonna 5.

A questo punto salviamo il risultato nello state array e passiamo all'operazione successiva:

#align(center, image("/assets/image-24.png", width: 80%))

2. Effettuiamo uno *Shift Rows*, nello specifico:
- La prima riga non viene modificata.
- La seconda viene spostata di un byte a sinistra.
- La terza di 2 byte a sinistra.
- La quarta di 3 byte a sinistra.
Gli shift sono circolari quindi chi arriva al limite sinistro "sbuca" all'estremità destra.
Questa trasformazioni si assicura che i 4 byte di una colonna vengano smistati in 4 colonne diverse.

Una volta finito salviamo il risultato nello state array.

3. A questo punto, possiamo passare alla *Mix Column*:

#align(center, image("/assets/image-25.png", width: 80%))

In questa operazione prendiamo in input i 4 byte di una colonna e otteniamo in output i nuovi 4 byte, non ci deve essere perdita di informazione, questo significa che l'*output dipende dall'input*.

4. Come ultima operazione facciamo l'*Add Round Key*:

#align(center, image("/assets/image-26.png", width: 80%))

Per quanto riguarda l'algoritmo di espansione della chiave:
- Ha come input la chiave composta da 4 words, ovvero 16bytes (128-bits).
- Restituisce come output un vettore da 44 words ovvero 156bytes, questo è sufficiente per garantire il numero di chiavi necessario per tutti i round.

Queste bastano per tutto l'algoritmo dato che le prime 4 word vengono usate per il primo _Add Round Key_ e le restanti 40 nei successivi 10 round.
Ovviamente all'aumentare della lunghezza della chiave aumentano anche i round.

Gli steps sono:
1. Viene copiata la chiave nelle prime 4 words dell'array esteso.
2. Il resto viene riempito con 4 words alla volta dove la word `word[i]` dipende da `w[i-1]` e `w[i-4]`.
Esistono diversi complessi algoritmi _finite-field_ per generare questa chiave estesa.

Nello specifico otteniamo:

#align(center, image("/assets/image-27.png", width: 70%))

=== Stream Ciphers
La cifratura a flusso va a cifrare i byte continuamente, dobbiamo generare sequenze di chiavi che cambiano continuamente, non possiamo cifrare ogni byte con la stessa chiave.

Data una chiave, viene generata sempre la stessa sequenza di chiavi per i successivi byte.

#showybox(
  frame: (
    border-color: green.lighten(60%),
    title-color: green.lighten(60%),
    body-color: green.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Seed*],
  [
    Viene utilizzato lo stesso concetto dei seed per i generatori di numeri, con un generatore se utilizziamo lo stesso seed otteniamo in output la stessa sequenza di numeri.
  ]
)

==== RC4
È un algoritmo estremamente semplice, utilizza una chiave di lunghezza variabile da 1 a 256bytes (da 8 a 2048bits) che viene usata per inizializzare lo *state array* _S_ di 256-byte.
In ogni momento dell'algoritmo avremo che _S_ contiene una permutazione di tutti i numeri a 8 bit ovvero di tutti i numeri da 0 a 255.
Per la cifratura e decifratura, un byte _k_ viene generato da _S_ selezionando una delle 255 entries, ad ogni valore _k_ selezionato viene effettuata una nuova permutazione dei valori di _S_.

Si compone di diverse fasi
- *Inizializzazione*: Viene inizializzato un array _S_ con tutti i valori da 0 a 255 in modo che `S[0] = 0, S[1] = 1, ..., S[255] = 255`.
Viene anche inizializzato anche un vettore _T_, se la lunghezza della chiave _K_ è 256bytes allora _K_ viene trasferita su _T_, altrimenti per una chiave di lunghezza _keylen_ bytes, i primi _keyleb_ bytes di _K_ vengono copiati in _T_ e poi _K_ viene ripetuta tante volte quanto necessario per riempire _T_. Possiamo riassumere questa operazione con il seguente pseudocodice:
```
for i = 0 to 255 do
S[i] = i;
T[i] = K[i mod keylen]
```

#align(center, image("/assets/image-32.png", width: 80%))

Viene poi effettuata la *prima permutazione*:
Per fare questa utilizziamo _T_, scorriamo tutto _S_ e per ogni `S[i]` lo swappiamo con un altro byte in _S_ basandoci sullo schema fornito da `T[i]`. Nello specifico:

```
j = 0;
for i = 0 to 255 do
  j = (j + S[i] + T[i]) mod 256;
  Swap (S[i], S[j]);
```

#align(center, image("/assets/image-33.png", width: 80%))

Iniziamo la *generazione delle chiavi*:
A questo punto la chiave non è più necessaria e la generazione avviene ciclando su _S_ e per ogni elemento `S[i]` lo swappiamo con un altro elemento di _S_ basandoci sulla corrente configurazione di _S_. Se raggiungiamo l'elemento in posizione 255 torniamo a 0. Possiamo usare il seguente pseudocodice:
```
i, j = 0;
while (true)
  i = (i + 1) mod 256;
  j = (j + S[i]) mod 256;
  Swap (S[i], S[j]);
  t = (S[i] + S[j]) mod 256;
  k = S[t];
```

#align(center, image("/assets/image-34.png", width: 80%))

Per cifrare effettuiamo uno _XOR_ del valore _k_ con il successivo byte del plaintext mentre per decifrare usiamo sempre lo _XOR_ del valore _k_ con il byte successivo del ciphertext.

== Block Cipher Mode Operation
Gli algoritmi con chiave simmetrica e a blocchi processano un blocco alla volta, quindi quando il testo è più lungo è necessario spezzarlo in più blocchi. Possiamo applicare i block cipher in 5 *modes of operation* individuate dal NIST:

#align(center, image("/assets/image-35.png", width: 80%))

=== Electronic Codebook Mode (ECB)
È il metodo più semplice, infatti se i blocchi hanno dimensione _b_ bits allora processiamo il testo _b_ bits alla volta cifrandoli sempre con la stessa chiave.
Per messaggi molto lunghi questa tecnica non è molto sicura infatti se ci sono ripetizioni nel testo queste avranno la stessa cifratura; oppure se il messaggio è molto strutturato potrebbe essere possibile effettuare cryptanalysis, ad esempio se ogni pagina inizia con gli stessi header abbiamo già delle combinazioni che possiamo sfruttare.

Per risolvere questo problema abbiamo bisogno di una tecnica che, anche se troviamo blocchi uguali, produce una cifratura diversa.

=== Cipher Block Chaining Mode (CBC)
In questa modalità di cifratura a blocchi l'input dell'algoritmo è lo _XOR_ del blocco in plaintext corrente e il precedente blocco cifrato, viene comunque utilizzata la stessa chiave.

#align(center, image("/assets/image-36.png", width: 80%))

Per la decifratura ogni blocco cifrato viene passato all'algoritmo, il risultato viene messo in _XOR_ con il precedente blocco cifrato per produrre il blocco in chiaro.

Per capire come funziona e soprattutto dimostrare il funzionamento possiamo scrivere: $ C_j = E(K, [C_(j-1) xor P_j]) $

Dove $E[K,X]$ è la funzione di cifratura effettuata sul blocco $X$ utilizzando la chiave $K$. Continuiamo la dimostrazione scrivendo:

$ D(K, C_j) = D(K, E(K, [C_(j-1) xor P_j])) \ D(K,C_j) = C_(j-1) xor P_j \ C_(j-1) xor D(K, C_j) = C_(j-1) xor C_(j-1) xor P_j = P_j $

Per produrre il primo blocco cifrato abbiamo bisogno di un *initilization vector* (IV) con cui effettuare lo _XOR_ con il primo blocco di plaintext. Per la decifratura facciamo lo stesso ragionamento quindi il vettore IV viene messo in _XOR_ con l'output dell'algoritmo di decifratura per recuperare il primo blocco di plaintext.
Il vettore IV deve essere noto a mittente e destinatario e per avere più sicurezza possiamo proteggere anch'esso con una chiave. Possiamo farlo mandando il vettore usando cifratura ECB.
Perché è importante proteggere IV? Perché anche se un attaccante non conosce la chiave ma riesce a leggere e modificare IV può modificare il primo blocco del messaggio, infatti: $ C_1 = E(K, [I V xor P_1]) \ P_1 = I V xor D(K, C_1) $

Adesso usiamo la notazione $X[j]$ per indicare il bit in posizione $j$: $ P_1[i] = I V[i] xor D(K, C_1)[i] $

E utilizzando la proprietà dello _XOR_: $ P_1[i]' = I V[i]' xor D(K, C_1)[i] $

Dove la notazione con <'> indica il complemento, questo significa che se un attccante può modificare i bit in IV allora può modificare anche i bit nel primo blocco senza conoscere la chiave.

==== *Propagazione degli errori*
In ECB se avviene un errore di trasmissione nel testo cifrato, solo il corrispondente blocco in chiaro viene compromesso.
In CBC l'errore si propaga, se avviene un errore in $C_k$ allora corrompe sicuramente anche $P_k$ e $P_(k+1)$, ma corrompe anche i successivi?

No, supponiamo $C_k$ corrotto e notiamo come il blocco in chiaro $P_(k+2)$ dipenda soltanto da $C_(k+1)$ e $C_(k+2)$:
- $C'_k eq.not C_k$ corrotto
- $P_k = C_(k-1) xor D(K, C_k)$ corrotto
- $P_(k+1) = C_k xor D(K, C_(k+1))$ corrotto
- $P_(k+2) = C_(k+1) xor D(k, C_(k+2))$ non corrotto

Se invece c'è un errore nella versione originale di $P_k$? Attraverso quanti blocchi si propaga l'errore? Che effetti nota il destinatario?
Un errore in $P_k$ corrompe $C_k$ ma dato che $C_k$ è l'input per calcolare $C_(k+1)$ anche quest'ultimo viene corrotto. Questo errore viene portato avanti in modo indefinito su tutti i blocchi cifrati successivi a $C_k$.
Alla fine della ricezione però l'algoritmo di decifratura ricostruisce il messaggo corretto per tutti i blocchi ad eccezione del blocco contentente l'errore.

_Cifratura (sempre corrotti)_

- $P'_k eq.not P_k$
- $C_k = E(K, [C_(k-1) xor P'_k])$
- $C_(k+1) = E(K, [C_k xor P_(k+1)])$
- $C_(k+2) = E(K, [C_(k+1) xor P_(k+2)])$

_Decifratura_

- $P_k = C_(k-1) xor D(K, C_k) = C_(k-1) xor C_(k-1) xor P'_k$ corrotto
- $P_(k+1) = C_k xor D(K, C_(k+1)) = C_k xor C_k xor P_(k+1)$ ok
- $P_(k+2) = C_(k+1) xor D(K, C_(k+2)) = C_(k+1) xor C_(k+1) xor P_(k+2)$ ok

=== Cipher Feedback Mode (CFB)
Con questa modalità possiamo convertire qualsiasi block cipher in uno stream cipher.

#align(center, image("/assets/image-37.png", width: 80%))

Nell'immagine sopra viene assunta come unità di trasmissione $s$, di solito sono 8 bits.
Anche qui il plaintext viene concatenato nella funzione, quindi il testo cifrato di ogni unità di testo in chiaro è in funzione dell'unità precedente.

La funzione di cifratura prende in input uno shift di $b$ bit che per la prima unità viene applicato ad un vettore IV, i $s$ bit più significativi del risultato della funzione vengono messi in _XOR_ con la prima unità di plaintext $P_1$ per produrre la prima unità di testo cifrato $C_1$ che verrà trasmessa. Il contenuto dello shift register viene shiftato a sinistra di $s$ bits e $C_1$ viene piazzato negli $s$ bits più a destra del registro. Questo processo continua finché non vengono cifrate tutte le unità di plaintext.

Per la decifratura viene utilizzato lo stesso schema, l'unica differenza è che le unità di testo cifrato ricevute vengono messe in _XOR_ con l'output che viene prodotto dalla funzione di cifratura.

=== Counter Mode (CTR)

#align(center, image("/assets/image-38.png", width: 80%))

Viene utilizzato un _counter_ che corrisponde alla grandezza dei blocchi del plaintext, l'unico requisito è che il valore counter sia diverso per ogni blocco plaintext che viene cifrato. Di solito questo valore viene inizializzato e poi incrementato ogni volta di 1.
Per la cifratura viene cifrato il counter e poi messo in _XOR_ con il blocco in chiaro, per la decifratura viene usato il processo inverso.

Questa tecnica presenta diversi vantaggi:
- *Hardware Effiency*: Questa tecnica può essere utilizzata in parallelo su più blocchi.
- *Software Efficiency*: Praticamente uguale a quella hardware, abbiamo molte opportunità per sfruttare il parallelismo ad esempio con processori che utilizzano istruzioni SIMD.
- *Preprocessing*: La cifratura non dipende dall'input, questo significa che se abbiamo abbastanza memoria possiamo precalcolarci dei valori per poi effettuare solo gli _XOR_ quando arriva l'input.
- *Random Access*: L'i-esimo blocco del testo in chiaro o del testo cifrato può essere processato senza dipendenze temporali da altri blocchi.
- *Provable Security*: È dimostrato essere sicuro quanto le altre tecniche di block cipher.
- *Simplicity*: A differenza di ECB e CBC, il CTR ha bisogno soltanto di implementare un algoritmo di cifratura e non di decifratura.

== Cryptanalysis
Il processo con il quale un attaccante ricava delle informazioni su un messaggio o una chiave.
La strategia dell'attaccante dipende da:
- Algoritmo di cifratura
- Informazioni a disposizione dell'attaccante (cosa viene inviato nel messaggio o altro)

Ci sono vari attacchi in base a cosa si conosce:
- Ciphertext only
- Known plaintext
- Chosen plaintext
- Chosen ciphertext
- Chosen text

Supponiamo che l'attaccante conosca sempre l'algoritmo di cifratura utilizzato (non sempre vero nella realtà)

*Ciphertext only*

L'attaccante conosce soltanto il testo cifrato, può provare attacchi *bruteforce* sulla chiave, provare a capire dei pattern del test se, ad esempio, conosce in che lingua è scritto il messaggio originale e quindi capire quali sono le parole più ripetute.

*Known plaintext*

L'attaccante conosce uno o più messaggi in chiaro e la loro cifratura, oppure alcuni pattern presenti nel testo in chiaro.
Con queste conoscenze l'attaccante potrebbe essere in grado di dedurre la chiave in base a come viene trasformato il testo.

*Chosen plaintext*

L'attaccante è in grado di accedere al sistema e inserire un suo messaggio che presenta dei pattern in grado di rilevare la struttura della chiave. Ovviamente deve essere in grado di ottenere il messaggio cifrato risultante

*Chosen ciphertext*

L'attaccante ha accesso al sistema per decifrare, seleziona un testo cifrato e lo invia al sistema, analizza il risultato per capire informazioni sulla chiave.

*Chosen text*

L'attaccante ha accesso sia alla cifratura che alla decifratura, può far cifrare messaggi scelti da lui e anche decifrare.

#showybox(
  frame: (
    border-color: green.lighten(60%),
    title-color: green.lighten(60%),
    body-color: green.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Computationally Secury Encryption Schemes*],
  [
    La cifratura è computazionalmente sicura se:
    - Il costo per romperla è maggiore al valore delle informazioni che si ricavano.
    - Il tempo per romperla supera il tempo utile di quell'informazione.
  ]
)

== Key Distribution
Abbiamo visto che questi algoritmi funzionano con chiave simmetrica, questo significa che mittente e destinatario devono condividerla in modo sicuro. Ci sono diversi modi per farlo, supponiamo le due parti siano _A_ e _B_:
- _A_ potrebbe portare fisicamente la chiave a _B_.
- Qualcuno di esterno potrebbe selezionare e portare la chiave a _B_.
- Se _A_ e _B_ già avevano una chiave per parlare potrebbero usarla per trasmettere la nuova chiave.
- Se _A_ e _B_ hanno una connessione sicura con _C_ questo potrebbe inviare la chiave al loro posto.

Le prime due opzioni prevedono uno scambio fisico, la terza è possibile ma se un attaccante entra in possesso di una chiave allora avrà anche tutte le successive. L'opzione 4 rimane la più attuabile:

#align(center, image("/assets/image-39.png", width: 80%))

In questo schema ignoriamo la cifratura nei collegamenti, potrebbe esserci o no, identifichiamo però due tipi di chiave:
- *Session Key*: Quando due _end systems_ vogliono comunicare stabiliscono una connessione logica, per tutta la durata della sessione tutti i dati vengono cifrati con una one-time session key, alla fine della sessione la chiave viene distrutta.
- *Permanent Key*: Questa chiave viene utilizzata per distribuire le sessions key.

Questa configurazione consiste in:
- *Key Distribution Center:* Il Key Distribution Center (KDC) determina quali sistemi sono autorizzati a comunicare fra di loro, quando due di loro ottengono l'autorizzazione questo gli invia una session key per la connessione.
- *Security Service Module (SSM)*: Esegue la cifratura e ottiene le session key degli utenti.

1. Un host invia una richiesta per parlare con un altro host
2. il SSM salva il pacchetto e chiede al KDC l'autorizzazione
3. Tra SSM e KDC avviene una comunicazione cifrata usando una master key condivisa solo fra loro, se il KDC approva la comunicazione genera una session key e la invia ai due SSM utilizzando una chiave permanente per ogni SSM.
4. L'SSM può adesso stabilire la connessione tra i due sistemi e rilasciare il pacchetto di connessione.

Tutti i dati che vengono scambiati adesso saranno cifrati dall'SSM utilizzando la session key.