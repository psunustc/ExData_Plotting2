plot3<-function(){
    #NEI <- readRDS("summarySCC_PM25.rds")
    #SCC <- readRDS("Source_Classification_Code.rds")
    library(ggplot2)
    library(reshape)
    data <- NEI[NEI$fips =="24510", -1]
    data <- tapply(X = data$Emissions, INDEX = list(data$year, data$type), mean)
    year <- as.numeric(rownames(data))
    data <- as.data.frame(cbind(year,
                    data), 
                    row.names= "F")
    data <- melt(data, id = "year")
    
    ggplot(data=data, aes(x=year, y=value, colour=variable)) +
        geom_line() + 
        scale_x_continuous(breaks=year) + 
        ylab("Emissions(in Tons)") +
        ggtitle("Total Emissions \nfrom 4 types of sources in Baltimore city")
    ggsave(filename = "plot3.png", width = 12, height = 8, units = "cm", bg = "white")
}