// CV and cover letter template. All styling lives here; the documents only
// hold content.
//
// Every size, colour and length that more than one component depends on is a
// theme key, so changing it in one place keeps everything else in step.
// Alignments (timeline nodes, dates, markers) are computed from font metrics
// rather than nudged by hand.
//
// Documents (see the end of this file):
//
//   #show: cv.with(details, [bio: […]])
//   #show: cover-letter.with(details, [to: …], [subject: …], [place: …],
//            [date: …], [salutation: …], [closing: …], [signature: …])
//
//   `details` is the dictionary in details.typ: name, headline, contacts,
//   photo, colour, language. Both draw the same header from it.
//
// Building blocks for the CV page (optional arguments in brackets):
//
//   #hl[…]                                     highlighted words in the bio
//
//   #highlights((title: …, body: […]), …)       any number of cards
//
//   #body-columns([ main column ], [ sidebar ]) columns are stretched to equal height
//
//   Main column:
//     #section(title, [note: …])[ entries ]
//     #entry(title: …, [date: …], [meta: …])[ [description] ]
//         date may have two lines: [2026 \ May–Jul]
//
//   Sidebar:
//     #side-section(label)[ any of the below, or plain text ]
//     #side-item(title, [sub: …])
//     #tags("a", "b", …)
//     #level-row(name, [level: …])
//
// Lower-level pieces, for building other layouts: #header(…), #letter(…).

// ---------------------------------------------------------------------------
// Theme
// ---------------------------------------------------------------------------

#let default-theme = (
  // The palette: one accent colour (plus white) drives the whole page. Text,
  // secondary text, hairlines and the header are all shades of the accent's
  // hue, derived in `_derive`; change the accent and everything follows.
  accent: rgb("#2b568b"),      // headings, markers; its dark shade is the header
  white: rgb("#ffffff"),       // page, name
  // strokes
  pill-stroke: 0.5pt,
  line-stroke: 0.8pt,          // hairlines: timeline, card borders
  // fonts (bundled in fonts/)
  sans: "IBM Plex Sans",
  mono: "IBM Plex Mono",
  // IBM Plex registers some weights as separate families; map them here.
  sans-weights: (medium: "IBM Plex Sans Medm", semibold: "IBM Plex Sans SmBld"),
  mono-weights: (medium: "IBM Plex Mono Medm"),
  // Type scale: a few fixed steps. Every text role is assigned one step in
  // `_derive`.
  type-scale: (
    xs: 7.5pt,     // mono dates
    s: 8pt,        // secondary: meta lines, subtitles, tags, pills, headline
    m: 8.5pt,      // body text, card text
    l: 9pt,        // item titles: entries, cards, sidebar items, languages
    xl: 9.5pt,     // header bio, sidebar headings, letter
    xxl: 11pt,     // main section headings
    display: 31pt, // name
  ),
  // geometry
  paper: "a4",
  margin-x: 40pt,
  margin-top: 34pt,
  margin-bottom: 26pt,
  header-height: 216pt,        // minimum header height; it grows to fit its content
  header-pad: 28pt,            // minimum space above and below the header content
  header-photo-gap: 35pt,      // text column ends this far left of the sidebar
  photo-dx: 0pt,               // photo's shift from the centre of its area (negative: left)
  header-gap: 14pt,            // equal vertical space between headline, name, bio and pills
  bio-weight: "light",         // header bio; "regular" reads better on vivid backgrounds
  pill-gap: 4.5pt,             // space between pills/tags, horizontally and vertically
  card-gap: 11pt,
  column-gap: 15pt,            // space between the main column and the sidebar
  section-gap: 20pt,           // minimum space between main-column sections
  entry-gap: 11pt,             // minimum space before each entry
  side-section-gap: 20pt,      // minimum space between sidebar sections
  card-inset: 11pt,            // padding on all four sides of a highlight card
  cards-spacing: 18pt,         // space above and below the row of cards
  date-width: 50pt,            // indent of entry content: date, gap, node, gap
  node-size: 5pt,              // timeline node (whole points render crisply)
  rail-gap: 6.25pt,            // space on each side of the node (date | node | title)
)

