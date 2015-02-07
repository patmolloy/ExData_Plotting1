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

data_subset$Date <- as.Date(data_subset$Date, format="%d/%m/%Y")

globalActivePower <- as.numeric(data_subset$Global_active_power)

date_time <- as.POSIXct(paste(data_subset$Date, data_subset$Time), format="%Y-%m-%d %H:%M:%S")


png("plot4.png", width=480, height=480)

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

with(data_subset, {
  plot(Global_active_power~date_time, type="l", 
       ylab="Global Active Power", xlab="")
  plot(Voltage~date_time, type="l", 
       ylab="Voltage", xlab="")
  plot(Sub_metering_1~date_time, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~date_time,col='Red')
  lines(Sub_metering_3~date_time,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~date_time, type="l", 
       ylab="Global_Reactive_Power",xlab="")
})

dev.off()

