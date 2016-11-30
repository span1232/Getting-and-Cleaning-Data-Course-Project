## CodeBook
Here describes the variables, the data, and any transformations or work performed to clean up the data from course.

## Independent variables
1) subject_number: Participants in study ranging from 1 to 30                      

2) movement_type: Six different movement type by participants (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)

3) Train_or_Test: Participants who were sampled into the Train or Test group  

## Dependent variables
1) Variables containing mean and std measurements in merged data were extracted

2) Variables were modified for clarity: t becomes time, f becomes Frequency, \\() were removed, std becomes Std, mean becomes Mean.

## Main datasets 
1) Train_and_Test_Data: Merged data from training and test sets

2) mean_and_std_data: Extracted variables contain mean and std measurements

3) tidy_data_set: The mean of each variable for each activity and each subject.
