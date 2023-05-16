library(dplyr)
library(stringr)

aktorzy <- read.csv("./datatables/actors.csv", sep = ";")
filmy <- read.csv("./datatables/films.csv", sep =";")
nominacje <- read.csv("./datatables/nominations.csv", sep = ";")


format(as.Date(aktorzy$birth.date, format="%Y-%m-%d"),"%Y") -> yearm

aktorzy %>% 
  mutate(date = yearm) -> new_aktorzy

################################################
### TO BE USED ###
##################

new_aktorzy %>% 
  filter(gender == "male") -> aktorzym1

new_aktorzy %>% 
  filter(gender == "female") -> aktorzyf2

##################
###############################################

new_aktorzy <- new_aktorzy[!is.na(new_aktorzy$date), ]
new_aktorzy$date <- as.numeric(new_aktorzy$date)

new_aktorzy %>% 
  rename(actor_id=id) %>% 
  inner_join(nominacje %>% rename(actor_id=actor.id), by=join_by(actor_id)) ->new_nominacje

new_nominacje %>% 
  filter(is.winner=='True') %>% 
  group_by(name) %>% 
  count -> df_nom
