#Download dataset
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
f <- read.csv(unz(temp, 'household_power_consumption.txt'), sep = ';', header = TRUE)
unlink(temp)

#import from dir
##f <- read.csv('household_power_consumption.txt', sep = ";", skip = 0, header = TRUE)
##head(f)

#Select only 1-2/Feb/2007
f[f$Date == '1/2/2007'|f$Date=='2/2/2007',] -> df

#Clean double and date time
df$Global_active_power <- as.double(as.character(df$Global_active_power))
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format = '%d/%m/%Y %H:%M:%S', tz = 'GMT')

#plot and save
png(filename = 'plot2.png', height = 480, width = 480, units = 'px')
plot(df$DateTime, df$Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = '')
dev.off()