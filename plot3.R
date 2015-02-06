# Read data
# data <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?")

# data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Extract subset 
# data_subset <- subset(data, subset=(Date == "2007-02-01" |  Date == "2007-02-02")) # just the two days

# 06/02/2015 Let's try this instead to actually only read the subset in the first place !

require(sqldf)
file <- c("./data/household_power_consumption.txt")
data_subset <- read.csv.sql(file, header = T, sep=";", sql = "select * from file where (Date == '1/2/2007' OR Date == '2/2/2007')" )

data_subset$Date <- as.Date(data_subset$Date, format="%d/%m/%Y")
globalActivePower <- as.numeric(data_subset$Global_active_power)

date_time <- as.POSIXct(paste(data_subset$Date, data_subset$Time), format="%Y-%m-%d %H:%M:%S")

png("plot3.png", width=480, height=480)

with(data_subset, {
  plot(Sub_metering_1~date_time, type="l",
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~date_time,col='Red')
  lines(Sub_metering_3~date_time,col='Blue')
})
legend("topright", col=c("black", "red", "blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1, lwd=2)


dev.off()