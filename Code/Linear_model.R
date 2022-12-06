library(tidyverse)


df<- read.csv("source_data/states_all.csv",stringsAsFactors=F)
colnames(df)<-str_to_lower(colnames(df)) 
df

df$state <- str_replace_all(df$state, '_', ' ')

df <- df[!(is.na(df$total_expenditure)), ]

df <- df[!(is.na(df$avg_math_4_score)), ]

min(df$avg_math_8_score)

NE_subset<-df %>% filter(state == "MASSACHUSETTS" | state == "MAINE" | state == "NEW HAMPSHIRE" | state == "VERMONT" | state == "CONNECTICUT" | state == "RHODE ISLAND") 

model <- lm(avg_math_8_score ~total_expenditure, data = df)
summary(model)
probabilities <- model %>% predict(df, type = "response")

summary(probabilities)

ggplot(df, mapping=aes(x=avg_reading_4_score, y=total_expenditure)) + geom_point() +
  stat_smooth(method="lm", color="blue", se=FALSE,
              method.args = list(family=binomial)) +xlab("Average Year 8 Math Score")+ylab("State Revenue")+ggtitle("How State Revenue Influences Math Scores")
