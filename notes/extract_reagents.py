
from slpp import slpp as lua
data = '''
{
{2329, "Elixir of Lion's Strength", 1, 2454, "", {{2449, 1}, {765, 1}, {3371, 1}}, "inv_potion_56", "", 1},
{2330, "Minor Healing Potion", 1, 118, "", {{2447, 1}, {765, 1}, {3371, 1}}, "inv_potion_49", "", 1},
{2331, "Minor Mana Potion", 25, 2455, "", {{785, 1}, {765, 1}, {3371, 1}}, "inv_potion_70", "", 1},
{2332, "Minor Rejuvenation Potion", 40, 2456, "", {{785, 2}, {2447, 1}, {3371, 1}}, "inv_potion_02", "", 1},
{2333, "Elixir of Lesser Agility", 140, 3390, 3396, {{3355, 1}, {2452, 1}, {3372, 1}}, "inv_potion_92","inv_scroll_03", 2},
{2334, "Elixir of Minor Fortitude", 50, 2458, "", {{2449, 2}, {2447, 1}, {3371, 1}}, "inv_potion_42", "", 1},
{2335, "Swiftness Potion", 60, 2459, 2555, {{2452, 1}, {2450, 1}, {3371, 1}}, "inv_potion_95","inv_scroll_06", 2}
}
'''

python_dict = lua.decode(data)
#print(python_dict[0])

for i in python_dict:
  print(python_dict[5])

#for line in python_dict.splitlines():
    #print(line)
    #lineResult = libLAPFF.parseLine(line)

#print("EOL")

LUA for Windows
--for i=1, #data do
--  print(data[1][2])
--end
for index, value in ipairs(data) do
    --print(index, value)
    print(value[6][1])
end