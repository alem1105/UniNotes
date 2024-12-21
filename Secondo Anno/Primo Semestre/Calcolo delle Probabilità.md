# Combinatoria


> [!info] Principio Fondamentale della Combinatoria
> Supponiamo di avere 2 esperimenti, il primo ha _n1_ esiti possibili mentre il secondo, **indipendentemente dall'esito del primo** ha _n2_ esiti possibili.
> Allora il numero delle coppie $(a_1,a_2)$ possibili con $a_i$ esito dell'esperimento i-esimo è $n_{1}\cdot n_2$.

_Esempio_

Se lanciamo un dado 2 volte, la prima volta abbiamo 6 esiti possibili mentre al secondo lancio abbiamo comunque 6 esiti possibili, indipendentemente dal risultato del primo.

Quindi in totale $6 \cdot 6 = 36$ esiti.

$$
\#\{(a,b): a = \text{faccia al primo lancio}, b = \text{faccia al secondo lancio}\}
$$

> [!info] Notazione \#
> Il simbolo \# davanti ad un insieme indica la sua cardinalità


_Esempio_

Se abbiamo 140 studenti, in quanti modi possiamo scegliere un rappresentante e un suo vice?
Per scegliere il rappresentante abbiamo 140 modi, per il suo vice abbiamo uno studente in meno quindi 139, in totale quindi $140\cdot 139$ esiti.


> [!info] Principio Fondamentale della Combinatoria (Generale)
> Supponiamo di avere _R_ esperimenti.
> Il primo ha $n_1$ esiti possibili e qualunque sia il suo risultato il secondo avrà sempre $n_2$ esiti.
> Qualunque sia la realizzazione del secondo il terzo avrà sempre $n_3$ esiti possibili e così via.
> Allora il numero delle possibili stringhe $(a_1,a_2,\dots,a_R)$ dove $a_i$ è l'esito dell'esperimento i-esimo è $n_{1}\cdot n_{2} \cdot ... \cdot n_{R}$.

_Esempio_

Abbiamo 120 ragazzi e 20 ragazze, dobbiamo scegliere un rappresentante e un suo vice in modo che siano di sesso diverso.

Nel primo caso abbiamo 140 esiti possibili, ma nel secondo dipende dall'esito del primo, infatti se abbiamo un rappresentante maschio otteniamo $140 \cdot 20$ esiti, mentre se il rappresentante è femmina allora il secondo esperimento ha 120 esiti e quindi $140 \cdot 120$.

**È caduta l'ipotesi, possiamo però dividere il problema in più sottoproblemi**.

Infatti la soluzione che cerchiamo è l'unione di due soluzioni:

$\{(a,b): \text{a rappresentante M., b vice F.}\} \cup \{(a,b): \text{a rappr. F., b vice M}\}$

Il primo ha $120\cdot 20$ esiti mentre il secondo $20 \cdot 120$, quindi in totale abbiamo $120\cdot 20 + 20 \cdot 120$ esiti.

_Esempio_

$\#\{\text{Strighe binarie di lunghezza 5}\}$.

Ad ogni "entrata" ovvero ad ogni carattere della stringa ho sempre 2 possibili input, quindi $2\cdot2\cdot2\cdot2\cdot2 = 2 ^5$.

_Esempio_

Ho un insieme A di _n_ elementi distinti, quanti sono i suoi sottoinsiemi?

Possiamo utilizzare la stessa formula di prima, quindi $2^n$, questo perché è possibile applicare una **bigezione** (una funzione biettiva, ha lo stesso funzionamento di una mappa, è come convertire un elemento in un altro) per indicare ogni sottoinsieme con una stringa binaria.

$$
\begin{align*}
&A = \{a_1,a_2,...,a_{n}\} \\
&B = \{a_1,a_2,a_{4}\}, B\subset A \\
&\text{Indico B come una stringa, se l'elemento è presente 1, 0 altrimenti}\\
&B = (1,1,0,1,...)
\end{align*}
$$

Quindi la nostra bigezione funziona in modo che $a_{i}\in B \leftrightarrow x_{i} = 1$.

_Esempio_

Dobbiamo ordinare:
- 4 libri di matematica
- 3 di chimica
- 2 romanzi

1) In quanti modi possiamo ordinarli sullo scaffale?
   
   Usando il principio fondamentale otteniamo $9!$ esiti possibili.

2) In quanti modi possiamo ordinarli sullo scaffale, mantenendo vicini quelli della stessa categoria?
   
   In questo caso non possiamo utilizzare subito il principio fondamentale, perché una volta messo un libro non conosciamo la sua tipologia e ad un certo punto non sapremo come continuare.
   
   Possiamo però dividere in più sottoproblemi questo caso, prima **ordiniamo le categorie**.
   
   Abbiamo 3 categorie, quindi per ordinarle $3!$ modi possibili, teniamo questo numero da parte.
   
   Poi per ogni categoria vediamo quanti modi abbiamo per ordinarla, quindi matematica $4!$, chimica $3!$ e i romanzi $2!$, mettendo tutto insieme otteniamo $3!\cdot4!\cdot3!\cdot2!$ esiti possibili.


> [!info] Definizione Permutazioni
> Dati $n$ oggetti distinti, le loro permutazioni sono tutti i loro possibili ordinamenti (allineamenti), il numero di questi è $n!$.

> [!info] Dimostrazione
> Per ordinare gli $n$ oggetti scelgo il primo, per fare questo ho $n$ modi, per il secondo ho $n-1$ modi, per il terzo $n-2$ e così via fino a quando non arrivo all'ultimo oggetto che avrà un solo modo per essere ordinato.
> 
> $$
> n! := \left\{\begin{align*}
>&1 \text{ se } n=0 \\
>&1*2*3*\cdots*n \text{ se } n =1,2,3,...\end{align*} \right\}
>$$
>

_Esempio_

Anagrammi, anche senza senso, della parola "Mela".

Come prima dobbiamo trovare le permutazioni di 4 elementi distinti, quindi $4!$.

Se dovessimo trovare gli anagrammi di "Emma"? In questo caso abbiamo due elementi uguali, come si procede?

Proviamo a diversificare le M e ottenere $M_1,M_2$, in questo modo otteniamo $4!$ anagrammi, ma se riportiamo le M come prima avremo delle ripetizioni, ad esempio $EM_1M_2A$ e $EM_2M_1A$.

Quindi avendo 2 elementi uguali, per ogni permutazione otteniamo una sua copia, quindi per toglierle tutte dobbiamo calcolare $\frac{4!}{2!}$ dove $4$ indica il numero di elementi e $2$ quello di elementi uguali.


> [!info] Regola Generale per Permutazioni con elementi uguali
> Dati $n$ elementi con $r$ elementi distinti:
> - 1° elemento appare $n_1$ volte
> - 2° elemento appare $n_2$ volte
> - ...
> - R-esimo elemento appare $n_R$ volte
>   
>   $\#\text{permutazioni}\{\frac{n!}{n_1!,n_2!,...,n_R!}\}$
>   
>   _Esempio con Emma_
>   $\frac{4!}{1!*2!*1!}$ Dato che E=1, M=2, A=1.

_Esempio_

Numero di possibili targhe alfanumeriche di lunghezza 5.
Abbiamo 26 lettere e 10 cifre, quindi per ogni entrate 36 input possibili, dato che sono 5 otteniamo $36^5$.

$\#\{\text{Numero di targhe alfanumeriche con simboli distinti di lunghezza 5}\}$ = $36*35*34*33*32$, in questo caso abbiamo usato il principio fondamentale.

$\#\{\text{Targhe di lunghezza 5 con 3 lettere 2 cifre}\}$
Prima scegliamo come posizionare 3 lettere in 5 posti, questo è dato da $\frac{5!}{3!\cdot2!}$, poi le lettere sono 26 quindi in 3 posizioni abbiamo $26^3$ esiti, mentre per le cifre $10^2$, mettendo tutto insieme otteniamo:

$$
\frac{5!}{3!\cdot2!}\cdot26^3\cdot10^2
$$

_Esempio_

Nella finale di 100m, calcolare le possibili classifiche delle nazioni se non ci sono parimerito, con nazione A=3, B=2, C=1, D=2, E=1, F=1

Utilizziamo la formula per il numero di permutazioni con ripetizioni, quindi con 10 partecipanti abbiamo:

$$
\frac{10!}{3!\cdot2!\cdot2!}
$$

_Esempio_

Riprendiamo un esempio visto prima ma facciamo un'osservazione, scegliamo due rappresentanti in 140 studenti.

$$
\#\{(a,b):a\neq b \text{ studenti}\} = 140\cdot 139
$$

Se utilizziamo le () significa che conta l'ordine, quindi ad esempio la coppia ("Lorenzo", "Cristina") è diversa da ("Cristina", "Lorenzo") ma noi sappiamo che in realtà sono uguali, quindi in questo caso non ci interessa l'ordine, in questo caso per togliere i doppioni ci basta dividere per due.

**Generalizzazione**
Ho un insieme di $n$ elementi distinti, in quanti modi posso scegliere $k$ elementi distinti e non conta l'ordine?

$$
\frac{n(n-1)(n-2)\cdots(n-k+1)}{k!}=\binom{n}{k}
$$

Se invece l'ordine conta utilizziamo il principio fondamentale e quindi non dobbiamo dividere per $k!$. Nella formula vista sopra abbiamo ottenuto il **coefficiente binomiale**.

> [!info] Coefficiente Binomiale
> Dati $0\leq k \leq n$ interi:
> 
> $$
> \binom{n}{n} = \frac{n!}{k!\cdot(n-k)!}
> $$
> 

Questo ha varie proprietà:

- Se $n=0$ allora anche $k=0$ e $\binom{0}{0}=\frac{0!}{0!*0!} = 1$
- $\forall n$ se $k=0$ ottengo $\binom{n}{0}=\frac{n!}{0!*(n-0)!}=1$
- $\binom{n}{k} = \binom{n}{n-k}$

**Triangolo di Tartaglia per i Coefficienti Binomiali**

![[Pasted image 20240925104452.png]]

_Esempio_

Ho 10 studenti, in quanti modi ne posso scegliere 3 se conta l'ordine? E se non conta?

Se conta l'ordine facciamo $10\cdot 9 \cdot 8$, se invece l'ordine non conta utilizziamo il C.B. quindi:

$$
\binom{10}{3}=\frac{10!}{3!\cdot 7!}
$$

_Esempio_

Ho 10 informatici, 5 segretari e 20 operai, devo scegliere un gruppo di rappresentanti composto da 3 inf. 2 seg. e 6 op., in quanti modi posso farlo?

$$
\frac{10!}{3!\cdot 7!}\cdot \frac{5!}{2!\cdot 3!}\cdot \frac{20!}{6!\cdot 14!}
$$

_Esempio_

In un gruppo da 10 amici devo formare 2 squadre, devo assegnare 5 maglie rosse e 5 maglie blu, in quanti modi posso farlo?

$$
\binom{10}{5}=\frac{10!}{5!\cdot 5!}
$$

Infatti le combinazione per assegnare una maglietta sono uguali per entrambe le squadre.

_Esempio_

Cambiando l'esempio di prima, se voglio formare due squadre scegliendo mano mano ogni membro, in quanti modi posso farlo?

$$
\binom{10}{5} \cdot \frac{1}{2}
$$

Vediamo due esempi utili per capire come si svolge.

_Esempio 1_

Ho 6 studenti e devo dividerli in 2 gruppi, uno da 4 e uno da 2.
In questo caso mi basta calcolare i modi di un gruppo, quindi:

$$
\binom{6}{4} \ \ oppure \ \ \binom{6}{2}
$$

Infatti una volta scelto un gruppo l'altro è già formato.
La situazione cambia se i due gruppi hanno la stessa dimensione.

_Esempio 2_

Dividiamo in 2 gruppi da 3 persone.
Se ne scelgo solo 3 per un gruppo, avrò delle ripetizioni, infatti se ad esempio ho come persone A,B,C,D,E,F e scelgo nel primo {A, B, C} nel secondo avrò {D, E, F} ma se come primo gruppo scelgo {D, E, F} come secondo ottengo {A, B, C}, ho ottenuto una ripetizione.

Per eliminarle:

$$
\binom{6}{3}\cdot\frac{1}{2}
$$

_Esempio_

5 studenti vogliono organizzare una festa e si dividono i ruoli:
- C1) Pulire il locale - 2 persone
- C2) Comprare bibite - 2 persone
- C3) Pubblicizzare la festa - 1 persona

Per risolvere scelgo gli studenti per C1, dai rimanenti per C2 e dai rimanenti per C3:

$$
\binom{5}{2}\cdot \binom{3}{2} \cdot \binom{1}{1}
$$


> [!info] Osservazione
> Svolgendo i calcoli dei coefficienti binomiali visti prima otteniamo:
> $$
> \frac{5!}{2!\cdot 2! \cdot 1!}
> $$
 Che è la stessa formula che utilizziamo per gli anagrammi, infatti possiamo assegnare ad ogni posizione uno studente e ad ogni studente il numero dell'incarico, in questo modo dobbiamo soltanto calcolare gli anagrammi della stringa "13221" (qualsiasi altra combinazione va bene).

**Generalizzazione**
Se abbiamo $n$ oggetti distinti che vogliamo ripartire in $r$ scatole $s_1,s_2,...,s_r$ in modo che $\forall i$ che vanno da $1$ a $r$ nella scatola $s_i$ inserisco l'oggetto $n_i$ dove:

$$
n_1+n_2+...+n_r=n
$$

Quante sono le ripartizioni possibili?

$$
\frac{n!}{n_{1}!\cdot n_{2}! \cdot ... \cdot n_{r}!} =: \binom{n}{n_1,n_2,...,n_r}
$$

E prende il nome di **Coefficiente Multinomiale**.
Quindi se prendiamo l'esempio di prima rappresentando il gruppo che svolge $c_i$ otteniamo $n_{1}=2, n_{2}=2, n_{3}=1, R=3$.

Perché si calcola in questo modo?
**Applichiamo il principio fondamentale della combinatoria**:

1) Scelgo $n_1$ oggetti distinti da mettere in $s_1$.
   Ho $\binom{n}{n_1}$ modi

2) Ne scelgo $n_2$ da mettere in $s_2$ dai rimanenti.
   Ho $\binom{n - n_1}{n_2}$ modi

3) Per $n_3$ ottengo $\binom{n-n_1-n_2}{n_3}$ modi

Quindi le ripartizioni totali sono:

![[Pasted image 20240925224536.png]]

# Probabilità
Consideriamo un esperimento (fenomeno con vari esiti) e chiamiamo **spazio campionario (S)** l'insieme dei possibili esiti dell'esperimento.

_Esperimento 1_

Lancio di un dado $S=\{1,2,3,4,5,6\}$.

_Esperimento 2_

Lancio 2 volte una moneta $S=\{(T,T), (T,C), (C,C), (C,T)\}$.

Un evento è descritto matematicamente da un sottoinsieme di $S$, più precisamente dall'insieme degli esiti che lo realizzano.

L'evento "esce un numero pari" è descritto da $\{2,4,6\} \subset S$.

La **Famiglia degli eventi** = **Famiglia dei sottoinsiemi di S**.
(Questa identità solo se S è numerabile altrimenti vanno fatte delle precisioni, introdurre $\sigma - algebre$).

## Proprietà

- Due eventi $E, F \subset S$ si dicono **incompatibili** se $E \cap F = \emptyset$.
- $S$ come evento è detto **evento certo**, nel caso del dado l'evento "esce un numero intero" è dato da $S$.
- Dato un evento $E$, l'evento complementare $E^c$ è dato da $E^{c}=S\backslash E$, ad esempio se l'evento è "esce un numero minore o uguale a 2" l'evento complementare è dato da $\{3,4,5,6\}$.
- Leggi di **De Morgan**
  $(A \cup B)^{c}=A^{c}\cap B^{c}$                   $(A \cap B)^{c}=A^{c}\cup B^{c}$

- L'evento **impossibile** è descritto da $\emptyset$.

## Spazio di Probabilità

> [!info] Definizione Spazio di Probabilità
> Uno spazio di probabilità è descritto dalla coppia $(S, P)$ dove **S è lo spazio campionario** dell'esperimento e **P detta funzione di probabilità**, è una funzione definita sulla famiglia degli eventi che soddisfa i seguenti assiomi:
> 
> 1) $P(E)\in [0,1] \ \ \forall E$ evento cioè $\forall E \subset S$
> 2) $P(S)=1$
> 3) Data una successione $E_{1},E_{2}...$ di eventi 2 a 2 disgiunti vale:
>    
> $$
>    P(\bigcup^{\infty}_{i=1} E_{i})=\sum\limits_{i=1}^{\infty}P(E_{i}) 
> $$
>    
>    Questo quando $\forall i\neq j$ e $E_{i}\cap E_{j}\neq \emptyset$
>    Ovvero $\forall i\neq j$ abbiamo $E_{i}$ e $E_{j}$ incompatibili.
>    
>    Terminologia: Dato $E$ evento, $P(E)$ si dice probabilità dell'evento E.
>

### Proposizione 1

$$
P(\emptyset)=0
$$

La probabilità dell'evento impossibile è uguale a 0.

_Dimostrazione - Utilizzando l'assioma 3_

Prendiamo la successione $E_1,E_2,E_3,...$  dove $E_1=\emptyset,E_2=\emptyset,E_3=\emptyset,...$, quindi abbiamo che $\forall i\neq j$ l'intersezione $E_i\cap E_j=\emptyset$.

Per l'assioma 3 $P(\bigcup\limits^{\infty}_{i=1} E_{i})=\sum\limits_{i=1}^{\infty}P(E_{i})$, quindi $P(\emptyset)=\sum\limits_{i=1}^{\infty}P(\emptyset)$, per l'assioma 1 sappiamo che $P(\emptyset)\in [0,1]$.

Supponiamo che $P(\emptyset)\in (0,1]$ allora abbiamo che $\sum\limits_{i=1}^{\infty}P(\emptyset)=+\infty$ e quindi $P(\emptyset)\neq \sum\limits_{i=1}^{\infty}P(\emptyset)$, per esclusione quindi $P(\emptyset)=0$ altrimenti come appena visto otteniamo un valore infinito.

### Proposizione 2
Prendiamo un esempio:
- Domani piove con una probabilità 0.3
- Domani c'è il sole con una probabilità 0.6
- Domani nevica con una probabilità 0.1
Qual è la probabilità che piova o che nevichi? 0.3 + 0.1 = 0.4

**P soddisfa l'additività finita**: Dati $n$ eventi a 2 a 2 _incompatibili_ $E_1,E_2,...,E_n$ vale $P(\bigcup\limits^{n}_{i=1} E_{i})=\sum\limits_{i=1}^{n}P(E_{i})$

_Dimostrazione_

Consideriamo la successione $F_1:=E_1,F_2:=E_2,...,F_n:=E_n,F_{n+1}:=\emptyset,F_{n+2}:=\emptyset$, ovvero hanno dei valori fino ad $n$ e poi sono $\emptyset$.

Dato che la successione è fatta da eventi 2 a 2 _incompatibili_ posso applicare il 3 assioma e otteniamo:

$$
P(\bigcup\limits^{\infty}_{i=1} F_{i})=\sum\limits_{i=1}^{\infty}P(F_{i})
$$

Che è equivalente a:

$$
P(\bigcup\limits^{\infty}_{i=1} E_{i})=P(E_1)+P(E_2)+...+P(E_n)+P(\emptyset)+...
$$

Per la proposizione precedente sappiamo che $P(\emptyset)=0$ quindi tutti i $P(\emptyset)$ sono trascurabili lasciando soltanto:

$$
P(\bigcup\limits^{n}_{i=1} E_{i})=P(E_1)+P(E_2)+...+P(E_n)
$$
### Proposizione 3

$$
\forall E\subset S \text{ vale } P(E^c)=1-P(E)
$$

_Dimostrazione_

![[Pasted image 20241001105352.png|400]]

$E$ e $E^c$ sono eventi _incompatibili_, quindi per l'**additività finita** abbiamo che $P(E\cup E^c)=P(E)+P(E^c)$ ma sappiamo che $E\cup E^c=S$ quindi possiamo dire che $P(E\cup E^c)=P(S)=1$.

Possiamo scrivere quindi:

$$
P(E)+P(E^c)=1\rightarrow P(E^c)=1-P(E)
$$

### Proposizione 4 - Monotonia della Funzione di Probabilità
Dati $E$ e $F$ eventi con $E\subset F$ allora vale $P(E)\leq P(F)$.

![[Pasted image 20241001105832.png|400]]

$F=E\cup (F\backslash E)$, quindi $E$ ed $F\backslash E$ sono _disgiunti_.

Quindi, $P(F)=P(E)+P(F\backslash E)$ dato che per l'assioma 1 $P(F\backslash E)\geq 0$
allora $P(E)+P(F\backslash E)\geq P(E)$.

### Proposizione 5
$\forall E,F$ eventi, allora $P(E\cup F)=P(E)+P(F)-P(E\cap F)$, questa è la **formula generale**, non l'abbiamo usata prima perché nel caso in cui $E,F$ sono disgiunti allora $P(E\cap F) = 0$.

_Esempio Grafico_

![[Pasted image 20241001110629.png|400]]

Anche se conosco l'area delle due figure, per conoscere l'area totale devo sottrarre l'area dell'intersezione fra le due.

_Dimostrazione_

![[Pasted image 20241001110726.png|300]]

Abbiamo che $I=E\backslash F, II = F\backslash E, III = E\cap F$, gli eventi quindi sono 2 a 2 disgiunti (gli eventi 2 a 2 disgiunti sono le zone I, II e III non E ed F).

Otteniamo che:
- $P(E)=P(I\cup III)= P(I)+P(III)$
- $P(F)=P(II\cup III)=P(II)+P(III)$
- $P(E\cap F)=P(III)$

Sappiamo che:
- $P(E\cup F)=P(I\cup II\cup III) = P(I)+P(II)+P(III)$
- E secondo la proposizione: $P(E\cup F)=P(E)+P(F)-P(E\cap F)$, sostituendo i valori : 
$$
P(E\cup F)=P(I)+P(III)+P(II)+P(III)-P(III)=P(I)+P(II)+P(III)
$$
Abbiamo ottenuto lo stesso risultato.

_Esempio_

Giulia porta ha 2 libri _L1, L2_, l'evento _E_ corrisponde a "Le piace _L1_" mentre _F_ a "Le piace _L2_".

- $P(E)=0.5$
- $P(F)=0.4$
- $P(E\cap F)=0.3$ -> "Le piacciono entrambi"

