#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages, zebra-fill: none)
#show raw: set text(font: "Cascadia Code")

#codly()

= Cifratura a Chiave Asimmetrica e Message Authentication

== Secure Hash Functions
Abbiamo già visto precedentemente le proprietà che dovrebbero essere rispettate da una buona hash function, adesso vediamo diverse funzioni con un focus sul gruppo delle *Secure Hash Algorithms (SHA)*.

=== Simple Hash Functions
Tutte le funzioni di hash operano nel seguente modo:
- L'input viene visto come una sequenza di blocchi da $n$-bits.
L'input viene processato un blocco alla volta in modo iterativo, alla fine dell'operazione si ottiene un risultato da $n$-bit. Per capire questo meccanismo si può prendere come esempio una delle funzioni più semplici ovvero con lo _XOR_, possiamo processarlo nel seguente modo: $ C_i = b_(i 1) xor b_(i 2) xor ... xor b_(i m) $

Dove:
- $C_i$: L'i-esimo bit dell'hash code con $1 lt.eq i lt.eq n$
- $m$: Numero dei blocchi da $n$ bits in input
- $b_(i j)$: i-esimo bit del j-esimo blocco
- $xor$: _XOR_ operation

Quindi ogni blocco viene messo in XOR con il successivo e alla fine otteniamo un valore grande quanto la grandezza dei blocchi.

Possiamo vedere questo processo graficamente con la seguente tabella:

#align(center, image("/assets/image-40.png",width: 50%))

Questa operazione non fa altro che produrre un bit di parità per ogni bit ed è conosciuta come *longitudinal redundancy check*, è abbastanza efficace per check di integrità. Però c'è da notare che la probabilità che un errore nei dati non porti ad un cambiamento nell'hash code è di $2^(-n)$.
Più i dati sono formattati e più perde di efficacia, ad esempio in quasi tutti i normali file di testo il primo bit di ogni ottetto è sempre 0, quindi se viene usato un valore hash da 128-bit (grandezza del risultato) invece di un'efficacia di $2^(-128)$ avremo $2^(-112)$.
Infatti dato che un ottetto è fatto da 8bit se abbiamo un hash value da 128 significa che abbiamo 16 ottetti (16 x 8), ma sappiamo che il primo bit di ognuno è 0 quindi ci saranno 16 bit bloccati a 0 che non cambieranno mai.

Per migliorare questo algoritmo possiamo applicare un *1-bit circular shift*, o rotazione, sull'hash value dopo che ogni blocco viene processato, possiamo riassumere l'operazione in:
1. Impostiamo l'hash value da $n$-bit a zero.
2. Processiamo ogni blocco successivo nel seguente modo:
  - Ruotiamo il valore hash corrente a sinistra di 1-bit.
  - _XOR_ del blocco con il valore hash.

Questo serve a "randomizzare" l'input ed abbassare il numero di _regolarità_ all'interno del testo, nonostante questo garantisca buona integrità dei dati non garantisce sicurezza. Questo perché lo _XOR_ è bidirezionale e facilissima da invertire, un attaccante potrebbe:
1. Intercettare un messaggio vero e il suo Hash Value valido
2. Scrivere un messaggio a suo piacimento
3. Calcolare l'hash di questo messaggio con lo stesso algoritmo e ottenere un hash falso
4. Aggiunge in fondo al messaggio un falso blocco di bit senza senso
5. Poiché lo XOR è prevedibile l'attaccante può calcolare matematicamente l'esatto valore che questo blocco extra deve avere per far si che sommandolo al risultato finale diventi magicamente indentico all'hash value vero.
//<3
Cifrare tutto non è la soluzione in questo caso, era stata proposta una soluzione dove oltre allo XOR applicato a blocchi da 64bits veniva cifrato tutto il messaggio con CBC, il procedimento era il seguente:

- Dato un messaggio in blocchi da 64bits $X_1, X_2, ..., X_N$ definiamo l'hash code $C$ come lo XOR blocco a blocco di tutti i blocchi e con l'hash code messo come ultimo blocco: $ C = X_(N+1) = X_1 xor X_2 xor ... xor X_N $

