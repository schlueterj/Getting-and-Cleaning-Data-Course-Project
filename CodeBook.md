# Code Book
The R script called run_analysis.R does the following. 

Download the dataset:
        Dataset downloaded and extracted under the folder called "UCI HAR Dataset""

Assign each data to variables:

        activities <- activity_labels.txt (6 obs. of 2 variables): Links the class labels with their activity name 
        features <- features.txt (561 obs. of 2 variables): List of all features, for details "features_info.txt"
        subject_test <- test/subject_test.txt (2947 obs. of 1 variable): Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
        x_test <- test/X_test.txt (2947 obs. of 561 variables): Training set
        y_test <- test/y_test.txt (2947 obs. of 1 variable): Training labels
        subject_train <- test/subject_train.txt (7352 obs. of 1 variable): Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
        x_train <- test/X_train.txt (7352 obs. of 561 variables): Test set
        y_train <- test/y_train.txt (7352 obs. of 1 variable): Test labels

5 Steps:

1. Merge the training and the test sets to create one data set:

        X (10299 obs. of 561 variables) is created by merging x_train and x_test using rbind() function
        Y (10299 obs. of 1 variable)is created by merging y_train and y_test using rbind() 
        Subject (10299 ob.s of 1 variable) created by merging subject_train and subject_test using rbind() function
        Merged_Data (10299 obs. of 563 variables) is created by merging Subject, Y and X using cbind() function

2. Extracting only the measurements on the mean and standard deviation for each measurement:

TidyData_1 (10299 obs. of 88 variables) is created by subsetting Merged_Data, selecting only columns: subject, code and the measurements on the mean and standard deviation (std) for each measurement

3. Use descriptive activity names to name the activities in the data set:

Entire numbers in code column of TidyData_1 replaced with corresponding activity taken from second column of the activities variable

4. Appropriately label the data set with descriptive variable names:

        All Acc in column’s name replaced by Accelerometer
        All Gyro in column’s name replaced by Gyroscope
        All BodyBody in column’s name replaced by Body
        All Mag in column’s name replaced by Magnitude
        All start with character f in column’s name replaced by Frequency
        All start with character t in column’s name replaced by Time

5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

TidyData (180 obs. of 88 variables) is created by summarizing TidyData_1 taking the means of each variable for each activity and each subject, after groupped by subject and activity.

Export TidyData into TidyData.txt file.