Quant'è la probabilità che non le piaccia alcun libro?

- Calcoliamo prima $E\cup F$ che equivale a "Le piace almeno un libro":
  $P(E\cup F)=P(E)+P(F)+P(E\cap F)=0.5+0.4-0.3=0.6$
- L'evento complementare di "Le piace almeno un libro" è "Non le piace nessun libro" quindi il risultato finale è:

$$
P((E\cup F)^c)=1-P(E\cup F)=1-0.6=0.4
$$

**Infatti**:

Dato uno spazio campionario _S_ e due eventi $E,F\subset S$ abbiamo che:

$$
x\in E\cup F\Leftrightarrow x\in E \text{ o } x\in F \Leftrightarrow \text{ x realizza almeno uno dei due eventi}
$$

Quindi $E\cup F$ significa che "Si verifica E oppure si verifica F" **non c'è esclusività**, invece $E\cap F$ significa che "Si verifica sia E che F".

_Esempio_

Abbiamo un dato truccato dove:
- 1 esce con probabilità $\frac{1}{2}$
- Gli altri numeri con probabilità $\frac{1}{10}$

Quant'è la probabilità che esce un numero dispari? $E=\{1,3,5\}$.

Per **additività finita**:

$$
\underbrace { P(E) }_{ \{1\}\cup\{3\}\cup\{5\} \text{ 2 a 2 incompatibili} }=P(\{1\})+P(\{3\})+P(\{5\})=\frac{1}{2}+\frac{1}{10}+\frac{1}{10}=\frac{7}{10}
$$

## Esiti su spazi di probabilità con esiti equiparabili
Supponiamo che $|S|<\infty$ quindi abbiamo una situazione del tipo, $S=\{ S_{1},S_{2},\dots,S_{n}\}$ con $n$ esiti.
Supponiamo che, ad esempio per simmetria, i vari esiti abbiano la stessa probabilità di realizzarsi, **sono equiprobabili**.

Come modelliamo questo esperimento con uno spazio di probabilità?

- Dato che gli esiti sono tra di loro paritari richiederanno che $P(\{ 1 \})=P(\{ 2 \})=\dots=P(\{ S_{n} \})=z$, questo valore lo chiameremo $z$.
- Inoltre abbiamo che
  $$
  1=P(S)=\underbrace{ P(\{ 1 \}\cup \dots\cup \{ S_{n} \}) }_{ S=\{ 1 \}\cup \dots\cup \{ S_{n} \} \text{ 2 a 2 incompatibili} }=\sum\limits_{i=1}^{n}P(\{ S_{i} \})=n \cdot z
  $$
Questo perché abbiamo la somma di $n$ valori uguali che valgono tutti $z$.

In questo modo abbiamo provato che $1=n \cdot z$ e quindi $z=\frac{1}{n}$, e dato che sono equiprobabili sappiamo che $\forall i, 1 \leq i \leq n, P(\{ S_{i} \})=\frac{1}{n}$.

