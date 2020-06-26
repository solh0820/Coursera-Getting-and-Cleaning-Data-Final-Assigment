# Coursera-Getting-and-Cleaning-Data-Final-Assigment

* R script, `run_analysis.R`, conducts the following:


1. Download file from web if it doesn't exists into  the working directory.
2. We start reading the train and test files datasets and then merge them into X(measurements),        Y(activity) and Subject, respectively.
3. We load data(X's) feature and activity info 
4. We extract columns named 'mean'(`-mean`) and 'standard'(`-std`).
   4.1 Modify column names to descriptive. (`-mean` to `Mean`, `-std` to `Std`, and remove symbols         like `-`, `(`, `)`)
5. Extract data by selected columns(from  3), and merge X(measurements), Y(activity) and Subject    data.
6. Replace Y(activity) column to it's name by refering activity label (from 3).
7. Generate 'Tidy Dataset' that consists of the average (mean) of each variable for each subject and each activity.
   The result is shown in the file `Tidy_Dataset.txt`.
