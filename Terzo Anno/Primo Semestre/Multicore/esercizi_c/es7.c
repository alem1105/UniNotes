#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
• Si scriva un programma che crea una lista di 20 elementi, ognuno composto da
un solo campo intero di nome valore
• Ogni elemento della lista deve impostare il valore alla rispettiva posizione nella
lista
• Es. il primo elemento deve avere valore 1, il secondo deve avere valore 2 ecc…
• Si dichiarino le seguenti funzioni:
struct Elemento *creaLista();
struct Elemento *eliminaPrimo(struct Elemento *p);
void eliminaDecimo(struct Elemento *p);
void eliminaUltimo(struct Elemento *p);
void stampaLista(struct Elemento *p);
• Il programma, una volta creata la lista con la relativa funzione, usa le funzioni
dichiarate rispettivamente per eliminare il primo, il decimo e l’ultimo elemento.
Ogni volta che elimina un elemento (richiamando la funzione corretta), deve
richiamare la funzione stampaLista per stampare l’intera lista modificata
*/

typedef struct Elemento {
    int valore;
    struct Elemento *next;
}elemento;

elemento *creaLista();
elemento *eliminaPrimo(elemento *p);
void *eliminaDecimo(elemento *p);
void *eliminaUltimo(elemento *p);
void stampaLista(elemento *p);

int main() {
    elemento *p = creaLista();
    printf("=== Lista Intera ===\n");
    stampaLista(p);
    p = eliminaPrimo(p);
    printf("\n=== Lista No 1 ===\n");
    stampaLista(p);
    eliminaDecimo(p);
    printf("\n=== Lista No 1-10 ===\n");
    stampaLista(p);
    eliminaUltimo(p);
    printf("\n=== Lista No 1-10-20 ===\n");
    stampaLista(p);
    while (p != NULL) {
        elemento *pt = p;
        p = p->next;
        free(pt);
    }
    printf("\nMemoria Liberata! Uscita.\n");
}

elemento *creaLista() {
    elemento *inizio = malloc(sizeof(elemento));
    if (inizio == NULL) {
        printf("Errore allocazione di memoria!");
        exit(0);
    }
    elemento *p = inizio;
    for (int i = 1; i <= 20; i++) {
        p -> valore = i;
        if (i == 20) break;
        p -> next = malloc(sizeof(elemento));
        if (p -> next == NULL) {
            printf("Errore allocazione di memoria!");
            exit(0);
        }
        p = p -> next;
    }
    return inizio;
}

elemento *eliminaPrimo(elemento *p) {
    p = p -> next;
    return p;
}

void *eliminaDecimo(elemento *p) {
    while (p -> valore != 9) {
        p = p -> next;
    }
    p -> next = p -> next -> next;
}

void *eliminaUltimo(elemento *p) {
    while (p -> valore != 19) {
        p = p -> next;
    }
    p -> next = NULL;
}

void stampaLista(elemento *p) {
    while (p != NULL) {
        printf("%d, ", p -> valore);
        p = p -> next;
    }
}