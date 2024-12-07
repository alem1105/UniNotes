Lo standard maggiormente utilizzato in virgola mobile è lo **IEEE 754** che definisce vari tipi di formati:
- *Half Precision*: 1 bit del segno, 5 bit dell'esponente, 10 bit mantissa
- *Single Precision*: 1 bit del segno, 8 bit dell'esponente, 23 bit mantissa
- *Double Precision*: 1 bit del segno, 11 bit dell'esponente, 52 bit mantissa

Il bit del segno se posto ad 1 indica un numero negativo, se posto a 0 indica un numero positivo, per quanto riguarda la **mantissa** dobbiamo ricordare il concetto di **notazione scientifica**, ovvero:
$$13,25 = 1,325 * 10$$
In binario gode delle stesse proprietà ma moltiplicato per base 2:
$$1101,01 = 1,10101 * 2^3$$
Quindi ogni numero che vogliamo rappresentare in virgola mobile va scritto:
$$(1,Mantissa)*2^{Esponente}$$
Otteniamo quindi **un 1 a sinistra della virgola**, e tutte le altre cifre alla sua destra **(mantissa)**, tutto moltiplicato per 2 elevato all'esponente che nella rappresentazione IEEE 754 Half Precision è rappresentato con 5 bit; in questo standard infatti si utilizza un *offset*, quindi avendo a disposizione 5 bit dobbiamo sommare all'esponente una variabile k tale che $k = \frac{2^N}{2}-1$, quindi in questo caso 15.
Il numero che otteniamo da questa somma prende il nome di **exponent bias**.

## Facciamo un esempio pratico scriviamo in standard IEEE 754 Half Precision il numero decimale 13,25:
1) Converto in binario il numero
	   13,25 = 1101,01
2) Sposto la virgola e scrivo il numero in forma $1,M*2^E$
	   $1,10101 * 2^3$
3) Aggiungo k (bias) all'esponente
	   3 + 15 = 18
4) Scrivo il numero nella notazione mettendo lo 0 nel bit del segno (numero positivo), 18 in binario nei bit dell'esponente e i bit della mantissa
	   0 | 10010 | 10101

## Procedimento inverso
Possiamo seguire questa formula:
$$1,M * 2^{E-K}$$
Ci basterà poi mettere il segno meno se il numero aveva un 1 al bit del segno altrimenti lasciamo il segno positivo.
Per esempio con il numero precedente 0 | 10010 | 10101 otteniamo:
$$1,10101 * 2{18-15} = 1,10101 * 2^3$$
Nel bit del segno abbiamo 0 quindi il numero è positivo