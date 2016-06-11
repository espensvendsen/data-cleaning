#run_analysis.R
#
# You should create one R script called run_analysis.R that does the following.
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.

# 0. Prerequisite. Download folder and load data into variables
if(!file.exists("./data")) {dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "Dataset.zip", method = "curl")
unzip("Dataset.zip")

testData.subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",header=FALSE)
testData.X <- read.table("./UCI HAR Dataset/test/X_test.txt",header=FALSE)
testData.y <- read.table("./UCI HAR Dataset/test/y_test.txt",header=FALSE)
trainData.subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",header=FALSE)
trainData.X <- read.table("./UCI HAR Dataset/train/X_train.txt",header=FALSE)
trainData.y <- read.table("./UCI HAR Dataset/train/y_train.txt",header=FALSE)
feature <- read.table("./UCI HAR Dataset/features.txt",header=FALSE)
label <- read.table("./UCI HAR Dataset/activity_labels.txt",header=FALSE)

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
data.subject <- rbind(testData.subject, trainData.subject)
colnames(data.subject) <- "subject"

data.y <- rbind(testData.y, trainData.y)
colnames(data.y) <- "y"

data.X <- rbind(testData.X, trainData.X)
colnames(feature) <- c("id", "name")
colnames(data.X) <- feature$name
colnamesSubset <- grepl("-mean\\(\\)|-std\\(\\)", colnames(data.X))
data.X <- data.X[, colnamesSubset]

data = cbind(data.subject, data.X, data.y)
remove(data.subject, data.X, data.y)

# 3. Uses descriptive activity names to name the activities in the data set
colnames(label) <- c("id", "activity")
data$activity <- sapply(data$y, function(x) { label[x, "activity"] })

# 4. Appropriately label the data set with descriptive variable names.
renameFeature <- function(col) {
    # Time dimension
    col <- gsub("tBody", "Time.Body.", col)
    col <- gsub("tGravity", "Time.Gravity.", col)
    
    # Frequency dimension
    col <- gsub("fBody", "Frequency.Body.", col)
    col <- gsub("fGravity", "Frequency.Gravity.", col)
    
    # Statistical attribute
    col <- gsub("-mean\\(\\)", ".Mean", col)
    col <- gsub("-std\\(\\)", ".Std", col)
    
    return(col)
}
colnames(data) <- renameFeature(colnames(data))

# 5. From the data set in step 4, creates a second, independent tidy data set with the average 
#    of each variable for each activity and each subject.
library(reshape2)
varNames <- grep("Mean|Std", colnames(data), value = T)
melted <- melt(data, id=c("subject", "activity"), measure.vars = varNames)
tidy <- dcast(melted, subject + activity ~ variable, mean)

write.table(tidy, file = "./data/tidy_data.txt", row.names = F)