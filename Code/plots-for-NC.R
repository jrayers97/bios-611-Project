library(tidyverse)

df<- read.csv("source_data/states_all.csv")
colnames(df)<-str_to_lower(colnames(df))

df_wide <- pivot_wider(df, names_from="primary_key", values_from = "primary_key")
df_wide

unique(df_wide$state)

NC_df <- subset(df_wide, df$state=="NORTH_CAROLINA", select=c(year:avg_reading_8_score));


sub_df_year_grades <- subset(df_wide, df$state=="NORTH_CAROLINA", select=c(year, grades_all_g));
sub_df_year_grades;
ggplot(data=sub_df_year_grades, aes(year,grades_all_g)) + geom_line() + 
  theme(axis.text.x=element_text(angle = -90, hjust = 0))

sub_df_year_total_exp <- subset(df_wide, df$state=="NORTH_CAROLINA", select=c(year, total_expenditure));
sub_df_year_total_exp;
ggplot(data=sub_df_year_total_exp, aes(year,total_expenditure)) + geom_line() + 
  theme(axis.text.x=element_text(angle = -90, hjust = 0))

sub_df_year_reading <- subset(df_wide, df$state=="NORTH_CAROLINA", select=c(year, avg_math_8_score));
sub_df_year_reading;
ggplot(data=sub_df_year_reading, aes(year,avg_math_8_score)) + geom_point() + 
  theme(axis.text.x=element_text(angle = -90, hjust = 0))

