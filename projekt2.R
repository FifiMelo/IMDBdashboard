library(dplyr)
library(stringr)

aktorzy <- read.csv("./datatables/actors.csv", sep = ";")
filmy <- read.csv("./datatables/films.csv", sep =";")
nominacje <- read.csv("./datatables/nominations.csv", sep = ";")


aktorzy %>% 
  filter(gender == "male") -> aktorzym

aktorzy %>% 
  filter(gender == "female") -> aktorzyf

format(as.Date(aktorzym$birth.date, format="%Y-%m-%d"),"%Y") -> yearm
aktorzym %>% 
  mutate(date = yearm) -> aktorzym

format(as.Date(aktorzyf$birth.date, format="%Y-%m-%d"),"%Y") -> yearf
aktorzyf %>% 
  mutate(date = yearf) -> aktorzyf

lista1 <- list()
lista2 <- list()

for (x in 1:34) {
  lista1[x] <- length(as.list(scan(text = aktorzym$film.ids[x], what = "", sep = ",")))
}

for (x in 1:67) {
  lista2[x] <- length(as.list(scan(text = aktorzyf$film.ids[x], what = "", sep = ",")))
}

aktorzym %>% 
  mutate(ilosc_filmow = lista1) -> aktorzym

aktorzyf %>% 
  mutate(ilosc_filmow = lista2) -> aktorzyf


nowiaktorzy <- rbind(aktorzym, aktorzyf)
nowiaktorzy <- nowiaktorzy[!is.na(nowiaktorzy$date), ]

nowiaktorzy$date <- as.numeric(nowiaktorzy$date)
nowiaktorzy$ilosc_filmow <- as.numeric(nowiaktorzy$ilosc_filmow)
