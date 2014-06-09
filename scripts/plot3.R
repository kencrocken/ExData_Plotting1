# --- Check if data directory exists in working directory, if not create the directory
if (!file.exists("./data")) {
    dir.create("./data")
}

# --- Check if data file exists, if not download data and unzip to data directory
if (!file.exists("./data/household_power_consumption.txt")) {
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileUrl, destfile = "./data/household_power_consumption.zip", method = "curl")
    dateDownloaded <- date()
    unzip("./data/household_power_consumption.zip", exdir = "./data")
}

# --- Read data
hh_power <- read.table("./data/household_power_consumption.txt", header = TRUE, 
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

# --- Check if figure directory exists, if not - create the directory
if (!file.exists("./data/figure")) {
    dir.create("./data/figure")
}

# --- plot to PNG file
png(file = "./data/figure/plot3.png", width = 480, height = 480)
plot(hh_power$datetime, hh_power$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(hh_power$datetime, hh_power$Sub_metering_2, type = "l", col = "red")
lines(hh_power$datetime, hh_power$Sub_metering_3, type = "l",col = "blue")
legend("topright",legend=c("sub_metering_1","sub_metering_2","sub_metering_3"), 
       lty = c(1, 1, 1), lwd = c(1, 1, 1),col = c("black","red","blue"))
dev.off()