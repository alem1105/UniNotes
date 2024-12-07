**Traccia:**
Il tuo caro amico Pico de Paperis ti ha mandato un messaggio molto strano scarabocchiato su una cartolina.
Ê da tanto che non lo vedi e da sempre vi divertite a scrivervi in codice.
Per decodificare il suo messaggio vai a cercare nella tua biblioteca un libro un po' particolare,
il cifrario di Archimede Pitagorico. Il cifrario da applicare è la famosa "Cifra del Faraone".
La decifrazione col metodo del Faraone si basa su delle regole di sostituzione di sequenze di simboli nel testo.
Il motivo per cui si chiama "cifra del Faraone" è che in antico Egizio le sequenze formate da più geroglifici
potevano essere scritte in qualsiasi ordine, quindi ogni anagramma delle sequenze era valido.
Per rendere la cosa più strana, Pico de Paperis ha deciso di usare un cifrario che non è esattamente quello del
Faraone, ma una sua variante. Invece di usare gli anagrammi usa dei "quasi anagrammi", cioè anagrammi che nel testo
originale hanno un carattere spurio in più rispetto alla sequenza cercata.
Nel cifrario sono contenute coppie di sequenze che indicano come trasformare il testo.
Ad esempio la coppia 'shampoo' -> 'soap' corrisponde a cercare un punto del messaggio in cui appare la sequenza 'shampoo'
(o un suo anagramma) ma con un carattere in più (ad esempio 'pmQohaso') e sostituirla con la sequenza 'soap'.

La decodifica del messaggio può portare a più possibili messaggi finali, perchè possono esserci più sequenze nel testo
che possono essere trasformate in ogni momento e l'ordine delle trasformazioni influenza le trasformazioni successive.
Ad un certo punto succederà che nessun "quasi-anagramma" delle sequenze del cifrario è presente in nessun punto
della sequenza di simboli per cui non è più possibile fare trasformazioni.
Queste sequenze le chiamiamo sequenze finali.
Di tutte le possibili sequenze finali,ci interessa l'insieme delle più corte.

Per decodificare il messaggio di Pico de Paperis devi implementare la funzione
pharaohs_revenge(encrypted_text : str, pharaohs_cypher : dict\[str,str]) -> set\[str]:
che riceve come argomenti:
- il testo che ti ha mandato Pico de Paperis, come stringa di simboli (caratteri)
- il cifrario da applicare, un dizionario che ha come chiavi le sequenze di cui cercare nel testo un quasi-anagramma
   e come valore associato la stringa da sostituire al quasi-anagramma trovato.
la funzione deve tornare l'insieme dei più brevi testi ottenibili applicando ripetutamente
le trasformazioni fin quando non è più possibile applicarne nessuna.

Esempio:
encrypted_text  = 'astronaut-flying-cyrcus'
pharaohs_cypher = {'tuar': 'me', 'cniy': 'op', 'sorta': 'tur', 'fult': 'at', 'rycg': 'nc'}

Risultato: {'tmeopcus', 'metopcus', 'ameopcus', 'atmepcus'}
e tutte le trasformazioni applicate sono quelle contenute nel file example.txt
(in ordine alfabetico e senza ripetizioni)

NOTA: almeno una delle funzioni o metodi che realizzate deve essere ricorsiva
NOTA: la funzione/metodo ricorsivo/o deve essere definita a livello più esterno
      altrimenti fallirete il test di ricorsione.

**Mia Soluzione:**
```python
def is_anagram(checking, word, set_done):
    if all(checking.count(char) >= word.count(char) for char in word):
        set_done[word].add(checking)
        return True


def translate(text, cypher, done, combinations, key_sets, set_done):
    transitions = False
    text_set = set(text)

    for word in cypher:

        if key_sets[word].issubset(text_set):

            word_set = key_sets[word]

            word_len = len(word)
            for i in range(len(text) - word_len):
                checking = text[i:i + word_len + 1]
                if word_set.issubset(checking):
                    if checking in set_done[word] or is_anagram(checking, word, set_done):
                        new_text = text[:i] + cypher[word] + text[i + word_len + 1:]
                        if new_text not in done:
                            translate(new_text, cypher, done, combinations, key_sets, set_done)
                            transitions = True
                    if not word_set.issubset(text[i + 1:]):
                        break

    done.add(text)
    if not transitions:
        combinations.add(text)


def pharaohs_revenge(encrypted_text: str, pharaohs_cypher: dict[str, str]) -> set[str]:
    key_sets = {key: set(key) for key in pharaohs_cypher}
    combinations = set()
    set_done = {key: set() for key in pharaohs_cypher}
    translate(encrypted_text, pharaohs_cypher, set(), combinations, key_sets, set_done)
    min_len = len(min(combinations, key=len))
    return {elem for elem in combinations if len(elem) == min_len}
```
