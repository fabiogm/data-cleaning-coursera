FILE_URL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
DATA_FILENAME <- "uci.zip"
DATA_DIR <- "UCI HAR Dataset"

downloadData <- function(url, destination) {
    download.file(url, destination, method="auto") 
}

getPath <- function(rest) {
    file.path(DATA_DIR, rest)
}

beautifyColNames <- function(dataset) {
    colNames <- colnames(dataset)
    # Remove periods.
    colNames <- gsub("\\.", "", colNames)
    # Remove first character.
    colNames <- substr(colNames, 2, nchar(colNames))
    # Capitalize mean and send it to front.
    colNames <- gsub("(.*)mean(.*)", "Mean\\1\\2",  colNames)
    # Capitalize std and send it to front.
    colNames <- gsub("(.*)std(.*)", "Std\\1\\2",  colNames)

    colnames(dataset) <- colNames
    invisible(dataset)
}

createSummary <- function(dataset) {
    # Calculate mean of columns by subject and activity.
    summDataset <- aggregate(subset(dataset, select=c(-Subject, -Activity)), list(dataset$Subject, dataset$Activity), mean)
    # Make variable names a bit more descriptive (moot point).
    colNames <- colnames(summDataset)
    colNames <- gsub("(.*)", "Mean\\1", colNames)
    colnames(summDataset) <- colNames
    colnames(summDataset)[1] <- "Subject"
    colnames(summDataset)[2] <- "Activity"
    invisible(summDataset)
}

main <- function() {

    if (!file.exists(DATA_DIR)) {
        print("Data not present in working directory, downloading...")
        downloadData(FILE_URL, DATA_FILENAME)
        unzip(DATA_FILENAME)
    }

    features <- read.table(getPath("features.txt"), stringsAsFactors=F)
    featureNames <- unlist(features[, 2])

    print("Merging datasets")
    trainData <- read.table(getPath("/train/X_train.txt"), col.names=featureNames)
    testData <- read.table(getPath("/test/X_test.txt"), col.names=featureNames)

    dataset <- rbind(trainData, testData)

    print("Keeping only measurements on mean and standard deviation.")
    colIdc <- grep("mean|std", featureNames)
    dataset <- dataset[, colIdc]
    
    print("Beautifying column names")
    dataset <- beautifyColNames(dataset)

    print("Loading subjects")
    trainSubj <- read.table(getPath("/train/subject_train.txt"))[, 1]
    testSubj <- read.table(getPath("/test/subject_test.txt"))[, 1]
    dataset$Subject <- c(trainSubj, testSubj)
    
    print("Assigning descriptive activity names")
    trainActivity <- read.table(getPath("/train/y_train.txt"))[, 1]
    testActivity <- read.table(getPath("/test/y_test.txt"))[,1]
    dataset$Activity <- c(trainActivity, testActivity)
    activityLabels <- read.table(getPath("activity_labels.txt"), stringsAsFactor=F)[, 2]
    dataset$Activity <- factor(dataset$Activity, labels=activityLabels)
   
    
    print("Creating tidy dataset")
    summaryDataset <- createSummary(dataset)
    write.table(summaryDataset, 'tidy_dataset.txt', row.names=F)
}

if (!interactive()) {
    main()
}
