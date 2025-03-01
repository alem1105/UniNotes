Internet é quindi composto da più reti, precisamente, redi di accesso e la backbone.

- **Rete di Accesso** - Sono reti che appunto ci forniscono accesso alla backbone, consideriamo rete di accesso il collegamento da un sistema fino al primo router che chiamiamo **edge router**

![[Pasted image 20250301172318.png]]

I collegamenti in blu sono quindi reti di accesso.

- **Backbone Internet** - È invece il resto del collegamento, quindi:

![[Pasted image 20250301172508.png]]

# Struttura di Internet

Ha una struttura gerarchica basata su vari livelli di ISP, al centro troviamo gli **ISP di livello 1** che sono quelli che si occupano di comunicazione a livello nazionale / internazionale, ad esempio passando anche cavi sottomarini per mettere in comunicazione i vari continenti.

Poi troviamo gli **ISP di livello 2** che sono nazionali o distrettuali, questi sono clienti degli ISP di livello 1 dato che gli forniscono connettività sul resto della rete.

Se due ISP di livello 2 sono collegati direttamente fra loro allora sono detti **pari grado** (peer).

Infine troviamo gli **IPS di livello 3** e quelli **locali**, questo sono i più vicini ai nostri terminali e, seguendo la gerarchia, sono quindi clienti degli ISP di secondo e primo livello.

Un pacchetto quindi deve passare fra molte reti prima di arrivare a destinazione e scegliere su che percorso mandarlo è uno dei problemi principali, questo prende il nome di **routing**.

![[Pasted image 20250301175233.png]]

# Capacità e Prestazioni delle Reti

Il concetto di velocità di una rete comprende molti fattori, come:
- Ampiezza di banda
- bitrate
- trhoughput
- ritardi
- perdita di pacchetti

## Bandwidth e bit rate

Con il termine **ampiezza di banda** si intendono due concetti diversi ma legati fra loro:

- **Caratterizzazione del canale o sistema trasmissivo** - Si misura in hertz e rappresenta la larghezza dell'intervallo di frequenze utilizzate nel sistema trasmissivo, ovvero quelle frequenze che un sistema trasmette senza danneggiare in modo irrecuperabile il segnale. Quindi maggiore ampiezza significa maggiore quantità di dati che può essere trasportata.
- **Caratterizzazione di un collegamento** - Si misura in bit al secondo (bps) ed è la quantità di bit al secondo che un link garantisce di trasmettere.

Il bit rate dipende quindi sia dalla banda che dalla tecnica di trasmissione o modulazione digitale utilizzata e quindi è proporzionale alla banda in hertz.

Quindi il bit rate ci fornisce un'indicazione sulla capacità della rete di trasferire dati.

## Throughput

Il throughput invece ci indica quanto velocemente riusciamo a inviare i dati, questo però non é un'indicazione basata sulla tecnologia utilizzata come il bitrate o larghezza di banda, è quanto riusciamo ad inviare **realmente** in quel momento.

Ci indica quindi il numero di bit al secondo che passano attraverso un punto della rete. In sintesi:
- Un link può avere $B$ bps di bitrate ma in quel momento possiamo inviare soltanto $T$ bps con $T\leq B$.

Quindi il **rate** è una misura potenziale mentre il **throughput** è una misura effettiva.

> [!info] Collo di Bottiglia
> Un pacchetto passa in molti nodi con link che hanno throughput diversi, questo significa che la velocità tra il nodo iniziale e quello di destinazione è data dal minore throughput dei link.
> 
> ![[Pasted image 20250301181125.png]]
> 
> Nel primo caso avremo $R_{S}$ mentre nel secondo $R_{C}$
> 

In Internet molto spesso accade che un pacchetto viaggia da una rete di accesso alla dorsale e poi in un'altra rete di accesso, la dorsale è quella con throughput più alto e quindi di solito si considera il minore soltanto fra le due reti di accesso.

### Throughput nei link condivisi

Dato che un link fra due router non è sempre dedicato ad un solo flusso dati, il rate del link fra i due router è condiviso fra tutti i flussi, esempio:

![[Pasted image 20250301182307.png]]

Se abbiamo 600kbps significa che ogni flusso arriva massimo a 200kbps

# Latenze

La latenza è il tempo che un pacchetto impiega ad arrivare a destinazione dal momento in cui il primo bit parte dalla sorgente.

Nella commutazione di pacchetto, i pacchetti si accodano nei buffer dei router, se il tasso di arrivo dei pacchetti sul collegamento è più grande del rate del collegamento allora i pacchetti si accodano in attesa del loro turno e quindi si genera ritardo. Inoltre se nel buffer non c'è più spazio per accogliere altri pacchetti allora questi verranno scartati.

In tutto ci sono 4 cause di ritardo per i pacchetti:

1) **Processing Delay** - Ogni pacchetto va processato per capire cosa farci, quindi usiamo del tempo per controllare errori sui bit, determinare su quale canale instradarlo e anche il tempo che passa dalla ricezione sulla porta input fino alla consegna sulla porta di output.
2) **Queueing Delay** - È l'attesa che si crea quando un pacchetto si trova nella coda prima di essere trasmesso, questo varia in base al livello di congestione del router e anche da pacchetto a pacchetto.

