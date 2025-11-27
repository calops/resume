// Resume Template
// Compile with: typst compile resume.typ

#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 1.5cm),
)

#set text(
  font: "Aporetic Sans",
  size: 10pt,
)

#set par(justify: true)

#let accent_color = rgb("#0D6C44")

#let icon(codepoint) = {
  text(font: "Symbols Nerd Font Mono", codepoint, fill: accent_color)
}

// Header styling
#let header(name, tagline, logo_path: none) = {
  if logo_path != none {
    grid(
      columns: (auto, 1fr),
      align: top,
      image(logo_path, height: 4em),
      // Adjust height as needed
      [
        #align(center)[
          #text(size: 24pt, weight: "bold", fill: accent_color)[#name]
          #v(0.3em)
          #text(size: 12pt, style: "italic")[#tagline]
        ]
      ],
    )
  } else {
    align(center)[
      #text(size: 24pt, weight: "bold")[#name]
      #v(0.3em)
      #text(size: 12pt, style: "italic")[#tagline]
    ]
  }
}

// Contact info styling
#let contact(..items) = {
  align(center)[
    #items.pos().join(" | ")
  ]
}

// Section styling
#let section(title) = {
  v(0.4em)
  grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    align: horizon,
    text(size: 12pt, weight: "bold", fill: accent_color)[#title],
    line(length: 100%, stroke: 2pt + accent_color)
  )
  v(0.1em)
}

// Skills styling
#let skills(..items) = {
  items.pos().join(" • ")
}

#let pill(content) = {
  box(
    inset: (x: 0.5em, y: 0.1em),
    radius: 4pt,
    fill: accent_color.lighten(60%),
    text(size: 8pt, content)
  )
}

// Experience entry styling
#let experience(title, company, location, dates, description, skills: none) = {
  let title_company_cell = [#text(weight: "bold")[#title] at #company]
  let dates_cell = [#dates]
  let location_cell = [#location]
  grid(
    columns: (1fr, auto),
    row-gutter: 0.3em,
    title_company_cell, dates_cell,
    location_cell, [],
  )
  v(-0.5em) // Remove space before description
  if description != "" {
    [#description]
  }
  v(0.5em) // Space before skills if description is present
  if skills != none and skills.len() > 0 {
    [
      #skills.map(skill => pill(skill)).join(h(0.5em))
    ]
  }
  v(0.5em)
}

// Education entry styling
#let education(degree, school, location, dates, details: none) = {
  grid(
    columns: (1fr, auto),
    row-gutter: 0.3em,
    [#text(weight: "bold")[#degree]], [#dates],
    [#school, #location], [],
  )
  v(-0.5em) // Remove space before details
  if details != none {
    details
  }
  v(0.5em)
}

// ==========================================
// Resume Content
// ==========================================

#let data = json("resume_data.json")

#header(
  data.header.name,
  data.header.tagline,
  logo_path: data.header.logo_path,
)

#v(0.5em)

#contact(
  [#icon("") #link("mailto:" + data.contact.email, data.contact.email)],
  [#icon("") #link("tel:" + data.contact.phone, data.contact.phone)],
  [#icon("") #data.contact.location],
  [#icon("") #link(data.contact.linkedin.url, data.contact.linkedin.username)],
  [#icon("") #link(data.contact.github.url, data.contact.github.username)],
)

#section("Skills")

*Technical:* #skills(..data.skills.technical)

*Languages:* #skills(..data.skills.languages)

#section("Experience")

#for exp in data.experience {
  experience(
    exp.title,
    exp.company,
    exp.location,
    exp.dates,
    exp.description,
    skills: exp.skills,
  )
}

#section("Education")

#for edu in data.education {
  education(
    edu.degree,
    edu.school,
    edu.location,
    edu.dates,
    details: [#edu.details],
  )
}

#section("Projects")

#for proj in data.projects {
  [
    #text(weight: "bold")[#proj.name] #h(1fr) #text(
      style: "italic",
    )[#proj.stack] \
    #proj.description
  ]
}

#section("Organizations")

#for org in data.organizations {
  [
    #text(weight: "bold")[#org.name] #h(1fr) #text(style: "italic")[#org.role] \
    #org.description
  ]
}
