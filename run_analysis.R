# 1. Merge the training and the test sets to create one data set

setwd('//HKGS00500101.hk.net.intra/b44064$/WORKAREA/data/UCI HAR Dataset/');

features = read.table('./features.txt',header=FALSE); 
activity_label = read.table('./activity_labels.txt',header=FALSE);
subject_train = read.table('./train/subject_train.txt',header=FALSE);
x_train = read.table('./train/x_train.txt',header=FALSE);
y_train = read.table('./train/y_train.txt',header=FALSE);
colnames(activity_label) = c('activityId','activity_label');
colnames(subject_train) = "subjectId";
colnames(x_train) = features[,2]; 
colnames(y_train) = "activityId";

trainingData = cbind(y_train,subject_train,x_train);

subject_test = read.table('./test/subject_test.txt',header=FALSE);
x_test = read.table('./test/x_test.txt',header=FALSE);
y_test = read.table('./test/y_test.txt',header=FALSE);
colnames(subject_test) = "subjectId";
colnames(x_test) = features[,2]; 
colnames(y_test) = "activityId";

test_data = cbind(y_test,subject_test,x_test);
merged_test_data = rbind(trainingData,test_data);
colNames  = colnames(merged_test_data); 

# 2. Extract only the measurements on the mean and standard deviation for each measurement

logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & !grepl("-meanFreq..",colNames) & !grepl("mean..-",colNames) | grepl("-std..",colNames) & !grepl("-std()..-",colNames));
merged_test_data = merged_test_data[logicalVector==TRUE];

# 3. Uses descriptive activity names to name the activities in the data set

merged_test_data = merge(merged_test_data,activity_label,by='activityId',all.x=TRUE);
colNames  = colnames(merged_test_data); 

# 4. Appropriately labels the data set with descriptive variable names

for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("-std$","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","time",colNames[i])
  colNames[i] = gsub("^(f)","freq",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};

colnames(merged_test_data) = colNames;

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject 

merged_test_data2 = merged_test_data[,names(merged_test_data) != 'activity_label'];
final_data = aggregate(merged_test_data2[,names(merged_test_data2) != c('activityId','subjectId')],by=list(activityId=merged_test_data2$activityId,subjectId = merged_test_data2$subjectId),mean);
final_data = merge(final_data,activity_label,by='activityId',all.x=TRUE);
write.table(final_data, './final_data.txt',row.names=FALSE,sep='\t');
