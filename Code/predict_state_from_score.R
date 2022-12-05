#try to predict the state based on their exam scores

library(tidyverse)
install.packages("gbm")
library(gbm)

df<- read.csv("source_data/states_all.csv")
colnames(df)<-str_to_lower(colnames(df)) 


sub_df <- df %>% filter(!state=="DODEA" & !state=="NATIONAL" & !state=="DISTRICT_OF_COLUMBIA")


sub_df$state <- str_replace_all(sub_df$state, '_', ' ')

head(sub_df)
df_scores <- sub_df %>% filter(!avg_math_4_score == "NA")

unique(df_scores$year)

