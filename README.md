# Getting and Cleaning Data
## Contents
This repo contains the two files:
* run_analysis.R: The R script that creates a tidy data file from the source data and creates a .txt file as its final output.
* CodeBook.md: Describing the changes in variable and object made in the script
## Data Source
Data and documentation can be found in the [UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and downloaded through [this link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).
## Notes on R Script
The R Script downloads and unzips the data file if the file is non-existent in the current working directory, so a separate download is not necessary.
