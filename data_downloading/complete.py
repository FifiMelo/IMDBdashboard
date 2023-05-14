import json

with open("./../jsons/actor_bios.json", "r") as file:
    filmography = json.load(file)
    
print(filmography[0].keys())