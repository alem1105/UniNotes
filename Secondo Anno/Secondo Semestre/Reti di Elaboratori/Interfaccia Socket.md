# Comunicazione tra Processi
Nel paradigma client / server la comunicazione a livello di applicazione avviene fra due processi: un client e un server.
- Di solito il client è quello che inizia la comunicazione inviando una richiesta al server
- Il server è in attesa di richieste dai client

## API: Application Progamming Interface
Se vogliamo sviluppare un programma in grado di comunicare con un altro programma abbiamo bisogno di un set di istruzioni che riescano a:
- Chiedere ai primi 4 livelli dello stack TCP / IP di aprire una connessione
- Inviare e ricevere dati
- Chiudere la connessione

Un insieme di istruzioni di questo tipo si chiama **API**

# Interfaccia Socket
I primi 4 livelli quindi racchiudono quella che prende il nome di interfaccia socket:

![[Pasted image 20250407103705.png|500]]

Il socket appare quindi come un terminale / file ma non è fisico, è un'astrazione per una struttura dati utilizzata dalle applicazioni.

Se due applicazioni comunicano fra loro significa che in realtà sono i loro socket che stanno comunicando.

Per permettere la comunicazione ci serve un **socket address**, composto da:
- Indirizzo IP - 32 bit
- Numero di porta - 16 bit

## Indirizzamento dei Processi
Due applicazioni per comunicare hanno bisogno di identificarsi:
- Tramite l'indirizzo IP identifichiamo l'host a cui inviare i dati
- Tramite il numero di porta identifichiamo il processo sull'host

Il numero di porta è contenuto negli header di livello di trasporto.

_Come viene recapitato un messaggio_

![[Pasted image 20250407110158.png|500]]

---

Ma come vengono individuati questi socket? Infatti dato che la comunicazione è bidirezionale ne abbiamo bisogno sia lato client che lato server.

**Lato Server**
- Socket Address locale fornito dal SO
- Numero di porta fornito dal progettista

- Socket Address remoto corrisponde al socket address locale del client che invia le richieste al server

Quindi il socket address locale di un server non cambia ma cambia quello remoto, anche se comunichiamo con lo stesso client può cambiare se abbiamo più connessioni con esso.

**Lato Client**
- Socket Address locale fornito dal SO
- Il numero di porta viene assegnato sempre dal SO in modo temporaneo, deve essere inutilizzato in quel momento

Per il socket address remoto:
- L'indirizzo IP viene fornito dal DNS
- La porta è nota in base all'applicazione, es 80 HTTP

Oppure se stiamo testando un'applicazione conosceremo sia IP che Porta.

## Socket TCP o UDP?
Dato che i due processi per comunicare utilizzano i servizi offerti dal livello di trasporto e qui usiamo i protocolli TCP o UDP, in base a quello scelto cambia anche il tipo di socket da usare.

Il tipo da scegliere varia in base a quello di cui ha bisogno l'applicazione:
- Perdita di dati - Alcune applicazioni tollerano la perdita di dati mentre altre hanno bisogno di una altissima fedeltà
- Temporizzazione - Alcune applicazioni come i giochi online hanno bisogno di piccoli ritardi mentre altre come la posta elettronica non hanno particolari richieste
- Throughput - Alcune applicazioni hanno bisogno di un'ampiezza di banda minima mentre ad altre non interessa
- Sicurezza - Alcune applicazioni richiedono la cifratura dei dati

Quindi, TCP offre:
- Trasporto affidabile
- Servizio orientato alla connessione
- Controllo di flusso e congestione

Mentre UDP offre:
- Trasporto non affidabile
- Senza connessione
- Nessun controllo di flusso e congestione

## Programmazione con Socket
Impariamo a costruire un'applicazione client / server che comunica utilizzando socket.

Il socket è quindi un'interfaccia locale creata dalle applicazioni dove i processi possono inviare e ricevere messaggi da processi di altre applicazioni. Tramite questa possiamo inviare datagrammi inaffidabili oppure avere un trasporto affidabile con un flusso orientato di byte.

### Programmazione Socket TCP
- Socket - Un ingresso tra il processo di un'applicazione e il protocollo di trasporto end - to - end (UDP o TCP)
- Servizio TCP - Trasferimento affidabile di byte da un processo all'altro

Si parla di flusso di byte ovvero una sequenza di byte che fluisce verso o da un processo:
- Flusso d'ingresso se viene dall'esterno (socket) e fluisce nel processo
- Flusso di uscita se dal processo va verso l'esterno

Per permettere la connessione:
- Il server deve essere sempre in esecuzione e aver creato un socket che "accoglie" il client
- Il client contatta il server creando un socket TCP, specificando il suo indirizzo IP e il numero di porta del processo che sta usando.
- Creato il socket è stata stabilita una connessione con il server.

Una volta che il server ha accettato il client, deve creare un nuovo socket e spostare li la connessione, in questo modo può accettare più connessione.

Quindi per aprire la connessione abbiamo:

![[Pasted image 20250407112103.png|500]]

Una volta stabilita, si libera il socket di "benvenuto" e se ne crea uno nuovo:

![[Pasted image 20250407112128.png|500]]

La comunicazione avviene quindi in questo modo:

![[Pasted image 20250407112239.png|500]]

> [!example]- Esempio Applicazione
> 
>_Esempio di applicazione_
>1) Il client legge una riga dall'input dell'utente e la invia al server tramite >la socket
>2) Il server legge la riga dalla socket
>3) Il server converte la riga in maiuscolo e la invia al client
>4) Il client legge la riga nella socket e la visualizza

