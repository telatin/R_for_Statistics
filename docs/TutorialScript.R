
#' ---
#' title: "An R script corresponding to day 1 section 5 onwards of my Introduction to R for Statistics course."
#' ---


#' 

#' ## Introduction
#'
#' In this script we use tidyverse for some descriptive analysis and the base R linear modelling function to describe and analyse the built in iris dataset
#'
#' I have used a special kind of comment in this script (the #') which means that I can `spin` this file into a nice report.
#' 
#' See https://bookdown.org/yihui/rmarkdown-cookbook/spin.html for more information, or https://quarto.org/ for more general introduction to making documents, presentations and websites directly with R.
#'
#' First we need to load the tidyverse packages for the current session.

library(tidyverse)


#' ## Load the data.

#' Load the iris built in data
data(iris)

#' ## Descriptive analysis

#' How many rows does iris have?
nrow(iris)

#' What is the class of each of the columns?  Note we can look at the columns one at a time, eg:
class(iris$Sepal.Length)

#' Or we can use `lapply` to *apply* the function class over the columns of iris (look at the help for apply to understand this):
lapply(iris , class)

#' We could also have used `str`
str(iris)

#' What is the mean sepal length of the flowers?
#' These two lines do exactly the same thing!  Which one you use is a matter of style.
iris$Sepal.Length |> mean()
mean(iris$Sepal.Length)

#' What is the minimum sepal width of the flowers?
iris$Sepal.Width |> min()

#' We could use the tidyverse function `summarise` to do this:
iris |> summarise( meanLength = mean(Sepal.Length) , minWidth=min(Sepal.Width))

#' How many virginica flowers are in the dataset?
table(iris$Species)
iris |> filter(Species=="virginica") |> nrow()

#' Using `gt`:

library(gtsummary)

#' Make a summary table of each variable in the dataset stratified by Species

tbl_summary(iris, by="Species")

library(GGally)

#' Pairs plots are useful summaries

ggpairs(iris)


#'  Using `dplyr` to find the mean of the sepal length for cases when petal length is less than 2:

iris |> filter(Petal.Length<2) |> summarise(mean(Sepal.Length))


#' ## Linear modelling

#' First we estimate the model:

model1 <- lm( Sepal.Length ~ Species, data=iris)

#' Now look at the different functions that we have available to extract information from the model:

#' Base functions:

summary(lm1)
anova(model1)
confint(model1)

#' A tidyverse function:

broom::tidy(model1 , conf.int=TRUE)

#' emmeans for post-hoc means and tests:

emmeans::emmeans(model1 , pairwise ~ Species)


#' Generate model predictions using `augment`

#' This creates a new version of `iris` with model predictions added.

model1 |> broom::augment(interval="confidence" )

#' We could store this dataset or we could pipe it straight into ggplot2 to plot the data with the modelled estimates and confidence intervals:

#' Here I use `lm` to create a model for sepal length depending on Species and Petal Length, then use ggplot2 to plot the resulting predictions with their confidence intervals:

library(ggplot2)

lm( Sepal.Length ~ Species * Petal.Length, data=iris) |>
  broom::augment(interval="confidence" ) |>
  ggplot() + 
    aes(x=Petal.Length, y=Sepal.Length, color=Species) + 
    geom_ribbon(aes(y=.fitted,ymin=.lower, ymax=.upper), alpha=0.1) + 
    geom_point() + 
    geom_line(aes(y=.fitted),lwd=1) + 
    theme_bw()

#' Compare this to the prediction intervals.  What is the difference?

lm( Sepal.Length ~ Species * Petal.Length, data=iris) |>
  broom::augment(interval="prediction" ) |>
  ggplot() + 
  aes(x=Petal.Length, y=Sepal.Length, color=Species) + 
  geom_ribbon(aes(y=.fitted,ymin=.lower, ymax=.upper), alpha=0.1) + 
  geom_point() + 
  geom_line(aes(y=.fitted),lwd=1) + 
  theme_bw()


  
#' ## More descriptives (section 10)

#' Recode the PetalLength variable into groups:

iris <- iris |> mutate(PetalLengthGrouped = cut_number(Petal.Length, 3, labels=c("Short", "Medium", "Long") )) 

#' Make a cross-tabulation of this by species (the base R way):

table(iris$Species, iris$PetalLengthGrouped)

#' A couple of tidyverse ways:

iris |> count(Species, PetalLengthGrouped)

iris |> janitor::tabyl(Species, PetalLengthGrouped)

#' But `tbl_summary` might be the nicest option:

iris |> tbl_summary(by=Species, include=PetalLengthGrouped)