// A shade of `base`: same hue, OKLCH lightness `l`, and `ratio` times base's
// chroma (colourfulness). Scaling the chroma keeps every shade in proportion to
// the accent: a greyish accent gives greyish shades, a vivid one vivid shades.
// Unlike RGB lighten/darken, this doesn't drift in hue.
// `max` caps the chroma, so neutrals (text, hairlines) stay neutral even with
// a very vivid accent.
#let _shade(base, l, ratio, max: none) = {
  let (_, c, hue, ..) = oklch(base).components()
  let c = ratio * c
  if max != none { c = calc.min(c, max) }
  rgb(oklch(l, c, hue)) // plain sRGB in the PDF: predictable in every viewer and printer
}

// Text sizes (one step of the type scale per role) and role colours, all
// shades of the accent or white. Lightness is chosen for contrast (WCAG)
// against the background each role sits on:
//   on white: ink 15.9:1, muted 7.1:1, accent 7.5:1 (all AAA)
//   on the header: name 15.1:1, bio 11.2:1, headline 8.6:1 (AAA),
//   pill outline 3.8:1 · hairlines 1.9:1 on white (decorative)
// Any role can be overridden through the theme (e.g. `ink: black`).
#let _derive(t) = {
  let z = t.type-scale
  t.sizes = (
    body: z.m, card-body: z.m, bio: z.xl,
    date: z.xs, meta: z.s, section-note: z.s, side-sub: z.s, tag: z.s, pill: z.s, headline: z.s,
    entry-title: z.l, card-title: z.l, side-title: z.l,
    side-heading: z.xl, section: z.xxl, name: z.display,
    letter: z.xl,
  )
  let a = t.accent
  (
    ink: _shade(a, 25%, 0.19, max: 0.02),   // near-black text
    muted: _shade(a, 46%, 0.2, max: 0.02),  // grey: meta lines, dates
    line: _shade(a, 80%, 0.12, max: 0.012), // hairlines: timeline, borders, tags
    header-bg: _shade(a, 27%, 0.64),
    header-accent: _shade(a, 82%, 0.5),
    header-line: _shade(a, 60%, 0.75),
    header-ink: t.white,
    header-soft: _shade(a, 90%, 0.14),
  ) + t
}

#let theme-state = state("cv-theme", _derive(default-theme))

// Run `f` with the current theme dictionary.
#let with-theme(f) = context f(theme-state.get())

// Text arguments for a font weight, picking the separate family when the
// theme maps that weight to one (see `sans-weights`).
#let _font(t, weight, mono: false) = {
  let family = if mono { t.mono } else { t.sans }
  let map = if mono { t.mono-weights } else { t.sans-weights }
  (font: map.at(weight, default: family), weight: weight)
}

// Height of a capital letter in the given text style — what the default
// `top-edge: "cap-height"` puts at the top of a line.
#let _cap(style) = measure(style("H")).height

// A length rounded to whole points.
#let _whole(v) = calc.round(v.pt()) * 1pt

// Offset that moves absolute position `v` onto the nearest whole point.
#let _snap(v) = _whole(v) - v

// A solid square marker, `size` rounded to whole points and its corner
// snapped to whole points on the page. Squares at fractional positions get
// anti-aliased edges on screen, so each would look slightly differently soft;
// snapped, they all render alike. Used inline, where a box is `size` × `size`.
#let _square(size, fill) = {
  let size = _whole(size)
  box(width: size, height: size, context {
    let p = here().position()
    place(top + left, dx: _snap(p.x), dy: _snap(p.y), rect(width: size, height: size, fill: fill))
  })
}

// A `width` × `height` box whose outline is drawn with its corner snapped to
// whole points, so every outlined box (cards, tags, pills) sits on the pixel
// grid the same way. Keep `width` and `height` whole points too.
#let _frame(width, height, stroke, body) = box(width: width, height: height, {
  context {
    let p = here().position()
    place(top + left, dx: _snap(p.x), dy: _snap(p.y), rect(width: width, height: height, stroke: stroke))
  }
  body
})

// An inline outlined label: about `inset` around `body`, rounded to whole points.
#let _label(body, inset, stroke) = context {
  let size = measure(body)
  let w = _whole(size.width + 2 * inset)
  let h = calc.floor((size.height + 2 * inset).pt()) * 1pt
  _frame(w, h, stroke, align(center + horizon, body))
}

