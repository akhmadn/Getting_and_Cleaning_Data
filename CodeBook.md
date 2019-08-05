This code book describes the variables, the data, and any transformations

The run_analysis.R script performs: 

- Download the dataset
Dataset downloaded and extracted under the folder called UCI HAR Dataset

- Assign each data to variables
  features <- features.txt : 561 rows, 2 columns 
  activities <- activity_labels.txt : 6 rows, 2 columns 
  test_subject <- test/subject_test.txt : 2947 rows, 1 column 
  test_x <- X_test.txt : 2947 rows, 561 columns 
  test_y <- y_test.txt : 2947 rows, 1 columns 
  train_subject <- test/subject_train.txt : 7352 rows, 1 column 
  train_x <- test/X_train.txt : 7352 rows, 561 columns 
  train_y <- test/y_train.txt : 7352 rows, 1 columns 

Step 1
Merges the training and the test sets to create one data set
X (10299 rows, 561 columns) by merging train_x and test_y using rbind() function
Y (10299 rows, 1 column) by merging train_y and test_y using rbind() function
Subject (10299 rows, 1 column) by merging train_subject and test_subject using rbind() function
Merged_Data (10299 rows, 563 column) is created by merging Subject, Y and X using cbind() function

Step 2
Extracts only the measurements on the mean and standard deviation for each measurement
TidyData (10299 rows, 88 columns) columns: subject, code and column contains the measurements on the mean and standard deviation (std) for each measurement

Step 3
Uses descriptive activity names to name the activities in the data set
Entire numbers in code column of the TidyData replaced with corresponding activity taken from second column of the  activities variable

Step 4
Appropriately labels the data set with descriptive variable names
code column in TidyData renamed into activities
All Acc in column's name replaced by Accelerometer
All Gyro in column's name replaced by Gyroscope
All BodyBody in column's name replaced by Body
All Mag in column's name replaced by Magnitude
All start with character f in column's name replaced by Frequency
All start with character t in column's name replaced by Time

Step 5
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
FinalData (180 rows, 88 columns) is created by sumarizing TidyData taking the means of each variable for each activity and each subject, after groupped by subject and activity.
Export FinalData into FinalData.txt file.