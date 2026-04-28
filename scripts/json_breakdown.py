import json

# Open the file and load its content
with open('cooking.json', 'r') as file:
    items = json.load(file)

#print(items)

#itemID, name, requiredSkill, craftedID, RecipeItemID, Reagents, craftedIconID, RecipeIconID, source[1=trainer, 2=vendor, 3=drop], category
#{2329, "Elixir of Lion's Strength", 1, 2454, "", {{2449, 1}, {765, 1}, {3371, 1}}, "inv_potion_56", "", 1},

"""
for list in items:
  print(f'{list["spell_id"], list["name"], list["learned_at"], list["creates"]["item_id"]}' + ',')
  for reagent in list["reagents"]:
    print(f'{reagent["item_id"], reagent["count"]}' + ',')
  if "recipe_item" in list:
    print(f'{list["recipe_item"]["drop_sources"]}')
"""

for list in items["recipes"]:
  beg = f'{list["spell_id"], list["name"], list["learned_at"], list["creates"]["item_id"]}' + ','
  reag = ""
  for reagent in list["reagents"]:
    reag += f'{reagent["item_id"], reagent["count"]}' + ','
  if "recipe_item" in list:
    ritem = "1"
  else:
    ritem = "3"
  first = beg.replace("(", "{").replace(")", "")
  midd = reag.replace("(", "{").replace('),', "}, ")
  trunc1 = first + ' {' + midd + '}, "", "", ' + ritem + '},'
  full_line = trunc1.replace('}, },', '}},')
  #print(first + ' {' + midd + '}, "", "", ' + ritem + '},')
  print(full_line)
