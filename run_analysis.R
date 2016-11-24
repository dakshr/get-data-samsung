## Set the working directory to the location with the "test" folder, "train" folder, 
## and files activit_labels and features.


## 1. MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET.

###Read the activity labels and list of features
activity_labels_df <- read.table("activity_labels.txt")
features_df <- read.table("features.txt")

###Read all the Test related data (list of subjects, X_test, and Y_test)
subject_test_df <- read.table("./test/subject_test.txt")
X_test_df <- read.table("./test/X_test.txt")
Y_test_df <- read.table("./test/Y_test.txt")

###Update the variables names to identify the subject, and in the Y_test table the activity 
names(subject_test_df) = "subject"
names(Y_test_df) = "activity_id"

###Combine all columns of the test data into 1 data set
test_df <- cbind(subject_test_df,Y_test_df,X_test_df)
rm(subject_test_df,Y_test_df,X_test_df)

###Read all the Train related data (list of subjects, X_test, and Y_test)
subject_train_df <- read.table("./train/subject_train.txt")
X_train_df <- read.table("./train/X_train.txt")
Y_train_df <- read.table("./train/Y_train.txt")

###Update the variables names to identify the subject, and in the Y_test table the activity 
names(subject_train_df) = "subject"
names(Y_train_df) = "activity_id"

###Combine all columns of the Train data into 1 data set
train_df <- cbind(subject_train_df,Y_train_df,X_train_df)
rm(subject_train_df,Y_train_df,X_train_df)

###Combine the rows of Test data with the rows of Train data
testtrain_df <- rbind(test_df,train_df)
rm(test_df,train_df)

## 2. EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT.

###Identify measurements on the mean and standard deviation. 
###This is considered to be any measurement which ends "mean" or "std"
###The end is considered when either of these are immediately followed by "()"
meanstd <- grep("mean()|std()", features_df$V2)


###Next, from the mean and std. dev measurements identified in the previous steps - 
###Use that list to extract ONLY the related columns from the merged Test and Train data set.
testtrain_df1 <- testtrain_df[, c(1,2,meanstd + 2)]
rm(testtrain_df)

## 3. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

###Merge the Test Train data set with the Activity labels, so that the activity description comes up next to the activity ID.
testtrain_df2 <- merge(x = testtrain_df1, y = activity_labels_df, by.x = "activity_id", by.y = "V1",all.x = TRUE)
rm(testtrain_df1)
## 4. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES.

###From the list of features, identify the ones for mean and std. dev.
###Apply basic clean up of the values to replace "-" with "_", and "()" with enpty string
###These names will be used as column names for data set.
meanstd2 <- gsub("\\(|\\)","",gsub("-","_",grep("mean()|std()", features_df$V2, value = TRUE)))

###Create a vector with all the appropriate column names - 
###The first 2 columns will have the same name, followed by "clean" feature names identified in the previous step
###Append this with the "Activity" label, which was included in the merged data set.
###Update the column names for the data set 
names(testtrain_df2) = c(names(testtrain_df2)[1:2], meanstd2, "activity")
names(testtrain_df2)


## 5. FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT TIDY DATA SET WITH THE 
## AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.
library(dplyr)

testtrain_df2$subject <- factor(testtrain_df2$subject)
testtrain_grp_df <- group_by(testtrain_df2, subject, activity)
summarize(testtrain_grp_df, a = mean(tBodyAcc_mean_X, na.rm = TRUE))

testtrain_tidy_df <- testtrain_grp_df %>% summarise_each(funs(mean(., na.rm = TRUE)))

testtrain_tidy_df ##this is the final output

###The generated text file with the tidy data set has the mean for each variable for 
### each subject and each activity.

###It is created using the following write table command
###  write.table(testtrain_tidy_df, file = "SamsungTidyData.txt", row.name=FALSE)

rm(activity_labels_df,features_df,testtrain_df2)