Poi viene cifrato il messaggio intero e inserito l'hash code per produrre il messaggio cifrato $Y_1, Y_2, ..., X_(N+1)$.
Sono stati scoperti diversi modi in cui il testo cifrato può essere manipolato e non rilevato dall'hashcode. Per esempio (seguendo le regole del CBC): $ X_1 = I V xor D(K, Y_1) \ X_i = Y_(i-1) xor D(K, Y_i) \ X_(N+1) = Y_N xor D(K, Y_(N+1)) $

Ma sappiamo che $X_(N+1)$ è l'hash code:
$ X_(N+1) &= X_1 xor X_2 xor ... X_N \ &=[I V xor D(K,Y_1)] xor [Y_1 xor D(K, Y_2)] xor ... xor [Y_(N-1) xor D(K, Y_N)] $

Dato che i termini nell'equazione precedente possono essere messi in XOR in qualsiasi ordine, significa che l'hash code non cambia se il testo cifrato viene permutato.

=== The SHA Secure Hash Function
Esistono diverse versioni di SHA:

#align(center, image("/assets/image-41.png", width: 80%))

Nel corso ci concentriamo su SHA-512.
L'algoritmo prende in input un messaggio con una lunghezza massima di $2^(128)$ bits e produce un output di 512-bit chiamato _digest_. L'input viene processato in blocchi da 1024-bit.

Graficamente possiamo vedere il processo:

#align(center, image("/assets/image-42.png", width: 80%))

