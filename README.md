# Resume

My CV and cover letter, written in [Typst](https://typst.app). I keep them on
GitHub because it's the easiest way to have the current version on whatever
machine I'm using.

**Current CV:** [emilio-hurtado_cv-english.pdf](emilio-hurtado_cv-english.pdf)

If you got here from an application, that PDF is the latest version.

## Building

With Typst installed:

```sh
typst compile --font-path fonts --ignore-system-fonts emilio-hurtado_cv-english.typ
typst compile --font-path fonts --ignore-system-fonts cover-letter-sample.typ
```

Adding `--input colour=all` renders one page per colour scheme, which is how I
compare them.

## What's where

| File | Contents |
| --- | --- |
| `details.typ` | Name, headline, contacts, photo and colour scheme, shared by both documents |
| `emilio-hurtado_cv-english.typ` | The CV |
| `cover-letter-sample.typ` | The cover letter layout, filled with placeholder text. I write the real ones per application and keep them out of the repo |
| `template.typ` | All of the layout and styling |
| `fonts/` | IBM Plex and Font Awesome, bundled so the PDF comes out the same on any machine |
| `linkedin/` | Profile picture and banner in the same style |

## The template

I spent more time on this than a CV strictly needs. A few things that were
worth getting right:

- **One accent colour.** Text, greys, hairlines and the header are all shades
  of the accent's hue, with lightness picked for contrast (AAA for text). Swap
  the accent and the whole page follows.
- **One base size.** Type, spacing and markers are all relative to
  `font-size`, so the page scales as a unit instead of drifting out of
  proportion.
- **Alignment from font metrics.** Timeline nodes, dates, bullets and heading
  markers are positioned from cap heights, not nudged by hand. Squares and card
  edges snap to whole points so they render crisply on screen.
- **Equal-height columns.** The main column and sidebar stretch their gaps to
  end level at the bottom of the page.

If you want to use it for your own CV, go ahead. Put your details in
`details.typ`, replace the content in the CV file, and pick a colour scheme from
`palettes` in `template.typ` (or pass your own accent). Any value in
`default-theme` can be overridden.

## License

The code is licensed under [GPL-3.0](LICENSE). Some files in the repo are not
part of that:

- My photos (`headshot.png` and everything in `linkedin/`) are not licensed
  for reuse. All rights reserved.
- The fonts in `fonts/` are under their own licenses: IBM Plex is under the SIL
  Open Font License, and Font Awesome's terms are in
  `fonts/Font-Awesome-LICENSE.txt`.
