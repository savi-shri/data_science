healthy  = read.csv("healthy.csv")
healthyMatrix = as.matrix(healthy)
str(healthMatrix)
# to see the image
image(healthyMatrix, axes=FALSE, col = grey(seq(0,1,length=256)))
healthyVector = as.vector(healthyMatrix)
distance = dist(healthyVector, method="euclidean")
# This might give you error - can not allocate vector of size 2.0
str(healthyVector)

n=365636
n*(n-1/2)

#It is a huge number so we can not use hirarchial clustering because of high resolution of image.
# So we need to use k-Means clustering which is below to segment the image

# Set number of cluster K based on what you are trying to extract
k=5
set.seed(1)
KMC = kmeans(healthyVector, centers=k,iter.max=1000)
str(KMC)
#Extract the vector
healthyClusters = KMC$cluster
# find the mean value from the cluster. In hirarchial cluste you find it by using tapply function(see the video)
#but in k-mean it is available as "centers" variable.
KMC$centers[2]

dim(healthyClusters) = c(nrow(healthyMatrix),ncol(healthyMatrix))
image(healthyClusters,axes=FALSE, col = rainbow(k))



