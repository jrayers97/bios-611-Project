library(tidyverse)
install.packages("missMDA")
install.packages("reshape2")
library(missMDA)
library(dplyr)
library(reshape2)


df<- read.csv("source_data/states_all.csv",stringsAsFactors=F)
colnames(df)<-str_to_lower(colnames(df)) 
df

df$state <- str_replace_all(df$state, '_', ' ')
NE_subset<-df %>% filter(state == "MASSACHUSETTS" | state == "MAINE" | state == "NEW HAMPSHIRE" | state == "VERMONT" | state == "CONNECTICUT" | state == "RHODE ISLAND") 


#estimate the number of principle components 
nb_ne<-estim_ncpPCA(NE_subset[,3:ncol(NE_subset)], ncp.min=0, ncp.max=5)

#perform the imputation 
NE_impute<-imputePCA(NE_subset[,3:ncol(NE_subset)],ncp=nb_ne$ncp)

correlation <-round(cor(NE_impute$completeObs[,1:23]),2)

melt_correlation<-melt(correlation)
cor_matrix<-ggplot(data = melt_correlation, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile()+ theme(axis.text.x=element_text(angle = -90, hjust = 0));
ggsave("figures/cor.png",plot=cor_matrix)
