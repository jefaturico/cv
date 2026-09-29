// ===========================================================================
// CV
// Your name, photo, contacts and colours are in details.typ.
//
// Build the PDF:
//   typst compile --font-path fonts --ignore-system-fonts \
//     emilio-hurtado_cv-english.typ
// ===========================================================================

#import "template.typ": *
#import "details.typ": details

// ---------------------------------------------------------------------------
// Introduction, in the header next to your photo. Wrap words in #hl[…] to
// highlight them. A ~ is a space that never breaks the line.
// ---------------------------------------------------------------------------

#show: cv.with(details, bio: [
  Only #hl[28.7%] of the seafloor has been mapped to modern standards, yet
  everything we build at sea starts with understanding what's beneath it. I'm~a
  diver and Marine Sciences student with #hl[field experience in coastal survey
  and sampling, and data processing in Python and GIS]. I'm~set~on~hydrography
  because I believe #hl[every project at sea is only as good
  as~the~survey~behind~it].
])

// ---------------------------------------------------------------------------
// Three cards under the header. *Stars* make text bold.
// ---------------------------------------------------------------------------

#highlights(
  (
    title: "Data acquisition and analysis",
    body: [I collect my own data *in~the~field*, then process and analyze it
      in *Python~and~GIS*.],
  ),
  (
    title: "Environmental background",
    body: [I minored in *coastal~sustainability* and spent a summer running
      a *wastewater~lab's* routine analyses.],
  ),
  (
    title: "Hackathon winner",
    body: [Won the 2025 Efiaqua Hackathon in Valencia as a *2-person~team*,
      out of *225~participants*.],
  ),
)

// ---------------------------------------------------------------------------
// The two columns below the cards. They stretch to fill the page.
//
//   #section("Title")[ entries ]            a heading with a timeline
//   #entry(date: …, title: …, meta: …)[ description ]
//       a date on two lines: [2026 \ May–Jul]; the description can be a
//       paragraph or a list of "- " lines
//
//   #side-section("Title")[ items ]         a heading in the right column
//   #side-item("Title", sub: "grey line below")
//   #level-row("Name", level: "grey text on the right")
//   #tags("a", "b", …)
// ---------------------------------------------------------------------------

#body-columns(
  // ===== LEFT COLUMN =====
  [
    #section("Academic projects")[
      #entry(
        date: "2025",
        title: "Oceanographic Characterization of the Calpe Coast",
        meta: "Field campaign · UCV · Calpe, Spain",
      )[
        - Planned and executed a multi-instrument coastal survey; deployed CTD,
          multiparameter probe, Niskin bottles and Van Veen grab.
        - Designed side-scan sonar survey lines, acquired the data, and used the
          imagery to document burial of _Posidonia oceanica_ meadows by sand.
        - Responsible for the physical oceanography component: processed CTD,
          sea-level, chlorophyll and turbidity data in Python (NumPy, pandas,
          Matplotlib, GSW) to assess Calpe's suitability as a smart coastal city.
      ]

      #entry(
        date: "2025",
        title: "Sediment-Sampling Survey Design in the Weddell Sea",
        meta: "Desk study · UCV",
      )[
        - Selected a study area and designed a sediment-sampling grid in QGIS
          based on geological and physical-oceanographic conditions.
      ]

      #entry(
        date: "2024",
        title: "Seafloor Geomorphology Mapping in the Alboran Sea",
        meta: "Desk study · UCV",
      )[
        - Mapped and interpreted subsea geological structures from public
          bathymetric datasets in QGIS.
      ]

      #entry(
        date: "2023",
        title: "GIS Site Selection for a Wastewater Treatment Plant",
        meta: "Desk study · UCV",
      )[
        - Overlaid exclusion layers in ArcGIS (protected land, roads, rivers,
          livestock~routes, rail, towns, steep slopes) to identify a suitable
          site.
      ]
    ]

    #section("Experience", note: "References available upon request")[
      #entry(
        date: [2026 \ May–Jul],
        title: "Laboratory Intern",
        meta: "Ciclagua · EDAR Albufera Sur & EDAR Sueca-Perelló · Valencia, Spain",
      )[
        - Ran the lab's routine analyses (COD, BOD, suspended solids, nutrients)
          on influent and effluent samples; results were used for plant process
          control and regulatory reporting.
      ]

      #entry(
        date: [2024–25 \ Summers],
        title: "PADI Divemaster",
        meta: "Buceo La Herradura · Granada, Spain",
      )[
        - Led guided dives and refresher courses, gave dive and boat
          safety~briefings, and ran equipment checks.
      ]
    ]
  ],

  // ===== RIGHT COLUMN =====
  [
    #side-section("Education")[
      #side-item("BSc in Marine Sciences", sub: [Catholic University of Valencia (UCV)~·~Expected~2027])
      #side-item("Minor in Blue Economy and Growth", sub: "EU-CONEXUS · Expected 2027")
      #side-item("Minor in Coastal Development and Sustainable Maritime Tourism", sub: "EU-CONEXUS · 2026")
      #side-item("International Baccalaureate", sub: [SEK El Castillo, Madrid~·~2021 \ Class representative])
    ]

    #side-section("International mobilities")[
      #side-item("SETU, Ireland", sub: "Surf & Turf Physics · Oct 2026")
      #side-item("Klaipėda University, Lithuania", sub: "LNG in shipping · Oct 2026")
      #side-item("University of Rostock, Germany", sub: "IoT & digital twins, Power BI · May 2026")
      #side-item("La Rochelle University, France", sub: "Entrepreneurship · Mar 2026")
      #side-item("UTCB, Romania", sub: "Pollution & remediation · Oct 2024")
    ]

    #side-section("Languages")[
      #level-row("Spanish", level: "Native")
      #level-row("English", level: "C2 · Cambridge certified")
    ]

    #side-section("Tools")[
      #tags("QGIS", "ArcGIS", "Python", "Git", "Linux")
    ]
  ],
)
