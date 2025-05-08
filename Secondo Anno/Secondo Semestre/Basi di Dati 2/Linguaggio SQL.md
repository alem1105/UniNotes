Usiamo un'architettura standard a 3 livelli per i DBMS, lo standard ANSI / SPARC:
1) **Livello interno** - implementa le strutture fisiche di memorizzazione (file sequenziali, file hash etc...)
2) **Livello logico** - Fornisce un modello logico dei dati, indipendenti da come sono memorizzati fisicamente, il **modello relazione**
3) **Livello esterno** - Fornisce una o più descrizioni di porzioni della base di dati indipendenti dallo schema logico infatti può prevedere organizzazioni dei dati alternative rispetto a quelle utilizzate.

Quindi un esempio di livello logico è:

![[Pasted image 20250508085805.png|400]]

Mentre per il livello esterno:

![[Pasted image 20250508085826.png|400]]

Questa è una possibile **vista** del database, ogni utente con diversi privilegi avrà una vista diversa.

---

Il linguaggio SQL ci fornisce delle strutture per operare:
- A livello logico
	- **Data Definition Language (DDL)** - per creare schemi di relazioni
	- **Data Manipolation Language (DML)** - Per interrogare ed aggiornare i dati
- A livello esterno - costrutti DDL per creare **viste** della base di dati

# Creazione di Database, Schemi e Tabelle

```
create database nome_database [opzioni]
Crea un database

create schema nome_schema [opzioni]
Crea uno schema (namespace) all'interno del database corrente

create table nome_table (...)
Crea una nuova tabella all'interno di uno schema del database corrente
```

## Creazione di Tabelle

```sql
create table [nome_schema]nome_tabella (
	nome_attributo dominio [vincoli di dominio]
	...
	[altri vincoli intra-relazionali]
	[vincoli inter-relazionali]
)
```

Il nome della schema è opzionale e se omesso viene usato lo schema di default senza nome.

_Esempio_

```sql
create table Corso (
	codice integer not null,
	nome character varying (100) not null,
	aula character varying (10) not null,
	primary key (codice)
)

create table Incarico (
	docente integer not null,
	corso integer not null,
	primary key (docente, corso),
	foreign key (docente) references Docente(matr),
	foreign key (corso) references Corso(codice)
)
```

### Domini SQL predefiniti
- Domini numerici
	- interi: integer, smallint...
	- decimali: numeric(prec, scala), decimali(prec, scala)
	- approssimati: float(prec), real, double precision
- Stringhe
	- character \[varying] (lung_max) (abbrev. in char / varchar)
	- text
	- ...
- Istanti temporali
	- date (tipo record con campi per anno, mese, giorno)
	- time (tipo record con campi per ora, min, sec)
	- timestamp (tipo record con campi per anno, ..., sec)
- Intervalli temporali: interval
- Valori booleani: Boolean, da SQL:1999 in poi
- Dati non strutturati di grandi dimensioni: CLOB e BLOB

### Valori di Deafult

```sql
create table Impiegato (
	nome ...,
	cognome ...,
	stipendio integer default 0,
	...
)
```

Se durante un inserimento o una modifica di questa tabella non viene indicato un valore per la colonna stipendio allora questo verrà impostato a 0.

### Vincoli di Dominio

```sql
create table Impiegato (
	nome varchar(100) not null ,
	cognome varchar(100) not null ,
	stipendio integer default 0
	check ( stipendio >= 0) , 
	...
)
```

- Ogni ennupla deve soddisfare il vincolo `stipendio >= 0`
- Il vincolo viene controllato in automatico all'inserimento e alla modifica
- In caso di violazione, l'inserimento o la modifica non avvengono e viene generato un errore.

### Vincoli di chiave

```sql
create table Studente (
	matricola integer not null,
	nome varchar(100) not null,
	cognome varchar(100) not null,
	nascita date,
	cf character(16) not null,
	// Chiave primaria (implica not null)
	primary key (matricola),
	unique (cf), //altra chiave
	unique (cognome, nome, nascita) //altra chiave
)
```

Se il vincolo di chiave è su un solo attributo possiamo usare anche:

```sql
create table Studente (
	matricola integer primary key, // implica not null
	...
)
```

---

> [!info] SQL e modello relazionale
> Una tabella SQL non rappresenta sempre una relazione infatti può contenere ennuple uguali, affinché rappresenti una relazione è necessario definire almeno una chiave.

_Esempio_

```sql
create table Studente (
	matr integer not null,
	cognome varchar(100) not null,
	nome varchar(100) not null
)
```

Da questa tabella possiamo ottenere:

![[Pasted image 20250508091740.png|300]]

Mentre con questa:

