Getting and Cleaning Data
=========================

This code is for Coursera course: Getting and Cleaning Data through Johns Hopkins University.

## Course Project
(find all project-related materials in the UCI HAR Dataset directory, however, copies of the important files have been put into this main directory to fulfil the submission requirement)

* Original data source from : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

* Choose your working directory 'setwd("path to your working directory")'

* Put run_analysis.R into your working directory

* load script into R 'source("run_analysis.R")'

* call  'tidy_data <- run_analysis()' script will automatically download zip file, unzip it 
and it will return data frame of tidy data. It is 180x68 because there are 30 subjects and 6 activities, thus "for each activity and each subject" means 30 * 6 = 180 rows.


Whole script works in tha way that it connects(rbind) data from train and test folders like

'X' : "UCI HAR Dataset/test/X_test.txt" and "UCI HAR Dataset/test/X_test.txt"

and in the same way data for 'Y', 'subject'

Other necessaty data are in features.txt and activity_labels.txt

From features.txt it will filter features with mean ot std in name by grep("-mean\\(\\)|-std\\(\\)", features[, 2])

then it will filer vatiables by this filter X <- X[, filtered_features]

and finally it will use this filter to set proper names to columns of X data frame 

names(X) <- features[filtered_features, 2]

names are then little improved by

remove '(' and ')' characters from names of X by: names(X) <- gsub("\\(|\\)", "", names(X))
put names to lower case and replace - to space by: names(X) <- gsub("-", " ", tolower(names(X)))

then script will use activities from activity_labels.txt

script will load them and improve them activities[, 2] = gsub("_", " ", tolower(as.character(activities[, 2])))

finally script apply these activity names to data frame Y by: Y[,1] = activities[Y[,1], 2] script will also rename Y's column as activity

script will name column of subject data frame as subject

and script connect these 3 data frames by cbind

##### tidy <- cbind(SUBJECT, Y, X)

####loads dplyr package which is mandatory for this analysis

library(dplyr)


and call result <- group_by(tidy,subject, activity) %>% summarise_each(funs(mean))

finaly script will write result to the file "data_set_with_the_mean_values.txt" and return result as data frame


