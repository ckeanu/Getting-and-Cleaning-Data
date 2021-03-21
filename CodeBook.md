Code Book
==========

## Downloading and Reading Files into R 
The code checks if data files are present in current working directory and unzips the file. Otherwise, it downloads and unzips the file.
Afterwards, it reads the data into R with the following names for each dataframe:
* activity_labels: activity ID descriptions for y_test and y_train
* features: labels for each variable in x_test and x_train
* x_test: values of variables in test 
* y_test: activity ID in test
* subject_test: subject ID in test
* x_train: values of variables in train
* y_train: activity ID in train
* subject_train: subject ID in train

## Question 1. Merging Data
* x_merged: row bind of x_train and x_test
* y_merged: row bind of y_train and y_test
* subject_merged: row bind of subject_train and subject_test
* data_merged: column bind of x_merged, y_merged, and subject_merged

## Question 2. Extracting mean() and std()
* selected: measurement names containing mean() and std()
* meanstd: vector of variable names containing _selected_ and the subject and activity variables
* data_tidy: data set with only mean(), std(), subject, and activity variables

## Question 3. Creating Activity Names
No new objects created, no variables renamed.

## Question 4. Creating Descriptive Variable Names
* All variables starting with t renamed to start with Time
* All variables starting with f renamed to start with Frequency
* All variables containing Acc renamed to contain Accelerometer
* All variables containing Gyro renamed to contain Gyroscope
* All variables containing BodyBody renamed to contain Body
* All variables containing Mag renamed to contain Magnitude
* All "-" symbols in variable names replaced with "."

## Question 5. New Summary Dataset and Final Output
* data_final: data_tidy is grouped by subject and activity, and then summarised by mean
* FinalDataCleaningOutput.txt: exported version of data_final in a .txt format
