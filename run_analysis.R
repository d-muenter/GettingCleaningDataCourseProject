## read the relevant files both for the test and train data

subject_test <- read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
X_test <- read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
test_y <- read.table(".\\UCI HAR Dataset\\test\\y_test.txt")
subject_train <- read.table(".\\UCI HAR Dataset\\train\\subject_train.txt")
X_train <- read.table(".\\UCI HAR Dataset\\train\\X_train.txt")
train_y <- read.table(".\\UCI HAR Dataset\\train\\y_train.txt")

## combine all the test data into one table
colnames(subject_test) <- "subject"
colnames(test_y) <- "activity"
test <- cbind(subject_test, test_y, X_test)
## combine all the train data into one table
colnames(subject_train) <- "subject"
colnames(train_y) <- "activity"
train <- cbind(subject_train, train_y, X_train)

## combine the test data and the train data into one data set
data_set <- rbind(test, train)
## order the data set by the subject number and change the row names accordingly
data_set <- data_set[order(data_set$subject),]
rownames(data_set) <- c(1:10299)

## change activity variable to more descriptive values
data_set$activity <- as.character(data_set$activity)
data_set$activity <- sub("1", "walking", data_set$activity)
data_set$activity <- sub("2", "walking_upstairs", data_set$activity)
data_set$activity <- sub("3", "walking_downstairs", data_set$activity)
data_set$activity <- sub("4", "sitting", data_set$activity)
data_set$activity <- sub("5", "standing", data_set$activity)
data_set$activity <- sub("6", "laying", data_set$activity)


## extract variables with measurements on the mean and standard deviation

## read the features file to find the relevant variables
features <- read.table(".\\UCI HAR Dataset\\features.txt")
## finding variables with measurements on mean and standard deviation
var_mean <- grep("mean\\(\\)", features[,2])
var_std <- grep("std\\(\\)", features[,2])
## combine both lists so the numbers of all relevant variables are in one list
rel_var <- sort(c(var_mean, var_std))
## extract relevant variables (columns)
data_set <- data_set[, c(1, 2, rel_var+2)]

## rename the variables to more descriptive names using the features.txt file

## extract relevant variable names from the features.txt file
rel_var_name <- features[rel_var, 2]
## rename variables to those names
colnames(data_set) <- c("subject", "activity", rel_var_name)



## create a second, independent tidy data set with the average of each variable
## for each activity and each subject

## create a list containing all the subjects
subjects <- c(1:30)
## create a list containing all six activities
activities <- c("walking", "walking_upstairs", "walking_downstairs", "sitting",
                "standing", "laying")


## create new data frame (sub_act_data) containing only the measurements
## pertaining to one subject and one activity
## then calculate the mean for each variable and store in new final data frame
a <- 0
final_data_set <- data.frame(matrix(NA, nrow=180, ncol=68))
colnames(final_data_set) <- c("subject", "activity", rel_var_name)
for (i in subjects) {
    for (j in activities) {
        a <- a + 1
        
        sub_act_data <- data_set[data_set$subject == i & data_set$activity == j,]
        
        ## calculate the mean for each variable and save them in the
        ## final data frame
        
        final_data_set[a,1] <- i
        final_data_set[a,2] <- j
        for (k in 3:68) {
            final_data_set[a, k] <- mean(sub_act_data[, k])
        }
       
    }
}

## remove all unnecessary data so that the code only outputs the final data set
rm(sub_act_data, a, i, j, k, data_set, features, subject_test, subject_train,
   test, test_y, train, train_y, X_test, X_train, activities, rel_var,
   rel_var_name, subjects, var_mean, var_std)

