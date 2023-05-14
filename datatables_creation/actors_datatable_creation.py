import json
import csv




with open("./../jsons/actor_bios.json", "r") as file:
    actor_bio = json.load(file)

with open("./../jsons/actors_filmography.json", "r") as file:
    filmography = json.load(file)

with open("./../jsons/actors_images.json", "r") as file:
    images = json.load(file)

with open("./../datatables/actors.csv", "w", encoding='utf-8') as actors_csv:
    writer = csv.writer(actors_csv, delimiter=';')
    writer.writerow(["id","name", "birth.date", "birth.place", "height", "full.name", "gender","trade.marks", "bigraphy","legacy.name" ,"film.ids", "image.urls"])
    i = 0
    for actor in actor_bio:
        data = []
        try:
            data.append(actor["id"][6:-1])
        except:
            data.append('')
        try:
            data.append(actor["name"])
        except:
            data.append('')
        try:
            data.append(actor["birthDate"])
        except:
            data.append('')
        try:
            data.append(actor["birthPlace"])
        except:
            data.append('')
        try:
            data.append(actor["heightCentimeters"])
        except:
            data.append('')
        try:
            data.append(actor["realName"])
        except:
            data.append('')
        try:
            data.append(actor["gender"])
        except:
            data.append('')
        try:
            data.append(actor["trademarks"])
        except:
            data.append('')
        try:
            data.append(actor["miniBios"][0]["text"])
        except:
            data.append('')
        try:
            data.append(actor["legacyNameText"])
        except:
            data.append('')
        try:
            data.append([film["id"][7:-1] for film in filmography[i]["filmography"]])
        except:
            data.append('')
        try:
            data.append([image["url"] for image in images[i]["resource"]["images"]])
        except:
            data.append('')
        i+=1
        writer.writerow(data)



