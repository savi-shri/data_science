library("ggplot2")
setwd("/Users/sshrivastava/data_science/")
data_r <- read.csv("failed_exons_by_case.csv")
#gather(table4, "year", "cases", 2:3)
new<-gather(data_r,"X50x","X100x","X200x","X400x", 2:5)
m<-tapply(new$Exon_number, new$Depth, mean)
colnames(new)[3]<-"Exon_number"
colnames(new)[2]<-"Depth"
ggplot(new, aes(x=Depth, y=Exon_number, fill=Depth)) +
  geom_dotplot(binaxis='y', stackdir='center') +
 theme_classic() +
  #geom_point(position="jitter") +
stat_summary(geom = "errorbar",fun.data = c(y=m,ymin=0))

library(ggplot2)
#m<-aggregate(new[3], list(new$Depth), mean)
m<-mean(new,list(new$Depth))
ggplot(data = new) +
  geom_dotplot(aes(y = Exon_number, x = Depth, fill = Depth),
               binaxis = "y",         # which axis to bin along
                   # Minimal difference considered diffeerent
               stackdir = "center"    # Centered
  )

ggplot(new, aes(x = Depth,y=y)) +
  stat_summary(fun.y = "mean", geom = "point")