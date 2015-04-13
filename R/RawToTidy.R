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