// Left edges and widths of the highlight cards: whole points, the row spanning
// the page margins (the last card absorbs the rounding).
#let _card-columns(t, n, page-width) = {
  let inner = page-width - 2 * t.margin-x
  let w = calc.floor(((inner - (n - 1) * t.card-gap) / n).pt()) * 1pt
  let xs = range(n).map(i => t.margin-x + i * (w + t.card-gap))
  let last = _whole(t.margin-x + inner) - xs.at(-1)
  (xs, range(n).map(i => if i == n - 1 { last } else { w }))
}

// The main column and the sidebar, on the grid of three highlight cards: the
// sidebar (and the header photo) starts where the last card starts, the main
// column spans the other cards less the column gap.
#let _body-columns(t, page-width) = {
  let (xs, widths) = _card-columns(t, 3, page-width)
  (main-width: xs.at(-1) - t.margin-x - t.column-gap, side-x: xs.at(-1), side-width: widths.at(-1))
}

// Section heading in semibold. Sidebar headings are plain accent-coloured
// text. Main headings (`marker: true`) are ink-coloured and lead with an
// accent square on the page margin, vertically centred on their capitals; the
// text then starts at `card-inset` from the margin, in line with the text
// inside the highlight cards above.
#let _heading(t, size, title, marker: false) = {
  if not marker { return text(size: size, .._font(t, "semibold"), fill: t.accent, title) }
  let title-text(it) = text(size: size, .._font(t, "semibold"), fill: t.ink, it)
  let m = _whole(0.5625 * size)
  box(baseline: -(_cap(title-text) - m) / 2, _square(m, t.accent))
  h(t.card-inset - m)
  title-text(title)
}

// Lay pills out in wrapping rows with the same `gap` between neighbours and
// between rows. A pill is an inline box whose inset counts towards its size,
// so the line box is exactly the pill and `leading` is the row gap. Between
// pills: weak spacing (dropped at a line end) plus a zero-width break point.
#let _pill-flow(pills, gap) = {
  set par(leading: gap, justify: false)
  block(pills.join(h(gap, weak: true) + sym.zws))
}

// ---------------------------------------------------------------------------
// Document setup
// ---------------------------------------------------------------------------

#let _document(theme: (:), title: "", author: "", lang: "en", body) = {
  let t = _derive(default-theme + theme)
  set document(title: title, author: author)
  set page(
    paper: t.paper,
    margin: (x: t.margin-x, top: t.margin-top, bottom: t.margin-bottom),
    fill: t.white,
  )
  set text(font: t.sans, size: t.sizes.body, fill: t.ink, lang: lang)
  set par(leading: 0.657em, spacing: 0.8em)
  // square bullet about a third of an em, centred on the x-height
  set list(indent: 1pt, body-indent: 6.5pt, spacing: 7.7pt, marker: context {
    let m = _whole(0.313 * text.size)
    box(baseline: -(0.35em - m / 2), _square(m, t.ink))
  })
  theme-state.update(t)
  body
}

// ---------------------------------------------------------------------------
// Header
// ---------------------------------------------------------------------------

// Highlighted words inside the header bio: brighter and heavier than the bio
// text.
#let hl(body) = with-theme(t => text(fill: t.header-ink, .._font(t, "medium"), body))

// A contact written as plain text, linked when it is an email or a web
// address. Anything else (a phone number, or content) is shown as is.
#let _autolink(it) = {
  if type(it) != str { return it }
  if it.contains(regex("^[^\s@]+@[^\s@]+\.[^\s@]+$")) { return link("mailto:" + it, it) }
  if it.starts-with(regex("https?://")) { return link(it, it.trim(regex("https?://"), at: start)) }
  if it.starts-with("www.") { return link("https://" + it, it) }
  it
}

