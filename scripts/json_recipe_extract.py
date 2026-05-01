import json

with open('tailoring.json', 'r') as file:
  items = json.load(file)

#itemID, name, requiredSkill, craftedID, Reagents, source[1=trainer, 2=quest|drop|vendor]

"""
count = 0
for list in items["recipes"]:
  count += 1 
  print(f'{list["name"]}')

print(count)
"""

count=0
for list in items["recipes"]:
  count += 1
  craftedID = list["creates"]["item_id"]
  if not craftedID:
    craftedID = ""
  beg = f'{list["spell_id"], list["name"], list["learned_at"], craftedID}' + ','
  reag = ""
  for reagent in list["reagents"]:
    reag += f'{reagent["item_id"], reagent["count"]}' + ','

  ritem = ""
  if "recipe_item" in list:
    for sources in list["recipe_item"]:
      ritem = f'{list["recipe_item"]["drop_sources"]}'
  else:
    ritem = '{"' + list["source"] + '"}'

  first = beg.replace("(", "{").replace(")", "")
  midd = reag.replace("(", "{").replace('),', "}, ")
  trunc1 = first + ' {' + midd + '}, ' + ritem + '},'
  last = trunc1.replace('[', '{').replace(']', '},')
  spaces = last.replace('}, },', '}},')
  full_line = spaces.replace('},},', '}},')
  #print(first + ' {' + midd + '}, ' + ritem + '},')
  print(full_line)

#print("count: " f'{count}')
