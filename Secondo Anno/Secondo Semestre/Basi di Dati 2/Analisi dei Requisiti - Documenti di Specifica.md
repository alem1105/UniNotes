Abbiamo visto che nel diagramma delle classi possiamo avere degli attributi da calcolare quando richiesto ma non viene specificato il come vengono calcolati.

Nel diagramma degli use - case invece non sono definite le operazioni degli use - case né cosa calcolano né se e come modificano i dati.

L'UML va quindi "accompagnato" da un documento di specifica che va ad aggiungere varie informazioni:
- Specifica dei tipi di dato: Serve a definire i tipi di dato non standard utilizzati nello schema concettuale
- Specifica di una classe: Definisce cosa calcola ogni operazione di classe e se e come modifica i dati esistenti
- Specifica di uno use - case: Definisce l'insieme delle operazioni di uno use - case, per ogni operazione definisce cosa calcola e come modifica i dati.
- Specifica dei vincoli esterni: Definisce ulteriori vincoli non definibili nel diagramma delle classi che gli oggetti / link devono soddisfare.

Vediamo esempi di questi documenti che vanno inclusi nello schema concettuale.

## Specifica dei tipi di Dato

_Esempio_

Fornisce informazioni su alcuni tipi di dati utilizzati in uno schema

![[Pasted image 20250319200231.png]]

## Specifica di Classe

_Esempio_

![[Pasted image 20250319201106.png]]

Le pre-condizioni vanno impostate su:
- Oggetto di invocazione
- Valori degli argomenti
- Altri oggetti del sistema
Queste devono essere soddisfatte affinché l'operazione possa essere invocata con successo

Le post-condizioni invece servono a:
- Definire valore di ritorno
- Definizione delle modifiche, creazione o eleminiazioni di nuovi oggetti o link.

Quindi mantenendo l'esempio di prima possiamo definire queste condizioni:

![[Pasted image 20250319201330.png]]

Pre - condizioni:
- Lo studente deve aver dato almeno un esame entro la data `d` altrimenti sarà impossibile calcolare la media.

Le post - condizioni ci indicano come calcolare il valore.

Ovviamente andrà fornita anche la specifica per l'operazione `voto_medio` di `Corso`

![[Pasted image 20250319201650.png]]

## Specifica di use - case

![[Pasted image 20250319204455.png]]

La precondizione è che uno studente per verbalizzare un voto di un corso non deve aver già verbalizzato un voto per quel corso.

La postcondizione è che verrà creato il link corrispondente

_Altro esempio_

![[Pasted image 20250319204631.png]]

Questo esempio copre il caso dell'iscrizione all'università, come precondizione quindi non deve esistere già uno studente con quella matricola e come postcondizione abbiamo la creazione dell'oggetto studente con i corrispondenti attributi.

## Specifica dei Vincoli Esterni
Abbiamo detto che sono vincoli non definibili nel diagramma

Prendiamo come esempio il seguente schema

![[Pasted image 20250319211348.png]]

E vogliamo che:
- I direttori afferiscono al dipartimento che dirigono
- Devono farlo da almeno da almeno 5 anni

Il primo requisito è fattibile facendo appunto `dirige` sottoclasse di `afferenza` ma per il secondo non possiamo fare nulla nel diagramma.

Questi vincoli vanno definiti nel documento in termini di:
- Identificatore univoco in modo da potersi riferire ad un vincolo specifico anche da altre parti dello schema. Questi identificatori usano degli standard, noi usiamo `[V.classi_a_cui_il_vincolo_si_applica.nome_vincolo]`
- Una asserzione che definisce quali sono le condizioni che devono essere soddisfatte dagli oggetti / link affinché siano in una situazione legale per il vincolo

Quindi riprendendo l'esempio di prima:

- `[V.Dipartimento.direttore_anni_afferenza]`

Per ogni oggetto `dip:Dipartimento` sia `dir:Impiegato` il direttore di `dip`, ovvero tale che `(dip, dir):dirige` deve essere `(dir, dip).inizio <= adesso - 5 anni`

---

Nel caso dove un vincolo esterno si applica agli oggetti di una sola classe è meglio definirlo nella specifica di quella classe piuttosto che nella specifica dei vincoli esterni (questo accade molto spesso)