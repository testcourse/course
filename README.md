Course Project for Getting and Cleaning Data
========================================================
## Merges the training and the test sets to create one data set.


```r
## Load features and name total X data column with feature
features <- read.table("UCI HAR Dataset/features.txt", header = FALSE)
## Load and combine all X data, then name its columns
dataTrainX <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
dataTestX <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
totalX <- rbind(dataTrainX, dataTestX)
names(totalX) <- as.character(features[, 2])
## Load and combine all y data, then name its columns
dataTrainy <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
dataTesty <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
totaly <- rbind(dataTrainy, dataTesty)
names(totaly) <- c("ActivityID")
## Load activities and set their column name
activities <- read.table("UCI HAR Dataset/activity_labels.txt", head = FALSE)
names(activities) <- c("ActivityID", "Activity")
## Merge y data with activities data to get meaningful label
totaly <- merge(totaly, activities, by.x = "ActivityID", by.y = "ActivityID", 
    all = FALSE)
## Load, combine and name all the subject
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
subject <- rbind(subjectTrain, subjectTest)
names(subject) <- c("Subject")
## Combine the whole data set into a single dataset name set1
set1 <- cbind(totalX, totaly, subject)
```



## Extract only the measurements on the mean and standard deviation for each measurement

```r
originalindex <- grep("mean\\(\\)|std\\(\\)", names(set1))
set2 <- set1[, c(originalindex, 563, 564)]
```

## Use the descriptive names


```r
names(set2) <- gsub("[-()]", "", names(set2))
```


## Tidy dataset with the average of each variable for each activity and each subject

```r
tidyDataSet <- aggregate(set2[, 1:66], by = list(Subject = set2$Subject, Activity = set2$Activity), 
    mean)
write.csv(tidyDataSet, file = "tidy.csv", row.names = FALSE)
```



