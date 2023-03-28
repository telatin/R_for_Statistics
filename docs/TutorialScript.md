---
title: "An R script corresponding to day 1 section 5 onwards of my Introduction to R for Statistics course."
---

## Introduction

In this script we use tidyverse for some descriptive analysis and the base R linear modelling function to describe and analyse the built in iris dataset

I have used a special kind of comment in this script (the #') which means that I can `spin` this file into a nice report.

See https://bookdown.org/yihui/rmarkdown-cookbook/spin.html for more information, or https://quarto.org/ for more general introduction to making documents, presentations and websites directly with R.

First we need to load the tidyverse packages for the current session.


```r
library(tidyverse)
```

## Load the data.
Load the iris built in data


```r
data(iris)
```

## Descriptive analysis
How many rows does iris have?


```r
nrow(iris)
```

```
## [1] 150
```

What is the class of each of the columns?  Note we can look at the columns one at a time, eg:


```r
class(iris$Sepal.Length)
```

```
## [1] "numeric"
```

Or we can use `lapply` to *apply* the function class over the columns of iris (look at the help for apply to understand this):


```r
lapply(iris , class)
```

```
## $Sepal.Length
## [1] "numeric"
## 
## $Sepal.Width
## [1] "numeric"
## 
## $Petal.Length
## [1] "numeric"
## 
## $Petal.Width
## [1] "numeric"
## 
## $Species
## [1] "factor"
```

We could also have used `str`


```r
str(iris)
```

```
## 'data.frame':	150 obs. of  5 variables:
##  $ Sepal.Length: num  5.1 4.9 4.7 4.6 5 5.4 4.6 5 4.4 4.9 ...
##  $ Sepal.Width : num  3.5 3 3.2 3.1 3.6 3.9 3.4 3.4 2.9 3.1 ...
##  $ Petal.Length: num  1.4 1.4 1.3 1.5 1.4 1.7 1.4 1.5 1.4 1.5 ...
##  $ Petal.Width : num  0.2 0.2 0.2 0.2 0.2 0.4 0.3 0.2 0.2 0.1 ...
##  $ Species     : Factor w/ 3 levels "setosa","versicolor",..: 1 1 1 1 1 1 1 1 1 1 ...
```

What is the mean sepal length of the flowers?
These two lines do exactly the same thing!  Which one you use is a matter of style.


```r
iris$Sepal.Length |> mean()
```

```
## [1] 5.843333
```

```r
mean(iris$Sepal.Length)
```

```
## [1] 5.843333
```

What is the minimum sepal width of the flowers?


```r
iris$Sepal.Width |> min()
```

```
## [1] 2
```

We could use the tidyverse function `summarise` to do this:


```r
iris |> summarise( meanLength = mean(Sepal.Length) , minWidth=min(Sepal.Width))
```

```
##   meanLength minWidth
## 1   5.843333        2
```

How many virginica flowers are in the dataset?


```r
table(iris$Species)
```

```
## 
##     setosa versicolor  virginica 
##         50         50         50
```

```r
iris |> filter(Species=="virginica") |> nrow()
```

```
## [1] 50
```

Using `gt`:


```r
library(gtsummary)
```

Make a summary table of each variable in the dataset stratified by Species


```r
tbl_summary(iris, by="Species")
```

<!--html_preserve--><div id="vnfqhnissn" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#vnfqhnissn .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#vnfqhnissn .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#vnfqhnissn .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#vnfqhnissn .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#vnfqhnissn .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#vnfqhnissn .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vnfqhnissn .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#vnfqhnissn .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#vnfqhnissn .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#vnfqhnissn .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#vnfqhnissn .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#vnfqhnissn .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#vnfqhnissn .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#vnfqhnissn .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#vnfqhnissn .gt_from_md > :first-child {
  margin-top: 0;
}

#vnfqhnissn .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vnfqhnissn .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#vnfqhnissn .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#vnfqhnissn .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#vnfqhnissn .gt_row_group_first td {
  border-top-width: 2px;
}

