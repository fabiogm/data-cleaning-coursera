## CodeBook

### Introduction

In order to generate the tidy dataset the following operations were performed on the original dataset

1. Train and test datasets merged;
2. Only measurements on the mean and standard deviation were kept;
3. More descriptive names were assigned to variables;
4. Assigned subject name and descriptive activity name to each observation.

### Variables

The origal dataset contains 3-axis raw signals from accelerometer and gyroscope (tAcc-XYZ and tGyro-XYZ, time domain signals). Acceleration signal was
separated into body and gravity accelerations signals (tBodyAcc-XYZ and tGravityAcc-XYZ). Body linear acceleration and angular velocity were derived in time to obtain 
Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean 
norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). A Fast Fourier Transform was applied to some of these Jerk signals
producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag variables.  

For all signals mean and standard deviation, among others, were estimated. Only mean and standard deviation were used in the creation of the tidy dataset. The last step
was calculating the mean of all variables, grouped by subject and activity.

