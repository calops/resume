#import "cv.typ": cv

#set page(
  paper: "a4",
  margin: (x: 1.4cm, y: 1.4cm),
  footer: context align(right, text(size: 8pt, fill: gray, counter(page).display("1/1", both: true))),
)

#let data = json("../data/resume_data.json")

#cv(data)
