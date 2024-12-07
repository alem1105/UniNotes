# Algoritmi
> [!Info] Cos'è un algoritmo?
> Un algoritmo è una sequenza di comandi **elementari** ed **univoci** che terminano in un tempo finito ed operano su strutture dati
> - Elementari: non si possono scomporre in comandi più semplici (atomicità)
> - Univoci: Hanno una sola interpretazione

# Strutture Dati
Per risolvere problemi abbiamo bisogno di utilizzare dati e quindi di memorizzarli ed organizzarli per semplificarne l'accesso e la modifica, per questo motivo utilizziamo le **strutture dati**.
Ogni struttura ha vantaggi e svantaggi, quindi per risolvere un problema dovremo scegliere la più adatta a quel caso.

# Efficienza
Affinché un algoritmo sia utilizzabile, **deve concludersi e produrre il suo output** entro un tempo "ragionevole".
Un aspetto che va affrontato è quindi la loro efficienza, cioè la quantificazione del tempo e della memoria utilizzata in esecuzione.

# Modello RAM (Random Access Machine)
Per studiare l'efficienza di un algoritmo dobbiamo analizzarlo, ovvero vedere le risorse che utilizza senza essere influenzati da tecnologie specifiche, abbiamo bisogno di un **modello astratto di calcolatore** (RAM).
La RAM è quindi una macchina astratta la cui validità e potenza concettuale non risiede nel fatto che diventa obsoleta con il progredire della tecnologia.
- Esiste un **singolo processore**
- Esistono delle **operazioni elementari**, l'esecuzione di ciascuna delle quali richiede un **tempo costante**(letture, scritture, calcoli ecc...)
  
***Misure di Costo***
Per ipotesi ogni operazione aritmetica che eseguiamo viene eseguita in tempo costante indipendentemente dalla dimensione degli operandi, **Misura di Costo Uniforme**.

_Esempio:_
```python
def esempio(n):
	x = 1
	for i in range(n):
		x = 2 * x
	print(x)
```
_Ciclo iterato n volte che calcola il valore $2^n$_

In questo caso il tempo di esecuzione totale è **proporzionale ad n**:
- Ciclo eseguito n volte
- Ad ogni iterazione eseguiamo incremento del contatore e calcolo di x.

# Problem Solving
E' un attività che ha lo scopo di raggiungere una soluzione dato un problema:
- **Analisi del problema**
- **Esplorazione degli approcci possibili**
- **Selezione di un approccio**
- **Definizione dell'algoritmo risolutivo**
- **Riflessione Critica**

Noi ci concentreremo su **problemi computazioneli**, problemi che richiedono di descrivere in modo automatico una relazione tra valori in input e il corrispondente output.


> [!info] Algoritmo Corretto
> Un algoritmo si dice **corretto** se per ogni istanza di un problema computazionale termina producendo l'output corretto.
> Si dice che l'algoritmo risolve il problema.

# Notazione Asintotica
In matematica la notazione asintotica permette di confrontare  il tasso di crescita (comportamento asintotica) di una funzione nei confronti di un'altra.

In informatica il calcolo asintotico è utilizzato per **analizzare la complessità di un algoritmo** in particolar modo per stimare **quanto aumenta il tempo** al crescere della dimensione $n$ dell'input.

Vedremo 3 diverse notazioni asintotiche:
- **Notazione asintotica O**: La notazione O grande è il limite superiore asintotico
- **Notazione asintotica Ω**: La notazione Omega è limite inferiore asintotico
- **Notazione asintotica Θ**: La notazione Theta è il limite asintotico stretto

***DISEGNO DA CORREGGERE, NOTAZIONI INVERTITE***
![[Pasted image 20240226183451.png]]

**Tutte le funzioni** che definiamo **vanno considerate non negative**, questo implica anche che il limite a $+\infty$ è non negativo, posto che esista.
Questo perché ci interessano funzioni che catturano tempi di esecuzioni, quindi non possono essere negativi o 0.

# Definizioni
- **[[Limite superiore asintotico e la notazione O grande]]**
- **[[Limite inferiore asintotico e la notazione Ω]]**
- **[[Il limite stretto asintotico e la notazione Θ Theta]]**
# Regole Generali
![[Pasted image 20240226201353.png]]


Per determinare i limiti asintotici di due funzioni $f(n)$ e $g(n)$ possiamo utilizzare il metodo del limite del rapporto $\frac{f(n)}{g(n)}$:
- Se il limite del rapporto per $n\rightarrow +\infty$ è diverso da $+\infty$ allora la funzione $f(n)$ è O$(g(n))$
- Se il limite del rapporto per $n\rightarrow +\infty$ è positivo o infinito (diverso da 0) allora la funzione $f(n)$ è Ω$(g(n))$
- Se il limite del rapporto per $n\rightarrow +\infty$ è un numero finito $k$ allora la funzione $f(n)$ è Θ$(g(n))$

**Se il limite non esiste non possiamo utilizzare questo metodo**

# [[Algebra della notazione asintotica]]

**ESEMPI**
![[IMG_7866E6CEA252-1.jpeg]]
# [[Costo di un Algoritmo]]

# [[Il Problema della Ricerca]]

# [[Il Problema dell'Ordinamento]]

# [[Strutture Dati]]