Consiste in:
1. *Append padding bits*: Al messaggio viene aggiunto un padding in modo che la lunghezza sia congruente a 896 modulo 1024, il padding viene sempre aggiunto anche se il messaggio è alla lunghezza desiderata. Il numero di bit di padding quindi si trova nel range di 1-1024 bits e il padding consiste in un singolo bit impostato a 1 seguito da tutti i bit necessari impostati a 0.
2. *Append Length*: Viene aggiunto alla fine un blocco da 128bit, questo viene trattato come un intero senza segno a 128bit e contiene la lunghezza del messaggio originale (prima dell'aggiunta del padding).

Dopo questi 2 passaggi otteniamo un messaggio che ha una lunghezza multiplo di 1024bits. Nell'immagine il messaggio viene rappresentato come una sequenza di blocchi da 1024bits $M_1, M_2, ..., M_N$ e la lunghezza totale è quindi $N times 1024$bits.

3. *Initialize hash buffer*: Un buffer da 512bit viene utilizzato per memorizzare i risultati intermedi e finale della funzione di hash. Il buffer può essere rappresentato come 8 registri da 64bits inizializzati a questi valori esadecimali:
$ a = "6A09E667F3BCC908" space e = "510E527FADE682D1" \
  b = "BB67AE8584CAA73B" space f = "9B05688C2B3E6C1F" \
  c = "3C6EF372FE94F82B" space g = "1F83D9ABFB41BD6B" \ 
  d = "A54FF53A5F1D36F1" space h = "5BE0CD19137E2179"
$

Questi valori sono salvati in formato *big-endian* ovvero dove il bit più significativo si trova nel posizione più a sinistra. I valori sono stati ottenuti prendendo i primi 64bits delle parti frazionarie delle radici quadrate dei primi 8 numeri primi.

4. *Process message in 1024-bit (128-word) blocks*: È il cuore dell'algoritmo, consiste in 80 rounds e nella figura precedente viene indicato come _F_. La logica invece viene illustrata con questa figura:

#align(center, image("/assets/image-43.png", width: 80%))

Ogni round prende come input il buffer da 512bit e aggiorna il suo contenuto. Come input del primo round abbiamo il valore hash intermedio $H_(i-1)$, ogni round $t$ utilizza un valore a 64bit $W_t$ derivato dal blocco corrente (1024bit) $M_i$. Ad ogni round si utilizza anche una costante $K_t$ dove $0 lt.eq t lt.eq 79$ (una per ogni round), queste costanti sono i primi 64bits delle parti frazionarie delle radici cubiche dei primi 80 numeri primi. Le costanti forniscono un set di patterns a 64bit randomizzati che dovrebbe rimuovere ogni regolarità presente nel testo in input.
Le operazioni eseguite in un round sono _shift circolari_ e operazioni booleane basate su _AND, OR, NOT e XOR_.
L'output dell'80-esimo round viene sommato insieme all'input del primo round $H_(i-1)$ e viene prodotto $H_i$, la somma viene fatta in modo indipendente per ognuna delle 8 words del buffer usando un'addizione modulo $2^(64)$.

5. *Output*: Dopo che tutti gli $N$ blocchi sono stati processati abbiamo l'output da 512bit.

L'algoritmo SHA-512 ha la proprietà che ogni bit dell'hash code è una funzione di ogni bit in input, le ripetizioni molto complesse della funzione _F_ producono risultati molto "disordinati" ed è molto difficile che due messaggi scelti a caso, anche simili, abbiano lo stesso hash code.
In ogni caso trovare due messaggi con lo stesso hash code è nell'ordine delle $2^(256)$ operazioni, mentre trovare un messaggio dato un hash code è nell'ordine delle $2^(512)$.

== HMAC
Vediamo l'approccio con hash code per l'*autenticazione dei messaggi*, questa tecnica è motivo di interesse perché:
- Le funzioni hash generalmente vengono eseguite più velocemente rispetto agli algoritmi di crittografia come il _DES_.
- Sono molto più diffuse librerie di codice per funzioni hash.

Funzioni hash come _SHA-1_ però non sono state progettate per essere usate come MAC e non possono essere usate in questo modo direttamente perché non si basano su una chiave segreta. Ci sono stati diversi tentativi per introdurre una chiave negli algoritmi hash esistenti e quello che ha ricevuto più supporto è l'*HMAC*, questo è stato anche usato per implementare MAC nelle connesioni internet in vari protocolli.

Obiettivi dell'HMAC:
- Utilizzare, senza modifiche, le esistenti funzioni hash.
- Permettere la sostituzione della funzione hash scelta con altre più sicure.
- Preservare le performance originali della funzione hash.
- Utilizzare le chiavi in modo semplice.
- Avere un'ottima comprensione della "forza" della funzione hash che stiamo usato, il vantaggio infatti è che se la funzione è sicura allora lo è anche HMAC.

HMAC tratta la funzione hash come una _"black box"_, questo ha due benefici, il primo è che parte dell'algoritmo è già pronta senza modifiche mentre il secondo è che possiamo appunto sostituire facilmente una funzione con un'altra, ad esempio se su quella in uso vengono scoperte delle debolezze.

Vediamo come funziona l'algoritmo, definiamo i seguenti termini:
- $H$ - funzione hash (SHA).
- $M$ - Messaggio input di HMAC (incluso il padding specificato nella funzione hash)
- $L$ - Numero di blocchi in $M$
- $Y_i$ - Blocco $i$-esimo di $M$ con $0 lt.eq i lt.eq L-1$
- $b$ - Numero di bits in un blocco
- $n$ - Lunghezza dell'hashcode prodotto dalla funzione hash
- $K$ - Chiave segreta, se la lunghezza della chiave è maggiore di $b$, allora la chiave viene data in input alla funzione hash per produrre una chiave da $n$-bit, una lunghezza consigliata è $gt.eq n$.
- $K^+$ - $K$ con un padding di zeri a sinistra in modo che la lunghezza sia $b$ bits.
- $"ipad"$ - 00110110 (36 in esadecimale) ripetuto $b/8$ volte
- $"opad"$ - 01011100 (5C in esaedcimale) ripetuto $b/8$ volte

Graficamente abbiamo:
#align(center, image("/assets/image-44.png", width: 80%))

La formula formale dell'HMAC è: $ "HMAC"(K,M) = H[(K^+ xor "opad") || H[k^+ xor "ipad"] || M] $

Che possiamo descrivere in questi passaggi:
1. Aggiungi zeri a sinistra di $K$ per creare una stringa lunga $b$ chiamata $K^+$
2. _XOR_ di $K^+$ con _ipad_ per produrre il blocco da $b$-bit $S_i$.
3. Aggiungere alla fine di $S_i$ $M$
4. Applicare $H$ allo stream generato dallo step 3.
5. _XOR_ di $K^+$ con _opad_ per produrre il blocco da $b$-bit $S_o$
6. Aggiungere alla fine del blocco $S_o$ il risultato dello step 4.
7. Applicare $H$ allo stream generato dallo step 6 per ottenere il risultato finale.

Da notare che lo _XOR_ con _ipad_ significa invertire una metà dei bit di $K$ e anche con _opad_ ma con un set di bit diverso. Passare $S_i$ e $S_o$ all'algoritmo di hash significa infatti creare due chiavi pseudocasuali da $K$.
HMAC dovrebbe avere un tempo d'esecuzione simile alla funzione hash per lunghi messaggi, infatti aggiunge 3 esecuzione della funzione base.

=== Secutity of HMAC
HMAC fa affidamento quasi interamente sulla funzione hash che utilizza, è stato provato infatti che la probabilità di successo di un attacco contro HMAC da parte di un attaccante che può leggere l'output di un messaggio generato da un utente è equivalente a uno dei seguenti attacchi alla funzione hash:
1. L'attaccante è in grado di calcolare un output della compression function anche con IV random, segreto e sconosciuto all'attaccante.
2. L'attaccante trova collissioni nella hash function anche con IV randomico e segreto.

Nel primo attacco, possiamo vedere la compression function come la hash function applicata ad un singolo blocco da _b_-bit, per questo attacco l'array IV è rimpiazzato da un segreto casuale di $n$ bits. Un attacco di questo tipo alla funzione hash richiede un attacco di forza bruta sulla chiave che è nell'ordine di $2^n$, o il _birthday attacck_ che è un caso particolare del secondo attacco.
Nel secondo attacco, l'attaccante è in ricerca di due messaggi $M$ e $M'$ che producono lo stesso hash quindi $H(M) = H(M')$, questo è il _birthday attacck_ detto prima. Per questo tipo di attacco siamo nell'ordine di $2^(n/2)$ per una lunghezza dell'hashcode di $n$.

Con questi dati potremmo pensare che ad esempio l'algoritmo MD5 non sia più sicuro dato che un numero di tentativi di $2^(64)$ oggi è abbastanza fattibile, quindi MD5 renderebbe HMAC non sicuro? *No*, questo perché HMAC utilizza una chiave segreta _K_, per calcolare l'HMAC di un messaggio non basta il messaggio stesso ma serve anche questa chiave.
Quindi MD5 da solo è debole perché l'attaccante potrebbe mettersi a genere hashcode finché non trova una collisione, ma se usato con HMAC allora l'attacco deve diventare *online* ovvero si deve mettere in ascolta e sperare di trovare due messaggi con lo stesso hash, per farlo dovrebbe catturare circa $2^(64)$ messaggi, anche con una rete a 1Gbps che trasmette senza mai fermarsi ci vorrebbero comunque 150.000 anni di intercettazioni continue, inoltre questo presuppone che la chiave non venga *mai cambiata* per lo stesso tempo.

== Authenticated Encryption (AE)

*NON HO TROVATO LE PAGINE DEL LIBRO SU QUESTO PARAGRAFO, DEVO CAPIRLO E SCRIVERLO MEGLIO*

Sono sistemi di cifratura che garantiscono sia confidenzialità che integrità. (Message encryption + message authentication)
Sono implementati attraverso block cipher, il primo è stato *OCB AE (2014)*:
- Approvato come standard in _IEEE 802.11_ wireless LAN e incluso in _MiniSec_.
Poi abbiamo *OCB* che è simile a ECB:
- Ha la stessa debolezza di ECB quindi stesso messaggio con stessa chiave produce lo stesso risultato, non è quindi sicuro per messaggi lunghi.
- Introduce un nuovo vettore _Z_, che viene utilizzato per effettuare _XOR_ con ogni blocco $M[i]$ nel seguente modo: $ C[i] = E_k (M[i] xor Z[i]) xor Z[i] $
- AES è usato come algoritmo di cifratura.
- $M$ viene diviso in blocchi da $n$-bits.
- Il numero totale di blocchi è $m=ceil("len"(M) / n)$
- $N$, un valore arbitrario di $n$-bit chiamato *nonce*
  - Se vengono cifrati più messaggi con la stessa chiave allora sarebbe meglio cambiare questo valore per ogni messaggio.
  - Ogni valore differente di $N$ produce un set diverso di $Z[i]$.

_Graficamente abbiamo_:

#align(center, image("/assets/image-45.png", width: 80%))

Calcolo di $Z[i]$:
- $L[0] = L = E_k (0^n)$
- $R = E_k (N xor L)$
- $L[i] = 2 dot L[i-1]; 1 lt.eq i lt.eq m;$ dove la moltiplicazione è un'operazione nei _campi finiti_.
- $Z[1] = L xor R$
- $Z[i] = Z[i-1] xor L["ntz")i]; 2 lt.eq i lt.eq m$ con ntz(i) indichiamo il numero di 0 meno significativi in $i$.

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
  title: [*Operazioni nei campi finiti*],
  [
    Servono a non far "esplodere" il risultato, se il risultato sfora il numero massimo che i bit possono contenere allora questo risultato viene riavvolto ovvero, se ad esempio abbiamo come risultato 260 e come valore massimo 255 allora il risultato sarà invece 4 perché una volta raggiunto 256 riniziamo a contare da 0.
  ]
)

