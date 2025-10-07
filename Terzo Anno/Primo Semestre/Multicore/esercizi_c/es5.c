#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
Si scriva un programma che dichiara una struttura
di nome Persona con i seguenti campi: nome,
cognome, eta, dataNascita
• N.B. dataNascita deve essere un’altra struttura
composta dai campi giorno, mese e anno.
• Si crei un Array di cinque posizioni di tipo Persona
• Permettere all’utente di inserire in input i dati di
tutte le persone
• Infine stampare tutti i dati inseriti
*/

typedef struct DataNascita {
    int giorno, mese, anno;
}dataNascita;

typedef struct Persona {
    char nome[20];
    char cognome[20];
    int eta;
    dataNascita datanascita;
}persona;

int main() {
    persona arr[5];
    for (int i = 0; i < 5; i++) {
        persona p;
        printf("=== Persona #%d ===\n", i+1);
        printf("Inserisci nome: ");
        scanf("%s", p.nome);
        printf("Inserisci cognome: ");
        scanf("%s", p.cognome);
        printf("Inserisci età: ");
        scanf("%d", &p.eta);
        printf("Inserisci giorno di nascita: ");
        scanf("%d", &p.datanascita.giorno);
        printf("Inserisci mese di nascita: ");
        scanf("%d", &p.datanascita.mese);
        printf("Inserisci anno di nascita: ");
        scanf("%d", &p.datanascita.anno);
        arr[i] = p;
    }

    printf("\n\n=== Risultati ===\n\n");

    for (int i = 0; i < 5; i++) {
        printf("=== Persona #%d ===\n", i+1);
        printf("Nome: %s\n", arr[i].nome);
        printf("Cognome: %s\n", arr[i].cognome);
        printf("Età: %d\n", arr[i].eta);
        printf("Giorno di nascita: %d\n", arr[i].datanascita.giorno);
        printf("Mese di nascita: %d\n", arr[i].datanascita.mese);
        printf("Anno di nascita: %d\n", arr[i].datanascita.anno);
    }

    return 0;
}