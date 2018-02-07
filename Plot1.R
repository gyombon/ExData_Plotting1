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

## Create histogram "Global Active Power"
hist(data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

## Save histogram as "plot1.png", in working directory, and close device.
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()