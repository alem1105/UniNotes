Possiamo realizzarlo in due modi:
- _Logico:_ uguaglianza tra sequenze di bit
- _Aritmetico:_ A > B

# Logico

![[Pasted image 20240121213453.png]]

# Aritmetico
![[Pasted image 20240121213856.png]]

Costruendo le tabelle di verità otteniamo le seguenti formule:
- _A < B:_ $\overline{A_1}\overline{A_0}B_0 + \overline{A_1}B_1+\overline{A_0}B_1B_0$
- _A = B:_ $(A_1\oplus B_1)(A_0\oplus B_0)$
- _A > B:_ $A_0\overline{B_1}B_0 + A_1A_0\overline{B_0}+A_1\overline{B_1}$
