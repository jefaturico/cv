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
  everything we build at sea starts with understanding what's beneath it. I'm a
  diver and Marine Sciences student with #hl[hands-on experience in coastal
  survey, sampling, and GIS]. What I offer is simple: a hunger to learn, the
  stamina for long days of work, and the belief that #hl[every project at sea
  is only as good as~the~survey~behind~it].
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
    body: [I minored in *coastal~sustainability* and spent a summer testing
      *treated~wastewater*.],
  ),
  (
    title: "Hackathon winner",
    body: [*Winning team* at the 2025 Efiaqua Hackathon in Valencia, out of
      *255~participants*.],
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
        - Planned and executed a multi-instrument coastal survey: CTD profiles, current
          measurements, Niskin water sampling, and Van Veen grabs.
        - Mapped _Posidonia oceanica_ meadows with side-scan sonar and integrated
          results with chlorophyll time series and vegetation surveys.
        - Processed and visualized datasets in Python (NumPy, pandas,
          Matplotlib, GSW) to assess Calpe's suitability as a smart coastal city.
      ]

      #entry(
        date: "2025",
        title: "Sediment-Sampling Survey Design in the Weddell Sea",
        meta: "Desk study · UCV",
      )[
        Selected a study area and designed a sediment-sampling grid in QGIS based
        on geological and physical-oceanographic conditions.
      ]

      #entry(
        date: "2024",
        title: "Seafloor Geomorphology Mapping in the Alboran Sea",
        meta: "Desk study · UCV",
      )[
        Mapped and interpreted subsea geological structures from public
        bathymetric datasets in QGIS.
      ]

      #entry(
        date: "2023",
        title: "GIS Site Selection for a Wastewater Treatment Plant",
        meta: "Desk study · UCV",
      )[
        Overlaid exclusion layers in ArcGIS (protected land, roads, rivers,
        livestock routes, rail, towns, steep slopes) to identify a suitable
        site.
      ]
    ]

    #section("Experience", note: "References available upon request")[
      #entry(
        date: [2026 \ May–Jul],
        title: "Laboratory Intern",
        meta: "Ciclagua · EDAR Albufera Sur & EDAR Sueca-Perelló · Valencia, Spain",
      )[
        Sampled influent and effluent water and analyzed its quality to support
        treatment-process control and regulatory reporting.
      ]

      #entry(
        date: [2024–25 \ Summers],
        title: "PADI Divemaster",
        meta: "Buceo La Herradura · Granada, Spain",
      )[
        Led and supervised guided dives, conducting briefings, equipment checks,
        and boat-based safety procedures.
      ]
    ]
  ],

  // ===== RIGHT COLUMN =====
  [
    #side-section("Education")[
      #side-item("BSc Marine Sciences", sub: [Catholic University of Valencia (UCV)~·~Expected~2027])
      #side-item("Minor in Blue Economy and Growth", sub: "EU-CONEXUS · Expected 2027")
      #side-item("Minor in Coastal Development and Sustainable Maritime Tourism", sub: "EU-CONEXUS · 2026")
    ]

    #side-section("International mobilities")[
      #side-item("SETU, Ireland", sub: "Surf & Turf Physics hub · Oct 2026")
      #side-item("Klaipėda University, Lithuania", sub: "LNG in shipping · Oct 2026")
      #side-item("University of Rostock, Germany", sub: "IoT & digital twins, Power BI · May 2026")
      #side-item("La Rochelle University, France", sub: "Startup project · Mar 2026")
      #side-item("UTCB, Romania", sub: "Pollution & remediation · Oct 2024")
    ]

    #side-section("Languages")[
      #level-row("Spanish", level: "Native")
      #level-row("English", level: "C2 · Cambridge certified")
    ]

    #side-section("Tools")[
      #tags("CTD", "Side-scan sonar", "Niskin bottle", "Van Veen grab",
        "QGIS", "ArcGIS", "Python", "NumPy", "pandas", "Matplotlib", "GSW", "Git", "Shell", "Linux/Unix")
    ]
  ],
)
