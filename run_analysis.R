# Loading required packages
library(dplyr)

#Download dataset
filename <- "getdata_projectfiles_UCI HAR Dataset.zip"

# Checking if archieve already exists.
if (!file.exists(filename)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileURL, filename)
}  

# Checking if folder exists
if (!file.exists("UCI HAR Dataset")) { 
    unzip(filename) 
}

#Reading all data tables

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "activity")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "activity")

#1. Merging the training and the test sets to create one data set.
X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

#2. Extracting only the measurements on the mean and standard deviation for each measurement. 
TidyData_1 <- Merged_Data %>% select(subject, activity, contains("mean"), contains("std"))

#3. Using descriptive activity names to name the activities in the data set.
TidyData_1$activity <- activities[TidyData_1$activity, 2]

#4: Appropriately labelling the data set with descriptive variable names.
names(TidyData_1)<-gsub("Acc", "Accelerometer", names(TidyData_1))
names(TidyData_1)<-gsub("Gyro", "Gyroscope", names(TidyData_1))
names(TidyData_1)<-gsub("BodyBody", "Body", names(TidyData_1))
names(TidyData_1)<-gsub("Mag", "Magnitude", names(TidyData_1))
names(TidyData_1)<-gsub("^t", "Time", names(TidyData_1))
names(TidyData_1)<-gsub("^f", "Frequency", names(TidyData_1))
names(TidyData_1)<-gsub("tBody", "TimeBody", names(TidyData_1))
names(TidyData_1)<-gsub("-mean()", "Mean", names(TidyData_1), ignore.case = TRUE)
names(TidyData_1)<-gsub("-std()", "StandardDeviation", names(TidyData_1), ignore.case = TRUE)
names(TidyData_1)<-gsub("-freq()", "Frequency", names(TidyData_1), ignore.case = TRUE)
names(TidyData_1)<-gsub("angle", "Angle", names(TidyData_1))
names(TidyData_1)<-gsub("gravity", "Gravity", names(TidyData_1))

#5: From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject.
TidyData <- TidyData_1 %>% group_by(subject, activity) %>% summarise_all(mean)
write.table(TidyData, "TidyData.txt", row.names = FALSE)
