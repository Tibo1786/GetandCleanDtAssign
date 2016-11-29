# run_analysis.R
Programming assignment of the module Getting and Cleaning Data
Script to be run on the data set "Human Activity Recognition Using Smartphones" from the source "Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013."

In order to run this script properly the libraries dplyr and reshape2 must have been installed.

# Description of the script

This script loads the dataset, and more specifially the different files containing the variables measurements, the variables names, the subject id and the activity id as well as the corresponding names and will first of all convert them to data frames. The two categories of datasets, train and test, are then merged in one global dataset. Then the script extract only the columns containing the terms mean and std followed by "()" to be sure that those are really the mean and standard deviation of the variables, and not another variable resulting from a calculation on a mean, for example. Following that the names of the activities are used to replace the activity ids in the dataset. Finally the script melts the dataset by activity and subject, in order to cast the data in a tidy dataset containing the mean of each variable for each activity of each subject and writes this data in a text file.
