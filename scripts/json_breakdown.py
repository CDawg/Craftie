import json

with open('update/alchemy.json', 'r') as file:
  items = json.load(file)

#itemID, name, requiredSkill, craftedID, Reagents, source[1=trainer, 2=quest|drop|vendor]

"""
count = 0
for list in items["recipes"]:
  count += 1 
  print(f'{list["name"]}')

print(count)
"""

for list in items["recipes"]:
  craftedID = list["creates"]["item_id"]
  if not craftedID:
    craftedID = ""
  beg = f'{list["spell_id"], list["name"], list["learned_at"], craftedID}' + ','
  reag = ""
  for reagent in list["reagents"]:
    reag += f'{reagent["item_id"], reagent["count"]}' + ','
  ritem = "ignore"
  if "recipe_item" in list:
    ritem = "2"
    #print(f'{list["recipe_item"]["drop_sources"]}')
  else:
    ritem = "1" #trainer
  #print(f'{list["source"]}')
  #print(f'{list["recipe_item"]}')
  first = beg.replace("(", "{").replace(")", "")
  midd = reag.replace("(", "{").replace('),', "}, ")
  trunc1 = first + ' {' + midd + '}, ' + ritem + '},'
  full_line = trunc1.replace('}, },', '}},')
  #print(first + ' {' + midd + '}, ' + ritem + '},')
  print(full_line)

