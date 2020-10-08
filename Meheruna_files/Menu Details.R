library("tidyr")
library(dplyr)
library("tidyverse")
library(reshape2)

menu <- read.csv(file = 'Ingredients.csv')
head(menu_details)

## Cleaning & Bending data ###
menu$ingredients <- gsub("\"", "", menu$ingredients)

## Considered upto 16 ingredients seperated by ',' , we may increase the columns in future.#####
lc<- separate(menu, col=ingredients, into= c('col1', 'col2','col3','col4','col5','col6','col7','col8','col9','col10',
                                             'col11','col12','col13','col14','col15'), sep=",")

## Added the separated and cleaned columns with the main DF ###
blended<- cbind(menu, lc)

menu_df<-select (blended,-c(1))
menu_df$col1 <- gsub("[[:punct:]]", "", menu_df$col1)
menu_df$ingredients <- gsub("[[:punct:]]", "", menu_df$ingredients)

write.csv(menu_df,"menu_df.csv", row.names = TRUE)

var<-1
menu_df<-cbind(menu_df,var)

### Pivot Table #######
piv_col1<-menu_df%>%select(id,col1,var)
wide_col1 <- pivot_wider(piv_col1, names_from = col1, values_from = var,values_fill = 0)

piv_col2<-menu_df%>%select(id,col2,var)
wide_col2 <- pivot_wider(piv_col2, names_from = col2, values_from = var,values_fill = 0)


piv_col3<-menu_df%>%select(id,col3,var)
wide_col3 <- pivot_wider(piv_col3, names_from = col3, values_from = var,values_fill = 0)


Merged_cols<-cbind(wide_col1,wide_col2,wide_col3)

#write.csv(df.wide,"menu_df_col1.csv", row.names = TRUE)


