# --- Read data, assume that data is already present in the working directory
hh_power <- read.table("household_power_consumption.txt", header = TRUE, 
                       sep = ";", na.strings = "?")

# --- Subset into the appropriate data, coerce the data column into date data type
# --- and rbind the date ranges into a single data frame
hh_power$Date <- as.Date(hh_power$Date, format="%d/%m/%Y")
hh_power_01 <- subset(hh_power, hh_power$Date == "2007-02-01")
hh_power_02 <- subset(hh_power, hh_power$Date == "2007-02-02")
hh_power <- rbind(hh_power_01,hh_power_02)

# --- Paste the date and time data into a new column and coerce the datetime
hh_power$datetime <- paste(hh_power$Date,hh_power$Time, sep = ' ')
hh_power$datetime <- strptime(hh_power$datetime, format = "%Y-%m-%d %H:%M:%S")

# --- plot to PNG file
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot (hh_power$datetime,hh_power$Global_active_power, type = "l", xlab = "",
      ylab = "Global Active Power (kilowatts)")
plot (hh_power$datetime,hh_power$Voltage, type = "l", xlab = "",
      ylab = "Voltage")
plot(hh_power$datetime, hh_power$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(hh_power$datetime, hh_power$Sub_metering_2, type = "l", col = "blue")
lines(hh_power$datetime, hh_power$Sub_metering_3, type = "l",col = "red")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"), 
       lty = c(1, 1, 1), lwd = c(1, 1, 1),col = c("black","blue","red"))
plot (hh_power$datetime,hh_power$Global_reactive_power, type = "l", xlab = "",
      ylab = "Global_reactive_power")
dev.off()