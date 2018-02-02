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

#Clean format
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format = '%d/%m/%Y %H:%M:%S', tz = 'GMT')
df[3:9] <- apply(df[3:9], 2, function(x) {as.numeric(as.character(x))})

#Create par&plots, save to png
png(filename = 'plot4.png', height = 480, width = 480, units = 'px')
par(mfrow=c(2,2))
with(df, plot(DateTime,Global_active_power, type = 'l', ylab = 'Global Active Power (kilowatts)', xlab = ''))
with(df, plot(DateTime, Voltage, type = 'l'))
plot(x = df$DateTime, y = df$Sub_metering_1, type = 'l', col = 'Black', xlab = '', ylab = 'Energy sub metering') + lines(x = df$DateTime, y = df$Sub_metering_2, type = 'l', col = 'red') + lines(x = df$DateTime, y = df$Sub_metering_3, type = 'l', col = 'blue') + legend('topright', border = 'white',legend = c('Sub_metering_1','Sub_metering_2', 'Sub_metering_3'), fill = c('black', 'red', 'blue'), bty = 'n', bg = 'n', cex = 0.7)
with(df, plot(DateTime,Global_reactive_power, type = 'l'))
dev.off()