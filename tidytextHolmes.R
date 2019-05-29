library(tidytext)
library(janeaustenr)
library(dplyr)
library(stringr)
library(gutenbergr)
library(widyr)

# 1661: the adventures of sh
# 108: the return of sh
# 834: the memoirs of sh
# 2350: his last bow
adventures_of <- gutenberg_download(c(1661, 108, 834))

str(adventures_of)

adv_of_rows <- adventures_of %>% 
  mutate(book = gutenberg_id) %>%
  group_by(book) %>%
  mutate(linenumber = row_number()) %>%
  select(book, linenumber, text) %>%
  ungroup()

tidy_adv <- adv_of_rows %>%
  unnest_tokens(word, text) %>%
  mutate(word = str_extract(word, "[a-z-]+")) %>%
  anti_join(stop_words)

tidy_adv %>%
  count(word, sort = TRUE)

tidy_adv %>% 
  pairwise_count(word, linenumber, sort = TRUE, upper = FALSE) %>%
  filter(item1 == "vitus" | item2 == "vitus")
