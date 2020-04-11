
setwd("/Users/vipinaggarwal/Desktop/DataScienceRCS/3.CleaningData/Project")
library("dplyr")

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#1.Merges the training and the test sets to create one data set.
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
sub <- rbind(subject_train, subject_test)
dataSet <- cbind(sub, x, y)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
select(dataSet, subject, code, contains("mean"), contains("std")) -> extractedData

#3.Uses descriptive activity names to name the activities in the data set
extractedData$code <- activities[extractedData$code, 2]

#4.Appropriately labels the data set with descriptive variable names.
names(extractedData)
names(extractedData)[2] <- "Activity" 
names(extractedData)[1] <- "Subject" 
names(extractedData) <- gsub("^t", "Time", names(extractedData))
names(extractedData) <- gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData) <- gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData) <- gsub("BodyBody", "Body", names(extractedData))
names(extractedData) <- gsub("^f", "Frequency", names(extractedData))
names(extractedData) <- gsub("Mag", "Magnitude", names(extractedData))
names(extractedData) <- gsub("tBody", "TimeBody", names(extractedData))
names(extractedData) <- gsub("angle", "Angle", names(extractedData))
names(extractedData) <- gsub("gravity", "Gravity", names(extractedData))
extractedData$TimeBodyAccelerometer.mean...X


#5From the data set in step 4, creates a second, independent tidy data set with the average of each
#variable for each activity and each subject.
install.packages("reshape2")
library(reshape2)
featuresCol <- grep("[Mm]ean|[Ss]td", names(extractedData))
melted <-melt(extractedData, id = c('Subject', 'Activity'), measure.vars = featuresCol)
tidyData <- dcast(melted, Subject + Activity ~ variable, mean)

#write table to file
write.table(tidyData, file = "tidydata.txt", row.names = FALSE)

                          