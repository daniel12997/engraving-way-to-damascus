// Push Engraving on Copper Plate: The Conversion on the Way to Damascus
// Historical Recreation Documentation
//
// Build with: typst compile paper.typ
// Live preview: typst watch paper.typ

// =============================================================================
// Document metadata
// =============================================================================

#set document(
  title: "Push Engraving on Copper Plate: The Conversion on the Way to Damascus",
  author: "Daniel Parker",
  date: datetime(year: 2026, month: 4, day: 1),
)

// =============================================================================
// Page layout
// =============================================================================

// Front matter (title, contents) is unnumbered.
// Body sections switch to arabic numbering starting at 1 below.
#set page(
  paper: "us-letter",
  margin: (x: 1.25in, top: 1in, bottom: 1in),
  numbering: none,
  number-align: center + bottom,
)

// =============================================================================
// Typography
// =============================================================================

#set text(
  font: "New Computer Modern",
  size: 11pt,
  lang: "en",
)

#set par(
  justify: true,
  leading: 0.65em,
  first-line-indent: 1.5em,
  spacing: 0.65em,
)

// Headings: numbered, with extra space above
#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(1.5em)
  set text(size: 18pt, weight: "bold")
  block(it)
  v(0.8em)
}

#show heading.where(level: 2): it => {
  v(1em)
  set text(size: 13pt, weight: "bold")
  block(it)
  v(0.3em)
}

#show heading.where(level: 3): it => {
  v(0.6em)
  set text(size: 11pt, weight: "bold", style: "italic")
  block(it.body)
}

// Block quotes
#show quote.where(block: true): set block(
  inset: (left: 2em, right: 2em, top: 0.5em, bottom: 0.5em),
  spacing: 1em,
)
#show quote.where(block: true): set text(size: 10pt)

// Footnotes: smaller
#show footnote.entry: set text(size: 9pt)

// Links: subtle color so URLs in the bibliography are recognizable
#show link: set text(fill: rgb("#1a4480"))

// =============================================================================
// Title block
// =============================================================================

#align(center)[
  #v(1.5in)

  #text(size: 11pt, tracking: 2pt)[HISTORICAL RECREATION DOCUMENTATION]

  #v(1.5em)

  #text(size: 22pt, weight: "bold")[
    Push Engraving on Copper Plate
  ]

  #v(0.4em)

  #text(size: 18pt, style: "italic")[
    The Conversion on the Way to Damascus
  ]

  #v(2em)

  #text(size: 11pt)[
    Period-Accurate Materials, Tools, Techniques, Process, and Sources \
    For Presentation at Historical Reenactment Events
  ]

  #v(3em)

  #text(size: 11pt)[
    Prepared April 2026
  ]
]

#pagebreak()

// =============================================================================
// Table of contents
// =============================================================================

#{
  show outline.entry.where(level: 1): set text(weight: "bold")
  outline(title: [Contents], indent: auto, depth: 2)
}

#pagebreak()

// Switch to numbered pages, restart counter at 1 for the body
#set page(numbering: "1")
#counter(page).update(1)

// =============================================================================
// Body sections
// =============================================================================

#include "sections/01-scope.typ"
#include "sections/02-materials.typ"
#include "sections/03-methods.typ"
#include "sections/04-research.typ"
#include "sections/05-execution.typ"

// =============================================================================
// Bibliography
// =============================================================================

#pagebreak()

#bibliography(
  "refs.yml",
  title: "Bibliography",
  style: "chicago-author-date",
  full: true,
)