// Must be the first thing on the page: the band and photo bleed to the page
// edges by offsetting from the top-left corner of the content area.
#let header(
  photo: none,     // file name ("headshot.png") or an image(…)
  headline: none,
  name: "",
  bio: none,       // one or more paragraphs (separate them with a blank line)
  contacts: (),    // text in outlined pills; emails and web addresses become links
) = with-theme(t => {
  let pill(body) = {
    set text(size: t.sizes.pill, fill: t.header-ink)
    _label(_autolink(body), 0.53 * t.sizes.pill, t.pill-stroke + t.header-line)
  }
  let photo = if type(photo) == str { image(photo) } else { photo }

  // The text spans from the page margin to the sidebar's left edge, less a gap.
  let split-x = _body-columns(t, page.width).side-x
  let column-width = split-x - t.margin-x - t.header-photo-gap
  let headline-text = if headline != none {
    text(size: t.sizes.headline, .._font(t, "medium", mono: true), fill: t.header-accent, tracking: 0.95pt, upper(headline))
  }
  let name-text = text(size: t.sizes.name, .._font(t, "semibold"), fill: t.header-ink, tracking: -0.6pt, name)
  let pills = contacts.map(pill)
  let content = box(width: column-width, {
    set block(spacing: 0pt)
    set par(spacing: 0pt)
    if headline != none { block(below: t.header-gap, headline-text) }
    block(below: t.header-gap, name-text)
    if bio != none {
      set par(leading: 0.74em, spacing: t.header-gap)
      block(below: t.header-gap, text(size: t.sizes.bio, weight: t.bio-weight, fill: t.header-soft, bio))
    }
    _pill-flow(pills, t.pill-gap)
  })
  // Where the text ends: a bio fills the column, otherwise the widest line.
  let text-width = if bio != none { column-width } else {
    calc.min(column-width, calc.max(
      measure(headline-text).width,
      measure(name-text).width,
      measure(pills.join(h(t.pill-gap))).width,
    ))
  }
  // As tall as the minimum or the content plus padding, whichever is larger.
  let height = calc.max(t.header-height, measure(content).height + 2 * t.header-pad)

  // Anything placed relative to the page's top-left corner.
  let bleed(body) = place(top + left, dx: -t.margin-x, dy: -t.margin-top, body)

  bleed(rect(width: page.width, height: height, fill: t.header-bg))
  if photo != none {
    // A cut-out on a transparent background, as tall as the header and
    // centred between the end of the text and the page edge, then shifted by
    // `photo-dx`.
    let text-edge = t.margin-x + text-width
    let natural = measure(photo)
    let width = natural.width * (height / natural.height)
    let x = text-edge + (page.width - text-edge - width) / 2 + t.photo-dx
    bleed(place(dx: x, { set image(width: width, height: height); photo }))
  }

  // Reserve the header's space in the flow, then centre the content on the
  // full header height (the page's top margin sits above this block).
  block(height: height - t.margin-top, width: 100%, place(top + left, dy: -t.margin-top,
    block(width: 100%, height: height, align(left + horizon, content)),
  ))
  // marks the header's bottom edge, for `letter`
  [#metadata(height) <cv-header-end>]
})

// ---------------------------------------------------------------------------
// Highlight cards
// ---------------------------------------------------------------------------

// A row of outlined cards; all cards take the height of the tallest one.
#let highlights(..cards) = with-theme(t => {
  let cards = cards.pos()
  let body(c, w) = block(width: w, inset: t.card-inset, {
    text(size: t.sizes.card-title, .._font(t, "semibold"), fill: t.accent, c.title)
    v(2.3pt)
    set par(leading: 0.66em)
    text(size: t.sizes.card-body, c.body)
  })
  block(above: t.cards-spacing, below: t.cards-spacing, {
    let (_, widths) = _card-columns(t, cards.len(), page.width)
    let cards = cards.zip(widths)
    // all cards as tall as the tallest, in whole points
    let tallest = calc.ceil(calc.max(..cards.map(((c, w)) => measure(body(c, w)).height)).pt()) * 1pt
    grid(
      columns: widths,
      column-gutter: t.card-gap,
      ..cards.map(((c, w)) => _frame(w, tallest, t.line-stroke + t.line, body(c, w))),
    )
  })
})

// ---------------------------------------------------------------------------
// Two-column body
// ---------------------------------------------------------------------------

// Flexible gap: a fixed minimum plus an equal share (1fr) of whatever room is
// left in the column. Inside a fixed-height column the shares fill it exactly;
// anywhere else a fraction resolves to nothing and only the minimum remains.
#let _gap(min) = { v(min); v(1fr) }

