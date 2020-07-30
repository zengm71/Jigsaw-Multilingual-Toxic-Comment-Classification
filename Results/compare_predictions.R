library(tidyverse)
setwd(paste0(getwd(), '/Prediction/'))
db = read_csv('03_xlm_roberta_large_unfreeze_olid_test_0shot.csv') %>% rename(oshot = toxic) %>%
  left_join(read_csv('03_xlm_roberta_large_unfreeze_olid_test_1k.csv') %>% rename(oo1k = toxic) %>% select(-label)) %>%
  left_join(read_csv('03_xlm_roberta_large_unfreeze_olid_test_2k.csv') %>% rename(oo2k = toxic) %>% select(-label)) %>%
  left_join(read_csv('03_xlm_roberta_large_unfreeze_olid_test_5k.csv') %>% rename(oo5k = toxic) %>% select(-label)) %>%
  left_join(read_csv('03_xlm_roberta_large_unfreeze_olid_test_10k.csv') %>% rename(o10k = toxic) %>% select(-label))
db
summary(db)
table(db$oo1k)
