import json
import requests

with open("./actor_ids.json", "r") as file:
    actor_ids = json.load(file)

actor_bios = []

for actor_id in actor_ids:
    print(f"Pobrano id {actor_id}")
    try:
        url = "https://online-movie-database.p.rapidapi.com/actors/get-awards"
        querystring = {"nconst": actor_id}
        headers = {
	"X-RapidAPI-Key": "0de58a4961mshb97a6aebc4001bcp14051bjsnf6d6bad1db52",
	"X-RapidAPI-Host": "online-movie-database.p.rapidapi.com"
}
        response = requests.get(url, headers=headers, params=querystring)
        actor_bios.append(
        {
            "nconst": actor_id,
            "content": response.json()
        })
    except:
        print("Nastapil blad")

with open("actors_awards.json", "w") as file:
    json.dump(actor_bios, file)