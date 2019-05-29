#source("https://bioconductor.org/biocLite.R")
#biocLite("MeSH.db")
#biocLite("MeSH.AOR.db")
#biocLite("MeSH.PCR.db")

library(MeSH.db)
library(MeSH.AOR.db)
library(MeSH.PCR.db)

columns(MeSH.db)
columns(MeSH.AOR.db)
columns(MeSH.PCR.db)


library("RSQLite")
SQL1 <- paste("SELECT DISTINCT MESHTERM, SYNONYM, CATEGORY",
              "FROM DATA")
res_mesh_syn <- dbGetQuery(dbconn(MeSH.db), SQL1)
#write.table(res_mesh_syn, file = "./data/MeSH_syn.txt")

library(tidyr)
library(dplyr)

res_mesh_syn  <- res_mesh_syn %>% 
  mutate(SYN_CLEAN = sapply(strsplit(x = res_mesh_syn$SYNONYM, split = "\\|"), 
                            FUN = function(x) x[1])) %>%
  select(MESHTERM, SYN_CLEAN)

write.table(res_mesh_syn, file = "./data/MeSH_syn.csv", sep = ";",
            quote = F, row.names = F, col.names = T)


mesh_terms <- tolower(unique(res_mesh_syn$MESHTERM))
mesh_syns <- tolower(res_mesh_syn$SYN_CLEAN)

uni_terms <- unigram$word[which(unigram$word %in% mesh_terms)]
uni_syns <- unigram$word[which(unigram$word %in% mesh_syns)]

write.csv(sort(uni_terms), file = "./data/uni_terms.txt", quote = F, row.names = F)
write.csv(sort(uni_syns), file = "./data/uni_syns.txt", quote = F, row.names = F)

big_terms <- bigram$word[which(bigram$word %in% mesh_terms)]
big_syns <- bigram$word[which(bigram$word %in% mesh_syns)]

write.csv(sort(big_terms), file = "./data/big_terms.txt", quote = F, row.names = F)
write.csv(sort(big_syns), file = "./data/big_syns.txt", quote = F, row.names = F)

tri_terms <- trigram$word[which(trigram$word %in% mesh_terms)]
tri_syns <- trigram$word[which(trigram$word %in% mesh_syns)]

write.csv(sort(tri_terms), file = "./data/tri_terms.txt", quote = F, row.names = F)
write.csv(sort(tri_syns), file = "./data/tri_syns.txt", quote = F, row.names = F)

#no quadgrams foundx
#quad_terms <- quadgram$word[which(quadgram$word %in% mesh_terms)]
#quad_syns <- quadgram$word[which(quadgram$word %in% mesh_syns)]

