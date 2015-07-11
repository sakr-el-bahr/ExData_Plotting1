
inputFilePath <- 'D:/Study/R/ExploratoryDA/CourseProject1/household_power_consumption.txt'

# number of lines to skip in file
# to get to line corresponding to measures
# of february 1st of 2007
skipLines <- 66637

# number of lines to read from file
# we need data for 2 days, each day of 24 hours
# each hour has 60 measures
linesToRead <- 2*24*60

# column classes
columnClasses <- c('character', 'character', rep('double', 7))

# column names
columnNames <- c('Date', 'Time', 'Global_active_power', 'Global_reactive_power', 'Voltage', 'Global_intensity', 'Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3')

# reading dataset
dt <- read.table(inputFilePath, sep=";", na.strings = '?', skip = skipLines, nrows = linesToRead, colClasses = columnClasses, col.names = columnNames)

# converting date and time columns into one column
# containgin datetime in POSIXlt format
DateTime <- with(dt[1:2], as.POSIXlt(paste(Date, Time), format = '%d/%m/%Y %H:%M:%S'))

# replacing Date and Time columns with POSIXlt DateTime column
df <- data.frame(DateTime, dt[3:9])

# getting rid of unnecessary data
rm(list = c('inputFilePath', 'skipLines', 'columnClasses', 'columnNames', 'linesToRead', 'dt', 'DateTime'))

outputFileName <- 'plot1.png'
# opening PNG graphic device 
png(filename = outputFileName)

# plotting
hist(df$Global_active_power, col = 'red', main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')

# closing PNG graphic device
dev.off()

print(paste('See result in file', outputFileName))

# cleaning up
rm(df, outputFileName)