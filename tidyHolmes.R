require(tibble)
require(dplyr)

options(tibble.width = Inf)

# directory of Sherlock Holmes files
path <- "./CompleteCanon"

# get file
file_names <- list.files(path, full.names = F)

# create books
books <- tibble(text = character(), title = character())

#for (file_name in file_names) {
for (file_name in file_names) {

  # read book
  book <- tibble(text = readLines(paste0(path, "/", file_name)))
  # add title 
  book <- book %>% mutate(title = substr(file_name, 1, 4))
  # merge books
  books <- bind_rows(books, book)
  
}
head(books)

str(books)

library(tidytext)

doyle_unigrams <- books %>%
  unnest_tokens(unigram, text, token = "ngrams", n = 1)

unigram <- doyle_unigrams %>%  
  count(unigram, sort = TRUE) %>%
  rename(word = unigram, freq = n)

doyle_bigrams <- books %>%
  unnest_tokens(bigram, text, token = "ngrams", n = 2)

bigram <- doyle_bigrams %>%  
  count(bigram, sort = TRUE) %>%
  rename(word = bigram, freq = n)

doyle_trigrams <- books %>%
  unnest_tokens(trigram, text, token = "ngrams", n = 3)

trigram <- doyle_trigrams %>%  
  count(trigram, sort = TRUE) %>%
  rename(word = trigram, freq = n)

doyle_quadgrams <- books %>%
  unnest_tokens(quadgram, text, token = "ngrams", n = 4)

quadgram <- doyle_quadgrams %>%  
  count(quadgram, sort = TRUE) %>%
  rename(word = quadgram, freq = n)

ngram_models <- list(quadgram, trigram, bigram, unigram)
