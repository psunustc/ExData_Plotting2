plot6<-function(){
    NEI <- readRDS("summarySCC_PM25.rds")
    SCC <- readRDS("Source_Classification_Code.rds")
    library(reshape)
    data <- NEI[NEI$fips%in%c("24510", "06037"), ] 
    coalIndex <- data.frame(as.character(SCC$SCC)[
                    grep(pattern = "Mobile", x = SCC$EI.Sector, ignore.case = T)], 
                    stringsAsFactors =F)
    names(coalIndex) <- "SCC"
    data <- merge(x = data, y = coalIndex, by.x = "SCC", by.y = "SCC", all = F)
    
    data <- with(data, tapply(Emissions, INDEX = list(year, fips), sum))
    Year <- as.numeric(rownames(data))
    data <- as.data.frame(cbind(Year, data), row.names = F)
    names(data) <- c("year", "Los_Angeles", "Baltimore_city")
    data <- melt(data, id = "year")
    
    ggplot(data=data, aes(x=year, y=value/1000, colour=variable)) +
        geom_line() + 
        scale_x_continuous(breaks=Year) + 
        ylab("Emissions(in thousand Tons)") +
        ggtitle("Motor vehicle sources")
    ggsave(filename = "plot6.png", width = 12, height = 8, units = "cm", bg = "white")
}