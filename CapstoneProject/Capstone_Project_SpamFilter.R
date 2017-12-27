
# https://archive.ics.uci.edu/ml/datasets/Spambase
# https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/
# Objective of this script is to classify spam and non-spam data in the Spambase data.

# Read the spambase data from https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.data 
file = "https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.data"

raw.data <- read.csv(file, header=F)

# Read attributes (Spam names) from the file "Spam names.csv" located at local.
name.var <- read.csv(file.choose())

# change the name of the below Spam names attributes which have special characters in their name as below:  
names(name.var)[49]<- "char_freq_semic"    # char_freq_;
names(name.var)[50]<- "char_freq_openp"    # char_freq_(
names(name.var)[51]<- "char_freq_openb"    # char_freq_[
names(name.var)[52]<- "char_freq_excl"     # char_freq_!
names(name.var)[53]<- "char_freq_dollar"   # char_freq_$
names(name.var)[54]<- "char_freq_pound"    # char_freq_#

# give column names in the raw.data using spam names data.
colnames(raw.data) <- colnames(name.var)

# copy the raw.data to another varianble raw
raw <- raw.data

#attached 'raw' to the R search path.  This means that the database is searched by R when evaluating a variable, 
#so objects in the database can be accessed by simply giving their names.
attach(raw)

# Look at the data - how many rows and columns this data has, what is the data type etc.
dim(raw)
head(raw)
tail(raw)
str(raw)


# Find out if there are missing values
na.count.all <- data.frame(sapply(raw, function(y) sum(length(which(is.na(y))))))
sum(is.na(raw))

raw$spam <- as.factor(raw$spam)
summary(raw$spam)

# Split the data into training and testing dataset with 75/25 ratio.
set.seed(123)
test.raw <- sample(nrow(raw),0.3*nrow(raw))
raw.train <- raw[-test.raw,] 
raw.test <- raw[test.raw,] 



## Building logistic regression model
glmModel <- glm(spam ~ ., data=raw.train,family=binomial)

# predicting values - make prediction on training data
glmModel.tr <- predict(glmModel, newdata=raw.train,type="response")

glmModel.tr.pred <- rep("0",3221)
glmModel.tr.pred[glm.tr>0.99999]="1"
table(raw.train$spam,glmModel.tr.pred)

# Below will provide the Coefficients table.
summary(glmModel)

###### ROC CURV
install.packages("ROCR")
library("ROCR")
ROCRpred = prediction(glmModel.tr, raw.train$spam)

# performance function
ROCRpref =  performance(ROCRpred, "tpr", "fpr")
plot(ROCRpref)
plot(ROCRpref, colorize=TRUE)
plot(ROCRpref, colorize=TRUE, print.cutoffs.at=seq(0,1,0.1),text.adj=c(-0.2,1.7))

# Compute AUROC
auc<-performance(ROCRpred, "auc")@y.values
auc

#Evaluating the model on testing data set
glm.test.pred <- predict(glmModel, newdata=raw.test,type="response")
glm.test <- rep("0", 1380)
glm.test[glm.test.pred>0.5]="1"
table(glm.test,raw.test$spam) 

ROCRpredTest = prediction(glm.pred, raw.test$spam)
# performance function
ROCRprefTest =  performance(ROCRpredTest, "tpr", "fpr")
plot(ROCRprefTest)
plot(ROCRprefTest, colorize=TRUE)
plot(ROCRprefTest, colorize=TRUE, print.cutoffs.at=seq(0,1,0.1),text.adj=c(-0.2,1.7))
auc<-performance(ROCRpredTest, "auc")@y.values
auc

