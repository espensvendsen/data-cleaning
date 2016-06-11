# Code Book 
This program processes raw data originating from UCI HAR Dataset by
means of run_analysis.R. See also [README](README.md) for additional details.

## Raw data source 
* Original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
* Original description of dataset: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
In short, the data describes the measurements of sensor data fro smartphones, 
and attempts to classify them according to 6 activites (sitting, laying, etc.)

## Tidy output 
The output is stored in tidy_data.txt. 
It describes the average of every measurements for each activity and each subject.

| Column | Description |
|--------|-------------|
| Subject | Id of subject (sequence number)|
| Activity | Activity label |
| ...remaining columns | Each remaining column represents an average value of a measurement |

