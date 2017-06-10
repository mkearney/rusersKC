slidify::knit2slides("docs/slides.Rmd")

browseURL("slides.html")
library(rtweet)
library(ggplot2)


djt <- read.csv("data/realdonaltrump-fullarchive.csv",
                stringsAsFactors = FALSE)
head(djt)

sa_trump <- syuzhet::get_nrc_sentiment(djt$text)
head(sa_trump)

highlighter : "highlight.js" # {highlight.js, prettify, highlight}
hitheme     : tomorrow      #
