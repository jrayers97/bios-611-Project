#try to predict the state based on their exam scores
install.packages("ggfortify")
library(ggfortify)
library(tidyverse)

df<- read.csv("source_data/states_all.csv")
colnames(df)<-str_to_lower(colnames(df)) 
df

sub_df <- df %>% filter(!state=="DODEA" & !state=="NATIONAL" & !state=="DISTRICT_OF_COLUMBIA")


sub_df$state <- str_replace_all(sub_df$state, '_', ' ')

df_wide<-pivot_wider(sub_df, names_from="primary_key", values_from = "primary_key")
df_wide

d<-df_wide[, 2:24]
d



NE_subset<-df %>% filter(state == "MASSACHUSETTS" | state == "MAINE" | state == "NEW_HAMPSHIRE" | state == "VERMONT" | state == "CONNECTICUT" | state == "RHODE_ISLAND") 

NE_subset
#loop over all columns and subsitute NA values for 0 to preform the PCA
for(i in 2:25){
  NE_subset[[i]][is.na(NE_subset[[i]])] <-0
}

numericNE<-NE_subset[,3:25]
resultsNE <- prcomp(numericNE, scale = TRUE)
summary(resultsNE)

PCA_0<-autoplot(resultsNE,data = NE_subset, colour = 'state',shape='state', frame=T,label=TRUE,label.size = 2)


#results <- prcomp(d, scale = TRUE)
#summary(results)

#autoplot(results,data = df_wide, colour = 'avg_reading_4_score',label=TRUE,label.size = 1)

#PCA_0<-ggplot(results$x %>% as_tibble() %>% select(PC1, PC2), aes(PC1, PC2,color = df_wide$year)) +
#  geom_point()+ggtitle("PCA with 0's inserted at NA values");


PCA_0;

ggsave("figures/PCA_0.png",plot=PCA_0);

