In questa notazione viene *prestabilito un numero di bit* da dedicare alla parte frazionaria ed un numero di bit alla parte intera, ad esempio:
![[Pasted image 20231021141242.png]]
Come facciamo quindi a convertire un numero decimale in base 10 nella notazione fixed point in base 2? Facciamo un esempio con 21,25

1) La **parte intera** la convertiamo **normalmente**, otteniamo quindi 10101
2) **Moltiplichiamo per 2 la parte decimale** e continuiamo a moltiplicare la parte decimale dei risultati che otteniamo, ci fermiamo o quando otteniamo uno 0 nella parte decimale o quando abbiamo raggiunto un numero di bit sufficiente alle nostre esigenze.
3) La **parte decimale** è data dagli **0 e 1 interi dei nostri risultati**, scritti nell'ordine in cui li abbiamo ottenuti
   ![[Pasted image 20231021141724.png]]
Quindi: $21,25_{10} = 10101,01_2$

*Vediamo un caso particolare: 10,3*:
La parte intera sarà 1010 mentre la parte decimale
![[Pasted image 20231021142038.png]]
La parte decimale quindi si ripeterà all'infinito: 1010,01001100110011...
Non otterremo mai con una precisione assoluta il nostro numero ma ogni cifra che aggiungiamo si avvicinerà sempre di più ad esso