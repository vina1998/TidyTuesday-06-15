tweets <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-06-15/tweets.csv')
library(tidyverse)
library(tidytext) 
library(textdata)
library(wordcloud)
library(wordcloud2)
library(dplyr)
library(patchwork)
library(ggimage)
library(cowplot)

most_traction <- tweets %>% as_tibble() %>% unnest_tokens(word, content) 
#remove words that aren't useful like "to" and "of" 
most_traction <- most_traction %>% anti_join(stop_words) 
#most common words in titles
test <- most_traction %>% count(word, sort = TRUE) 
test %>% filter(n>500) %>% ggplot(aes(n,word)) +geom_col()
#get joy lexicon 
nrc_joy <- get_sentiments("nrc") %>%  filter(sentiment == "joy")
#positive words
joy_words <- most_traction %>%inner_join(nrc_joy) %>% count(word, sort = TRUE) 

nrc_disgust <- get_sentiments("nrc") %>%  filter(sentiment == "disgust")
#disgust words
disgust_words <- most_traction %>%inner_join(nrc_disgust) %>% count(word, sort = TRUE)
wordcloud2(joy_words,shape ="circle",  color = "goldenrod",size=0.5,backgroundColor = "bisque")
wordcloud2(disgust_words,shape ="circle",  color = "tan",size=0.5,backgroundColor = "bisque")
ggplot()+draw_image( image = "/Users/thivina/Documents/TidyTuesday-06-15/img/joy.png", x=0,y=0,width = 1, height=0.6) +draw_image( image = "/Users/thivina/Documents/TidyTuesday-06-15/img/disgust.png", x=0,y=0.5,width = 1, height=0.6) 

