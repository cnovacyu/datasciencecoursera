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
    if (outcome == "heart attack") {
        cols <- c(2, 11)
        df_ht <- state_df[,cols]
        df_ht <- df_ht[complete.cases(df_ht),]
        df_ht <- df_ht[order( df_ht[,2], df_ht[,1] ), ]
        return(head(df_ht$Hospital.Name, 1))
              
    } else if (outcome == "heart failure") {
        cols <- c(2, 17)
        df_hf <- state_df[,cols]
        df_hf <- df_hf[complete.cases(df_hf),]
        df_hf <- df_hf[order(df_hf[,2], df_hf[,1]),]
        #return(head(df_hf$Hospital.Name, 1))
        return(head(df_hf))
        
    } else {
        cols <- c(2, 23)
        df_p <- state_df[,cols]
        transform(df_p, hf = as.numeric(df_p[,2]))
        df_p <- df_p[complete.cases(df_p),]
        df_p <- df_p[order(df_p[,2], df_p[,1]),]
        #return(head(df_p$Hospital.Name, 1))
        return(class(df_p$Hospital.Name))
        
    }
}