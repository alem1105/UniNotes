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

#align(center, image("/assets/image-19.png", width: 80%))

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
  title: [*Calcolareryptanalysis*],
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

Utilizzare la funzione di decifratura come secondo step in 3DES non offre vantaggi in termini di crittografia ma permette la retrocompatibilità con il DES classico, o meglio permette a chi usa 3DES di decriptare anche messaggi cifrati con DES.

Per migliore sicurezza si è passati poi all'AES.

==== AES - Advanced Encryption Standard
- Blocchi da 128-bits e chiavi da 128-192-256-bits.
- L'input delle funzioni di cifratura e decifratura sono blocchi singoli da 128-bits, questi vengono rappresentati in una matrice 4x4 con un byte su ogni cella (16 byte = 128bits). La matrice durante il processo viene copiata nello *State Array* che viene modificato ad ogni passo.
- La chiave viene estesa in un array per lo schedule delle key words. Ogni word è composta da 4 bytes e per una chiave da 128bit generiamo 44 words, abbastanza da coprire ogni round (dato che in un round usiamo 4 words per generare una sottochiave)
- L'ordine con cui leggere le matrici è seguendo le colonne, quindi:

  #align(center, image("/assets/image-21.png", width: 50%))

Quindi, ricapitolando, abbiamo due matrici ordinate in questo modo una per le chiavi da utilizzare e una per il testo.

In questo algoritmo i round:
- Non seguono architettura Feistel.
- Hanno tutti lo stesso tipo e numero di operazioni tranne l'ultimo round della cifratura e il primo della decifratura.
- Abbiamo una chiave iniziale da cui vengono generate sottochiavi. (come visto prima)

#align(center, image("/assets/image-20.png", width: 80%))

Vediamo le operazioni da svolgere in ogni round, partiamo da questa situazione:

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
- Restituisce come output un vettore da 44 words ovvero 176bytes, questo è sufficiente per garantire il numero di chiavi necessario per tutti i round.

Queste bastano per tutto l'algoritmo dato che le prime 4 word vengono usate per il primo _Add Round Key_ e le restanti 40 nei successivi 10 round.
Ovviamente all'aumentare della lunghezza della chiave aumentano anche i round.

Gli steps sono:
1. Viene copiata la chiave nelle prime 4 words dell'array esteso.
2. Il resto viene riempito con 4 words alla volta dove la word `word[i]` dipende da `w[i-1]` e `w[i-4]`.
Esistono diversi complessi algoritmi _finite-field_ per generare questa chiave estesa.

Nello specifico otteniamo:

#align(center, image("/assets/image-27.png", width: 80%))

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
Un algoritmo che ha:
  - Dimensione della chiave variabile da 128-192-256-bits.
  - Estremamente veloce.
  - Si basa su permutazioni casuali.

Si compone di diverse fasi
- *Inizializzazione*: Si prende la chiave e viene utilizzata per inizializzare un vettore _S_ di 256byte, se la chiave è lunga 256 viene usata tutta, se più piccola viene ripetuta.
- Questo vettore conterrà sempre una permutazione dei bit della chiave.
- Per cifrare e decifrare, viene generato un byte _k_ dal vettore _S_ selezionandolo a caso.
- Ad ogni valore generato viene effettuata una permutazione su _S_.

La chiave viene anche copiata su un array _T_, infatti se la chiave è più piccola di _S_ allora viene ripetuta in _T_ altrimenti se di uguale grandezza avremo _T_ ed _S_ uguali con al loro interno soltanto la chiave.

*Inizializzazione*:
```
for i = 0 to 255 do
S[i] = i;
T[i] = K[i mod keylen]
```

Effettuo la *prima permutazione*:
Per fare questa utilizziamo _T_, scorriamo tutto _S_ e per ogni `S[i]` lo swappiamo con un altro byte in _S_ basandoci sullo schema fornito da `T[i]`. Nello specifico:

```
j = 0;
for i = 0 to 255 do
j = (j + S[i] + T[i]) mod 256;
Swap (S[i], S[j]);
```

Iniziamo la *generazione delle chiavi*:
Si scorre tutto l'array _S_ e per ogni elemento si swappa `S[i]` con un altro byte di _S_ seguendo _S_ stesso, se si raggiunge il massimo si rinizia dall'elemento 0.
- Per cifrare, si fa uno _XOR_ del valore _k_ con l'elemento successivo del plaintext.
- Per decifrare, si fa uno _XOR_ di _k_ con l'elemento successivo nel ciphertext.

```
i, j = 0;
while (true)
  i = (i + 1) mod 256;
  j = (j + S[i]) mod 256;
  Swap (S[i], S[j]);
  t = (S[i] + S[j]) mod 256;
  k = S[t];
```

