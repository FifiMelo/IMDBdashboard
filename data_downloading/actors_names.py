import json

with open("./../jsons/actor_bios.json", "r") as file:
    actors = json.load(file)

for actor in actors:
    try:
        print(actor["name"])
    except:
        pass