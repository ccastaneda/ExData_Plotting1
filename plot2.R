plot2 <- function() {
## verify if file exists
	if(!file.exists("./household_power_consumption.txt"))
 	{
## read the data into a temp file data, unzip and delete the temp file
        data <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",data)
        dataFile <- unzip(data)
        unlink(data)
	}

	dataPower <- read.table("./household_power_consumption.txt", header=T, 
		sep=';', na.strings="?", nrows=2075259)
#	head(dataPower)

	dataPower$Date <- as.Date(dataPower$Date, format="%d/%m/%Y")
#	head(dataPower)

## Subsetting the data
	febData <- subset(dataPower, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
#	head(febData)
	
## convert the Date and Time variables to Date/Time timestamp col added
      febData <- transform(febData, TimeStamp=as.POSIXct(paste(Date, Time)))

## make variables numeric
	febData$Global_active_power <- as.numeric(as.character(febData$Global_active_power))
#	febData$Global_reactive_power <- as.numeric(as.character(febData$Global_reactive_power))
#	febData$Voltage <- as.numeric(as.character(febData$Voltage))
#	febData$Sub_metering_1 <- as.numeric(as.character(febData$Sub_metering_1))
#	febData$Sub_metering_2 <- as.numeric(as.character(febData$Sub_metering_2))
#	febData$Sub_metering_3 <- as.numeric(as.character(febData$Sub_metering_3)) 


##plot graph
	plot(febData$TimeStamp,febData$Global_active_power, 
		type="l", xlab="", ylab="Global Active Power (Kilowatts)")

##o/p plot to file       
	dev.copy(png, file="plot2.png", width=480, height=480)
      dev.off()

##check file
      if(file.exists("./plot2.png"))
 	{
	print("Plot2.png has been saved in:")
	getwd()
	}

}
plot2()