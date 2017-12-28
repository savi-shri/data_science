
# Data Story

# Read the spambase data from https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.data 
file = "https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.data"

raw.data <- read.csv(file, header=F)

# Read attributes (Spam names) from the file "Spam names.csv" located at local. 
# Download the "Spam names.csv" file from "https://github.com/savi-shri/data_science/blob/master/CapstoneProject/Spam names.csv"

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
# Find out the observations and variable in the data
dim(raw)

head(raw)
tail(raw)

# Find out the data type in the data
str(raw)


# Find out if there are missing values
na.count.all <- data.frame(sapply(raw, function(y) sum(length(which(is.na(y))))))
sum(is.na(raw))

# Outcome variable statistics
raw$spam <- as.factor(raw$spam)
summary(raw$spam)
