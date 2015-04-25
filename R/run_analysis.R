#
#
# Getting and Cleaning Data Class project
#

#
# run_analysis.R
#

#    Create one R script called run_analysis.R that does the following. 

# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names. 
# 5) From the data set in step 4, creates a second, independent tidy data set
#    with the average of each variable for each activity and each subject.

#
#   This script was preceded by DownloadAndUnzip.R
#   DownloadAndUnzip.R downloded the zipped test and training files
#                       and then unzipped the files into their respective directories
#

#
#   Set Working Directory 
#

setwd("D:/Users/Bob/Bobs Courses/DataScience files/RStdio Projects/GandCProject")

#
#   Load libraries
#
library(dplyr)

#
#   Read in the data and restrucure as required for the class project
#

#
#   The headings for the test and training data are common
#

Features561 = read.table("data/UCI HAR Dataset/features.txt")

#
#   Read in the six different activity codes and their associated names
#       and then place heading names on the two columns
#


Activity_Labels = read.table("data/UCI HAR Dataset/activity_labels.txt")

colnames(Activity_Labels) = c("Activity_Code","Activity_Name")

#
#   Test Data - Read in the Test Data and restructure it
#


#       Test    Read in the data with the person ID (subject) for each of the tests
#               and then place a heading at the top of the column
#

Subject_Test = read.table("Data/UCI HAR Dataset/test/subject_test.txt")
colnames(Subject_Test) = ("Person_ID")

#       Test    Read in the data with the activity codes for each of the tests
#               and then place a heading at the top of the column
#

ActivityCodeY_Test = read.table("Data/UCI HAR Dataset/test/y_test.txt")
colnames(ActivityCodeY_Test) = ("Activity_Code")

#
#       Test    Read in the measured and calculated results
#               and then place headings on each of the 561 columns
#

Readings_TestX = read.table("Data/UCI HAR Dataset/test/x_test.txt")
colnames(Readings_TestX) = Features561[,2]

#
#       Test    Combine the three tables containg test data
#               adding additional columns to the data frame
#

Merged_Test = cbind(Readings_TestX,Subject_Test,ActivityCodeY_Test)


#
#   Read in the Training Data and restructure it
#

#
#       Train   Read in the data with the person ID (subject) for each of the tests
#               and then place a heading at the top of the column
#
Subject_Train = read.table("Data/UCI HAR Dataset/train/subject_train.txt")
colnames(Subject_Train) = ("Person_ID")

#
#       Train   Read in the data with the activity codes for each of the tests
#               and then place a heading at the top of the column
#


ActivityCodeY_Train = read.table("Data/UCI HAR Dataset/train/y_train.txt")
colnames(ActivityCodeY_Train) = ("Activity_Code")


#
#       Train   Read in the measured and calculated results
#               and then place headings on each of the 561 columns
#


Readings_TrainX = read.table("Data/UCI HAR Dataset/train/x_train.txt")
colnames(Readings_TrainX) = Features561[,2]


#
#       Train   Combine the three tables containg test data
#               adding additional columns to the data frame
#

Merged_Train = cbind(Readings_TrainX,Subject_Train,ActivityCodeY_Train)

#
#       Combine the test and training data
#       by adding the training data in the rows below the test data

Merged_DataSet = rbind(Merged_Test,Merged_Train)

#
#       Extract the data columns that have "mean" values in them
#

Mean_of_Merged = Merged_DataSet[,grep("mean",names(Merged_DataSet))]


#
#       Extract the data columns that have "standard deviation (std)" values in them
#

Std_of_Merged = Merged_DataSet[,grep("std",names(Merged_DataSet))]

#
#       Combine the extracted "mean" and "std" data frames into one
#           and add the Person_ID and Activity_Code tables as
#           the last two columns of data
#

Std_and_Mean_of_Merged_DataSet = cbind(Std_of_Merged,Mean_of_Merged,Merged_DataSet$Person_ID,Merged_DataSet$Activity_Code)

#
#       Rename the Person_ID and Activity_Code columns so they are more legible
#

names(Std_and_Mean_of_Merged_DataSet)[names(Std_and_Mean_of_Merged_DataSet)=="Merged_DataSet$Person_ID"] <- "Person_ID"
names(Std_and_Mean_of_Merged_DataSet)[names(Std_and_Mean_of_Merged_DataSet)=="Merged_DataSet$Activity_Code"] <- "Activity_Code"

#
#   rename(Std_and_Mean_of_Merged_DataSet,Person_ID = Std_and_Mean_of_Merged_DataSet,
#                                         Activty_Code = Merged_DataSet$Activity_Code)
#

#
#      Add a column to the data frame for the name of each activity rather than just the code
#


# Std_and_Mean_of_Merged_DataSet[, "Activity_Name"] <- "xxx"
mutate(Std_and_Mean_of_Merged_DataSet,Activity_Name = "xxx")

#
#       Fill the new column with the names associated with the Activity_Code for each observation(row)
#               had to use "as.character" to coerce value from factor to character values
#

i=0
while (i< (nrow(Std_and_Mean_of_Merged_DataSet))){
    i = i + 1;
    Std_and_Mean_of_Merged_DataSet$Activity_Name[i] = as.character(Activity_Labels[Std_and_Mean_of_Merged_DataSet$Activity_Code[i],2]);
}

#
#   Now that the activities are named, drop the column with Activty_Code
#   This will make calculating the average of each column in the tidy data set later on.
#   Also simplify column names by removing"()" bracket pair across all columns
#

Std_and_Mean_of_Merged_DataSet <- subset( Std_and_Mean_of_Merged_DataSet, select = -Activity_Code )
# Across all columns, replace all instances of "t" with "X"
names(Std_and_Mean_of_Merged_DataSet) <- gsub("\\(\\)", "", names(Std_and_Mean_of_Merged_DataSet))

#
#   Sort merged dataset into ascending order by Person_ID and Activity_Name
#   in order to obtain average for each measurement for each person. 
#   Apply the means() function to each varaiable
#   (note: the variables used to group the results are not included in the calculation)
#
    
Tidy_Dataset = group_by(Std_and_Mean_of_Merged_DataSet,Person_ID,Activity_Name) %>% summarise_each(funs(mean))

#
# Edit the column names.Replace all instances of "()" with "" (aka, delete the bracket pair)
#

names(Tidy_Dataset) <- gsub("\\(\\)", "", names(Tidy_Dataset))

#
# Using the round function to make the file output a little more legible
#

Tidy_Dataset[,-2] =round(Tidy_Dataset[,-2],digits=3) #the "-2" excludes column 1 and 2

#
# write the Tidy_Datset to a file
#

write.table (Tidy_Dataset,file = "data/Tidy_Dataset.txt",row.names=FALSE,eol="\r\n",sep="\t")