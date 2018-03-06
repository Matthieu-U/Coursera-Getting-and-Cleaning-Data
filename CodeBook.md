---
title: "Code Book: Getting and Cleaning Data Course Project"
---

Description variables used:
- 'features': used to store all the features from 'features.txt'

- 'subjectsTraining': used to store all the subjects from 'subject_train.txt'

- 'x_Train' : used to store all the trainingdata (Training sets) from 'X_train.txt'

- 'y_Train' : used to store all the trainingdata (Training labels) from 'Y_train.txt'

- 'subjectsTesting': used to store all the subject from 'subject_test.txt'

- 'x_Test' : used to store all the testdata (Test sets) from 'X_test.txt'

- 'y_Test' : used to store all the testdata (Test labels) from 'y_test.txt'

- 'trainingData' : used to store the combined dataframe from the training variables : 'y_Train', 'subjectTraining' and    'x_Train'

- 'testingData' : used to store the combined dataframe from the test variables : 'y_Test', 'subjectTesting', 'x_Test'

- 'totalData' : used to store the combined dataframe from the variables 'trainingData' and 'totalData'

- 'mean_std' : used to store a dataframe with only the mean and standarddeviation from 'totalData'

- 'activityLabels' : used to store all the activities from 'activity_labels.txt'

- 'totalDatamerge' : used to store a combined dataframe from 'totalData' and 'activityLabel'

- 'tidyDataset' : used to store the tida dataset with the average of each variable for each activity and each subject 


Transformations performed to clean up data:
- colnames(subjectsTraining) <- "sub_ID" to replace column name 'V1' with 'sub_ID'

- colnames(x_Train) <- features[,2] to replace 561 column names (VXXX) with the second column of the dataframe 'features'

- colnames(y_Train) <- "activity_ID" to replace column name 'v1' with 'activity_ID'

- colnames(subjectsTesting) <- "sub_ID" to replace column name 'v1'with 'sub_UD'

- colnames(x_Test) <- features[,2] to replace 561 column names (vxxx) with the second column of the dataframe 'features'

- colnames(y_Test) <- "activity_ID" to replace column name 'v1 with 'activity_ID'
 
- trainingData <- cbind(y_Train,subjectTraining,x_Train) to combine the trainingdata 

- testingData <- cbind(y_Test,subjectTesting,x_Test) to combine the testingdata

- totalData <- rbind(trainingData, testingData) to combine the trainingdata and testingdata

- mean_std <- totalData[,grepl("mean|std",colnames(totalData))] to extracts only the measurements on the mean and standard deviation for each measurement

- colnames(activityLabels)<-c("activity_ID","activity_Type") to change the column names V1 and v2 to 'activity_ID' and 'activity_Type

- totalDatamerge <- merge(activityLabels, totalData, by = "activity_ID") to add the activity labels to totalData

- names(totalDatamerge) <- gsub("BodyBody", "Body", names(totalDatamerge))
  names(totalDatamerge) <- gsub("Acc", "Accelerometer", names(totalDatamerge))
  names(totalDatamerge) <- gsub("Gyro", "Gyroscope", names(totalDatamerge))
  names(totalDatamerge) <- gsub("Mag", "Magnitude", names(totalDatamerge))
  names(totalDatamerge) <- gsub("^t", "time", names(totalDatamerge))
  names(totalDatamerge) <- gsub("^f", "frequency", names(totalDatamerge))
 
  To make the column names better readable (using full names instead of short names) 

- tidyDataset<- ddply(totalDatamerge, c("sub_ID","activity_ID"), numcolwise(mean))
  To create an independent tidy data set with the average of each variable for each activity and each subject

- write.table(tidydataset,file="tidydataset.txt")
  To write the tidyDataset to "tidydataset.txt"
