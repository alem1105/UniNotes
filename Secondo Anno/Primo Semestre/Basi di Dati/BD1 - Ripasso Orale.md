Praticamente quello che sta nelle dispense ma ho bisogno di scrivere le cose per studiarle, poi boh aggiungerò qualcosa sulle dimostrazioni.

---

# 3NF

Nelle basi di dati voglia evitare 3 situazioni:
- Anomalie di Inserimento: Vogliamo inserire un dato ma per farlo dobbiamo inserirne anche altri
- Anomalie di Cancellazione: Come l'inserimento quindi vogliamo cancellare un dato ma per farlo ne perdiamo anche altri
- Anomalie di Aggiornamento: Se vogliamo aggiornare un dato dobbiamo farlo in ogni tupla dove compare
- Ridondanza nella rappresentazione dei dati

**Definizione 1**: Dato uno schema di relazione $R$, una **dipendenza funzionale** su $R$ è una coppia ordinati di sottoinsiemi non vuoti $X,Y$ di $R$ e viene denotata con $X\to Y$.

Si dice che un'istanza $r$ di $R$ soddisfa la dipendenza funzionale $X\to Y$ se per ogni coppia di tuple $t_{1},t_{2}$ si ha che **se** $t_{1}[X]=t_{2}[X]$ **allora** $t_{1}[Y]=t_{2}[Y]$.

Se $F$ è un insieme di dipendenze funzionali su $R$ ed $r$ è un'istanza di $R$ che soddisfa tutte le dipendenze di $F$, diciamo che $r$ è un'istanza legale di $R$.

La **chiusura** di $F$ denotata con $F^+$ è l'insieme di dipendenze funzionali che sono soddisfatte da ogni istanza legale di $R$.

Banalmente si ha che $F\subseteq F^+$.

**Definizione 2**: Dato uno schema di relazione $R$, un insieme di dipendenze funzionali $F$ su $R$ e un sottoinsieme $K$ di $R$ diciamo che $K$ è una **chiave** per $R$ se:
- $K\to R\in F^+$
- Per ogni sottoinsieme proprio $K'$ di $K$ si ha che $K'\to R\not\in F^+$ (quindi non devono esserci sottoinsiemi che sono chiave a loro volta)

> [!info] Info su 3NF
> Uno schema di relazione in cui non ci sono attributi che dipendono parzialmente né transitivamente dalla chiave è detto in terza forma normale.

Più formalmente:

**Definizione 3**: Dati uno schema di relazione $R$ e un insieme di dipendenze funzionali $F$ su $R$ diciamo che:
- Un attributo $A$ di $R$ è **primo** se appartiene ad una chiave di $R$
- Un sottoinsieme $X$ di $R$ è una **superchiave** se contiene una chiave di $R$

**Definizione 4:** Siano $R$ uno schema di relazione e $F$ un insieme di dipendenze funzionali su $R$:
- $X\to A\in F^+$ tale che $A\not\in X$ è una **dipendenza parziale** su $R$ se $A$ non è primo ed $X$ è contenuto **propriamente** in una chiave di $R$.
  In modo discorsivo non abbiamo dipendenze parziali se gli attributi che non appartengono alla chiave devono dipendere dall'intera chiave
  ![[Pasted image 20250118224219.png]]
  
- $X\to A\in F^+$ tale che $A\not\in X$ è una **dipendenza transitiva** su $R$ se $A$ non è primo e **per ogni chiave** $K$ di $R$ si ha che $X$ non è contenuto propriamente in $K$ e $K-X\neq \emptyset$.
  Non abbiamo dipendenze transitive se gli attributi che non appartengono alla chiave, dipendono direttamente dalla chiave e non da altri attributi non chiave.
  
  ![[Pasted image 20250118224228.png]]

**Definizione 5**: Siano $R$ uno schema di relazione e $F$ un insieme di dipendenze funzionali su $R$. $R$ **è in 3NF** se per ogni dipendenza funzionale $X\to A\in F^+$ tale che $A\not\in X$ si ha che:
- $A$ è primo, oppure
- $X$ è una superchiave.

**Teorema 1**: Siano $R$ uno schema di relazione e $F$ un insieme di dipendenze funzionali su $R$. Uno schema $R$ è in 3NF se e solo se non esistono né dipendenze parziali né dipendenze transitive in $R$.

_Dimostrazione_

