
if (!"slidify" %in% installed.packages()) {
    devtools::install_github('ramnathv/slidify')
    devtools::install_github('ramnathv/slidifyLibraries')
}


slidify::knit2slides("../docs/index.Rmd")

browseURL("../docs/slides.html")
library(rtweet)
library(ggplot2)

usrs <- lookup_users(fds$user_id)
