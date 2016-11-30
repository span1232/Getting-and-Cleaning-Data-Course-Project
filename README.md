##README

Main steps
1) Downloads, unzips dataset if zip or folder does not exist working directory

2) Automatically retreives all files into data.table

3) Renames training and test sets with feature file

4) Combines (subject_number, movement_type and Train_or_Test) columns to X_test and X_train respectively

5) Merge X_test and X_train 

6) Edit labels to descriptive variable names.

7) Extract dependent variables containing mean and std calculations 

8) Performs tidy data set with the average of each variable for each activity and each subject

9) Returns to initial working directory
