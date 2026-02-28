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

_Per blocchi intendiamo la grandezza degli "spazi" in cui viene diviso il messaggio da cifrare e sui quali viene applicata la cifratura, quindi se adesempio abbiamo da cifrare un messaggio lungo m e blocchi da n, avremo $m / n$ blocchi_