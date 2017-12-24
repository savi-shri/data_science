# install a package
install.packages("ROCR")
library("ROCR")
ROCRpred = prediction(predictTrain, qualityTrain$PoorCare)
# performance function
ROCRpref = performane(ROCRpred, "tpr", "fpr")
plot(ROCRpref)
plot(ROCRpref, colorize=TRUE)
plot(ROCRpref, colorize=TRUE, print.cutoffs.at=seq(0,1,0.1),text.adj=c(-0.2,1.7))