// Is this the first section of its column? True when no section of the same
// kind (identified by its end marker) lies between the column's start marker
// and here, in document order.
#let _first-in-column(end-label) = {
  let start = query(selector(<cv-column>).before(here())).at(-1, default: none)
  if start == none { return true }
  query(selector(end-label).after(start.location()).before(here())).len() == 0
}

// Marks the start of a column, for `_first-in-column`.
#let _column(body) = { [#metadata(none) <cv-column>]; body }

// Main and side columns. Both are stretched to the bottom margin by growing
// their flexible gaps, so they always end level with each other. If either
// column is too tall to fit, the stretching is skipped and content flows on.
#let body-columns(main, side) = with-theme(t => {
  let avail = page.height - t.margin-bottom - here().position().y
  let (main-width, side-width, ..) = _body-columns(t, page.width)
  let natural = calc.max(
    measure(block(width: main-width, _column(main))).height,
    measure(block(width: side-width, _column(side))).height,
  )
  let height = if natural <= avail { avail } else { auto }
  grid(
    columns: (main-width, side-width),
    column-gutter: t.column-gap,
    block(height: height, _column(main)),
    block(height: height, _column(side)),
  )
})

// ---------------------------------------------------------------------------
// Main column
// ---------------------------------------------------------------------------

// A main-column section. `note` is an optional italic subtitle under the title.
#let section(title, note: none, body) = with-theme(t => {
  if not _first-in-column(<cv-section-end>) { _gap(t.section-gap) }
  block(above: 0pt, below: 0pt, _heading(t, t.sizes.section, title, marker: true))
  if note != none {
    v(10.8pt)
    // aligned with the heading text, not the square
    block(above: 0pt, below: 0pt, pad(left: t.card-inset, text(size: t.sizes.section-note, style: "italic", fill: t.muted, note)))
  }
  body // entries bring their own (flexible) leading gap
  // the end marker tells the timeline where this section stops
  [#metadata(none) <cv-section-end>]
})

// Is position `a` earlier in the document than position `b`?
#let _before(a, b) = a.page < b.page or (a.page == b.page and a.y < b.y)

// Timeline rail: a node beside each entry title, joined by a line to the next
// entry of the same section (only when both are on the same page). The line
// length comes from the entries' real positions, so it always meets the next
// node exactly.
#let _timeline(t, node-y) = context {
  let here-pos = here().position()
  let next = query(selector(<cv-entry>).after(here(), inclusive: false)).at(0, default: none)
  let end = query(selector(<cv-section-end>).after(here())).at(0, default: none)
  let node = t.node-size
  // node corner, snapped to whole points (see `_square`); the rail runs
  // through the node's centre
  let nx = t.date-width - t.rail-gap - node
  let ny = node-y - node / 2
  nx += _snap(here-pos.x + nx)
  ny += _snap(here-pos.y + ny)
  let x = nx + node / 2
  if next != none {
    let next-pos = next.location().position()
    let same-section = end == none or _before(next-pos, end.location().position())
    if same-section and next-pos.page == here-pos.page {
      place(top + left, dx: x, dy: ny + node / 2, line(
        angle: 90deg,
        length: next-pos.y - here-pos.y,
        stroke: t.line-stroke + t.line,
      ))
    }
  }
  place(top + left, dx: nx, dy: ny, rect(width: node, height: node, fill: t.accent))
}

