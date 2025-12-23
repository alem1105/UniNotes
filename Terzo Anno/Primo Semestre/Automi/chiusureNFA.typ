#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

= Proprietà di chiusura dei Linguaggi Regolari

== Chiusura per Unione

Rivediamo l'unione utilizzando gli NFA, infatti adesso sappiamo che NFA e DFA sono equivalenti.

Uniamo due DFA in un NFA equivalente ai due:

#align(center,
  image("img/Untitled-2024-12-04-1933.svg", width: 90%)
)

Infatti possiamo semplicemente considerare un NFA che come primo stato ci porta in modo parallelo su entrambi i DFA, avremo quindi che:

- $Q = Q_1 union Q_2 union {q_0}$

- $F = F_1 union F_2$

- $forall q in Q, a in Sigma_epsilon$:

$ delta(q,a) = cases(delta_1 (q,a) " se " q in Q_1, delta_2 (q,a) " se " q in Q_2, {q_0^1 , q_0^2} " se " q=q_0 and a = epsilon, emptyset " se " q = q_0 and a eq.not epsilon) $

== Chiusura per Concatenazione

Dati due NFA $N_1, N_2$ per $L_1,L_2$ costruisco NFA per $L=L_1 circle.small L_2$

#align(center,
  image("img/Untitled-2024-12-04-1933(2).svg", width: 90%)
)

Quindi li stati finali di $N_1$ li facciamo diventare dei normali stati che però hanno un $epsilon-"arco"$ verso lo stato iniziale di $N_2$

Formalmente:
- $N = {Q, Sigma, delta, q_0, F}$

- $Q = Q_1 union Q_2$

- $q_0 = q_0^1$

- $Sigma_epsilon = Sigma union {epsilon}$

- $F = F_2$

- $forall q in Q, forall a in Sigma_epsilon$:

$ delta (q,a) = cases(delta_1 (q,a) " se " q in Q_1 and q in.not F_1, delta_1 (q,a) " se " q in F_1 and a eq.not epsilon, delta_1 (q,a) union {q_0^2} " se " q in F_1 and a = epsilon, delta_2 (q,a) " se " q in Q_2) $

== Chiusura per Operazione "\*" star

Dato un NFA $N$ t.c. $L(N)=L$ devo costruire NFA $N^*$ t.c. $L(N^*)=L^*$

#align(center,
  image("img/Untitled-2024-12-04-1933(3).svg", width: 80%)
)

Formalmente abbiamo $N^*=(Q', Sigma, delta', q_0 ', F')$ e $N=(Q, Sigma, delta, q_0 , F)$:
- $q_0 '$ nuovo stato iniziale

- $F' = F union {q_0 '}$

- $Q'=Q union {q_0 '}$

- $forall q in Q', forall a in Sigma_epsilon$:

$ delta(q,a) = cases(delta(q,a) " se " q in Q and q in.not F, delta(q,a) " se " q in F and a in.not epsilon, delta(q,a) union {q_0} " se " q in F and a = epsilon, {q_0} " se " q = q_0 ' and a = epsilon, emptyset " se " q=q_0 ' and a eq.not epsilon) $