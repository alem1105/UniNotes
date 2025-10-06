#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
• Si scriva un programma che permette all’utente di
inserire delle Automobili (l’utente ne può inserire
quante ne preferisce)
• Ogni auto deve contenere i campi prezzo e
modello
• Alla fine il programma deve stampare tutte le auto
inserite dall’utente
*/

typedef struct Automobile {
    float prezzo;
    char modello[20];
}automobile;

typedef struct ListaAutomobili {
    automobile *valore;
    struct ListaAutomobili *next;
}listaAuto;

int main() {
    listaAuto *inizio = malloc(sizeof(listaAuto));
    listaAuto *p = inizio;
    p->valore = malloc(sizeof(automobile));
    if (inizio == NULL | p->valore == NULL) {
        printf("Errore allocazione di memoria!");
        return 0;
    }
    printf("Inserisci modello automobile: ");
    scanf("%s", p -> valore -> modello);
    printf("Inserisci prezzo automobile: ");
    scanf("%f", &p -> valore -> prezzo);

    while(1) {
        printf("Vuoi inserire altre auto? (y/f): ");
        char input[10];
        scanf("%s", input);
        if (strcmp(input, "f") == 0) break;

        p -> next = malloc(sizeof(listaAuto));
        p = p -> next;
        p -> valore = malloc(sizeof(automobile));

        if (p == NULL | p -> valore == NULL) {
            printf("Errore allocazione di memoria!");
            return 0;
        }

        printf("Inserisci modello automobile: ");
        scanf("%s", p -> valore -> modello);
        printf("Inserisci prezzo automobile: ");
        scanf("%f", &p -> valore -> prezzo);
    }

    p = inizio;
    int i = 1;
    printf("\n=== RISULTATI ===\n");
    while (p != NULL) {
        printf("Automobile #%d\n", i++);
        printf("modello: %s\n", p->valore->modello);
        printf("prezzo: %f\n", p->valore->prezzo);
        free(p -> valore);
        p = p -> next;
    }

    free(inizio);
    return 0;
}