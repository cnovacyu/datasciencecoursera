##create a special object that stores a numeric vector and cache's its mean

##create list containing a function to set the value of the vector, get the 
##value of the vector, set the value of the mean, and get the value of the mean
makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}


## checks to see if mean has already been computed with previous function. If
## yes, gets mean from cache and does not recompute inverse. If not, it will
## calculate the mean of the cache

cachemean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}