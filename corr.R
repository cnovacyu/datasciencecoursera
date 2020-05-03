#Part 2 - Read files and report number of complete observations
corr <- function(directory, threshold = 0) {
    
    # set working directory to path where zip file is stored
    setwd(file.path("C:", "Users", "cnovacy", "Documents", "01 - Projects", 
                    "Code", "datasciencecoursera", directory))
    
    # store the list of all the files in the directory
    files <- list.files(full.names=TRUE)
    
    # create df with all the files and their complete cases
    df_com <- complete(directory, id=1:332)
    
    # subset from df_com where cases are higher than the threshold specified
    df_sub <- subset(df_com, nobs > threshold)
    
    # create a df to store
    corr_results <- numeric(0)
    
    # loop through files that met threshold and dump data into new df
    for (i in df_sub[, c("id")]) {
         # read each file
         data <- read.csv(files[i])
         
         sulfate <- data[, c("sulfate")]
         nitrate <- data[, c("nitrate")]
         
         df <- rbind(df, cor(sulfate, nitrate))
     }
    
    df
   
}