# Read data
data <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?")
                      
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Extract subset 
data_subset <- subset(data, subset=(Date == "2007-02-01" |  Date == "2007-02-02")) # just the two days

globalActivePower <- as.numeric(data_subset$Global_active_power)

date_time <- as.POSIXct(paste(data_subset$Date, data_subset$Time), format="%Y-%m-%d %H:%M:%S")

png("plot2.png", width=480, height=480)
plot(date_time, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

