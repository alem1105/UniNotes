#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= Cryptographic Tools

== Symmetric Encryption
È la tecnica di crittografia universale per garantire la *confidenzialità* dei dati. Il mittente e il destinatario, per scambiarsi messaggi, devono condividere la stessa chiave segreta _K_.
Questa tecnica, per essere sicura, richiede:
- Un algoritmo crittografico forte.
- Che la condivisione della chiave sia avvenuta in modo sicuro.

#align(center, image("/assets/image-6.png", width: 80%))

I principali tipi di attacco a queste tecniche sono:
- *Crittoanalisi*: Sfruttare la natura matematica dell'algoritmo o se si conoscono alcune caratteristiche del testo non cifrato per dedurre la chiave.
- *Brute-Force*: Si provano tutte le chiavi possibili finché non si ottiene un testo sensato. In media è necessario provare almeno la metà di tutte le chiavi possibili.

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
  title: [*La distrubuzione delle chiavi*],
  [
    Il vero problema di questa tecnica è la distribuzione della chiave, infatti, come fanno due persone a scambiarsi la chiave in modo sicuro se il canale su cui parlano non è protetto? Questo problema verrà risolto dalla *crittografia asimmetrica*.
  ]
)

Tra i principali algoritmi per la crittografia simmetrica troviamo:
- *DES (Data Encryption Standard)*: Utilizza blocchi da 64-bit e una chiave da 56-bit. Anche se è l'algoritmo più studiato la sua chiave da 56-bit lo rende molto debole contro i moderni processori di oggi.
- *3DES (Triple DES)*: Ripete il DES tre volte usando 2 o 3 chiavi diverse portando quindi la lunghezza effettiva della chiave a 112 o 168 bit. I problemi principali sono che è molto lento e usa ancora blocchi piccoli da 64-bit.
- *AES (Advanced Encryption Standard)*: Creato per sostituire il 3DES. È molto più efficiente, utilizza blocchi da 128-bit e chiavi da 128, 192 o 256-bit.

L'AES è più efficiente perchè utilizza un'architettura chiamata *Rijndael* che applica le sue trasformazioni all'intero blocco di 128-bit simultaneamente organizzandolo in una matrice, questa struttura è ottimizzata per eseguire calcoli paralleli ed è perfetta per come lavorano i processori moderni.
Questo rende l'algoritmo più veloce rispetto ad un DES o 3DES che invece utilizzano la *Rete di Feistel*, questa divide il blocco a metà e, a ogni passaggio, cripta solo una metà alla volta incrociandola con l'altra.

_Tempi medi richiesti per rompere un algoritmo_:

#align(center, image("/assets/image-7.png", width: 80%))

Oggi però i *computer quantistici* minacciano gravemente gli algoritmi con chiave pubblica, infatti questi si basano su problemi matematici come la fattorizzazione che un QC può risolvere facilmente. Oggi si cercano quindi algoritmi *Quantum - resistant*.

== Type of Symmetric Encryption
Ovviamente dobbiamo cifrare file più grandi di un qualsiasi blocco, per questo esistono diverse tipologie di cifratura:
- *Block Cipher*: Cifra il testo elaborando un blocco alla volta, può riutilizzare le chiavi ed è il più comune.
- *Stream Cipher*: Cifra il flusso di dati continuamente, byte alla volta, generando un flusso pseudocasuale, è molto più veloce e usa meno codice.

Un metodo di cifratura che utilizza il cifrario a blocchi è il *ECB*:
- *Electronic Codebook (ECB)*: È la modalità base per usare i cifrari a blocchi su messaggi lunghi. Ogni blocco viene cifrato singolarmente con la stessa chiave, il problema è che se il testo in chiaro ha delle regolarità allora queste appariranno anche nel testo cifrato.

== Message Authentication
La cifratura dei messaggi protegge dalla lettura non autorizzata ma non dalla manomissione del messaggio ovvero gli attacchi attivi.
Con l'autenticazione dei messaggi garantiamo:
- Il contenuto non è stato alterato
- Il messaggio proviene da una fonte legittima

Per garantire che il messaggio non sia stato alterato si utilizza un *MAC (Message Authentication Code)*. Attraverso la chiave _K_ e il messaggio _M_ si calcola un "tag": $ "MAC" = F(K,M) $
Se il ricevente, ricalcolando il MAC con la stessa chiave segreta, ottiene lo stesso risultato, ha la garnazie che il messaggio non sia stato modificato.

