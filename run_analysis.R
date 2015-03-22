# project Getting and Cleaning Data
# source("run_analysis.R")

run_analysis <- function() {

#0 get data
  
if(!file.exists("UCI HAR Dataset")){
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
  unzip(temp)
  unlink(temp)
} else {
  print("file already exists")
}
  
# 1. Merges the training and the test sets to create one data set.
  
#load and merge X
tmp1 <- read.table("UCI HAR Dataset/train/X_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/X_test.txt")
X <- rbind(tmp1, tmp2)

#load and merge SUBJECT
tmp1 <- read.table("UCI HAR Dataset/train/subject_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/subject_test.txt")
SUBJECT <- rbind(tmp1, tmp2)


#load and merge Y
tmp1 <- read.table("UCI HAR Dataset/train/y_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/y_test.txt")
Y <- rbind(tmp1, tmp2)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# load features
features <- read.table("UCI HAR Dataset/features.txt")
# filter features by mean and std
filtered_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

# filter 561 variables of X only to 66 interesting variables
X <- X[, filtered_features]

# set names for x columns by interesting features
names(X) <- features[filtered_features, 2]
# remove '(' and ')' characters from names of X
names(X) <- gsub("\\(|\\)", "", names(X))
# put names to lower case and replace - to space
names(X) <- gsub("-", " ", tolower(names(X)))

# 3. Uses descriptive activity names to name the activities in the data set.

# load activities labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
# replace _ to space and put activity names to lower case
activities[, 2] = gsub("_", " ", tolower(as.character(activities[, 2])))
# set name of column in Y as 'activity'
names(Y) <- "activity"
# replace values at Y by their label
Y[,1] = activities[Y[,1], 2]

# 4. Appropriately labels the data set with descriptive activity names.

# set name of columnt in SUBJECT as 'subject'
names(SUBJECT) <- "subject"
# create a new data frame as connection of subject, activity and data
tidy <- cbind(SUBJECT, Y, X)
# save this new data frame to a file'tidy_data.txt'
write.table(tidy, "tidy_data.txt", row.name=FALSE)

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

#loads dplyt package which is mandatory for this calculations
library(dplyr)
# create a new data frame resul by these steps:
# create grouprs subject and subgroups activity at tidy data frame
# put this dataframe to the function summarise_each which will call mean for each column
result <- group_by(tidy,subject, activity) %>% summarise_each(funs(mean))
# save this new data frame to a file'"data_set_with_the_mean_values.txt'

write.table(result, "data_set_with_the_mean_values.txt",row.name=FALSE)

# in case that that we would like to create dataFrame of means for each activity (merge subject) or each person (merge activity)
# the code would be like

#resultS <- group_by(tidy,subject) %>% summarise_each(funs(mean))
#30 obs. of 68 variables
#resultA <- group_by(tidy,activity) %>% summarise_each(funs(mean))
#6 obs. of 68 variables

result
}