### Proposizione
Se $|S|=n$ e gli esiti sono equipossibili, allora $\forall E, P(E)=\frac{|E|}{|S|}=\frac{\text{\# esiti favorevoli a E}}{\text{\# esiti possibili}}$

_Dimostrazione_

Dato $E=\bigcup\limits_{S\in E}\{ S \}$ gli eventi $\{ S \}$, con $S \in E$ sono 2 a 2 incompatibili. Possiamo applicare l'additività finita e ottenere:

$$
P(E)=\sum_{S\in E}P(\{ S \})=\sum_{S\in E} \frac{1}{n}=\frac{|E|}{n}=\frac{|E|}{|S|}
$$
_Esempio_

Lancio 2 dadi, qual è la probabilità che la somma dei numeri usciti dia 6?

$$
\begin{align*}
&S=\{ (a,b):a,b\in \{ 1,2,\dots,6 \} \}\\
&a=\text{numero al 1° lancio} \\
&b=\text{numero al 2° lancio}
\end{align*}
$$

Il dado è onesto e quindi tutti i numeri sono equipossibili, quindi:

$$
P(E)=\frac{|E|}{|S|} \text{ dove } E\subset S
$$

$$
\begin{align*}
E=\text{"La somma da 6"}&=\{ (a,b)\in S:a+b=6 \} \\
&=\{ (1,5),(2,4),(3,3),(4,2),(5,1) \} \\ \\
&P(E)=\frac{|E|}{|S|}=\frac{5}{\underbrace{ 6 \cdot 6 }_{ \text{esiti possbili 2 dadi} }}=\frac{5}{36}
\end{align*}
$$


> [!info] Ordine
> Conviene non prendere i numeri dimenticando l'ordine, altrimenti gli esiti non sono equipossibili:
> $$
> P(\text{"Sono usciti 2 e 3 in qualunque ordine"})=\frac{2}{36}, \{ (2,3),(3,2) \}
> $$
> 
> $$
> P(\text{"Uscito 1 e 1"})=P(\{ (1,1) \})=\frac{1}{36}
> $$

_Esempio_

Ho un mazzo da 40 carte, estraggo 2 carte senza rimpiazzo, quant'è la probabilità che escano 2 carte di bastoni?

Il mazzo è composto da 4 semi e 10 carte per seme.
- $M$ = Mazzo
- $S=\{ (a,b):a,b\in M, a \neq b \}$

Per simmetria ho esiti equiprobabili quindi vale $P(E)=\frac{|E|}{|S|}$.

In questo caso abbiamo che $E=\{ (a,b)\in S:a,b \text{ sono di bastoni} \}$, $|S|=40 \cdot 39$ che sono i modi possibili per estrarre due carte ed $|E|=10 \cdot 9$ che sono i modi possibili per estrarre due carte dello stesso seme.

$$
P(E)=\frac{|E|}{|S|}=\frac{10 \cdot 9}{40 \cdot 39}=\frac{1}{4}\cdot \frac{3}{13}=\frac{3}{52}
$$

_Approccio Alternativo_

$S=\{ \{ a,b \}:a,b\in M, a\neq B \}$, adesso consideriamo di estrarre 2 carte nello stesso momento e quindi non sono più coppie ordinate, non conta l'ordine.

Gli esiti sono comunque equiprobabili ma adesso per selezionare due carte senza contare l'ordine in tutto il mazzo posso fare $\binom{40}{2}$ mentre per due carte dello stesso seme $\binom{10}{2}$ quindi:

$$
P(E)=\frac{\binom{10}{2}}{\binom{40}{2}}=\frac{3}{52}
$$

_Esempio Libro_

Ho un'urna con 6 palline bianche e 5 nere.
Estraggo 3 palline a caso senza rimpiazzo, quant'è la probabilità che esca 1 bianca e 2 nere?

Non ci conviene registrare soltanto il colore delle palline, **questo perché rompe la simmetria**, ci conviene invece numerarle una per una in modo da distringuerle.

$Urna=U=\{ B_{1},B_{2},B_{3},B_{4},B_{5},B_{6},N_{1},N_{2},N_{3},N_{4},N_{5} \}$ abbiamo quindi 11 palline distinguibili.

$S=\{ A\subset U:|A|=3 \}$, un esempio di esito è $\{ B_{2},B_{4},N_{3} \}$.

Quindi adesso $S$ ha esiti equiprobabili per simmetria: $P(E)=\frac{|E|}{|S|}$ dove $|S|=\binom{11}{3}$.

Quanto vale $|E|$? $E=\{ A \subset U:|A|=3, \text{A ha una pallina bianca e 2 nere} \}$

$|E|=6 \cdot\binom{5}{2}$ dove $6$ sono i modi per estrarre una pallina bianca e $\binom{5}{2}$ quelli per scegliere due palline nere senza considerare l'ordine. Quindi:

$$
P(E)=\frac{6 \cdot\binom{5}{2}}{\binom{11}{3}} = \frac{4}{11}
$$


_Esempio dei Compleanni_

A quanto corrisponde la probabilità che due persone condividano lo stesso giorno di compleanno? Prendendo in considerazione soltanto anni da 365 giorni.

$S=\{ (x_{1},x_{2}):x_{1},x_{2}\in \{ 1,2,\dots,365 \} \}$, $E=\{ (x_{1},x_{2})\in S:x_{1}=x_{2} \}=\{ (1,1),(2,2),\dots,(365,365) \}$.

Allora $P(E)=\frac{365}{365^2}$ infatti ho una sola coppia fra le 365 di $E$ ed ho $365^2$ per scegliere i compleanni di due persone.

Se abbiamo 3 persone?

$S=\{ (x_{1},x_{2},x_{3}):x_{1},x_{2},x_{3}\in \{ 1,2,\dots,365 \} \}$, $E=\{ (x_{1},x_{2},x_{3})\in S: \exists i\neq j \text{ con }1\leq i,j\leq 3, x_{i}=x_{j}\}$

Ma calcolare tutte le triplette con 3 valori uguali è molto complesso, è invece più semplice calcolare quelle con 3 valori distinti ovvero $E^c$ e poi per calcolare $P(E)$ svolgere $1-P(E^c)$.

$E^c=\{ (x_{1},x_{2},x_{3})\in S:x_{1},x_{2},x_{3}\text{ sono distinti} \}$, per il principio fondamentale della combinatoria $|E^c|=365\cdot 364\cdot 363$, mentre $|S|=365^3$ e quindi:

$$
P(E)=1-\frac{365\cdot 364\cdot 363}{365^3}
$$

_In Generale per n persone:_

$$
P(E)=1-\frac{|E^c|}{|S|}=1-\frac{365\cdot 364\cdot \dots. \cdot (365-n+1)}{365^n}
$$

_Esercizio_

Creare una commissione di 5 persone estratte da un gruppo composto da 6 uomini e 9 donne. Se scelgo le persone da bendato, quante sono le probabilità che la commissione sia formata da 3 uomini e 2 donne.

$S=\{ A\subset G:|A|=5 \}$ dove $G=$ gruppo delle 15 persone totali.
Dobbiamo calcolare quindi $P(E)=\frac{|E|}{|S|}$ dove $E=\{ A\subset G:|A|=5\wedge\text{A contiene 3U e 2D} \}$.

Come visto in esempi precedenti ci conviene numerare tutte le persone in modo da distinguerle in questo modo otteniamo che per scegliere 3 uomini da un gruppo di 6 posso calcolare $\binom{6}{3}$ e per le donne $\binom{9}{2}$ in totale per formare un gruppo da 5 = $\binom{6}{3}\cdot \binom{9}{2}$.

$|S|$ è più semplice dato che dobbiamo semplicemente scegliere 5 persone da un gruppo di 15 e quindi $\binom{15}{5}$, la probabilità è data quindi da:

$$
P(E)=\frac{|E|}{|S|}=\frac{\binom{6}{3}\cdot\binom{5}{2}}{\binom{15}{5}}=\frac{240}{1001}
$$

_Proviamo a tenere conto dell'ordine di scelta:_

Allora $S=\{ (x_{1},x_{2},x_{3},x_{4},x_{5}):\forall i,\ x_{i}\in G,x_{1},\dots,x_{5}\text{ sono distinti} \}$.

$|S|=15\cdot 14\cdot 13\cdot 12\cdot 11$.

$E=\{ (x_{1},\dots,x_{5})\in S:\text{ci sono 3u e 2d} \}$.

In questo caso non posso procedere subito con il principio fondamentale dato che se appunto inizio a calcolare $15\cdot 14\cdot ?$ a questo punto non so cosa scegliere, perché dipende dagli esiti precedenti, se ho scelto 2 donne devo scegliere un uomo ma se ho scelto 2 uomini posso scegliere sia una donna che 1 uomo, o altri casi ancora.

Posso però stabilire in che posizione scelgo gli uomini e le donne ad esempio $(U_{*},D_{*},D_{*},U_{*},U_{*})$ in questo modo posso calcolare tutte le combinazioni di posizioni possibili con il coefficiente binomiale $\binom{5}{3}=\binom{5}{2}$ oppure calcolare le permutazioni della stringa e quindi $\frac{5!}{3!\cdot 2!}$, tutti e 3 i modi sono validi.

A questo punto scelgo gli uomini nella cinquina con il principio fondamentale e quindi $6\cdot 5\cdot 4$, e poi scelgo le donne $9\cdot 8$. Mettendo tutto insieme:

$$
\frac{5!}{3!\cdot 2!}\cdot 6\cdot 5\cdot 4\cdot 9\cdot 8 =\frac{240}{1001}
$$

**Considerando o meno l'ordine, il risultato NON cambia, avrò sempre le stesse probabilità**

## Principio di Inclusione / Esclusione

- Con 2 eventi: $P(A\cup B) = P(A)+P(B)-P(A\cap B)$
- Con 3 eventi: $P(A\cup B\cup C)=P(A)+P(B)+P(C)-P(A\cap B)-P(A\cap C)-P(B\cap C)+P(A\cap B\cap C)$
- Con $n$ eventi: (***!!! NON FA PARTE DEL PROGRAMMA !!!***) 

$$
P\left( \bigcup_{i=1}^{n}E_{i} \right)=\sum_{i=1}^nP(E_{i})-\sum_{i\leq i\leq j\leq n}P(E_{i}E_{j})+\sum_{1\leq i\leq j\leq k\leq n}P(E_{i}\cap E_{j}\cap E_{k})\dots(-1)^nP(E_{1}\cap E_{2}\cap E_{n})
$$

## Probabilità Condizionata

Dati $E, F$ eventi con $P(F)>0$, la probabilità di $E$ condizionata a $F$ è definita come $P(E|F)=\frac{P(E\cap F)}{P(F)}$. Per $E,F$ eventi con $P(F)$ positiva.

Si svolge l'esperimento e so che "si verifica F", questa informazione muta la mia speranza che si verifichi $E$ e la nuova probabilità di $E$ sapendo che si è verificato $F$ è data da $P(E|F)$.

_Esempio_

Lancio 1 dado.

$E=\text{Esce 1 o 2}, P(E)=\frac{2}{6}=\frac{1}{3}$.

Immaginiamo di sapere che si è verificato l'evento $F$ dove $F=\text{Uscito un numero } \leq 4$, se so che $F$ si realizza allora so che è uscito o 1 o 2 o 3 o 4. Ho 4 possibili esiti e c'è simmetria.

Quindi in questo modo se si verifica $F$ allora $P(E)=\frac{2}{4}=\frac{1}{2}$, ci aspettiamo quindi $P(E|F)=\frac{1}{2}$, calcoliamolo usando la definizione:

$$
\begin{align*}
&P(E|F)=\frac{P(E\cap F)}{P(F)}=\frac{\frac{2}{6}}{\frac{4}{6}}=\frac{1}{2} \\ \\
&S=\{ 1,2,\dots,6 \} \\
&F=\{ 1,2,3,4 \}
\end{align*}
$$

_Proposizione_

Se $S$ è finito e ha esiti equiprobabili allora $P(E|F)=\frac{|E\cap F|}{|F|}$ con $E,F$ eventi con $P(F)$ positiva.

_Dimostrazione_

$P(E|F)=\frac{P\cap F}{P(F)}$ e per ipotesi $P(F)>0$ quindi vale la definizione di $P(E|F)$

$$
P(E|F)=\frac{P(E\cap F)}{P(F)}=\frac{\frac{|E\cap F|}{|S|}}{\frac{|F|}{|S|}}=\frac{|E\cap F|}{|F|}
$$

_Esercizio_

Estraggo 3 carte da un mazzo da 40 senza rimpiazzo, sapendo che ho estratto solo carte di bastoni, qual è la probabilità di aver estratto un asso?

$$
\begin{align*}
&E=\text{Estraggo un asso} \\
&F=\text{Le carte sono di bastoni} \\
&S=\{ A\subset M:|A|=3 \}\text{ dove M = mazzo, S ha esiti equiprobabili} \\
 \\
&\underbrace{ P(E|F)=\frac{|E\cap F|}{|F|} }_{ \text{proposizione precedente} }=\frac{\binom{9}{2}}{\binom{10}{3}}=\frac{3}{10} \\
 \\
&\binom{9}{2} \text{ sono le terne non ordinate di bastoni dove non c'è asso}
\end{align*}
$$

_Esempio_

Ho un dado truccato dove 1 esce con probabilità $\frac{1}{2}$ mentre gli altri numeri $\frac{1}{10}$, qual è la probabilità che esca $1$ o $2$ sapendo che è uscito un numero $\leq 4$.

$$
\begin{align*}
&S=\{ 1,2,3,4,5,6 \} \\
&E=\{ 1,2 \} \\
&F=\{ 1,2,3,4 \} \\
\\
&P(E|F)=\frac{P(E\cap F)}{P(F)}= \dots \\  \\
&E\cap F=\{ 1,2 \},P(E\cap F)=P(\{ 1 \})+P(\{ 2 \})=\frac{1}{2}+\frac{1}{10}=\frac{3}{5} \\
\\
&P(F)=P(\{ 1,2,3,4 \})=\frac{1}{2}+\frac{3}{10}=\frac{4}{5} \\
\\
&\dots=\frac{\frac{3}{5}}{\frac{4}{5}}=\frac{3}{4}
\end{align*}
$$

**Regola del Prodotto**

Se $P(F)>0,P(E|F)=\frac{P(E\cap F)}{P(F)}$ quindi $P(E\cap F)=P(F)\cdot P(E|F)$

_Esempio_

Abbiamo un'urna con 10 palline bianche e 4 palline nero, estraggo 2 palline senza rimpiazzo. Qual è la probabilità che siano entrambe bianche? Lo avevamo già risolto con la combinatoria, vediamo senza:

$$
\begin{align*}
&F=\text{La prima pallina estratta è bianca} \\
&E=\text{La seconda pallina estratta è bianca} \\
&G=E\cap F, P(G)=P(E\cap F)=P(F)\cdot P(E|F)=\frac{10}{14}\cdot \frac{9}{13}
\end{align*}
$$

_Dimostrazione_

Siano $E_{1},\dots,E_{n}$ eventi allora $P(E_{1}\cap\dots\cap E_{n})=P(E_1)\cdot P(E_{2}|E_{1})\cdot P(E_{3}|E_{1}\cap E_{2})\dots \cdot P(E_{n}|E_{1}\cap \dots\cap E_{n-1})$ supponendo che $P(E_{1}>0,P(E_{1}\cap E_{2})>0,\dots,P(E_{1}\cap\dots\cap E_{n-1})>0)$.

_Dimostrazione per n=2 già fatta, vediamo con n=3_

$$
\begin{align*}
&n=3  \\
&\text{Dobbiamo provare che} \\
&P(E_{1}\cap E_{2}\cap E_{3})=P(E_{1})\cdot P(E_{2}|E_{1})\cdot P(E_{3}|E_{1}\cap E_{2}) \\
 \\
&\text{Per definizione di prob cond.} \\
 \\
&P(E_{1})\cdot P(E_{2}|E_{1})\cdot P(E_{3}|E_{1}\cap E_{2})=P(E_{1})\cdot\frac{P(E_{2}\cap E_{1})}{P(E_{1})}\cdot\frac{P(E_{3}\cap E_{1}\cap E_{2})}{P(E_{1}\cap E_{2})}=\dots \\
 \\
&=P(E_{1}\cap E_{2}\cap E_{3})
\end{align*}
$$

Per $n$ generico è simile.

_Esempio_

Estraggo 3 carte senza rimpiazzo da un mazzo da 40, qual è la probabilità che la prima carta è di bastoni, la seconda di denari e la terza di bastoni.

$$
\begin{align*}
&P(G)=? \ G=\text{1 carta bastoni, 2 denari, 3 bastoni} \\
 \\
&\text{1° Metodo combinatoria} \\
&S=\{ (a,b,c):a,b,c\in M, distinti \} \\
&P(G)=\frac{|G|}{|S|}=\frac{10\cdot 10\cdot 9}{40\cdot 39 \cdot 38}=\dots \\
 \\
&\text{2° Metodo prob. cond.} \\
&G=E_{1}\cap E_{2}\cap E_{3} \text{ dove} \\
&E_{1}=\text{prima carta B},E_{2}=\text{seconda carta D},E_{3}=\text{terza carta B} \\
 \\
&\text{Per regola prodototto} \\
&P(G)=P(E_{1}\cap E_{2}\cap E_{3})=P(E_1)\cdot P(E_{2}|E_{1})\cdot P(E_{3}|E_{1}\cap E_{2})= \\
&=\frac{10}{40}\cdot \frac{10}{39}\cdot \frac{9}{38}=\dots
\end{align*}
$$

**Teorema di Bayes**

$$
P(A|B)\overset{\text{Definizione}}=\frac{P(A\cap B)}{P(B)}\overset{\text{Regola prodotto}}=\frac{P(A)\cdot P(B|A)}{P(B)}
$$

Enunciato:

$$
P(A|B)=\frac{P(A)\cdot P(B|A)}{P(B)}
$$

---

_Esempio_

Ho un'urna con 10 palline di cui 1 d'oro, lancio 1 dado, se esce 1 estraggo 2 palline senza rimpiazzo altrimenti estraggo 1 sola pallina, con che probabilità estraggo la pallina d'oro?


> [!info] Formula probabilità totale
> Dati $E,F$ eventi allora $P(E)=P(F)\cdot P(E|F)\cdot P(F^C)\cdot P(E|F^C)$
> 
> _Dimostrazione_
> 
> $E=(E\cap F)\cup (E\cap F^C)$ quindi  dato che sono incompatibili $P(E)=P(E\cap F)+P(E\cap F^C)\overset{\text{Regola Prodotto}}=P(F)\cdot P(E|F)+P(F^C)\cdot P(E|F^C)$.

Se so cosa da il dado allora posso calcolare la probabilità.

$F=\text{Il dado da 1}$, $E=\text{La pallina d'oro viene estratta}$

E quindi per la legge della probabilità totale:

$$
\begin{align*}
&P(E)=P(F)\cdot P(E|F)\cdot P(F^C)\cdot P(E|F^C)=\dots  \\ \\
&\text{Calcoliamo i valori:} \\
&P(F)=\frac{1}{6} \\
&P(E|F)=\frac{P(E\cap F)}{P(F)}=\frac{9}{\binom{10}{2}}=\frac{1}{5} \\
&P(F^C)=\frac{5}{6} \\
&P(E|F^C)=\frac{1}{10} \\ \\
&\text{Quindi:} \\
&\dots=\frac{1}{6}\cdot \frac{1}{5}+\frac{5}{6}\cdot \frac{1}{10}=\frac{7}{60}
\end{align*}
$$

---

Adesso invece sappiamo che la pallina d'oro è stata estratta, qual è la probabilità che dal dado è uscito 1?

Noi sappiamo calcolare $P(E|F)$ e $P(E|F^C)$ ma adesso vogliamo ottenere $P(F|E)$.

Per il teorema di Bayes:

$$
P(F|E)=\frac{P(F\cap E)}{P(E)}=\frac{P(F)\cdot P(E|F)}{P(E)}
$$

Quindi:

$$
P(F|E)=\frac{P(F)\cdot P(E|F)}{P(E)}=\frac{\frac{1}{6}\cdot \frac{1}{5}}{\frac{7}{60}}=\frac{2}{7}
$$


---

_Esempio Parte I_

In un'agenzia di assicurazioni le persone vengono divise in due categorie: _propense e non propense a fare incidenti_. 

Le persone propense hanno una probabilità di 0.4 di fare un incidente in un anno mentre le non propense 0.2.

Il 30% degli automobilisti è propensa agli incidenti.

Qual è la probabilità che un nuovo cliente abbia un incidente in quell'anno?

$$
\begin{align*}
&A:=\text{Il nuovo cliente è propenso agli incidenti} \\
&A_{1}:= \text{Il nuovo cliente ha un incidente in un anno} \\
&P(A_{1})=? \\
&P(A_{1}|A)=0.4, P(A_{1}|A^C)=0.2, P(A)=0.3 \\
 \\
&\text{Per la formula di probabilità totale:} \\
&P(A_{1})=P(A)\cdot P(A_{1}|A)+P(A^C)\cdot P(A_{1}|A^{C})=0.3\cdot 0.4+0.7\cdot 0.2=0.26=26\%
\end{align*}
$$

_Parte II_

Sapendo che il cliente ha avuto un incidente in quell'anno, qual è la probabilità che sia propenso agli incidenti?

Quindi 

$$
P(A|A_{1})=\frac{P(A\cap A_{1})}{P(A_{1})}=\frac{P(A)\cdot P(A_{1}|A)}{P(A_{1})}=\frac{0.3\cdot 0.4}{0.26}=\frac{6}{13}
$$


## Legge probabilità totale generalizzata
Siano $F_{1},\dots,F_{n}$ eventi 2 a 2 disgiunti tali che $S=\bigcup\limits^{n}_{i=1}F_{i}$ allora per ogni evento $E_{i}$ vale $P(E)=\sum\limits_{i=1}^n P(F_{i})\cdot P(E| F_{i})$.

_Esempio con $n=2$_

$$
P(E)=P(F_{1})\cdot P(E | F_{1})+P(F_{2})\cdot P(E|F_{2})
$$

_Esempio Test Malattia_

Abbiamo un esame efficace al 95% quando la malattia è presente, 1% di falsi positivi e il 5x1000 della popolazione ha effettivamente la malattia.

$D=\text{La persona testata ha la malattia}$

$E=\text{Persona è positiva all'esame}$

$$
\begin{align*}
&P(E|D)=0.95 \\
&P(E|D^C)=0.01 \\
&P(D)=0.005 \\
&\text{Qual è la probabilità che una persona testata abbia la malattia?} \\
&P(D|E)=? \\
&P(D|E)=\frac{P(D\cap E)}{P(E)}=\frac{P(D)\cdot P(E|D)}{P(D)\\cdot P(E|D)+ P(D^C)\cdot P(E|D^C)}=\frac{0.005\cdot 0.95}{0.005\cdot 0.95+0.995\cdot 0.01}=0.323 \\
&\text{Quindi se il test dice che siamo malati, lo siamo veramente in un caso su 3 circa.}
\end{align*}
$$

Il test è buono se $P(D|E)$ è vicina al 100% e anche se $P(D^C|E^C)$ è vicina al 100%.

Questo non è un buon test per la popolazione e la malattia presa in esame, infatti ci sono troppi pochi malati e se vengono effettuati tanti test con questa probabilità di falsi positivi avremo più test sbagliati che veri malati.

Infatti con 995 sani e 5 malati abbiamo molti falsi positivi.

Infatti:

$P(D|E)=\frac{P(D\cap E)}{P(E)}=\frac{\text{\#Persone malate con test positivo}}{\text{\#Persone con test positivo}}$ dove il numero di persone con test positivo (denominatore) è dato da $\text{\#Persone malate con test positivo + \#Persone sane con test positivo}$.

Prendiamo ad esempio 995.000 sani testati allora 9950 sani avranno un test positivo ovvero test sbagliati mentre i malati che sono 5000, solo il 95% ovvero 4750 avranno un test positivo e quindi corretto.

Notiamo quindi che i testi sbagliati 9950 sono molto maggiori rispetto ai test corretti 4750.

Questo test sarebbe più corretto se usato per una malattia con più infetti.

## Rapporto a Favore

_Definizione_: Il rapporto a favore di un evento $A$ è dato da:

$$
\frac{P(A)}{P(A^C)}=\frac{P(A)}{1-P(A)}
$$

_Esempio_:

Abbiamo la partita di calcio Italia - Brasile. Se la vittoria dell'italia è data 1 a 5 intendiamo che il rapporto a favore dell'evento "l'italia vince" è $\frac{1}{5}$ e quindi $\frac{P(A)}{P(A^C)}=\frac{1}{5}$.

Data l'espressione possiamo calcolare A:

$$
\begin{align}
&P(A)=\frac{1}{5}\cdot(1-P(A)) \\
&P(A)=\frac{1}{5}-\frac{P(A)}{5} \\
&\frac{6}{5}P(A)=\frac{1}{5} \\
&P(A)=\frac{1}{6};P(A^C)=\frac{5}{6}
\end{align}
$$

_Esempio di Criminologia_

Abbiamo $H$ ipotesi "Mario Rossi è l'assassino", abbiamo una stima di $P(H)$, ad esempio per Sherlock Holmes $P(H)=0.8$.

Introduciamo una nuova prova $E$ e questa modifica la nostra stima in $P(H|E)$, avendo introdotto una nuova prova, come cambia il rapporto a favore? Questo è dato da:

$$
\frac{P(H|E)}{P(H^C|E)} \text{ Mentre prima era } \frac{P(H)}{P(H^C)}
$$

Inoltre per il teoria di Bayes sappiamo che:

$$
P(H|E)=\frac{P(H)\cdot P(E|H)}{P(E)};P(H^C|E)=\frac{P(H^C)\cdot P(E|H^C)}{P(E)}
$$

Quindi il nuovo rapporto è dato da:

$$
\frac{P(H|E)}{P(H^C|E)}=\frac{\frac{P(H)\cdot P(E|H)}{P(E)}}{\frac{P(H^C)\cdot P(E|H^C)}{P(E)}}=\frac{P(H)}{P(H^C)}\cdot\frac{P(E|H)}{P(E|H^C)}
$$

Quindi possiamo vederlo anche come:

$$
\text{Vecchio rapporto }\cdot \frac{P(E|H)}{P(E|H^C)}
$$

Il nostro rapporto a favore quindi aumenta se $P(E|H)>P(E|H^C)$ ovvero se il loro rapporto > 1. Aumenta se appunto l'ipotesi è vera piuttosto che quando è falsa.

## Bayes Generalizzato
Avevamo visto la probabilità totale generalizzata, possiamo generalizzare anche il teorema di Bayes:

$$
P(F_{i}|E)=\frac{P(F_{i})\cdot P(E|F_{i})}{\sum\limits_{j=i}^{n}P(F_{j})\cdot P(E|F_{j})}
$$

_Esercizio_

Un aereo è scomparso, si presume sia finito con uguale probabilità in una di 3 zone $Z_{1},Z_{2},Z_{3}$.

Abbiamo:
- $1-\beta_{i}$ = Probabilità di trovare l'aereo in $Z_{i}$ se è effettivamente in $Z_{i}$.
- Sapendo che le ricerche in $Z_{1}$ hanno dato esito negativo, qual è la probabilità che l'aereo sia in $Z_{i}$ con $i=1,2,3$?
- $R_{i}=\text{L'aereo è in } Z_{i}$
- $E=\text{La ricerca in } Z_{1}\text{ ha dato esito negativo}$
- $P(R_{1})=P(R_{2})=P(R_{3})=\frac{1}{3}$
- $P(R_{i}|E)=?$

$$
\begin{align*}
P(R_{1}|E)=\frac{P(E\cap R_{1})}{P(E)}=\frac{P(R_{1})\cdot P(E|R_{1})}{P(E)}=\frac{P(R_{1})\cdot P(E|R_{1})}{\sum\limits_{k=1}^3 P(R_{k})\cdot P(E|R_{k})}=\frac{\frac{1}{3}\cdot \beta_{1}}{\frac{1}{3}\beta_{1}+\frac{1}{3}\cdot 1+ \frac{1}{3}\cdot 1}=\frac{\beta_{1}}{\beta_{1}+2}
\end{align*}
$$

Adesso prendiamo $j=2,3$

$$
\begin{align}
P(R_{j}|E)=\frac{P(R_{j})\cdot P(E|R_{j})}{P(E)}=\frac{\frac{1}{3}\cdot 1}{\frac{1}{3}\beta_{1}+\frac{1}{3}+\frac{1}{3}}=\frac{1}{\beta_{1}+2}
\end{align}
$$

**Proposizione**

Sia $F$ evento con $P(F)>0$ allora la funzione $E\rightarrow P(E|F)$ al variare di $E$ eventi è una funzione di probabilità. Abbiamo quindi una serie di indentità:

1) $P(E^C|F)=1-P(E|F)$
2) $P(A\cup B|F)=P(A|F)+P(B|F)-P(A\cap B|F)$
3) $A_{1},\dots,A_{n}$ eventi 2 a 2 disgiunti allora $P\left( \bigcup\limits_{i=1}^n A_{i}|F \right)=\sum\limits_{i=1}^n P(A_{i}|F)$

_Dimostrazioni negli appunti non so se le metto =P dato che dobbiamo solo fare esercizi_

_Esempio_: lanciamo 2 dadi e valutiamo la speranza degli eventi con $P$. Sappiamo che "il primo dado ha dato un numero pari" e chiamiamo questo evento $A$ quindi adesso la calcoliamo $P(\cdot,A)$. Se poi sappiamo che si verifica $B=\text{"Il 2 dato da un numero dispari"}$ allora valutiamo $Q(\cdot,B)$ dove $Q=P(\cdot,A)$ ottenendo quindi che $Q=(\cdot,A\cap B)$.

## Indipendenza di Eventi
Due eventi $E$ e $F$ si dicono indipendenti se $P(E\cap F)=P(E)\cdot P(F)$ e si scrive $E\perp\!\!\!\!\!\!\perp F$, sarebbe più intuitivo dire che $E$ ed $F$ sono indipendenti se $P(E|F)=P(E)$ e $P(F|E)=P(F)$ però per dare un senso a $P(E|F)$ è necessario che $P(F)>0$ e analogamente per $P(F|E)$ serve che $P(E)>0$.

Tolto il caso in cui uno tra $E$ ed $F$ abbia probabilità 0, la formulazione intuitiva e la definizione coincidono.

Infatti vale:

$$
\begin{align*}
\text{Sia } F \text{ con } P(F)>0 \text{ allora, per ogni evento } E \\
 \\
P(E|F)=P(E)\Leftrightarrow P(E\cap F)=P(E)\cdot P(F)
\end{align*}
$$

_Dimostrazione_

$$
\begin{align*}
&\text{Sia } P(E|F)=P(E) \text{ allora siccome } P(E|F)=\frac{P(E\cap F)}{P(F)} \text{ abbiamo che } \frac{P(E\cap F)}{P(F)}=P(E) \\
 \\
&\text{Moltiplichiamo per } P(F) \to P(F)\cdot\frac{P(E\cap F)}{P(F)}=P(E)\cdot P(F) \Leftrightarrow P(E\cap F)=P(E)\cdot P(F) \\
 \\
&\text{Quindi supponiamo che } P(E\cap F)=P(E)\cdot P(F) \text{ e dividiamo per } P(F)>0 \\
 \\
&\underbrace{ \frac{P(E\cap F)}{P(F)} }_{ P(E|F) }=P(E)
\end{align*}
$$

Analogamente possiamo provare che se $P(E)>0$ allora $P(F|E)=P(F)\Leftrightarrow P(E\cap F)=P(E)\cdot P(F)$.

_Osservazione_

Se $P(E)=0$ allora $E,F$ sono indipendenti per ogni $F$ evento, ovvero esistono eventi con probabilità nulla ma possibili.

Sia $E$ con $P(E)=0$ e sia $F$ evento dobbiamo verificare che $P(E\cap F)=\overbrace{ P(E) }^{ 0 }\cap P(F)$.

Quindi dobbiamo provare che $P(E\cap F)=0$, sappiamo che $E\cap F\subset E$ e per monotonia $P(E\cap F)\leq P(E)=0$.

_Esempio_

Lancio due volte un dado $E=\{ \text{Il 1° lancio dà 4} \},F=\{ \text{La somma dei lanci dà 6} \}$. $E\perp\!\!\!\!\!\!\perp F$?

$$
\begin{align*}
&S=\{ (a,b):a,b\in \{ 1,2,3,4,5,6 \} \} \text{ esiti equiprobabili} \\
&P(E)=\frac{1}{6} \\
&F=\{ (a,b)\in S:a+b=6 \}=\{ (1,5),(2,4),(3,3),(4,2),(5,1) \} \\
&P(F)=\frac{5}{36} \\
&P(E\cap F)=\{ (4,2) \}=\frac{1}{36} \\
 \\
&P(E\cap F)\neq P(E)\cdot P(F) \text{ quindi } E\not{\perp\!\!\!\!\!\!\perp} F
\end{align*}
$$

_Esempio_

Lancio due volte un dado $E=\{ \text{Il 1° lancio dà 4} \},F=\{ \text{La somma dei lanci dà 7} \}$. $E\perp\!\!\!\!\!\!\perp F$?

$$
\begin{align*}
&S=\{ (a,b):a,b\in \{ 1,2,3,4,5,6 \} \} \text{ esiti equiprobabili} \\
&P(E)=\frac{1}{6} \\
&F=\{ (a,b)\in S:a+b=6 \}=\{ (1,6),(2,5),(3,4),(4,3),(5,2),(6,1) \} \\
&P(F)=\frac{6}{36}=\frac{1}{6} \\
&P(E\cap F)=\{ (4,3) \}=\frac{1}{36} \\
 \\
&P(E\cap F)= P(E)\cdot P(F) \text{ quindi } E\perp\!\!\!\!\!\!\perp F
\end{align*}
$$

Se ho un esperimento composto da sottoesperimenti che non si influenzano allora eventi riferiti a sottoesperimenti diversi risultano indipendenti.

_Esempio_

Lancio due volte un dado e ho due sottoesperimenti: primo e secondo lancio. I due sottoesperimenti non si possono influenzare.

$E=\text{1° dà pari},F=\text{2° dà multiplo di 3}$, trattandosi di eventi che si riferiscono a lanci diversi ci aspettiamo che siano indipendenti, verifichiamo che $P(E\cap F)=P(E)\cdot P(F)$.

$$
\begin{align*}
&S=\{ (a,b):a,b\in \{ 1,2,3,4,5,6 \} \} \text{ esiti equiprobabili} \\
&P(E)=\frac{3}{6}=\frac{1}{2} \\
&P(F)=\frac{2}{6}=\frac{1}{3} \\
&E\cap F=\{ (a,b):a\in \{ 2,4,6 \},b\in \{ 3,6 \} \} \\
&P(E\cap F)=\frac{|E\cap F|}{|S|}=\frac{6}{36}=\frac{1}{6} \text{ che è uguale a }\frac{1}{2}\cdot \frac{1}{3} \text{ quindi } E\perp\!\!\!\!\!\!\perp F
\end{align*}
$$

**Proposizione**: Dati $E,F$ eventi, $E\perp\!\!\!\!\!\!\perp F\Rightarrow E^C\perp\!\!\!\!\!\!\perp F$

_Dimostrazione_

Supponiamo $E\perp\!\!\!\!\!\!\perp F$ e quindi $P(E\cap F)=P(E)\cdot P(F)$, dobbiamo provare che $E^C\perp\!\!\!\!\!\!\perp F$, cioè $P(E^C\cap F)=P(E^C)\cdot P(F)$.

$$
\begin{align*}
\text{Abbiamo che } P(E^C)=1-P(E) \\ \\
P(E^C\cap F)=(1-P(E))\cdot P(F)&=P(F)-\underbrace{ P(E\cap F) }_{ E\perp\!\!\!\!\perp F\Rightarrow P(E)\cdot P(F) } \\
&=P(F)-P(E)\cdot P(F) \\
\text{ Raggruppando } P(F)\to \ &=P(F)\cdot(1-P(E))  \\
&=P(F)\cdot P(E^C)
\end{align*}
$$

Supponiamo adesso di avere tre, eventi $E,F,G$: sappiamo che $E,F$ sono indipendenti e anche $E,G$ sono indipendenti. Possiamo dire che $E$ è indipendente da $F\cap G$? **No, possono essere dipendenti**.

_Esempio_

Lancio 2 dadi e definisco gli eventi:

$$
\begin{align*}
&E=\text{La somma dei dadi dà 7} \\
&F=\text{Il primo dado dà 4} \ \ \ G=\text{Il secondo dado dà 3}
\end{align*}
$$

Prendendo gli esempi precedenti sappiamo che $E\perp\!\!\!\perp F$, quindi dobbiamo provare che $E\perp\!\!\!\perp G$:

$$
\begin{align*}
&P(E)=\frac{6}{36}=\frac{1}{6} \\
&P(G)=\frac{1}{6} \\
&P(E\cap G)=\frac{1}{36} \\
&\text{Abbiamo che } P(E)\cdot P(G)=\frac{1}{6}\cdot \frac{1}{6}=\frac{1}{36}=P(E\cap G) \\
&\text{Quindi abbiamo mostrato che } E\perp\!\!\!\perp G \\
 \\
&\text{Notiamo però che } E\cancel{\perp\!\!\!\perp} (F\cap G) \text{ infatti } P(E|F\cap G)=1\neq P(E)
\end{align*}
$$

**Definizione**

Dati 3 eventi $E,F,G$ si dice che sono indipendenti se:

$$
\begin{align*}
&P(E\cap F) = P(E)\cdot P(F) \to E\perp\!\!\!\perp F \\
&P(E\cap G) = P(E)\cdot P(G) \to E\perp\!\!\!\perp G \\
&P(F\cap G) = P(F)\cdot P(G) \to F\perp\!\!\!\perp G \\
&P(E\cap F\cap G)=P(E)\cdot P(F)\cdot P(G)
\end{align*}
$$

**Teorema**

Se $E,F,G$ sono indipendenti, allora $E$ è indipendente da ogni evento costruito a partire da $F$ e $G$ usando unione, intersezione e complementare.

_Quindi, ad esempio:_

Se $E,F,G$ sono indipendenti, allora:

$$
\begin{align*}
&E\perp\!\!\!\perp(F\cap G) \\
&E\perp\!\!\!\perp(F\cup G) \\
&E\perp\!\!\!\perp(F^C \cup G) \\
&E\perp\!\!\!\perp F^C \\
&ecc\dots
\end{align*}
$$

E se ho più di 3 eventi?

**Definizione**

Dati $n$ eventi $E_1,\dots,E_{n}$ questi sono detti indipendenti se $\forall A\subset \{ 1,2,\dots,n \}$ con $A\neq \emptyset$ vale:

$$
P\left( \bigcap_{i\in A}E_{i} \right)=\prod_{i\in A}P(E_{i})
$$

Questa formula è interessante per $A$ tale che $|A|\geq 2$ infatti se $A=\{ i_{0} \}$ allora diventa $P(E_{i_{0}})=P(E_{i_{0}})$ che è banalmente vero.

_Esempio_

![[Pasted image 20241021200031.png|300]]

Prendiamo questi ponti, ogni ponte è integro con probabilità $p$ (e quindi distrutto con probabilità $1-p$), indipendentemente da ponte a ponte. Supponiamo $p=0.3$

Calcolare $P(\text{Partendo da A arrivo B})$.

Definiamo l'evento $E_{i}=\text{Il ponte i è integro}$.

Le strade che posso percorrere sono date da $(E_{1}\cap E_{2})\cup E_{3}$, quindi:

$$
\begin{align*}
P(A\to B)&= P((E_{1}\cap E_{2})\cup E_{3}) \\
&=P(E_{1}\cap E_{2})+P(E_{3})-P(E_{1}\cap E_{2}\cap E_{3}) \\
&=P(E_{1})\cdot P(E_{2})+P(E_{3})-P(E_{1})\cdot P(E_{2})\cdot P(E_{3}) \\
&=p^2+p-p^3=(0.3)^2+0.3-(0.3)^3
\end{align*}
$$

_Oppure possiamo calcolare_

$$
\begin{align*}
1-\underbrace{ P(\text{Da A non arrivo B}) }_{ E_{3}^C\cap(E_{1}^C\cup E_{2}^C) } =\overbrace{ P(E_{3}^C\cap(E_{1}^C\cup E_{2}^C))U }^{ \text{3 rotto e almeno 1 o 2 rotto} }=\text{Da finire :(}
\end{align*}
$$

---

## Problema Monty Hall
Siamo in un gioco dove dobbiamo scegliere 1 fra 3 porte, in una di queste è presente una macchina mentre nelle altre due abbiamo delle pecore, dopo che scegliamo una porta il conduttore ci apre un'altra porta che contiene una pecora e ci propone uno scambia, conviene accettarlo o no?

![[Pasted image 20241023220706.png]]

Quindi se cambiamo abbiamo una possibilità di vittoria di $\frac{2}{3}$ mentre se manteniamo la nostra scelta di $\frac{1}{3}$.

---

Tornando agli eventi indipendenti

_Esempio_

Siano $A,B,C,D$ eventi indipendenti con $P(A)=0.2,P(B)=0.5,P(C)=0.7,P(D)=0.1$ calcolare $P(A\cap C),P(B\cap C\cap D),P(B\cup C)$.

$$
\begin{align*}
&P(A\cap C)=P(A)\cdot P(C)=0.2\cdot 0.7=0.14 \\
&P(B\cap C\cap D)=P(B)\cdot P(C)\cdot P(D) = 0.5\cdot 0.7 \cdot 0.1=0.035 \\
&P(B\cup C)=P(B)+P(C)-P(B\cap C)=0.5+0.7-(0.5\cdot 0.7)=0.85 \\
 \\
&\text{In alternativa:} \\
 \\
&P(B\cup C)=1-P((B\cup C)^C)=1-P(B^C\cap C^C)=1-P(B^C)\cdot P(C^C) \\
&=1-(1-0.5)\cdot (1-0.7)=0.85
\end{align*}
$$

_Esempio con percorsi_

Se prendiamo come esempio un circuito con componenti in parallelo ci basta che un solo componente funzioni per permettere il passaggio di corrente, mettiamo caso che ogni componente è indipendente dalle altre e che $p_{i}=P(\text{La componente i è funzionante})$, come si calcola $P(\text{Il sistema funziona})$?

$$
\begin{align*}
&P\left(\bigcup_{i=1}^n E_{i}\right) \text{ con } E_{i}=\text{"La componente funziona"} \\
&P\left(\bigcup_{i=1}^n E_{i}\right)=1-\left( P\left( \bigcup_{i=1}^n E_{i} \right)^C \right)=1-P\left( \bigcap_{i=1}^n E_{i}^C \right) \\
&=1-\prod_{i=1}^n P(E_{i}^C)=1-\prod_{i=1}^n(1-p_{i})
\end{align*}
$$

# Variabili Aleatorie

## Reali

Dato uno spazio di probabilità $(S,P)$, una variabile aleatoria è una funzione $X:S\to \mathbb{R}$ quindi una funzione che mappa elementi dello spazio campionari in numeri reali.

_Esempio_

Lancio una moneta due volte abbiamo $X:=\#\text{volte in cui esce testa}$, $X$ è una variabile aleatoria.

Abbiamo $S=\{ (T,T),(C,C),(T,C),(C,T) \}$ e sono tutti esiti equiprobabili, abbiamo:

$X((T,T))=2,X((T,C))=1,X((C,T))=1,X((C,C))=0$

_Esempio_

Lancio due volte un dado e abbiamo $X:=\#\text{Somma dei numeri usciti}$, otteniamo quindi

$S=\{ (a,b):a,b\in \{ 1,2,3,4,5,6 \} \}$ e quindi abbiamo esiti equiprobabili.

$X((a,b))=a+b$ quindi ad esempio $X((1,5))=6$

## Discrete
Una variabile aleatorie $X$ è detta **discreta** se i valori che può assumere $\{ X_{i} \}_{i\in I}$ formano un insieme finito o infinito numerabile. Quindi ad esempio la variabile aleatori degli esempi sopra è discreta.

## Densità di probabilità discreta
Data $X$ variabile aleatoria che assume $\{ X_{i} \}_{i\in I}$, la **densità di probabilità discreta** di $X$ è la funzione:

$$
P_{X}:\{ X_{i} \}_{i\in I}\to[0,1], P_{X}:=P(X=X_{i})
$$

È quindi una funzione che descrive la probabilità associata a ciascun valore possibile di una variabile aleatoria discreta.

_Esempio_

Lancio due volte una moneta e v.a. $X:=\#\text{Teste Uscite}$ quindi $X(T,T)=2,X(T,C)=X(C,T)=1, X(C,C)=0$.

Quindi $X$ è una variabile aleatoria che assume i valori 0,1,2.

$p_{X}:\{ 0,1,2 \}\to[0,1]$ e $P_{X}(a)=P(X=a)$, quindi calcoliamo:

$P_{X}(0)=P(X=0)=\frac{1}{4}$ poi $P_{X}(1)=P(X=1)=\frac{2}{4}$ e $P_{X}(2)=P(X=2)=\frac{1}{4}$

_Esempio_

Lancio due volte un dado e la variabile aleatoria è $X:=\#\text{Somma dei valori usciti}$.

Quindi abbiamo esiti equiprobabili in $S=\{ (a,b):a,b\in \{ 1,2,3,4,5,6 \} \}$.

$X(a,b)=a+b$ assume i valori $\{ 2,3,\dots,12 \}$ e calcoliamo:

$$
\begin{align*}
&PX(2)=P(X=2)=P(\{ (1,1) \})=\frac{1}{36} \\
&PX(3)=P(X=3)=P(\{ (1,2),(2,1) \})=\frac{2}{36} \\
&\text{In generale } P_{X}(k)=
\begin{cases}
\frac{k-1}{36} \text{ k=2,3,4,5,6,7} \\
\frac{13-k}{36} \text{ k=7,8,9,10,11,12}
\end{cases}
\end{align*}
$$

---

Possiamo rappresentare la densità di probabilità discreta con un istogramma.

Ad esempio sia $X$ il numero di teste nel lancio di due monete, sappiamo che:

$P_{X}(0)=\frac{1}{4},P_{X}(1)=\frac{2}{4},P_{X}(2)=\frac{1}{4}$

![[Pasted image 20241025213151.png|500]]

## Valore Atteso
Data una variabile aleatorie discreta $X$ che assume valore $\{ X_{i} \}_{i\in I}$, definiamo il valore atteso di $X$ come:

$$
E[X]=\sum_{i\in I}X_{i}P(X=X_{i})=\sum_{i\in I}X_{i}P_{X}(X_{i})
$$

Dove $E$ indica _expected value of X_.

_Esempio_

Lanciamo una moneta 2 volte e come variabile aleatoria abbiamo $X=\#\text{Teste Uscite}$.

$$
E[X]=0\cdot \frac{1}{4}+1\cdot \frac{2}{4}+2\cdot \frac{1}{4}=1
$$

_Esercizio_

Data un'urna con 3N e 2B. Estraggo due palline senza rimpiazzo, sia $X:=\#\text{Palline nere estratte, calcolare}$ calcolare $E[X]$.

Abbiamo $X=\{ 0,1,2 \}$

- $P(X=0)=\frac{2\cdot 1}{5\cdot 4}=\frac{2}{20}$
- $P(X=1)=\frac{3\cdot 2}{5\cdot 4} + \frac{2\cdot 3}{5\cdot 4}=\frac{12}{20}$
- $P(X=2)=\frac{3\cdot 2}{5\cdot 4}=\frac{6}{20}$

$$
E[X]=0\cdot \frac{2}{20} + 1\cdot \frac{12}{20} + 2\cdot \frac{6}{20}=\frac{6}{5}
$$

## Funzione di Distribuzione (o Ripartizione)

Data una variabile aleatoria $X$, la sua funzione di distribuzione è definiti come:

$$
F_{X}:\mathbb{R}\to[0,1] \text{ con } F_{X}(a)=P(X\leq a) \ \forall a\in \mathbb{R}
$$

_Esempio_

Sia $X$ la stessa v.a. di prima determiniamo $F_{X}$.

- Se $a<0$ allora $F_{X}(a)=P(X\leq a)=0$
- Se $0\leq a<1$ allora $F_{X}(a)=P(X\leq a)=\frac{1}{10}$
- Se $1\leq a<2$ allora $F_{X}(a)=P(X\leq a)=F_{X}(\{ X=1 \cup \{ X=0 \})=\frac{1}{10}+\frac{6}{10}=\frac{7}{10}$
- Se $a\geq 2$ allora $F_{X}(a)=P(X\leq a)=F_{X}(\{ X=0 \}\cup \{ X=1 \}\cup \{ X=\text{} \})=\frac{1}{10}+\frac{6}{10}+\frac{3}{10}=1$

Quindi guardando meglio la funzione abbiamo che:

$$
F_{X}(a)=
\begin{cases}
0 \ se \ a<0 \\
\frac{1}{10} \ se \ 0\leq a <1 \\
\frac{7}{10} \ se \ 1\leq a < 2 \\
1 \ se \ a\geq 2
\end{cases}
$$

![[Pasted image 20241028215529.png|500]]

In generale se $X$ è variabile aleatoria che assume $n$ valori dati da $X_{1}\leq X_{2}\leq\dots\leq X_{n}$ allora si ha che:

$$
F_{X}(a)=
\begin{cases}
0 \ \ \ se \ a<X_{1} \\
P(X_{1}) \ \ \ se \ X_{1}\leq a <X_{2} \\
P(X_{1})+P(X_{2}) \ \ \ se \ X_{2}\leq  a < X_{3} \\
. \\
P(X_{1})+P(X_{2})+\dots+P(X_{k}) \ \ \ se \ X_{k}\leq a < X_{k+1} \\
. \\
1=P(X_{1})+\dots+P(X_{n}) \ \ \ se \ a\geq X_{n}
\end{cases}
$$

E vista come grafico:

![[Pasted image 20241028220218.png]]

_Esercizio_

Estraggo 3 carte da un mazzo da 40. Sia $X:=\#\text{Carte di bastoni uscite}$ determinare $P_{X},F_{X},E[X]$

- $P(X=0)=\frac{\binom{30}{3}}{\binom{40}{3}}=\frac{812}{1976}$
- $P(X=1)=\frac{\binom{30}{2}\binom{10}{1}}{\binom{40}{3}}=\frac{870}{1976}$
- $P(X=2)=\frac{\binom{30}{1}\binom{10}{2}}{\binom{40}{3}}=\frac{270}{1976}$
- $P(X=3)=\frac{\binom{10}{3}}{\binom{40}{3}}=\frac{24}{1976}$

Quindi abbiamo:

$$
E[X]=0\cdot \frac{812}{1976}+1\cdot \frac{870}{1976}+2\cdot \frac{270}{1976}+3\cdot \frac{24}{1976}=\frac{1482}{1976}
$$

E per $F(a)$:

$$
F_{X}(a)=
\begin{cases}
0 \ se \ a<0 \\
\frac{812}{1976} \ se \ 0\leq a< 1 \\
\frac{812}{1976}+\frac{870}{1976} \ se \ 1\leq a < 2 \\
\frac{812}{1976}+\frac{870}{1976} + \frac{270}{1976} \ se \ 2\leq a < 3 \\
1 \ se \ a\geq 3
\end{cases}
$$


## Varianza di una variabile aleatoria
Sia $X$ una v.a. discreta, la varianza di $X$ è definita come $Var(X):=E[(X-\underbrace{ EX }_{ \text{valore atteso} })^2]$.

La varianza torna utile perché quantifica quanto la v.a. $X$ si discosta dal suo valore atteso.

_Esempio_

Sia $X$ una v.a. con $X(1)=\frac{1}{2}$ e $X(-1)=\frac{1}{2}$ abbiamo che:

$$
E[X]=EX=1\cdot \frac{1}{2} + -1\cdot \frac{1}{2}=0
$$

e quindi:

$$
Var(X)=E[(X-EX)^2]=E[(X-0)^2]=E[X^2]=1
$$

_Esempio_

Sia $X$ una v.a. che assume i valore $\{ -3,0,1,2 \}$ con:
- $P_{X}(-3)=\frac{2}{10}$
- $P_{X}(0)=\frac{1}{10}$
- $P_{X}(1)=\frac{4}{10}$
- $P_{X}(2)=\frac{3}{10}$

Calcolare $EX$ e $Var(X)$.

- $EX=-3\cdot \frac{2}{10}+0\cdot \frac{1}{10}+ 1\cdot \frac{4}{10}+2\cdot \frac{3}{10}=\frac{4}{10}$

$$
Var(X)=E\left[ \left( X-\frac{4}{10} \right)^2 \right]
$$

Ma come calcoliamo $\left( X-\frac{4}{10} \right)^2$? Dobbiamo vedere i singoli casi

- $X=-3 \to (X-0.4)^2=(-3-0.4)^2=11.56$
- $X=0 \to (X-0.4)^2=(-0-0.4)^2=0.16$
- $X=1 \to (X-0.4)^2=(1-0.4)^2=0.36$
- $X=2 \to (X-0.4)^2=(2-0.4)^2=2.56$

Quindi otteniamo:

$$
(X-0.4)^2=
\begin{cases}
11.56 \text{ con probabilità } \frac{2}{10} \\
0.16 \text{ con probabilità } \frac{1}{10} \\
0.36 \text{ con probabilità } \frac{4}{10} \\
2.56 \text{ con probabilità } \frac{3}{10}
\end{cases}
$$

E quindi:

$$
Var(X)=E[(X-0.4)^2]=11.56\cdot 0.2+0.16\cdot 0.1+0.36\cdot 0.4+2.56\cdot 0.3=3.24
$$

### Non linearità della Varianza

Non è lineare infatti $Var(aX+b)=a^2Var(X)$

_Dimostrazione_

$$
\begin{align*}
Var(aX+b)&=E[((aX+b)-E[aX+b])^2] \\
\text{Linearità di E } &=E[(aX+\cancel b-aEX-\cancel b)^2] \\
\text{Raccogliamo } &=E[a^2(X-EX)^2] \\
\text{Linearità di E } &= a^2\underbrace{ E[(X-EX)^2] }_{ \text{Definizione Varianza} }=a^2Var(X)
\end{align*}
$$

Quindi abbiamo anche che:

$$
\sigma_{aX+b}=\sqrt{ Var(aX+b) }=|a|\sqrt{ Var(X) }=|a|\sigma_{X}
$$

_Deviazione Quadrata sotto_

## Deviazione Quadrata
Sia $X$ una v.a., la deviazione quadrata standard di $X$ è data da $\sigma_{X}:=\sqrt{ Var(X) }$

---

Dati $(S,P)$ e $X:S\to \mathbb{R}$

Sia $f:\mathbb{R}\to \mathbb{R}$. Denoto con $f(X)$ la variabile aleatoria $f\circ X$, abbiamo quindi che:

$$
\underbrace{ S\xrightarrow{X}\mathbb{R}\xrightarrow{f}\mathbb{R} }_{ f\circ X=f(X) }
$$

- $f(X):S\to \mathbb{R}$ è una variabile aleatoria discreta

Infatti:
- $X:S\to \mathbb{R}$ assume valori $\{ X_{i}:i\in I \}$
- $f(X)=f\circ X:S\to \mathbb{R}$ assume valori $\{ f(X_{i}):i\in I \}$

_Esempio_

Lancio 10 volte una moneta e $X=\#\text{Teste Uscite}$. Vinco 2 Euro per ogni testa e perdo 1 euro per ogni croce.

$Y=\#\text{Guadagno Algebrico}$, posso esprimere $Y$ come $f(X)$.

$$
Y=2\cdot X-1(10-X)=3X-10 \ \ \ \ \ Y=f(X)\text{ dove } f:\mathbb{R}\to \mathbb{R}
$$

---

Ho $(S,P)$ e $X:S\to \mathbb{R}$ v.a.

Ho $f:\mathbb{R}\to \mathbb{R}$, se $X$ è una v.a. discreta, allora $f\circ X=f(X)$ è v.a. discreta.

Ci interessa calcolare $E[f(X)]$ 

_Primo Metodo_

Determino i possibili valori di $f(X)$ che chiamo $\{ y_{j}:j\in J \}$ e calcolo $P(f(X)=y_{j}) \ \ \forall j\in J$. Quindi per definizione:

$$
E[f(X)]=\sum_{j}y_{j}\cdot P(f(X)=y_{j})
$$

_Secondo Metodo_ **Teorema**

Sia $X$ v.a. discreta che assume valori $\{ X_{i} \}_{i\in I}$ e sia $f:\mathbb{R}\to \mathbb{R}$. Allora:

$$
E[f(X)]=\sum_{i\in I} f(X_{i})\cdot P(X=X_{i})=\sum_{i\in I}f(X_{i})\cdot P_{X}(X_{i})
$$

_Dimostrazione_

![[Pasted image 20241030221242.png]]

_Esempio_

Data $X$ che assume valori $-1,0,3$ con prob $0.2,0.5,0.3$ rispettivamente. Calcolare $E((X-1)^2)$.

_Primo Metodo_

$$
Y=(X-1)^2 \text{ assume valori } 
\begin{cases}
4 \text{ se } X=-1 \ o \ X=3 \\
1 \text{ se } X=0
\end{cases}
$$

- $P(Y=4)=P(X=-1)+P(X=3)=0.2+0.3=0.5$
- $P(Y=1)=P(X=0)=0.5$
- $E[Y]=4\cdot 0.5+1\cdot 0.5=2.5$

_Secondo Metodo_

$$
\begin{align*}
E[Y]&=f(-1)\cdot P(X=-1)+f(0)\cdot P(X=0)+f(3)\cdot P(X=3) \\
&=(-1-1)^2\cdot 0.2+(0-1)^2 \cdot 0.5 + (3-1)^2 \cdot 0.3 \\
&= 0.8+0.5+1.2=2.5
\end{align*}
$$

---

## Valore atteso con funzione
Se $X$ è v.a. discreta che assume i valori $\{x_{i}\}_{i\in I}$ e $f:\mathbb{R}\to \mathbb{R}$ allora:

$$
E[f(X)]=\sum_{i\in I}f(x_{i})\cdot P(X=x_{i}) \ \ \text{La chiamiamo *}
$$


> [!example]- Esempio
> $X$ assume valori $\{ -1,0,2,3 \}$ e abbiamo che:
> - $P(-1)=0.1$
> - $P(0)=0.2$
> - $P(2)=0.2$
> - $P(3)=0.5$
> 
> Allora:
> 
> $$
> E[(X-1)^4]=E[f(X)] \text{ dove } f(u)=(u-1)^4
> $$
> 
> Calcoliamolo:
> 
> $$
> E[(X-1)^4]=E[f(X)]=f(-1)P(-1)+f(0)P(0)+f(2)P(2)+f(3)P(3)=
> $$
> 
> $$
> =(-1-1)^4\cdot 0.1 + (-1)^4 \cdot 0.2 + (2-1)^4 \cdot 0.2 + (3-1)^4 \cdot 0.5 = 2
> $$

**Linearità del valore atteso**

Sia $X$ v.a. discreta e siano $a,b\in \mathbb{R}$ allora $E[aX+b]=aE[X]+b$

**Dimostrazione**

Sia $\{ x_{i} \}_{i\in I}$ l'insieme dei valori assunti da $X$, inoltre abbiamo che $aX+b=f(X)$ dove $f(u)=au+b$, la scriviamo quindi come funzione di X.

$$
\begin{align*}
E[aX+b]=E[f(X)]\overset{\text{usando *}}= \sum_{i\in I}f(x_{i})P(X=x_{i})&=\sum_{i\in I} (ax_{i} +b)P(X=x_{i}) \\ \\
\text{Proprietà Distributiva }&= \sum_{i}ax_{i}P(x_{i})+bP(x_{i}) \\ \\
\text{Portiamo fuori a,b e spezziamo}&=a\underbrace{ \sum_{i}x_{i}P(x_{i}) }_{ E[X] }+b\underbrace{ \sum P(x_{i}) }_{ 1 }=aE[X]+b
\end{align*}
$$

_Esempio_

$E[X]=1000$ come calcoliamo $E[3X-500]$ ?

Applichiamo la formula -> $E[3X-500]=3E[X]-500=3000-500=2500$

**Proposizione**

Ricordando che la **varianza** si calcola $Var(X):=E[(X-EX)^2]$, possiamo anche calcolarla come:

$$
Var(X)=E[X^2]-(EX)^2
$$

_Dimostrazione_

$$
\begin{align*}
Var(X)=E[(X-EX)^2]&=E[f(X)] \text{ dove } f(u)=(u-EX)^2 \\
\text{Per teorema * } E[f(X)]&=\sum_{i}f(x_{i})P(x_{i})=\sum_{i}(x_{i}-EX)^2P(x_{i}) \\
&=\sum_{i}(x_{i}^2-2x_{i}EX+(EX)^2)P(x_{i}) \\
&=\underbrace{ \sum_{i}x_{i}^2P(x_{i}) }_{ E[X^2] \text{ per *} }-\underbrace{ 2EX\sum_{i}x_{i}P(x_{i}) }_{ -2EX\cdot EX }+\underbrace{ (EX)^2\sum_{i}P(x_{i}) }_{ (EX)^2 } \\
&=E[X^2]-2(EX)^2+(EX)^2=E[X^2]-(EX)^2
\end{align*}
$$



> [!example]- Esempio
> $X$ assume valori $\{ -1,0,2,3 \}$ e abbiamo che:
> - $P(-1)=0.1$
> - $P(0)=0.2$
> - $P(2)=0.2$
> - $P(3)=0.5$
>   
>   $EX=-1\cdot 0.1+0\cdot 0.2 + 2\cdot 0.2 + 3\cdot 0.5=1.8$
>   
>   $Var(X)=E[X^2]-(EX)^2$
>   
>   Calcoliamo $E[X^2]=(-1)^2P(-1)+(0)^2P(0)+2^2P(2)+3^2P(3)=5.4$
>   
>   E quindi $Var(X)=5.4-(1.8)^2=2.16$
>   
>   Usando l'altra formula:
>   
>   $Var(X)=E((X-EX)^2)=(-1-1.8)^2P(-1)+(0-1.8)^2P(0)+(2-1.8)^2P(2)+(3-1.8)^2P(3)$

---

Ricordiamo la **deviazione quadratica standard**.

$$
=\sqrt{ Var(X) }
$$

Osserviamo che $Var(X)$ deve essere sempre $\geq 0$ infatti $Var(X)=E[(X-EX)^2]$ che è si un numero qualsiasi ma elevato al quadrato e quindi o 0 o positivo.

$$
Var(X)=0\Leftrightarrow P(X=EX)=1
$$

Se la varianza è uguale a 0 significa che la variabile è costante infatti $Var(X)$ misura quando $X$ si sposta dal suo valore atteso $E[X]$.

_Osservazione_

Nè la varianza nè la deviazione quadratica sono lineari infatti:

**Proprietà**

Data $X$ v.a. discreta e dati $a,b\in \mathbb{R}$ vale:

$$
Var(aX+b)=a^2Var(X)
$$

E quindi notiamo che amplifica le costanti moltiplicative e annulla quelle additive.

> [!example]- Esempio
> Consideriamo 100 lavoratori di cui 80 hanno salario 500, 10 hanno 1000 e 10 hanno 5000. Scegliamo un lavoratore a caso e indichiamo con $X$ il suo salario. Determinare $E[X],Var(X),\sigma(X)$.
> 
> Abbiamo che $X$ può assumere (500,1000,5000) con:
> - $P(500)=0.8$
> - $P(1000)=0.1$
> - $P(5000)=0.1$
> 
> $E[X]=500\cdot 0.8+1000\cdot 0.1+5000\cdot 0.1=1000$
> 
> $Var(X)=E[(X-EX)^2]=E[(X - 1000)^2]=(500-1000)^2P(500)+(1000-1000)^2P(1000)+(5000-1000)P(5000)=1800000$
> 
> $\sigma(X)=\sqrt{ 1800000 }=1341.64$

## Variabile di Bernoulli
Una v.a. $X$ è detta di Bernoulli di parametro $p\in[0,1]$ se $P(X=1)=p$ e $P(X=0)=1-p$, quindi questa può assumere soltanto due valori.

Quindi in questo caso notiamo che:

$$
E[X]=1\cdot P(X=1)+0\cdot P(X=0)=1\cdot p+0\cdot(1-p)=p
$$

Mentre

$$
Var(X)=E[X^2]-(EX)^2=p-p^2=p\cdot(1-p)
$$

Dove

$$
E[X^2]= 1^2\cdot P(X=1)+0^2\cdot P(X=0)=p
$$

## Variabile Aleatoria Binomiale
Dato un esperimento con $n$ prove indipendenti, tutte svolte nello stesso modo, supponiamo che ogni prova abbiamo due esiti possibili che chiamiamo _successo_ e _insuccesso_.

> [!example]- Esempi
> Lancio una moneta 10 volte, i 10 lanci solo le prove e come successo stabilisco che deve uscire testa.
>
>Lancio un dado 8 volte, gli 8 lanci sono le prove e come successo stabilisco quando esce un numero multiplo di 3.
> 

Definiamo $X=\#\text{Successi Ottenuti}$ nelle prove, notiamo quindi che può assumere come valore, tutti i valori interi da $0$ a $n$, ma con che probabilità?

Chiamiamo $p$ la probabilità che una singola prova ci dia successo come esito.

**Proposizione**

$$
\forall k=0,1,2,\dots,n \text{ vale } P(X=k)=\binom{n}{k}\cdot p^k\cdot(1-p)^{n-k}
$$

Prendiamo l'esempio 2 quindi abbiamo $n=8,p=\frac{1}{3}$ e calcoliamo la probabilità di due successi:

$$
P(X=2)=\binom{8}{2}\cdot\left( \frac{1}{3} \right)^2 \cdot\left( \frac{2}{3} \right)^6
$$

**Perché vale questa proposizione?**

Supponiamo di avere 4 prove e ci chiediamo $P(X=2)$, questo evento $\{ X=2 \}$ possiamo vederlo come unione di varie prove:

$$
E_{SSII}\cup E_{SISI}\cup E_{SIIS}\cup E_{ISSI}\cup E_{IISS}\cup E_{ISSI}
$$

Dove i pedici indicano successi e insuccessi.

Abbiamo $\binom{4}{2}$ eventi, in generale $\binom{n}{k}$.

Adesso se calcoliamo la probabilità di tutti questi eventi:

$$
\begin{align*}
P(X=2)&=P(E_{SSII})+\dots+P(E_{ISSI}) \\
&=p\cdot p\cdot (1-p)\cdot (1-p))+\dots+ ((1-p)\cdot p \cdot p \cdot (1-p))
\end{align*}
$$

Hanno tutti la stessa probabilità che è data da $p^2 \cdot (1-p)^2$ quindi è uguale a:

$$
\binom{4}{2}\cdot p^2 \cdot (1-p)^2
$$

Ovviamente abbiamo $p=2$ e quindi $n-k=2$ ma dipende da quanti esiti con successo abbiamo. **Vale quindi la proposizione generale vista sopra**.

### Definizione
Una v.a. binomiale di paramentri $n\in \{ 1,2,3,\dots \}$ e $p\in[0,1]$ è una v.a. che assume valori $0,1,2,\dots,n$ con la stessa probabilità:

$$
P(X=k)=\binom{n}{k}\cdot p^k \cdot (1-p)^k \ \ \ \forall k\in \{ 0,1,2,\dots,n \}
$$

**Teorema**

Indichiamo con $X=Bin(n,p)$ una v. binomiale di parametri $n,p$.

Sia $X=Bin(n,p)$ allora:

$$
E[X]=n\cdot p \text{ e } Var(X)=n\cdot p \cdot (1-p)
$$

Se $n=1$ e $X=Bin(n,p)$ ho che $X$ assume i valori $0,1$ e:

$$
P(X=1)=\binom{n}{1}\cdot p^1 \cdot (1-p)^{n-1}=\binom{1}{1}p^1(1-p)^0=p
$$

Mentre

$$
P(X=0)=1-p
$$

Quindi notiamo che $Bin(1,0)=Bernoulli(p)$ ovvero una variabile aleatoria di Bernoulli di parametro $p$.

> [!Example]- Esercizio
> Lancio 5 volte una moneta onesta. Sia $X=\#\text{Teste Uscite}$ determinare la probabilità discreta di $X,EX, Var(X),\sigma(X)$.
> 
> **Dobbiamo riconoscere che è binomiale!**
> 
> Infatti $X=Bin\left( 5, \frac{1}{2} \right)$ ovvero 5 prove e il successo è che esce testa.
> 
> Calcoliamo $P_{X}$, sappiamo che $X$ assume $0,1,2,3,4,5$ ovvero le possibili teste quindi per questi valori $k$ calcoliamo:
> 
> ![[Pasted image 20241104201401.png|500]]
> 
> Poi abbiamo che:
> 
> $$
> E[X]=np=5\cdot \frac{1}{2}=2.5
> $$
> 
> $$
> Var(X)=np(1-p)=5\cdot \frac{1}{2} \cdot \frac{1}{2} = 1.25
> $$
> 
> $$
> \sigma_{X}=\sqrt{ 1.25 }=1.118
> $$
> 

---

Perché le costanti additive non importano nella varianza?

Prendiamo come esempio due grafici di due probabilità:

![[Pasted image 20241108153446.png|500]]

Notiamo che se trasliamo la probabilità di una costante, i grafici rimangono uguali ma vengono traslati, la varianza quindi rimane la stessa, dato che misura la dispersione dal valore atteso.

Quindi $Var(X)$ e $Var(X+b)$ coincidono.

Per vederlo meglio:

![[Pasted image 20241108153745.png|500]]

Qui infatti abbiamo che $Var(X)<Var(Y)$, notiamo infatti che nel grafico di $P_{Y}$ abbiamo più dispersione dal valore atteso rispetto al grafico di $P_{X}$

## Variabile Aleatoria di Poisson
Una variabile aleatoria $X$ è detta di Poisson di parametro $\lambda>0$ se assume valori $0,1,2\dots$(tutti valori interi) e:

$$
P_{X}(k)=P(X=k)=e^{-\lambda}\cdot \frac{\lambda^{k}}{k!} \ \ \ \forall k=0,1,2,\dots
$$

Per verificare l'esistenza della variabile aleatoria di Poisson di parametro $k$ devo verificare:

$$
\begin{cases}
P_{X}(k)\geq 0 \ \ \ \forall k=0,1,2,\dots \\
 \\
\sum\limits_{k=0}^{\infty} P_{X}(k)=1
\end{cases}
$$

Infatti:

$$
\sum_{k=0}^\infty P_{X}(k)=\sum_{k=0}^\infty e^{-\lambda}\cdot \frac{\lambda^k}{k!}=e^{-\lambda}\cdot \underbrace{ \sum_{k=0}^\infty \frac{\lambda^k}{k!}U }_{ \text{Serie Esponenziale} } =e^{-\lambda}\cdot e^{\lambda}=1
$$

La variabile aleatoria di Poisson è un'approssimazione della variabile aleatoria binomiale $Bin(n,p)$ quando $n$ è molto grande e $p$ è piccolo, più precisamente:

**Teorema, Legge dei piccoli numeri**

Dato $n\in \{ 1,2,\dots \}$ sia $P_{n}\in[0,1]$ tale che:

$$
\exists \lim_{ n \to \infty } nP_{n} =: \lambda >0
$$

Allora posto $X_{n}=Bin(n,P_{n})$ e $Z=Pos(\lambda)$ ho:

$$
\lim_{ n \to \infty } P(X_{n}=k)=P(Z=k) \ \ \ \forall k\in \{ 0,1,2,\dots \}
$$


Quindi per $n$ grande possiamo approssimare $P(X_{n} = k) \approx P(Z=K)$, quindi in alcune situazioni abbiamo che:

$$
Bin(n,p)\approx Poisson(\lambda)
$$

Dove presi $n,p,\lambda$ abbiamo che:

$$
\begin{align*}
&n\gg 1 \text{ (molto grande)} \\
&np \approx \lambda \text{ quindi anche } p\approx \frac{\lambda}{n} 
\end{align*}
$$

Cosa intendiamo per $Bin(n,p)\approx Poisson(\lambda)$? Intendiamo che:

$$
P(X=k)\approx  P(Z=k) \ \ \ \forall k=0,1,2,\dots
$$

Dove $X=Bin(n,p)$ e $Z=Poisson(\lambda)$

_Esempio di grandezza ben modellizzata da una variabile aleatoria di Poisson_

Prendiamo la pagina di un libro e consideriamo la probabilità che un carattere venga stampato in modo errato. Quindi abbiamo una v.a. binomiale infatti un numero di prove $n$ e due esiti, successo se stampato male e insuccesso altrimenti.

Notiamo che $n$ è il numero di caratteri ed è molto alto all'interno di una pagina, e $p$ possiamo assumerla piccola.

Possiamo quindi assumere $Bin(n,p)\approx Poisson(\lambda)$ dove $\lambda=n\cdot p$

_Esempio più concreto_

Supponiamo che il numero di errori tipografici per pagina sia approssimato da $Poiss\left( \frac{1}{2} \right)$:

- Qual è la probabilità che ci sia almeno un errore a pagina 20?

Consideriamo quindi $z:=\#\text{Errori a pagina 20}$ e abbiamo quindi che:

$$
\begin{align*}
&z=Poiss(\lambda) \ \ \ \lambda=\frac{1}{2} \\
 \\
&P(z=k)=e^{-\frac{1}{2}}\cdot\left( \frac{1}{2} \right)^k \cdot \frac{1}{k!}
\end{align*}
$$

Possiamo considerare il fatto che ci sia almeno un errore come l'evento complementare di non ci sono errori, quindi possiamo calcolare:

$$
P(z\geq 1)=1-P(z=0)=1-e^{-\frac{1}{2}}\cdot\left( \frac{1}{2} \right)^0 \cdot \frac{1}{0!}=1-e^{-\frac{1}{2}}\approx 0.393
$$

- Qual è la probabilità che ci siano esattamente 4 errori?

Dobbiamo quindi calcolare:

$$
P(z=4)=e^{-\frac{1}{2}}\cdot\left( \frac{1}{2} \right)^4 \cdot \frac{1}{4!}=\frac{1}{\sqrt{ e }}\cdot \frac{1}{16} \cdot \frac{1}{24}\approx0.00158
$$

**La Poisson approssima una binomiale $Poiss(\lambda)\approx Bin\left( n,\frac{\lambda}{n} \right)$ per un $n$ abbastanza grande**

**Teorema, Valore Atteso e Varianza Poisson**

Se $X=Poiss(\lambda)$ allora $E[X]=\lambda$ e anche $Var(X)=\lambda$

---

Dimostrazione legge piccoli numeri, non mi va di scriverla per bene =P

![[Pasted image 20241108164547.png]]

---

## Variabile Aleatoria Geometrica
Immaginiamo di ripetere in maniera indipendente una prova (lancio dado $\infty$ volte). Ogni prova ha successo con probabilità $p$ e insuccesso con $1-p$.

Sia $X$ il numero di prove necessarie per ottenere il primo successo.

$$
P(X=k) \ \ \ k=1,2,3,\dots
$$

Quindi:

$$
P(X=k)=\underbrace{ (1-p) }_{ \text{Prova 1, ins.} }\cdot \underbrace{ (1-p) }_{ \text{Prova 2 ins.} }\cdot (1-p) \cdots p \to \text{Ultima prova, successo}
$$

Quindi abbiamo che:

$$
P(X=k)=(1-p)^{k-1} \cdot p \ \ \ \forall k=1,2,\dots
$$

Tecnicamente però potrei sempre ottenere un insuccesso e quindi avere che $X=+\infty$ e quindi avrei che:

$$
P(X=+\infty)=(1-p)^{\infty}=0 \ \ \ \text{con } 0<p<1 
$$

Questo significa che l'evento è possibile ma ha una probabilità nulla, questa strana situazione è data dal fatto che l'insieme degli esiti è un insieme non numerabile.

Oppure possiamo dimostrare che questo risultato è 0 svolgendo:

$$
P(X=\infty)=1-P(X<\infty)=1-1=0
$$

Dove

$$
P(X<\infty)=\sum^\infty_{k=0}P(X=k)=\sum^\infty_{k=0}(1-p)^k\cdot p=p\underbrace{ \sum^\infty_{k=0}(1-p)^k }_{ \text{Serie Geometrica} }=p\cdot \frac{1}{1-(1-p)}=1
$$

Infine possiamo dire che in una v.a. geometrica:

$$
EX=\frac{1}{p} \qquad Var(X)=\frac{1-p}{p^2}
$$

> [!Example]- Esercizio
> Lancio un dado finché non esce 6.
> a) Calcolare valore atteso del numero di lanci effettuati
> b) Calcolare probabilità di aver effettuato almeno 7 lanci
> 
> a)
> 
> $$
> \begin{align*}
> &P(\text{Esce 6})=\frac{1}{6}=p \\
> &X=\text{Lanci effettuati fino al primo 6}=Geom\left( \frac{1}{6} \right) \\
> &E[X]=\frac{1}{\frac{1}{p}}=\frac{1}{\frac{1}{6}}=6
> \end{align*}
> $$
> 
> b) Abbiamo $p=\frac{1}{6}$ come prima e anche la v.a. $X$. Adesso però dobbiamo calcolare $P(X=7)$
> 
> $$
> P(X=7)=(p)^{k-1}=\left( \frac{5}{6} \right)^6
> $$
> 

## Variabile Aleatoria Binomiale Negativa
Dipende da due parametri, $p\in(0,1)$ che è la probabilità di successo in una prova e $r\in \{ 1,2,3\dots \}$ intero che indica il numero di successi che voglio ottenere.

_Esempio Chiave_

Considero una successione di prove indipendenti di tipo successo / insuccesso.

$$
X:=\#\text{Prove effettuate fino ad avere } r \text{ successi per la prima volta}
$$

Allora $X=\text{Bin\_Neg}(p,r)$, $X$ assume valori $r,r+1,r+2,\dots$ quindi dato $k\in \{ r,r+1,r+2\dots \}$ come calcoliamo $P(X=k)$?

Sappiamo che sicuramente la k-esima prova deve avere come esito successo, mentre nelle k-1 prove dobbiamo avere sicuramente r-1 successi ma non ci importa in che ordine, possiamo quindi scriverlo come:

$$
P(X=K)=P(\text{Ho r-1 successi nelle prime k-1 prove})\cdot p
$$

A questo punto possiamo utilizzare la binomiale per calcolare la probabilità dei r-1 successi:

$$
\binom{k-1}{r-1}\cdot p^{r-1}\cdot(1-p)^{(k-1)-(r-1)}=\binom{k-1}{r-1}\cdot p^{r-1}\cdot(1-p)^{k-r}
$$

Quindi moltiplicando per $p$ dell'ultimo successo otteniamo:

$$
P(X=k)=\binom{k-1}{r-1}\cdot p^{r}\cdot(1-p)^{k-r}
$$

Inoltre sappiamo che:

$$
X=\text{Bin\_Neg}(p,r) \Rightarrow E[X]=\frac{r}{p} \qquad Var(X)=\frac{r(1-p)}{p^2} 
$$

> [!info] Osservazione
> 
> ![[actually.png|100]]
> 
> Se $r=1$ ovvero il numero di successi uguale a 1 otteniamo le stesse formule delle geometrica

> [!Example]- Esercizio
> In un gioco si estrae una pallina a caso da un'urna con 40 palline di cui una dorata, se si estrae quest'ultima si vince un peluche. Vogliamo giocare finché non vinciamo 2 peluche e ogni giocata costa 1.50 euro. Calcolare il valore atteso della spesa.
> 
> Definiamo:
> - $X=\#\text{Numero di volte che giochiamo}$
> - $Y=\text{Spesa Effettuata}$
>   
>   Che relazione c'è fra le due? $Y=1,5\cdot X$ e quindi $E[Y]=1,5\cdot E[X]$, calcoliamo il valore atteso di $X$ dato che è una binomiale negativa:
>   
>   $X=\text{Bin\_Neg}\left( p=\frac{1}{40},r=2 \right)$ questo significa che possiamo calcolare il suo valore atteso con la formula:
>   
>   $$
> E[X]=\frac{r}{p}=\frac{2}{\frac{1}{40}}=80  
> $$ 
> 
> E quindi:
> 
> $$
> E[Y]=1,5\cdot 80 =120
> $$
>   

## Variabile Aleatoria Ipergeometrica

Prototipo: Abbiamo un'urna con $N$ palline di cui $m$ bianche e $N-m$ nere, estraggo senza rimpiazzo $n$ palline con $n\leq N$.

Definiamo $X:=\#\text{Numero palline bianche estratte}$

$X$ è detta **variabile aleatoria di parametri** $N,m,n$

Come si calcola $P(X=k)?$ Numeriamo tutte le palline per distinguerle, nello spazio campionario abbiamo: $\binom{N}{n}$ modi per scegliere $n$ palline. Usiamo il principio fondamentale della combinatoria:

$$
P(X=k)=\frac{\binom{n}{k}\cdot \binom{N-m}{n-k}}{\binom{N}{n}}
$$

Quindi al numeratore abbiamo i modi per scegliere le bianche per i modi per scegliere le nere.

Per quali $k$ abbiamo che $P(X=k)>0$?

$$
P(X=k)\Leftrightarrow \binom{m}{k}>0 \Leftrightarrow 0\leq n-k\leq N-m
$$

Ricordiamo che per i binomiali $\binom{b}{a}$ deve valere $0\leq a\leq b$ altrimenti è 0.

Quindi abbiamo:

$$
\begin{cases}
0\leq k\leq m \\
0\leq n-k \leq N-m
\end{cases}
$$

Ovvero 4 disuguaglianze:

$$
\begin{cases}
0\leq k \\
k\leq m \\
k\leq n \\
n+m-N\leq k
\end{cases}
$$

Scritto in un'unica disuguaglianza:

$$
max(0,n+m-N)\leq k\leq min(m,n)
$$

**Definizione**

Una variabile aleatoria ipergeometrica di parametri $N,m,n$ è una variabile aleatoria discreta con densità di probabilità come il prototipo visto per l'esercizio sopra, cioè:

$$
P(X=k)=\frac{\binom{n}{k}\cdot \binom{N-m}{n-k}}{\binom{N}{n}}
$$

Inoltre abbiamo che:

$$
E[X]=\frac{n\cdot m}{N} \qquad Var(X)=np(1-p)\left( 1-\frac{n-1}{N-1} \right) \qquad \text{dove } p=\frac{m}{N}
$$

_Esempio_

Un rivenditore acquista componenti a lotti da 10, per ogni lotto controlla a caso 3 componenti e mantiene il lotto solo se i 3 componenti sono buoni. Il 30% dei lotti ha 4 componenti difettosi mentre il 70% ne ha soltanto 1 difettoso. Che % di lotti rifiuterà il rivendtiore?

Definiamo $X:=\#\text{Pezzi difettosi tra i 3 scelti dal lotto}$

Calcoliamo $P(X\geq 1)$ ovvero che ci sia almeno un pezzo difettoso.

$$
\begin{align*}
&P(X\geq 1) = 1-P(X=0) \\
 \\
&P(X=0)=P(X=0|E)P(E)+P(X=0|E^C)P(E^C) \\
&\text{Dove E indica che il lotto ha 4 pezzi difettosi} \\
 \\
&P(X=0|E)=\frac{\binom{4}{0}\binom{6}{3}}{\binom{10}{3}} \\
 \\
&P(X=0|E^C)=\frac{\binom{1}{0}\binom{9}{3}}{\binom{10}{3}} \\
 \\
&\text{Quindi:} \\
 \\
&P(X=0)=\frac{\binom{4}{0}\binom{6}{3}}{\binom{10}{3}} \cdot 0.3 + \frac{\binom{1}{0}\binom{9}{3}}{\binom{10}{3}} \cdot 0.7
\end{align*}
$$


> [!Example]- Esempio
> 50 studenti di cui 7 con occhi verdi, scegliamo a caso 10 studenti, calcolare media e varianza di studenti con occhi verdi fra quelli scelti.
> 
> Abbiamo N=50, m=7 e n=10 mentre $X:=\#\text{Studenti con occhi verdi}$.
> 
> $$
> E[X]=\frac{nm}{N}=\frac{7}{5} 
> $$
> 
> Mentre per la varianza:
> 
> $$
> Var(X)=10\cdot \frac{7}{50}\cdot\left( \frac{43}{50} \right)\cdot \left( 1- \frac{9}{49} \right)
> $$
> 
> Infatti $p=\frac{7}{50}$
> 


> [!NOTE] Osservazione
> 
> ![[actually.png|100]]
> 
>
> Prima abbiamo visto esempi senza rimpiazzo, cosa succede reinserendo ad esempio le palline estratte? Otteniamo semplicemente una binomiale, infatti avremo un numero di prove tutte uguali e indipendenti.
> 

---

## Recap Variabile Aleatoria

- $X$ variabile aleatoria è una funzione $X:S\to \mathbb{R}$
- $X$ è discreta se l'insieme dei possibili valori $\{ x_{i} \}_{i\in I}$ è finito oppure infinito numerabile

In varaibili aleatorie discrete, abbiamo introdotto la densità di probabilità discreta $p_{X}:\{ x_{i} \}_{i\in I}\to[0,1]$, definita come $p_{X}(x_{i}):= P(X=x_{i})$.

**Proposizione**

$$
\sum_{i\in I}p_{X}(x_{i})=1 \qquad \text{Per X v.a. discreta}
$$

_Dimostrazione_

Definiamo $E_{i}:=\{ X=x_{i} \}$ al variare di $i\in I$. Gli eventi $E_{i}$ sono una famiglia numerabile di eventi perché $X$ è una variabile aleatoria discreta, inoltre gli eventi sono 2 a 2 incompatibili.

Per l'additività finita se $I$ è finito e per l'additività numerabile se $I$ è infinito numerabile ho:

$$
P\left( \bigcup_{i\in I}E_{i} \right)=\sum_{i\in I}P(E_{i})
$$

Inoltre notiamo che:

$$
\bigcup_{i\in I}E_{i}=S\Rightarrow P(\bigcup_{i\in I}E_{i})=P(S)=1
$$

Infatti l'unione di tutti gli eventi è l'evento certo.

E quindi:

$$
1=P\left( \bigcup_{i\in I}E_{i} \right)=\sum_{i\in I} \overbrace{ P(E_{i}) }^{ \{ X=x_{i} \} }=\sum_{i\in I}p_{X}(x_{i})
$$

> [!info] Osservazione
> 
> ![[actually.png|100]]
> 
> Se $X$ è v.a. generica allora non è vero che $\sum\limits_{x}P(X=x)=1$ dove $x$ è un possibile valore di $X$.

**Definizione**

Date due v.a. $X$ e $Y$ definite sullo stesso spazio campionario, ovvero sono entrambe delle funzioni definite come $S\to \mathbb{R}$, entrambe discrete dove $X$ ha valori in $\{ x_{i} \}_{i\in I}$ e $Y$ ha valori in $\{ y_{j} \}_{j\in J}$.

La **densità di probabilità discreta congiunta** denotata con $p_{X,Y}$ è la funzione:

$$
p_{X\times Y}:= \{ x_{i} \}_{i\in I} \times \{ y_{j} \}_{j\in J}\to[0,1]
$$

È quindi definita sul prodotto cartesiano dei due insiemi, è inoltre definita come:

$$
p_{X,Y}(x_{i},y_{j})=P(X=x_{i},Y=y_{j})
$$


> [!example]- Esempio
> 
> Supponiamo di lanciare un dado 2 volte, chiamiamo $X:=\#\text{Lanci in cui ho faccia pari}$ e $Y:=\#\text{Lanci in cui esce multiplo di 3}$. Come calcoliamo $p_{X,Y}$?
> 
> $X$ ha valori in $\{ 0,1,2 \}$ mentre $Y$ in $\{ 0,1,2 \}$.
> 
> $$
> p_{X,Y}(x,y)=P(X=x,Y=y)
> $$
> 
> Dobbiamo calcolare quindi 9 valori
> 
> 
>| X/Y | 0   | 1   | 2   |
>| --- | --- | --- | --- |
>| 0   |  $\frac{4}{36}$   |  $\frac{4}{36}$   |  $\frac{1}{36}$   |
>| 1   |  $\frac{4}{36}$   |  $\frac{8}{36}$   |     |
>| 2   |     |     |     |
>
>Dove per ogni casella calcoliamo $P(X,Y)$ dove al posto di $X$ e $Y$ inseriamo il corrispondente valore della variabile aleatoria.
>
>- Prima Riga
>- $p_{X,Y}(0,2)=P(X=0,Y=2)=P(\{ 3,3 \})=\frac{1}{36}$
>- $p_{X,Y}(0,0)=P(X=0,Y=0)=\frac{2\cdot 3}{36}$
>- $p_{X,Y}(0,1)=P(X=0,Y=1)=P((3,1),(3,5),(1,3),(5,3))=\frac{4}{36}$
> - Seconda Riga
>- $p_{X,Y}(1,0)=P(X=1,Y=0)=P((2,1),(2,5),(4,1),(4,5))=\frac{4}{36}$
>- $p_{X,Y}(1,1)=P(X=1,Y=1)=P((2,3),(4,3),(1,6),(5,6),(6,5),(6,1))=\frac{8}{36}$
>- $p_{X,Y}(1,2)=P(X=1,Y=2)=\dots$
>  
>  Altro metodo è quello di fare la tabella con i casi, in questo caso un 6x6 e poi inserire in ogni casella la coppia di valori (x,y), poi contiamo quante caselle per ogni coppia di valori. 
>  
>  ![[Pasted image 20241115125935.png|250]]
>  
>  Se prendiamo lo stesso esempio ma lanciando il dado una sola volta abbiamo che:
>  
>  $$
>  \begin{cases}
> 1 \qquad X=0,Y=0 \\
> 2 \qquad X=1,Y=0 \\
> 3 \qquad X=0,Y=1 \\
> 4 \qquad X=1,Y=0 \\
> 5 \qquad X=0,Y=0 \\
> 6 \qquad X=1,Y=1
> \end{cases}
> $$
>  
>  E inserendolo nella tabella:
>  
>  
>| X/Y | 0             | 1             |
>| --- | ------------- | ------------- |
>| 0   | $\frac{2}{6}$ | $\frac{1}{6}$ |
>| 1   | $\frac{2}{6}$ | $\frac{1}{6}$ |
>
>Notiamo che la somma di tutti i valori fa 1.
>

**Proposizione**

Siano $X$ e $Y$ v.a. discrete definite su $S$, sia $\{ x_{i} \}_{i\in I}$ l'insieme dei possibili valori di $X$ e sia $\{ y_{j} \}_{j\in J}$ l'insieme dei possibili valori di $Y$.

Allora:
1) $p_{X,Y}(x_{i},y_{j})\in[0,1]$
2) $\sum_{i\in I}\sum_{j\in J}p_{X,Y}(x_{i},y_{j})=1$
3) $p_{X}(x_{i})=\sum_{j\in J}p_{X,Y}(x_{i},y_{j})$
4) $p_{Y}(y_{j})=\sum_{i\in I}p_{X,Y}(x_{i},y_{j})$ 

