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

---@class Craftie
Craftie = {
	Player = {
    Name    = UnitName("player"),
    Realm   = GetRealmName(),
    ClassID = select(3, UnitClass("player")), --use the class ID, due to locales
    Faction = UnitFactionGroup("player"),
    GUID    = UnitGUID("player"),
    Combine = UnitName("player").."-"..GetRealmName(), --unique to isolate accounts on save
	},
}
Craftie._L={} --locales

Craftie.Game = {
  Version = tonumber(string.sub(__Gversion, 1, 1))
}

Craftie.Save = {
  Account= {}, --account wide
  Player = {}, --individually
}

Craftie.Color = {
  Theme = "|CFFFF9524",
  Blue  = "|CFF4BB4FA",
  Skyblue="|CFF42DBFF",
  Yellow= "|CFFFFFB63",
  Gold  = "|CFFFFDA45",
  White = "|CFFFFFFFF",
  Silver= "|CFFDEDEDE",
  Gray  = "|CFFABABAB",
  Lime  = "|CFF9CFFA1",
  Guild = {0.2, 0.92, 0.2}
}

Craftie.DEBUGLEVEL = 3 --default [INFO | ERROR] | WARN]

Craftie.CHAT = {
  INFO = {1, "|CFFDEDEDEINFO|r"},
  ERROR= {2, "|CFFFF0000ERROR|r"},
  WARN = {3, "|CFFFF8A4DWARNING|r"},
  EVENT= {4, "|CFF92CEFCEVENT|r"},
  SEND = {5, "|CFF89DE49SEND|r"},
  ACK  = {6, "|CFFD177F7ACK|r"},
  SAVE = {7, "|CFF4AB587SAVE|r"},
  CACHE= {9, "|CFFB5E0A2CACHE|r"},
  PARSE= {8, "|CFFC238B7PARSE|r"},
  FUNC = {10,"|CFF385EC2FUNC|r"},
}

Craftie.Date = date("%y-%m-%d_%H:%M:%S")

Craftie.PlayerGUIDProf = {}
Craftie.NumGuildMembers = 0
Craftie.PlayerGuild = {}
Craftie.IsInCombat = false
Craftie.Alert = {
  NewProf = 0,
  Order = 0
}
Craftie.Throttle = {
  Chat = {
    Timer= 20,
    Flag = 1
  },
  Prof = {
    Timer= 30,
    Flag = 1
  }
}

Craftie.Framelevel = {
  Background= 0,
  Foreground= 10,
  Menu      = 20,
  Buttons   = 30,
  Cover     = 40,
}

Craftie.FrameStrata = {
  "LOW",
  "MEDIUM",
  "HIGH",
}
Craftie.FrameFont = {
  "Fonts/FRIZQT__.ttf",
  "Fonts/ARIALN.ttf",
  "Interface/Addons/Craftie/Fonts/AvantGarde.ttf",
}

Craftie.GuildFrameUsing = 1 --classic default
Craftie.Tooltip = {}

Craftie.Backdrop = {
  General = {
    bgFile  = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  },
  Glow = {
    bgFile  = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile= "Interface/FriendsFrame/PendingFriendGlow",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  },
  Opaque = {
    bgFile  = "Interface/Tooltips/CHATBUBBLE-BACKGROUND",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  },
  Borderless = {
    bgFile  = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile= "",
    edgeSize= 12,
    insets  = {left=0, right=0, top=0, bottom=0},
  },
  Slider = {
    Template = "UISliderTemplateWithLabels",
  }
}

Craftie.Packet = {}
Craftie.Packet.Timeout = 2 --timeout if no data recieved
Craftie.Packet.ACK = {}
Craftie.Packet.Prefix = {
  Load = "!L", --onload
  Ping = "!P", --ping request
  Data = "!D", --data chunk
  Net  = "!N", --online
  Info = "!T", --tooltip
  Order= "!O", --order send
  Ack  = "!A", --order ack
}

Craftie.Class = {
  {1, "Warrior",     {0.78, 0.61, 0.43}, "|CFFC69B6D", "ClassIcon_Warrior"},
  {2, "Paladin",     {0.96, 0.55, 0.73}, "|CFFF48CBA", "ClassIcon_Paladin"},
  {3, "Hunter",      {0.67, 0.83, 0.45}, "|CFFAAD372", "ClassIcon_Hunter"},
  {4, "Rogue",       {1.00, 0.96, 0.41}, "|CFFFFF468", "ClassIcon_Rogue"},
  {5, "Priest",      {1.00, 1.00, 1.00}, "|CFFFFFFFF", "ClassIcon_Priest"},
  {6, "Death Knight",{0.77, 0.12, 0.23}, "|CFFC41E3A", "ClassIcon_DeathKnight"},
  {7, "Shaman",      {0.00, 0.44, 0.87}, "|CFF0070DD", "ClassIcon_Shaman"},
  {8, "Mage",        {0.25, 0.78, 0.92}, "|CFF3FC7EB", "ClassIcon_Mage"},
  {9, "Warlock",     {0.53, 0.53, 0.93}, "|CFF8788EE", "ClassIcon_Warlock"},
  {11,"Druid",       {1.00, 0.49, 0.04}, "|CFFFF7C0A", "ClassIcon_Druid"},
}

