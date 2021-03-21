#Load required packages
library(dplyr)
library(data.table)
library(reshape2)

#Download and unzip data into working directory
datafile <- "datafiles.zip"
if (!file.exists(datafile)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url, file.path(getwd(), "datafiles.zip"))
  unzip(datafile)
}  else{
  unzip(datafile)
}

#Read the data files into R
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
features <- read.table("UCI HAR Dataset/features.txt")  
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")


#Data tidying and analysis
##Question 1: Merge the training and the test sets to create one data set.
#a. Merge training and test data together
x_merged <- rbind(x_train, x_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)
#b. Rename variable names
names(subject_merged)<- c("subject")
names(y_merged) <- c("activity")
names(x_merged) <- features$V2
#c. Merge all columns together
data_merged <- cbind(x_merged, y_merged, subject_merged)


##Question 2: Extract only the measurements on the mean and standard deviation for each measurement
#a. Select measurement names containing mean() and std()
selected <- features$V2[grepl("mean\\(\\)|std\\(\\)", features$V2)]
#b. Create a vector of variable names for selected names and the subject and activity variables
meanstd <- c(as.character(selected), "subject", "activity" )
#c. Subset the data to extract only the required measurements
data_tidy <- subset(data_merged,select=meanstd)


##Question 3: Uses descriptive activity names to name the activities in the data set
#a. Convert the entries into character format so it can accept renaming
data_tidy$activity <- as.character(data_tidy$activity)
#b. Loop the entry renaming
for (i in 1:6){
  data_tidy$activity[data_tidy$activity == i] <- as.character(activity_labels[i,2])
}
#c. Convert the entries into a factor format
data_tidy$activity <- as.factor(data_tidy$activity)


##Question 4: Appropriately label the data set with descriptive variable names
names(data_tidy)<-gsub("^t", "Time", names(data_tidy))
names(data_tidy)<-gsub("^f", "Frequency", names(data_tidy))
names(data_tidy)<-gsub("Acc", "Accelerometer", names(data_tidy))
names(data_tidy)<-gsub("Gyro", "Gyroscope", names(data_tidy))
names(data_tidy)<-gsub("BodyBody", "Body", names(data_tidy))
names(data_tidy)<-gsub("Mag", "Magnitude", names(data_tidy))
names(data_tidy)<-gsub("-", "\\.", names(data_tidy))


##Question 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.
#a. Create the final data set
data_final <- data_tidy %>%
              group_by(subject, activity) %>%
              summarise_all(funs(mean))
#b. Export data into .txt file for submission
write.table(data_final, "FinalDataCleaningOutput.txt", row.name=FALSE)
