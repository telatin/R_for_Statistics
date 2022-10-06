
# Just for fun

library(dadjoke)
library(cowsay)


dadjoke() |> 
  capture.output() |> 
  paste(collapse = "\n") |> 
  say(by="random")


library(praise)

praise() |> say(by="random")


p <- praise()
say(p)


