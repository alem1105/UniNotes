#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= Internet Security
In questo capitolo ci si concentra sui pericoli con cui puó scontrarsi un utente su internet.
Iniziamo vedendo le criticitá dei browsers ovvero i software che permettono agli utenti di collegarsi ad internet, di base questi devono:
- Collegarsi a degli indirizzi web
- Ricevere i contenuti da mostrare
- Trasmettere eventuali dati dell'utente all'indirizzo

Giá da questi tre punti possiamo osservare diverse possibili criticità:
- Un browser spesso si connette anche ad altri indirizzi oltre a quello indicato nella barra di navigazione
- Il software del browser puó essere corrotto per eseguire azioni malevole
- Alcuni browser permettono l'installazione di estensioni di cui non possiamo fidarci al 100%.
- Altro...

Con altri tipi di programmi è possibile limitare i file a cui hanno accesso o togliere l'accesso ad internet esterno, queste limitazioni non sono applicabili ad un browser e, anche per questo, è uno dei principali vettori di attacco dove vengono anche scoperte molte vulnerabilità.

== Browser Attacks
Ci sono 3 principali modi per attaccare un browser:
- Modificare il sistema operativo in modo da compromettere il corretto funzionamento del browser.
- Modificare il browser o uno dei suoi componenti per alterarne il comportamento.
- Intercettare e/o modificare le comunicazioni da e verso il browser.

=== Man-in-the-Browser
In questo tipo di attacco si utilizza del codice per infettare il browser, questo codice puó leggere, copiare e condividere tutto quello che l'utente inserisce nel browser. Il pericolo qui é che l'attaccante puó recuperare le credenziali dell'utente, dati bancari o altre informazioni sensibili.
