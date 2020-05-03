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
    
    # create a new df to store cor results
    cor_results <- c()
    
    # loop through files that met threshold and calc corr for each file
    for (i in df_sub[, c("id")]) {
         
         #read each file and remove remove with NAs in sulfate and nitrate cols
         data <- read.csv(files[i])
         data_clean <- data[!is.na(data$sulfate) & !is.na(data$nitrate),]
         
         # create vectors with sulfate and nitrate data to calc cor
         sulfate <- data_clean[, c("sulfate")]
         nitrate <- data_clean[, c("nitrate")]
          
         # add cor results to a df for each file
         cor_results <- append(cor_results, cor(sulfate, nitrate))
     }
    
    # return first 6 rows of cor results
    cor_results
   
}