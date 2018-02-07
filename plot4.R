## Read the source data, assuming it has been saved under its original name in the working directory.
data <- read.table("./household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Convert Date variables to Date class.
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Subset data set to data from the dates 2007-02-01 and 2007-02-02.
data <- subset(data, Date == "2007-02-01" | Date == "2007-02-02")

## Create new column combining Date and Time and convert it to Date/Time class.
data$DateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(data$DateTime)

## Remove incomplete observations
data <- data[complete.cases(data), ]

## Create Plot 4
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(data, {
          plot(Global_active_power ~ DateTime, type = "l", ylab = "Global Active Power", xlab = "")
          plot(Voltage ~ DateTime, type = "l", ylab = "Voltage", xlab = "Date Time")
          plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Global Active Power", xlab = "")
          lines(Sub_metering_2 ~ DateTime, col = "Red")
          lines(Sub_metering_3 ~ DateTime, col = "Blue")
          legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, bty = "n", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
          plot(Global_reactive_power ~ DateTime, type = "l", ylab = "Global Reactive Power", xlab = "Date Time")
})

## Save histogram as "plot1.png", in working directory, and close device.
dev.copy(png,"plot4.png", width=480, height=480)
dev.off()