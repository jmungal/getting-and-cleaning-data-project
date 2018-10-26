# Getting and Cleaning Data Course Project

This GitHub Repository hosts my source code for the Getting and Cleaning Data course project. This is the third Course in the Coursera Data Science specialization track.

## Files

run_analysis.R - This is the main cleansing and analysis script. It takes the following actions, as prescribed in the course project instructions:

1) Downloads the RAW UCI HAR data set, and unzips it.
2) Merges the training and the test sets to create one data set.
3) Extracts only the measurements on the mean and standard deviation for each measurement.
4) Uses descriptive activity names to name the activities in the data set.
5) Appropriately labels the data set with descriptive variable names.
6) From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidy_data_set.txt - This is the second, independent tidy data set which is created by run_analysis.R.

CodeBook.md - A code book that describes the variables, the data, transformations and cleansing work performed.
