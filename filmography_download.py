import json
import requests

with open("./actor_ids.json", "r") as file:
    actor_ids = json.load(file)

actor_bios = []

for actor_id in actor_ids:
    print(f"Pobrano id {actor_id}")
    try:
        url = "https://online-movie-database.p.rapidapi.com/actors/get-all-filmography"
        querystring = {"nconst": actor_id}
        headers = {
            "X-RapidAPI-Key": "d38fac4a46mshcae3c95dd27dd25p19e3e2jsnb41485bca785",
            "X-RapidAPI-Host": "online-movie-database.p.rapidapi.com"
        }
        response = requests.get(url, headers=headers, params=querystring)
        actor_bios.append(
        {
            "nconst": actor_id,
            "content": response.json()
        }
    )
    except:
        print("Nastapil blad")

with open("actors_filmography.json", "w") as file:
    json.dump(actor_bios, file)