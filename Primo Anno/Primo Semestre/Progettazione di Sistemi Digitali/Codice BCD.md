Il sistema numerico **binario** è quello più **naturale per un computer** mentre quello **decimale** il più **naturale per un essere umano**, per far combaciare queste  esigenze noi convertiamo i numeri decimali in binario, eseguiamo i calcoli e poi riconvertiamo in decimale. Questo richiede però che i numeri vengano memorizzati in modo che possano essere convertiti in binario. Abbiamo bisogno quindi di **un metodo per rappresentare** le cifre **decimali** in 0 ed 1 e che **permetta di eseguire le operazioni senza eseguire conversioni**. Con 4 bit posso rappresentare un massimo di 16 valori, da 0 a 15, quindi un codice binario non ambiguo, che deve codificare 10 elementi con 4 bit, 6 delle possibili combinazioni rimarranno scoperte dando luogo a numerose **alternative di codifica** che appartengono alla classe dei codici binario decimale, indicata con **BCD**. Il più utilizzato è il  *BCD 8421*, in questo sistema rappresentiamo con 4 bit le cifre da 0 a 9, quindi un numero con n cifre decimali, in BCD, richiederà *n ∗ 4 bit*. Ad esempio il numero 396 sarà: 0011 1001 0110, *ogni 4 bit rappresentano una  cifra decimale*.

| Cifra Decimale | BCD  |
| -------------- | ---- |
| 0              | 0000 |
| 1              | 0001 |
| 2              | 0010 |
| 3              | 0011 |
| 4              | 0100 |
| 5              | 0101 |
| 6              | 0110 |
| 7              | 0111 |
| 8              | 1000 |
| 9              | 1001 |
