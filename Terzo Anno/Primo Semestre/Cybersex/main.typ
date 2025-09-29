#import "@preview/showybox:2.0.4": showybox
#import "@preview/fontawesome:0.6.0": *

#import "@preview/ilm:1.4.1": *

#set text(lang: "it")

#show: ilm.with(
  title: [Cybersecurity],
  author: "Alessio Marini, 2122855",
  date: datetime(year: 2025, month: 09, day: 27),
  abstract: [Appunti presi durante il corso di *Cybersecurity* nell'anno *2025/2026* del professore Angelo Spognardi. \ 
  Gli appunti li scrivo principalmente per rendere il corso più comprensibile *a me* e anche per imparare il linguaggio Typst. Se li usate per studiare verificate sempre le informazioni 🙏🏻. \ \
  *Contatti*: \
  #fa-icon("github") #link("www.github.com/alem1105")[alem1105]\
  #fa-icon("envelope", solid: false) #link("mailto:marini.2122855@studenti.uniroma1.it")[marini.2122855\@studenti.uniroma1.it]
  ],
  figure-index: (enabled: false),
  table-index: (enabled: false),
  listing-index: (enabled: false),
  external-link-circle: false,
)

#set math.equation(numbering: none)

#include "introduzione.typ"