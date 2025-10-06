#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
• Si scriva un programma che definisce due funzioni:
• char * leggiStringa() –legge una stringa in input memorizzandola
dinamicamente e ritorna un puntatore a questa stringa
• void sostituisciNumeri(char *p) – prende come parametro un puntatore
ad una stringa e sostituisce tutti i numeri con il carattere * (asterisco)
• Infine si dichiari la funzione main che per prima cosa chiama la funzione
leggiStringa(), stampa la stringa inserita in input, chiama la funzione
sostituisciNumeri ed infine stampa la stringa modificata
*/

char *leggiStringa();
void sostituisciNumeri(char *p);

int main() {
    printf("Inserisci stringa: ");
    char *stringa = leggiStringa();
    sostituisciNumeri(stringa);
    printf("\nStringa pulita: %s\n", stringa);
    return 0;
}

char *leggiStringa() {
    char c, *stringa;
    stringa = malloc(sizeof(char));
    if (stringa == NULL) {
        printf("Errore allocazione di memoria!");
        exit(0);
    }
    scanf("%c", &c);
    int i;
    for (i = 0; c != '\n'; i++) {
        stringa[i] = c;
        stringa = realloc(stringa, (i+2) * sizeof(char));
        if (stringa == NULL) {
            printf("Errore allocazione di memoria!");
            exit(0);
        }
        scanf("%c", &c);
    }
    stringa[i] = '\0';
    return stringa;
}

void sostituisciNumeri(char *p) {
    while (*p != '\0') {
        if (*p <= 57 && *p >= 48) {
            *p = '*';
        }
        p += 1;
    }
}