![[Pasted image 20250301182843.png]]

3) **Transmission Delay** - Tempo richiesto per immettere tutti i bit del pacchetto sul collegamento, se ad esempio il primo bit viene trasmesso al tempo $t_{1}$ e l'ultimo bit al tempo $t_{2}$ allora il ritardo di trasmissione è $t_{2} - t_{1}$. Possiamo calcolare anche come:

$$
\begin{align*}
\frac{L}{R} \text{ con } &L = \text{Lunghezza in bit del pacchetto} \\
&R = \text{Rate del collegamento in bps}
\end{align*}
$$

![[Pasted image 20250301183125.png]]

4) **Propagation Delay** - Tempo che impiega un bit per propagarsi sul collegamento ovvero viaggiare dal punto $A$ al punto $B$. Possiamo calcolarlo come:

$$
\begin{align*}
\frac{d}{s} \text{ con }  &s=\text{velocità di propagazione (di solito la luce) } 2\cdot 10^8 \text{ m/sec} \\
&d = \text{lunghezza del collegamento fisico}
\end{align*}
$$

![[Pasted image 20250301183355.png]]

> [!info] Differenza tra ritardo di trasmissione e propagazione
> 
> ![[actually.png|150]]
> 
> La trasmissione è il tempo necessario a un nodo per far uscire il pacchetto quindi varia in base al rate del link e alla lunghezza del pacchetto.
> 
> La propagazione invece indica il tempo che impiega un bit per percorrere il percorso una volta fuori dal nodo, varia quindi in base alla distanza.
> 

## Ritardo di Nodo

Il ritardo è dato quindi da:

$$
d_{nodal} = d_{proc}+d_{queue}+d_{trans}+d_{prop}
$$

Dove:
- $\color{orange}d_{trans}$ - Ritardo di trasmissione che è significativo sui collegamenti a bassa velocità
- $\color{orange}d_{prop}$ - Ritardo di propagazione che va da pochi microsecondi a centinaia di millisecondi
- $\color{orange}d_{proc}$ - Ritardo di elaborazione, in genere pochi microsecondi o meno
- $\color{orange}d_{queue}$ - Ritardo di accodamento che dipende dalla congestione della rete in quel momento

## Ritardo di Accodamento

Abbiamo detto che questo può variare da pacchetto a pacchetto, anche perché non é detto che tutti seguono la stessa strada, su un percorso potrebbe crearsi del traffico in qualsiasi momento, possiamo quindi soltanto fare delle stime.

Indichiamo con:
- $R$ = Rate di trasmissione in bps
- $L$ = Lunghezza del pacchetto in bit
- $a$ = tasso medio di arrivo dei pacchetti pkt/s

L'intensità del traffico la indichiamo con:
$$
\frac{La}{R} \rightarrow \begin{cases}
\approx 0: \text{Poco ritardo} \\
\approx 1: \text{Ritardo consistente} \\
> 1: \text{Più lavoro di quello gestibile, tempo medio } \infty
\end{cases}
$$

![[photo_2025-03-01_19-07-10.jpg|500]]

Più l'intensità si avvicina a 1 più rapidamente cresce il ritardo medio di accodamento.

## Perdita di pacchetti (packet loss)

Se un pacchetto trova il buffer (coda) di un router pieno allora il pacchetto viene scartato e quindi perso, se questo accada o il pacchetto viene ritrasmesso dal nodo precedente oppure non viene più trasmesso

## Ritardi e percorsi in Internet
Cosa significano questi valori nel vero Internet? Utilizziamo il comando `traceroute o tracert` per misurare il ritardo di una comunicazione dalla sorgente alla destinazione fornendo dettagli su tutti i router che attraversiamo. Il mittente invia dei pacchetti e ogni router risponderà al mittente, quest'ultimo calcola l'intervallo di tempo tra invio e risposta.

L'output del comando è composto da varie colonne:
1) Numero del router nel percorso
2) Nome del router
3) Indirizzo del router
4) Tempo andata e ritorno 1 pacchetto
5) Tempo andata e ritorno 2 pacchetto
6) Tempo andata e ritorno 3 pacchetto

Se non riceviamo risposte o se il router nasconde le sue informazioni visualizziamo degli \* inoltre dato che il ritardo di accodamento varia in base alla congestione della rete può accadere che per un router $n$ abbiamo un ritardo $T$ e per il router $n+1$ abbiamo un ritardo $T_{1}< T$.

### Prodotto rate * ritardo

Ci indica il numero massimo di bit che possono riempire il collegamento, ad esempio se abbiamo un link da 1 bps e un ritardo di 5 secondi avremo non più di 5 bit contemporaneamente sul link, infatti: 

![[Pasted image 20250301191854.png]]

Il primo bit entra dopo un secondo e dopo 5 secondi sarà arrivato alla fine, in questi 5 secondi sono entrati altri bit tutti a differenza di un secondo per via del bitrate e si saranno mossi tutti ogni secondo.

Possiamo pensare al link come un tubo, la sezione trasversale indica il rate e la lunghezza il ritardo, possiamo quindi vedere il volume come prodotto tra rate e ritardo:

![[Pasted image 20250301192035.png]]

