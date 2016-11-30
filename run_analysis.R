#open data.table and dplyr
library(data.table)
library(dplyr)

#Downloading dataset if zip or folder does not exist working directory
if (!file.exists("UCI HAR Dataset.zip") | !file.exists("UCI HAR Dataset")){
    URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(URL, "./UCI HAR Dataset.zip")
}
#unzip file if folder does not exist in working directory
if (!file.exists("UCI HAR Dataset")){
    unzip(zipfile="UCI HAR Dataset.zip")
}

#Open data folder "UCI HAR Dataset"
setwd(paste0(getwd(),"/UCI HAR Dataset"))

#Retreive features and activity labels
 features <- data.table((read.table("features.txt", header = FALSE, stringsAsFactors = FALSE)))
 features <- features[[2]] 

activity_labels <- read.table("activity_labels.txt", header = FALSE)

#Go one directory down to "test" folder
setwd(paste0(getwd(),"/test"))

#Retrive test datasets from "y_test", "X_test" and "subject_test"
y_test <- data.table(read.table("y_test.txt", header = FALSE))
X_test <- data.table(read.table("X_test.txt", header = FALSE))
subject_test <- data.table(read.table("subject_test.txt", header = FALSE))

# name the variables of X_test using "features"
names(X_test) <- features

#return to "UCI HAR Dataset" directory
setwd('..')

#bind "subject_test", "y_test" and "X_test" together
X_test<-bind_cols(subject_test, y_test, X_test)

#rename column 1 and 2 as subject_test and movement_type 
colnames(X_test)[1] <- "subject_number"
colnames(X_test)[2] <- "movement_type"

#Go one directory down to "train" folder
setwd(paste0(getwd(),"/train"))

#Retrive train datasets from "y_train", "X_train" and "subject_train"
y_train <- data.table(read.table("y_train.txt", header = FALSE))
X_train <- data.table(read.table("X_train.txt", header = FALSE))
subject_train <- data.table(read.table("subject_train.txt", header = FALSE))

# name the variables of X_train using "features"
names(X_train) <- features

#bind "subject_train", "y_train" and "X_train" together
X_train<-bind_cols(subject_train, y_train, X_train)

#rename column 1 and 2 as subject_test and movement_type 
colnames(X_train)[1] <- "subject_number"
colnames(X_train)[2] <- "movement_type"

#create a train vector, convert to data.table and bind to X_train
X_train <- rep("train", each=nrow(X_train)) %>% 
    data.table() %>% 
    bind_cols(X_train)

#name new column as Train_or_Test     
colnames(X_train)[1] <- "Train_or_Test"

#create a test vector, convert to data.table and bind to X_test
X_test <- rep("test", each=nrow(X_test)) %>% 
    data.table() %>% 
    bind_cols(X_test)

#name new column as Train_or_Test     
colnames(X_test)[1] <- "Train_or_Test"

#combine training and test sets by row binding
Train_and_Test_Data <- union(X_train, X_test) 

#set Train_or_Test, movement_type and subject_number column to factor
Train_and_Test_Data$Train_or_Test <- as.factor(Train_and_Test_Data$Train_or_Test) 
Train_and_Test_Data$movement_type <- factor(Train_and_Test_Data$movement_type, levels = activity_labels[,1], labels = activity_labels[,2])
Train_and_Test_Data$subject_number <- as.factor(Train_and_Test_Data$subject_number) 

#remove duplicated columns
Train_and_Test_Data <- Train_and_Test_Data[,unique(names(Train_and_Test_Data)),with=FALSE]

#create vector with permutaion of names containing "mean" and "std
mean_variations <- c("mean", "Mean", "MEAN")
col_with_word_mean <- which(grepl(paste(mean_variations, collapse = "|"), names(Train_and_Test_Data)))

std_variations <- c("std", "Std", "STD")
col_with_word_std <- which(grepl(paste(std_variations, collapse = "|"), names(Train_and_Test_Data)))

#Edit labels to descriptive variable names.
names(Train_and_Test_Data) <- gsub("^t", "time", names(finalData))
names(Train_and_Test_Data) <- gsub("^f", "Frequency", names(Train_and_Test_Data))
names(Train_and_Test_Data) <- gsub("\\()", "", names(Train_and_Test_Data))
names(Train_and_Test_Data) <- gsub("-std", "Std", names(Train_and_Test_Data))
names(Train_and_Test_Data) <- gsub("-mean", "Mean", names(Train_and_Test_Data))

#mean and std columns extracted with 1) "Train_or_Test", 2) "subject number" and 3) "movement type"
mean_and_std_data <- select(Train_and_Test_Data, c(1 ,2, 3 ,sort(c(col_with_word_mean, col_with_word_std))))

#tidy data set with the average of each variable for each activity and each subject
tidy_data_set<-mean_and_std_data %>%
group_by(subject_number, movement_type, Train_or_Test) %>%
summarise_each(funs(mean))

#Return back to initial working directory
setwd('..');setwd('..')