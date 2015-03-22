Course Project Code Book
========================

Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The attached R script (run_analysis.R) performs the following to clean up the data:

* Merges the training and test sets to create one data set, train/X_train.txt with test/X_test.txt, train/subject_train.txt with test/subject_test.txt, and train/y_train.txt with test/y_test.txt.

* Reads features.txt and use only features with the mean and standard deviation

* Use this features to filter X. The result is a 10299x66 data frame (original was 10299x561).

* Reads activity_labels.txt (put them to lower case and replace _ with space)and applies descriptive activity names to name the activities in the data set:

        walking
        
        walking upstairs
        
        walking downstairs
        
        sitting
        
        standing
        
        laying

* The script also appropriately labels the data set with descriptive names: all feature names (attributes) and activity names are converted to lower case, 
hyphens are replaced with spaces and brackets () are removed. Then it merges the 10299x66 data frame containing features with 10299x1 data frames containing 
activity labels and subject IDs. The result is saved as tidy_data.txt, a 10299x68 data frame such that the first column contains subject IDs, 
the second column activity names, and the last 66 columns are measurements. 

* Subject IDs are integers between 1 and 30 inclusive. 

* Activity is enumeration of following

        walking
        
        walking upstairs
        
        walking downstairs
        
        sitting
        
        standing
        
        laying


* The names of the attributes are similar to the following:

        tbodyacc mean x 
        
        tbodyacc mean y 
        
        tbodyacc mean z 
        
        tbodyacc std x 
        
        tbodyacc std y 
        
        tbodyacc std z 
        
		... (66 attributes)

* Finally, the script creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

For this 2nd tidy data set is used dplyr package with the following code 'result <- group_by(tidy,subject, activity) %>% summarise_each(funs(mean))'
which will save a new dataset to the result variable, data set will be created by calculating mean of each column for every subgroup 'activity' of a group 'subject'.

The result is saved as 'data_set_with_the_mean_values.txt', it is a data frame 180x68, where as before, the first column contains subject IDs, 
the second column contains activity names , and then the averages for each of the 66 attributes.
There are 30 subjects and 6 activities, thus 180 rows in this data set with averages.
