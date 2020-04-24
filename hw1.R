# open and read hw 1 data file for 11) - 20)
data <- read.csv("hw1_data.csv")

# 11) return the column names of the dataset
colnames(data)

# 12) grab the first two rows of the data
head(data, 2)

# 13) return number of rows in data set
nrow(data)

# 14) grab the last two rows of the data
tail(data, 2)

# 15) grab the element in the 47th row, Ozone column (1) 
data[[c(1, 47)]]

# 16) return num of missing values in Ozone column
sum(is.na (data$Ozone))

# 17) return mean of Ozone column and exclude NA values
mean(data$Ozone, na.rm = TRUE)

# 18) return subset of dataset where Ozone > 31 and Temp > 90
df <- data.frame(data)
df.sub <- subset(df, Ozone > 31 & Temp > 90)
mean(df.sub$Solar.R, na.rm = TRUE)

# 19) return the mean of Temp when Month is 6
df.m_6 <-subset(df, Month == 6)
mean(df.m_6$Temp)

# 20) return max Ozone value for May
df.m_5 <- subset(df, Month == 5)
max(df.m_5$Ozone, na.rm = TRUE)