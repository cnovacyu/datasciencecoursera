# set working directory to path where data is stored
setwd(file.path("C:", "Users", "cnovacy", "Documents", "01 - Projects", "Code", "datasciencecoursera"))

# create function for "not in" to validate parameters passed in function
`%notin%` <- Negate(`%in%`)


## Part 4 - Returning hospitals from all states with rank specified for 30-day death rate
## of outcome ("heart attack", "heart failure", "pneumonia") passed in function
rankall <- function(outcome, num = "best") {
    
    ## read outcome data
    care_measure <- read.csv("outcome-of-care-measures.csv")
    
    ## get list of unique states from outcome data
    states <- unique(care_measure[, 7])
    
    ## check that outcome is valid
    if (outcome %notin% c("heart attack", "heart failure", "pneumonia")) stop("invalid outcome")
    
    ## return df with hospital names and sate for given rank for outcome parameter
    
    #identify columns to be selected based on outcome parameter entered
    if (outcome == "heart attack") {
        cols <- c(2, 7, 11)
        
    } else if (outcome == "heart failure") {
        cols <- c(2, 7, 17)
        
    } else {
        cols <- c(2, 7, 23)
    }
    
    # create subset df with specified columns from above
    df_sub <- care_measure[,cols]
    
    # convert rates from factor to numeric
    df_sub[,3] <- as.numeric(as.character(df_sub[,3]))
    
    # remove NA values
    df_sub <- df_sub[complete.cases(df_sub),]
    
    # sort data by state, rate, and then hospital name
    df_sub <- df_sub[order( df_sub[,2], df_sub[,3], df_sub[,1] ), ]
    
    # split the df by state to view ranked rates for each
    s <- split(df_sub, df_sub[,2])
    
    # identify the rank to identify for each state based on num parameter
    if (num == "best") {
        ranked <- lapply(s, function(x) x[1,1])
        
    } else if (num == "worst") {
      ranked <- lapply(s, function(x) x[nrow(x),1])

    } else {
      ranked <- lapply(s, function(x) x[num,1])
    }
    
    # retrieve the hospital names after lapply
    hospitals <- unlist(ranked)
    
    # retrieve all the states after lapply
    states <- names(ranked)
    
    # create and return completed df
    return(data.frame("hospital"=hospitals, "state"=states, row.names=states))
}