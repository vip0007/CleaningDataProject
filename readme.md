Read Me 1. The run\_analysis.R contains the script to extract the tidy
data from the given data set 2. The file CodeBook.md contains the
relavent information of the final output tidyDataSet. 3. First the data
is read in the script from all the text file provided in the data set.
4. Then the test data, train data and the subjects are mergerd to get
the whole data in one table. 5. Then only mean and std related data are
extracted from data set. 6. Finally the mean is take for all the
variable grouped by Subject and Activity, using melt and dcast function.
