# Open up the first file and explore the data

# setwd(file.path("C:", "Users", "cnovacy", "Documents", "01 - Projects", 
#                "Code", "datasciencecoursera", "specdata"))

# read and open the first file
# pollution <- read.csv("001.csv")
# head(pollution)

# check to see how many rows there are in the Date column
# length(pollution$Date)

# look at the dimensions of the df
# 1461 rows and 4 columns
# dim(pollution)
 
# summarize structure of the file
# str(pollution)
 
# view result summary of data
# summary(pollution)
 
# shows structure info of the file and column names
# names(pollution)


# Part 1 - pollutantmean function - calculate mean of pollutant (sulfate 
# or nitrate) across specified list of monitors.

pollutantmean <- function(directory, id = 1:332, pollutant) {
    
    # set working directory to path where zip file is stored
    setwd(file.path("C:", "Users", "cnovacy", "Documents", "01 - Projects", 
                    "Code", "datasciencecoursera", directory))
    
    # store the list of all the files in the directory
    files <- list.files(full.names=TRUE)
    
    # create an empty data frame to store all the file data in
    df <- data.frame()
    
    # loop through files specified when func is called and append to df
    for (i in id) {
        df <- rbind(df, read.csv(files[i]))
    }
    
    # grab column index depending on what user entered for pollutant
    if (pollutant == "sulfate") {
        col <- 2
    } else {
        col <- 3
    }
    
    # find mean of pollutant specified by user
    mean(df[,col], na.rm=TRUE)

}