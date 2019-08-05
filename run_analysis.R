#########################
#
# Akhmad Nizhami
#
#########################

######################### 
#  Collecting Data
#########################

#Downloading dataset
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip","Dataset.zip", mode = "wb")

#unzipping dataset
unzip(zipfile = "Dataset.zip", exdir = "./data")

######################## 
# Step 1. 
########################

# Merges the training and the test sets to create one data set

# reading training data
train_x <- read.table("data/UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("data/UCI HAR Dataset/train/y_train.txt")
train_subject <- read.table("data/UCI HAR Dataset/train/subject_train.txt")

# reading test data
test_x <- read.table("data/UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("data/UCI HAR Dataset/test/y_test.txt")
test_subject <- read.table("data/UCI HAR Dataset/test/subject_test.txt")

# Reading feature vector
features <- read.table('data/UCI HAR Dataset/features.txt')

# Reading activity labels
activityLabels = read.table('data/UCI HAR Dataset/activity_labels.txt')

# Assigning column names
colnames(train_x) <- features[,2]
colnames(train_y) <-"activityId"
colnames(train_subject) <- "subjectId"

colnames(test_x) <- features[,2] 
colnames(test_y) <- "activityId"
colnames(test_subject) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

#Merge all data
train <- cbind(train_y, train_x, train_subject )
test <- cbind(test_y, test_x, test_subject )
merged_data <- rbind(train, test)

dim(merged_data)
#[1] 10299   563

#******************************************************************
#
#Step 2
#
#******************************************************************

#Extracts only the measurements on the mean and standard deviation for each measurement.

#Reading column names:
colNames <- colnames(merged_data)

colNames

#Create vector for defining ID, mean and standard deviation:
mean_std <- (grepl("activityId" , colNames) | 
                   grepl("subjectId" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)

mean_std

# 
Mean_Std_data <- merged_data[ , mean_std == TRUE]

Mean_Std_data

#******************************************************************
#
#Step 3. 
#
#******************************************************************

#Uses descriptive activity names to name the activities in the data set
ActivityNames <- merge(Mean_Std_data, activityLabels,by='activityId',all.x=TRUE)

#******************************************************************
#
#Step 4.
#
#******************************************************************

# Appropriately labels the data set with descriptive variable names.
# this has been achived 

#******************************************************************
#
#Step 5.
#
#******************************************************************

# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# this is to make a second tidy data set
secData <- aggregate(. ~subjectId + activityId, ActivityNames, mean)
secData <- secData[order(secData$subjectId, secData$activityId),]

# Writing second tidy data set in txt file
write.table(secData, "secTidySet.txt", row.name=FALSE)

