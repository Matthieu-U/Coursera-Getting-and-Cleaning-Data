## Peer-graded Assignment: Getting and Cleaning Data Course Project

## 1. Merging the training and test data into one dataset
##
## First download data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## Unpack data in your working directory 

## Set working directory
setwd("C:/Users/muitten1/Desktop/coursera/UCI HAR Dataset")

## Reading general data 
features <- read.table("./features.txt",header=FALSE)

subjectsTraining <- read.table("./train/subject_train.txt", header=FALSE)
colnames(subjectsTraining) <- "sub_ID"

## Reading training data and assigning names
x_Train <- read.table("./train/X_train.txt", header=FALSE)

colnames(x_Train) <- features[,2] 

y_Train <- read.table("./train/Y_train.txt", header=FALSE)
colnames(y_Train) <- "activity_ID"

## Reading testdata and assigning to column names
subjectsTesting <- read.table("./test/subject_test.txt", header=FALSE)
colnames(subjectsTesting) <- "sub_ID"

x_Test <- read.table("./test/X_test.txt", header=FALSE)
colnames(x_Test) <- features[,2]

y_Test <- read.table("./test/y_test.txt", header=FALSE)
colnames(y_Test) <- "activity_ID"

## Merging training and test sets

trainingData <- cbind(y_Train,subjectsTraining,x_Train)
testingData <- cbind(y_Test,subjectsTesting,x_Test)

totalData <- rbind(trainingData, testingData)

##2. Extract only the measurements on the mean and standard deviation for each measurement

mean_std <- totalData[,grepl("mean|std",colnames(totalData))]


## 3.Using descriptive activity names for the activities in the dataset

activityLabels <- read.table("./activity_labels.txt",header=FALSE)

## assigning colnames
colnames(activityLabels)<-c("activity_ID","activity_Type")

## 4. Add labels to dataset with descriptive variable names

totalDatamerge <- merge(activityLabels, totalData, by = "activity_ID")
names(totalDatamerge) <- gsub("BodyBody", "Body", names(totalDatamerge))
names(totalDatamerge) <- gsub("Acc", "Accelerometer", names(totalDatamerge))
names(totalDatamerge) <- gsub("Gyro", "Gyroscope", names(totalDatamerge))
names(totalDatamerge) <- gsub("Mag", "Magnitude", names(totalDatamerge))
names(totalDatamerge) <- gsub("^t", "time", names(totalDatamerge))
names(totalDatamerge) <- gsub("^f", "frequency", names(totalDatamerge))


## 5. Create a tidy independent data set with the average of each variable for each activity and each subject
## for ddply you have to install the plyr library: 
## install.packages("plyr")
## library(plyr) 

tidyDataset<- ddply(totalDatamerge, c("sub_ID","activity_ID"), numcolwise(mean))
write.table(tidyDataset,file="tidydataset.txt")
