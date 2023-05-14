
import json
import requests

url = "https://online-movie-database.p.rapidapi.com/actors/list-most-popular-celebs"

querystring = {"currentCountry":"US"}

headers = {
	"X-RapidAPI-Key": "d38fac4a46mshcae3c95dd27dd25p19e3e2jsnb41485bca785",
	"X-RapidAPI-Host": "online-movie-database.p.rapidapi.com"
}

response = requests.get(url, headers=headers, params=querystring)

actor_ids = [actor_id[6:15] for actor_id in response.json()]

with open("./../jsons/actor_ids.json", "w") as json_file:
    json.dump(actor_ids, json_file)