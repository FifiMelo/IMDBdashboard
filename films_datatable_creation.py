import json
import csv
with open("./actors_filmography.json", "r") as file:
    filmography = json.load(file)

film_ids = set()
film_content = dict()

for actor in filmography:
    for film in actor["filmography"]:
        id = film["id"][7:-1]
        if not id in film_ids:
            film_content[id] = dict()
            film_content[id]["title"] = film["title"]
            try:
                film_content[id]["year"] = film["year"]
            except:
                film_content[id]["year"] = "not yet released"
            try:
                film_content[id]["image_url"]= film["image"]["url"]
            except:
                film_content[id]["image_url"] = ''
            film_ids.add(id)

with open("./films.csv", "w", encoding = "utf-8") as file:
    writer = csv.writer(file, delimiter=';')
    writer.writerow(["id","title", "year", "image.url"])
    for id in film_ids:
        data = []
        data.append(id)
        data.append(film_content[id]["title"])
        data.append(film_content[id]["year"])
        data.append(film_content[id]["image_url"])
        writer.writerow(data)
