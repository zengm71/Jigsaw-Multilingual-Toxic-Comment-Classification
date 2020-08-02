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
  ggplot() + geom_line(aes(x = size, y = value, colour = Model, lty = Freeze,
                           group = g)) + 
  geom_hline(aes(yintercept = .7, 
                 colour = 'Zampieri et al., 2019'), show.legend = T) + 
  scale_x_continuous(breaks = c(0, 1000, 2000, 5000, 10000), labels = c('0-shot', '1k', '2k', '5k', '10k')) + 
  labs(x = '', y = 'F1 Score', lty = 'Freeze Transformer Weights', 
       title = 'Transfer Learning Performance on OLID') + 
  theme_minimal(base_size = 10) + 
  theme(legend.position = 'bottom', legend.box="vertical", legend.margin=margin(), legend.text.align = 0) +
  guides(colour=guide_legend(nrow=2,byrow=TRUE)) 

ggsave(file = 'transfer_learning_performance_nominal.png', width = 4.5, height = 4, units = 'in')
