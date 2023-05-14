import json
import requests

with open("./../jsons/actor_ids.json", "r") as file:
    actor_ids = json.load(file)

actor_bios = []

for actor_id in actor_ids:
    print(f"Pobrano id {actor_id}")
    url = "https://online-movie-database.p.rapidapi.com/actors/get-known-for"
    querystring = {"nconst": actor_id}
    headers = {
	        "X-RapidAPI-Key": "b7a0da1812mshc0512880fba8b48p1ae73ajsnaf886e4896dd",
	        "X-RapidAPI-Host": "online-movie-database.p.rapidapi.com"
        }
    response = requests.get(url, headers=headers, params=querystring)
    actor_bios.append(
        {
            "nconst": actor_id,
            "content": response.json()
        }
    )


with open("./../jsons/actors_known_for.json", "w") as file:
    json.dump(actor_bios, file)