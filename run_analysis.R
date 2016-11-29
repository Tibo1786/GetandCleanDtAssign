library(dplyr)
library(reshape2)

## Step 1 Merges the training and the test sets to create one data set
## Extraction of the data from the text files

y_test <- tbl_df(read.table("./UCI HAR Dataset/test/y_test.txt"))
X_test <- tbl_df(read.table("./UCI HAR Dataset/test/X_test.txt"))
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
X_train <- tbl_df(read.table("./UCI HAR Dataset/train/X_train.txt"))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

## Merging the two datasets, no more difference between the train and test data

X_total <- rbind(X_train,X_test)
y_total <- rbind(y_train,y_test)
subject_total <- rbind(subject_train,subject_test)

## Step 2 Extract only the measurements of mean and standard deviation
## for each measurement

colnames(X_total) <- features[,2]
X_total <- X_total[,grepl("(mean|std)\\(\\)", colnames(X_total))]

## Step 3 Uses descriptive activity names to name the activities in the data set
## Step 4 Appropriately labels the data set with descriptive variable name

colnames(activity_labels) <- cbind("activity_code","activity_name")
colnames(subject_total) <- "subject_id"
colnames(y_total) <- "activity_id"

X_total <- mutate(X_total,activity = activity_labels$activity_name[
  match(y_total$activity_id,activity_labels$activity_code)],subject = subject_total$subject_id)

## Step 5 From the data set in step 4, creates a second, independent tidy data set 
## with the average of each variable for each activity and each subject. So for one activity of
## one subject the values of the variables will be averaged.

X_melt <- melt(X_total,id=c("activity","subject"))
X_mean <- dcast(X_melt,subject+activity~variable,mean)

## write to file
write.table(X_mean,"./tidy_data.txt",row.names = FALSE)
