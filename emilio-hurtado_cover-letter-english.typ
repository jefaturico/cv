// ===========================================================================
// COVER LETTER
// Your name, photo, contacts and colours are in details.typ.
//
// Build the PDF:
//   typst compile --font-path fonts --ignore-system-fonts \
//     emilio-hurtado_cover-letter-english.typ
// ===========================================================================

#import "template.typ": *
#import "details.typ": details

#show: cover-letter.with(
  details,

  // Who you are writing to. Remove the address lines you don't need.
  to: (
    name: "Jane Doe",
    address: (
      "Survey Manager",
      "Company Name",
      "Street 1, 1000 City",
      "Country",
    ),
  ),

  // The heading above the letter
  subject: "Application: thesis internship in hydrographic survey",

  // Shown as "Madrid, 28 September 2026". The date is today's unless you
  // write one, e.g.  date: "1 October 2026",
  place: "Madrid",

  salutation: "Dear Ms Doe,",
  closing: "Kind regards,",
)

// ===========================================================================
// THE LETTER
// Write it below. Leave an empty line between paragraphs.
// ===========================================================================

Dear [Name / Hiring Team],

I am writing to ask about the possibility of joining [Company] for my final-year internship in 2027. I study Marine Sciences at the Catholic University of Valencia, and during my degree I have increasingly steered my work towards hydrography and the more technical side of marine science. I already have experience collecting and processing marine data, working with Python and GIS, and working at sea as a PADI Divemaster. I am now looking for the chance to put that experience to work on professional projects and keep building from there.

[COMPANY-SPECIFIC: 1–2 sentences on what the company actually does and why it makes sense for me to contact them.]

The internship is a 300-hour curricular placement, equivalent to roughly eight weeks full-time, and I am available at any point between February and September 2027. I am equally interested in field and offshore work and in data processing or spatial analysis. I am not looking for a particular job title; what matters to me is doing technical work that develops skills I will use in hydrography.

If possible, I would also like to develop my bachelor's thesis around the internship. Working with a real technical problem or dataset would allow me to produce a thesis directly related to the career I am building towards. After graduating, I intend to continue into the MSc in Geodesy and Geoinformatics, specialising in Hydrography, at HafenCity University Hamburg.

I take learning seriously. When I decide to get good at something, I tend to question how I am doing it, find what I could improve, and repeat the process. I would bring the same approach to the work I am given at [Company].

I have attached my CV and would be glad to discuss whether there might be a place for me on your team.