#include <stdio.h>
#include <stdlib.h>

/* Si scriva un programma che legge in input una
serie di numeri interi (finché l’utente non inserisce
l’intero 0) che vengono inseriti in un array in
modo dinamico
Il programma deve poi stampare il minore e il
maggiore*/

int main(char **argv, int argc) {
    int capacity = 5;
    int input;
    int i = 0;
    int *arr = malloc(capacity * sizeof(int));
    int min = __INT_MAX__;
    int max = -__INT_MAX__;
    if (arr == NULL) {
        printf("Errore allocazione di memoria!\n");
        exit(0);
    }
    while (1) {
        printf("Inserire un numero (0 per uscire): ");
        scanf("%d", &input);
        if (input == 0) {
            break;
        }
        if (i >= capacity) {
            capacity *= 2;
            arr = realloc(arr, capacity * sizeof(int));
            if (arr == NULL) {
                printf("Errore allocazione di memoria!\n");
            }
        }
        arr[i++] = input;
        if (input > max) {
            max = input;
        }
        if (input < min) {
            min = input;
        }
    }
    printf("Numero minimo: %d\nNumero massimo: %d\n", min, max);
    free(arr);
    printf("Memoria liberata.\n");
}
