#import "@preview/ilm:2.1.1": *

#show: ilm.with(
  title: [Appunti Tirocinio],
  authors: "Alessio Marini",
  abstract: [Appunti presi per il mio Tirocinio interno presso il Vision-Lab.],
  listing-index: (enabled: false),
  figure-index: (enabled: false),
  table-index: (enabled: false),
  table-of-contents: []
)

#set text(
  font: "New Computer Modern",
  size: 11pt, 
  lang: "it", // Fondamentale per attivare la sillabazione corretta in italiano
)
#show math.equation: set text(font: "New Computer Modern Math")
#set math.equation(numbering: none)

#set par(
  justify: true,
  leading: 0.65em,         // Interlinea (distanza tra le righe di uno stesso paragrafo)
  first-line-indent: 1.5em // Il classico "\parindent" di LaTeX
)

#set par(spacing: 0.65em)

#set page(
  margin: (
    top: 3cm,
    bottom: 3cm,
    left: 3cm, 
    right: 3cm
  )
)

#show heading: set block(above: 1.5em, below: 1em)

#include "preliminaries.typ"
#include "lnn_for_regression.typ"
#include "lnn_for_classification.typ"
#include "multilayer_perceptrons.typ"
#include "cnn.typ"