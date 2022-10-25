library(tidyverse)

df<- read.csv("source_data/states_all.csv")
colnames(df)<-str_to_lower(colnames(df))

df_wide <- pivot_wider(df, names_from="primary_key", values_from = "primary_key")
df_wide

sub_df_wide <- subset(df_wide, df$state=="NORTH_CAROLINA", select=c(year, grades_all_g));
sub_df_wide;
ggplot(data=sub_df_wide, aes(year,grades_all_g)) + geom_line() + 
  theme(axis.text.x=element_text(angle = -90, hjust = 0))
