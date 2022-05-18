# Importing dataset

library(readxl)
Airline <- read_excel(file.choose())
View(Airline)

# Removing unnecessary columns
Data <- Airline[2:12]
View(Data)
str(Data)

summary(Data)

# Normalize the data
normalized_data <- scale(Data[, 1:11]) 

summary(normalized_data)

# Distance matrix
d <- dist(normalized_data, method = "euclidean") 

fit <- hclust(d, method = "ward.D2")

# Display dendrogram
plot(fit) 
plot(fit, hang = -1)

groups <- cutree(fit, k =14)# Cut tree into 14 clusters

rect.hclust(fit, k =14, border = "red")

cluster <- as.matrix(groups)

final <- data.frame(cluster, Data)

aggregate(Data[, 1:11], by = list(final$cluster), FUN = mean)

library(readr)
write_csv(final, "Airlines_R.csv")

getwd()
