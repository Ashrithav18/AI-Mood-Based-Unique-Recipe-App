# main.py
from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel
from typing import List
import uvicorn

app = FastAPI()

# Allow all origins for testing (you can restrict later)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

class Message(BaseModel):
    query: str
    ingredients: List[str] = []

# Dummy food list with ingredients
food_list = [
    {
        "name": "Paneer Butter Masala",
        "ingredients": ["paneer", "butter", "tomato", "cream", "garam masala"],
        "link": "https://www.bigbasket.com/",
    },
    {
        "name": "Veg Biryani",
        "ingredients": ["rice", "carrot", "beans", "peas", "spices"],
        "link": "https://www.blinkit.com/",
    },
    {
        "name": "Aloo Paratha",
        "ingredients": ["potato", "wheat flour", "salt", "oil", "spices"],
        "link": "https://www.jiomart.com/",
    },
]

@app.post("/suggest_recipe")
async def suggest_recipe(message: Message):
    query = message.query.lower()
    user_ingredients = set(i.lower() for i in message.ingredients)

    suggestions = []

    for recipe in food_list:
        recipe_ingredients = set(i.lower() for i in recipe["ingredients"])
        matched = user_ingredients.intersection(recipe_ingredients)

        match_ratio = len(matched) / len(recipe_ingredients)

        if "recipe" in query or matched:
            missing = list(recipe_ingredients - matched)
            suggestions.append({
                "name": recipe["name"],
                "matched_ingredients": list(matched),
                "missing_ingredients": missing,
                "shopping_link": recipe["link"]
            })

    if not suggestions:
        return {"reply": "Sorry, no matching recipes found. Try adding more ingredients or changing your query."}
    
    return {"reply": "Here are some recipes you can try:", "suggestions": suggestions}

if _name_ == "_main_":
    uvicorn.run("main:app", port=8000,reload=True)
