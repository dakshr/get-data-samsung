## Set the working directory to the location with the "test" folder, "train" folder, 
## and files activit_labels and features.

## 1. MERGES THE TRAINING AND THE TEST SETS TO CREATE ONE DATA SET.

###Read the activity labels and list of features

###Read all the Test related data (list of subjects, X_test, and Y_test)

###Update the variables names to identify the subject, and in the Y_test table the activity 

###Combine all columns of the test data into 1 data set

###Read all the Train related data (list of subjects, X_test, and Y_test)

###Update the variables names to identify the subject, and in the Y_test table the activity 

###Combine all columns of the Train data into 1 data set

###Combine the rows of Test data with the rows of Train data

## 2. EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT.

###Identify measurements on the mean and standard deviation. 
###This is considered to be any measurement which ends "mean" or "std"
###The end is considered when either of these are immediately followed by "()"


###Next, from the mean and std. dev measurements identified in the previous steps - 
###Use that list to extract ONLY the related columns from the merged Test and Train data set.

## 3. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET

###Merge the Test Train data set with the Activity labels, so that the activity description comes up next to the activity ID.

## 4. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES.

###From the list of features, identify the ones for mean and std. dev.
###Apply basic clean up of the values to replace "-" with "_", and "()" with enpty string
###These names will be used as column names for data set.


###Create a vector with all the appropriate column names - 
###The first 2 columns will have the same name, followed by "clean" feature names identified in the previous step
###Append this with the "Activity" label, which was included in the merged data set.
###Update the column names for the data set 

## 5. FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT TIDY DATA SET WITH THE 
## AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT.

###The generated text file with the tidy data set has the mean for each variable for 
### each subject and each activity.


###It is created using the following write table command
### 	write.table(testtrain_tidy_df, file = "SamsungTidyData.txt", row.name=FALSE)
