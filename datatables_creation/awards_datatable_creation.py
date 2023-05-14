import json
import csv

with open("./../jsons/actors_awards.json", "r") as file:
    awards = json.load(file)

print(awards[0]["content"]["resource"]["awards"][0].keys())

with open("./../datatables/nominations.csv", "w", encoding = "utf-8") as file:
    writer = csv.writer(file, delimiter=';')
    writer.writerow(["id", "actor.id", "event.name", "category", "is.winner", "year"])
    for actor in awards:
        for award in actor["content"]["resource"]["awards"]:
            data = []
            data.append(award["awardNominationId"])
            try:
                data.append(actor["nconst"])
            except:
                data.append('')
            try:
                data.append(award["eventName"])
            except:
                data.append('')
            try:
                data.append(award["category"])
            except:
                data.append('')
            try:
                data.append(award["isWinner"])
            except:
                data.append('')
            try:
                data.append(award["year"])
            except:
                data.append('')
            writer.writerow(data)

    
