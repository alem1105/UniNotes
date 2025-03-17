Abbiamo il seguente problema:

Tre contenitori di capienza 4, 7 e 10 litri, inizialmente i contenitori da 4 e 7 sono pieni e quello da 10 vuoto. Possiamo soltanto versare acqua da un contenitori all'altro e fermarci solo quando il contenitore sorgente è vuoto o il destinazione è pieno.

Esiste una sequenza di operazioni che termina lasciando esattamente due litri d'acqua nel contenitore da 4 o da 7?

Possiamo modellare il problema con un grafo diretto dove i nodi sono i possibili stati di riempimento dei 3 contenitori, avremo quindi delle terne $(a,b,c)$ dove $a$ indica il contenitore da 4, $b$ quello da 7 e $c$ quello da 10.

Metteremo degli archi fra due nodi se è possibile passare fra lo stato di uno verso l'altro. Un frammento del grafo sarà quindi:

![[Pasted image 20250316165612.png|400]]

Per risolvere il problema dobbiamo capire se uno dei due nodi $(2,x,y), (x,2,y)$ è raggiungibile dal nodo $(4,7,0)$.

Abbiamo quindi modellato il problema per risolverlo con le visite, ad esempio possiamo usare una visita in ampiezza con costo $O(n+m)$ per la ricerca del cammino minimo.

Adesso però consideriamo una variante del problema, definiamo un'operazione "buona" se termina lasciando esattamente 2 litri in uno dei due contenitori; definiamo un'operazione "parsimoniosa" se il totale dei litri versati in tutti i versamenti è minimo rispetto a tutte le altre sequenza, ovvero che abbiamo spostato il minimo numero di litri.

Per modellare il problema in questo modo possiamo assegnare un costo ad ogni arco dove il costo sarà uguale ai litri spostati. Una porzione del grafo sarà quindi:

![[Pasted image 20250316170052.png]]

Adesso quindi non vogliamo più il cammino minimo a livello di archi percorsi ma il cammino minimo a livello di costo ovvero litri spostati.

---

Un'idea potrebbe essere quella di inserire dei **nodi dummy** ovvero fasulli negli archi, ad esempio se un arco pesa 3 inseriamo due nodi finti in modo che è come se attraversassimo 3 archi invece che 1:

![[Pasted image 20250316170220.png]]

Questa soluzione è possibile però soltanto quando i costi degli archi sono interi e abbastanza piccoli altrimenti non è scalabile come soluzione.