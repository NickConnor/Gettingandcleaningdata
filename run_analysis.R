## Okay, lets see if I can get the files and then merge them into a single table.
## They are in a .zip folder so perhaps I should take them out into some other file in the script.
## Or perhaps just manually unzip the folder. 

## check if file exists, if not download and unzip and recheck.
if(dir.exists("UCI HAR Dataset")){
  message("Data loaded, processing...")
  root.dir <- "UCI HAR Dataset"
} else {
  message("Downloading Dataset please wait...")
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile="smartphone.zip")
  message("Extracting files")
  unzip("smartphone.zip", files = NULL, list = FALSE, overwrite = TRUE,
      junkpaths = FALSE, exdir = ".", unzip = "internal",
      setTimes = FALSE)
  message("Data loaded, proceeding...")
  root.dir<- "UCI HAR Dataset"
} 
## This works great, tested. Solid.
## Read all these tables and files into variables in r

library(plyr)


## subject training and testing ids?
subject_train<- read.table(paste(root.dir,"train","subject_train.txt", sep="/"))
subject_test<- read.table(paste(root.dir,"test","subject_test.txt", sep="/"))

## x-related tables
xtrain<- read.table(paste(root.dir,"train","X_train.txt", sep="/"))
xtest<- read.table(paste(root.dir,"test","X_test.txt", sep="/"))

## y-related tables
ytrain<- read.table(paste(root.dir,"train","y_train.txt", sep="/"))
ytest<- read.table(paste(root.dir,"test","y_test.txt", sep="/"))

## Clean up into 3 data clusters
x_data<- rbind(xtrain,xtest)
y_data<- rbind(ytrain,ytest)
subject_data<- rbind(subject_train,subject_test)

features <- read.table(paste(root.dir,"features.txt", sep="/"))

meanandstd <- grep("-(mean|std)\\(\\)", features[,2])

x_data<- x_data[,meanandstd]

names(x_data)<-features[meanandstd, 2]


## Activity names
activitynames<- read.table(paste(root.dir,"activity_labels.txt", sep="/"))

y_data[,1] <- activitynames[y_data[, 1], 2]

## correct the column names
names(y_data) <- "activity"
names(subject_data) <- "subject"

## bind all the data in a single data set
compiled <- cbind(x_data, y_data, subject_data)

## Create an independent tidy data set with the average of each variable
averages_of_data <- ddply(compiled, .(subject, activity), function(x) colMeans(x[, 1:66]))

## writing the table, in text format
write.table(averages_of_data, "averages_of_data.txt", row.name=FALSE)
message("File completed, find 'averages_of_data.txt' file in your working directory")

