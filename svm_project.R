# Lib Load ####
install.load::install_load(
  "e1071"
  , "ggplot2"
  , "dplyr"
  , "esquisse"
)

# Get file ####
loans <- read.csv(file.choose(new = T))
str(loans)
summary(loans)

# Feature Engineer ####
loans$inq.last.6mths <- factor(loans$inq.last.6mths)
loans$delinq.2yrs <- factor(loans$delinq.2yrs)
loans$pub.rec <- factor(loans$pub.rec)
loans$not.fully.paid <- factor(loans$not.fully.paid)
loans$credit.policy <- factor(loans$credit.policy)

# EDA ####
# Create a histogram of fico scores colored by not.fully.paid
esquisser()
library(ggplot2)

loans %>% ggplot(
  aes(
    x = fico
    , fill = not.fully.paid
    )
  ) +
  geom_histogram(
    binwidth = 5
    , color = "black"
    ) +
  labs(
    title = "FICO Histogram",
    x = "FICO",
    y = "Count",
    subtitle = "Color by Not Fully Paid"
    ) +
  theme_bw()

loans %>% ggplot(
  aes(
    x = fico
    , fill = not.fully.paid
  )
) +
  geom_density(
    alpha = 0.5
  ) +
  labs(
    title = "FICO Density Plot"
    , x = "FICO"
    , y = "Density"
    , subtitle = "Color by Not Fully Paid"
  ) +
  theme_bw()

# Create a barplot of purpose counts, colored by not.fully.paid. Use position=dodge in the geom_bar argument
loans %>% ggplot(
  aes(
    x = purpose
    , fill = not.fully.paid
  )
) +
  geom_bar(
    position = "dodge"
    ) +
  labs(
    title = "FICO Bar Plot"
    , x = "Purpose of Loan"
    , y = "Count"
    , subtitle = "Colored by Not Fully Paid"
  ) +
  theme_bw() +
  theme(axis.text.x=element_text(angle=90, hjust=1))
