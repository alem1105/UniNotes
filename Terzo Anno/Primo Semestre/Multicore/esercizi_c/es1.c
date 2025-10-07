#include <stdio.h>
#include <stdlib.h>

/*  Si scriva un programma che legge in input una
    serie di numeri interi (finché l’utente non inserisce
    l’intero 0) che vengono inseriti in un array in
    modo dinamico
    Il programma deve poi stampare la somma di tutti
    gli interi
 */

int main(char **argv, int argc) {
    int capacity = 5;
    int *arr = malloc(capacity * sizeof(int));
    if (arr == NULL) {
        printf("Errore allocazione di memoria!\n");
        return 0;
    }
    int i = 0;
    int input = -1;
    while (input != 0) {
        printf("Inserire un numero (0 per uscire): ");
        scanf("%d", &input);
        if (i < capacity) {
            arr[i++] = input;
        } else {
            arr = realloc(arr, 2 * capacity * sizeof(int));
            if (arr == NULL) {
                printf("Errore allocazione di memoria!\n");
            }
            capacity *= 2;
            arr[i++] = input;
        }
    }

    // Stampare Somma
    int somma = 0;
    for (int k = 0; k < i; k++) {
        somma += arr[k];
    }
    free(arr);
    printf("Somma ottenuta: %d\n", somma);
}