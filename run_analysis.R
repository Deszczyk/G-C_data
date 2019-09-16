
#For each record in the dataset it is provided: 
#- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
#- Triaxial Angular velocity from the gyroscope. 
#- A 561-feature vector with time and frequency domain variables. 
#- Its activity label. 
#- An identifier of the subject who carried out the experiment. 

setwd("B:/JJ_Doc/R/getting_cleaning/UCI HAR Dataset/")
getwd()



x_test <- read.table("test/X_test.txt", header = FALSE)
y_test <- read.table("test/y_test.txt", header = FALSE)

x_train <- read.table("train/X_train.txt", header = FALSE)
y_train <- read.table("train/y_train.txt", header = FALSE)



x_all <- rbind(x_train, x_test)
y_all <- rbind(y_train,y_test)

subject_test <- read.table("test/subject_test.txt", header = FALSE)
subject_train <- read.table("train/subject_train.txt", header = FALSE)

subject_all <- rbind(subject_train, subject_test)

features_l <- read.table("features.txt")
activities <- read.table("activity_labels.txt")


colnames(x_all) <- t(features_l[2])

colnames(y_all) <- "Activity"
colnames(subject_all) <- "Subject"


merged <- cbind(subject_all, activity, features)

head(merged)



#2.Extracts only the measurements on the mean and standard deviation for each measurement. 


mean <- grep( "mean",names(merged))
std <- grep( "std",names(merged))
s1 <- grep( "Subject",names(merged))
a1 <- grep( "Activity",names(merged))

print(a1)
print(s1)

all_col <-c(s1,a1,mean,std)

merged_ms<- merged[,all_col]

head(merged_ms)



#3.Uses descriptive activity names to name the activities in the data set


merged_ms$Activity <- activities[merged_ms$Activity, 2]
head(merged_ms)





#4.Appropriately labels the data set with descriptive variable names. 





merged_char[, 2] <- as.character(merged_ms[, 2])

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable
#for each activity and each subject.


Merged_final <- merged_ms %>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))


write.table(Merged_final, file = "Merged_final.txt", row.names = FALSE)
