Si utilizza una struttura ad albero dove ogni nodo si dirama in 1 o 2 archi.
Iniziamo inserendo la formula da verificare nella radice dell'albero e andremo a scomporla fino ad ottenere una contraddizione o una formula atomica, quindi non più scomponibile.

*Se incontriamo contraddizioni in tutti i nodi la formula è insoddisfacibile*
*Se vogliamo verificare una tautologia infatti possiamo negarla e verificare che ci siano solo contraddizioni*.

Possiamo dividere le formule in più regole, **congiuntive e disgiuntive**

**Regole alfa**
$\alpha_1$: $x \wedge y$ diventa $x,y$
$\alpha_2: \neg(x\vee y) \ diventa \ \neg x,\neg y$
$\alpha_3: \neg(x \rightarrow y) \ diventa \ x,\neg y$
$\alpha_4: x\leftrightarrow y \ diventa \ x\leftrightarrow y, y\leftrightarrow x$
$\alpha_5: \neg\neg x \ diventa \ x$

**Regole beta**
$\beta_1: x\vee y \ lo \ seperiamo \ in \ x \ y$
$\beta_2: \neg(x\wedge y) \ lo \ separiamo \ in \ \neg x \ \neg y$
$\beta_3: x\rightarrow y \ lo \ separiamo \ in \ \neg x \ y$
$\beta_4: \neg(x\leftrightarrow y) \ lo \ separiamo \ in \ \neg(x\rightarrow y) \ \neg(y\rightarrow x)$

**Regole Tableux Predicativi**
$\forall xAx$ diventa $\forall xAx,Aa$
$\neg \exists xBx$ diventa $\neg\exists xBx,\neg Ba$
$\exists xAx$ diventa $Aa$
$\neg\forall xBx$ diventa $\neg Ba$
### Esercizi di esempio
![[Screenshot 2023-11-23 alle 08.53.42.png]]
![[Screenshot 2023-11-23 alle 08.53.57.png]]





