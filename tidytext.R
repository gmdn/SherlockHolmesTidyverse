library(jsonlite)
metadata <- fromJSON("https://data.nasa.gov/data.json")
names(metadata$dataset)

nasa_title <- data_frame(id = metadata$dataset$`_id`$`$oid`, 
                         title = metadata$dataset$title)
nasa_title

nasa_desc <- data_frame(id = metadata$dataset$`_id`$`$oid`, 
                        desc = metadata$dataset$description)

nasa_title <- nasa_title %>% 
  unnest_tokens(word, title) %>% 
  anti_join(stop_words)

nasa_desc <- nasa_desc %>% 
  unnest_tokens(word, desc) %>% 
  anti_join(stop_words)

nasa_title %>%
  count(word, sort = TRUE)

title_word_pairs <- nasa_title %>% 
  pairwise_count(word, id, sort = TRUE, upper = FALSE)

title_word_pairs