_Dimostrazione_

1) $p_{X,Y}(x_{i},y_{j})\underset{definizione}=P(X=x_{i},Y=y_{j})\in[0,1]$ 
2) Questa dimostrazione usa le stesse idee della dimostrazione di $\sum\limits_{i\in I}p_{X}(x_{i})=1$ 

Poniamo $E_{ij}=\{ X=x_{i},Y=y_{j} \}$, abbiamo che $p_{X,Y}(x_{i},y_{j})\underset{definizione}= P(X=x_{i},Y=y_{j})=P(E_{ij})$.

Gli eventi $E_{ij}$ al variare di $i\in I,j\in J$ formano una famiglia finita o infinita numerabile di eventi 2 a 2 incompatibili.

Quindi:

$$
\sum_{i\in I,j\in J}p_{X,Y}(x_{i},y_{j})=\sum_{i\in I,j\in J}P(E_{i})\underset{\text{additività}}=P\left( \bigcup_{i\in I,j\in J}E_{ij} \right) =P(S)=1
$$

3) 
   
$$
p_{X}(x_{i})\underset{\text{definizione}}=P(X=x_{i})=P\left( \bigcup_{j\in J}\{ X=x_{i},Y=y_{j} \} \right)=P\left( \bigcup_{j\in J}E_{ij} \right)=\sum_{j\in J}P(E_{ij})=\sum_{j\in J}p_{X,Y}(x_{i},y_{j})
$$ 

