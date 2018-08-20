# Data input and output with R

# CSV input output
# Get a sample csv file
write.csv(mtcars, file = "my_example.csv") # write csv
ex <- read.csv("my_example.csv")           # read csv
head(ex)
class(ex)

# Excel files with R
install.packages("readxl")
library(readxl)
excel_sheets('Sample-Sales-Data.xlsx')
df <- read_excel("Sample-Sales-Data.xlsx", sheet = "Sheet1")
head(df)

entire.workbook <- lapply(excel_sheets('Sample-Sales-Data.xlsx'),
                          read_excel,
                          path = 'Sample-Sales-Data.xlsx')
head(entire.workbook)
entire.workbook #  A list, notice double brackets [[]]

# Write to Excel file
install.packages("xlsx")
library(xlsx)

head(mtcars)
write.xlsx(mtcars, file = "output_example.xlsx")

# SQL with R
# Google it RODBC RPosetgreSQL etc

# Web Scrapping with R
install.packages("rvest")
library(rvest)
lego_movie <- read_html("http://www.imdb.com/title/tt1490017/")
lego_movie %>%
  html_nodes("strong span") %>%
  html_text() %>%
  as.numeric()

