Impareremo a progettare applicazioni di basi di dati reali e di grandi dimensioni che sono impossibili da definire direttamente in un DBMS, va quindi investito molto tempo nella comprensione dei dati. Non esistono soluzioni uniche, si fanno delle scelte e si arriva ad una soluzione completa.

# Contesto Organizzativo

Nella progettazione e sviluppo di un software sono presenti varie figure:
- Committente
- Esperti del dominio
- Analisti
- Progettisti
- Programmatori
- Utenti Finali
- Manutentori

**Esempio** - Il comune XYZ vuole automatizzare la gestione delle contravvenzioni, ovvero dotare ogni vigile di un'app per smartphone che gli consenta di segnalare ad un sistema informatico il veicoli che ha commesso la contravvenzione, il luogo e la natura di quest'ultima. Il comune tramite dei bandi per la progettazione, realizzazione e manutenzione sceglie come aziende, rispettivamente ITSolutions, Develop e Ops.

Abbiamo quindi:

- Committente: Comune XYZ
- Analisti: Personale ITSolutions
- Progettisti: Personale ITSolutions
- Programmatori: Personale Develop
- Utenti Finali: Polizia locale XYZ
- Manutentori: Personale Ops
- Esperti del dominio? Funzionario del Comune o altro esperto del codice della strada.

# Ciclo di vita del Software

## Macro-fasi

1) **Studio di fattibilità** - In questa fase si comprendono i requisiti di alto livello, si valutano costi e benefici, vengono pianificate le attività e le risorse del progetto e si individua l'ambiente di programmazione sia hardware che software.

2) **Raccolta dei Requisiti** - Si raccolgono i requisiti dai vari attori e si "organizzano".

3) **Analisi Concettuale dei Requisiti** - Si produce lo _schema concettuale_ dell'applicazione, questo definisce _cosa_ deve fare l'applicazione indipendentemente dal _come_, in particolare:
   - Modella i dati di interesse, le loro articolazioni e interrelazioni
   - Specifica i servizi computazionali che l'applicazione dovrà offrire ai diversi utenti
   - È un modello logico-matematico che useremo come base da cui partire per le prossime attività di progettazione.

4) **Design dell'applicazione** - In questa fase si specifica come l'applicazione deve realizzare le sue funzioni, quindi si definisce l'architettura, le strutture di rappresentazione dei dati ovvero le memorie di massa e si sceglie quindi la tecnologia adatta.

5) **Realizzazione dell'applicazione** - Scrivere codice e documentazione

6) **Integrazione dei componenti e verifica dell'applicazione** - Si integrano fra loro tutte le componenti sviluppate in modo indipendente e si valuta se l'applicazione svolge correttamente tutti i compiti prefissati.

7) **Messa in esercizio dell'applicazione**

8) **Manutenzione dell'applicazione** - Si monitora l'esercizio dell'applicazione e vengono implementati aggiornamenti se necessario.

Al termine di ogni fase è possibile tornare indietro.

## Modelli

In contesti didattici si usa un modello **a cascata** ovvero ogni attività inizia quando termina le precedente.

Principalmente invece viene utilizzato un modello **a spirale o iterativo** ovvero si continuano a ripetere tutte le fasi e a ogni iterazione si rilascia una nuova versione più completa.

![[Image 27-02-25 at 10.00.jpg|500]]

_Foto rubata da [Marco Casu](https://github.com/CasuFrost)_

# UML

UML sta per Unified Modeling Language e definisce diversi tipi di diagrammi per modellare l'applicazione sotto prospettive diverse.

La metodologia che utilizziamo si basa su UML ma non è esattamente la metodologia utilizzata da UML, in particolare ci concentriamo solo sugli aspetti base ed i diagrammi più importanti.

Useremo solo i seguenti diagrammi:
- Diagrammi Strutturali:
	- Diagramma delle classi e degli oggetti
- Diagrammi comportamentali:
	- Diagramma degli use case
	- Diagramma degli stati e delle transizioni

---

Alcuni sono solo PDF dato che ci stanno principalmente solo regole per fare esercizi
# [[Analisi Concettuale dei Requisiti]]

# [[Analisi dei Requisiti - Documenti di Specifica]]

# [[Logica del Primo Ordine - FOL]]

Non so se li sistemerò un giorno 🤓
# [[Introduzione alla fase di progettazione]]

# [[Logica del Primo Ordine nell'Analisi Concettuale]]

# [[Linguaggio SQL]]