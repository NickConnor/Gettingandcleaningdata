# Markdown file for NickConnor's cleaning assignment

# First section consists of a series of commands to check for the requisite files. 
## If the files exist then it proceeds
## If the files don't exist then it proceeds to download them.
## Unzips and stores the UCI folder and sets root directory
## It also calls the plyr package 

# Reading in and merging the data tables
## Each of the data tables is read into working memory
## Subject, X and Y related tables are row bound
## they are in different directories in the unzipped folder, but that's fine, they are found using a modified paste command
## these files are then combined into three bound datasets

# Removal of non-mean and non-str
## starting here and removing the unwanted columns
## features are read from another text file to name headers
## "meanandstd" varible is created as a grep filter of only those headers containing -mean OR -std. (logical variable)
## X data is parsed by those columns

# Descriptive Activity Names 
## These are found in the activity_labels.txt file
## The names are parsed into the y-data linked to the numbers corresponding to the Activity name
## straightforward column names "activity" and "subject" were assigned to aid in merger.

# Compiled all datasets
## "Compiled" varible should now be clean of non-mean and non-str columns, also the id and the motion type.
## using the powerful "ddply" command I then split data frame, apply function (means), and return results in a new data frame named averages_of_data
## to further ensure clarity (or try to) i've melted and recast this set into a tidy set.
## Write the file and return a confirmation message. 