#vnfqhnissn .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnfqhnissn .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#vnfqhnissn .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#vnfqhnissn .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vnfqhnissn .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnfqhnissn .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#vnfqhnissn .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#vnfqhnissn .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vnfqhnissn .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#vnfqhnissn .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnfqhnissn .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#vnfqhnissn .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vnfqhnissn .gt_left {
  text-align: left;
}

#vnfqhnissn .gt_center {
  text-align: center;
}

#vnfqhnissn .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vnfqhnissn .gt_font_normal {
  font-weight: normal;
}

#vnfqhnissn .gt_font_bold {
  font-weight: bold;
}

#vnfqhnissn .gt_font_italic {
  font-style: italic;
}

#vnfqhnissn .gt_super {
  font-size: 65%;
}

#vnfqhnissn .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#vnfqhnissn .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#vnfqhnissn .gt_indent_1 {
  text-indent: 5px;
}

#vnfqhnissn .gt_indent_2 {
  text-indent: 10px;
}

#vnfqhnissn .gt_indent_3 {
  text-indent: 15px;
}

#vnfqhnissn .gt_indent_4 {
  text-indent: 20px;
}

#vnfqhnissn .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;setosa&lt;/strong&gt;, N = 50&lt;sup class=&quot;gt_footnote_marks&quot;&gt;1&lt;/sup&gt;"><strong>setosa</strong>, N = 50<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;versicolor&lt;/strong&gt;, N = 50&lt;sup class=&quot;gt_footnote_marks&quot;&gt;1&lt;/sup&gt;"><strong>versicolor</strong>, N = 50<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;virginica&lt;/strong&gt;, N = 50&lt;sup class=&quot;gt_footnote_marks&quot;&gt;1&lt;/sup&gt;"><strong>virginica</strong>, N = 50<sup class="gt_footnote_marks">1</sup></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Sepal.Length</td>
<td headers="stat_1" class="gt_row gt_center">5.00 (4.80, 5.20)</td>
<td headers="stat_2" class="gt_row gt_center">5.90 (5.60, 6.30)</td>
<td headers="stat_3" class="gt_row gt_center">6.50 (6.23, 6.90)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Sepal.Width</td>
<td headers="stat_1" class="gt_row gt_center">3.40 (3.20, 3.68)</td>
<td headers="stat_2" class="gt_row gt_center">2.80 (2.53, 3.00)</td>
<td headers="stat_3" class="gt_row gt_center">3.00 (2.80, 3.18)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Petal.Length</td>
<td headers="stat_1" class="gt_row gt_center">1.50 (1.40, 1.58)</td>
<td headers="stat_2" class="gt_row gt_center">4.35 (4.00, 4.60)</td>
<td headers="stat_3" class="gt_row gt_center">5.55 (5.10, 5.88)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Petal.Width</td>
<td headers="stat_1" class="gt_row gt_center">0.20 (0.20, 0.30)</td>
<td headers="stat_2" class="gt_row gt_center">1.30 (1.20, 1.50)</td>
<td headers="stat_3" class="gt_row gt_center">2.00 (1.80, 2.30)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="4"><sup class="gt_footnote_marks">1</sup> Median (IQR)</td>
    </tr>
  </tfoot>
</table>
</div><!--/html_preserve-->

```r
library(GGally)
```

Pairs plots are useful summaries


```r
ggpairs(iris)
```

