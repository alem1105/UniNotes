Vedremo diverse tecniche per risolvere problemi:
- Tecnica greedy
- Divide et impera
- Programmazione dinamica
- Backtracking

# Complessità

Un algoritmo si dice **efficiente** se la sua complessità è di ordine polinomiale nella dimensione $n$ dell'input ovvero di complessità $O(n^ c)$ per una qualche costante $c$.

Lo diciamo invece **inefficiente** se superpolinomiale ovvero:

- **Esponenziale** - Una funzione di ordine $\Theta(c^ n)=2^{\Theta(n)}$
- **Super Esponenziale** - Una funzione che cresce più velocemente di un esponenziale ad esempio $2^{\Theta(n^2)}$ oppure $2^{\Theta(n\log n)}$
- **Sub Esponenziale** - Una funzione che cresce più lentamente di un esponenziale ovvero $2^ {o(n)}$ ad esempio $2^{\Theta(n^c)}$ dove $c$ è una costante inferiore di 1. Oppure $n^{\Theta(\log n)}=2^{\Theta(\log^2 n)}$ infatti basta scomporre la potenza per riottenere la parte a sinistra, scritta come a destra abbiamo un esponente più piccolo di $n$.

I problemi più studiati sono quelli per cui non si conosce un algoritmo subesponenziale, ad esempio i problemi della fattorizzazione e dell'isomorfismo tra grafi sono molto noti e da tempo esistono algoritmi superpolinomiali con complessità $2^{O(n^{1/3})}$.

Pensiamo ad esempio al **test di primalità**, l'algoritmo banale è esponenziale, questo perché ha complessità $O(n)$ ma la lunghezza dell'input è $\log n$ dato che i numeri sono in binario. Infatti, riscriviamo $n$ in funzione di $k$ lunghezza in bit:

$$
\begin{align*}
&\text{Un numero n richiede:} \\
&k = \log_{2} n \text{ bit} \\
&2^k = 2^{\log_{2} n}\\
&2^k = n
\end{align*}
$$

Quindi è esponenziale sulla grandezza in bit del numero infatti abbiamo un costo di $O(2^{\log n})$, ad esempio se prendiamo 1024 dobbiamo si eseguire circa 1024 operazioni ma se guardiamo i bit abbiamo circa 10 bit e 1024 operazioni, aggiungendo un solo bit andiamo a 2048 operazioni mentre una soluzione ottimale dovrebbe essere polinomiale e quindi $O(\log^c n)$.

Anche se ci fermassimo prima nella ricerca dei divisori, fermandoci alla radice otteniamo comunque un costo esponenziale:

$$
O(\sqrt{ n })=O(2^{\log \sqrt{ n }}) = O(2^{\frac{1}{2} \log n})=2^{\Theta(\log n)}
$$

---

Per un problema ovviamente possono esistere diversi algoritmi, ad esempio per ordinare una lista di interi abbiamo algoritmi che vanno da complessità come $O(n\cdot n!)$ fino a ridurci a $O(n \log n)$. È importante quindi **non** confondere la complessità del problema con quella dell'algoritmo.

Un algoritmo di complessità $O(g(n))$ fornisce una limitazione superiore alla complessità del problema, significa che per un grande numero $n$ il nostro algoritmo si comporta come $g(n)$. Se invece si dimostra che un qualsiasi algoritmo per un problema ha complessità $\Omega(f(n))$ si è stabilita una limitazione inferiore alla complessità del problema, significa che avremo _almeno_ quel comportamento della funzione.

Se $f(n)=g(n)$ allora l'algoritmo è detto ottimo perché la sua complessità in ordine di grandezza risulta la migliore.

Calcolare le limitazioni inferiori non è semplice ed esistono pochi modi per dimostrare che queste sono vere, vediamone due:

- **Dimensione dei dati** - Se un problema ha in ingresso $n$ dati e richiede di esaminarli tutti allora la limitazione inferiore è $\Omega(n)$

- **Eventi Contabili** - Se un problema richiede che un certo evento sia ripetuto almeno $m$ volte allora una limitazione inferiore alla complessità è $\Omega(m)$. Ad esempio per gli algoritmi di ordinamento se abbiamo $n$ elementi è stato dimostrato che bisogna effettuare almeno $n\log n$ confronti.

---

Un problema si dice **intrattabile** se non può avere algoritmi efficienti come ad esempio stampare tutte le permutazioni di $n$ elementi, il problema in questo caso ha un limite inferiore di $2^{\Omega(n\log n)}$ e quindi non possiamo raggiungere la complessità polinomiale.

Ma perché consideriamo efficiente un algoritmo con complessità $O(n^c)$ con una generica $c$ e non un numero fisso?

**Tesi di Church-Turing** - I modelli di calcolo realistici sono equivalenti dal punto di vista computazionale, se qualcosa è non calcolabile su una macchina lo resterà su qualunque altra.

**Testi di Church-Turing estesa** - I modelli di calcolo realistici sono tra loro polinomialmente correlati, quindi il concetto di trattabilità è **indipendente dalla macchina**.

- # [[Grafi]]
- # [[Grafi Pesati]]

---

- # [[Problemi di Ottimizzazione e Algoritmi di Ottimizzazione]]