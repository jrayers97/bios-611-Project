library(tidyverse)
install.packages("ggfortify")
library(ggfortify)
install.packages("missMDA")
library(missMDA)

df<- read.csv("source_data/states_all.csv",stringsAsFactors=F)
colnames(df)<-str_to_lower(colnames(df)) 
df

df$state <- str_replace_all(df$state, '_', ' ')

NE_subset<-df %>% filter(state == "MASSACHUSETTS" | state == "MAINE" | state == "NEW HAMPSHIRE" | state == "VERMONT" | state == "CONNECTICUT" | state == "RHODE ISLAND") 


#estimate the number of principle components 
nb_ne<-estim_ncpPCA(NE_subset[,3:ncol(NE_subset)], ncp.min=0, ncp.max=5)

#perform the imputation 
NE_impute<-imputePCA(NE_subset[,3:ncol(NE_subset)],ncp=nb_ne$ncp)

#Now with the imputed values, we can do PCA
pca.fit.NE <- prcomp(NE_impute$completeObs, scale=TRUE)
pca.fit.NE$rotation
summary(pca.fit.NE)

PCA_NE_Impute<-autoplot(pca.fit.NE,data = NE_subset, colour = 'state',shape='state', frame=T,label=TRUE,label.size = 1)

PCA_NE_Impute
ggsave("figures/PCA_NE_Impute.png",plot=PCA_NE_Impute);
