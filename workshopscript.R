


# Load libraries

library(ggplot2)
library(dplyr)
library(data.table)
library(readxl)


# Load data

treated <- read_excel(path="walkingspeed.xlsx", 
                      sheet = "treated",
                      range = "A1:B68")

# Notes:
# The library readxl for reading Excel sheets.  There are alternatives but I find this works well.
# Multiline function call
# Named arguments
# Assigning the outcome to the variable
# Help file, how did we know how this function worked.

treated <- read_excel(path="walkingspeed.xlsx", 
                      sheet = "treated",
                      range = "A1:B68")

control <- read_excel(path="walkingspeed.xlsx", 
                      sheet = "control",
                      range = "A1:B70")

metadata <- read_excel(path="walkingspeed.xlsx", 
                      sheet = "meta",
                      range = "A1:D139")


# Explore data

class(treated)
str(treated)
summary(treated)
head(treated)
View(treated)

# Access elements from the dataframe

str(control)

control$walktime
mean(control$walktime)
log(control$walktime)

# Wrangle

# We need to append and merge data.

str(treated)
str(control)

# First we need to make sure the vectors we are merging have the same type and name

# Base R
treated$walktime <- as.numeric(treated$time)
# data.table
setDT(treated)
treated[ , walktime := as.numeric(time)  ]
# tidyverse
treated <- treated %>% mutate(walktime = as.numeric(time))


## Append rows together:

# data.table
combined <- rbind(treated, control, fill=TRUE)
# tidyverse
combined <- bind_rows(treated, control)
combined <- bind_rows(treated = treated, 
                      control = control, 
                      .id = "group")

str(metadata)
str(combined)

walkingdata <- merge(combined, metadata, 
                by.x = "patid", by.y = "patient")
walkingdata



# Describe

walkingdata %>% 
  filter(!is.na(walktime)) %>% 
  group_by(group) %>% 
  summarise(Mean=mean(walktime), SD=sd(walktime))

walkingdata[!is.na(walktime) ,  
            .(Mean=mean(walktime), SD=sd(walktime)),
            group]



# Visualise

# A very bad graph
plot(walkingdata$age , walkingdata$walktime)

# A better graph
ggplot(walkingdata) + 
  aes(x=age, y=walktime) + 
  geom_point()

# Adorn the graph
ggplot(walkingdata) + 
  aes(x=age, y=walktime) + 
  geom_point() + 
  labs(x="Age (years)", y="Time (seconds)") + 
  scale_y_log10() + 
  facet_wrap(~sex) +
  theme_bw()

ggplot(walkingdata) + 
  aes(x=group, y=walktime) + 
  geom_boxplot() + 
  labs(x="Treatment group", y="Time (seconds)") + 
  scale_y_log10() + 
  facet_wrap(~sex) +
  theme_bw()

  

# Recode

# base
walkingdata$walktime[ walkingdata$walktime > 100 ] <- NA
walkingdata$walktime[ walkingdata$walktime < 0.1 ] <- NA
# data.table
walkingdata[ walktime>100 , walktime := NA]
walkingdata[ walktime<0.1 , walktime := NA]


# Simple tests
t.test( data = walkingdata , walktime ~ group)
ttest1 <- t.test( data = walkingdata , walktime ~ group)
ttest1$p.value

# Model
lm1 <- lm( data = walkingdata , walktime ~ group)
summary(lm1)
confint(lm1)

# Diagnose
plot(lm1)

# Recode

walkingdata[ , speed := 1/walktime]

lm2 <- lm( data = walkingdata , log(walktime) ~ group)
lm3 <- lm( data = walkingdata , 1/walktime ~ group)
plot(lm2)
plot(lm3)

summary(lm3)
gtsummary::tbl_regression(lm3)

# Augment model

lm4 <- lm( data = walkingdata , 1/walktime ~ group + age + sex + department)
gtsummary::tbl_regression(lm4)

lm5 <- lm( data = walkingdata , 1/walktime ~ group + age + sex + factor(department))
gtsummary::tbl_regression(lm5)

anova(lm5 , update(lm5, . ~ . -age))
