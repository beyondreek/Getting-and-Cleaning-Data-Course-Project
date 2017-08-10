#Set the working directory to the UCI HAR Dataset
setwd("C:/Users/valluira/Documents/Coursera/DataScienceCourse/WD/datasciencecoursera/week4/tidy/UCI HAR Dataset/")

#Load the "dplyr" package
library(dplyr)


#Load the X_train ,y_train, subject_train sets and convert them to tibble dataframes  

xtrain<-read.table("train/X_train.txt")
xtrain_df<-tbl_df(xtrain)

ytrain<-read.table("train/y_train.txt")
ytrain_df<-tbl_df(ytrain)

sj_train<-read.table("train/subject_train.txt")
sj_train_df<-tbl_df(sj_train)

#Load the X_test ,y_test, subject_test sets and convert them to tibble dataframes  

xtest<-read.table("test/X_test.txt")
xtest_df<-tbl_df(xtest)

ytest<-read.table("test/y_test.txt")
ytest_df<-tbl_df(ytest)

sj_test<-read.table("test/subject_test.txt")
sj_test_df<-tbl_df(sj_test)


#Merge X, Y and subject train and test data using rbind

xData<-rbind(xtrain_df,xtest_df)
yData<-rbind(ytrain_df,ytest_df)
subjectData<-rbind(sj_train_df,sj_test_df)

#Load features set into "feat"
feat<-read.table("features.txt")

#Subset features with the names "[Mm]ean" or "std"
mean_std<-grepl("mean|std|Mean",feat[,2])

#Subset "[Mm]ean" and "std" columns from xData
xData<-xData[,mean_std]

#Rename the column names in "xData" appropriately
names(xData)<-feat[mean_std,2]

#Load activity names to "act"
act<-read.table("activity_labels.txt")

#Change the column name in yData to "activity"
names(yData)<-"activity"
#Rename the values in yData to descriptive activity names
yData[,1]<-act[yData[,1],]
yData$activity <- factor(yData$activity, levels = act[,1], labels = act[,2])

#Change the column name in subjectData to "subject"
names(subjectData)<-"subject"

#Merge subjectData,yData and xData using "cbind" and load it to "mergedData"
mergedData<-cbind(subjectData,yData,xData)

#Rename the variable names to descriptive variable names
names(mergedData)<-gsub("Acc","Acceleration",names(mergedData))
names(mergedData) <- gsub("Mag","Magnitude",names(mergedData))
names(mergedData) <- gsub("Gyro","AngularSpeed",names(mergedData))
names(mergedData) <- gsub("^t","TimeDomain.",names(mergedData))
names(mergedData) <- gsub("^f","FrequencyDomain.",names(mergedData))
names(mergedData) <- gsub("Freq\\.","Frequency.",names(mergedData))
names(mergedData) <- gsub("Freq$","Frequency",names(mergedData))
names(mergedData) <- gsub("GyroJerk","AngularAcceleration_",names(mergedData))
names(mergedData) <- gsub("*mean",".Mean",names(mergedData))
names(mergedData) <- gsub("*std",".StandardDeviation",names(mergedData))
names(mergedData) <- gsub("()","",names(mergedData))

#Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidy_mergedData = ddply(mergedData, c("subject","activity"), numcolwise(mean))
write.table(tidy_mergedData, file = "tidy_mergedData.txt")
