#import "@preview/showybox:2.0.4": showybox
#import "@preview/finite:0.5.0": automaton
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.8": *
#show: codly-init.with()
#codly(languages: codly-languages)
#show raw: set text(font: "Cascadia Code")

= Caching
La cache è una zona di memoria molto più veloce ma anche più piccola nella quale memorizziamo dati che sappiamo ci serviranno nel breve termine, assumiamo che sia vero il principio di località ovvero che un accesso in una locazione è seguito da un accesso ad una zona vicina. Ne esistono comunque di due tipi:
- *Spatial Locality*: Accedi ad una zona vicina
- *Temporal Locality*: Dovrai accedere alla zona tra poco.

I dati sono inseriti nella cache con una struttura a blocchi / linee, questo significa che se ad esempio trasferiamo in cache il dato `z[0]` allora stiamo probabilmente stiamo trasferendo anche i dati vicini come ad esempio `z[1], z[2], ..., z[15]`, in generale infatti è meglio fare un solo trasferimento in cache di 16 locazioni piuttosto che 16 trasferimenti di una sola locazione.

La cache è organizzata a livelli: L1, L2, L3..., dall'alto verso il basso (con L1 in alto) le cache diventano sempre più lente ma anche più grandi di capacità. La CPU quindi quando dovrà prendere un dato prima controllerà che i dati siano presenti in L1, poi in L2 ecc.... Inoltre non possiamo sapere se i dati salvati in L1 siano presenti o meno in L2 o altri livelli, dipende dalla tipologia della cache.

É importante quindi scrivere codice che sfrutti bene la cache e riduca il numero di cache miss ovvero di letture in memoria principale.

Un altro concetto importante è la *consistency* ovvero quando la CPU scrive un dato in cache è importante che questo dato sia consistente con quello scritto in memoria principale.
- *Write-Through*: La cache aggiorna il dato in memoria principale ogni volta che quello in cache viene aggiornato.
- *Write-Back*: La cache marca alcuni dati come *dirty*, quando una linea della cache viene rimpiazzata da una nuova linea allora la linea dirty viene scritta in memoria principale.

== Caching on Multicores
I programmatori non hanno controllo su cosa viene scritto e su cosa è presente in cache, ma dobbiamo mantenere *cache coherence*, _Esempio_

Abbiamo un sistema con due cores e due cache (una per core).
- `y0` variabile privata di Core 0
- `y1 e z1` variabili private del Core 1
- `x = 2` variabile condivisa

Al tempo 0 abbiamo che:
- Core 0: `y0 = x;` | Core 1: `y1 = 3 * x;`

Quindi le cache sono:
- Core 0: `x = 2 | y0 = 2`
- Core 1: `x = 2 | y1 = 6`

Alla seconda istruzione i core eseguono:
- Core 0: `x = 7;` | Core 1: `Statement che non chiama x`
Le cache si aggiornano in:
- Core 0: `x = 7 | y0 = 2`
- Core 1: `x = 2 | y1 = 6`

Adesso come terza istruzione:
- Core 0: `Statement che non chiama x` | Core 1: `z1 = 4*x;`
Le cache diventano quindi:
- Core 0: `x = 7 | y0 = 2`
- Core 1: `x = 2 | y1 = 6 | z1 = 4*2 o 4*7`

Per x il dato aggiornato è 7 ma non è stato cambiato nella cache del core 1. Questo accade sia in Write Through che in Write Back.

Per evitarlo esistono diverse tecniche:

- *Snooping Cache Coherence* - Sappiamo che i cores condividono un bus di sistema e ogni segnale trasmesso su questo può essere intercettato dagli altri cores, quando il core 0 aggiorna la x nella sua cache condivide questa informazione sul bus. Se il core 1 sta ascoltando il bus può capire che la x è stata aggiornata e rendere la sua copia non valida. Oggi però questa tecnica non è utilizzata dato che molto costosa visto l'elevato numero di cores sulle macchine.

- *Directory Based Cache Coherence* - Si utilizza una struttura dati chiamata directory per memorizzare gli stati di ogni linea della cache. In questo modo possiamo memorizzare quali core hanno in memoria quali dati, quando un dato viene aggiornato consultiamo la struttura dati e andiamo ad aggiornare le memorie che lo contengono per marcare quel dato come non valido.

Un altro problema nelle cache è il *false sharing*, questo avviene perché siccome i dati nella cache sono raccolti in linee, ogni linea può contenere diversi valori, ma quando i dati vengono invalidati viene invalidata tutta la linea.
Esistono diverse soluzioni a questo problema.
- Forzare il salvataggio su linee diverse delle variabili usate da threads diversi.
- Padding ovvero aggiungere dei byte dopo ogni dato in modo che questi si trovino su linee diverse. C'è da fare attenzione però se salviamo delle struct, infatti il compilatore potrebbe cambiare l'ordine dei campi interni. In Gcc possiamo utilizzare:
```c
struct alignTo64ByteCacheLine {
  int _onCacheLine1 __attribute__((aligned(64)))
  int _onCacheLine2 __attribute__((aligned(64)))
}
```

Come otteniamo la grandezza di una linea della cache?ù
- Dal codice con `sysconf (_SC_LEVEL1_DCACHE_LINESIZE)`
- Dalla shell con `getconf LEVEL1_DCACHE_LINESIZE`

- Un'ultima soluzione è quella di creare delle variabili locali per ogni thread e far salvare le modifiche solo a fine computazione, questo perché se ogni thread scrive ad ogni modifica andrebbe a invalidare i dati per gli altri thread.