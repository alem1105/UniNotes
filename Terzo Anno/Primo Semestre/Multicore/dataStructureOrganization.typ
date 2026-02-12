#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages)
#show raw: set text(font: "Cascadia Code")

== Importance of data structure organization for coalesced accesses

=== Array of Struct vs Struct of Array
É meglio utilizzare un array dove ogni elemento é una struct oppure una struct dove ongni elemento é un array?

```c
struct innerStruct {
  float x;
  float y;
};


struct innerStruct AoS[N];
```

```c
struct innerArray {
  float x[N];
  float y[N];
};


struct innerArray SoA;
```

- Come vengono organizzati i dati in memoria?
- La *cache localicty* come viene gestita?
- I coalesced access?

In memoria possiamo vederli organizzati in questo modo:

#image("/assets/image.png")

Adesso, se ad esempio tutti i thread dovessero accedere ad un dato $x$:

#image("/assets/image-1.png")

Accadono le seguenti cose:
- Nell'AoS sprechiamo spazio nella cache dato che carichiamo anche $y$ ma in quel momento é inutile, potremmo infatti caricare tutte le $x$
- Con SoA possiamo caricare con un singolo accesso tutti i dati che ci servono ovvero soltanto le $x$.
- Il SoA quindi permette il coalesced access e richiede anche meno spazio.

== Reduce on GPU

La prima idea che possiamo utilizzare per effettuare una Reduce é la seguente:

#image("/assets/image-2.png")

Che possiamo implementare con il codice:

```c
unsigned int t = threadIdx.x;
for (unsigned int stride = 1; stride < blockDim.x; stride *= 2) {
  __syncthreads();

  if (t % (2 * stride) == 0)
    partialSum[t] += partialSum[t+stride];
}
```

In questo modo ad ogni iterazione andranno a lavorare sempre la metá dei thread rispetto alla precedente. Questo peró in realtá é un problema!
Infatti alcuni thread fanno delle somme mentre altri non fanno nulla, giá dalla prima iterazione tutti i thread dispari sono disabilitati. Non abbiamo divergenza ma utilizziamo poco le nostre risorse.

Un modo migliore per effettuare una reduce é il seguente:

#image("/assets/image-3.png")

L'idea é che dividiamo il blocco in due e ogni thread fa la somma fra se stesso e il suo corrispondente nell'altra metá, ad esempio prendiamo un blocco da 512 threads:
- Alla prima iterazione tutti leggono i dati
- Alla seconda lavorano a coppia:
  - Il thread 0 si somma con il thread 256
  - Il thread 1 si somma con il thread 257
  - ...
- Andando avanti con le iterazioni andiamo sempre a dimezzare il numero di thread attivi ma la cosa importante é che non spegniamo thread in modo alternato ma in modo contiguo e questo permette alla GPU di disabilitare warp interi non andando a impattare di molto sulle performance, infatti:
- Prendendo sempre 512 come grandezza abbiamo:
  - Iterazione 1: 512 / 32: 16 warp attivi
  - Iterazione 2: 256 / 32: 8 warp attivi
  - ...
  - Quando ci serviranno meno di 32 thread sará il caso in cui c'é un solo warp e i thread non svolgono tutti lo stesso lavoro, infatti alcuni saranno spenti e qui abbiamo divergenza ma é soltanto per poche iterazioni a fine codice e per pochi dati.


Possiamo implementare questa reduction in questo modo:

```c
__shared__ float partialSum[SIZE];
partialSum[threadIdx.x] = X[blockIdx.x * blockDim.x + threadIdx.x];

unsigned int t = threadIdx.x;
for (unsigned int stride = blockDim.x / 2; stride >= 1; stride >> 1) {
  __syncthreads();
  if (t < stride)
    partialSum[t] += partialSum[t + stride];
}
```

La shared memory peró ricordiamo che é condivisa soltanto fra i threads all'interno dello stesso blocco, come riduciamo quindi un vettore piú grande del numero di thread per blocco?

Supponiamo di dover ridurre un vettore di `N` elementi con `N = Nblock * Nthread`, dobbiamo:
- Usare un kernel `reduce<<<Nblock, Nthread>>>(v, partial)` per ottenere nella variabile `partial` un vettore con `Nblock` elementi (1 elemento per ogni blocco) che contiene i risultati parziali.
- Utilizzare un altro kernel `reduce<<<1, Nblock>>>(partial, result)` per ottenere i risultati finali, oppure far lavorare la CPU su questo invece di chiamare un altro kernel.

== CUDA + MPI 
Ci sono due strade possibili, dipende da:

- *MPI non sa che c'é la GPU*: I dati devono essere trasferiti in modo esplicito tra dalla GPU alla CPU prima di fare le chiamate MPI, alla ricezione stessa cosa ma in ordine inverso

```c
// Chi invia
cudaMemcpy(tmp, src, cudaMemcpyDeviceToHost);
MPI_Send(tmp, ..., N+1, ...)

// Chi riceve
MPI_Recv(tmp, ..., N, ...) // recv
cudaMemcpy(tmp, src, cudaMemcpyHostToDevice);
```

- *MPI é a conoscenza della GPU*: Non c'é bisogno di copiare i dati tra GPU e memoria Host, questo ci permette di risparmiare una copia aggiuntiva all'invio e una alla ricezione

La differenza sostanziale é che nelle nuove versioni possiamo appunto passare direttamente puntatori a memoria della GPU e MPI gestirá tutto da solo mentre con versioni precedenti di MPI dobbiamo fare noi a mano i trasferimenti.