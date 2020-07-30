library(readxl)
library(tidyverse)
setwd('Documents/Berkeley/W266/final project/')
Results <- read_excel("Results.xlsx", sheet = "table 3")

as.tbl(Results) %>% gather(key = 'key', value = 'value', `OLID 0-shot`:`OLID 0-shot 10k`) %>%
  mutate(size = ifelse(key == 'OLID 0-shot', 0, 
                       ifelse(key == 'OLID 0-shot 1k', 1000,
                              ifelse(key == 'OLID 0-shot 2k', 2000,
                                     ifelse(key == 'OLID 0-shot 5k', 5000, 10000))))) %>% 
  mutate(g = paste(Model, Freeze)) %>%
  mutate(key = factor(key, 
                         levels = c('OLID 0-shot', 'OLID 0-shot 1k','OLID 0-shot 2k' ,
                                    'OLID 0-shot 5k', 'OLID 0-shot 10k'))) %>%
  ggplot(aes(x = size, y = value, colour = Model, lty = Freeze,
             group = g)) + geom_line() + 
  scale_x_continuous(breaks = c(0, 1000, 2000, 5000, 10000), labels = c('0-shot', '1k', '2k', '5k', '10k')) + 
  labs(x = '', y = 'F1 Score', lty = 'Freeze Transformer Weights', 
       title = 'Transfer Learning Performance on OLID') + 
  theme_minimal() + theme(legend.position = 'bottom', legend.box="vertical", legend.margin=margin()) +
  guides(colour=guide_legend(nrow=2,byrow=TRUE))

ggsave(file = 'transfer_learning_performance_nominal.png', width = 4, height = 4, units = 'in')
