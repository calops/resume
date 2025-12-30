#import "cv.typ": cv

#set page(
  paper: "a4",
  margin: (x: 1.4cm, y: 1.4cm),
)

#let data = json("../data/resume_data.json")

#cv(data)