```
## plot: [1,1] [===>-------------------------------------------------------------------------------------------] 4% est: 0s
## plot: [1,2] [=======>---------------------------------------------------------------------------------------] 8% est: 1s
## plot: [1,3] [==========>------------------------------------------------------------------------------------] 12% est: 1s
## plot: [1,4] [==============>--------------------------------------------------------------------------------] 16% est: 1s
## plot: [1,5] [==================>----------------------------------------------------------------------------] 20% est: 1s
## plot: [2,1] [======================>------------------------------------------------------------------------] 24% est: 1s
## plot: [2,2] [==========================>--------------------------------------------------------------------] 28% est: 1s
## plot: [2,3] [=============================>-----------------------------------------------------------------] 32% est: 1s
## plot: [2,4] [=================================>-------------------------------------------------------------] 36% est: 1s
## plot: [2,5] [=====================================>---------------------------------------------------------] 40% est: 1s
## plot: [3,1] [=========================================>-----------------------------------------------------] 44% est: 1s
## plot: [3,2] [=============================================>-------------------------------------------------] 48% est: 1s
## plot: [3,3] [================================================>----------------------------------------------] 52% est: 1s
## plot: [3,4] [====================================================>------------------------------------------] 56% est: 1s
## plot: [3,5] [========================================================>--------------------------------------] 60% est: 0s
## plot: [4,1] [============================================================>----------------------------------] 64% est: 0s
## plot: [4,2] [================================================================>------------------------------] 68% est: 0s
## plot: [4,3] [===================================================================>---------------------------] 72% est: 0s
## plot: [4,4] [=======================================================================>-----------------------] 76% est: 0s
## plot: [4,5] [===========================================================================>-------------------] 80% est: 0s
## plot: [5,1] [===============================================================================>---------------] 84% est: 0s
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`. plot: [5,2]
## [===================================================================================>-----------] 88% est: 0s `stat_bin()`
## using `bins = 30`. Pick better value with `binwidth`. plot: [5,3]
## [======================================================================================>--------] 92% est: 0s `stat_bin()`
## using `bins = 30`. Pick better value with `binwidth`. plot: [5,4]
## [==========================================================================================>----] 96% est: 0s `stat_bin()`
## using `bins = 30`. Pick better value with `binwidth`. plot: [5,5]
## [===============================================================================================]100% est: 0s
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13-1.png)

 Using `dplyr` to find the mean of the sepal length for cases when petal length is less than 2:


```r
iris |> filter(Petal.Length<2) |> summarise(mean(Sepal.Length))
```

```
##   mean(Sepal.Length)
## 1              5.006
```

## Linear modelling
First we estimate the model:


```r
model1 <- lm( Sepal.Length ~ Species, data=iris)
```

Now look at the different functions that we have available to extract information from the model:
Base functions:


```r
summary(lm1)
```

```
## Error in summary(lm1): object 'lm1' not found
```

```r
anova(model1)
```

```
## Analysis of Variance Table
## 
## Response: Sepal.Length
##            Df Sum Sq Mean Sq F value    Pr(>F)    
## Species     2 63.212  31.606  119.26 < 2.2e-16 ***
## Residuals 147 38.956   0.265                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
confint(model1)
```

```
##                       2.5 %   97.5 %
## (Intercept)       4.8621258 5.149874
## Speciesversicolor 0.7265312 1.133469
## Speciesvirginica  1.3785312 1.785469
```

A tidyverse function:


```r
broom::tidy(model1 , conf.int=TRUE)
```

```
## # A tibble: 3 × 7
##   term              estimate std.error statistic   p.value conf.low conf.high
##   <chr>                <dbl>     <dbl>     <dbl>     <dbl>    <dbl>     <dbl>
## 1 (Intercept)          5.01     0.0728     68.8  1.13e-113    4.86       5.15
## 2 Speciesversicolor    0.930    0.103       9.03 8.77e- 16    0.727      1.13
## 3 Speciesvirginica     1.58     0.103      15.4  2.21e- 32    1.38       1.79
```

emmeans for post-hoc means and tests:


```r
emmeans::emmeans(model1 , pairwise ~ Species)
```

```
## $emmeans
##  Species    emmean     SE  df lower.CL upper.CL
##  setosa       5.01 0.0728 147     4.86     5.15
##  versicolor   5.94 0.0728 147     5.79     6.08
##  virginica    6.59 0.0728 147     6.44     6.73
## 
## Confidence level used: 0.95 
## 
## $contrasts
##  contrast               estimate    SE  df t.ratio p.value
##  setosa - versicolor      -0.930 0.103 147  -9.033  <.0001
##  setosa - virginica       -1.582 0.103 147 -15.366  <.0001
##  versicolor - virginica   -0.652 0.103 147  -6.333  <.0001
## 
## P value adjustment: tukey method for comparing a family of 3 estimates
```

Generate model predictions using `augment`
This creates a new version of `iris` with model predictions added.


```r
model1 |> broom::augment(interval="confidence" )
```

