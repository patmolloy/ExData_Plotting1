# Read data
data <- read.csv("./data/household_power_consumption.txt", header=T, sep=';', na.strings="?")
                      
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Extract subset 
data_subset <- subset(data, subset=(Date == "2007-02-01" |  Date == "2007-02-02")) # just the two days

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