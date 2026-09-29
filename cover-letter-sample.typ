// ===========================================================================
// COVER LETTER (sample)
// A placeholder letter that shows the layout. My real letters are written per
// application and kept out of the repo.
//
// Build the PDF:
//   typst compile --font-path fonts --ignore-system-fonts cover-letter-sample.typ
// ===========================================================================

#import "template.typ": *
#import "details.typ": details

#show: cover-letter.with(
  details,

  // Who you are writing to. Remove the address lines you don't need.
  to: (
    name: "Hiring Manager",
    address: (
      "Company Name",
      "Street 1, 1000 City",
      "Country",
    ),
  ),

  // The heading above the letter
  subject: "Application: role title",

  // Shown as "Madrid, 1 October 2026". The date is today's unless you
  // write one, e.g.  date: "1 October 2026",
  place: "Madrid",

  salutation: "Dear Hiring Manager,",
  closing: "Kind regards,",
)

// ===========================================================================
// THE LETTER
// Write it below. Leave an empty line between paragraphs.
// ===========================================================================

#lorem(70)

#lorem(55)

#lorem(60)

#lorem(35)
