
# https://archive.ics.uci.edu/ml/datasets/Spambase
# https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/

file = "https://archive.ics.uci.edu/ml/machine-learning-databases/spambase/spambase.data"

raw.data <- read.csv(file, header=F)

name.var <- read.csv(file.choose())
names(name.var)[49]<- "char_freq_semic"    # char_freq_;
names(name.var)[50]<- "char_freq_openp"    # char_freq_(
names(name.var)[51]<- "char_freq_openb"    # char_freq_[
names(name.var)[52]<- "char_freq_excl"     # char_freq_!
names(name.var)[53]<- "char_freq_dollar"   # char_freq_$
names(name.var)[54]<- "char_freq_pound"    # char_freq_#

colnames(raw.data) <- colnames(name.var)
raw <- raw.data

attach(raw)

dim(raw)
head(raw)
tail(raw)
str(raw)


##### EDA
# Extracting data from columns - word_freq_our, word_freq_remove, word_freq_free, word_freq_hp, 
#word_freq_george, word_freq_edu, char_freq_excl, char_freq_dollar, capital_run_length_average, 
#capital_run_length_longest,spam
raw.sub <- raw[,c(5,7,16,25,27,46,52,53,55,56,58)]

#Removing capital_run_length_average and capital_run_length_longest from raw.sub
raw.freq <- raw.sub[,-c(9,10)]

# getting only capital_run_length_average, capital_run_length_longest and spam variables data
raw.val <- raw.sub[,c(9,10,11)]


library(lattice)
bwplot(spam~word_freq_our, data=raw.sub)
bwplot(spam~word_freq_remove, data=raw.sub)
bwplot(spam~word_freq_free, data=raw.sub)
bwplot(spam~word_freq_hp, data=raw.sub)
bwplot(spam~word_freq_george, data=raw.sub)
bwplot(spam~word_freq_edu, data=raw.sub)

library(reshape2)
# convert the column data into row data
freq.m <- melt(raw.freq,id.vars='spam')

# Box and whisker plot of all the eight varianbles from raw.freq
bwplot(value~spam |variable, data=freq.m, between=list(y=1), layout = c(2, 4))

# Density histogram of all the eight varianbles from raw.freq
histogram(~value|variable,type = "density", 
          data=freq.m,layout=c(2,4),
          panel=function(x,...){
            panel.histogram(x,...)
            panel.mathdensity(dmath=dnorm,col="red",
                              args=list(mean=mean(x),sd=sd(x)),...)}
)

# convert column data into rows.
freq.v <- melt(raw.val,id.vars='spam')
# box and whisker plot for capital_run_length_average and capital_run_length_longest against spam variable.

bwplot(value~spam |variable, data=freq.v, between=list(y=1), layout = c(1, 2) )

# Histogram with density for capital_run_length_average and capital_run_length_longest against spam variable.
histogram(~value|variable,type="density",
          data=freq.v,layout=c(1,2),
          panel=function(x,...){
            panel.histogram(x,...)
            panel.mathdensity(dmath=dnorm,col="red",
                              args=list(mean=mean(x),sd=sd(x)),...)})


