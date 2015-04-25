#
#
# Getting and Cleaning Data Class project
#

#
# Download and Unzip Datafiles
#

#    Create one R script called run_analysis.R that does the following. 

# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.
#
#   Set wworking directory
#

setwd = ("D:/Users/Bob/Bobs Courses/DataScience files//RStdio ProjectsGandCProject/Data")

#
#   Download data set zip file
#

fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="DataSet.zip")
downloaddate = date()

#
#   Extract data files from .zip file
#
unzip("./DataSet.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE)