// A timeline entry. Everything but the title is optional; the description
// goes in a trailing content block: #entry(date: "2025", title: "…")[…]
#let entry(date: none, title: "", meta: none, ..body) = with-theme(t => {
  let body = body.pos().at(0, default: none)
  _gap(t.entry-gap)
  block(above: 0pt, below: 0pt, {
    let title-text(it) = text(size: t.sizes.entry-title, .._font(t, "semibold"), it)
    let date-text(it) = text(font: t.mono, size: t.sizes.date, fill: t.muted, it)
    let meta-text(it) = text(size: t.sizes.meta, fill: t.muted, it)
    let meta-gap = 8.3pt // title baseline → meta cap top
    // The node, the date and the title's first line share one centre line: half
    // the title's cap height. The date is shifted so its own cap centre lands there.
    let node-y = _cap(title-text) / 2
    let date-dy = node-y - _cap(date-text) / 2
    // A second date line (e.g. [2026 \ May–Jul]) shares its baseline with the
    // meta line: pick the leading that puts it exactly there.
    let date-leading = if meta != none {
      _cap(title-text) + meta-gap + _cap(meta-text) - date-dy - 2 * _cap(date-text)
    } else { par.leading }
    [#metadata(none) <cv-entry>]
    _timeline(t, node-y)
    // date (right-aligned) | gap · node · gap | content — the node sits exactly
    // between the end of the date and the start of the title
    let rail-width = t.node-size + 2 * t.rail-gap
    grid(
      columns: (t.date-width - rail-width, rail-width, 1fr),
      align(right, pad(top: date-dy, if date != none { set par(leading: date-leading); date-text(date) })),
      none,
      {
        title-text(title)
        if meta != none { block(above: meta-gap, meta-text(meta)) }
        if body != none { block(above: 8.2pt, body) }
      },
    )
  })
})

// ---------------------------------------------------------------------------
// Sidebar
// ---------------------------------------------------------------------------

#let side-section(label, body) = with-theme(t => {
  if not _first-in-column(<cv-side-end>) { _gap(t.side-section-gap) }
  block(above: 0pt, below: 11pt, _heading(t, t.sizes.side-heading, label))
  block(below: 0pt, body)
  [#metadata(none) <cv-side-end>]
})

// A sidebar item: semibold title, optional grey `sub` line below.
#let side-item(title, sub: none) = with-theme(t => block(below: if sub == none { 10.9pt } else { 12.6pt }, {
  text(size: t.sizes.side-title, .._font(t, "semibold"), title)
  if sub != none {
    block(above: 6.9pt, text(size: t.sizes.side-sub, fill: t.muted, sub))
  }
}))

// Square tags outlined with the hairline.
#let tags(..items) = with-theme(t => {
  let tag(it) = _label(it, 0.53 * t.sizes.tag, t.line-stroke + t.line)
  set text(size: t.sizes.tag)
  _pill-flow(items.pos().map(tag), t.pill-gap)
})

#let level-row(name, level: none) = with-theme(t => block(below: 10.9pt, grid(
  columns: (1fr, auto),
  text(size: t.sizes.side-title, .._font(t, "semibold"), name),
  if level != none { text(size: t.sizes.side-title, fill: t.muted, level) },
)))

// ---------------------------------------------------------------------------
// Palettes
// ---------------------------------------------------------------------------

// Colour versions of the CV and letter. Each one is a theme override passed to
// `cv`: usually just the accent, since every other colour is derived from it
// (see `_derive`). Any derived role can be pinned too, e.g. (accent: …,
// header-bg: …).
//
// For readable headings and card titles, keep the accent's contrast on white
// at 4.5:1 or more (7:1 is ideal). Contrast of each accent is noted below.

#let palettes = (
  slate: (accent: rgb("#475569")), // 7.6:1
  kelp: (accent: rgb("#2f6b4f")),  // 6.3:1
  burgundy: (accent: rgb("#8c2a43")), // 8.3:1
  // Fugro: its logo navy (#041e41) is too dark for headings, so it is the
  // header and a mid blue of the same hue is the accent.
  fugro: (accent: rgb("#26528e"), header-bg: rgb("#041e41")), // 7.8:1
  // GEOxyz: logo red (#e11f22) as the header and accent, as on their website.
  // Pure white text (softer tints would fall below 4.5:1 on this red), pill
  // outlines in white at 70% over the red, and a regular-weight bio.
  geoxyz: (accent: rgb("#e11f22"), header-bg: rgb("#e11f22"),
    header-ink: white, header-soft: white, header-accent: white, header-line: rgb("#f6bcbd"),
    bio-weight: "regular"), // 4.75:1
)

// ---------------------------------------------------------------------------
// Cover letter
// ---------------------------------------------------------------------------

