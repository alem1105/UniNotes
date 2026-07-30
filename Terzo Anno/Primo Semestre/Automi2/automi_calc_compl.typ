#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *
#import "@preview/ilm:1.4.0": ilm
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge

#ilm(
  title: [Automi, Calcolabilità e Complessità],
  author: "Alessio Marini, 2122855",
  date: datetime(year: 2026, month: 05, day: 20),
  abstract: [Appunti presi durante il corso di *Automi, Calcolabilità e Complessità* nell'anno *2025/2026* del professore Daniele Venturi. \ 
  Gli appunti li scrivo principalmente per rendere il corso più comprensibile *a me* e anche per imparare il linguaggio Typst. Se li usate per studiare verificate sempre le informazioni 🙏🏻. \ \
  *Contatti*: \
  #fa-icon("github") #link("www.github.com/alem1105")[alem1105]\
  #fa-icon("envelope", solid: false) #link("mailto:marini.2122855@studenti.uniroma1.it")[marini.2122855\@studenti.uniroma1.it]],
  []
)

#set text(
  font: "New Computer Modern",
  size: 11pt, 
  lang: "it", // Fondamentale per attivare la sillabazione corretta in italiano
)

#include "automi2.typ"
#include "calcolabilita2.typ"
#include "complessita2.typ"