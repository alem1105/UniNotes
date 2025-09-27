#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton

#set heading(numbering: "1.")

= DFA - Automa a Stati Finiti
Il modello di computazione che utilizzeremo per ora è un DFA, questo ha una memoria limitata e permette una gestione dell'input. La memoria gli permette di memorizzare i suoi stati e tramite gli input decide in quale stato futuro muoversi.

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
  title: [Esempio - Una porta automatica],
  [Una porta automatica avrà due stati: 
  - Aperta
  - Chiusa
  E due input:
  - Rileva qualcuno
  - Non rileva nessuno
  Quindi lo stato iniziale sarà la porta chiusa, se rileva qualcuno va nello stato di aperta mentre se non rileva nessuno rimane chiusa.]
) 

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
  title: [*DFA*],
  [Definiamo un DFA come una tupla $(Q, Sigma, delta, q_0, F)$ dove:
   - $Q$ è l'insieme degli stati
   - $Sigma$ è l'insieme finito dei simboli in input
   - $delta: Q times Sigma arrow Q$ è la funzione di transizione degli stati, ovvero dato lo stato in cui si trova ed un input, restituisce lo stato in cui andremo
   - $q_0 in Q$ è lo stato iniziale dell'automa
   - $F subset.eq Q$ è l'insieme degli stati di accettazione dell'automa, ovvero gli stati dove l'automa si trova dopo aver riconosciuto determinate stringhe e consente la terminazione.
  ]
)

Dato DFA $M$ possiamo definire l'insieme delle stringhe riconosciute dall'automa, ovvero quelle che lo portano in uno stato di accettazione come $L(M)$. Da notare che può anche accadere che $L(M)=emptyset$. Daremo una definizione più formale di quest'ultimo più avanti.

Dati dei DFA vogliamo iniziare a definire dei linguaggi dedicati a questi, per farlo abbiamo bisogno della *funzione di transizione estesa*.

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
  title: [*Funzione di Transizione Estesa*],
  [La definiamo come: $ delta^* = Q times Sigma^* arrow Q $ \ Quindi questa a differenza di quella classica non usa degli input singoli ma delle intere stringhe appartenenti al *linguaggio* del DFA. \ È definibile in modo ricorsivo:
  $ cases(delta^*(q, epsilon) = delta(q,epsilon)=q, delta^*(q,a w) = delta^*(delta(q,a),w) " con " w in Sigma^* " e " a in Sigma) $ \
  Quindi data una stringa, partiamo dal primo carattere a sinistra e andiamo avanti utilizzando la funzione di transizione fino ad arrivare ad una stringa vuota.]
)

Adesso diamo le definizioni di *Configurazione* e *Passo di Computazione* che ci serviranno a definire più formalmente un *Linguaggio Accettato* del DFA.

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
  title: [*Configurazione*],
  [Sia $D:=(Q,Sigma,delta,q_0,F)$ un DFA, definiamo la coppia $(q,w) in Q times Sigma^*$ come configurazione di $D$. Inoltre dato un $x in Sigma^*$, la *configurazione iniziale* è $(q_0, x)$.
  ]
)

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
  title: [*Passo di Configurazione*],
  [Indica il passaggio da una configurazione ad un'altra rispettando la funzione di transizione $delta$, il passaggio lo indichiamo con il simbolo $attach(tack.r, br: M)$ dove $M$ indica il DFA. Possiamo dire quindi che esiste una relazione binaria fra un passo di configurazione e la funzione di transizione: $ (p, a x) attach(tack.r, br: M) (q,x)  arrow.double.r.l delta(p,a) = q $ 
  Dove $p,q in Q$ - $a in Sigma$ e $x in Sigma^*$.
  Un passaggio di configurazione può avvenire, quindi, soltanto se la funzione di transizione lo permette.]
)

Possiamo estendere questa relazione con il simbolo $attach(tack.r, br: M, tr: *)$ considerando anche la *chiusura riflessiva e transitiva*:
- *Riflessività:* $(q,x) attach(tack.r, br: M, tr: *) (q,x)$
- *Transitività:* Se $(q, a b y) attach(tack.r, br: M) (p, b y) and (p, b y) attach(tack.r, br: M) (r, y) arrow.r.double (q, a b y) attach(tack.r, br: M, tr: *) (r, y)$
  - Dove $q,p,r in Q$ - $a,b in Sigma$ ed $y in Sigma^*$

Definiamo quindi il linguaggio accettato dal DFA.

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
  title: [*Linguaggio Accettato*],
  [Diciamo che $x in Sigma^*$ è accettato da un automa $M=(Q,Sigma,delta,q_0,F)$ se $delta^*(q_0, x) in F$ oppure usando la relazione del passaggio, se $(q_0,x) attach(tack.r, br: M, tr: *) (q, epsilon)$ con $q in F$.]
)