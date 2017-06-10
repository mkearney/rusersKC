---
framework   : "html5slides"  # {io2012, html5slides, shower, dzslides, ...}
revealjs    : {theme: "Default", transition: cube}
widgets     : [bootstrap]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
url         : {lib: "."}
hitheme     : monokai
knit        : slidify::knit2slides
--- .transition

<h2></h2>

<link rel="stylesheet" href="./frameworks/html5slides/default/html5slides.css">

<br>
<br>

<h1 class="mytitle">Twitter data for everyone:<br>
An introduction to rtweet</h1>

<p class="titleinfo">Michael W. Kearney<br>
Assistant Professor<br>
School of Journalism<br>
Informatics Institute<br>
University of Missouri</p>

---

## My background
**Education**
- PhD in Communication Studies from KU
  - Grad minor in quantitative psychology
  - Center for Research Methods & Data Analysis

**Research**
- Interests are partisanship, selective exposure, new media
- Dissertation entitled...

---

## &nbsp;

![](images/diss.png)

---

## &nbsp;

![](images/rtweetpkg.png)

---

## Agenda
- Twitter APIs
- Getting started with rtweet
  - Authorization token(s)
  - Package resources

- Quick tour of rtweet functions
  - Friends/followers
  - Users/tweets

--- .transition

## &nbsp;

<h1 class="mytransition">Twitter APIs</h1>

---

## Twitter data
- Twitter makes data available via Application Program Interfaces
  (API)
  - **API**: protocols for making and sending requests

- Twitter APIs of interest:
  - **REST**: Search, read profile info, post Tweets
  - **Streaming**: Monitor tweets in real-time

---

## Package resources
- Website: [mkearney.github.io/rtweet](https://mkearney.github.io/rtweet)
- Vignettes:


```r
## Authorizing API access
vignette(topic = "auth", package = "rtweet")

## Overview
vignette(topic = "intro", package = "rtweet")

## Streaming API
vignette(topic = "stream", package = "rtweet")
```

--- .transition

## &nbsp;

<h1 class="mytransition">Getting started with rtweet</h1>

---

## Installing and loading rtweet


```r
## download from CRAN
install.packages("rtweet")

## or download dev version from Github
if (!"devtools" %in% installed.packages()) {
    install.packages("devtools")
}
devtools::install_github("mkearney/rtweet")

## load rtweet
library(rtweet)
```

---

## Create Twitter App
- [https://apps.twitter.com](apps.twitter.com)
- For call back enter `http://127.0.0.1:1410`

![](images/auth1.png)

---

## Keys and access tokens

![](images/auth2.png)

---

## Copy keys

![](images/auth3.png)

---

## Create token


```r
## whatever name you assigned to your created app
appname <- "rtweet_token"

## api key (example below is not a real key)
key <- "XYznzPFOFZR2a39FwWKN1Jp41"

## api secret (example below is not a real key)
secret <- "CtkGEWmSevZqJuKl6HHrBxbCybxI1xGLqrD5ynPd9jG0SoHZbD"

## create token named "twitter_token"
twitter_token <- create_token(
    app = appname,
    consumer_key = key,
    consumer_secret = secret)
```

---

## Save token


```r
## path of home directory
home_directory <- path.expand("~/")

## combine with name for token
file_name <- file.path(home_directory, "twitter_token.rds")

## save token to home directory
saveRDS(twitter_token, file = file_name)
```

## Set environment variable


```r
## On my mac, the .Renviron text looks like this:
##     TWITTER_PAT=/Users/mwk/twitter_token.rds

## assuming you followed the procodures to create "file_name"
##     from the previous code chunk, then the code below should
##     create and save your environment variable.
cat(paste0("TWITTER_PAT=", file_name),
    file = file.path(home_directory, ".Renviron"),
    append = TRUE)
```

--- .transition

## &nbsp;

<h1 class="mytransition">rtweet functions</h1>

---

## Streaming


```r
## comey stream
comes <- stream_tweets("comey,trump", timeout = 60 * 3)

## get plain text
twt <- plain_tweets(comes$text, include_hashtags = TRUE)

## sentiment analysis
sa <- syuzhet::get_nrc_sentiment(twt)
comes <- tibble::as_tibble(cbind(comes, sa))
```

--- .dark3

## Sentiment analysis
<br>
<div style="margin-left: auto; margin:right: auto;">
<img class="sentanalysis" src="images/comey.png" alt="comey">
</div>

--- .dark3

## &nbsp;

<div style="margin-left: auto; margin:right: auto;">
<img class="sentanalysis" src="images/statecomey.png" alt="statecomey">
</div>

--- .dark3

## &nbsp;

![](images/worlddensity.png)

![](images/popdensity.jpg)

--- .sentanalysis

## &nbsp;

![](images/sentanalysisprimary.png)

--- .sentanalysis

## User networks
- In my dissertation, I tracked user networks on Twitter during the
  2016 election
- Republican group: users who followed one or more of the following:
  - Sean Hannity, Sarah Palin, Fox News Politics, and Drudge Report
- Democrat group: users who followed one or more of the following:
  - Rachel Maddow, Paul Krugman, HuffPost Politics, and Salon

--- .sentanalysis

## &nbsp;

![](images/ddr2.png)

--- .netanalysis

## &nbsp;

![](images/polrnetwork.png)



--- .transition

## &nbsp;

<h1 class="mytransition">That's it \o/<br><br>Thanks!</h1>


---


```r
## load state data
data("state")

## initialize vector
state_tweets <- vector("list", 50)

## loop through 50 states
for (i in seq_along(state_tweets)) {
    state_tweets[[i]] <- search_tweets(
        paste0("comey OR trump geocode:", state.center$y[i], ",",
               state.center$x[i], ",", "50mi"),
    )
}
```

---

## Packages
- httr
- jsonlite
- devtools