# Getting and Cleaning Data

## Cleaning data project

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Prerequisites
1. You have installed package reshape2. This program is tested with version ‘1.4.1’.
2. You have privileges to create a directory on your local machine.

## Instructions
Run run_analysis.R. It will do the following:
1. Create a local folder .\data and unzip the project data in folder "UCI HAR Dataset"
2. Process and clean data set 
3. Store the tidy result in .\data\tiny_data.txt