Vediamo adesso come avviene il calcolo di $C[m]$, della checksum e del tag:
- $"len"(M[m]) lt.eq n$ bit
- $C[m]$ viene calcolato in modo diverso da $C[i={1, m-1}]$
- $C[m]0^*$ è uguale a $C[m]$ con un padding fino a raggiungere una lunghezza di $n$.
- $L[-1] = L dot 2^(-1)$
- La checksum è in funzione di $M$ e $K$
- Viene prodotto un Tag di lunghezza *tau*
- *tau* determina il livello di autenticazione, più è alto *tau* maggiore è il livello di autenticazione.

_Algoritmo di cifratura_:

1. Partizionare M in $M[1],...,M[m]$
2. $L = L(0) = E_K (0^n)$
3. $R = E_k (N xor L)$
4. for $(i = 1; i lt.eq m)$ $L(i) = 2 dot L(i-1)$
5. $L(-1) = L dot 2^(-1)$
6. $Z[1] = L xor R$
7. for $(i = 2; i lt.eq m)$ $Z[i] = Z[i-1] xor L("ntz"(i))$
8. for $(i = 1; i lt.eq m-1)$ $C[i]=E_K (M[i] xor Z[i]) xor Z[i]$
9. $X[m] = "len"(M[m]) xor L(-1) xor Z[m]$
10. $Y[m] = E_K (X[m])$
11. $C[M] = M[m] xor ("first len"(M[m]) "bits of" Y[m])$
12. Checksum = $M[1] xor ... xor M[m-1] xor C[m]0^* xor Y[m]$
13. Tag = $E_K ("Checksum" xor Z[m]) ["first "tau"bits"]$

