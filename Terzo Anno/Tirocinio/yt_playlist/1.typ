#import "@preview/zebraw:0.6.3": *
#show: zebraw.with(numbering: false, lang: false)
#import "@preview/showybox:2.0.4": showybox

= How do AI and Neural Networks work?
L'*IA* è quel campo che si occupa di creare macchine e sistemi in grado di compiere tasks che normalmente richiederebbero l'intelligenza umana. Il *Machine Learning* è un sottoinsieme dell'AI dove i _modelli_ vengono addestrati su dei dati, questi modelli potranno poi essere utilizzati per riconoscere pattern e fare quindi delle predizioni.

Uno dei metodi principali del machine learning sono le *Neural Networks*, queste sono alla base dei famosi _Large Language Model_ come ChatGPT.

Una rete neurale è composta da 3 elementi principali, *input nodes, hidden layer, output nodes*. Se gli hidden layer sono più di 1 allora la rete è detta _deep neural network_. I nodi di una rete prendono il nome di *neuroni*.

#align(
  center,
  figure(image("/assets/image-115.png", width: 50%), caption: "Struttura base di una Neural Network")
)

Per capire più a fondo il funzionamento base, prendiamo delle piccole immagini di $5 dot 4 = 20$ pixels, ognuna che rappresenta un numero da $0$ a $9$.

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  figure(image("/assets/image-116.png", width: 50%), caption: [Tutte le immagini]),
  figure(image("/assets/image-117.png", width: 65%), caption: [Ogni pixel è rappresentato da un valore]),
)

In questo caso l'$1$ rappresenta il colore giallo mentre lo $0$ rappresenta il bianco.

Possiamo costruire una rete molto semplice composta soltanto da $20$ input nodes, uno per ogni pixel, nessun hidden layers e un solo output node.