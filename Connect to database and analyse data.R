#Connect to  SQL Server
library(odbc)
library(ggplot2)
library(dplyr)

con <- DBI::dbConnect(odbc::odbc(), Driver = "SQL Server", Server = "DAVE-PC", 
                      Database = "NYCTaxi_Sample", Trusted_Connection = "True")

#extract some data
df <- dbGetQuery(con, "SELECT TOP 5000
                        	medallion,
                        	fare_amount,
                        	trip_distance
                        
                        FROM
                        	dbo.nyctaxi_sample
                        
                        TABLESAMPLE(5000 ROWS)")

#View the record
View(df)

summary(df)


summary(df$trip_distance)
summary(df$fare_amount)


#Plot
ggplot(df, aes(x = trip_distance, y = fare_amount)) +
  geom_point(alpha = 0.5) + 
  geom_smooth(method = "lm") +
  xlab("Distance") +
  ylab("Fare")

#Check linear regression
summary(lm(df$fare_amount ~ df$trip_distance))