_Algoritmo di decifratura_:

1. Partizionare M in $M[1],...,M[m]$
2. $L = L(0) = E_K (0^n)$
3. $R = E_K (N xor L)$
4. for $(i = 1; i lt.eq m)$ $L(i) = 2 dot L(i-1)$
5. $L(-1) = L dot 2^(-1)$
6. $Z[1] = L xor R$
7. for $(i = 2; i lt.eq m)$ $Z[i] = Z[i-1] xor L("ntz"(i))$
8. for $(i = 1; i lt.eq m-1)$ $M[i] = D_K (C[i] xor Z[i]) xor Z[i]$
9. $X[m] = "len"(M[m]) xor L(-1) xor Z[m]$
10. $Y[m] = E_K (X[m])$
11. $M[m] = ("first len"(C[m]) "bits of" Y[m]) xor C[m]$
12. Checksum = $M[1] xor ... xor M[m-1] xor C[m]0^* xor Y[m]$
13. Tag' = $E_K ("Checksum" xor Z[m]) ["first "tau"bits"]$

== RSA Publick-Key Encryption
RSA è un block cipher dove il plaintext e il testo cifrato sono interi tra 0 ed $n-1$ per un $n$.
Cifratura e decifratura sono nella seguente forma, dato un blocco di testo in chiaro $M$ e un blocco di testo cifrato $C$:
$ C &= M^e "mod" n \ M &= C^d "mod" n = (M^e)^d "mod" n = M^(e d) "mod" n $

Sia mittente che destinatario devono conoscere i valori di $n$ ed $e$, inoltre solo il destinatario conosce il valore di $d$. Questo algoritmo ha come chiave pubblica $P U = {e, n}$ e come chiave privata $P R={d, n}$, per essere un buon algoritmo di cifratura a chiave pubblica deve soddisfare i seguenti requisiti:
1. Deve essere possibile trovare valori di $e, d, n$ tali che $M^(e d) "mod" n = M$ per ogni $M < n$.
2. Deve essere relativamente facile calcolare $M^e$ e $C^d$ per ogni valore $M<n$.
3. Deve essere praticamente impossibile determinare $d$ dato $e$ ed $n$.

