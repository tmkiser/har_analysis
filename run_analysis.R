
dir <- "UCI HAR Dataset"
activity_labels <- read.table(paste(dir, "activity_labels.txt", sep = "/"))
colnames(activity_labels) <- c("id", "name")
features <- read.table(paste(dir, "features.txt", sep = "/"))
colnames(features) <- c("id", "name")

feature_subset <- c(
        "tBodyAcc-mean()-X",
        "tBodyAcc-mean()-Y",
        "tBodyAcc-mean()-Z",
        "tBodyAcc-std()-X",
        "tBodyAcc-std()-Y",
        "tBodyAcc-std()-Z",
        "tGravityAcc-mean()-X",
        "tGravityAcc-mean()-Y",
        "tGravityAcc-mean()-Z",
        "tGravityAcc-std()-X",
        "tGravityAcc-std()-Y",
        "tGravityAcc-std()-Z",
        "tBodyAccJerk-mean()-X",
        "tBodyAccJerk-mean()-Y",
        "tBodyAccJerk-mean()-Z",
        "tBodyAccJerk-std()-X",
        "tBodyAccJerk-std()-Y",
        "tBodyAccJerk-std()-Z",
        "tBodyGyro-mean()-X",
        "tBodyGyro-mean()-Y",
        "tBodyGyro-mean()-Z",
        "tBodyGyro-std()-X",
        "tBodyGyro-std()-Y",
        "tBodyGyro-std()-Z",
        "tBodyGyroJerk-mean()-X",
        "tBodyGyroJerk-mean()-Y",
        "tBodyGyroJerk-mean()-Z",
        "tBodyGyroJerk-std()-X",
        "tBodyGyroJerk-std()-Y",
        "tBodyGyroJerk-std()-Z",
        "tBodyAccMag-mean()",
        "tBodyAccMag-std()",
        "tGravityAccMag-mean()",
        "tGravityAccMag-std()",
        "tBodyAccJerkMag-mean()",
        "tBodyAccJerkMag-std()",
        "tBodyGyroMag-mean()",
        "tBodyGyroMag-std()",
        "tBodyGyroJerkMag-mean()",
        "tBodyGyroJerkMag-std()",
        "fBodyAcc-mean()-X",
        "fBodyAcc-mean()-Y",
        "fBodyAcc-mean()-Z",
        "fBodyAcc-std()-X",
        "fBodyAcc-std()-Y",
        "fBodyAcc-std()-Z",
        "fBodyAccJerk-mean()-X",
        "fBodyAccJerk-mean()-Y",
        "fBodyAccJerk-mean()-Z",
        "fBodyAccJerk-std()-X",
        "fBodyAccJerk-std()-Y",
        "fBodyAccJerk-std()-Z",
        "fBodyGyro-mean()-X",
        "fBodyGyro-mean()-Y",
        "fBodyGyro-mean()-Z",
        "fBodyGyro-std()-X",
        "fBodyGyro-std()-Y",
        "fBodyGyro-std()-Z",
        "fBodyAccMag-mean()",
        "fBodyAccMag-std()",
        "fBodyBodyAccJerkMag-mean()",
        "fBodyBodyAccJerkMag-std()",
        "fBodyBodyGyroMag-mean()",
        "fBodyBodyGyroMag-std()",
        "fBodyBodyGyroJerkMag-mean()",
        "fBodyBodyGyroJerkMag-std()"
        )

#
# training set
#
train_dir <- "train"

# A 561-feature vector with time and frequency domain variables. 
training_set <- read.table(paste(dir, train_dir, "X_train.txt", sep = "/"), row.names = NULL)
colnames(training_set) <- features$name
training_set$id <- seq(from = 1, to = nrow(training_set))
row.names(training_set) <- seq(from = 1, to = nrow(training_set))
#training_set <- subset(training_set, select = feature_subset)

# activity label for each observation 
training_labels <- read.table(paste(dir, train_dir, "y_train.txt", sep = "/"), row.names = NULL)
colnames(training_labels) <- c("activity_id")
training_set$activity_id <- training_labels

# identifier of the subject who carried out the experiment for each observation
training_subjects <- read.table(paste(dir, train_dir, "subject_train.txt", sep = "/"), row.names = NULL)
colnames(training_subjects) <- c("subject_id")
training_set$subject_id <- training_subjects

#
# test set
#
test_dir <- "test"

test_set <- read.table(paste(dir, test_dir, "X_test.txt", sep = "/"), row.names = NULL)
colnames(test_set) <- features$name
test_set$id <- seq(from = nrow(training_set) + 1, to = nrow(training_set) + nrow(test_set))
row.names(test_set) <- seq(from = nrow(training_set) + 1, to = nrow(training_set) + nrow(test_set))
#test_set <- subset(test_set, select = feature_subset)

test_labels <- read.table(paste(dir, test_dir, "y_test.txt", sep = "/"), row.names = NULL)
colnames(test_labels) <- c("activity_id")
test_set$activity_id <- test_labels

test_subjects <- read.table(paste(dir, test_dir, "subject_test.txt", sep = "/"), row.names = NULL)
colnames(test_subjects) <- c("subject_id")
test_set$subject_id <- test_subjects

merged_set <- rbind(training_set, test_set)
