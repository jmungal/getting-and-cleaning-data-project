# Coursera - Getting and Cleaning Data - Course Project
# 10/23/2018 - written - Justin M
#
# Overview
# This project will read in raw data sets, merge them, extract only the data 
# we're interested in (mean and standard deviation), and then write this data to a 
# tidy dataset.


#####################################################################################################
## 1. Merge the training and the test sets to create one data set.
#####################################################################################################

## Download and unzip the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="Dataset.zip")
unzip(zipfile="Dataset.zip")

# Read in our dataset, and assign to appropriately named variables
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
features <- read.table('./UCI HAR Dataset/features.txt')
activity_labels = read.table('./UCI HAR Dataset/activity_labels.txt')

# Assign column names
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activity_id"
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activity_id"
colnames(subject_test) <- "subject_id"
colnames(subject_train) <- "subject_id"
colnames(activity_labels) <- c('activity_id','activity_type')

# Merge our data
train_merged <- cbind(y_train, subject_train, x_train)
test_merged <- cbind(y_test, subject_test, x_test)
all_merged <- rbind(train_merged, test_merged)

#####################################################################################################
## 2. Extract only the measurements on the mean and standard deviation for each measurement.
#####################################################################################################

col_names <- colnames(all_merged)
mean_and_std <- (grepl("activity_id",col_names) | grepl("subject_id",col_names) | grepl("mean..",col_names) | grepl("std..",col_names))
mean_and_std_data <- all_merged[,mean_and_std == TRUE]

#####################################################################################################
## 3. Use descriptive activity names to name the activities in the data set
#####################################################################################################

with_activity_names_data <- merge(mean_and_std_data, activity_labels, by='activity_id', all.x=TRUE)

#####################################################################################################
# 4. Create a second, independent tidy data set with the average of each variable for each 
#    activity and each subject.
#####################################################################################################

tidy_data_set <- aggregate(. ~subject_id + activity_id, with_activity_names_data, mean)
tidy_data_set <- tidy_data_set[order(tidy_data_set$subject_id, tidy_data_set$activity_id),]
write.table(tidy_data_set, "tidy_data_set.txt", row.name=FALSE)
