# This script is for "Data Wrangling Excersize 2"
# 
library(dplyr)
setwd("/Users/sshrivastava/data_science/data_wrangling_exercise_2")
titanic_data <- read.csv("titanic_original.csv")
head(titanic_data)

# 1: embark column has missing values, which corresponds to passengers from Southampton. 
# Replace these missing values with S
titanic_data$embarked[titanic_data$embarked == ""] <- "S"

# 2: Fill the missing values in age column
# 2.1 Caluclate the mean of age column to populate those missing values
titanic_data$age[is.na(titanic_data$age)] <-mean(titanic_data$age,na.rm = TRUE)
# 2.2 Think about other ways to fill these missing values

# 3: Fill lifeboat missing values with None or NA


# If using titanic_data$boat[is.na(titanic_data$boa)] <- "None", gives the error "invalid factor level, NA generated"
# This error is because NA is not in the factor lavel. 
# By running
#str(titanic_data)
# you can see that the boat column is a factor and does not have "NA" as defined level.
# So first convert all the data in boat to character so you can add "None" as string.

titanic_data$boat <- as.character(titanic_data$boat)

# Convert <NA> into None.
titanic_data$boat[titanic_data$boat == ""] <- "None"

# Change back the type of boat to factor
titanic_data$boat <- as.factor(titanic_data$boat)

# 4:  Create a new column has_cabin_number which has 1 if there is a cabin number, and 0 otherwise.

titanic_data <- mutate(titanic_data, has_cabin_number = ifelse(titanic_data$cabin== "", 0, 1))

# 5: Write the data to titanic_clean.csv
write.csv(titanic_data, file="titanic_clean.csv")
