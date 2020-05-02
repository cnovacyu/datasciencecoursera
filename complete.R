#Part 2 - Read files and report number of complete observations
complete <- function(directory, id = 1:332) {
    
    # set working directory to path where zip file is stored
    setwd(file.path("C:", "Users", "cnovacy", "Documents", "01 - Projects", 
                    "Code", "datasciencecoursera", directory))
    
    # store the list of all the files in the directory
    files <- list.files(full.names=TRUE)
    
    # create an empty data frame to store all the file data in
    df <- data.frame()
    
    # create an empty data frame to store the complete cases in
    df_obs <- data.frame()
    
    # loop through files specified when func is called
    for (i in id) {
        # append data from file to df
        df <- rbind(df, read.csv(files[i]))
        
        # subset from the df to just look at each file
        df_sub <- subset(df, ID==i)
        
        # store the file id
        obs_id <- df_sub[1,4]
        
        # calculate the complete cases for each file
        nobs <- sum(complete.cases(df_sub))
        
        # store id and complete cases into a vector
        obs_row <- c(obs_id, nobs)
        
        # add each id, complete case rows into a df
        df_obs <- rbind(df_obs, obs_row)
    }
    
    # rename columns in df
    colnames(df_obs) <- c("id", "nobs")
    
    # rename rows to num of rows
    row.names(df_obs) <- c(1: nrow(df_obs))
    
    # return df
    df_obs
}