4) Dimostrazione simile a (3).

_Esempio_

Ho variabili aleatorie $X,Y$ su $S$. $X$ assume valori $-2,0,5$ e $Y$ assume valori $4,9$. Inoltre $p_{X,Y}$ è data da:

| X / Y | 4              | 9              |
| ----- | -------------- | -------------- |
| -2    | $\frac{1}{10}$ | $\frac{2}{10}$ |
| 0     | $\frac{0}{10}$ | $\frac{1}{10}$ |
| 5     | $\frac{3}{10}$ | $\frac{3}{10}$ |
Dobbiamo determinare $p_{X}$ e $p_{Y}$. Ricordiamo la formula:

$$
p_{X}(x_{i})=\sum_{j}p_{X,Y}(x_{i},y_{j})
$$

Quindi calcolando $p_{X}$

$$
p_{X}(-2)=p_{X,Y}(-2,4)+p_{X,Y}(-2,9)=\frac{1}{10}+\frac{2}{10}=\frac{3}{10}
$$

$$
p_{X}(0)=\frac{0}{10}+\frac{1}{10}=\frac{1}{10}
$$

$$
p_{X}(-2,9)=\frac{1}{10}+\frac{2}{10}=\frac{3}{10}
$$

$$
p_{X}(5)=\frac{3}{10}+\frac{3}{10}=\frac{6}{10}
$$

