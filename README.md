### Introduction

This describes run_analysis.R program that creates datasets tidy_dataset.txt
and t_dataset.txt from data that is from 
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

the data sets are created based on the following rules
  - Merges the training and the test sets to create one data set.
  - Extracts only the measurements on the mean and standard deviation for each measurement. 
  - Uses descriptive activity names to name the activities in the data set
  - Appropriately labels the data set with descriptive variable names. 
  - Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Key to run the program


Download data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
extract the data to the R working directory it should create a folder of name 'UCI HAR Dataset' and all data should 
be underneath it.

Download run_analysis.R to your R working directory and run

Note:- you should have reshape2 package

After successfult run two TXT files in CSV format will be created with names
-tidy_dataset.txt
-t_dataset.txt
