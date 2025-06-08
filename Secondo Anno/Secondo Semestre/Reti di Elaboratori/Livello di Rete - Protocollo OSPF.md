Con questo protocollo non usiamo algoritmi con **distance vector** ma con **link state**.

Con il link state abbiamo:
- Lo stato di un link - indica il costo associato a quel link
- Se il costo è $\infty$ allora il collegamento non esiste o è interrotto
- Ogni nodo deve conoscere i costi di tutti i collegamenti della rete
- Il link state database mantiene la mappa completa di tutta la rete

# Link State Database (LSDB)
È il database che mantiene la mappa di tutta la rete, questo deve essere unico e ogni nodo deve possederne una copia. Lo rappresentiamo tramite una matrice:

![[Pasted image 20250505154720.png|400]]

Come fanno i nodi a costruire un loro LSDB?
- Ogni nodo conosce i suoi vicini e il costo dei collegamenti per raggiungerli
	- Per fare questo manda un messaggio di `hello` a tutti i vicini e tramite le risposte costruisce queste informazioni
- La lista formata dalle coppie `(vicino, costo)` viene chiamata **LS packet (LSP)**.
- Ogni nodo esegue il **flooding** degli LSP:
	- Invia a tutti i vicini il proprio LSP.
	- Quando riceve LS packet da un vicino, se è nuovo allora lo inoltra anche ai suoi vicini, tranne a chi glielo ha mandato.
	- In questo modo aggiorniamo tutta la rete

Una volta terminato questo processo abbiamo costruito l'LSDB.

Per trovare i percorsi minimi, ogni nodo deve applicare in modo indipendente l'algoritmo di Dijkstra usando come radice se stesso. L'algoritmo è iterativo e viene eseguito per un numero di volte pari al numero di nodi presenti nella rete.

Usiamo la seguente notazione:
- $N$: insieme dei nodi della rete
- $c(x,y):$ costo del collegamento da x a y
- $D(v):$ costo del cammino minimo dal nodo origine alla destinazione v nell'iterazione corrente
- $p(v):$ immediato predecessore di v lungo il cammino
- $N':$ sottoinsieme di nodi per cui il cammino a costo minimo dall'origine è definitivamente noto

Prima di applicare l'algoritmo partiamo da una situazione come questa:

```
N' = {r}
for all nodi n:
	se n è adiacente a r
		allora D(n) = c(r,n)
	altrimenti D(n) = inf
```

Inizializziamo quindi il sottoinsieme con i nodi adiacenti alla radice, poi possiamo far partire il ciclo:

```
determina un n non in N' tale che D(n) sia minimo
aggiungi n a N'
per ogni nodo a adiacente a n e non in N' aggiorna D(a):
	D(a) = min(D(a), D(n) + c(n, a))
Termina quando N' = N
```

Possiamo applicare Dijkstra per risolvere esercizi in modo "grafico":

![[Pasted image 20250505161401.png]]

Quindi ad ogni step segniamo i costi per ogni nodo e al successivo aggiungiamo quello di costo minimo.

Questa procedura, in questo caso, ci fa ottenere:

![[Pasted image 20250505161615.png|400]]

Perché appunto u può raggiungere soltanto v e x, tutti i restanti nodi li raggiunge tramite x.

# Confronto tra algoritmi SV e DV

## Complessità dei messaggi
Con un algoritmo LS se abbiano `n` nodi e `E` collegamenti invieremo $O(nE)$ messaggi mentre con un algoritmo DV dobbiamo scambiare messaggi soltanto fra nodi adiacenti

## Velocità di convergenza
Con algoritmi LS abbiamo una complessità di $O(n^2)$ mentre con DV abbiamo una convergenza più lenta ma:
- può presentare cicli d'instradamento
- può presentare il problema del conteggio all'infinito (lo scambio di aggiornamenti infinito)

## Robustezza
In generale l'OSPF è più robusto di RIP infatti cosa succede se un router funziona male?
- Con LS se un router ad esempio comunica a tutti un costo sbagliato per uno dei suoi collegamenti non compromette l'intera rete dato che ogni nodo calcola la tabella localmente
- Con DV invece se un router comunica cammini errati significa che questa informazioni si diffonde su tutta la rete portando a calcoli errati.

# Protocollo OSPF
Un protocollo ovviamente non è solo un algoritmo ma anche che tipo di messaggi scambia e le sue interazioni con altri protocolli.

OSPF sta per Open Shortest Path First. Open perchè le specifiche del protocollo sono pubbliche.

Questo è un protocollo a stato del collegamento:
- Utilizza il **flooding** di informazioni di stato del collegamento.
- Utilizza Dijkstra per la determinazione del percorso a costo minimo.

Per flooding intendiamo:
- Ogni volta che si verifica un cambiamento il router manda l'informazione a tutti gli altri router, chi la riceve la invia ai suoi vicini e così via. Non si invia l'informazione ricevuta a chi ce l'ha inviata.
- Invia periodicamente messaggi OSPF all'intero sistema.
- I messaggi OSPF vengono trasportati in datagrammi IP usando il numero di protocollo 89 nel campo IP protocol.

Ci sono diversi tipi di messaggi OSPF:
- Hello - Usato dai router per annunciare la loro esistenza ai vicini
- Database Description - Risposta ad hello, di solito per inviare il LSDB ai nuovi router
- Link State Request - Usato per richiedere specifiche informazioni su un collegamento
- Link State Update - Messaggio principale usato da OSPF per la costruzione del LSDB
- Link State ACK - Riscontro al link state update (offre più affidabilità)

