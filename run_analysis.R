dataTrainX <- read.table("UCI HAR Dataset/train/X_train.txt", header=FALSE);
dataTrainy <- read.table("UCI HAR Dataset/train/y_train.txt", header=FALSE);
dataTestX <- read.table("UCI HAR Dataset/test/X_test.txt", header=FALSE);
dataTesty <- read.table("UCI HAR Dataset/test/y_test.txt", header=FALSE);
features <- read.table("UCI HAR Dataset/features.txt", header=FALSE);
activities <- read.table("UCI HAR Dataset/activity_labels.txt", head=FALSE);
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header=FALSE);
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header=FALSE);
subject <- rbind(subjectTrain,subjectTest);
featurenames <- as.character(features[,2]);
totalX <- rbind(dataTrainX,dataTestX);
totaly <- rbind(dataTrainy,dataTesty);
names(totalX) <- featurenames;
tidyindex <- grep("mean\\(\\)|std\\(\\)",featurenames);
tidyX <- totalX[,tidyindex];
entireactivity <- merge(totaly,activities,by.x="V1",by.y="V1",all.x=TRUE,all.y=FALSE);
tmp <- data.frame(subject=subject$V1,activity=entireactivity$V2);
tidyData <- cbind(tmp,tidyX);
tidy <- tidyData[1:180,];
for (i in 1:30){
  for (j in 1:6){
    for (k in 3:ncol(tidyData)){
      for (l in 1:180){
        tidy[l,k] <- tapply(tidyData[,k],subject == i & as.integer(activity) == j,mean)[2];
      }
    }
  }
}   


