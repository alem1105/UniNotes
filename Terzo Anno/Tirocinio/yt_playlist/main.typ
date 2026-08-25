#import "@preview/ilm:2.1.1": *

#show: ilm.with(
  title: [Appunti AI - ML - Deep Learning],
  authors: "Alessio Marini",
  abstract: [Cose viste da playlist carine su YT],
  listing-index: (enabled: false),
  figure-index: (enabled: false),
  table-index: (enabled: false),
  table-of-contents: []
)

#set text(
  font: "New Computer Modern",
  size: 11pt, 
  lang: "it",
)
#show math.equation: set text(font: "New Computer Modern Math")
#set math.equation(numbering: none)

#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 1.5em
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

#include "1.typ"