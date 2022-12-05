library(tidyverse)

df<- read.csv("source_data/states_all.csv")

colnames(df)<-str_to_lower(colnames(df))


df_wide <- pivot_wider(df, names_from="primary_key", values_from = "primary_key")

NE_subset<-df %>% filter(state == "MASSACHUSETTS" | state == "MAINE" | state == "NEW_HAMPSHIRE" | state == "VERMONT" | state == "CONNECTICUT" | state == "RHODE_ISLAND") 


NE_Exp_Year<- ggplot(data = NE_subset) + 
  geom_point(mapping = aes(x = year, y = instruction_expenditure)) +
  geom_smooth(mapping = aes(x = year, y = instruction_expenditure,color=state))


ggsave("figures/NE_Exp_Year.png",plot=NE_Exp_Year);