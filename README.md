Human Activity Data Preparation Project

Overview

To prepare tidy human activity data we downloaded from "The UCI Machine Learning Repository" for subsequent analysis.


Project Summary

The R script "run_analysis.R" prepared for
1.	Merges the training and the test sets to create one data set.
2.	Extracts only the measurements on the mean and standard deviation for each measurement. 
3.	Uses descriptive activity names to name the activities in the data set
4.	Appropriately labels the data set with descriptive variable names. 
5.	Creates and independent tidy data set with the average of each variable for each activity and each subject based on the data set at point 4.

Script Running Steps

1.	Download the human activity data from Repository and unzip the data.
2.	In the "run_analysis.R" script file, change line 3 to the folder of the unzipped data
3.	Run the script file, you will find a "final_data.txt" generated under the folder you setup at step 2.
Additional Information
Please refer to file "CodeBook.MD" for additional information about the variables, data and transformations.


