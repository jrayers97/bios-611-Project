library(tidyverse)

df<- read.csv("source_data/states_all.csv")

colnames(df)<-str_to_lower(colnames(df))

df_wide <- pivot_wider(df, names_from="primary_key", values_from = "primary_key")


sub_df <- subset(df_wide, df_wide$year==2011)


NE_subset<-df %>% filter(state == "MASSACHUSETTS" | state == "MAINE" | state == "NEW_HAMPSHIRE" | state == "VERMONT" | state == "CONNECTICUT" | state == "RHODE_ISLAND") 

x<-NE_subset$avg_math_4_score

png("figures/NE_hist.png")
hist(x, breaks=10,col="red",xlab="Average NAEP Math Score for Grade 4 in New England",
     main="Histogram of NAEP Scores for New England")
while (!is.null(dev.list())) dev.off()

png("figures/US_scatterplot.png")
pairs(select(df_wide, c("year", "total_revenue", "federal_revenue", "instruction_expenditure")), pch = 19)
while (!is.null(dev.list())) dev.off()
