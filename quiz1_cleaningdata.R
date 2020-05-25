setwd(file.path("C:", "Users", "cnovacy", "Documents", "01 - Projects", "Code", "datasciencecoursera", "Data"))

# 1) Download housing data about Idaho. How many properties are worth $1m or more
# use sss06hid data dictionary

community <- read.csv("getdata_data_ss06hid.csv")

df <- data.frame(community)
df.sub <- subset(df, ST == '16' & VAL == 24)
nrow(df.sub)


# 3) Read natural gas data and read rows 18-23 and columns 7-15.
#What is the value of sum(dat$Zip*dat$Ext,na.rm=T)?

#fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
#download.file(fileUrl, destfile=file.path("C:", "Users", "cnovacy", "Documents", "01 - Projects", "Code", "datasciencecoursera", "Data"))
rowIndex <- 18:23
colIndex <- 7:15

dat <- read.xlsx("getdata_data_DATA.gov_NGAP.xlsx", sheetIndex = 1,
                  colIndex=colIndex, rowIndex=rowIndex)

sum(dat$Zip*dat$Ext,na.rm=T)


# 4) Read XML data on Balitmore resturants. How many restaurants have zipcode 21231?

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
doc <- xmlTreeParse(sub("s", "", fileUrl), useInternalNodes = TRUE)

# get the top node of the xml file: response
rootNode = xmlRoot(doc)
xmlName(rootNode)

#  get the names of the nodes within response node: row
names(rootNode)

# grab the first row node
rootNode[[1]][["row"]]

# return all the names within the first node: name, zipcode, neighborhood,
#councildistrict, policedistrict, location_1
names(rootNode[[1]][["row"]])

# grab the second node item (zipcode): returns text
rootNode[[1]][["row"]][[2]]

# grab the actual xmlValue of the second note item: 21206
xmlSApply(rootNode[[1]][["row"]][[2]],xmlValue)

# loop over all the zipcode nodes and get the contents as a string
zipcodes <- xpathSApply(rootNode, "//row/zipcode",xmlValue)

# count how many zipcodes = 21231
length(which('21231' == zipcodes))


# 5) Download housing data about Idaho. Use fread to load data.
# Caclulate fastest user times of various functions
require(data.table)
DT <- fread("getdata_data_ss06pid.csv", sep = ",", header=TRUE)

funcs = c("tapply(DT$pwgtp15,DT$SEX,mean)", "DT[,mean(pwgtp15),by=SEX]",
          "mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)",
          "mean(DT$pwgtp15,by=DT$SEX", "sapply(split(DT$pwgtp15,DT$SEX),mean)",
          "rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]")

times <- list()

#0.36  #0.24
ptm <- proc.time()
system.time({tapply(DT$pwgtp15,DT$SEX,mean)})
proc.time() - ptm

#0.50
ptm <- proc.time()
system.time({DT[,mean(pwgtp15),by=SEX]})
proc.time() - ptm

#0.39
ptm <- proc.time()
system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
proc.time() - ptm

#0.25
ptm <- proc.time()
system.time({mean(DT$pwgtp15,by=DT$SEX)})
proc.time() - ptm

#0.24
ptm <- proc.time()
system.time({sapply(split(DT$pwgtp15,DT$SEX),mean)})
proc.time() - ptm

#2.50
ptm <- proc.time()
system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
proc.time() - ptm



##Alternate code

library("data.table")

# the example below runs 100 times
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv", destfile = "ACS.csv")

DT <- fread("ACS.csv", sep = ",")



counter<- 0
myName<-"DT[,mean(pwgtp15), by=SEX]"
for (i in 1:100)
{
    a<- Sys.time()  
    DT[,mean(pwgtp15), by=SEX]
    b<-Sys.time()
    myTime<-b-a
    counter<- counter + myTime
}
cat("counter is: ", counter, "myName is: ", myName, "\n")



counter<- 0
myName<-"mean(DT[DT$SEX==1,]$pwgtp15);mean(DT[DT$SEX==2,]$pwgtp15)"
for (i in 1:100)
{
    a<- Sys.time()  
    mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)
    b<-Sys.time()
    myTime<-b-a
    counter<- counter + myTime
}
cat("counter is: ", counter, "myName is: ", myName, "\n")



counter<- 0
myName<-"sapply(split(DT$pwgtp15,DT$SEX),mean)"
for (i in 1:100)
{
    a<- Sys.time()  
    sapply(split(DT$pwgtp15,DT$SEX),mean)
    b<-Sys.time()
    myTime<-b-a
    counter<- counter + myTime
}
cat("counter is: ", counter, "myName is: ", myName, "\n")



counter<- 0
myName<-"tapply(DT$pwgtp15, DT$SEX, mean)"
for (i in 1:100)
{
    a<- Sys.time()  
    tapply(DT$pwgtp15, DT$SEX, mean)
    b<-Sys.time()
    myTime<-b-a
    counter<- counter + myTime
}
cat("counter is: ", counter, "myName is: ", myName, "\n")



counter<- 0
myName<-"mean(DT$pwgtp15, by=DT$SEX)"
for (i in 1:100)
{
    a<- Sys.time()  
    mean(DT$pwgtp15, by=DT$SEX)
    b<-Sys.time()
    myTime<- b-a
    counter<- counter + myTime
}
cat("counter is: ", counter, "myName is: ", myName, "\n")



#We convert the entire DATAFRAME to numeric
#Otherwise rowmeans will not work
DT <- data.frame(data.matrix(DT))


counter<- 0
myName<-"rowMeans(DT)[DT$SEX==1];rowMeans(DT)[DT$SEX==2]"

for (i in 1:100)
{
    a<- Sys.time()  
    rowMeans(DT)[DT$SEX==1];rowMeans(DT)[DT$SEX==2]
    b<-Sys.time()
    myTime<- b-a
    counter<- counter + myTime
}
cat("counter is: ", counter, "myName is: ", myName, "\n")