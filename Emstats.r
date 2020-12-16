library(ggplot2)
require(reshape2)

df <- read.csv("export.csv")
#mutate(diff_genre = Hommes-Femmes,group_by(region))


ggplot(df, aes(x = Year, y= Unemployment.rate, shape=Region, color=Gender)) + geom_point() + geom_line()

mdf <- subset(df, Gender=="Males")
fdf <- subset(df, Gender=="Females")

Em_diff = mdf$Employment.rate - fdf$Employment.rate
Ac_diff = mdf$Activity.rate - fdf$Activity.rate
Unem_diff= mdf$Unemployment.rate - fdf$Unemployment.rate

diff_df <- data.frame( Region = mdf$Region, Year = mdf$Year, Employment.diff = Em_diff, Activity.diff=Ac_diff, Unemployment.diff = Unem_diff)

mdff <- melt(diff_df, id.vars=c("Region","Year"), variable.name="Quantity")
mdff_global <- subset(mdff, Region=="")


#ggplot(diff_df, aes(x=Year,shape=Region,)) + geom_point(aes(y=Unemployment.diff)) + geom_point(aes(y=Employment.diff)) + geom_point(aes(y=Activity.diff))  

ggplot(mdff, aes(Year, value, shape=Region)) + geom_point(aes(colour=Quantity)) + geom_line(aes(colour=Quantity))

ggplot(mdff_global, aes(Year, value)) + geom_point(aes(colour=Quantity)) + geom_line(aes(colour=Quantity))