# run_analysis.R

library(reshape2)


# Downloading  dataset 
DataUrlDir <- "./rawData"
Url<- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
DataFilename <- "Data.zip"
DataDFn <- paste(DataUrlDir, "/", "Data.zip", sep = "")
dataDir <- "./data"

if (!file.exists(DataUrlDir)) {
  dir.create(DataUrlDir)
  download.file(url = Url, destfile = DataDFn)
}
if (!file.exists(dataDir)) {
  dir.create(dataDir)
  unzip(zipfile = DataDFn, exdir = dataDir)
}


#1 Merges the training and the test sets to create one data set.
# train data
Xtrain <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/X_train.txt"))
Ytrain <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/Y_train.txt"))
Subjecttrain <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/subject_train.txt"))

# test data
Xtest <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/X_test.txt"))
Ytest <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/Y_test.txt"))
Subjecttest <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/subject_test.txt"))

# merge {train, test} data
X <- rbind(Xtrain, Xtest)
Y <- rbind(Ytrain, Ytest)
Subject <- rbind(Subjecttrain, Subjecttest)


#3. Uses descriptive activity names to name the activities in the data set
# feature file info
features <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/features.txt"))

# Activity labels info
Activitylabels <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/activity_labels.txt"))
Activitylabels[,2] <- as.character(Activitylabels[,2])

#4 Extracts only the measurements on the mean and standard deviation for each measurement.
Cols <- grep("-(mean|std).*", as.character(features[,2]))
ColNames <- features[Cols, 2]
ColNames <- gsub("-mean", "Mean", ColNames)
ColNames <- gsub("-std", "Std", ColNames)
ColNames <- gsub("[-()]", "", ColNames)


X <- X[Cols]
FinalData <- cbind(Subject, Y, X)
colnames(FinalData) <- c("Subject", "Activity", ColNames)

FinalData$Activity <- factor(FinalData$Activity, levels = Activitylabels[,1], labels = Activitylabels[,2])
FinalData$Subject <- as.factor(FinalData$Subject)


#5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

melt <- melt(FinalData, id = c("Subject", "Activity"))
Tidy <- dcast(melt, Subject + Activity ~ variable, mean)

write.table(Tidy, "./Tidy_Dataset.txt", row.names = FALSE, quote = FALSE)
