--[==[
Copyright ©2026 Porthias of Dreamscythe

The contents of this addon, excluding third-party resources, are
copyrighted to Porthias with all rights reserved.
This addon is free to use and the authors hereby grants you the following rights:
1. You may make modifications to this addon for private use only, you
   may not publicize any portion of this addon.
2. Do not modify the name of this addon, including the addon folders.
3. This copyright notice shall be included in all copies or substantial
  portions of the Software.
All rights not explicitly addressed in this license are reserved by
the copyright holders.
]==]--

__Gversion, __Gbuild, __Gdate, __Gtoc = GetBuildInfo()

Craftie = {
	_L={},

  Game = {
    "Classic",
    "Burning Crusade",
    "Wrath",
  },

	Player = {
	  Name    = UnitName("player"),
	  Realm   = GetRealmName(),
		ClassID = select(3, UnitClass("player")), --use the class ID, due to locales
	  Faction = UnitFactionGroup("player"),
		GUID    = UnitGUID("player"),
		Combine = UnitName("player").."-"..GetRealmName(), --unique to isolate accounts on save
	},
}

Craftie.Game.Version = tonumber(string.sub(__Gversion, 1, 1))
Craftie.Game.Name = Craftie.Game[tonumber(string.sub(__Gversion, 1, 1))]

Craftie.Profession={}
Craftie.Professions={}

Craftie.Packet ={}
Craftie.Packet.Prefix = {
  Load = "!L", --onload
  Ping = "!P", --ping request
  Data = "!D", --data chunk
}

Craftie.Class = {
  {"Druid",       {1.00, 0.49, 0.04}, "|CFFFF7C0A", "ClassIcon_Druid"},
  {"Hunter",      {0.67, 0.83, 0.45}, "|CFFAAD372", "ClassIcon_Hunter"},
  {"Mage",        {0.25, 0.78, 0.92}, "|CFF3FC7EB", "ClassIcon_Mage"},
  {"Paladin",     {0.96, 0.55, 0.73}, "|CFFF48CBA", "ClassIcon_Paladin"},
  {"Priest",      {1.00, 1.00, 1.00}, "|CFFFFFFFF", "ClassIcon_Priest"},
  {"Rogue",       {1.00, 0.96, 0.41}, "|CFFFFF468", "ClassIcon_Rogue"},
  {"Shaman",      {0.00, 0.44, 0.87}, "|CFF0070DD", "ClassIcon_Shaman"},
  {"Warlock",     {0.53, 0.53, 0.93}, "|CFF8788EE", "ClassIcon_Warlock"},
  {"Warrior",     {0.78, 0.61, 0.43}, "|CFFC69B6D", "ClassIcon_Warrior"},
  {"Death Knight",{0.77, 0.12, 0.23}, "|CFFC41E3A", "ClassIcon_DeathKnight"},
}

--prio professions
Craftie.Professions = {
  {"Alchemy",        "Trade_Alchemy",        "0.72, 0.80, 0.19", {"Elixir Master", "Potion Master", "Transmute Master"}},
  {"Blacksmithing",  "Trade_BlackSmithing",  "0.60, 0.54, 0.48", {"Armorsmith", "Weaponsmith", "Swordsmith", "Hammersmith", "Axesmith"}},
  {"Cooking",        "INV_Misc_Food_15",     "0.88, 0.44, 0.13"},
  {"Enchanting",     "Trade_Engraving",      "0.73, 0.33, 0.83"},
  {"Engineering",    "Trade_Engineering",    "0.91, 0.75, 0.25", {"Gnomish", "Goblin"}},
  {"Leatherworking", "Trade_LeatherWorking", "0.76, 0.63, 0.42", {"Dragonscale", "Elemental", "Tribal"}},
  {"Tailoring",      "Trade_Tailoring",      "0.91, 0.69, 0.88", {"Mooncloth", "Shadoweave", "Spellfire"}},
  {"Jewelcrafting",  "INV_Misc_Gem_02",      "1.00, 0.25, 0.25"},
  --{"Inscription",    "inv_inscription_tradeskill01", "1.00, 0.25, 0.25"},
}

