## coded 26th July 2014
##
## root1 variable has the path to directory from working directory that holds the data
root1 <-"./UCI HAR Dataset"
##
##final data sets are tidy_set and t_set
##working directory will have two csv created tidy_dataset.txt and t_dataset.txt
##
##-----------------------------------------------
## Load data from files to memory
##-----------------------------------------------
library(reshape2)
## Load y_train.txt
## train_y contains loaded values
fdata1 <- paste(root1 , "/train/y_train.txt",sep="")
train_y <- read.table(fdata1,header=FALSE)

## Load X_train.txt
## train_m contains the loaded values
fdata1 <- paste(root1 , "/train/X_train.txt",sep="")
train_m <- read.table(fdata1,header=FALSE)

## load subject_train.txt
## train_sub contains the loaded values
fdata1 <- paste(root1 , "/train/subject_train.txt",sep="")
train_sub <- read.table(fdata1,header=FALSE)

## load the activity labels data
## actl contains activity referece data
fdata1 <- paste(root1 , "/activity_labels.txt",sep="")
actl <- read.table(fdata1,header=FALSE)

## load the features labels
## featl contains features reference data
fdata1 <- paste(root1 , "/features.txt",sep="")
featl <- read.table(fdata1,header=FALSE)

## load y_test.txt
## test_y contains the loaded data
fdata1 <- paste(root1 , "/test/y_test.txt",sep="")
test_y <- read.table(fdata1,header=FALSE)

## load X_test.txt
## test_m contains the loaded data
fdata1 <- paste(root1 , "/test/X_test.txt",sep="")
test_m <- read.table(fdata1,header=FALSE)

## load subject_test.txt
## test_sub contains loaded data
fdata1 <- paste(root1 , "/test/subject_test.txt",sep="")
test_sub <- read.table(fdata1,header=FALSE)

## process train data to create a master with subject, X and y data combined
## add column labels also to train_m using features reference data
## and merge train_y and train_sub data to train_m to associate X data to
## subjectcode and activity code
## subjectCode and activityCode are the new columns appended to train_m
##
##add column labels
names(train_m) <- featl$V2

## append subjectcode 
train_m$subjectCode <- train_sub$V1

## append activitycode
train_m$activityCode <- train_y$V1

## process test data to create a master with subject, X and y data combined
## add column labels also to test_m using features reference data
## and merge test_y and test_sub data to test_m to associate X data to
## subjectcode and activity code
#### subjectCode and activityCode are the new columns appended to train_m

##add column labels
names(test_m) <- featl$V2

## append subjectcode 
test_m$subjectCode <- test_sub$V1

## append activitycode
test_m$activityCode <- test_y$V1

## merge tran and test data to create alldata
alldata <- rbind(test_m, train_m)

## identify the columns to subset from alldata
## assumption any column name containing mean or Mean or std are the required
## columns.....including subjectCode ad activityCode
cl1 <- names(alldata)
cl1 <- c(cl1[grep("mean",cl1)],cl1[grep("std",cl1)],cl1[grep("Mean",cl1)],"activityCode","subjectCode") 

## create a subset based on the columns in cl1 and store in t_set1
t_set1 <- subset(alldata, select=cl1)

## merge teh activity labels to the dataset to make it meaningful
t_set <- merge(t_set1, actl, by.x="activityCode", by.y="V1")

## rename the column V2 to more meaningful name
names(t_set)[names(t_set)=="V2"] <- "activityLabel"

## rearrange columns to be more meaningful with subject and activity in front
## create a list of column in right order
cl1 <- cl1[cl1 != "activityCode" & cl1 != "subjectCode" ]
cl1 <- c("subjectCode", "activityCode","activityLabel",cl1)
t_set <- t_set[c(cl1)]
t_set <- arrange(t_set,subjectCode,activityCode)
##
##
##t_set is the dataset as asked for the assignment
##
##
##
## 2nd data set creation that is tidy dataset average of each variable for each activity and each subject.
##
##
## select value columns
vars1 <- cl1[4:length(cl1)]
## melt the data set
t <- melt(t_set,id=c("subjectCode","activityCode","activityLabel"),measure.vars=c(vars1))
## cast it again to have average of each variable
tidy_set <-dcast(t,subjectCode + activityCode + activityLabel ~ variable, mean)
## rename the labels to reflect the correct names
aa <- names(tidy_set)
for(i in 4:length(aa)) aa[i] <- paste("avg_of_",aa[i],sep="")
names(tidy_set) <- aa


## save to file
fdata1 <- "./tidy_dataset.txt"
write.csv(fdata1,x=tidy_set,row.names = FALSE)
fdata1 <- "./t_dataset.txt"
write.csv(fdata1,x=t_set,row.names = FALSE)
