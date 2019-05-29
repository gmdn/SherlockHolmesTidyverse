# load Damiani's list of terms
terms <- read.csv(file = "./data/SherlockTerms.txt", 
                  header = FALSE, 
                  colClasses = c("character", "character", "numeric"), 
                  stringsAsFactors = FALSE)

# give names 
names(terms) <- c("ita", "eng", "count")

# lowercase and trim whitespace 
terms$ita <- trimws(tolower(terms$ita))
terms$eng <- trimws(tolower(terms$eng))

str(terms)
#print(terms)
#dim(terms)
