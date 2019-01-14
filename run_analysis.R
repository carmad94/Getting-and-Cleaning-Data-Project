library(dplyr)

# Read training and test data sets
y_train <- read.table("UCI_HAR_Dataset/train/y_train.txt", sep=" ")
X_train <- read.table("UCI_HAR_Dataset/train/X_train.txt", sep="")
subject_train <- read.table("UCI_HAR_Dataset/train/subject_train.txt", sep=" ")

y_test <- read.table("UCI_HAR_Dataset/test/y_test.txt", sep=" ")
X_test <- read.table("UCI_HAR_Dataset/test/X_test.txt", sep="")
subject_test <- read.table("UCI_HAR_Dataset/test/subject_test.txt", sep=" ")

features <- read.table("UCI_HAR_Dataset/features.txt", sep=" ")
activity_labels <- read.table("UCI_HAR_Dataset/activity_labels.txt", sep=" ")

#column naming for activity and subject
names(X_train) <- features$V2
names(y_train) <- c("activity_num")
names(subject_train) <- c("subject_num")

names(X_test) <- features$V2
names(y_test) <- c("activity_num")
names(subject_test) <- c("subject_num")

names(activity_labels)[1] <- c("activity_num")
names(activity_labels)[2] <- c("activity_label")
y_train <- left_join(y_train, activity_labels)
y_test <- left_join(y_test, activity_labels)


# Merge training and test data sets to one data set
har_data_train <- cbind(X_train, y_train, subject_train)
har_data_test <- cbind(X_test, y_test, subject_test)
har_data_set <- rbind(har_data_train, har_data_test)

# Extract mean and stdev for each measurement
har_mean_std <- har_data_set[grepl("std[[:punct:]]|mean[[:punct:]]|_num|_label", names(har_data_set))]

# Add descriptive labels / variable names
names(har_mean_std)[1:66] <- gsub("[()]","",names(har_mean_std[1:66]))
names(har_mean_std)[1:66] <- gsub("-","_",names(har_mean_std[1:66]))
names(har_mean_std)[1:40] <- sub("t","Triaxial_",names(har_mean_std[1:40]))
names(har_mean_std)[41:66] <- sub("f","Fourier_",names(har_mean_std[41:66]))


# tidy data set
activity_subject_mean <- aggregate(har_mean_std[1:66], by=list(har_mean_std$activity_label, har_mean_std$subject_num), FUN=mean)
names(activity_subject_mean)[1] <- c("activity")
names(activity_subject_mean)[2] <- c("subject")
#export the tidy data set
write.table(activity_subject_mean, file = "activity_subject_mean.txt",row.names=FALSE, na="")