```
## # A tibble: 150 × 10
##    Sepal.Length Species .fitted .lower .upper   .resid   .hat .sigma     .cooksd .std.resid
##           <dbl> <fct>     <dbl>  <dbl>  <dbl>    <dbl>  <dbl>  <dbl>       <dbl>      <dbl>
##  1          5.1 setosa     5.01   4.86   5.15  0.0940  0.0200  0.516 0.000231        0.184 
##  2          4.9 setosa     5.01   4.86   5.15 -0.106   0.0200  0.516 0.000294       -0.208 
##  3          4.7 setosa     5.01   4.86   5.15 -0.306   0.0200  0.516 0.00245        -0.600 
##  4          4.6 setosa     5.01   4.86   5.15 -0.406   0.0200  0.515 0.00432        -0.797 
##  5          5   setosa     5.01   4.86   5.15 -0.00600 0.0200  0.517 0.000000943    -0.0118
##  6          5.4 setosa     5.01   4.86   5.15  0.394   0.0200  0.515 0.00407         0.773 
##  7          4.6 setosa     5.01   4.86   5.15 -0.406   0.0200  0.515 0.00432        -0.797 
##  8          5   setosa     5.01   4.86   5.15 -0.00600 0.0200  0.517 0.000000943    -0.0118
##  9          4.4 setosa     5.01   4.86   5.15 -0.606   0.0200  0.514 0.00962        -1.19  
## 10          4.9 setosa     5.01   4.86   5.15 -0.106   0.0200  0.516 0.000294       -0.208 
## # … with 140 more rows
```

We could store this dataset or we could pipe it straight into ggplot2 to plot the data with the modelled estimates and confidence intervals:
Here I use `lm` to create a model for sepal length depending on Species and Petal Length, then use ggplot2 to plot the resulting predictions with their confidence intervals:


```r
library(ggplot2)

lm( Sepal.Length ~ Species * Petal.Length, data=iris) |>
  broom::augment(interval="confidence" ) |>
  ggplot() + 
    aes(x=Petal.Length, y=Sepal.Length, color=Species) + 
    geom_ribbon(aes(y=.fitted,ymin=.lower, ymax=.upper), alpha=0.1) + 
    geom_point() + 
    geom_line(aes(y=.fitted),lwd=1) + 
    theme_bw()
```

![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-20-1.png)

Compare this to the prediction intervals.  What is the difference?


```r
lm( Sepal.Length ~ Species * Petal.Length, data=iris) |>
  broom::augment(interval="prediction" ) |>
  ggplot() + 
  aes(x=Petal.Length, y=Sepal.Length, color=Species) + 
  geom_ribbon(aes(y=.fitted,ymin=.lower, ymax=.upper), alpha=0.1) + 
  geom_point() + 
  geom_line(aes(y=.fitted),lwd=1) + 
  theme_bw()
```

![plot of chunk unnamed-chunk-21](figure/unnamed-chunk-21-1.png)

## More descriptives (section 10)
Recode the PetalLength variable into groups:


```r
iris <- iris |> mutate(PetalLengthGrouped = cut_number(Petal.Length, 3, labels=c("Short", "Medium", "Long") )) 
```

Make a cross-tabulation of this by species (the base R way):


```r
table(iris$Species, iris$PetalLengthGrouped)
```

```
##             
##              Short Medium Long
##   setosa        50      0    0
##   versicolor     0     48    2
##   virginica      0      6   44
```

A couple of tidyverse ways:


```r
iris |> count(Species, PetalLengthGrouped)
```

```
##      Species PetalLengthGrouped  n
## 1     setosa              Short 50
## 2 versicolor             Medium 48
## 3 versicolor               Long  2
## 4  virginica             Medium  6
## 5  virginica               Long 44
```

```r
iris |> janitor::tabyl(Species, PetalLengthGrouped)
```

```
##     Species Short Medium Long
##      setosa    50      0    0
##  versicolor     0     48    2
##   virginica     0      6   44
```

But `tbl_summary` might be the nicest option:


```r
iris |> tbl_summary(by=Species, include=PetalLengthGrouped)
```

