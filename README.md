READ ME: "Getting and Cleaning Data Course Project"

Preparations before running script:

1. First download data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

2. Unpack data in your working directory (in the subfolder "UCI HAR Dataset")

3. Start the run_analysis.R script

4. Before running the final lines in the script (5. Create a tidy independent data set with the average of each variable for each activity and each subject) you have to install the plyr package and run the library plyr to be able to use ddply. 


Description script:

- The script will first read all the datafiles from the UCI dataset. After reading the datasets to different variables.
- The column names are replaced by the the column names in features.txt and the activity labels in activity_labels.text.
- In the next step the script will use cbind and rbind to combine the training data and the testing data.
- To clean the data further the gsub function is used to make the column names more readable. 
- To make a tidy dataset the ddply function is used and the write.table function to write a new tidy dataset.