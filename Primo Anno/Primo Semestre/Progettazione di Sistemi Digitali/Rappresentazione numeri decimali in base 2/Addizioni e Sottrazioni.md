Per eseguire queste due operazioni **svolgiamo sempre una somma** prestando attenzione al segno degli addendi e **scegliendo il segno corretto del risultato**, ad esempio due numeri negativi sommati ci dovranno restituire un numero negativo.
Vediamo con più esattezza i passaggi da svolgere:
1) *Confrontiamo gli esponenti* e li portiamo allo stesso valore, di solito si sceglie il più grande
2) *Spostiamo la mantissa* per mantenere il valore dell'*addendo* con esponente *più piccolo*
3) *Scelgo che operazione svolgere* in base al segno degli addendi, quindi scelgo il loro ordine ed il segno del risultato corretto

Esempio:
- $A = (26.42)_{10}=(11010.011010)_2$
- Lo scriviamo in notazione scientifica = $1.1010011010 * 2^4$
- Lo rappresentiamo in IEEE 754 = 0 | 10011 | 1010011010
- Prendiamo un altro numero B che in IEEE 754 = 1 | 10100 | 0010110101 e in decimale = -37.65625
- Per effettuare la somma portiamo l'esponenti di A 19 a 20 come l'esponente di B e spostiamo la mantissa, i due numeri saranno quindi:
  $A = 0.1101001101 * 2^5$
  $B = 1.0010110101 * 2^5$
- Posso svolgere B - A e poi mettere il segno meno al risultato
- ![[Pasted image 20231021154415.png]]
- Normalizzato in notazione scientifica otteniamo: $1,01101000 * 2^3$
- Possiamo poi scriverlo anche in standard IEEE 754: 1 | 10010 | 0110100000