Mentre per la $p_{Y}$:

$$
p_{Y}(4)=p_{XY}(-2,4)+p_{XY}(0,4)+p_{XY}(5,4)=\frac{1}{10}+\frac{0}{10}+\frac{3}{10}=\frac{4}{10}
$$

$$
p_{Y}(9)=\frac{2}{10}+\frac{1}{10}+\frac{3}{10}=\frac{6}{10}
$$

---

In una v.a. discreta congiunta, le densità che la compongono vengono chiamata **marginali** e conoscendo la congiunta possiamo calcolare le marginali, ma non vale il contrario.

Vediamo un esempio

Abbiamo un'urna con 6 palline numerate da 1 a 6, estraiamo 2 palline con rimpiazzo e definiamo:

$$
\begin{align*}
&X:=\text{Numero della prima pallina} \\
&Y:=\text{Numero della seconda pallina}
\end{align*}
$$

Quindi $X$ assume valori in $\{ 1,2,3,4,5,6 \}$ e con $p_{X}(k)=\frac{1}{6}$ per ogni $k$ da 1 a 6, analogamente per $Y$.

La congiunta $(X,Y)$ assume valori $(a,b)$ con $a,b\in \{ 1,2,3,4,5,6 \}$ e $p_{X,Y}(a,b)=P(X=a,Y=b)=\frac{1}{36}$  $\forall(a,b)\in \{ 1,2,3,4,5,6 \}^2$


Adesso facciamo lo stesso esempio ma senza rimpiazzo:

Quindi le due marginali sono identiche ma per la congiunta abbiamo che:

$$
p_{X,Y}(a,b)=\begin{cases}
\frac{1}{30} \text{ se } a,b\in \{ 1,\dots,6 \} \text{ e } a\neq b \\
0 \text{ se } a,b\in \{ 1,\dots,6 \} \text{ e } a=b
\end{cases}
$$

Infatti la congiunta assume valori $(a,b)$ dove $a,b\in \{ 1,\dots,6 \}$ ma $a\neq b$.

Notiamo quindi che nei due esperimenti le due marginali sono uguali ma la congiunta dipende dall'esperimento e quindi cambia.

> [!Info] Definizione
> Se ho $n$ v.a. discrete $X_{1},\dots X_{n}:S\to \mathbb{R}$ dove $X_{i}$ ha valori in $V_{i}$ con $i=1,\dots,n$ la densità di probabilità discreta congiunta è data da $p_{X_{1},\dots,X_{n}}:V_{1}\times\dots \times V_{n}\to [0,1]$ ed è definita come $p_{X_{1},\dots,X_{n}}(a_{1},\dots,a_{n}):=P(X_{1}=a_{1},\dots,X_{n}=a_{n})$

Adesso torniamo ad un esempio con 2 v.a. definite quindi $X,Y:S\to \mathbb{R}$ e la loro congiunta definite come:

$$
\begin{align*}
&X:S\to \mathbb{R} \qquad S\to X_{S} \\
&Y:S\to \mathbb{R} \qquad S\to Y_{S} \\
&(X,Y):S\to \mathbb{R}^2 \qquad S\to(X_{S},Y_{S})
\end{align*}
$$

Supponiamo di avere una funzione composta $f:\mathbb{R}^2\to \mathbb{R}$ definita:

$$
f(X,Y):S\to \mathbb{R} \qquad S\to f(X_{S},Y_{S})
$$

Questa è una v.a. dato che va da $S$ in $\mathbb{R}$ e se $X,Y$ sono discrete allora lo è anche $f$ dato che se applichiamo una funzione, la cardinalità del codominio è sicuramente minore o uguale a quella del dominio.

Adesso data una v.a. di questo tipo, calcoliamo il valore atteso.

**Proposizione**

Siano $X,Y$ v.a. discrete e $f:\mathbb{R}^2 \to \mathbb{R}$ allora:

$$
E[f(X,Y)]=\sum_{i\in I}\sum_{j\in J}f(x_{i},y_{j})P_{X,Y}(x_{i},y_{j})
$$

Dove $\{ x_{i} \}_{i\in I}$ è l'insieme dei valori di $X$ e $\{ y_{j} \}_{j\in J}$ è l'insieme dei valori di $Y$.

> [!example]- Esempio
> 
> Data la v.a.
> 
> ![[Pasted image 20241120201611.png|200]]
> 
> Calcolare $E[X^2 Y]=\sum_{i}\sum_{j}x_{i}^2y_{j}P_{X,Y}(x_{i},y_{j})$ dove $f:\mathbb{R}^2\to \mathbb{R}$ e definita come $f(a,b)=a^2b$, eseguiamo i calcoli:
> 
> $$
> E[X^2Y]=(-1)^2\cdot 0 \cdot \frac{2}{10}+(-1)^2\cdot 2\cdot \frac{1}{10}+(-1)^2\cdot 3\cdot 0 +\dots = \frac{45}{10}
> $$


**Proposizione**

$E[X+Y]=E[X]+E[Y]$

_Dimostrazione_

Abbiamo $f:\mathbb{R}^2\to \mathbb{R}$ definita da $f(a,b)=a+b$ ovvero $f(X,Y)=X+Y$, possiamo quindi vederla come una funzione e usare la proposizione precedente per calcolare il valore atteso:

$$
\begin{align*}
E[X+Y]&=E[f(X,Y)] \\
&=\sum_{i}\sum_{j}\underbrace{ f(x_{i},y_{j}) }_{ x_{i}+y_{j} }P_{X,Y}(x_{i},y_{j}) \\
&=\sum_{i}\sum_{j}x_{i}P_{X,Y}(x_{i},y_{j})U+\sum_{i}\sum_{j}y_{i}P_{X,Y}(x_{i},y_{j}) \\
&=\sum_{i}x_{i}\underbrace{ \left( \sum_{j}P_{X,Y}(x_{i},y_{j})U \right) }_{ \text{Ruota solo la j, è il calcolo di } P_{X} }+\sum_{j}y_{j}\underbrace{ \left( \sum_{i}P_{X,Y}(x_{i},y_{j}) \right) }_{ \text{Ruota solo la i, è il calcolo di }P_{Y} } \\
&=\underbrace{ \sum_{i}x_{i}P_{X}(x_{i}) }_{ E[X] }+\underbrace{ \sum_{j}y_{j}P_{Y}(y_{j}) }_{ E[Y] } \\
&=E[X]+E[Y]
\end{align*}
$$

In modo analogo si ottiene che:

**Proposizione**

$$
E[X_{1}+\dots+X_{n}]=E[X_{1}]+\dots+E[X_{n}]
$$

In generali dati $a_{1},\dots,a_{n}\in \mathbb{R}$ si ha che:

$$
E[a_{1}X+\dots+a_{n}X_{n}]=a_{1}E[X_{1}]+\dots+a_{n}E[X_{n}]
$$


> [!example]- Esempio
> Lancio un dado 1000 volte, calcolare $E[X]$ dove $X=\text{\#Esce 5}$, notiamo che usando la binomiale quindi $X=Bin(1000,1/6)$ si ha che:
> 
> $$
> E[X]=\sum_{k=0}^1000 k\binom{1000}{k}\left( \frac{1}{6} \right)^k \left( \frac{5}{6} \right)^{1000-k}
> $$
> 
> Ed è molto calcoloso.
> 
> È meglio scomporre questa variabile aleatoria in 1000 variabili più semplici piuttosto che eseguire il calcolo.
> 
> Possiamo scomporla in $X_{1},\dots,X_{1000}$ dove $X_{i}$ vale 1 se alla i-esima prova esce 5, 0 altrimenti, in questo modo otteniamo:
> 
> $$
> E[X]=\sum_{i=1}^{1000} \underbrace{ E[X_{i}] }_{ 1\cdot \frac{1}{6}+0\cdot \frac{5}{6} } = 1000 \cdot \frac{1}{6}
> $$
> 
> Da cui abbiamo trovato la formula $E[X]=np$ per le binomiali, infatti in questo caso abbiamo $n=1000$ e $p=\frac{1}{6}$

**Proposizione**

Se $X=Bin(n,p)\Rightarrow E[X]=np$

_Dimostrazione_

$X=\#Successi$ in $n$ prove indipendenti dove $p=\text{prob. successo}$ allora $X=X_{1}+\dots+X_{n}$ dove $X_{i}$ vale 1 se la i-esima prova ha successo, 0 altrimenti. Allora:

$$
E[X]=E\left[ \sum_{i=1}^n X_{i}\right]=\sum_{i=1}^n\underbrace{ E[X_{i}] }_{ 1\cdot p + 0\cdot (1-p) }=np
$$

---

Prendiamo un'urna con $N$ palline di cui $m$ bianche e $N-m$ nere, estraiamo $n$ palline senza rimpiazzo, questo possiamo farlo in due modi.
1) Estraiamo $n$ palline in un unico blocco
2) Estraiamo una pallina alla volta senza rimpiazzo

Pensiamo al caso di estrarre una pallina alla volta, definiamo quindi: $E_{i}=$ La i-esima pallina estratta è bianca.

$$
\begin{align*}
&E_{1}=\frac{m}{N} \\
&\dots \\
&E_{3}=?
\end{align*}
$$

Possiamo calcolare $E_{3}$ usando la combinatoria ma per altri motivi (?) possiamo dire che:

$$
P(E_{1})=P(E_{2})=\dots=P(E_{n}) \qquad (*)
$$

Quindi sapendo $(*)$ possiamo dire che:

$$
P(E_{i})=\frac{m}{N} \qquad \forall i=1,\dots ,n
$$

Ma perché vale $(*)$?

Prendiamo l'urna e numeriamo le palline per distinguerle:

$$
U=\{ B_{1},B_{2},\dots ,B_{m},N_{1},N_{2},\dots ,N_{N-m} \}
$$

E abbiamo come spazio campionario:

$$
S=\{ (x_{1},x_{2},\dots,x_{n}):x_{i}\in U \ \forall i, x_{1},\dots,x_{n}  \text{ distinti} \}
$$

Abbiamo tutti esiti equiprobabili e quindi $P(E)=\frac{|E|}{|S|}$  $\forall E\subset S$ evento. Adesso supponiamo di avere una mappa bigettiva $f:S\to S$ quindi $\forall E\subset S$ abbiamo che $|E|=|f(E)|$ e quindi:

$$
P(E)=\frac{|E|}{|S|}=\frac{|f(E)|}{|S|}=P(f(E))
$$

> [!NOTE] Cosa abbiamo imparato?
> $$
> \forall f:S\to S \text{ bigettiva}
> $$
> 
> Si ha che:
> 
> $$
> P(E)=P(f(E)) \qquad \forall E\subset S \text{ evento}
> $$

Adesso dimostriamo $(*)$, più precisamente che $P(E_{1})=P(E_{i})$ $i=2,3,\dots,n$.


Scegliamo $i\in \{ 2,3,\dots,n \}$ e abbiamo che $E_{1}=\{ (x_{1},\dots,x_{n})\in S:x_{1}\in \{ B_1,B_{2},\dots,B_{m} \} \}$. Possiamo esibire $f:S\to S$ bigettiva tale che $f(E_{1})=E_{i}$? Se possiamo farlo allora abbiamo che $P(E)=P(f(E_{1}))=P(E_{i})$ .

Prendiamo ad esempio $i=3$, abbiamo $f(x_{1},x_{2},x_{3},\dots ,x_{n})=\{ x_{3},x_{2},x_{1},\dots,x_{n} \}$ ovvero $f$ scambia la prima con la i-esima entrata.

_Esempio_

Scegliamo 5 studenti da inter rogare e definiamo:
- E = Il secondo e il terzo studente scelto sono maschi.
- F = Il quarto e il quinto studente scelto sono maschi.

Abbiamo $C$ come classe e il nostro spazio campionario è:

$$
\begin{align*}
&S=\{ (x_{1},x_{2},\dots,x_{5}):x_{i}\in C\quad\forall i, x_{1},\dots,x_{5} \text{ distinti} \} \\
&E = \{ (x_{1},x_{2},\dots,x_{5})\in S:x_{2},x_{3} \text{ sono maschi} \} \\
&F = \{ (x_{1},\dots,x_{5})\in S : x_{4},x_{5} \text{ sono maschi} \}
\end{align*}
$$

Abbiamo che $P(E)=P(F)$ se esibiamo $f:S\to S$ bigettiva tale che $f(E)=F$, possiamo definire:

$$
f(x_{1},x_{2},x_{3},x_{4},x_{5})=(x_{1},x_{4},x_{5},x_{2},x_{3})
$$

Ovvero che scambia il 2 con il 4 e il 3 con il 5.

Questo metodo vale sempre se si lavora con spazi di probabilità che hanno esiti equiprobabili.

> [!NOTE] Proposizione
> Sia $S$ uno spazio di probabilità con esiti equiprobabili e sia $f:S\to S$ una bigezione. Allora $P(E)=P(f(E))$ $\forall E\subset S$.

_Dimostrazione_

$$
P(E)\underset{\text{esiti quiprobabili}}=\frac{|E|}{|S|}\underset{\text{f è bigettiva}}=\frac{|f(E)|}{|S|}\underset{\text{esiti equiprobabili}}=P(f(E))
$$

> [!NOTE] Proposizione
> Sia $X$ v.a. ipergeometrica con paramentri $N,m,n$ (con il prototipo visto nella ipergeometrica) abbiamo $E[X]=\frac{nm}{N}$

_Dimostrazione_ 

Estraiamo le palline una alla volta e scomponiamo $X=X_{1}+X_{2}+\dots+X_{n}$ dove ogni v.a. $X_{i}$ vale 1 se la i-esima pallina è bianca, 0 altrimenti. Otteniamo quindi:

$$
E[X]=\sum_{i=1}^n E[X_{i}]=\frac{nm}{N}
$$

Infatti:

$$
E[X_{i}]=1\cdot P(E_{i})+0\cdot P(E_{i}^C)=P(E_{i})=P(E_{1})=\frac{m}{N}
$$

Se le $n$ estrazioni sono con rimpiazzo allora $X$ è una v.a. binomiale, infatti con il rimpiazzo tutti gli esperimenti sono identici e non si influenzano. Per dimostrarlo abbiamo usato la linearità del valore atteso in modo molto semplice, altrimenti avremmo dovuto usare metodi più complessi.


> [!NOTE] Definizione - Variabili Aleatorie Indipendenti
> Date $X_{1},X_{2},\dots,X_{n}$ v.a. sullo stesso spazio campionario, queste sono **indipendenti** se:
> 
> $$
> P(X_{1}\in A_{1},\dots,X_{n}\in A_{n})=P(X_{1}\in A_{1}),\dots,P(X_{n}\in A_{n}) \quad \forall A_{1},\dots,A_{n}\subset \mathbb{R}
> $$
> 
> Se ho un esperimento formato da sottoesperimenti operativamente indipendenti, ovvero che non si influenzano allora variabili aleatorie che si riferiscono a sottoesperimenti diversi sono tra loro indipendenti.

_Esempio_

Lanciamo un dado 20 volte, definiamo

