# Getting And Cleaning Data Course Project

## How Does My Script Work?

### Step 1 (on the project page on coursera)

First, I read in all the relevant files. 

For test and train files each I combined the training / test set (X_test.txt / X_train.txt), the subject set (subject_test.txt / subject_train.txt) and the set defining the activity (y_test.txt / y_train.txt).
I then combined both the test and train data and ordered them by subject number.

### Step 3

Next, I changed the activity variable to more descriptive names.

### Step 2

After that I extracted those columns from the data that are measurements on the mean and standard deviation. For that I chose to use all features that include *mean()* or *std()*. I did not use the features that contain *mean* in an earlier part of the name.

### Step 4

Then I changed the column names to "subject" and "activity" for the first two columns and to the names given in the features.txt file for the rest of the columns. 

### Step 5

Creating the independent tidy data set with the average of each variable for each activity and each subject:
I used two for loops to find those parts of the data that pertain to one subject and one activity. Inside those two for loops I used one more for loop to calculate the mean of each variable and save it to the final data set.


## Reading My Data Set

For reading the data set in and looking at it in R you can use the following command:

```
data <- read.table(file_path)
View(data)
```



## About The Codebook

In the codebook I described the first two variables (Subject and activity) and gave a generic description of the other variables. I hope you don't mind that I didn't describe each of the 66 variables and what they mean individually.
