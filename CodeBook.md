---
title: "CodeBook for Coursera Getting and Cleaning Data Course Project"
author: "beyondreek"
date: "August 10, 2017"
output: html_document
---



## Introduction

The script run_analysis.R performs the following activities as required by the project: 
* Loads the train, test data and subject data.
* Merges the X data, Y data and Subject data using rbind().
* Loads the features data from "features.txt" and activities from "activity_labels.txt".
* Subset features with string [M]mean/std from X data.
* On the whole dataset, column names are modified to be more readable.
* Activity values in the dataset are replaced by Activity names.
* Finally, a new tidy data set with all the average measures for each subject and activity is generated and stored as "tidy_mergedData.txt"

## Variables
* The variables **xtrain_df**, **xtest_df**, **ytrain_df**, **ytest_df**, **sj_train_df**, **sj_test_df** contain the train and test **X data**, **Y data** and **Subject data**.
* The variables **xData**, **yData**,**subjectData** contain the merged test and train data. **xData** is later subsetted to contain only valiables that have mean or standard deviation measurements.
* The variable **feat** has the features data.
* The variable **mean_std** is a subset of features with the strings mean, mean and std in them.
* The variable **act** has the activity labels.
* The variable **mergedData** has the **subjectData**,**yData** and **xData** .
* The variable **tidy_mergedData** has the average of each variable for each activity and each subject and is stored in **tidy_mergedData.txt**.