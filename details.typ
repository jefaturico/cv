// ===========================================================================
// YOUR DETAILS
// Used by both the CV and the cover letter, so they always match.
// Change the text between the quotes "…".
// ===========================================================================

#let details = (
  name: "Emilio Hurtado",

  // The small line above your name
  headline: "Marine Sciences · Hydrography",

  // Shown in boxes under your name. Add or remove lines as you like;
  // emails and web addresses (www.… or https://…) become clickable. Icons:
  // "email", "phone", "location", "linkedin" or "github". Write linebreak(),
  // to start a new row of boxes.
  contacts: (
    (icon: "email", text: "emilio@hurtadosanchez.com"),
    (icon: "phone", text: "+34 626 495 200"),
    linebreak(),
    (icon: "location", text: "Madrid, Spain"),
    (icon: "linkedin", text: "https://linkedin.com/in/emiliohurtadosanchez"),
    // (icon: "github", text: "https://github.com/jefaturico"),
  ),

  // A photo in this folder, ideally a cut-out on a transparent background
  // (.png). Write `none` (without quotes) for no photo.
  photo: "headshot.png",

  // Colour scheme: "slate", "kelp", "burgundy", "fugro" or "geoxyz"
  colour: "slate",

  // Language code, for hyphenation: "en", "es", "de", "fr", …
  language: "en",
)
