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

## Create Plot 3
with(data, {
          plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Global ACtive Power (kilowatts)", xlab = "")
          lines(Sub_metering_2 ~ DateTime, col = "Red")
          lines(Sub_metering_3 ~ DateTime, col = "Blue")
})
legend("topright", col = c("black", "red", "blue"), lwd = c(1, 1, 1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Save histogram as "plot1.png", in working directory, and close device.
dev.copy(png,"plot3.png", width=480, height=480)
dev.off()