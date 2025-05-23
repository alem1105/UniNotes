# Accesso Multiplo a divisione di codice (CDMA)
> CDMA: Code Division Multiple Access

Con questo protocollo abbiamo un solo canale che occupa tutta la banda e tutte le stazioni possono trasmettere contemporaneamente, per non creare collisioni ogni stazione parlerà con un codice diverso. È come se più persone parlano nella stessa stanza ma ogni coppia parla una lingua diversa, in questo modo chi parla la stessa lingua può comprendersi.

Come si realizza?

Assumiamo di avere 4 stazioni connesse sullo stesso canale:
- I dati spediti sono $d_{1},d_{2},d_{3},d_{4}$
- I codici assegnati $c_{1},c_{2},c_{3},c_{4}$

Ogni stazione moltiplica i propri dati per il proprio codice e trasmette il risultato, quindi nel canale comune otteniamo:

![[Pasted image 20250523170713.png|500]]

## Proprietà dei Codici
- Se moltiplichiamo ogni codice per un altro otteniamo 0
- Se moltiplichiamo ogni codice per se stesso otteniamo il numero delle stazioni (in questo esempio 4)
- Qualsiasi stazione voglia ricevere dati da una delle altre tre stazioni moltiplica i dati ricevuti per il codice del mittente e divide per il numero delle stazioni

Ad esempio se la stazione 2 vuole ricevere i dati della stazione 1:

$$
\begin{align*}
&\frac{[(d_{1}\cdot c_{1}+d_{2}\cdot c_{2}+d_{3}\cdot c_{3}+d_{4}\cdot c_{4})\cdot c_{1}]}{4} \\
=& \frac{[d_{1}\cdot c_{1}\cdot c_{1}+d_{2}\cdot c_{2}\cdot c_{1}+d_{3}\cdot c_{3}\cdot c_{1}+d_{4}\cdot c_{4}\cdot c_{1}]}{4} =\frac{4\cdot d_{1}}{4} = d_{1}
\end{align*}
$$

## Sequenze di Chip
Il CDMA si basa sulla teoria della codifica, ad ogni stazione viene assegnato un codice che è una sequenza di numeri chiamati chip.

Queste sono **sequenze ortogonali**:
- Ogni sequenza è composta da N elementi con N uguale al numero delle stazioni. N inoltre deve essere una potenza di 2.
- Se moltiplichiamo una sequenza per un numero, ogni elemento della sequenza viene moltiplicato per tale numero
- Se moltiplichiamo due sequenze uguali e sommiamo i risultati otteniamo N
- Se moltiplichiamo due sequenze diverse e sommiamo i risultati otteniamo 0
- Sommare due sequenze significa sommare gli elementi corrispondenti

# Rappresentazione dei Dati nel CDMA
La regola per la codifica è:
- Se ci sono dati presenti -> Bit dati +1
- Se non ci sono dati -> Bit dati -1
- Silenzio -> Bit dati 0

_Esempio_

![[Pasted image 20250523174937.png]]

Il bit vale 0 quindi c'è silenzio.

### Segnale digitale creato dalle 4 stazioni
![[Pasted image 20250523175225.png|500]]

Che decodificato:

![[Pasted image 20250523175318.png|500]]

## Generazione sequenze di Chip
Come vengono generate le sequenze di chip?

Si usa una **tabella di Walsh (matrice quadrata)**, in questa tabella ogni riga è una sequenza di chip.

$W_{1}$  indica una sequenza con un solo chip (una riga e una colonna) e può assumere valore +1 o -1, lo scegliamo noi.

Per le successive, conoscendo $W_{N}$ possiamo costruire $W_{2N}$ nel seguente modo:

![[Pasted image 20250523175635.png|500]]

Quindi ad esempio, partendo con $W_{1}=[+1]$:

![[Pasted image 20250523175748.png|500]]

---


> [!info] Protocolli MAC
> Abbiamo visto diversi protocolli MAC:
> - LAN Wired: CSMA / CD
> - LAN Wireless: CSMA / CA
> 
> Se il CSMA è il più efficiente perché si studiano anche Aloha, TDMA o altro? Perché in alcune reti wireless potrebbero esserci delle caratteristiche fisiche che non consentono di usare i protocolli MAC più complessi ed efficienti.

# Bluetooth
È una tecnologia LAN wireless progettata per connettere dispositivi con diverse funzioni (telefoni, notebook, stampanti) e diverse capacità in un raggio di più o meno 10m.

## LAN Bluetooth
Una LAN bluetooth è una rete ad hoc, infatti si forma spontaneamente senza aiuto di alcuna stazione base (access point). Di solito è una rete piccola che permette la connettività di pochi dispositivi.

Queste reti prendono il nome di PAN (Personal Area Network) e sono gestite dallo standard IEEE 802.15 implementato dalla tecnologia Bluetooth.

Usano una banda da 2,4Ghz divisa in 79 canali da 1Mhz ciascuno.

> Le PAN sono concetto più vasto, non sono soltanto reti bluetooth. Le PAN con bluetooth si chiamano Piconet e Scatternet

### Piconet
È una rete composta al massimo da 8 dispositivi dove 1 agisce da stazione primaria (master) e gli altri 7 da secondarie (slave) che si sintonizzano con la prima.

In realtà possono esserci fino a 255 slave ma nella comunicazione con il master possono essercene soltanto 7, quelli che non si trovano nella comunicazione si dicono in stato di **parked**.

Il master può comunque cambiare di stato due dispositivi in modo da poter comunicare con tutti, ovvero spostare un attivo in parked e viceversa.

### Scatternet
La scatternet è una combinazione di Piconet, ovvero una stazione secondaria di una piconet può essere la primaria di un'altra piconet passando quindi i messaggi da una rete all'altra.

## Dispositivi Bluetooth
I dispositivi bluetooth hanno un trasmettitore radio a breve portata, da notare che siccome hanno un'ampiezza di banda a 2.4Ghz potrebbero esserci interferenze con le LAN wireless IEEE 802.11b

## Bluetooth Layers
Il bluetooth inoltre definisce uno stack protocollare diverso da quello del TCP / IP

![[Pasted image 20250523182723.png|500]]

## Protocollo MAC
Bluetooth usa TDMA con slot temporali da $625\mu s$. Le stazioni primarie e secondarie inviano e ricevono dati ma non contemporaneamente (half duplex), inoltre per differenziarsi la primaria usa slot pari mentre la secondaria slot dispari.

_Esempio trasmissione con secondaria singola:_

![[Pasted image 20250523183232.png|500]]

- Per trasmettere un pacchetto impiega circa $366\mu s$, quindi rimane in tempo di guardia per $625-366=259\mu s$ che serve per: turnaround, salto di frequenza e sincronizzazione

Se la comunicazione avviene con più stazioni secondarie, allora la prima usa comunque slot pari ma ad ogni slot specifica chi deve trasmettere nello slot successivo:

![[Pasted image 20250523183527.png|500]]

