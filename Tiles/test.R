#actors <- read.csv("C:/Users/felip/Desktop/python/IMDBdashboard/datatables/actors.csv", sep = ";")
#films <- read.csv("C:/Users/felip/Desktop/python/IMDBdashboard/datatables/films.csv", sep =";")
#nominations <- read.csv("C:/Users/felip/Desktop/python/IMDBdashboard/datatables/nominations.csv", sep = ";")

for(i in 1:nrow(actors)) {
  row <- actors[i,]
  print(row$id)
}

a[[1]] <- 0

