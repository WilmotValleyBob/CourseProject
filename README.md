# CourseProject
Central Repository for class project for the Get and Clean Data course @ Johns Hopkins University.
This course is part of the Data Science track and is available online via Coursera.

The structure of the CourseProject GitHub repository has this README.md file at the highest level.

Also at this level is the "R" directory that contains all R scripts required for the class project.

The "R" directory contains:

RawtoTidy.R     -   This script downloads the data files and unzips the files into local files.
                    This script must be run before run_analysis.R
                
run_analysis.R  -   This script does all of the analysis work required for the course project.
                    It depends on the RawtoTidy.R script being run to populate the expected input files.