Craftie.PROFMAXLEVEL = 300
Craftie.Profession={}
Craftie.Professions = {
  --id, name, icon, color, mastery, spell
  {171, "Alchemy",        "Trade_Alchemy",        "0.72, 0.80, 0.19", {"Elixir Master", "Potion Master", "Transmutation Master"}, 2559},
  {164, "Blacksmithing",  "Trade_BlackSmithing",  "0.60, 0.54, 0.48", {"Armorsmith", "Weaponsmith", "Master Swordsmith", "Master Hammersmith", "Master Axesmith"}, 2018},
  {184, "Cooking",        "INV_Misc_Food_15",     "0.88, 0.44, 0.13", {}, 2550},
  {333, "Enchanting",     "Trade_Engraving",      "0.73, 0.33, 0.83", {}, 7411},
  {202, "Engineering",    "Trade_Engineering",    "0.91, 0.75, 0.25", {"Gnomish Engineer", "Goblin Engineer"}, 4036},
  {165, "Leatherworking", "Trade_LeatherWorking", "0.76, 0.63, 0.42", {"Dragonscale Leatherworking", "Elemental Leatherworking", "Tribal Leatherworking"}, 2108},
  {197, "Tailoring",      "Trade_Tailoring",      "0.91, 0.69, 0.88", {"Mooncloth Tailoring", "Shadoweave Tailoring", "Spellfire Tailoring"}, 3908},
}

Craftie.PROFMAXSEG = 4
if (Craftie.Game.Version >= 2) then
  Craftie.PROFMAXLEVEL = 375
  Craftie.PROFMAXSEG = 5
  table.insert(Craftie.Professions, {755, "Jewelcrafting", "INV_Misc_Gem_02", "1.00, 0.25, 0.25", {}, 25229})
end
if (Craftie.Game.Version >= 3) then
  Craftie.PROFMAXLEVEL = 450
  Craftie.PROFMAXSEG = 6
  table.insert(Craftie.Professions, {773, "Inscription", "inv_inscription_tradeskill01", "1.00, 0.25, 0.25", {}, 45357})
end

-- BLOB data is keyed by the stable numeric profession ID. Names are localized
-- and have changed between clients, so they are not suitable saved-data keys.
function Craftie:GetProfessionID(profession)
  local professionID = tonumber(profession)
  if (professionID) then return professionID end

  for _, data in pairs(Craftie.Professions) do
    if (data[2] == profession) then return data[1] end
  end
  return nil
end

-- Updated for name conversions by the ID
function Craftie:GetProfessionName(ID)
  local professionID = tonumber(ID)
  for _, data in pairs(Craftie.Professions) do
    if ((professionID and data[1] == professionID) or data[2] == ID) then
      return data[2]
    end
  end
  return nil
end

Craftie.ProfessionMasteries = {
  Alchemy = {
    [28677] = 1, --elixir master
    [28675] = 2, --potion master
    [28672] = 3, --transmute
  },

  Blacksmithing = {
    [9788]  = 1, --armorsmith
    [9787]  = 2, --weaponsmith
    [17041] = 3, --swordsmith
    [17039] = 4, --hammersmith
    [17040] = 5, --Axesmith,
  },

  Engineering = {
    [20219] = 1, --gnomish
    [20222] = 2, --goblin
  },

  Leatherworking = {
    [10656] = 1, --dragonscale
    [10658] = 2, --elemental
    [10660] = 3, --tribal
  },

  Tailoring = {
    [26798] = 1, --mooncloth
    [26801] = 2, --Shadoweave
    [26797] = 3, --Spellfire
  },
}

function Craftie:GetProfessionMastery(profession)
  local specs = Craftie.ProfessionMasteries[profession]
  if not specs then
    return nil
  end

  local found = {}
  for spellID, masteryName in pairs(specs) do
    if (IsSpellKnown(spellID)) then
      table.insert(found, masteryName)
    end
  end
  return (#found > 0) and found or nil
end

function Craftie:BitDouble(packet, decompress)
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

function Craftie:BitCompression(packet, decompress)
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
      rate[0] = Craftie:BitDouble(packet, true)
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
      return Craftie:BitDouble(package, false)
    end
  else
    return package
  end
end

--complex tree tables
function Craftie:CopyTable(original)
  local copy = {}
  for k, v in pairs(original) do
    if type(v) == "table" then
      v = Craftie:CopyTable(v) -- Recursive call for nested tables
    end
    copy[k] = v
  end
  return copy
end

function Craftie:Split(s, delimiter)
  local result = {}
  if (s) then
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
      table.insert(result, match)
    end
  end
  return result
end

function Craftie:IsEmpty(s)
  return s == nil or s == ''
end

function Craftie:GetKeyFromValue(_array, value, index)
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

function Craftie:SortTableByString(tbl) --alpha second key
  table.sort(tbl, function(a, b)
    return string.lower(a[2]) < string.lower(b[2])
  end)
end

function Craftie:SanitizeString(str, lowercase)
  if (str == nil) then
    return nil
  end

  -- Recipe separators are not consistent across every client build (i.e. " - " versus ": ")
  local sanitized = str:gsub("%p", ""):gsub("%s+", " "):match("^%s*(.-)%s*$")
  if (lowercase) then
    return sanitized:lower()
  else
    return sanitized
  end
end

function Craftie:SearchTable(tbl, search) --basic table
  local results = {}
  search = string.lower(search or "")

  for _, name in ipairs(tbl) do
    if string.find(string.lower(name), search, 1, true) then
      table.insert(results, name)
    end
  end

  return results, #results
end

function Craftie:SortTableByMatch(tbl, search)
  search = string.lower(search or "")
  local matchCount = 0

  -- First pass: count matches
  if (search ~= "") then
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

function Craftie:TextSpacing(text)
  local string = ""
  local length = #text
  local dist = 20 -length
  local space = " "
  for i=1, dist do
    space = space .. " "
  end
  string = text .. space
  return string
end

--designed for nested tables
function Craftie:KeyCount(t)
  local count = 0
  for k, v in pairs(t) do
    count = count + 1
  end
  return count
end