$$
\begin{align*} 
&X:= \text{Numero uscito al 3° lancio} \\
&Y:= \text{Numero uscito al 9° lancio} \\
&Z:= \text{Numero uscito al 17° lancio}
\end{align*}
$$

Possiamo provare che $X,Y,Z$ sono v.a. indipendenti.

> [!NOTE] Proposizione
> Siano $X:S\to \mathbb{R}$ e $Y:S\to \mathbb{R}$ v.a. discrete, $X$ assume valori $\{ x_{i} \}_{i\in I}$ e $Y$ assume valori $\{ y_{j} \}_{j\in J}$.
> Allora $X,Y$ sono indipendenti se e solo se:
> 
> $$
> p_{X,Y}(x_{i},y_{j})=p_{X}(x_{i})p_{Y}(y_{j}) \quad \forall i\in I, j\in J
> $$

> [!alert] Nota
>  Per decidere se $X$ e $Y$ sono indipendenti o meno mi basta sapere $p_{X,Y}$ infatti $p_{X}(x_{i})=\sum_{j}p_{X,Y}(x_{i},y_{j})$ e $p_{Y}(y_{j})=\sum_{i}p_{X,Y}(x_{i},y_{j})$.

_Dimostrazione Proposizione_

![[Pasted image 20241125090443.png]]

---

## Covarianza di variabili aleatorie
Date 2 v.a. $X,Y:S\to \mathbb{R}$, ovvero che hanno lo stesso spazio campionario, la covarianza di $X$ e $Y$ è data da:

$$
Cov(X,Y)=E[(X-EX)\cdot(Y-EY)]
$$

Questa ha varie proprietà

1) $Cov(X,X)=Var(X)$

_Dimostrazione_

$$
Cov(X,X)=E[(X-EX)(X-EX)]=E[(X-EX)^2]=Var(X)
$$

2) $Cov(X,Y)=Cov(Y,X)$

_Dimostrazione_

$Cov(X,Y)=E[(X-EX)(Y-EY)]=E[(Y-EY)(X-EX)]=Cov(Y,X)$

3) $Cov(X,Y)=E[XY]-E[X]E[Y]$

Notiamo infatti che se $Y=X$ riotteniamo la varianza di X ma nell'altra forma ovvero $Var(X)=E[X^2]-(E[X])^2$

_Dimostrazione_

$$
\begin{align*}
Cov(X,Y)=E[(X-EX)(Y-EY)]&=E[XY-X\cdot EY-EX\cdot Y+EX\cdot EY] \\
\text{Per linearità di E} &=E[XY]-EX\cdot EY\cancel{-EX\cdot EY}+\cancel{EX\cdot EY}  \\
&= E[XY]-EX\cdot EY
\end{align*}
$$

**La covarianza gode della linearità?** Si

- **Proprietà 1**

Siano $X,Y,Z:S\to \mathbb{R}$ v.a. e siano $a,b\in \mathbb{R}$:

$$
Cov(aX+bY,Z)=aCov(X,Z)+bCov(Y,Z)
$$

_Dimostrazione_

$$
\begin{align*}
Cov(aX+bY,Z)&=E[(aX+bY-\underbrace{ E[aX+bY] }_{ aEX+bEY })(Z-EZ)] \\
&=E[(aX+bY-aEX-bEY)(Z-EZ)] \\
&=E[(a(X-EX)+b(E-EY))(Z-EZ)] \\
&=E[a(X-EX)(Z-EZ)+b(Y-EY)(Z-EZ)] \\
\text{Linearità di E}&=aE[(X-EX)(Z-EZ)]+bE[(Y-EY)(Z-EZ)] \\
\text{Definizione cov}&= aCov(X,Z)+bCov(Y,Z)
\end{align*}
$$

- **Proprietà 2**

È analoga alla precedente ma in direzione opposta, quindi date $X,Y,Z:S\to \mathbb{R}$ e dati $a,b\in \mathbb{R}$ allora:

$$
Cov(Z,aX+bY)=aCov(X,Z)+bCov(Y,Z)
$$

La dimostrazione è simile alla precedente.

---

Le due proprietà appena viste implicano la linearità, quindi:

$$
Cov\left( \sum_{k=1}^n a_{k}X_{k}, \sum_{j=1}^m b_{j}Y_{j} \right)=\sum_{k=1}^n \sum_{j=1}^m a_{k} b_{j} Cov(X_{k},Y_{j})
$$

_Idea Utilizzo:_

$$
\begin{align*}
&Cov(2X_{1}-3X_{2},-4Y_{1}+Y_{2})= \\
\\
&\text{Proprietà 1:}\\&=2Cov(X_{1},-4Y_{1}+Y_{2})-3Cov(X_{2},-4Y_{1}+Y_{2}) \\ \\
&\text{Proprietà 2:}\\
&= 2\cdot (-4) \cdot Cov(X_{1},Y_{1})+2\cdot 1 \cdot Cov(X_{1},Y_{2})-3\cdot(-4)\cdot Cov(X_{2},Y_{1})-3\cdot 1 \cdot Cov(X_{2},Y_{2}) \\
&=-8 Cov(X_{1},Y_{1})+2Cov(X_{1},Y_{2})+12Cov(X_{2},Y_{1})-3Cov(X_{2},Y_{2})
\end{align*}
$$

---

**Proposizione**

Se $X_{1},X_{2},\dots,X_{n}:S\to \mathbb{R}$ allora $Var(X_{1}+\dots+X_{n})$:

$$
\sum_{i=1}^n Var(X_{i})+2\sum_{1\leq i \leq j \leq n} Cov(X_{i},X_{j}) \qquad(1)
$$
Se le v.a. sono 2 a 2 non correlate ovvero se $Cov(X_{i},X_j)=0$ $\forall i\neq j$ allora:

$$
Var(X_{1}+\dots+X_{n})=\sum^n_{i=1} Var(X_{i}) \quad (2)
$$

La proprietà (1) implica la (2) se siamo sotto l'ipotesi detta prima, quindi dobbiamo dimostrare soltanto (1)

_Dimostrazione_

$$
Var(X_{1}+\dots+X_{n})=Cov(X_{1}+\dots+X_{n},X_{1}+\dots+X_{n})
$$

Per bilinearità possiamo dire che che la covarianza è uguale:

$$
\sum^n_{k=1}\sum_{j=1}^n Cov(X_{k},X_{j})=\sum_{k=1}^n Cov(X_{k},X_{k})\dots
$$

_Da continuare non l'ho ben capita (ma tanto a l'esame non c'è, letsgoski 🤙🏻_.

---

Notiamo che la regola, in generale, funziona come il quadrato di binomio, infatti:

$$
Var(X+Y)=Var(X)+Var(Y) + 2Cov(X,Y)
$$

**Proposizione**

Se $X,Y$ sono v.a. indipendenti allora $E[XY]=E[X]E[Y]$ e quindi $Cov(X,Y)=0$

_Dimostrazione_

Per dimostrarlo ci servono due cose:

1) $E[f(X,Y)]=\sum_{i}\sum_{j}f(x_{i},y_{j})p_{X,Y}(x_{i},y_{j})$
2) $p_{X,Y}(x_{i},y_{j})=p_{X}(x_{i})p_{Y}(y_{j})$

$$
\begin{align*}
E[XY]&=\sum_{i}\sum_{j}x_{i}y_{j}p_{X,Y}(x_{i},y_{j}) \quad (1) \\
&=\sum_{i}\sum_{k}x_{i}y_{j}p_{X}(x_{i})p_{Y}(y_{j}) \quad (2) \\
\text{Distribuiamo} &= \underbrace{ \left( \sum_{i}x_{i}p_{X}(x_{i})U \right) }_{ E[X] }\underbrace{ \left( \sum_{j}y_{j}p_{Y}(y_{j}) \right) }_{ E[Y] }=E[X]E[Y]
\end{align*}
$$

**Proposizione**

Se $X,Y$ sono v.a. indipendenti e $f:\mathbb{R}\to \mathbb{R}$ e $g:\mathbb{R}\to \mathbb{R}$ allora anche $f(X)$ e $g(Y)$ sono indipendenti, per dimostrarlo, dire che le funzioni applicate alla v.a. sono indipendenti significa che $\forall A,B \subset \mathbb{R}$ vale:

$$
P(f(X)\in A,g(Y)\in B)=P(f(X)\in A)P(g(Y)\in B)
$$

_Proviamolo:_

$$
\begin{align*}
P(f(X)\in A,g(Y)\in B)&=P(X\in f^{-1}(A),Y\in g^{-1}(B)) \\
&=P(X\in f^{-1}(A))P(Y\in f^{-1}(B)) \\
&=P(f(X)\in A)P(g(Y)\in B)
\end{align*}
$$

---

**Ricordiamo**

- $X,Y$ non correlate se $Cov(X,Y)=0$
- $X,Y$ sono indipendenti se $P(X\in A,Y\in B)=P(X\in A)P(Y\in B)$ $\forall A,B\subset \mathbb{R}$ 

Notiamo che se $X,Y$ sono indipendenti, allora $Cov(X,Y)=0$, vale anche il contrario? No, esistono v.a. dipendenti con $Cov(X,Y)=0$

**Corollario**

Se $X_{1},\dots,X_{n}$ sono v.a. indipendenti allora $Var\left( \sum_{i=1}^nx_{i} \right)=\sum_{i=1}^n(x_{i})$ 

**Applicazione - Proposizione**

$$
X=Bin(n,p)\Rightarrow Var(X)=np(1-p)
$$

_Dimostrazione_

Prendo $n$ prove indipendenti di tipo successo / insuccesso:

$$
\begin{align*}
&X:=\#\text{Successi Ottenuti} \\
&X=X_{1}+\dots+X_{n}
\end{align*}
$$

Quindi $X_{i}$ vale 1 se la i-esima prova è un successo, 0 altrimenti. Dato che le prove sono indipendenti, per il corollario possiamo dire:

$$
\begin{align*}
Var(X)&=\sum^n_{i=1}\underbrace{ Var(X_{i}) }_{ E[X_{i}^2] -(E[X_{i}])^2}  \\
&=(1\cdot p + 0 \cdot (1-p))-(1\cdot p + 0 \cdot (1-p))^2 \\
&=p\cdot(1-p)
\end{align*}
$$


> [!example]- Esercizio
> Lanciamo una moneta truccata 100 volte, sappiamo che esce testa con probabilità $\frac{2}{3}$ e croce con $\frac{1}{3}$. Definiamo $X=\text{Teste Ottenute}$ e $Y=\text{Croci ottenute}$. Calcolare $Cov(X,Y)$.
> 
> Sappiamo che $X+Y=100$ e quindi possiamo scrivere $Y=100-X$ e quindi dobbiamo calcolare $Cov(X,100-X)$.
> 
> Per bilinearità possiamo dire $Cov(X,100-X)=Cov(X,100)-Cov(X,X)$, calcoliamo quindi:
> 
> $$
> Cov(X,100)=E[X\cdot 100] - E[X]\cdot E[100] = 100\cdot E[X]-E[X]\cdot 100 = 0
> $$
> 
> Quindi $Cov(X,Y)=0-Cov(X,X)=-Var(X)=-\frac{200}{9}$, infatti calcolando $Var(X)$ otteniamo:
> 
> $$
> X=Bin\left( 100,\frac{2}{3} \right)\Rightarrow Var(X)=np(1-p)=100\cdot \frac{2}{3}\cdot \frac{1}{3}
> $$
> 

> [!example]- Esercizio
> ![[Pasted image 20241128092402.png]]

## Variabile Aleatorie Continue
Ricordiamo che:

- $X$ v.a. è una funzione definita come $X:S\to \mathbb{R}$
- $X$ è detta discreta se $X$ assume valori $\{ x_{i} \}_{i\in I}$ insieme finito, oppure infinito ma numerabile

_Definizione v.a. continua_

Una v.a. $X:S\to \mathbb{R}$ è detta continua se esiste $f:\mathbb{R}\to[0,+\infty)$ t.c. $P(X\in A)=\int\limits_{A} f(x_{a})dx$, la funzione $f$ è detta **funzione di densità**

_Definizione v.a. uniforme_

Una v.a. $X$ è detta uniforme sull'intervallo $(a,b)$ se è continua con funzione di densità:

$$
f(x)=
\begin{cases}
\frac{1}{b-a} \qquad\text{ se } x\in(a,b) \\
0 \qquad\quad \text{ altrimenti}
\end{cases}
$$

(Anche con intervalli chiusi)

Prendiamo $[a,b]=[0,1]$, sia $A\subset[0,1]$ allora $P(X\in A)$:

$$
\int_{A}f(x)dx=\int_{A}1dx=\text{Lunghezza di A}=L(A)
$$

Ad esempio se $P\left( X\in\left( \frac{1}{2}, \frac{3}{4} \right) \right)=L\left( \left( \frac{1}{2}, \frac{3}{4} \right) \right)=\frac{3}{4}-\frac{1}{2}=\frac{1}{4}$, infatti la probabilità di cadere in un punto dell'intervallo è uguale per tutti i punti dell'intervallo.

---

Sia $X=Unif([a,b])$ allora $P(X\subset[a,b])=1$, infatti $X$ ha sempre valori nell'intervallo essendo uniforme. Infatti:

$$
P(X\in[a,b])=\int_{[a,b]}f(x)dx=\int_{a}^b f(x)dx=\int_{a}^b \frac{1}{b-a} dx = 1
$$

_Esercizio_

Sia $X=Unif([2,8])$ calcolare $P(-3<X<4 \text{ o } 5\leq X<8)$, noi sappiamo calcolare $P(X\in A)=\int_{A} f(x)dx$.

Per quale $A\subset \mathbb{R}$ possiamo scrivere l'evento $-3<X<4 \text{ o } 5\leq X<8$  come $X\in A$.

Si, prendiamo $A=(-3,4)\cup[5,8)$.

Quindi calcoliamo:

$$
\begin{align*}
P(-3<X<4 \text{ o } 5\leq X<8) =\int_{A}f(x)dx&=\int_{(-3,4)}f(x)dx+\int_{[5,8)}f(x)dx \\
&=\int_{-3}^4 f(x)dx+\int_{5}^8 f(x)dx \\
\end{align*}
$$

Dove:

$$
f(x)=
\begin{cases}
\frac{1}{b-a} \text{ se } x\in[a,b] ; \frac{1}{6} \text{ se } x\in[2,8]\\
0 \text{ altrimenti}
\end{cases}
$$

Infati dato che è uniforme in 2,8 tutti i punti hanno la stessa probabilità di $\frac{1}{8-2}=\frac{1}{6}$. Quindi abbiamo una situazione simile:

![[Pasted image 20241130125107.png|500]]

Eseguendo i calcoli otteniamo:

$$
\begin{align*}
&\int_{-3}^4 f(x)dx=\int_{2}^4f(x)dx=\int_{2}^4 \frac{1}{6}dx=\frac{2}{6} \\
 \\
&\int_{5}^8 f(x)dx=\int_{5}^8 \frac{1}{6}dx=\frac{3}{6} \\
 \\
&\text{Quindi in conclusione:} \\
 \\
&P(-3<X<4 \text{ o } 5\leq X<8) = \frac{2}{6}+ \frac{3}{6} = \frac{5}{6}
\end{align*}
$$

**Proposizione**

Se $X$ è v.a. continua con funzione di densità $f$ allora:

$$
\int_{-\infty}^{+\infty} f(x)dx=1
$$

---

$X$ è detta v.a. continua con funzione di densità $f\geq 0$ se $P(X\in A)=\int_{A}f(x)dx$ $\forall A\subset \mathbb{R}$ (misurabile).

Ricordiamo che data $X$ v.a., la funzione di distribuzione (ripartizione) di $X$ è data da $F:\mathbb{R}\to[0,1]$ dove $F(x)=P(X\leq x)$ $\forall x\in \mathbb{R}$.

**Proposizione**

Se $X$ è v.a. continua con funzione di densità $f$ allora:

$$
F(x)=\int_{-\infty}^{x} f(u)du
$$

Infatti, $F(x)=P(X\leq x)=P(X\in\underbrace{ (-\infty,x] }_{ A })=\int_{A}f(u)du=\int\limits_{-\infty}^{x}f(u)du$ 

**Proposizione**

Sia $X$ v.a. continua allora $\forall x\in \mathbb{R}$ vale $P(X=x)=0$, infatti:

$$
P(X=x)=P(X\in \{ x \})=\int_{\{ x \}}f(u)du=\int_{x}^x f(u)du=0
$$

Anche nelle uniformi abbiamo questa regola, infatti è vero che la variabile assume valori nell'intervallo ma nessun valore dell'intervallo ha probabilità positiva. L'unica cosa che possiamo calcolare è la probabilità che la variabile assuma valori in degli intervalli.

_Esercizio_

Data $X$ v.a. continua con funzione di densità:

$$
f(x)=\begin{cases}
cx^2 \text{ se } x\in[1,5] \\
0 \text{ altrimenti}
\end{cases}
$$

- Calcolare $c$:

Sappiamo che $\int_{-\infty}^\infty f(x)dx=1$ quindi calcoliamo:

$$
1=\int_{1}^5 cx^2 dx=\frac{124}{3}c
$$

Quindi $c=\frac{3}{124}$

- Calcolare $P(X>3)$

È la stessa cosa di calcolare $P(X\in(3,+\infty))$ che, per come è definita la variabile, è uguale a $P(X\in(3,5])$:

$$
\int_{3}^5 f(x)dx=\frac{3}{124}\int_{3}^5 x^2 dx=\frac{3}{124} \cdot \frac{5^3 - 3^3}{3}=\frac{98}{124}
$$

### Valore Atteso e Varianza di Variabili Aleatorie continue
Se $X$ è v.a. continua allora:

$$
E[X]:= \int_{-\infty}^\infty xf(x)dx
$$

Non pensiamo che sia come il classico valore atteso ovvero $f(x)=P(X=x)$, l'interpretazione corretta è che:

$$
f(x)dx=P(X\in[x,x+dx])+o(dx)
$$

Ovvero la probabilità che $X$ sia in un intervallo molto piccolo intorno al valore $x$.

Per calcolarlo con delle funzioni, invece vale: **Proposizione**

Sia $X$ v.a. continua con funzione di densità $f$ e sia $g:\mathbb{R}\to \mathbb{R}$ allora:

$$
E[g(X)]=\int_{-\infty}^\infty g(x)f(x)dx
$$

Per quanto riguarda la varianza invece se $X$ v.a. continua allora:

$$
Var(X)=E[(X-EX)^2]
$$

In generale per le v.a. continue valgono le stesse proprietà che abbiamo visto per le discrete.

Una proprietà aggiuntiva che invece troviamo nelle uniformi è la seguente:

**Proprietà**

Sia $X=Unif([a,b])$ e:

$$
f(x)=\begin{cases}
\frac{1}{b-a} \text{ se } x\in[a,b] \\
0 \text{ altrimenti}
\end{cases}
$$

Allora:

$$
E[X]=\frac{a+b}{2}
$$

Infatti dato che la variabile è uniforme nell'intervallo, il valore atteso sarà proprio a metà intervallo.

_Dimostrazione_

$$
\begin{align*}
EX=\int_{-\infty}^\infty xf(x)dx=\int_{a}^b x \frac{1}{b-a}dx=\frac{1}{b-a}\int _{a}^b xdx&=\frac{1}{b-a} \cdot \frac{x^2}{2}|^b_{a} \\
&=\frac{1}{b-a} \cdot \frac{b^2 - a^2}{2} \\
&=\frac{1}{\cancel{b-a}} \cdot \frac{(b+a)\cancel{(b-a)}}{2}=\frac{a+b}{2}
\end{align*}
$$

**Proprietà**

Per quanto riguarda la varianza, sempre nelle uniformi, vale invece:

$$
Var(X)=\frac{(b-a)^2}{12}
$$

_Dimostrazione_

$$
Var(X)=E[X^2]-(EX)^2=E[X^2]-(\frac{a+b}{2})^2
$$

Calcoliamo singolarmente $E[X^2]$:

$$
\begin{align*}
E[X^2]=\int_{-\infty}^\infty x^2 f(x)dx=\int_{a}^b x^2 \frac{1}{b-a}dx=\frac{1}{b-a}\int_{a}^b x^2dx&=\frac{1}{b-a} \cdot \frac{x^3}{3}|^b_{a} \\
&=\frac{1}{b-a} \cdot \frac{b^3 - a^3}{3} = \frac{b^2+ab+a^2}{3}
\end{align*}
$$

Adesso torniamo alla formula della varianza e mettendo insieme i risultati:

$$
\begin{align*}
Var(X)=\frac{b^2+ab+a^2}{3}-\frac{a^2+2ab+b^2}{4}&=\frac{4b^2+4ab+4a^2-3a^2-6ab-3b^2}{12} \\
&=\frac{a^2-2ab+b^2}{12}=\frac{(b-a)^2}{12}
\end{align*}
$$

## Variabile Aleatoria Gaussiana
Una variabile aleatoria $X$ è detta gaussiana o normale di media $\mu\in \mathbb{R}$ e varianza $\sigma^2>0$ se è una v.a. continua con funzione di densità:

$$
f(x)=\frac{1}{\sqrt{ 2\pi }\cdot\sigma}\cdot e^{-\frac{(x-\mu)^2}{2\sigma^2}}
$$

E scriveremo $X=\mathcal{N}(\mu,\sigma^2)$

**Gaussiana Standard**

Se $\mu=0$ e $\sigma^2=1$ allora $X=\mathcal{N}(0,1)$ è detta **Guassiana Standard**, quindi:

$$
f(x)=\frac{1}{\sqrt{ 2\pi }}\cdot e^{-\frac{x^2}{2}}
$$

---

I nomi dei parametri non sono casuali, infatti possiamo provare che $E[X]=\mu$ e che $Var(X)=\sigma^2$, infatti anche la deviazione quadratica standard è uguale a:

$$
\sigma=\sqrt{ \sigma^2 }=\sqrt{ Var(X) }
$$

Il grafico di una Gaussiana è a campana e simmetrico rispetto alla retta verticale $x=\mu$, inoltre $\forall x$ $f(x)>0$ ma quasi tutta l'area della campana è concentrata in:

![[Pasted image 20241206223923.png|500]]

> [!danger] Attenzione
> La variabile Gaussiana è ben definita, ovvero esiste, perché $f\geq 0$ e $1=\int_{-\infty}^\infty f(x)dx$, infatti data in generale una $f:\mathbb{R}\to[0,+\infty)$ con $1=\int_{-\infty}^\infty f(x)dx$ si può sempre costruire una v.a. $X$ continua che ha $f$ come funzione di densità.

