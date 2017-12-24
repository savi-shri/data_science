# The outcome of a logisctic regression model is probability



quality = read.csv(file="quality.csv")
table(quality$PoorCare) # see how many have poor care and good care based on 0 and 1
# this will give 98 as good care and 33 as poor care
# in baseline classification method is to just predict 
# most frequent outcome for all observations.
# Since good care is more common than poor care so
# so in this case we will predict good care. If we do that we
# would get 98/131 or accuracy 0.74. So the aim here is to develop
# the model with 0.74 accuracy.
# Randomely splitting the dataset to training and testing dataset

install.packages("caTools")
library("caTools")
# Sample splitting
set.seed(88)
#SplitRatio above will give 75% dataset as training and 25% as testing
# The first argument in sample.split is outcome variable.
split=sample.split(quality$PoorCare,SplitRatio=0.75)
split

qualityTrain = subset(quality, split == TRUE)
qualityTest = subset(quality, split == FALSE)
nrow(qualityTrain)
nrow(qualityTest)
# build logistic regression model

QualityLog = glm(PoorCare ~ officeVisit + Norcotics, data = qualityTrain, family = binomial)
summary(QualityLog)
# we want to focus on coefficients. Positive values of coefficients
# of officeVisit and Norcotics are +ve. Higher values of these are
# indicative of poor care. The * on both these values shows that 
# they are significant in our model.
# AIC value is quality of model. AIC provides the means for model
# selection. The AIC with minimu value is good model. 
# 
# Make prediction on training data
predictTrain = predict(QualityLog, = type="response")
# type="response" will tell predict function to give us the probability
summary(predictTrain)
# since we are getting probability here all the numbers should  
# be between 0 and 1
# Lets see if we are predicting higher probability for poor care cases as expected
# below will compute average for true prediction of each of outcome
tapply(predictTrain,qualityTrain$PoorCare, mean)
# results will give you higher probability if poor care cases

# Threshold calculation. The below will give TP,FN,FP,TN
table(qualityTrain$PoorCare, predictTrain > 0.5)
# with table output you can calcualte sensitivity, specificity

# change the threshold value to 0.7
table(qualityTrain$PoorCare, predictTrain > 0.7)
# calculate the sensitivity and specificity

table(qualityTrain$PoorCare, predictTrain > 0.2)
# calculate the sensitivity and specificity.

# from here decide which threshold to pick.






