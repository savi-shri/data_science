tumor = read.csv("tumor.csv", header = FALSE)
tumorMatrix = as.matrix(tumor)
tumorVector = as.vector(tumorMatrix)

# we will not run K-mean clustering algorithm again on tumor data instead we will apply the k-means clustering 
# results that we found using healthy brain image. healthy vector as training set and tumor as test set
# install a package
install.packages("flexclust")
library("flexclust")

# this package contains the object class KCCA (K centroid cluster analysis)
KMC.kcca = as.kcca(KMC, healthyVector) # data conversion take some time to run, KMC is the original variable which we created in healthy.R
tumorCluster = predict(KMC.kcca,newdata=tumorVector)
dim(tumorCluster) = c(nrow(tumorMatrix),ncol(tumorMatrix))
image(tumorClusters, axes=FALSE, col=rainbow()k)