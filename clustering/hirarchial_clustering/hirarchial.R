# Movie recommondation system using hirarchial clustering 

movies = read.table("movieLens.txt", header = FALSE, sep="|", quote="\"")
str(movies)
# varianble does not have varianble names so we add the column names ourselves
colnames(movies) = c("ID", "Title", "ReleaseDate", "VideoRleaseDate", "IMDB","Unknown","Adventure".....add all other 18 genre)

str(movies) # now each column will have name
# we wont we using some of the column so remove them
movies$ID = NULL
movies$ReleaseDate = NULL
movies$VideoRleaseDate = NULL
movies$IMDB = NULL
#remove duplicate data sets

movies = unique(movies)
str(movies)

# compute the distances for all the genre varianble which are from 2 to 23 columns
distances = dist(movies[2:23], method = "euclidean")

# ward method cares abour distance between clusters using centroid distance.
#and also the variance in each of the cluster
clusterMovies = hclust(distances, method="ward") 
#plot the dendrogram
plot(clusterMovies)
# select the meaningful cluster by looking at the dendrogram. We selected 10
clusterGroups = cutree(clusterMovies, k = 10)

#figureout how is cluster are like. The tapply will arrange the data points into 10 cluster and then
# calculate the mean of each cluster for Action genre
tapply(movies$Action, clusterGroups, mean)

# Do that for every variable and then save the results in an excel to analyze the outcome.

subset(movies, Title=="Men in Black (1997)")

# this movie is in 257th row in the cluster
clusterGroups[257] # reuslt of this will be 2
clsuter2 = subset(movies, clusterGroups = 2)
# This will give you top 10 movies for recommdation for one the user on Netflix.
cluster2$Title[1:10]
