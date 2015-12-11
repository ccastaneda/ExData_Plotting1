plot1 <- function() {
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

## plot the graph
        hist(febData$Global_active_power, 
		main = paste("Global Active Power"), 
		col="red", xlab="Global Active Power (Kilowatts)")
##       
	dev.copy(png, file="plot1.png", width=480, height=480)
      dev.off()

    	if(file.exists("./plot1.png"))
 	{
	print("Plot1.png has been saved in:")
	getwd()
	}
}
plot1()