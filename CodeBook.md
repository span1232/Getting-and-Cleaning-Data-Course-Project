# CodeBook
Here describes the variables, the data, and any transformations or work performed to clean up the data from course.

## Independent variables
subject_number: Participants in study ranging from 1 to 30                      
movement_type: Six different movement type by participants (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)
Train_or_Test: Participants who were sampled into the Train or Test group  

## Dependent variables
Variables containing mean and std measurements in merged data were extracted
Variables were modified for clarity: t becomes time, f becomes Frequency, \\() were removed, std becomes Std, mean becomes Mean.

## Main datasets 
Train_and_Test_Data: Merged data from training and test sets
mean_and_std_data: Extracted variables contain mean and std measurements
tidy_data_set: The mean of each variable for each activity and each subject.