### Funzione di distribuzione
Sia $X=\mathcal{N}(\mu,\sigma^2)$ calcoliamo $F(x)$ ovvero $P(X\leq x)$:

$$
P(X\leq x)=\int_{-\infty}^x f(z)dz=\frac{1}{\sqrt{ 2\pi }\cdot \sigma}\int_{-\infty}^x e^{-\frac{(z-\mu)^2}{2\sigma^2}}dz
$$

Se $X$ è una gaussiana standard e quindi $N(0,1)$ invece di scrivere $F(x)$ scriviamo $\phi(x)$:

$$
\phi(x)=\frac{1}{\sqrt{ 2\pi }}\int_{-\infty}^x e^{-\frac{z^2}{2}}dz
$$

Per $\phi(x)$ troviamo delle tabelle già compilate con $x\geq 0$, perché non troviamo i valori negativi? Osserviamo graficamente cosa otteniamo con $\phi(x)$:

Prendiamo ad esempio $\phi(3)$ (non ci interessa il risultato ma solo il grafico):

![[Pasted image 20241206224847.png|500]]

Stiamo calcolando l'area colorata di viola, adesso guardiamo ad esempio, a cosa corrisponde graficamente $\phi(-3)$:

![[Pasted image 20241206225012.png|500]]

$\phi(-3)$ corrisponde all'area colorata di viola, ma notiamo che è identica all'area verde che prima abbiamo escluso con $\phi(3)$, cosa significa questo? Che $\phi(-3)=1-\phi(3)$. Quindi i valori negativi non sono presenti nella tabella perché possiamo calcolarli tramite i loro valori inversi.

In generale quindi $\phi(-x)=1-\phi(x)$, e inoltre $\phi(0)=\frac{1}{2}$

Prendiamo ad esempio $Z=\mathcal{N}(0,1)$ e calcoliamo $P(|Z|\geq 2)$ questo corrisponde a calcolare $P(Z\leq 2 \text{ o } Z\geq 2)$:

$$
= \underbrace{ P(Z\leq -2) }_{ \phi(-2)=1-\phi(2) } + \underbrace{ P(Z\geq 2) }_{ 1-\phi(2)=\phi(-2) }=2(1-\phi(2))=2\cdot 0.0228=0.0456=4.56\%
$$

In generale possiamo dire $\phi(x)=P(Z\leq x)$, per vedere meglio i calcoli sopra vediamo il grafico:

![[Pasted image 20241206225737.png|500]]


> [!NOTE] **Proposizione**
> Sia $\mu\in \mathbb{R}$ e $\sigma^2 >0$ e sia $Z=\mathcal{N}(0,1)$ allora $Y:=\pm \sigma Z+\mu$ è $\mathcal{N}(\mu,\sigma^2)$

Dove possiamo calcolare:
- $E[Y]=E[\sigma Z+\mu]=\sigma E[Z]+\mu=\sigma \cdot 0+\mu=\mu$
- $Var(Y)=Var(\sigma Z+\mu)=\sigma^2 Z\cdot Var(Z)=\sigma^2 \cdot 1= \sigma^2$

_Dimostrazione_

Devo capirla =P perché pisciato lezione.

Possiamo anche dimostrare che $Y=\mathcal{N}(\mu,\sigma^2)\Rightarrow \frac{Y-\mu}{\sigma}=\mathcal{N}(0,1)$ 

> [!example]- Esercizio
> Sia $Y=\mathcal{N}(3,16)$, usando $\phi$ calcolare $P(Y\geq 10)$
> 
> $$
> P(Y\geq 10)=P(Y-3\geq 10-3)=P\left(\frac{Y-3}{4}\geq \frac{10-3}{4}\right)
> $$
> 
> In questo modo possiamo definire $Z=\frac{Y-3}{4}=\mathcal{N(0,1)}$ dato che $\mu=3$ e $\sigma=4 (\sigma^2 =16)$ e quindi calcolare adesso:
> 
> $$
> P\left( Z\geq \frac{7}{4} \right)=P(Z\geq 1.75)=1-\phi(1.75)=1-0.9599=0.0401
> $$


---

## Variabili Aleatorie Identicamente Distribuite
Adesso vediamo due casi di variabili aleatorie diverse ma "con le stesse caratteristiche":

_Caso 1_

Abbiamo un mazzo da 40 carte, estraiamo una carta e definiamo:

$$
X=\begin{cases}
1 \text{ se ho estratto Bastoni o Coppe} \\
0 \text{ altrimenti}
\end{cases}
$$

Come spazio campionario abbiamo il mazzo di carte e quindi esiti, quindi calcoliamo:

$$
P(X=1)=\frac{1}{2} \qquad P(X=0)=\frac{1}{2}
$$

_Caso 2_

Lanciamo una moneta e definiamo:

$$
Y=\begin{cases}
1 \text{ se esce T} \\
0 \text{ se esce C}
\end{cases}
$$

Come spazio campionario abbiamo quindi $S=\{ T,C \}$ e calcoliamo:

$$
P(Y=1)=\frac{1}{2} \qquad P(Y=0)=\frac{1}{2}
$$

Notiamo che $X,Y$ sono v.a. distinte e anche con funzioni definite anche su spazi campionari diversi, nonostante questo assumono gli stessi valori con le stesse probabilità.

> [!NOTE] Definizione
> Date v.a. $X:S\to \mathbb{R}$ e $Y:S'\to \mathbb{R}$, $X,Y$ sono dette **identicamente distribuite** (o aventi la stessa legge) se:
> 
> $$
> P(X\in A)=P(Y\in A) \qquad \forall A\subset \mathbb{R}
> $$
> 


> [!NOTE] Osservazione
> ![[actually.png|100]]
> 
> Se $X$ è v.a. discreta che assume valori $\{ x_{i} \}_{i\in I}$ allora $P(X\in A)=P(X\in A\cap \{ x_{i} \}_{i\in I})$ che è uguale a:
> 
> $$
> P\left( \bigcup_{i:x_{i}\in A} \{ X=x_{i} \} \right)=\sum_{i:x_{i}\in A}P(X=x_{i})=\sum_{i:x_{i}\in A}p_{X}(x_{i})=\sum_{x\in A}p_{X}(x)
> $$
> 
> In conclusione quindi $P(X\in A)=\sum\limits_{x\in A}p_{X}(x)$

Siano adesso $X$ e $Y$ v.a. discrete e supponiamo che $p_{X}=p_{Y}$. Allora per quanto appena provato possiamo dire che:

$$
P(X\in A)=\sum_{x\in A}p_{X}(x)\underset{p_{X}=p_{Y}}=\sum_{x\in A}p_{Y}(x)=P(Y\in A)
$$

Abbiamo provato quindi che due v.a. discrete $X,Y$ con $p_{X}=p_{Y}$ sono **identicamente distribuite** e si può provare anche il viceversa, quindi:

> [!NOTE] **Proposizione**
> Siano $X,Y$ v.a. discrete allora $X,Y$ sono identicamente distribuite(I.D.) $\Leftrightarrow p_{X}=p_{Y}$
> 

Per le v.a. continue vale qualcosa di simile:


> [!NOTE] **Proposizione**
> Siano $X,Y$ v.a. continue (anche con spazi campionari diversi) chiamiamo $f_{X}$ e $f_Y$ le rispettive funzioni di densità di probabilità. Allora:
> 
> $$
> X,Y \text{ sono I.D.} \Leftrightarrow f_{X}=f_{Y} \text{ ovunque (o quasi)}
> $$
> 

Dimostriamo quindi che se $X,Y$ sono continue e $f_{X}=f_{Y}$ allora sono I.D.

Fissato un $A\subset \mathbb{R}$ abbiamo che:

$$
P(X\in A)=\int_{A} f_{X}(x)dx\underset{f_{X}=f_{Y}}=\int_{A}f_{Y}(x)dx=P(Y\in A)
$$

Dove ovviamente nella $f_{Y}$ le $x$ sono equivalenti alle $y$ dato che la funzione di distribuzione di è identica.

Abbiamo provato quindi che $P(X\in A)=P(Y\in A)$ $\forall A\subset \mathbb{R}$ e quindi $X,Y$ sono I.D.

## Teorema di De Moivre - Laplace (preludio del teorema del limite centrale)
Fissiamo $p\in(0,1)$. Dato $n\in \{ 1,2,3,\dots \}$ sia $S_{n}$ v.a. binomiale di parametri $n,p$. Sia $Z=\mathcal{N}(0,1)$ allora $\forall a<b$ vale:

$$
\lim_{ n \to \infty } P\left(a\leq \frac{S_{n}-np}{\sqrt{ np(1-p) }}\leq b\right) =P(a\leq Z \leq b)
$$

Inoltre $\frac{S_{n}-np}{\sqrt{ np(1-p) }}$ ha valore atteso 0 e varianza 1.

Dimostriamolo usando che $E[S_{n}]=np$ e che $Var(S_{n})=np(1-p)$:

$$
\begin{align*}
&E\left[\frac{S_{n}-np}{\sqrt{ np(1-p) }}\right]\underset{\text{linearità di E}}=\frac{E[S_{n}]-np}{\sqrt{ np(1-p) }}=\frac{np-np}{\sqrt{ np(1-p) }}=0 \\
 \\
&Var\left(\frac{S_{n}-np}{\sqrt{ np(1-p) }}\right)=Var\left( \frac{S_{n}}{\sqrt{ np(1-p) }}\right)=\frac{1}{np(1-p)}\cdot Var(S_{n})=\frac{np(1-p)}{np(1-p)}=1
\end{align*}
$$

Inoltre $S_{n}=X_{1}+X_{2}+\dots+X_{n}$ che sono tutte indipendenti quindi sono tutte $Bern(p)$. $S_{n}$ è quindi somma di v.a. indipendenti identicamente distribuite.

# Teorema del Limite Centrale
Nel teorema di De Moivre consideriamo $S_{n}=Bin(n,p)$ che non è altro che la somma di $n$ v.a. indipendenti di prove successo / insuccesso con $p$ probabilità di successo per ogni singola prova.

Quindi definiamo $S_{n}$ come il numero di successi e notiamo che:

$$
S_{n}=X_{1}+X_{2}+\dots+X_{n}
$$

Dove:

$$
X_{i}=\begin{cases}
1 \text{ se alla prova i ho successo} \\
0 \text{ altrimenti}
\end{cases}
$$

Per $i=1,2,\dots,n$ abbiamo che $X_{1},\dots,X_{n}$ sono tutte $Bern(p)$ quindi identicamente distribuite e sono v.a. indipendenti perché si riferiscono a prove indipendenti.

L'importante è quindi che $S_n$ è somma di $n$ v.a. I.I.D. (indipendenti e identicamente distribuite)

**Enunciato Teorema Limite Centrale**

Siano $X_{1},X_{2},X_{3},\dots$ v.a. indipendenti e identicamente distribuite, tutte di valore atteso $\mu\in \mathbb{R}$ e di varianza $\sigma^2\in(0,\infty)$ allora posto $S_{n}:=X_{1}+\dots X_{n}$ abbiamo:

$$
\frac{S_{n}-n\mu}{\sigma \sqrt{ n }}\to Z=\mathcal{N}(0,1)
$$

Più precisamente, $\forall a<b$ vale:

$$
\lim_{ n \to \infty } P\left( a<\frac{S_{n}-\mu n}{\sigma \sqrt{ n }}<b \right) = \underbrace{ P(a<Z<b) }_{ \frac{1}{\sqrt{ 2\pi }} \int_{a}^b e^{- \frac{x^2}{2}} dx}
$$

## Commenti sul Teorema
$X_{1},X_{2},\dots,X_{n}$ sono v.a. I.I.D., cosa significa?
- Indipendenti significa che $\forall n$ $X_{1},\dots,X_{n}$ sono indipendenti, ovvero:
  
$$
P(X_{1}\in A_{1}, \dots, X_{n}\in A_{n}=\prod_{i=1}^n P(X_{i}\in A_{i}) \quad \forall A_{1},\dots,A_{n} \subset \mathbb{R} 
$$

- Identicamente Distribuite significa che $\forall i\neq j$ vale $P(X_{i}\in A)=P(X_{j}\in A) \quad \forall A\subset \mathbb{R}$, quindi non le distinguiamo a livello probabilistico.
  
- Per v.a. discrete questo significa che $p_{X_{i}}=p_{X_{j}}$ $\forall i\neq j$, mentre per v.a. continue questo significa che $f_{X_{i}}=f_{X_{j}}$ $\forall i\neq j$

Prendiamo un esempio di successione IID: $X_{1},X_{2},\dots$ sono tutte indipendenti e $Bern(p)$ allora in questo caso $S_{n}=X_{1}+\dots+X_{n}=Bin(n,p)$ e infatti il Teorema di De Moivre non è altro che un caso particolare del Teorema del Limite Centrale.

Infatti abbiamo detto che $X_{1},\dots$ è una successione di v.a. indipendenti $Bern(p)$, allora $\mu=E[X_{i}]=p$ e $\sigma^2=Var(X_{i})=p(1-p)$.

Otteniamo quindi che:
- $n\mu=np$
- $\sigma \sqrt{ n }=\sqrt{ \sigma^2 n }=\sqrt{ np(1-p) }$

E il TLC mi diche che posto $S_{n}=X_{1}+\dots+X_{n}=Bin(n,p)$ si ha:

$$
\frac{S_{n}-n\mu}{\sigma \sqrt{ n }}=\frac{S_{n}-np}{\sqrt{ np(1-p) }}\to Z=\mathcal{N}(0,1)
$$

Che non è altro che il Teorema di De Moivre

---

Esistono v.a. per cui valore atteso o varianza non son ben definite oppure sono ben definite ma divergono, nel T.L.C (Teorema Limite Centrale) queste situazioni non sono considerate, infatti abbiamo che $\mu\in \mathbb{R}$ e che $\sigma^2\in(0,+\infty)$.

---

Nel TLC consideriamo la v.a. $\frac{S_{n}-\mu n}{\sigma \sqrt{ n }}$ ma da dove vengono $n \mu$ e $\sigma \sqrt{ n }$ ?

$$
\begin{align*}
&E[S_{n}]=E[X_{1}+\dots+X_{n}]=E[X_{1}]+\dots+E[X_{n}]=n\mu  \\ \\
&\text{Abbiamo trovato quindi che } E[S_{n}]=n\mu, \text{ quindi}: \\
 \\
&E\left[ \frac{S_{n}-n\mu}{\sigma \sqrt{ n }} \right] =\frac{E[S_{n}]-n\mu}{\sigma \sqrt{ n }}=0
\end{align*}
$$

Mentre per quanto riguarda la varianza:

$$
\begin{align*}
&Var(S_{n})=Var(X_{1}+\dots+X_{n})=\sum_{i=1}^n Var(X_{i})=n\sigma^2 \\
 \\
&\text{Quindi:} \\
 \\
&Var\left( \frac{S_{n}-n\mu}{\sigma \sqrt{ n }} \right)=Var\left( \frac{1}{\sigma \sqrt{ n }} S_{n} -\frac{n\mu}{\sigma \sqrt{ n }} \right) = \left( \frac{1}{\sigma \sqrt{ n }} \right)^2 Var(S_{n})=\frac{1}{\sigma^2 n}\cdot n\sigma ^2 = 1
\end{align*}
$$

- Quindi le costanti che appaiono in $\frac{S_{n}-n\mu}{\sigma \sqrt{ n }}$ sono state scelte per garantire che il suo valore atteso sia 0 e la varianza 1

# Legge Forte dei Grandi Numeri
Inizialmente nel corso ci ponevamo domande del tipo "Cosa significa che lanciando una moneta abbiamo 1/3 di probabilità che esca testa?". Una prima risposta era che "Lanciando una moneta tante volte allora esce testa in circa un terzo dei casi" ma non riuscivamo a rendere precisa questa affermazione che ha varie criticità, ad esempio non possiamo definire il circa o le tante volte.

Abbiamo quindi scartato questa opzione e abbiamo introdotto lo spazio di probabilità come modello matematico astratto.

Ma esiste un teorema che ci permette di non scartare completamente la prima idea? Si, la **legge forte dei grandi numeri**.

Consideriamo un esperimento descritto dallo spazio di probabilità (S,P).

_Esempio_

Lancio una moneta truccata che dà T con prob 1/3. Abbiamo quindi che $S=\{ T,C \}$ e $P(\{ T \})=\frac{1}{3}$ mentre $P(\{ C \})=\frac{2}{3}$.

Introduciamo un META-esperimento come segue: Ripeto l'esperimento descritto da (S,P) infinite volte sempre con lo stesso protocollo e gli esperimenti che ripeto non si influenzano, sono quindi indipendenti fra loro.

Il Meta-esperimento è descritto dal suo spazio di probabilità che denotiamo con $(\overline{S},\overline{P})$, $\overline{S}$ é dato quindi da: $\overline{S}=\{ (s_{1},s_{2},\dots) :s_{i}\in S\}$ e quindi tornando all'esempio della moneta abbiamo che $\overline{S}=\{ (s_{1},s_{2},\dots) :s_{i}\in \{ T,C \}\}$, quindi $s_{i}$ é l'esito di un sottoesperimento, notiamo quindi che l'esito del meta-esperimento é una stringa composta dagli esiti dei sottoesperimenti, ad esempio:

$(T,C,T,T,C,C, \dots)$ significa che al primo lancio abbiamo ottenuto testa, al seconda croce, al terzo testa...

Per quanto riguarda la funzione di probabilità $\overline{P}$ la situazione è più complessa e difficile da introdurre.

Questa si chiama **probabilità prodotto** e la indichiamo con $\overline{P}$, questa funzione di probabilità ha le seguenti proprietà:
- $\overline{P}=(\{ \overline{s} = (s_{1},\dots) \in \overline{S}:s_{i}\in E\})=P(E)$ questo $\forall i\in \{ 1,2,\dots \}=\mathbb{N}_{+}$ e $\forall E\subset S$
- $\overline{P}(E_{1} \times E_{2} \times \dots \times E_{n} \times S \times S \times \dots)=P(E_{1})P(E_{2})\dots P(E_{n})$ questo $\forall n$ e $\forall E_{1},E_{2},\dots,E_{n}\subset S$

Possiamo spiegare queste proprietà in modo più discorsivo:
- $\overline{P}$ ha la proprietà che se mi interesso alla prova i-esima la probabilità che il risultato della prova i-esima soddisfi l'evento $E\subset S$ è la probabilità che si verifichi $E$ nell'esperimento base (ad esempio la probabilità che al terzo lancio di un dado esca 2 é 1/6 proprio come nell'esperimento base)
- $\overline{P}$ ha la proprietà che eventi riferiti a prove diverse sono indipendenti

## Frequenza Assoluta
Osserviamo che il metaesperimento é descritto dallo spazio di probabilità $(\overline{S},\overline{P})$ dove $\overline{S}=S^{\mathbb{N}_{+}}$ con $\mathbb{N}_{+}=\{ 1,2,\dots \}$. Quindi $\overline{S}=\{ (s_{1},\dots):s_{i}\in S \quad \forall i\in \mathbb{N}_{+} \}$.

Fissiamo adesso un evento $E\subset S$ ad esempio $E=\text{Esce un numero pari}$ e dato un $n$ intero definiamo:

$$
Y^E_{n}:= \text{Volte in cui si verifica E nelle prime n prove del metaesperimento}
$$

È quindi una funzione definita su:

$$
Y^E_{n}:\overline{S}\to \{ 0,1,2,\dots,n \} 
$$

_Esempio_

Supponiamo $\overline{s}=(4,3,2,5,1,1,\dots)$ (ricordiamo che è infinito) e se $E=\{ 2,4,6 \}$ allora:

$$
\begin{align*}
Y^E_{3}(\overline{s} )=2 \\
Y^E_{6}(\overline{s} )=2
\end{align*}
$$

## Teorema (Interpretazione frequentistica della probabilità)
$\forall E\subset S$ evento dell'esperimento base, vale:

$$
\overline{P}\left( \left\{  \overline{s}:\lim_{ n \to \infty } \frac{Y^E_{n}(\overline{s} )}{n} = P(E)  \right\} \right)= 1 
$$

- $\frac{Y^E_{n}(\overline{s} )}{n}$ Questo prende il nome di **frequenza relativa di E nelle prime n prove**

Questa formula è conseguenza della legge forte dei grandi numeri e risolve i problemi che avevamo per rispondere alla domanda sulla probabilità. Infatti con "tanti lanci" ci riferiamo alla probabilità del metaesperimento $\overline{P}$ mentre con $P$ ci riferiamo alla probabilità del singolo lancio. Inoltre abbiamo una definizione precisa ovvero $=1$ e non "circa".

## Teorema (Legge Forte dei Grandi Numeri)
Sia $(S,P)$ spazio di probabilità e siano $X_{1},X_{2},\dots$ v.a. IID tutte definite su $S$ e con valore atteso $\mu$. Allora:

$$
P\left( \left\{  s\in S:\lim_{ n \to \infty } \frac{X_{1}(s)+X_{2}(s)+\dots+ X_{n}(s)}{n} =\mu  \right\} \right) = 1
$$

Ricordiamo infatti che IID sta per **indipendenti e identicamente distribuite** e che per identicamente distribuite intendiamo:

$$
P(X_{i}\in A)=P(X_{j}\in A) \quad \forall i\neq j \qquad \forall A\subset \mathbb{R}
$$

E questo implica che:

$$
E[X_{i}]=E[X_{j}]
$$

Quindi in modo discorsivo possiamo dire che, la media aritmetica di una sequenza di variabili aleatorie IID converge al loro valore atteso quando il numero di esperimenti tende a infinito.

## Corollario della Legge forte dei grandi numeri
$\forall(S,P)$ prendiamo un esperimento base e $\forall X:S\to \mathbb{R}$ variabile aleatoria con $\mu:E[X]$ ben definito, vale:

$$
\overline{P}\left( \left\{  \overline{s}\in \overline{S}  :\lim_{ n \to \infty } \frac{X_{1}(\overline{s} )+\dots+X_{n}(\overline{s} )}{n} =E[X] \right\} \right)=1 
$$

Questo ci dà un'interpretazione frequentistica del valore atteso.

Ricordando che definiamo $\forall i=1,2,\dots$    $X_{i}:\overline{S}\to \mathbb{R}$ come:

$$
X_{i}(\overline{s} )=X(s_{i})
$$

Dove $\overline{s}=(s_{1},s_{2},\dots)\in \overline{S}$