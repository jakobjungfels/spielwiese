from fastapi import FastAPI
import requests
import datetime
import json

app = FastAPI()


@app.get("/")
async def root(token: str = "", time: str = "", percentage: int = 90):
    updated_after = datetime.datetime.fromtimestamp(datetime.datetime.now().timestamp()-8640000).strftime("%Y-%m-%dT%H:%M:%S") if time == "" else time

    if token == "":
        return {"Error": "Please provide a token"}

    data = json.loads(requests.get("https://api.wanikani.com/v2/review_statistics", params={"updated_after": updated_after}, headers={"Wanikani-Revision":"20170710", "Authorization": f"Bearer {token}"}).text)
    ids = []
    for review in data["data"]:
        if review["data"]["percentage_correct"] > percentage:
            ids += [str(review["data"]["subject_id"])]

    meanings = []
    subjects = json.loads(requests.get(f"https://api.wanikani.com/v2/subjects", params={"ids": ",".join(ids)}, headers={"Wanikani-Revision":"20170710", "Authorization": f"Bearer {token}"}).text)
    for subject in subjects["data"]:
        for meaning in subject["data"]["meanings"]:
            if meaning["primary"]:
                meanings += [meaning["meaning"]]
    
    return {"meanings": ",".join(meanings)}