---

In Java tramite il package `java.net` abbiamo a disposizione interfacce e classi per l'implementazione di applicazioni di rete:
- `Socket` `ServerSocket` per connessioni TCP
- `DatagramSocket` per connessioni UDP
- `URL` per HTTP
- `InetAddress` per rappresentare indirizzi
- `URLConnection` per rappresentare connessioni ad un URL

_Scriviamo un applicazione per comunicare TCP in Java_

- Scriviamo il Client:

```Java
importa java.io.*;
importa java.net.*;

class TCPClient {
	public static void main(String argv[]) throws Exception {
		String sentence;
		String modifiedSentence;

		// Crea Flusso di ingresso
		BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
		// Crea un socket client connesso al server
		Socket clientSocket = new Socket("hostname", 6789);
		// Crea un flusso di uscita collegato al socket
		DataOutputStream outToServer = new DataOutputStream(clientSocket.getOutputStream());
		// Crea un flusso di ingresso collegato al socket
		BufferedReader inFromServer = new BufferedReader(new InputStreamReader(clientSocket.getInputStream()));
		
		System.out.print("Inserisci una frase: ");
		sentence = inFromUser.readLine();

		// Invia la frase inserita al server
		outToServer.writeBytes(sentence + '\n');
		// Legge la risposta dal server
		modifiedSentence = inFromServer.readLine();
		System.out.println("FROM SERVER: " + modifiedSentence);
		// Chiude la connessione
		clientSocket.close();
	}
}
```

- Scriviamo il Server:

```Java
import java.io.*;
import java.net.*;
class TCPServer {
public static void main(String argv[]) throws Exception
{
	String clientSentence;
	String capitalizedSentence;
	// Crea Socket di benvenuto
	ServerSocket welcomeSocket = new ServerSocket(6789);
	while(true) {
	// Attende sul benvenuto un client
		Socket connectionSocket = welcomeSocket.accept();
	// Crea flusso di ingresso collegato al socket
		BufferedReader inFromClient =
			new BufferedReader(new
			InputStreamReader(connectionSocket.getInputStream()));
	// Crea flusso di uscita collegato al socket
		DataOutputStream outToClient =
		new DataOutputStream(connectionSocket.getOutputStream());
	// Legge la riga dal socket
		clientSentence = inFromClient.readLine();
		capitalizedSentence = clientSentence.toUpperCase() + '\n';
	// Scrive la riga sul socket
		outToClient.writeBytes(capitalizedSentence);
	}
}
}
```

### Programmazione Socket UDP
In UDP non c'è connessione tra client e server, quindi:
- Non c'è handshaking
- Il mittente allega esplicitamente a ogni pacchetto l'indirizzo IP e la porta di destinazione
- Il server deve estrarre l'indirizzo IP e la porta del mittente del pacchetto ricevuto

Inoltre in questo tipo di connessione i pacchetti potrebbero arrivare in ordine diverso rispetto a quello di invio. Trasferiamo "datagrammi" in modo inaffidabile.

La comunicazione avviene in questo modo:

![[Pasted image 20250407121448.png|500]]

- Scriviamo il client in Java

```Java
import java.io.*;
import java.net.*;

class UDPClient {
	public static void main(String args[]) throws Exception
	{
// Crea flusso di ingresso
	BufferedReader inFromUser =
		new BufferedReader(new InputStreamReader(System.in));
// Crea socket client
	DatagramSocket clientSocket = new DatagramSocket();
// Traduce il nome dell'host in indirizzo IP con DNS
	InetAddress IPAddress = InetAddress.getByName("hostname");
	
	byte[] sendData = new byte[1024];
	byte[] receiveData = new byte[1024];
	String sentence = inFromUser.readLine();
	sendData = sentence.getBytes();
// Crea il datagramma con dati, lunghezza, IP, porta
	DatagramPacket sendPacket =
		new DatagramPacket(sendData, sendData.length, IPAddress, 9876);
// Invia il datagramma al server
	clientSocket.send(sendPacket);
	DatagramPacket receivePacket =
		new DatagramPacket(receiveData, receiveData.length);
// Legge il datagramma ricevuto dal server
	clientSocket.receive(receivePacket);
	
	String modifiedSentence =
		new String(receivePacket.getData());
	System.out.println("FROM SERVER:" + modifiedSentence);
	clientSocket.close();
	}
}
```

- Scriviamo il server

```Java
import java.io.*;
import java.net.*;
class UDPServer {
	public static void main(String args[]) throws Exception
	{
	// Crea socket per datagramma sulla porta 9876
		DatagramSocket serverSocket = new DatagramSocket(9876);
		byte[] receiveData = new byte[1024];
		byte[] sendData = new byte[1024];
		while(true)
		{
		// Crea spazio per i datagrammi
			DatagramPacket receivePacket =
			new DatagramPacket(receiveData, receiveData.length);
		// Riceve i datagrammi
			serverSocket.receive(receivePacket);
			String sentence = new String(receivePacket.getData());
		// Ottiene l' indirizzo IP e il numero di porta dal mittente
			InetAddress IPAddress = receivePacket.getAddress();
			int port = receivePacket.getPort();
			String capitalizedSentence = sentence.toUpperCase();
			sendData = capitalizedSentence.getBytes();
		// Crea il datagramma da inviare al client
			DatagramPacket sendPacket =
			new DatagramPacket(sendData, sendData.length, IPAddress,port);
		// Scrive il datagramma sulla socket
			serverSocket.send(sendPacket);
		} // Fine while
	}
}
```

