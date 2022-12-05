library(tidyverse)

df<- read.csv("source_data/states_all_extended.csv")

colnames(df)<-str_to_lower(colnames(df))


df_wide <- pivot_wider(df, names_from="primary_key", values_from = "primary_key")

df_wide


sub_df <- subset(df_wide, df_wide$year==2011)

sub_df

summary(df)
dev.off()
hist(sub_df$avg_math_8_score,col="red")


NE_subset<-df %>% filter(state == "MASSACHUSETTS" | state == "MAINE" | state == "NEW_HAMPSHIRE" | state == "VERMONT" | state == "CONNECTICUT" | state == "RHODE_ISLAND") 

my.max <- function(x) ifelse( !all(is.na(x)), max(x, na.rm=T), NA)
my.min <- function(x) ifelse( !all(is.na(x)), min(x, na.rm=T), NA)

my.mean <- function(x) ifelse( !all(is.na(x)), mean(x, na.rm=T), NA)
my.sd <- function(x) ifelse( !all(is.na(x)), sd(x, na.rm=T), NA)
my.min(NE_subset$avg_math_4_score)

x<-NE_subset$avg_math_4_score
png("figures/NE_hist.png")
hist(x, breaks=10,col="red",xlab="Average NAEP Math Score for Grade 4 in New England",
     main="Histogram of NAEP Scores for New England")
dev.off()

png("figures/US_scatterplot.png")
pairs(select(df_wide, c("year", "total_revenue", "federal_revenue", "instruction_expenditure")), pch = 19)
dev.off()
