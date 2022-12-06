library(tidyverse)


df<- read.csv("source_data/states_all.csv",stringsAsFactors=F)
colnames(df)<-str_to_lower(colnames(df)) 
df

df$state <- str_replace_all(df$state, '_', ' ')


df <- df[!(is.na(df$total_expenditure)), ]
df <- df[!(is.na(df$instruction_expenditure)), ]
df <- df[!(is.na(df$avg_math_4_score)), ]
df <- df[!(is.na(df$enroll)), ]

min(df$avg_math_8_score)

NE_subset<-df %>% filter(state == "MASSACHUSETTS" | state == "MAINE" | state == "NEW HAMPSHIRE" | state == "VERMONT" | state == "CONNECTICUT" | state == "RHODE ISLAND") 

model_math_total <- lm(avg_math_8_score ~total_expenditure, data = df)
summary(model_math_total)
probabilities <- model_math_total %>% predict(df, type = "response")

summary(probabilities)

ggplot(df, mapping=aes(x=avg_reading_4_score, y=total_expenditure)) + geom_point() +
  stat_smooth(method="lm", color="blue", se=FALSE,
              method.args = list(family=binomial)) +xlab("Average Year 8 Math Score")+ylab("Total Expenditure")+ggtitle("How Total Expenditure Influences Math Scores")


model_reading_total <- lm(avg_reading_8_score ~total_expenditure, data = df)
summary(model_reading_total)
probabilities <- model_reading_total %>% predict(df, type = "response")

summary(probabilities)

ggplot(df, mapping=aes(x=avg_reading_4_score, y=total_expenditure)) + geom_point() +
  stat_smooth(method="lm", color="blue", se=FALSE,
              method.args = list(family=binomial)) +xlab("Average Year 8 Reading Score")+ylab("Total Expenditure")+ggtitle("How Total Expenditure Influences Reading Scores")

model_enroll_total <- lm(avg_reading_8_score ~enroll, data = df)
summary(model_enroll_total)
probabilities <- model_enroll_total %>% predict(df, type = "response")

summary(probabilities)

ggplot(df, mapping=aes(x=avg_reading_4_score, y=total_expenditure)) + geom_point() +
  stat_smooth(method="lm", color="blue", se=FALSE,
              method.args = list(family=binomial)) +xlab("Average Year 8 Reading Score")+ylab("Total Enrollment")+ggtitle("How Total Enrollment Influences Reading Scores")