function Craftie.BitDouble(packet, decompress)
  local package = ""
  local pos = {
    {"fffff","L"},{":::::","r"},
    {"100","q"}, {"101","j"}, {"111",";"}, {"000","J"},
    {":::","i"}, {"1m1","{"}, {"1D1","+"}, {"1B1","~"},
    {"fff","l"}, {"ff0","x"}, {"ff0","X"}, {"f00","Z"}
  }

  local rate = {}
  rate[0] = packet
  for k,v in pairs(pos) do
    if (decompress) then
      rate[k] = string.gsub(rate[k-1], v[2], v[1])
    else
      rate[k] = string.gsub(rate[k-1], v[1], v[2])
    end
  end
  package = rate[#pos] --last key
  return package
end

function Craftie.BitCompression(packet, decompress)
  local dblcompression = true
  local package = ""
  --2 to the power of 5 = 32 (appears to be the safest compression)
  local pos = {
    {"00000","f"}, {"00001","a"}, {"00010","b"}, {"00011","c"},
    {"00100","d"}, {"00101","e"}, {"00110","z"}, {"00111","g"},
    {"01000","h"}, {"01001","k"}, {"01010","m"}, {"01011","n"},
    {"01100","A"}, {"01101","B"}, {"01110","C"}, {"01111","D"},
    {"10000","E"}, {"10001","F"}, {"10010","G"}, {"10011","H"},
    {"10100","K"}, {"10101","M"}, {"10110","N"}, {"10111","P"},
    {"11000","Q"}, {"11001","R"}, {"11010","S"}, {"11011","T"},
    {"11100","U"}, {"11101","V"}, {"11110","W"}, {"11111",":"}
  }

  local rate = {}
  if (dblcompression) then
    if (decompress) then
      rate[0] = Craftie.BitDouble(packet, true)
    else
      rate[0] = packet
    end
  else
    rate[0] = packet
  end

  for k,v in pairs(pos) do
    if (decompress) then
      rate[k] = string.gsub(rate[k-1], v[2], v[1])
    else
      rate[k] = string.gsub(rate[k-1], v[1], v[2])
    end
  end
  package = rate[#pos] --last key

  if (dblcompression) then
    if (decompress) then
      return package
    else
      return Craftie.BitDouble(package, false)
    end
  else
    return package
  end
end

--complex tree tables
function Craftie.CopyTable(original)
  local copy = {}
  for k, v in pairs(original) do
    if type(v) == "table" then
      v = Craftie.CopyTable(v) -- Recursive call for nested tables
    end
    copy[k] = v
  end
  return copy
end

function Craftie.Split(s, delimiter)
  local result = {}
  if (s) then
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
      table.insert(result, match)
    end
  end
  return result
end

function Craftie.IsEmpty(s)
  return s == nil or s == ''
end

function Craftie.FirstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

function Craftie.GetKeyFromValue(_array, value, index)
  if ((index == nil) or (index == 0)) then
		for k,v in pairs(_array) do
			if v==value then return k end
		end
		return nil
  else
	  for k,v in pairs(_array) do
	    if v[index]==value then return k end
	  end
	  return nil
	end
end

function Craftie.SortTableByString(tbl) --alpha second key
  table.sort(tbl, function(a, b)
    return string.lower(a[2]) < string.lower(b[2])
  end)
end

function _sanitize(str)
  return str:gsub("[^%w]", "")
end

function Craftie.SortTableByMatch(tbl, search)
    search = string.lower(search or "")
    local matchCount = 0

    -- First pass: count matches
    if search ~= "" then
      for _, item in ipairs(tbl) do
        local name = string.lower(item[2] or "")
        if string.find(name, search, 1, true) then
          matchCount = matchCount + 1
        end
      end
    else
      matchCount = #tbl -- Empty search = everything matches
    end

    -- Sort table
    table.sort(tbl, function(a, b)
      local nameA = string.lower(a[2] or "")
      local nameB = string.lower(b[2] or "")

      local posA = string.find(nameA, search, 1, true) or math.huge
      local posB = string.find(nameB, search, 1, true) or math.huge

      -- Earlier match wins
      if posA ~= posB then
          return posA < posB
      end

      -- Alphabetical fallback
      return nameA < nameB
    end)

    return matchCount
end
