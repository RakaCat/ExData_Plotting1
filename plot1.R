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

#Convert data to double
df$Global_active_power <- as.double(as.character(df$Global_active_power))

#plot
png(filename = 'plot1.png', height = 480, width = 480, units = 'px')
hist(df$Global_active_power, xlab = 'Global Active Power (kilowatts)', main = 'Global Active Power', col = 'red')
dev.off()
