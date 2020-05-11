# set working directory to path where data is stored
setwd(file.path("C:", "Users", "cnovacy", "Documents", "01 - Projects", "Code", "datasciencecoursera"))

# read outcome-of-care-measures.csv data and store in variable
outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

# view # of columns
ncol(outcome)

#view # of rows
nrow(outcome)


## Part 1 - Plot 30-day mortality rates for heart attack in histogram

# grab the data from the 30-day death rates from heart attack column
outcome[, 11] <- as.numeric(outcome[, 11])

# make histogram with data
hist(outcome[, 11])