- Parte SOLO SE: Se non abbiamo dipendenze parziali e transitive, tutte le nostre dipendenze $X\to A$ avranno $X$ chiave o che ne contiene una e quindi verificano sempre la condizione vista prima $X$ superchiave.

- Parte SE: Lo schema $R$ è in 3NF quindi $\forall X\to A\in F^+, A\not\in X$ abbiamo che $A$ primo oppure $X$ superchiave, quindi ci sono diversi casi:

1) Se $A$ è primo viene a mancare la condizione per avere dipendenze parziali e transitive, quindi abbiamo terminato
2) Se $A$ non è primo allora $X$ è superchiave per l'altra condizione, in quanto tale può contenere una chiave ma non essere contenuto propriamente e quindi non possiamo avere dipendenze parziali (dove la chiave deve contenere propriamente X).
   Inoltre essendo superchiave non possono verificarsi, per ogni chiave, le condizioni di dipendenza transitive dato che almeno una è contenuta in $X$.

Abbiamo quindi dimostrato che le due condizioni di 3NF sono equivalenti.

## Decomposizioni che preservano le dipendenze.
Quando si decompone uno schema è importante che questa decomposizioni preservi tutte le dipendenze presenti in $F^+$ ovvero la chiusura di $F$. Come si calcola questo insieme? Introduciamo un altro insieme $F^A$.

Sia $R$ uno schema di relazione e $F$ un insieme di dipendenze funzionali, sia $F^A$ l'insieme di dipendenze funzionali definito nel modo seguente:
- se $f\in F$ allora $f\in F^A$
- se $Y\subseteq X \subseteq R$ allora $X\to Y\in F^A$ **riflessivitá**
- se $X\to Y\in F^A$ allora $XZ\to YZ\in F^A$ per ogni $Z\subseteq R$ **aumento**
- se $X\to Y\in F^A$ e $Y\to Z\in F^A$ allora $X\to Z\in F^A$ **transitività**

Dimostreremo che $F^+=F^A$ ovvero che la chiusura di insieme di dipendenze può essere ottenuta applicando ricorsivamente gli  assiomi di Armstrong, sono utili inoltre altre regole utile che ci permettono di ricavare da delle dipendenze in $F^A$ altre dipendenze di $F^A$:
- se $X\to Y\in F^A$ e $X\to Z\in F^A$ allora $X\to YZ\in F^A$ **unione**
- se $X\to Y\in F^A$ e $Z\subseteq Y$ allora $X\to Z\in F^A$ **decomposizione**
- se $X\to Y\in F^A$ e $WY\to Z\in F^A$ allora $WX\to Z\in F^A$ **pseudotransitività**

**Teorema 2**: Sia $F$ un insieme di dipendenze funzionali, valgono le 3 regole viste sopra.

_Dimostrazione_

- Unione: Se $X\to Y\in F^A$, per l'aumento si ha che $X\to XY\in F^A$. Analogamente se $X\to Z\in F^A$ sempre per aumento si ha che $XY\to YZ\in F^A$ quindi dato che abbiamo $X\to XY;XY\to YZ\in F^A$ per transitività possiamo dire che $X\to YZ\in F^A$.

- Decomposizione: Se $Z\subseteq Y$ allora per riflessività si ha che $Y\to Z\in F^A$ quindi poiché $X\to Y\in F^A$ e $Y\to Z\in F^A$ per transitività abbiamo che $X\to Z\in F^A$.

- Pseudotransitività: Se $X\to Y\in F^A$, per l'aumento possiamo dire che $WX\to WY\in F^A$ quindi poiché $WX\to WY\in F^A$ e $WY\to Z\in F^A$ per transitività abbiamo che $WX\to Z\in F^A$.

**Definizione 6**: Siano $R$ uno schema di relazione, $F$ un insieme di dipendenze funzionali su $R$ e $X$ un sottoinsieme di $R$. La chiusura di $X$ rispetto ad $F$ denotata con $X^+_{F}$ è definito come $X^+_{F}=\{ A:X\to A\in F^A \}$

**Lemma 1**: Siano $R$ uno schema di relazione ed $F$ un insieme di dipendenze funzionali su $R$. Si ha che $X\to Y\in F^A$ se e solo se $Y\subseteq X^+$.

_Dimostrazione_: Sia $Y=A_{1},A_{2},\dots,A_{n}$.

