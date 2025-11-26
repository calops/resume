// Resume Template
// Compile with: typst compile resume.typ

#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 1.5cm),
)

#set text(
  font: "Linux Libertine",
  size: 10pt,
)

#set par(justify: true)

// Header styling
#let header(name, tagline) = {
  align(center)[
    #text(size: 24pt, weight: "bold")[#name]
    #v(0.3em)
    #text(size: 12pt, style: "italic")[#tagline]
  ]
}

// Contact info styling
#let contact(..items) = {
  align(center)[
    #items.pos().join(" | ")
  ]
}

// Section styling
#let section(title) = {
  v(0.8em)
  text(size: 12pt, weight: "bold")[#title]
  line(length: 100%, stroke: 0.5pt)
  v(0.3em)
}

// Experience entry styling
#let experience(title, company, location, dates, description) = {
  grid(
    columns: (1fr, auto),
    row-gutter: 0.3em,
    [*#title* at #company], [#dates],
    [#location], [],
  )
  v(0.2em)
  description
  v(0.5em)
}

// Education entry styling
#let education(degree, school, location, dates, details: none) = {
  grid(
    columns: (1fr, auto),
    row-gutter: 0.3em,
    [*#degree*], [#dates],
    [#school, #location], [],
  )
  if details != none {
    v(0.2em)
    details
  }
  v(0.5em)
}

// Skills styling
#let skills(..items) = {
  items.pos().join(" • ")
}

// ==========================================
// Resume Content
// ==========================================

#header(
  "Your Name",
  "Your Title / Tagline",
)

#v(0.5em)

#contact(
  "email@example.com",
  "+1 (555) 123-4567",
  "City, Country",
  "linkedin.com/in/yourprofile",
  "github.com/yourusername",
)

#section("Experience")

#experience(
  "Job Title",
  "Company Name",
  "City, Country",
  "Month Year – Present",
)[
  - Accomplished X by implementing Y, resulting in Z
  - Led a team of N people to deliver project on time
  - Improved system performance by X%
]

#experience(
  "Previous Job Title",
  "Previous Company",
  "City, Country",
  "Month Year – Month Year",
)[
  - Description of key responsibility and achievement
  - Another significant accomplishment
  - Technical skills utilized and impact made
]

#section("Education")

#education(
  "Degree Name",
  "University Name",
  "City, Country",
  "Year – Year",
  details: [
    Relevant coursework, honors, or activities
  ],
)

#section("Skills")

*Technical:* #skills("Skill 1", "Skill 2", "Skill 3", "Skill 4", "Skill 5")

*Languages:* #skills("Language 1 (Native)", "Language 2 (Fluent)", "Language 3 (Basic)")

#section("Projects")

*Project Name* #h(1fr) _Technology Stack_

Brief description of the project, its purpose, and your role. Highlight key achievements or technical challenges overcome.

#v(0.3em)

*Another Project* #h(1fr) _Technology Stack_

Description of another significant project that demonstrates your skills and experience.
