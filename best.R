# set working directory to path where data is stored
setwd(file.path("C:", "Users", "cnovacy", "Documents", "01 - Projects", "Code", "datasciencecoursera"))

# create function for "not in" to validate parameters passed in function
`%notin%` <- Negate(`%in%`)


## Part 2 - Finding hospital in a state with lowest 30-day death rate
## of outcome ("heart attack", "heart failure", "pneumonia") passed in function
best <- function(state, outcome) {
    
    ## read outcome data
    care_measure <- read.csv("outcome-of-care-measures.csv")
    
    ## get list of unique states from outcome data
    states <- unique(care_measure[, 7])
    
    ## check that state and outcome are valid
    if (state %notin% states) stop("invalid state")
    if (outcome %notin% c("heart attack", "heart failure", "pneumonia")) stop("invalid outcome")
    
    ## return hospital name in state with lowest 30-day death rate
    
    # filter df down to only state specified in parameter
    state_df <- care_measure[care_measure$State == state, ]

    # create subset of data based on outcome specified in parameter
    # sort data and return hospital with lowest death rate
    
    #identify columns to be selected based on outcome parameter entered
    if (outcome == "heart attack") {
        cols <- c(2, 11)
        
    } else if (outcome == "heart failure") {
        cols <- c(2, 17)
        
    } else {
        #identify columns to be selected
        cols <- c(2, 23)
    }
    
    # create subset df with specified columns
    df_sub <- state_df[,cols]
    
    # convert rates from factor to numeric
    df_sub[,2] <- as.numeric(as.character(df_sub[,2]))
    
    # remove NA values
    df_sub <- df_sub[complete.cases(df_sub),]
    
    # sort data by rates and then hospital name
    df_sub <- df_sub[order( df_sub[,2], df_sub[,1] ), ]
    
    # return name of hospital with lowest rate
    return(head(df_sub[,1], 1))
}