- Parte SE: Poiché $X\to Y\in F^A$, per la decomposizione possiamo dire che $\forall i=1,\dots ,n$ si ha che $X\to A_{i}\in F^A$ e questo significa che $A_{i}\in X_+$. Dove $A_{i}$ per ogni $i$ sono gli attributi presenti in $Y$ e quindi $Y\subseteq X^+$.

- Parte SOLO SE: Dato che $Y\subseteq X^+$, per ogni $i=1,\dots,n$ si ha che $X\to A_{i}\in F^A$ pertanto per l'unione $X\to Y\in F^A$.

**Teorema 3**: Siano $R$ uno schema di relazione ed $F$ un insieme di dipendenze funzionali su $R$ si ha $F^+=F^A$.

_Dimostrazione_

- Dimostriamo che $F^A \subseteq F^+$

Sia $X\to Y$ una dipendenza funzionale in $F^A$ dimostriamo per induzione sul numero $i$ di applicazioni di uno degli assiomi di Armstrong.

_Base Induzione:_ $i=0$ in questo caso $X\to Y\in F$ e quindi banalmente sarà anche in $F^+$

_Induzione_: Per l'ipotesi induttiva, ogni dipendenza funzionale ottenuta a partire da $F$ applicando armstrong un numero di volte minore o uguale a $i-1$ è in $F^+$, per $i$ si presentano 3 casi:

1) $X\to Y$ è stata ottenuta mediante l'assioma della riflessività, in tal caso $Y\subseteq X$. Quindi sia $r$ un'istanza di $R$ e siano $t_{1},t_{2}$ due tuple di $r$ tali che $t_{1}[X]=t_{2}[X]$ allora banalmente si ha anche che $t_{1}[Y]=t_{2}[Y]$.
2) $X\to Y$ è stata ottenuta applicando l'aumento ad una dipendenza $V\to W\in F^A$ tale che $X=VZ$ e $Y=WZ$ per qualche $Z\subseteq R$. Sia $r$ un'istanza legale di $R$ e siano $t_{1}$ e $t_{2}$ due tuple di $r$ tali che $t_{1}[X]=t_{2}[X]$ si avrà anche che $t_{1}[V]=t_{2}[V]$ e $t_{1}[Z]=t_{2}[Z]$. Per ipotesi induttiva $t_{1}[V]=t_{2}[V]$ porta a $t_{1}[W]=t_{2}[W]$ e insieme portano a $t_{1}[Z]=t_{2}[Z]$ e quindi otteniamo che $t_{1}[Y]=t_{2}[Y]$.
3) $X\to Y$ è stata ottenuta applicando la transitività a due dipendenze funzionali $X\to Z,Z\to Y\in F^A$. Sia $r$ un'istanza di $R$ e siano $t_{1},t_{2}$ due tuple di $r$ tali che $t_{1}[X]=t_{2}[X]$ per ipotesi induttiva si ha che $t_{1}[X]=t_{2}[X]\Rightarrow t_{1}[Z]=t_{2}[Z]$ e sempre per ipotesi induttiva $t_{1}[Z]=t_{2}[Z]\Rightarrow t_{1}[Y]=t_{2}[Y]$.

- Dimostriamo che $F^+\subseteq F^A$

Supponiamo per assurdo che esista una dipendenza funzionale $X\to Y\in F^+$ tale che $X\to Y\not\in F^A$. Mostreremo che esiste un'istanza legale di $R$ che non soddisfa $X\to Y$ (contraddice il fatto che $X\to Y\in F^+$).

Consideriamo la seguente istanza $r$:

![[Pasted image 20250125192728.png|250]]

Mostriamo che:

1) $r$ è un'istanza legale di $R$. Sia $V\to W$ una dipendenza funzionale in $F$ e supponiamo per assurdo che non sia soddisfatta da $r$. In tal caso le due tuple devono avere valori uguali su $V$ e diversi per $W$, questo implica che $V\subseteq X^+$ e $W\cap(R-X^+)\neq \emptyset$. Poiché $V\subseteq X^+$, per il lemma 1 si ha che $X\to V\in F^A$ e quindi per transitività si ha che $X\to W\in F^A$ e quindi per il lemma 1 $W\subseteq X^+$ che contraddice quanto detto prima ovvero che $W\cap(R-X^+)\neq \emptyset$.
2) In quanto istanza legale, $r$ soddisfa tutte le dipendenze in $F^+$, in particolare $X\to Y$. Poiché $X\subseteq X^+$ le due tuple di $r$ coincidono sugli attributi $X$ e quindi poiché soddisfa $X\to Y$ devono coincidere anche gli attributi di $Y$, questo implica che $Y\subseteq X^+$ e quindi per il lemma 1 che $X\to Y\in F^A$.

