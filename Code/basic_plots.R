library(tidyverse)

df<- read.csv("source_data/states_all.csv")

colnames(df)<-str_to_lower(colnames(df))

df_wide <- pivot_wider(df, names_from="primary_key", values_from = "primary_key")

png("figures/US_hist_8_math.png")
ggplot(df, aes(avg_math_8_score, fill = state)) + geom_histogram(bins = 40) +
  scale_fill_manual(values = c("MASSACHUSETTS" = "blue","MAINE" = "red", "NEW_HAMPSHIRE"="yellow", "VERMONT"="green", "CONNECTICUT"="orange", "RHODE_ISLAND"="brown"))
while (!is.null(dev.list())) dev.off()

png("figures/US_hist_4_math.png")
ggplot(df, aes(avg_math_4_score, fill = state)) + geom_histogram(bins = 40) +
  scale_fill_manual(values = c("MASSACHUSETTS" = "blue","MAINE" = "red", "NEW_HAMPSHIRE"="yellow", "VERMONT"="green", "CONNECTICUT"="orange", "RHODE_ISLAND"="brown"))
while (!is.null(dev.list())) dev.off()

png("figures/US_hist_8_reading.png")
ggplot(df, aes(avg_math_8_score, fill = state)) + geom_histogram(bins = 40) +
  scale_fill_manual(values = c("MASSACHUSETTS" = "blue","MAINE" = "red", "NEW_HAMPSHIRE"="yellow", "VERMONT"="green", "CONNECTICUT"="orange", "RHODE_ISLAND"="brown"))
while (!is.null(dev.list())) dev.off()

png("figures/US_hist_4_reading.png")
ggplot(df, aes(avg_math_8_score, fill = state)) + geom_histogram(bins = 40) +
  scale_fill_manual(values = c("MASSACHUSETTS" = "blue","MAINE" = "red", "NEW_HAMPSHIRE"="yellow", "VERMONT"="green", "CONNECTICUT"="orange", "RHODE_ISLAND"="brown"))
while (!is.null(dev.list())) dev.off()

sub_df <- subset(df_wide, df_wide$year==2011)


NE_subset<-df %>% filter(state == "MASSACHUSETTS" | state == "MAINE" | state == "NEW_HAMPSHIRE" | state == "VERMONT" | state == "CONNECTICUT" | state == "RHODE_ISLAND") 

x<-NE_subset$avg_math_4_score

png("figures/NE_hist.png")
hist(x, breaks=10,col="red",xlab="Average NAEP Math Score for Grade 4 in New England",
     main="Histogram of NAEP Scores for New England")
while (!is.null(dev.list())) dev.off()

png("figures/US_hist.png")
ggplot(sub_df, aes(avg_math_4_score, fill = state)) + geom_histogram(bins = 40) +
  scale_fill_manual(values = c("MASSACHUSETTS" = "blue","MAINE" = "red", "NEW_HAMPSHIRE"="yellow", "VERMONT"="green", "CONNECTICUT"="orange", "RHODE_ISLAND"="brown"))
while (!is.null(dev.list())) dev.off()

png("figures/US_scatterplot.png")
pairs(select(df_wide, c("year", "total_revenue", "federal_revenue", "instruction_expenditure")), pch = 19)
while (!is.null(dev.list())) dev.off()