Riguardo al primo requisito, significa che dobbiamo trovare una relazione nella forma $ M^(e d) "mod" n = M $

Per soddisfare questa equazione, dato che usiamo numeri interi, é necessario soddisfare: $ e dot d "mod" Phi(n) = 1 $
Dove con $Phi(n)$ indichiamo la *funzione toziente di Eulero*, questa rappresenta il numero di interi positivi piú piccoli di $n$ che sono "relativamente primi" a $n$ cioé che non hanno divisori in comune con $n$ a parte 1.
Calcolare questa funzione per numeri grandi é si molto semplice ma praticamente impossibile dato che andrebbero controllati tutti i numeri prima di $n$ per vedere se sono primi rispetto ad esso.
É qui che sono d'aiuto i numeri primi, infatti la matematica ci dice che se prendiamo $n = p dot q$ con $p$ e $q$ primi allora possiamo calcolare $Phi(n) = (p-1)(q-1)$, infatti se un numero é primo non condivide divisori con nessuno dei numeri che lo precedono e quindi $Phi(q)=q-1$.
Quindi se conosciamo i due numeri che hanno "creato" $n$ allora calcolare $Phi(n)$ si calcola subito altrimenti ci vorrebbero tantissimi anni.

Adesso utilizziamo quindi $Phi(n)$ per creare le chiavi:
- L'esponente pubblico $e$, lo scegliamo a caso e lo usiamo per cifrare le chiavi. L'unica regola é che non deve avere divisori in comune con $Phi(n)$. La chiave pubblica che diamo a tutti é $(e,n)$.
- L'esponente privato $d$ lo scegliamo quindi tale che rispetti $e dot d "mod" Phi(n) = 1$, quindi un numero che moltiplicato per $e$ ci dia come resto 1 se diviso per $Phi(n)$.

Per cifrare il messaggio dobbiamo prendere il messaggio $M$, elevarlo per $e$ e dividerlo per $n$ prendendo il resto: $ C = M^e "mod" n $

Per decifrare, riceviamo $C$ lo eleviamo per $d$. Matematicamente stiamo facendo: $ (M^e)^d "mod" n = M^(e d) "mod" n $

Grazie al fatto che abbiamo costruito $e$ e $d$ usando la funzione di Eulero possiamo dire che elevare alla potenza $e$ e poi alla potenza $d$ sono due operazioni che si annullano lasciandoci il messaggio originale $M$.


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
  title: [*Passaggi da eseguire*],
  [
    Prima di tutto generiamo le chiavi
    1. Selezioniamo $p, q$ primi e diversi fra loro
    2. Calcoliamo $n = p dot q$
    3. Calcoliamo $Phi(n) = (p-1)(q-1)$
    4. Selezioniamo un intero $e$ con M.C.D.$(Phi(n), e) = 1; 1 < e < Phi(n)$
    5. Calcoliamo $d$ sapendo che $d dot e "mod" Phi(n) = 1$
    6. Creiamo la chiave pubblica $K U={e,n}$
    7. Creiamo la chiave privata $K R = {d,n}$

    Poi possiamo cifrare un messaggio (un intero)
    - Testo in chiaro $M$ con $M < n$
    - Testo cifrato é dato da $C= M^e "mod" n$

    Per decifrare
    - Dal testo cifrato $C$ otteniamo $M = C^d "mod" n$
  ]
)


#showybox(
  frame: (
    border-color: blue.lighten(60%),
    title-color: blue.lighten(60%),
    body-color: blue.lighten(95%)
  ),
  title-style: (
    color: black,
    weight: "regular",
    align: center,
    boxed-style: (anchor: (y: horizon, x: left))
  ),
  title: [*Esempio di utilizzo*],
  [
    1. Selezioniamo due numeri primi $p=17, q=11$
    2. Calcoliamo $n = p q = 187$
    3. Calcoliamo $Phi(n) = (p-1)(q-1) = 160$
    4. Selezioniamo $e$ tale che é primo e minore rispetto a $Phi(n)=160$, ad esempio $e=7$.
    5. Determiniamo $d$ tale che $d dot e "mod" 160 = 1$ e $d < 160$, in questo caso $d=23$

    Otteniamo come chiavi chiave pubblica ${7, 187}$ e come chiave privata ${23, 187}$
    Vogliamo inviare il numero 88:
    1. Lo cifriamo calcolando $88^7 "mod" 187$ e otteniamo $11$
    2. Per decifrare calcoliamo $11^(23) "mod" 187$ e riotteniamo 88
  ]
)

