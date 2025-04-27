1) Utente
	1) Nome
	2) Data registrazione
	3) Possono essere professionisti o privati
		1) Professionisti
			1) Serve URL con info legali
			2) Non possono comprare
			3) Popolarità - Si calcola in base al numero di utenti che hanno effettuato bid negli ultimi 12 mesi per loro articoli in asta o che hanno acquistato non in asta.
			   Bassa se sotto a 50, media se sotto a 300 alta se sopra a 300
		2) Privati
	4) Affidabilità - Si calcola in base ai feedback ricevuti, media aritmetica di tutti i feedback diminuita di un fattore che indica i feedback negativi. Detta $z$ la frazione dei feed negativi l'affidabilità è data da $\frac{m(1-z)}{5}$ dove $m$ è la media aritmetica di quelli positivi. 
	   L'affidabilità quindi è sempre un reale tra 0 e 1

2) Post
	1) Oggetto in vendita
	2) Tipologia
		1) Se con Asta va specificata la partenza, i rialzi e la scadenza. Per ogni asta scaduta ci interessa il bid che se l'è aggiudicata.
		2) Se senza asta allora solo prezzo di vendita

3) Oggetti
	1) Descrizione
	2) Categoria
		1) Le categorie devono essere organizzate in modo gerarchico, ad esempio Tecnologia è una categoria di primo livello e  Componenti PC, Telefoni, Console sono sottocategorie di tecnologia
	3) Prezzo - se con asta va calcolato, ovvero ultimo bid + prezzo rialzo
	4) Metodi di Pagamento (Bonifico - Carta di Credito)
	5) Nuovo o Usato
		1) Per quelli nuovi servono minimo due anni di garanzia, usati non obbligatorio
		2) Per oggetti usata vengono chieste informazioni sullo stato. (OTTIMO BUONO DISCRETO DA SISTEMARE)

4) bid - le offerte fatte dagli utenti
	1) Istante in cui è stato fatto
	2) Utente offerente (bidder)

5) feedback
	6) sono favoltativi
	7) voto da 0 a 5
	8) commento facoltativo