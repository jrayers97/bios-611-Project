library(tidyverse)

df<- read.csv("source_data/states_all.csv")
colnames(df)<-str_to_lower(colnames(df))

df;

sub_df <- subset(df, df$year==1992, select=c(state, federal_revenue));

unique(sub_df$state);
unique(sub_df$federal_revenue);

write.csv(df, "./edited_data/df_tided.csv")

states_revenue<- ggplot(data=sub_df, aes(state,federal_revenue)) + geom_point() + 
  theme(axis.text.x=element_text(angle = -90, hjust = 0));


ggsave("figures/states_revenue.png",plot=states_revenue);