#align(center, image("/assets/image-8.png", width: 80%))

Ovviamente, anche qui, la chiave deve essere in possesso solo delle persone fidate.

Possiamo inoltre distinguere due casi:
- *Without Confidentiality*: Il messaggio è autenticato ma non cifrato, viene soltanto aggiunto il TAG al messaggio.
- *With Confidentiality*: Il messaggio è autenticato e cifrato, quindi anche il tag viene cifrato.

Quando è utile avere autenticazione ma non confidenzialità?
- Sistemi broadcast o molto carichi
- Protocolli di rete, l'header del pacchetto IP non deve essere alterato ma non abbiamo bisogno di nasconderlo dato che i router devono leggerlo.

== Funzioni di Hash
Una funzione Hash $H(M)$ è un'alternativa al _MAC_ che non richiede una chiave in input, prende un messaggio di dimensione variabile e restituisce un'impronta di dimensione fissa (_digest_). Per essere sicura, una funzione Hash deve possedere:
- *One-Way or preimage resistant*: Dato un hash, deve essere impossibile risalire al messaggio originale.
- *Second preimage or Weak Collision resistant*: Dato un messaggio _X_, deve essere impossibile trovare un altro messaggio _Y_ diverso che produca lo stesso hash.
- *Strong collision resistant*: Deve essere impossibile trovare qualsiasi coppia di messaggi _X_ e _Y_ che abbiano lo stesso Hash

Possiamo utilizzare l'hash a scopo di autenticazione in diversi modi:
- *One-Way Hash function + Symmetric Encryption*
  #align(center, image("/assets/image-9.png", width: 80%))
- *One-Way Hash function + Public Key Encryption*
  #align(center, image("/assets/image-10.png", width: 80%))
  Qui il vantaggio è che non è richiesta la distribuzione delle chiavi in modo sicuro.
- *One-Way Hash function + Secret Value (no encryption)*
  #align(center, image("/assets/image-11.png", width: 80%))
  Non abbiamo bisogno di crittografia, risparmiando quindi computazione.
  Chi invia il messaggio deve calcolare $"MD"_M = H(K | M | K)$ e inviare $"MD"_M | M$, a questo punto il destinatario, che conosce _K_, deve calcolare $H(K | M | K)$ e verificare $"MD"_M$

Lo standard più utilizzato è lo *SHA* anche se oggi è considerato debole e si utilizza *SHA-2 o SHA-3*.

== Crittografia a Chiave Pubblica (Asimmetrica)
È un algoritmo di crittografia proposto da *Diffie e Hellman* nel 1976, risolve principalmente il problema della distribuzione della chiave.
Viene utilizzata una coppia di chiavi collegate fra loro matematicamente, una *pubblica* e una *privata*. Queste garantiscono:
- *Confidenzialità*: Io cifro con la chiave pubblica di Bob e solo Bob con la sua chiave privata sarà in grado di decifrare il messaggio.
- *Autenticazione*: Cifro l'hash con la mia chiave privata, adesso tutti possono decifrarlo con la mia chiave pubblica garantendo quindi che sono stato io a generare quel messaggio.

#align(center, image("/assets/image-12.png", width: 80%))

Tra i principali algoritmi a chiave asimmetrica troviamo:
- *RSA*: Utilizzato per la cifratura, firme digitali e scambio di chiavi.
- *Diffie-Hellman*: Serve _solo_ per permettere a due entità di generare una chiave simmetrica condivisa attraverso un canale sicuro.
- *DSS (Digital Signature Standard)*: Garantisce firma digitale con SHA-1
- *ECC (Elliptic Curve)*: Sicuro quanto RSA ma usa chiavi più corte, è quindi più veloce e leggero.

#align(center, image("/assets/image-13.png", width: 80%))

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
  title: [*Vero vantaggio della chiave asimmetrica*],
  [
    La crittografia asimmetrica è *computazionalmente lentissima* rispetto a quella simmetrica, nel mondo reale infatti viene si utilizzata ma soltanto all'inizio delle comunicazioni per scambiare in modo sicuro una chiave segreta temporanea simmetrica, dopo questo scambio il resto della comunicazione avviene con cifratura simmetrica tramite AES.
  ]
)