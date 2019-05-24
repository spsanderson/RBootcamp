# Lib Load ####
# K-Means does not take in labels it is unsupervised
install.load::install_load(
  "ISLR"
  , "ggplot2"
  , "tidyverse"
  , "cluster"
)

print(head(iris), 5)

ggplot(
  data = iris
  , aes(
    x = Petal.Length
    , y = Petal.Width
    , color = Species
  )
) +
  geom_point(
    size = 4
  )

# set a seed to make reproducible
set.seed(101)

# k-means is built into R
iris.cluster <- kmeans(
 x = iris %>% select(-Species)
  , centers = 3
  , nstart = 20
)
summary(iris.cluster)
print(iris.cluster)
table(iris.cluster$cluster, iris$Species) # in unsupervised learning you will not typically have this convienence

clusplot(iris, iris.cluster$cluster, color = T, shade = T, labels = 0, lines = 0)