=== Sicurezza dell'RSA
Esistono 4 diversi modi per attaccare l'algoritmo RSA:
- *Brute Force*: Provare tutte le possibili chiavi private.
- *Mathematical Attacks*: Ci sono diversi approcci possibili, tutti equivalenti per quanto riguarda gli sforzi da fare per fattorizzare il prdotto di due numeri primi.
- *Timing Attacks*: Questi dipendono dal tempo di esecuzione dell'algoritmo di decifratura.
- *Chosen ciphertext attacks*: Sfruttano le proprietá dell'RSA. Non affronteremo questo argomento.

La difesa contro il primo tipo di attacchi é uguale a molti altri algoritmi ovvero usare uno spazio delle chiavi enorme, in questo caso maggiore é il numero di bit di $d$ maggiore sará il tempo necessario a "trovarlo", in questo caso peró visti i calcoli necessari, maggiore é la grandezza della chiave e maggiore sará il tempo necessario per cifrare e decifrare.

==== Il problema della fattorizzazione
Ci sono 3 approcci per attaccare RSA matematicamente:
- Fattorizzare $n$ nei suoi due fattori primi, questo permette di calcolare subito $Phi(n)$ e determinare anche $d$.
- Determinare $Phi(n)$ direttamente senza determinare prima $p, q$, come prima ci permette di calcolare subito $d$
- Determinare direttamente $d$ senza trovare prima $Phi(n)$.

Il problema principale é quello di fattorizzare $n$ nei suoi due fattori primi, infatti determinare $Phi(n)$ é equivalente a fattorizzare $n$. Possiamo quindi vedere i tempi di fattorizzazione di $n$ come "benchmark" della sicurezza di RSA.
Per un $n$ grande con grandi fattori primi, la fattorizzazione é un problema difficile ma non quanto lo era prima.
Nella seguente tabella sono misurati i tempi in MIPS-years ovvero un anno in cui un processore che puó eseguire un milione di istruzioni al secondo processa senza interruzioni.
Il numero di cifre fa riferimento al numero di cifre della chiave.

#align(center, image("/assets/image-46.png", width: 80%))

Col tempo sono stati scoperti diversi algoritmi per la fattorizzazione dei numeri ma in generale, per ora, una chiave nel range di 1024-2048 bits è ritenuta sicura. Inoltre i ricercatori hanno dato qualche restrizione aggiuntiva per rendere meno semplice la fattorizzazione di $n$:
- $p$ e $q$ devono avere una lunghezza simile ma non troppo piccoli.
- Sia $(p-1)$ che $(q-1)$ devono avere un fattore primo grande, questo perché se hanno solo fattori primi piccoli possono essere ricavati subito da un algoritmo chiamato *Pollard's $p-1$*
- Il M.C.D.$(p-1, q-1)$ deve essere piccolo, questo perché se é grande significa che genera meno chiavi possibili.

Inoltre é stato dimostrato (*Michael Wiener*) che se $e < n$ e $d < n^(1/4)$ allora $d$ puó essere facilmente determinato.

==== Timing Attacks
Come detto prima si basano sul tempo di esecuzione dell'algoritmo di decifratura, *Paul Kocher* ha dimostrato che in alcuni casi é possibile determinare la chiave privata solamente tenendo traccia di quanto tempo ci mette il computer a decifrare il messaggio.

Per usare questo attacco si indovina la chiave bit a bit, procedendo da sinistra verso destra:
- L'attaccante crea un messaggio cifrato e lo invia, questo messaggio é costruito in modo tale che quando il computer arriva al bit che lui sta cercando di indovinare, se quel bit é 1 allora l'operazione sará lentissima mentre se é 0 allora sará normale.
- Si cronometra il tempo totale che impiega il computer a rispondere
- Se il tempo é stato estremamente lungo allora puó impostare quel bit a 1 altrimenti a 0. Si passa al bit successivo.

