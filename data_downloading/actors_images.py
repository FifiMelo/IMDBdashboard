import json
import requests

with open("./../jsons/actor_ids.json", "r") as file:
    actor_ids = json.load(file)

actor_bios = []

for actor_id in actor_ids:
    print(f"Pobrano id {actor_id}")
    try:
        url = "https://online-movie-database.p.rapidapi.com/actors/get-all-images"
        querystring = {"nconst": actor_id}
        headers = {
	        "X-RapidAPI-Key": "b7a0da1812mshc0512880fba8b48p1ae73ajsnaf886e4896dd",
	        "X-RapidAPI-Host": "online-movie-database.p.rapidapi.com"
        }
        response = requests.get(url, headers=headers, params=querystring)
        actor_bios.append(response.json())
    except:
        print("Nastapil blad")

with open("./../jsons/actors_images.json", "w") as file:
    json.dump(actor_bios, file)