# Read data
# data <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?")
                      
# data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Extract subset 
# data_subset <- subset(data, subset=(Date == "2007-02-01" |  Date == "2007-02-02")) # just the two days

# 06/02/2015 Let's try this instead to actually only read the subset in the first place !

require(sqldf)
file <- c("./data/household_power_consumption.txt")
data_subset <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')" )

data_subset[data_subset == "?"] <- NA # deal with the question marks in the data and change to NA

globalActivePower <- as.numeric(data_subset$Global_active_power)
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