// A cover letter on the CV's grid, after a `header` without a bio: the subject
// is a main-column heading over the text, the recipient and date are sidebar
// sections. The whole letter is centred vertically in the white space between
// the header and the bottom of the page.
#let letter(
  recipient: none,             // e.g. a #side-item with the name, company and address
  date: auto,                  // auto is today; a datetime, or text as written
  place: none,                 // where you write from, before the date
  subject: none,
  salutation: [Dear Hiring Manager,],
  closing: [Kind regards,],
  signature: none,             // your name under the closing
  body,
) = with-theme(t => {
  let (main-width, side-width, ..) = _body-columns(t, page.width)
  let letter = grid(
    columns: (main-width, side-width),
    column-gutter: t.column-gap,
    _column({
      if subject != none {
        block(above: 0pt, below: t.entry-gap + 4pt, _heading(t, t.sizes.section, subject, marker: true))
      }
      // the text starts in line with the heading text, not the square
      pad(left: t.card-inset, {
        set text(size: t.sizes.letter)
        set par(leading: 0.75em, spacing: 1.15em, justify: true)
        salutation
        parbreak()
        body
        block(above: 1.6em, closing)
        if signature != none {
          block(above: 0.8em, text(.._font(t, "semibold"), signature))
        }
      })
    }),
    {
      let side = _column({
        if recipient != none { side-section("To", recipient) }
        side-section("Date", block(below: 10.9pt, text(size: t.sizes.side-title, {
          if place != none [#place, ]
          let date = if date == auto { datetime.today() } else { date }
          if type(date) == datetime { date.display("[day padding:none] [month repr:long] [year]") } else { date }
        })))
      })
      // fixed at its natural height, so the sections' flexible gaps stay at
      // their minimum instead of stretching down the page
      block(height: measure(block(width: side-width, side)).height, side)
    },
  )
  let header = query(selector(<cv-header-end>).before(here())).at(-1)
  let white = page.height - header.value
  let space = (white - measure(letter).height) / 2
  // without room to centre, keep the usual gap below the header
  block(above: calc.max(space, t.cards-spacing), letter)
})

// ---------------------------------------------------------------------------
// Documents
// ---------------------------------------------------------------------------

// Themes to render for `colour`: a palette name from `palettes`, a theme
// dictionary of your own such as (accent: rgb("#2b568b")), or "all" for one
// copy per palette. `--input colour=…` on the command line overrides it.
#let _themes(colour) = {
  let colour = sys.inputs.at("colour", default: colour)
  if type(colour) == dictionary { return (colour,) }
  if colour == "all" { return palettes.values() }
  assert(colour in palettes, message: "unknown colour \"" + colour
    + "\", pick one of: " + palettes.keys().join(", ") + " or all")
  (palettes.at(colour),)
}

// One page (or one per palette) with the header from `details`.
#let _render(details, title, theme: (:), bio: none, body) = {
  for (i, t) in _themes(details.at("colour", default: "slate")).enumerate() {
    if i > 0 { pagebreak() }
    _document(
      theme: t + theme,
      title: title + " " + details.name,
      author: details.name,
      lang: details.at("language", default: "en"),
      {
        header(
          photo: details.at("photo", default: none),
          headline: details.at("headline", default: none),
          name: details.name,
          bio: bio,
          contacts: details.at("contacts", default: ()),
        )
        body
      },
    )
  }
}

// The CV. Use as `#show: cv.with(details, bio: […])`; everything after it
// in the file is the page below the header.
#let cv(details, bio: none, body) = _render(details, "CV", bio: bio, body)

// The cover letter. Use as `#show: cover-letter.with(details, …)`; everything
// after it in the file is the text of the letter.
#let cover-letter(
  details,
  to: none,        // (name: …, address: ("line", "line", …)), or any content
  subject: none,
  place: none,     // where you write from, shown before the date
  date: auto,      // auto is today; or write it out: "1 October 2026"
  salutation: [Dear Hiring Manager,],
  closing: [Kind regards,],
  signature: auto, // auto is your name
  body,
) = {
  let lines(it) = if type(it) == array { it.join(linebreak()) } else { it }
  let recipient = if type(to) == dictionary {
    side-item(to.name, sub: lines(to.at("address", default: none)))
  } else { to }
  // the photo sits exactly centred beside the name
  _render(details, "Cover letter", theme: (photo-dx: 0pt), letter(
    recipient: recipient,
    subject: subject,
    place: place,
    date: date,
    salutation: salutation,
    closing: closing,
    signature: if signature == auto { details.name } else { signature },
    body,
  ))
}
