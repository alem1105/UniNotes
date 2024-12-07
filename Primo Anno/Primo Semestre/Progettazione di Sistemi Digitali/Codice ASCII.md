Il **codice standard** per i caratteri alfanumerici è il codice **ASCII** che utilizza 7 bit per codificare 128 caratteri.
I bit sono divisi in **due parti**, una formata dai 3 bit più significativi che indicato la **tipologia del valore** e l'altra dagli altri 4 bit restanti che indicano la sua **rappresentazione**.
Siccome tutti i calcolatori utilizzano 8 bit, che prendono il nome di **1 byte**, è stata creata un'estensione del codice ASCII a 8 bit aggiungendone uno nella posizione più significativa di valore 0.
Questo bit viene utilizzato per scopi specifici, ad esempio nelle stampanti abilita la stampa di simboli addizionali.

## Bit di parità
Per individuare errori nelle comunicazioni è stato aggiunto un bit al codice ASCII allo scopo di rendere il numero totale di 1 presenti nel codice pari o dispari

| ASCII       | Parità Pari | Parità Dispari |     |
| ----------- | ----------- | -------------- | --- |
| A = 1000001 | 01000001    | 11000001       |     |
| B = 1010100 | 11010100    | 01010100       |     |
|             |             |                |     |
|             |             |                |     |
|             |             |                |     |
