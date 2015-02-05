# Read data
data <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?")
                      
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Extract subset 
data_subset <- subset(data, subset=(Date == "2007-02-01" |  Date == "2007-02-02")) # just the two days

globalActivePower <- as.numeric(data_subset$Global_active_power)
png("plot1.png", width=480, height=480)
hist(globalActivePower, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()