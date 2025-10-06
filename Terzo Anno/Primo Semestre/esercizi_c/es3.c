#include <stdio.h>
#include <stdlib.h>

/*
Si dichiari una struttura di nome Automobile che
contiene i seguenti campi: prezzo, modello,
cilindrata, colore.

Il programma deve permettere all’utente di salvare
tre tipi di macchine differenti (quindi deve poter
inserire in input tutti i campi delle tre rispettive
macchine)

Infine, si stampino tutti i campi delle tre macchine
*/

struct Automobile {
    float prezzo;
    char modello[20], colore[20];
    int cilindrata;
};

int main() {
    struct Automobile *arr = malloc(3 * sizeof(struct Automobile));
    for (int i = 0; i < 3; i++) {
        struct Automobile aut;
        printf("\nAutomobile #%d\n", i+1);
        printf("Inserisci prezzo: ");
        scanf("%f", &aut.prezzo);
        printf("Inserisci modello: ");
        scanf("%s", aut.modello);
        printf("Inserisci colore: ");
        scanf("%s", aut.colore);
        printf("Inserisci cilindrata: ");
        scanf("%d", &aut.cilindrata);
        arr[i] = aut;
    }

    printf("\n\n=== Stampa Risultati ===\n\n");

    for (int i = 0; i < 3; i++) {
        printf("Automobile #%d\n", i+1);
        printf("Prezzo: %f\n", arr[i].prezzo);
        printf("Modello: %s\n", arr[i].modello);
        printf("Colore: %s\n", arr[i].colore);
        printf("Cilindrata: %d", arr[i].cilindrata);
    }

    free(arr);
    printf("\n\nUscita. Memoria liberata\n");
    return 0;
}