#let accent_color = rgb("#0D6C44")

#let icon(codepoint) = {
  text(font: "Symbols Nerd Font Mono", codepoint, fill: accent_color)
}

#let header(name, tagline, logo_path: none) = {
  if logo_path != none {
    grid(
      columns: (auto, 1fr),
      align: horizon,
      column-gutter: 2em,
      image(logo_path, height: 5em),
      [
        #align(right)[
          #text(size: 24pt, weight: "bold", fill: accent_color)[#name] \
          #text(size: 12pt, style: "italic")[#tagline]
        ]
      ],
    )
  } else {
    align(center)[
      #text(size: 24pt, weight: "bold")[#name] \
      #text(size: 12pt, style: "italic")[#tagline]
    ]
  }
}

#let contact(..items) = {
  align(center)[
    #items.pos().join(text(fill: black)[ • ])
  ]
}

#let section(title) = {
  v(0.4em)
  grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    align: horizon,
    text(size: 12pt, weight: "bold", fill: accent_color)[#title], line(length: 100%, stroke: 2pt + accent_color),
  )
  v(0.1em)
}

#let skills(..items) = {
  items.pos().join(" • ")
}

#let pill(content) = {
  box(
    inset: (x: 0.5em, y: 0.1em),
    radius: 4pt,
    fill: luma(230),
    text(size: 8pt, content),
  )
}

#let format_description(description) = {
  if description == "" { return }
  let lines = description.split("\n")
  for line in lines {
    if line.starts-with("- ") {
      list.item(line.slice(2))
      v(-0.5em)
    } else {
      line
      linebreak()
    }
  }
}

#let experience(title, company, location, dates, description, skills: none) = {
  block(breakable: false)[
    #let title_company_cell = [#text(weight: "bold")[#title] at #text(weight: "bold", fill: accent_color)[#company]]
    #let dates_cell = [#align(right)[#dates]]
    #let location_cell = [#location]
    #grid(
      columns: (1fr, auto),
      row-gutter: 0.3em,
      title_company_cell, dates_cell,
      location_cell, [],
    )
    #v(-0.5em)
    #if description != "" {
      format_description(description)
    }
    #if skills != none and skills.len() > 0 {
      [
        #skills.map(skill => pill(skill)).join(h(0.5em))
      ]
    }
    #v(0.8em)
  ]
}

#let education(degree, school, location, dates, details: none) = {
  block(breakable: false)[
    #let degree_school_cell = [#text(weight: "bold")[#degree] at #text(weight: "bold", fill: accent_color)[#school]]
    #let dates_cell = [#align(right)[#dates]]
    #let location_cell = [#location]
    #grid(
      columns: (1fr, auto),
      row-gutter: 0.3em,
      degree_school_cell, dates_cell,
      location_cell, [],
    )
    #v(-0.5em)
    #if details != none {
      format_description(details)
    }
    #v(0.8em)
  ]
}

#let cv(data) = {
  set text(
    font: "Aporetic Sans",
    size: 10pt,
  )
  set par(justify: true)

  header(
    data.header.name,
    data.header.tagline,
    logo_path: data.header.logo_path,
  )

  v(0.5em)

  contact(
    [#icon("") #link("mailto:" + data.contact.email, data.contact.email)],
    [#icon("") #link("tel:" + data.contact.phone, data.contact.phone)],
    [#icon("") #data.contact.location],
    [#icon("") #link(data.contact.linkedin.url, data.contact.linkedin.username)],
    [#icon("") #link(data.contact.github.url, data.contact.github.username)],
  )

  section("Skills")

  grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    row-gutter: 0.8em,
    [*Programming:*], skills(..data.skills.programming),
    [*Technologies:*], skills(..data.skills.technologies),
    [*Languages:*], skills(..data.skills.languages),
  )

  section("Experience")

  for exp in data.experience {
    experience(
      exp.title,
      exp.company,
      exp.location,
      exp.dates,
      exp.description,
      skills: exp.skills,
    )
  }

  section("Education")

  for edu in data.education {
    education(
      edu.degree,
      edu.school,
      edu.location,
      edu.dates,
      details: edu.details,
    )
  }
}
