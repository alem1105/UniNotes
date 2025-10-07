#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
Si scriva un programma che dichiara una struttura
di nome Libro con due campi: titolo e prezzo

Si dichiari una funzione che prende in input due
libri e ritorna 0 se hanno gli stessi valori nei due
rispettivi campi, 1 altrimenti

N.B. i valori dei campi delle strutture devono
essere inseriti in input dall’utente 
*/

typedef struct Libro {
    char titolo[20];
    float prezzo;
}libro;

int confronta_libri(libro lib1, libro lib2);

int main() {
    libro lib1, lib2;
    printf("Inserisci il nome del primo libro: ");
    scanf("%s", lib1.titolo);
    printf("Inserisci prezzo del primo libro: ");
    scanf("%f", &lib1.prezzo);

    printf("Inserisci il nome del secondo libro: ");
    scanf("%s", lib2.titolo);
    printf("Inserisci prezzo del secondo libro: ");
    scanf("%f", &lib2.prezzo);

    if (confronta_libri(lib1, lib2) == 0) {
        printf("\nI due libri sono uguali\n");
    } else {
        printf("\nI due libri sono diversi\n");
    }

    return 0;
}

int confronta_libri(libro lib1, libro lib2) {
    if (strcmp(lib1.titolo, lib2.titolo) == 0 && lib1.prezzo == lib2.prezzo) {
        return 0;
    } else {
        return 1;
    }
}