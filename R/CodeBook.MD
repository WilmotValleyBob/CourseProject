---
title: "CodeBook for run_analysis.R script"
author: "Wilmot Valley Bob"
date: "Saturday, April 25, 2015"
output: html_document
---

This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

When you click the **Knit** button a document will be generated that includes both content as well as the output of any embedded R code chunks within the document. You can embed an R code chunk like this:

```{r}
summary(cars)
```

You can also embed plots, for example:

```{r, echo=FALSE}
plot(cars)
```

Note that the `echo = FALSE` parameter was added to the code chunk to prevent printing of the R code that generated the plot.


This CodeBook is for the class project that is a part of the requirement for the "Getting and "Cleaning Data Course" 

This file contains a description of the steps undertaken to transform the data from its original state and turn it into the required Tidy Dataset required.

As noted in the README.md file, this script must be preceed by the execution of the DownLoadandUnzip.R script that downloads,unzips, and populated the input files for the run_analysis.R script.

DATA INFORMATION
================


    The host site for the data is:
    
        http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
    
    
    
    The data for the runa_analysis.R script is located at:
        https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
        
        
    The run_analysis.R script performs the following steps to clean the data:
    
  
    



   The headings for the test and training data are common. The "features.txt" file
   is read into the Features561 variable. 561 was chosen as part of the name s there are 
   561 data items.

    The text labels for each of the activities are alos common across the test and training datasets.
    The "activity_labels.txt file" is read into the "Activity_Labels" dataframe and column names are added
    to identify the column s containing "Activity_Code" and ""Activity_Name"



Next the test data is read in and restructured.
    
    The test data is spread out over three files. Each of the three .txt files is
    read into a corresponding data frame and then column names are attached to 
    each data frame.

    subject_test.txt is read into Subject_Test and the "Person_ID" label is affixed.
    y_test.txt is read into ActivityCodeY_Test and the "activity Code" label is affiexed
    x_test.txt is read into the Readings_TestX data frame and the labels stored in Features561 are affixed
    
    The three test data structured are combined into the Merged_Test data frame
    


The training data has an identical structure and file distribution
so thetraining data is read in and restructured.
    
    The training data is spread out over three files. Each of the three .txt files is
    read into a corresponding data frame and then column names are attached to 
    each data frame.

    subject_train.txt is read into Subject_Train and the "Person_ID" label is affixed.
    y_train.txt is read into ActivityCodeY_Train and the "activity Code" label is affiexed
    x_train.txt is read into the Readings_TrainX data frame and the labels stored in Features561 are affixed
    
    The three test data structured are then combined into the Merged_Train data frame
    
Now the restructured test and training data are combined into one data frame, "Merged_Dataset" 

Only the columns containing data relative to""mean" and "standard deviation" are required.
Columns with mean values are extracted into the Mean_of_Merged data frame
Columns with standard deviation values are extracted into the Std_of_Merged data frame

The Mean_of_Merged and Std_of_Merged are then combined into a single data frame, Std_and_Mean_of Merged
and Person_ID and Activity_Code data items are attached via the "cbind" function. The resultant data frame is Std_and_Mean_of_Merged_Dataset.

The "Person_ID" and "Activity_COde" headings are cleaned up to be more legible.

The mutate() function is used to add a column name to contain the "Activity_Name". This column is then populated
with the data  that was stored in the Activity_Labels data frame

Now that the activities have been named, the "Activity_Code" column can be removed. This is not 
absolutely necessary, but it will make the calulation for the "mean" of every variable more straight forward.

Next, take the time to simplify the column headings by removing unnecessary "()" brackets

Now we cann sort the Std_and_Mean_of_Merged_Dataset so the the rows are arranged by Activity_Name within Person_ID
sequence. At the same time we calculate the mean of all numeric columns. Only the first two columns; Person_ID and
ctivity_Name are excluded from the calculation.

While it was not required as part of the project, I opted to round all the mean valued to three digits just to make the reading of the "Tidy_Dataset" easier.

Finally the "Tidy_Dataset" was written to the "Tidy_Dataset.txt"  file
    


