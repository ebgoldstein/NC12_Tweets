#NC12 tweets

#libraries
library(rtweet)
library(tidyverse)

# your app name
appname <- "YOUR_APP_NAME"

## api key
key <- "YOUR_KEY"

## api secret key
secret <- "YOUR_SECRET_KEY"

# create token named "twitter_token"
twitter_token <- create_token(
  app = appname,
  consumer_key = key,
  consumer_secret = secret)

#max 3200 statuses.
nc12 <- get_timeline("NCDOT_NC12", n = 3000)

## plot the frequency of tweets for each user over time
nc12 %>%
  ts_plot("weeks", trim = 1L) +
  ggplot2::geom_point() +
  ggplot2::theme_minimal() +
  ggplot2::theme(
    legend.title = ggplot2::element_blank(),
    legend.position = "bottom",
    plot.title = ggplot2::element_text(face = "bold")) +
  ggplot2::labs(
    x = NULL, y = NULL,
    title = "Frequency of Tweets by NC12",
    caption = "\nSource: Data collected from Twitter's REST API via rtweet"
  )

#find all mentions of overwash
nc12ow <- filter(nc12, grepl('overwash', text))

#save the overwash tweets
write_as_csv(nc12ow, "NC12_overwash", prepend_ids = TRUE, na = "",
             fileEncoding = "UTF-8")


#############
