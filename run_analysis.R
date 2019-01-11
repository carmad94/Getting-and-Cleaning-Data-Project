
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

# Merge training and test data sets to one data set
har_data_train <- cbind(X_train, y_train, subject_train)
har_data_test <- cbind(X_test, y_test, subject_test)
har_data_set <- rbind(har_data_train, har_data_test)

# Extract mean and stdev for each measurement
har_mean_std <- har_data_set[grepl("std[[:punct:]]|mean[[:punct:]]|_num", names(har_data_set))]

# Add descriptive labels / variable names
names(har_mean_std)[1:66] <- gsub("[()]","",names(har_mean_std[1:66]))
names(har_mean_std)[1:66] <- gsub("-","_",names(har_mean_std[1:66]))
names(har_mean_std)[1:40] <- sub("t","Triaxial_",names(har_mean_std[1:40]))
names(har_mean_std)[41:66] <- sub("f","Fourier_",names(har_mean_std[41:66]))

# tidy data set
activity_mean <- aggregate(har_mean_std[1:66], by=list(har_mean_std$activity_num), FUN=mean)
subject_mean <- aggregate(har_mean_std[1:66], by=list(har_mean_std$subject_num), FUN=mean)
names(subject_mean)[1] <- c("subject")
names(activity_mean)[1] <- c("activity")
activity_mean[1] <- activity_labels$V2
#export the tidy data set
write.csv(activity_mean, file = "activity_mean.csv",row.names=FALSE, na="")
write.csv(subject_mean, file = "subject_mean.csv",row.names=FALSE, na="")