```sql
create table Studente (
	matr integer not null,
	cognome varchar(100) not null,
	nome varchar(100) not null,
	primary key (matr)
)
```

Non può accadere la situazione di prima con ennuple uguali.

## Vincoli di integrità referenziale

Costruiamo un database di esempio

![[Pasted image 20250508092047.png|400]]

```sql
create table Officina (
	nome varchar(100) not null,
	indirizzo varchar(500) not null,
	primary key (nome)
)

create table Veicolo (
	targa char(8) not null,
	tipo varchar(50) not null,
	primary key (targa)
)

create table Riparazione (
	officina varchar(100) not null,
	codice integer not null,
	veicolo char(8) not null 
	primary key (officina, codice)
	foreign key (officina) references Officina(nome),
	foreign key (veicolo) references Veicolo(targa)
)

create table RicambioRip (
	officina varchar(100) not null,
	rip int not null,
	ricambio char(5) not null,
	primary key (officina, rip, ricambio),
	foreign key (officina) references Officina(nome),
	foreign key (rip) references Riparazione(codice)
)

```

## Modifica e Cancellazione di tabelle, schemi e database
Modifca:
- `alter table`
	- `alter table add column`
	- `alter table drop column`
	- `alter table alter column`
	- `alter table add constraint`
	- `alter table drop constraint`
	- ...

Per la cancellazione.
- `drop table <nome tabella>`
- `drop schema <nome schema>`
- `drop database <nome database>`

# Domini SQL definiti dall'utente
Per l'utente è possibile definire:
- Domini specializzazione di altri domini
- Domini di tipo enumerativo
- Domini di tipo record

Ed SQL offre due comandi per fare questo:
- `create domain`
- `create type`
Che offrono diverse funzionalità

## Domini speciallizati
Un dominio specializzato definisce un sottoinsieme di valori di un dominio esistente

```sql
create domain nome_dominio as tipo_base
[valore di default]
[vincolo]
```

_Esempio - Definizione del dominio voto_

```sql
create domain voto as integer
default 0
check (value >= 18 and value <= 30)
```

## Domini Enumerativi
Un dominio enumerativo definisce un insieme finito, piccolo e stabile di valori ognuno identificato da un'etichetta.

```sql
create type nome_dominio as enum('valore1',..., 'valore N')
```

_Esempio - Definizione del dominio genere_

```sql
create type genere as enum('M', 'F')
```


> [!info] Etichette delle enum
> Le etichette delle enum non sono strighe ma identificatori veri e propri.

## Domini Tipi Record
I valori di un dominio di tipo record (o **dominio composto**) sono record di valori, uno per ogni campo del dominio. Il valore di ogni campo di un record è del rispettivo dominio.

```sql
create type nome_dominio as (
	campo1 dominio1, ..., campoN dominioN
)
```

_Esempio - Definizione del dominio composto indirizzo_

```sql
create type indirizzo (
	via varchar(200), citta varchar(100)
)
```


> [!info] Costrutto Create type
> Il costrutto create type non è implementato di standard e a seconda della versione può soffrire alcune limitazioni.

## Modifica e Cancellazione di Domini
Tutti i domini che abbiamo creato possono essere modificati o rimossi.

Modifica:
- `alter domain <nome dominio>`
- `alter type <nome dominio>`

Cancellazione:
- `drop dominio <nome dominio>`
- `drop type <nome dominio>`

# Generazione di Valori Progressivi
In alcune situazioni è necessario aggiungere un identificatore artificiale in una entità e quindi un attributo aggiuntivo.

_Esempio_

![[Pasted image 20250508094524.png|400]]

In questi casi è possibile lasciare al DBMS il compito di assegnare valori diversi per il campo **id** (generalmente progressivi) alle diverse ennuple.

Con **PostgreSQL** usiamo il seguente costrutto:

```sql
create table Prenotazione (
	id integer default nextval ('Prenotazione_id_seq') not null,
	istante timestamp not null,
	primary key (id)
);
```

Oppure in modo più breve:

```sql
create table Prenotazione (id serial not null, ...)
```

Per inserire ennuple:

```sql
insert into Prenotazione(istante)
	values ('2011-08-24 13:15:05') returning id
```

Questo costrutto PostgreSQL `returning id` permette al comando `insert` di restituire all'utente il valore per **id** scelto dal DBMS.

---

In MySQL invece abbiamo il modificatore `auto_increment` per gli attributi:

```sql
create table Prenotazione (
	id integer not null auto_increment,
	istante timestamp not null,
	primary key (id)
);
```

E per inserire ennuple usiamo:

```sql
insert into Prenotazione(istante) values ('2011-08-24 13:15:05')
```

# Viste
