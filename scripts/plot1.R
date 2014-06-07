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
png(file = "plot1.png", width = 480, height = 480)
hist(hh_power$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()