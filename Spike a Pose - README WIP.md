Il progetto si basa sul riconoscimento di azioni durante partite di pallavolo tramite il caricamento di un video. Nello specifico:
- Bagher
- Muro
- Spike
- Servizio
- Neutro

Il nostro obiettivo era quello di fornire allo scoutman di squadre più piccole un supporto per appuntare le statistiche di ogni giocatore durante le partite.

## Tecnologie Utilizzate
Per creare l'applicazione abbiamo creato una pipeline che si basa sull'utilizzo del modello YOLO-POSE per tracciare i giocatori e raccogliere una collezione di 30 frame, ciascuno contenente 17 keypoints dello scheletro del giocatore.

Abbiamo poi analizzato diverse reti che avrebbero riconosciuto l'azione in base a questi keypoints:
- LSTM (Long Short Term Memory)
- Bi - LSTM (Bidirectional LSTM)
- ST - GCN (Spatial Temporal - Graph Convolutional Network)

La differenza sostanziale è nel come queste interpretano i dati.
- LSTM: Li appiattisce e li considera come un unico array, vede i frame dal 1 al 30.
- Bi - LSTM: Appiattisce ancora i dati ma guarda i frame da 1 a 30 e poi da 30 a 1.
- ST - GCN: Tramite delle matrici permette il "message passing" di informazioni all'interno dello scheletro umano, riuscendo a riconoscere pattern più complessi.

La nostra pipeline principale utilizza la ST - GCN.

## Dataset
Il Dataset lo abbiamo creato da zero utilizzando uno script che permetteva di selezionare un giocatore e salvare i suoi ultimi 30 frame, se disponibili, su un file annotandolo direttamente nella classe scelta.

Il problema principale è che è molto piccolo e soprattutto sbilanciato.

## Addestramento delle Reti

## Video Output