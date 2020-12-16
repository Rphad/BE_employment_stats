library(ggplot2)
require(reshape2)

#The file saved from statbel is loaded
df <- read.csv("export.csv")

mdf <- subset(df, Gender=="Males")
fdf <- subset(df, Gender=="Females")

#Differences between men and women
Em_diff = mdf$Employment.rate - fdf$Employment.rate
Ac_diff = mdf$Activity.rate - fdf$Activity.rate
Unem_diff= mdf$Unemployment.rate - fdf$Unemployment.rate

diff_df <- data.frame( Region = mdf$Region, Year = mdf$Year, Employment.diff = Em_diff, Activity.diff=Ac_diff, Unemployment.diff = Unem_diff)

#For the plot containing Belgium only
mdff <- melt(diff_df, id.vars=c("Region","Year"), variable.name="Quantity")
mdff_global <- subset(mdff, Region=="")

#Unemployment rate in BE & regions
unem_all <- ggplot(df, aes(x = Year, y= Unemployment.rate, shape=Region, color=Gender)) + geom_point() + geom_line() + ggtitle('Unemployment rate in Belgium')

#Employment differences across regions
diff_all <- ggplot(mdff, aes(Year, value, shape=Region)) + geom_point(aes(colour=Quantity)) + geom_line(aes(colour=Quantity)) + ggtitle('Differences in employment related rates across genders and regions in Belgium')

#Employment diffs in BE only (clearer)
diff_be <- ggplot(mdff_global, aes(Year, value)) + geom_point(aes(colour=Quantity)) + geom_line(aes(colour=Quantity)) + ggtitle('Differences in employment related rates across genders in Belgium')


#Saving
ggsave(plot=unem_all, "unem_all.pdf")
ggsave(plot=diff_all, "diff_all.pdf")
ggsave(plot=diff_be, "diff_be.pdf")