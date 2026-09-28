# CV and cover letter

A matching CV and cover letter, written in [Typst](https://typst.app).

| File | What to edit there |
| --- | --- |
| `details.typ` | Your name, headline, contacts, photo and colour, shared by both documents |
| `emilio-hurtado_cv-english.typ` | The CV: introduction, cards, projects, experience, sidebar |
| `emilio-hurtado_cover-letter-english.typ` | The letter: recipient, subject, and the text itself at the bottom |
| `template.typ` | The design. You don't need to touch it |

Only change text inside quotes `"…"` or square brackets `[…]`. Lines starting
with `//` are notes and don't show up in the PDF.

## Making the PDFs

**In the browser, no install:** create a project on [typst.app](https://typst.app),
upload everything in this folder (including `fonts/`), open the CV or the letter
and download the PDF.

**On your computer:** install Typst, then run in this folder:

```sh
typst compile --font-path fonts --ignore-system-fonts emilio-hurtado_cv-english.typ
typst compile --font-path fonts --ignore-system-fonts emilio-hurtado_cover-letter-english.typ
```

Add `--input colour=all` to get one page in every colour scheme, to compare them.

## Formatting cheatsheet

| Write | Get |
| --- | --- |
| `*bold*` | **bold** |
| `_italic_` | *italic* |
| `#hl[words]` | highlighted words (only in the CV introduction) |
| `a~b` | a space that never breaks the line |
| `\` at the end of a line | a line break |
| `- item` at the start of a line | a bullet point |
| an empty line | a new paragraph |
| `\#`, `\*`, `\_`, `\@` | the symbol itself |

## Another language or job

Copy the CV or letter file, rename it (e.g. `…_cv-spanish.typ`), and edit the
copy. For a different headline or language, copy `details.typ` too and change the
`#import "details.typ"` line at the top of the copy to the new name.
