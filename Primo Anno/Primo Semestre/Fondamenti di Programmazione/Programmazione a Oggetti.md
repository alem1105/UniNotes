L'obiettivo della programmazione a oggetti è quello di rendere il codice riutilizzabile, si basa sulla creazione di *classi e oggetti*.
Le classi *forniscono un mezzo per costruire nuove strutture dati*, un oggetto è *un'istanza* di quella classe

***Esempio:***
![[Pasted image 20231206095157.png]]

Proviamo adesso a ripensare alle immagini (matrici) ma come oggetti, quindi con attributi e metodi.
![[Pasted image 20231206095722.png]]

```python
class Color:

	def __init__(self, r, g, b):
		print(f'Object is initialized with id {id(self)} type {type(self)}')
		self._r = r
		self._g = g
		self._b = b

	def __repr__(self):
		return f"Color ({self._r}, {self._g}, {self._b})"

c1 = Color(0, 0, 0) # Istanza di un oggetto
```

- *class Color* indica la definizione della classe.
- *\_\_init\_\_* è il costruttore ovvero il metodo che crea oggetti, in questo caso crea oggetti e memorizza i valori r, g, b.
- *\_\_self\_\_* va aggiunto nei metodi di una classe. Si riferisce all'oggetto istanza che verrà creato successivamente quando chiamiamo la classe con *c1 = Color(0,0,0)*, c1 sarebbe "self".
- *\_\_repr\_\_* è il metodo che riscriviamo per mostrare la rappresentazione a video dell'oggetto quando lo stampiamo con print()
- **NB** solitamente in Python gli attributi con _ sono da considerarsi privati (\_r, \_g, \_b).

# Ereditarietà
Cosa succede se abbiamo un colore con 'alpha' channel? Ovvero un colore che estende la tripla RGB codificando la trasparenza dei colori in un quarto canale alpha.
![[Pasted image 20231206105632.png]]

La classe *ColorAlpha* eredita tutti gli attributi e metodi dalla classe *Color* ma la estende con l'attributo *alpha*, vediamo come scriverlo in codice:
```python
class ColorAlpha(Color):
	def __init__(self, r, g, b, a):
		super().__init__(r, g, b)
		self._a = a

	def __repr__(self):
		return super().__repr__()[:-1] + f', {self._a}'
```

Tramite *super* chiamo il costruttore della classe madre *Color* e poi estendo l'oggetto con l'attributo alpha.
Anche il metodo \_\_repr\_\_  è un estensione del metodo della classe madre.
Quindi per creare un oggetto di tipo *ColorAlpha* dovrò scrivere:
```python
ca1 = ColorAlpha(255,255,0,0)
```

# Attributi di Classe e di Oggetto

```python
class Color:

	n_istances = 0

	def __init__(self, r, g, b):
		self._r = r
		self._g = g
		self._b = b
		Color.n_istances += 1
```

- *n_istances* sarà un attributo di classe, ovvero in comune tra tutte le istanze
- *r, g, b* sono attributi di oggetto, quindi ogni oggetto avrà quegli attributi ma con valori diversi
- **NB** Posso accedere agli attributi di classe anche dagli oggetti
```python
c = Color(255,0,0)

Color.n_istances
c.n_istances
```
Le due righe di codice accedono allo stesso dato.
**Devo stare attento però a non scrivere un attributo di classe tramite un oggetto, in quel caso l'attributo diventa specifico per quell'istanza**
```python
# Mettiamo caso che n_istances valga 2
# Se scrivo:
c.n_istances = 0
# Stampo entrambi
c.n_istances, Color.n_istances
# Ottengo
(0, 2)
```

# Metodi di Classe
Un metodo di classe riceve una classe come primo argomento implicito, così come una istanza oggetto riceve un riferimento a se stessa.

```python
class Alien:

	n_istances = 0

	@classmethod
	def get_n_istances(cls):
		return cls.n_istances

	@classmethod
	def increment_istances(cls):
		cls.n_istances += 1

	@classmethod
	def decrement_istances(cls):
		cls.n_istances -= 1
```

*@classmethod* è un **decoratore**, ovvero serve ad aggiungere funzionalità ad una funzione senza modificarla.

# Decoratori
Assumiamo di avere una funzione che non possiamo modificare, ma vogliamo aggiungere delle funzionalità ad essa, come facciamo?
```python
def my_locked_function():
	print('Main code of the locked function 1')
```

Il trucco sta nel ricordarsi che possiamo passare funzioni ad altre funzioni
```python
#Decoratore
def before_and_after_decorator(func):
	def my_wrapping_function():
		print('> Decorator: before')
		func()
		print('> Decorator: after')
	return my_wrapping_function

def my_locked_function():
	print('Main code of the locked function 1')

# dec sara' di tipo funzione
dec = before_and_after_decorator(my_locked_function) 
```

Eseguendo dec() ottengo:
```python
'> Decorator: before'
'Main code of the locked function 1'
'> Decorator: after'
```

Invece di assegnare ogni volta una variabile come nuova funzione, posso usare direttamente il mio decoratore con la seguente sintassi:
```python
@before_and_after_decorator
def my_locked_function():
	print('Main code of the locked function')
```

# Overloading Operatori
Dopo aver creato una nuova struttura dati, magari vogliamo cambiare il suo comportamento quando effettuiamo operazioni tra sue istanze, come ad esempio la somma o la sottrazione. Lo abbiamo già fatto con il metodo *\_\_repr\_\_* ma vediamo come fare:
```python
class Color:

	def __add__(self, other_col):
		return Color(self._r + other_col._r,
					 self._g + other_col._g,
					 self._b + other_col._b)
```

In questo modo abbiamo effettuato l'overloading dell'operatore somma, andando quindi a sommare due istanze della classe Color otterremo un oggetto che ha come valori la somma dei valori RGB.

**E' possibile definire la somma fra due colori e anche la moltiplicazione fra colore e scalare?**
```python
class Color:

	def __mul__(self, k):
		if isistance(k, int):
			print('using scalar multiply')
			return Color(self._r*k, self._g*k, self._b*k)
		elif isistance(k, Color):
			print('using elementwise multiply')
			return Color(self._r*k._r, self._g*k._g, self._b*k._b)
		else:
			raise TypeError(f'Only multiplying between a) two colors b) color and a scalar are allowed, but i got {type(k)}')
```

In questo modo se nella moltiplicazione, i fattori sono due colori moltiplichiamo tra loro i canali RGB, altrimenti se abbiamo un colore e uno scalare, moltiplichiamo i canali RGB per quell'intero.
Nel caso riceviamo un tipo diverso da *int* o *Color* solleviamo un'eccezione e spieghiamo cosa è successo.

# Gestione delle eccezioni
Come abbiamo visto prima possiamo generare degli errori, ma possiamo anche gestirli per non far terminare il nostro programma.
Utilizziamo il costrutto *try - except - finally*
- **try**: prova ad eseguire il blocco
- **except**: cattura l'eccezione specificata
- **finally**: assicura che il blocco di codice sia sempre eseguito
```python
c1 = Color(255,255,0)

try:
	fw = open('./tmp.txt', mode='w')
	fw.write(repr(c1))
	c1 * 'foobar'
	a = 1/0
	fw.close()
except TypeError as te:
	print('Someone tried to do a multiplication with a color and an unlnown type\nThe error was:')
	print(te)
except ZeroDivisionError as de:
	print(de)
finally:
	print('> This part of the code should always complete')
	del c1
	fw.close()
```

Possiamo anche gestire più eccezioni nello stesso blocco