---

Calcolare $F^+$ richiede tempo esponenziale in $F$, più precisamente esponenziale sul numero di attributi in $R$. Per i nostri scopi è sufficiente determinare se una dipendenza $X\to Y$ appartiene ad $F^+$, questo si fa calcolando $X^+$ e verificando se $Y\subseteq X^+$, il calcolo di $X^+$ può essere fatto tramite un algoritmo.

**Algoritmo 1**: Prende come input uno schema $R$, un insieme $F$ di dipendenze su $R$ e un sottoinsieme $X$ di $R$. Come output fornisce la chiusura di $X$ rispetto ad $F$ all'interno della variabile $Z$.

![[Pasted image 20250126110326.png]]

**Teorema 4**: L'algoritmo 1 calcola correttamente la chiusura di un insieme di attributi $X$ rispetto ad un insieme $F$ di dipendenze funzionali.

_Dimostrazione_: Indichiamo con $Z^0$ il valore iniziale di $Z$ ($Z^0=X$) e con $Z^i$ ed $S^i$, $i\geq 1$ i valori di $Z$ ed $S$ dopo l'i-esima esecuzione del ciclo, si vede ad occhio che $Z^i \subseteq Z^{i+1}$, proveremo che esiste $i$ tale che $A\in Z^i$ se e solo se $A\in X^+$.

- Parte SE, mostriamo per induzione su $i$ che $Z^i\subseteq X^+$ per ogni $i$.

_Base Induzione:_ se $i=0$ dato che $Z^0=X$ e $X\subseteq X^+$ si ha che $Z^0\subseteq X^+$.

_Induzione:_ $i>0$, per ipotesi abbiamo che $Z^{i-1}\subseteq X^+$. Sia $A$ un attributo in $Z^i-Z^{i-1}$, significa che lo abbiamo aggiunto all'ultima iterazione e quindi deve esistere una dipendenza $Y\to V\in F$ tale che $Y\subseteq Z^{i-1}$ e $A\in V$. Dato che $Y\subseteq Z^{i-1}$ otteniamo per ipotesi induttiva che $Y\subseteq X^+$ e per il lemma 1 possiamo dire che $X\to Y\in F^A$, inoltre dato che $Y\to V\in F$ possiamo dire per transitività che $X\to V\in F^A$ e quindi per il lemma 1 otteniamo $V\subseteq X^+$, quindi per ogni $A\in Z^i-Z^{i-1}$ si ha $A\in X^+$, e quindi per l'ipotesi induttiva $Z^i\subseteq X^+$.

- Parte SOLO SE: Sia $A$ un attributo in $X^+$ e sia $j$ tale che $S^j=Z^j$ ($Z^j$ è il valore di $Z$ quando l'algoritmo termina). Mostreremo che $A\in Z^j$. Poiché $A\in X^+$ si ha $X\to A\in F^+$ per il teorema 3, pertanto $X\to A$ deve essere soddisfatta da ogni istanza legale di $R$. Consideriamo le seguente istanza $r$:

![[Pasted image 20250126115211.png]]

Mostriamo che è legale, se per assurdo esistesse in $F$ una dipendenza funzionale $V\to W$ non soddisfatta da $r$, si dovrebbe avere $V\subseteq Z^j$ e $W\cap(R-Z^j)\neq \emptyset$ ma in tal caso si avrebbe $S^j\neq Z^j$ (contraddizione, significa che non siamo ancora arrivati all'ultima iterazione, ma prima o poi aggiungeremo $W$). Poiché $r$ è un'istanza legale di $R$ deve soddisfare $X\to A$ che si trova in $F^A$ e per il teorema 3 in $F^+$, ma allora poiché $X=Z^0 \subseteq Z^j$, $A$ deve essere in $Z^ j$.

**Definizione 7** Sia $R$ uno schema di relazione. Una **decomposizione** di $R$ è una famiglia $\rho=\{ R_{1},R_{2},\dots,R_{k} \}$ di sottoinsiemi di $R$ che ricopre $R$ ovvero $\bigcup_{i=1}^k R_{i} =R$.

**Definizione 8**: Siano $F$ e $G$ due insiemi di dipendenze funzionali. $F$ e $G$ sono equivalenti $F\equiv G$ se $F^+=G^+$
