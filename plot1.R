library(sqldf)
library(dplyr)
library(data.table)

# Exploratory Data Anaysis (EDA): 
# Goal: Find patterns in data and understand its properties.
# This R script does the following:
# 1/ Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
# 2/ Name each of the plot files as plot1.png, plot2.png, etc.
# 3/ Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot. The code file include code for reading the data so that the plot can be fully reproduced; including the code that creates the PNG file.
# Adds the PNG file and R code file to the top-level folder of the git repository https://github.com/chalendony/exploring-data.git


file  = "household_power_consumption.txt"
system("head -n 10 household_power_consumption.txt")
# since the file is large we read only a subset for two days of data
tab <- read.csv2.sql(file,sql = "select * from file where Date LIKE '1/2/2007' or Date LIKE '2/2/2007' ",  sep = ";")
# check to see if miss values present
sapply(tab, function(x) sum(is.na(x)))

## Format Date and Time variables: 
tab <- as.data.table(tab)

tab[, Datefmt := as.Date(Date, format = "%d/%m/%Y")]
tab[, Timefmt := as.POSIXct(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S")]
# head(tab)
png(filename = "plot1.png", width = 480, height = 480)
hist(x = as.vector(tab$Global_active_power),main = "Global Active Power",  col = "red", xlab = "Global Active Power (kilowatts)")
dev.off()
