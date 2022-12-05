library(tidyverse)
install.packages("usmap")
library(usmap)

df<- read.csv("source_data/states_all.csv")

colnames(df)<-str_to_lower(colnames(df))

sub_df <- df %>% filter(df$year==2011, !state=="DODEA" & !state=="NATIONAL" & !state=="DISTRICT_OF_COLUMBIA")


sub_df$state <- str_replace_all(sub_df$state, '_', ' ')

sub_df


texp11<-plot_usmap(data = sub_df, 
           regions="states", 
           values="total_expenditure")+ scale_fill_continuous(
             low = "white", high = "red", name = "Total Expendeture Per State in 2011", label = scales::comma
           ) +
  theme(legend.position = "right")

iexp11<-plot_usmap(data = sub_df, 
           regions="states", 
           values="instruction_expenditure")+ scale_fill_continuous(
             low = "white", high = "red", name = "Instructional Expendeture Per State in 2011", label = scales::comma
           ) +
  theme(legend.position = "right")

m811<-plot_usmap(data = sub_df, 
           regions="states", 
           values="avg_math_8_score")+ scale_fill_continuous(
             low = "white", high = "red", name = "Average Grade 8 NAEP Math Scores Per State in 2011", label = scales::comma
           ) +
  theme(legend.position = "right")

m411<-plot_usmap(data = sub_df, 
           regions="states", 
           values="avg_math_4_score")+ scale_fill_continuous(
             low = "white", high = "red", name = "Average Grade 4 NAEP Math Scores Per State in 2011", label = scales::comma
           ) +
  theme(legend.position = "right")

mEnroll<-plot_usmap(data = sub_df, 
                 regions="states", 
                 values="enroll")+ scale_fill_continuous(
                   low = "white", high = "red", name = "Enrollment Per State in 2011", label = scales::comma
                 ) +
  theme(legend.position = "right")


png("figures/US_Exp_11.png")
iexp11
dev.off()

png("figures/US_M411.png")
m411
dev.off()

png("figures/US_M_811.png")
m811
dev.off()

png("figures/US_texp11.png")
texp11
dev.off()

png("figures/US_mEnroll.png")
mEnroll
dev.off()
