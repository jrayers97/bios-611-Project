library(tidyverse)
install.packages("ggfortify")
library(ggfortify)
install.packages("missMDA")
library(missMDA)

df<- read.csv("source_data/states_all.csv",stringsAsFactors=F)
colnames(df)<-str_to_lower(colnames(df)) 
df

sub_df <- df %>% filter(!state=="DODEA" & !state=="NATIONAL" & !state=="DISTRICT_OF_COLUMBIA")
sub_df$state <- str_replace_all(sub_df$state, '_', ' ')

df_wide<-pivot_wider(sub_df, names_from="primary_key", values_from = "primary_key")
df_wide

str(df)

#estimate the number of principle components 
nb<-estim_ncpPCA(df[,3:ncol(df)], ncp.min=0, ncp.max=5)

#perform the imputation 
df_impute<-imputePCA(df[,3:ncol(df)],ncp=nb$ncp)

#Now with the imputed values, we can do PCA
pca.fit <- prcomp(df_impute$completeObs, scale=TRUE)
pca.fit
pca.fit$rotation
summary(pca.fit)

PCA_Impute<-autoplot(pca.fit,data = df,label=TRUE,label.size = 2)

ggsave("figures/PCA_Impute.png",plot=PCA_Impute);
