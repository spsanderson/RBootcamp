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

# View Data ####
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

# reslect columns
adult <- adult %>%
  select(
    -type_employer, -type_employer_dplyr
  )

# The assignment says to group govt jobs, i'm not quite sure about this, lets lookk
# at age and income
adult %>%
  filter(
    type_employer_clean == 'State-gov' | 
      type_employer_clean == 'Local-gov' | 
      type_employer_clean == 'Federal-gov'
  ) %>%
  ggplot(
    aes(
      x = type_employer_clean
      , y = age
      , fill = income
    )
  ) +
  geom_boxplot(
    outlier.colour = 'red'
  ) +
  labs(
    title = "Boxplot Government Emplyment Type by Income Level and Gender",
    x = "Government Employer Type",
    y = "Age",
    fill = "Govt Type"
    ) +
  theme_bw() +
  theme(
    legend.background = element_blank()
  ) +
  theme(
    legend.key = element_blank()
  ) +
  facet_wrap(vars(sex))
# The average ages above are not significantly different from each group of government employer type
# so it should be ok to reduce these groups into Government employee
# write a function to do this and do this via a piped dplyr method
govt.emp.reclass.func <- function(job){
  job <- as.character(job)
  if(job == 'State-gov' | job == 'Local-gov' | job == 'Federal-gov') {
    return('SL-gov')
  } else {
    return(job)
  }
}

adult$type_emp_govt <- sapply(adult$type_employer_clean, govt.emp.reclass.func)

# dplyr style
adult <- adult %>%
  mutate(
    type_employer_dplyr = ifelse(
      (
        type_employer_clean == 'State-gov' | 
        type_employer_clean == 'Local-gov' | 
        type_employer_clean == 'Federal-gov'
      )
      , 'SL-gov'
      , as.character(type_employer_clean)
      )
    )

# Since all look good we can make adult$type_employer equal to type_employer_clean
adult$type_employer <- NA
adult$type_employer <- adult$type_emp_govt

# reslect data frame
adult <- adult %>%
  select(-type_employer_clean, -type_emp_govt, -type_employer_dplyr)

# Marital Status ####
# Look at marital status and pair it down
table(adult$marital)
# reduce to 
# Married
# Not-Married
# Never-Married
marital.reclass.func <- function(marital){
  marital <- as.character(marital)
  if(
    marital == 'Married-AF-spouse' |
    marital == 'Married-civ-spouse' |
    marital == 'Married-spouse-absent'
  ){
    return('Married')
  } else if (
    marital == 'Divorced' |
    marital == 'Separated' |
    marital == 'Widowed'
  ) {
    return('Not-Married')
  } else {
    return(marital)
  }
}
adult$marital_clean <- sapply(adult$marital, marital.reclass.func)
adult$marital <- adult$marital_clean
adult <- adult %>%
  select(-marital_clean)

# Country Check ####
table(adult$country)
unique(adult$country)

# going to gruop by continent
country.reclass.func <- function(country) {
  country <- as.character(country)
  if(
    country == 'United-States' |
    country == 'Honduras' |
    country == 'Dominican-Republic' |
    country == 'Outlying-US(Guam-USVI-etc)' |
    country == 'Cuba' |
    country == 'Mexico' |
    country == 'El-Salvador' |
    country == 'Jamaica' |
    country == 'Canada' |
    country == 'Haiti' |
    country == 'Puerto-Rico' |
    country == 'Guatemala' |
    country == 'Nicaragua'
  ) {
    return('North-America')
  } else if (
    country == 'Iran' |
    country == 'Laos' |
    country == 'China' |
    country == 'Philippines' |
    country == 'Cambodia' |
    country == 'Taiwan' |
    country == 'Japan' |
    country == 'Vietnam' |
    country == 'Thailand' |
    country == 'Hong' |
    country == 'India'
  ) {
    return('Asia')
  } else if (
    country == 'Columbia' |
    country == 'South' |
    country == 'Trinadad&Tobago' |
    country == 'Ecuador' |
    country == 'Peru'
  ) {
    return('South-America')
  } else if (
    country == 'Hungary' |
    country == 'England' |
    country == 'Scotland' |
    country == 'Holand-Netherlands' |
    country == 'Italy' |
    country == 'France' |
    country == 'Yugoslavia' |
    country == 'Germany' |
    country == 'Poland' |
    country == 'Greece' |
    country == 'Ireland'
  ) {
    return('Europe')
  } else if(
    country == 'Portugal'
  ) {
    return('Africa')
  } else {
    return('Unclassified')
  }
}

# reclass country to continent
adult$continent <- sapply(adult$country, country.reclass.func)

adult %>% select(
  country, continent
) %>%
  distinct_all() %>%
  arrange(continent)
