import json

# Open the file and load its content
with open('cooking.json', 'r') as file:
    items = json.load(file)

#print(items)

#itemID, Cat, name, requiredSkill, craftedID, RecipeItemID, Reagents, craftedIconID, RecipeIconID, source[1=trainer, 2=vendor, 3=drop], category
#{2329, "Elixir of Lion's Strength", 1, 2454, "", {{2449, 1}, {765, 1}, {3371, 1}}, "inv_potion_56", "", 1},

for list in items:
   print(f"name: {list['name']}")