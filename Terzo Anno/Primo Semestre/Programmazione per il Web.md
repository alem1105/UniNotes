# APP
Un **APP** è un'applicazione che utilizziamo sui nostri dispositivi, ne esistono di diversi tipi:
- **Desktop APP**: Vengono eseguite sui sistemi operativi dei computer. Spesso richiedono un'installazione.
- **Mobile APP**: Vengono eseguite sui sistemi operativi dei dispositivi mobili. Hanno bisogno di un'installazione e si dividono in altri due sottotipi:
	- **Native APP**: Sono state scritte in un linguaggio nativo per quel sistema operativo come ad esempio **Kotlin -> Android** oppure **Swift -> iOS**.
	- **Hybrid APP**: Scritte usando tecnologie web cross-compiled per diversi sistemi operativi.
- **Web APP**: Vengono eseguiti sui browser web quindi abbiamo bisogno di una connessione ad internet.
	- **Single Page Application**: Una web app che aggiorna i dati presenti in una pagina quando questi vengono aggiornati in un server.
	- **Progressive Web App**: Una web app che può essere installata sul dispositivo tramite la cache del browser web rendendola accessibile anche offline o quando siamo con una connessione internet debole.

## Web Application
Il codice di un'applicazione web viene eseguito in diversi "posti":
- Il codice della logica locale, come ad esempio la validazione di alcuni dati o in generale piccole elaborazioni e quello dell'interfaccia grafica vengono eseguiti nel browser web.
- La logica dell'applicazione quindi elaborazioni più pesanti e anche il Database Management System vengono eseguiti su un server.

Infatti possiamo dividere un web app in due parti:
- **Front-end**: Comprende la UI e in generale quello che riguarda i client. Si utilizzano principalmente linguaggi come HTML, CSS, Javascript e Asynchronous request (AJAX)
- **Back-end**: Comprende quello che viene eseguito sul server e in generale la logica dell'applicazione. Di solito comprende quindi delle API, uno storage e un DBMS.
  Principalmente vengono usati linguaggi come PHP, Python, C#, Java, Go....
  Noi nel corso approfondiremo Go.

Le API sono un'interfaccia che permette la comunicazione tra il backend e il frontend (tra browser e server).