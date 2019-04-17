# Lib Load ####
library(tidyverse)
library(Amelia)
library(funModeling)
library(DataExplorer)
library(esquisse)
library(caTools)

# Get File ####
adult <- read.csv(file.choose(new = T))
adult %>% glimpse()
head(adult, 5)

# Lets drop the column X as it is a secondary index
adult <- adult %>%
  select(-X)
head(adult, 1)
str(adult)
summary(adult)
plot_missing(adult)
create_report(adult)
table(adult$type_employer)

# combine never-worked and without-pay since they are essentially the same thing call uemp
adult$type_employer_clean <- NA

job.reclass.func <- function(job) {
  job <- as.character(job)
  if(job == 'Never-worked' | job == 'Without-pay') {
    return('Unemp')
  } else if(job == 'Self-emp-inc' | job == 'Self-emp-not-inc'){
    return('Self')
  } else {
    return(job)
  }
}
adult$type_employer_clean <- sapply(adult$type_employer, job.reclass.func)
table(adult$type_employer_clean)

# dplyr pipped version
adult <- adult %>%
  mutate(
    type_employer_dplyr = ifelse(
      (type_employer == 'Never-worked' | type_employer == 'Without-pay')
      , 'Unemp'
      , ifelse(
        (type_employer == 'Self-emp-inc' | type_employer == 'Self-emp-not-inc')
        , 'Self'
        , as.character(type_employer)
      )
    )
  )