<!--html_preserve--><div id="dxdkmtnwom" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#dxdkmtnwom .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#dxdkmtnwom .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#dxdkmtnwom .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#dxdkmtnwom .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#dxdkmtnwom .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#dxdkmtnwom .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dxdkmtnwom .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#dxdkmtnwom .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#dxdkmtnwom .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#dxdkmtnwom .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#dxdkmtnwom .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#dxdkmtnwom .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#dxdkmtnwom .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#dxdkmtnwom .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#dxdkmtnwom .gt_from_md > :first-child {
  margin-top: 0;
}

#dxdkmtnwom .gt_from_md > :last-child {
  margin-bottom: 0;
}

#dxdkmtnwom .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#dxdkmtnwom .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#dxdkmtnwom .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#dxdkmtnwom .gt_row_group_first td {
  border-top-width: 2px;
}

#dxdkmtnwom .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dxdkmtnwom .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#dxdkmtnwom .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#dxdkmtnwom .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dxdkmtnwom .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#dxdkmtnwom .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#dxdkmtnwom .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#dxdkmtnwom .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#dxdkmtnwom .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#dxdkmtnwom .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-left: 4px;
  padding-right: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#dxdkmtnwom .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#dxdkmtnwom .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#dxdkmtnwom .gt_left {
  text-align: left;
}

#dxdkmtnwom .gt_center {
  text-align: center;
}

#dxdkmtnwom .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#dxdkmtnwom .gt_font_normal {
  font-weight: normal;
}

#dxdkmtnwom .gt_font_bold {
  font-weight: bold;
}

#dxdkmtnwom .gt_font_italic {
  font-style: italic;
}

#dxdkmtnwom .gt_super {
  font-size: 65%;
}

#dxdkmtnwom .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 75%;
  vertical-align: 0.4em;
}

#dxdkmtnwom .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#dxdkmtnwom .gt_indent_1 {
  text-indent: 5px;
}

#dxdkmtnwom .gt_indent_2 {
  text-indent: 10px;
}

#dxdkmtnwom .gt_indent_3 {
  text-indent: 15px;
}

#dxdkmtnwom .gt_indent_4 {
  text-indent: 20px;
}

#dxdkmtnwom .gt_indent_5 {
  text-indent: 25px;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;Characteristic&lt;/strong&gt;"><strong>Characteristic</strong></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;setosa&lt;/strong&gt;, N = 50&lt;sup class=&quot;gt_footnote_marks&quot;&gt;1&lt;/sup&gt;"><strong>setosa</strong>, N = 50<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;versicolor&lt;/strong&gt;, N = 50&lt;sup class=&quot;gt_footnote_marks&quot;&gt;1&lt;/sup&gt;"><strong>versicolor</strong>, N = 50<sup class="gt_footnote_marks">1</sup></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="&lt;strong&gt;virginica&lt;/strong&gt;, N = 50&lt;sup class=&quot;gt_footnote_marks&quot;&gt;1&lt;/sup&gt;"><strong>virginica</strong>, N = 50<sup class="gt_footnote_marks">1</sup></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">PetalLengthGrouped</td>
<td headers="stat_1" class="gt_row gt_center"></td>
<td headers="stat_2" class="gt_row gt_center"></td>
<td headers="stat_3" class="gt_row gt_center"></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Short</td>
<td headers="stat_1" class="gt_row gt_center">50 (100%)</td>
<td headers="stat_2" class="gt_row gt_center">0 (0%)</td>
<td headers="stat_3" class="gt_row gt_center">0 (0%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Medium</td>
<td headers="stat_1" class="gt_row gt_center">0 (0%)</td>
<td headers="stat_2" class="gt_row gt_center">48 (96%)</td>
<td headers="stat_3" class="gt_row gt_center">6 (12%)</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Long</td>
<td headers="stat_1" class="gt_row gt_center">0 (0%)</td>
<td headers="stat_2" class="gt_row gt_center">2 (4.0%)</td>
<td headers="stat_3" class="gt_row gt_center">44 (88%)</td></tr>
  </tbody>
  
  <tfoot class="gt_footnotes">
    <tr>
      <td class="gt_footnote" colspan="4"><sup class="gt_footnote_marks">1</sup> n (%)</td>
    </tr>
  </tfoot>
</table>
</div><!--/html_preserve-->

