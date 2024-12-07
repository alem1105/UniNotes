#intervalli  
Vediamo qualche esempio:
$$[a,b] = x \in \mathbb{R}:a\leq x \leq b$$
$$(a,b)=x\in\mathbb{R}:a<x<b$$
In generale le **parentesi quadre** indicano un estremo **incluso** mentre le **parentesi tonde** un estremo **escluso**.
Per riconoscere un intervallo basta controllare se al suo interno ci sono dei "buchi", **se non è sempre continuo** e quindi ne troviamo qualcuno quello **non** **è** un **intervallo**.
Esempio: $E=\{0\leq x\leq 1\} \cup \{2\leq x \leq 3\}$ non è un intervallo perché presente un "buco" da 1 a 2
## Unione di due Intervalli
_**L'unione di due intervalli è un intervallo quando l'intersezione fra i due non è vuota_**
$$[0,1]\cup[2,3]\textrm{ non è un intervallo}\rightarrow [0,1]\cap[2,3]=\emptyset$$
## Intersezione di due intervalli
**_L'intersezione di due intervalli è un intervallo se l'intersezione non è vuota_**
$$(-\infty,3]\cap[2,+\infty)=[2,3] \textrm{ è intervallo}$$
$$[0,1]\cap[1,2]=\{1\}=[1,1] \textrm{ Intervallo Degenere}$$
## Estremi Superiori ed Inferiori, Massimi e Minimi
Sia $E \subseteq \mathbb{R}$, si dice che esiste il massimo di E se $\exists M \in E: M\geq x, \forall x \in E$.
Analogamente esiste il minimo se $\exists m \in E: m\leq x, \forall x \in E$_

Stabiliamo una rapida regola utile per gli esercizi, **_Massimo e Minimo possono non esistere, ovvero quando abbiamo un intervallo con estremi esclusi, estremo superiore ed inferiore esistono sempre_**

Vediamo qualche esempio per chiare le idee:
- $E = [a,b] \rightarrow$ Esiste il massimo che è $b$ ed è anche estremo superiore
- $E=[a,b)\rightarrow$ Non esiste il massimo ma l'intervallo è limitato superiormente da $b$
Vediamo alcuni casi per semplificarci la vita più avanti, con sup() e inf() indichiamo rispettivamente estremo superiore ed inferiore di un intervallo:
- $\forall E \subseteq \mathbb{R}$
	  $inf(E) \leq sup(E)$
- $E\subseteq F\subseteq \mathbb{R}$
	  $inf(F)\leq inf(E) \leq sup(E) \leq sup(F)$
- $\forall E,F \subseteq \mathbb{R}$
	  $sup(E\cup F)=max(sup(E),sup(F)), \ inf(E\cup F)=min(inf(E),inf(F))$
	  Quindi l'estremo superiore dell'unione di due intervalli sarà il maggiore tra gli estremi superiori e l'estremo inferiore sarà il minore tra gli inferiori