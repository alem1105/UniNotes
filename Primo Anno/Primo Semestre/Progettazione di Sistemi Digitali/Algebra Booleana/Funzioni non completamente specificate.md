Abbiamo 3 casi:

1) Non tutte le combinazioni in ingresso sono ammissibili
2) Non tutti i valori in uscita sono ammissibili
3) Si verificano entrambi i casi precedenti

In ognuno di questi casi il valore della funzione viene rappresentato come **don't care** con la lettera delta $\delta$

Esempio:
Dato $x\in[0,7]$
$y=x-2$ rappresentato in CA2 con il minimo numero di bit
Dato $x\in[1,5]$
$z=x-2$ rappresentato in CA2 con il minimo numero di bit, ovvero $[-4,3]$
![[Pasted image 20231021193319.png]]

La z non ammette il risultato -2 perché in ingresso abbiamo 0 e la funzione accetta x da 1 a 5, mentre per gli ultimi valori non possiamo rappresentarli con 3 bit in CA2.