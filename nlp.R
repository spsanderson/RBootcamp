# lib load ####
install.load::install_load(
  "tm"
  , "twitteR"
  , "wordcloud"
  , "RColorBrewer"
  , "e1071"
  , "class"
)

ckey = '' # key
skey = '' # access toekn
token = '' # (Access token)
stoken = '' # (Access token secret)

# Connect to Twitter ####
setup_twitter_oauth(
  consumer_key = ckey
  , consumer_secret = skey
  , access_token = token
  , access_secret = stoken 
)

soccer.tweets <- searchTwitter('python', n = 1000, lang = 'en')
soccer.text <-sapply(soccer.tweets, function(x) x$getText())
soccer.text <- iconv(soccer.text, 'UTF-8', 'ASCII')
soccer.corpus <- Corpus(VectorSource(soccer.text))

# DT Matrix ####
soccer.tm <- TermDocumentMatrix(
  soccer.corpus
  , control = list(
    removePunctuation = T
    , stopwords = c(
      'python' 
      , 'http'
      , stopwords('english')
    )
    , removeNumbers = T
    , tolower = T
    )
  )

# Convert to a matrix ####
term.doc.matrix <- as.matrix(soccer.tm)

# Get work Freq
word.freq <- sort(rowSums(term.doc.matrix), decreasing = T)
dm <- data.frame(
  word = names(word.freq)
  , freq = word.freq
)

# word cloud ####
wordcloud(dm$word, dm$freq, random.order = F, color = brewer.pal(8, "Dark2"))