Esistono tre difese contro questo tipo di attacchi:
- *Constant Exponentiation Time*: Si forza il computer ad impiegare sempre lo stesso tempo massimo per ogni bit, ovviamente andiamo a peggiorare le prestazioni.
- *Random Delay*: Si aggiunge del "rumore" facendo fare delle piccole pause casuali al processore, il difetto é che l'hacker puó inviare il messaggio tante volte e fare una media dei tempi di risposta rilevando i tempi reali.
- *Blinding*: Consiste nel modificare il messaggio ricevuto per imbrogliare il cronometro dell'hacker.

In alcuni RSA é implementato il Blinding nel seguente modo:
1. Genera un segreto casuale $r$ tra $0$ e $n-1$.
2. Calcola $C'=C(r^e) "mod" n$ dove $e$ é l'esponente pubblico.
3. Calcola $M'=(C')^d "mod" n$ come il classico RSA
4. Calcola $M=M' dot r^(-1) "mod" n$

Ovvero:
1. Viene scelto un numero casuale
2. Lo cifriamo e moltiplichiamo per il messaggio ricevuto.
3. Decifriamo questo valore ottenuto andando a imbrogliare il cronometro dell'hacker
4. Moltiplichiamo il valore ottenuto con l'inverso del numero inventato prima per ottenere il messaggio originale.

Questa operazione di blinding diminuisce le performance di un 2-10%.

== Diffie-Hellman
L'algoritmo permette a due utenti di scambiarsi una chiave segreta in modo sicuro.

Vengono scelti due elementi pubblici:
- Un numero primo $q$
- $alpha < q$ e $alpha$ deve essere una radice primitiva di $q$
Una radice primitiva modulo $n$ é un numero $g$ che elevato a potenza riesce a generare da solo tutti i numeri possibili di quel modulo. Ad esempio se $n=7$ allora 3 é una radice primitiva infatti elevando 3 a tutte le potenze da 1 a 6 e calcolando il resto della divisione con 7 otteniamo tutti i numeri da 1 a 6.
Non tutti i numeri possiedono radici primitive, cioé avviene solo per $2,4,p^k$ o $2p^k$ dove $p$ é un primo dispari.
- L'utente A genera le sue chiavi, prima seleziona una chiave privata $X_A$ t.c. $X_A < q$ e poi calcola la chiave pubblica $Y_A = alpha^(X_A) "mod" q$
- L'utente B genera le sue chiavi nello stesso modo quindi $X_B < q$ e $Y_B=alpha^(X_B) "mod" q$
- Devono scambiarsi la loro chiave pubblica e poi possono calcolare la chiave in comune:
  - A la puó calcolare eseguendo $K=(Y_B)^(X_A) "mod" q$
  - B la puó calcolare eseguendo $K=(Y_A)^(X_B) "mod" q$
- Questa chiave K é il valore che si sono "scambiati" e che possono usare per le loro future comunicazioni.

=== Sicurezza del Diffie-Hellman
Prendiamo questo esempio dove un algoritmo utilizza Diffie-Hellman per scambiare le chiavi:

#align(center, image("/assets/image-47.png", width: 80%))

Questo tipo di comunicazione non é sicura contro attacchi del tipo *man-in-the-middle*. Alice e Bob devono scambiarsi la chiave e Darth é l'avversario:
1. Darth prepara l'attacco generando due chiavi private casuali $X_(D 1)$ e $X_(D 2)$ e genera anche le corrispettive chiavi pubbliche.
2. Alice trasmette la sua chiave pubblica a Bob.
3. Darth intercetta $Y_A$ e trasmette $Y_(D 1)$ a Bob, inoltre calcola anche $K 2=(Y_A)^(X_(D 2)) "mod" q$
4. Bob riceve $Y_(D 1)$ e calcola $K 1 = (Y_(D 1))^(X_B) "mod" q$
5. Bob trasmette $Y_B$
6. Darth intercetta $Y_B$ e trasmette $Y_(D e)$ ad Alice, inoltre calcola anche $K 1=(Y_B)^(X_(D 1)) "mod" q$
7. Alice riceve $Y_(D 2)$ e calcola $K 2 = (Y_(D 2))^(X_A) "mod" q$

A questo punto Alice e Bob sono convinti di essersi scambiati le chiavi ma invece tutte le loro future comunicazioni saranno lette da Darth che potrá anche modificare i messaggi.
Questo algoritmo é vulnerabile a questo tipo di attacchi perché non c'é autenticazione del mittente, é possibile quindi risolvere questi problemi utilizzando firme digitali o certificati a chiave pubblica.