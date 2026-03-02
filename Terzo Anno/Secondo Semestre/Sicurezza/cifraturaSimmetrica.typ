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
