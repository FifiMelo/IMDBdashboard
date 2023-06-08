library(dplyr)
library(stringr)

aktorzy <- read.csv("https://raw.githubusercontent.com/FifiMelo/IMDBdashboard/main/datatables/actors.csv", sep = ";")
filmy <- read.csv("https://raw.githubusercontent.com/FifiMelo/IMDBdashboard/main/datatables/films.csv", sep =";")
nominacje <- read.csv("https://raw.githubusercontent.com/FifiMelo/IMDBdashboard/main/datatables/nominations.csv", sep = ";")


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


aktorzy$image.urls <- strsplit(aktorzy$image.urls, ",")

for (x in 1:101) {
  aktorzy$image.urls[x][[1]] <- gsub("'", "", aktorzy$image.urls[x][[1]])
}

for (x in 1:101) {
  aktorzy$image.urls[x][[1]][1] <- gsub("\\[", "", aktorzy$image.urls[x][[1]][1])
}


filmy <- filmy[!grepl("not yet released", filmy$year),]
lista3 <- filmy$year
lista3 <- as.numeric(lista3)
filmy %>% 
  mutate(yearn = lista3) -> filmy


plot_ly(filmy,
        x = ~year,
        type = "histogram")
