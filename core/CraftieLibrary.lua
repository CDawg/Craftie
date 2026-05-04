--[==[
Copyright ©2026 Porthias of Dreamscythe

The contents of this addon, excluding third-party resources, are
copyrighted to Porthios with all rights reserved.
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

	player = {
	  name   = UnitName("player"),
	  realm  = GetRealmName(),
		classID= select(3, UnitClass("player")), --use the class ID, due to locales
	  faction= UnitFactionGroup("player"),
		GUID   = UnitGUID("player"),
		combine= UnitName("player").."-"..GetRealmName(), --unique to isolate accounts on save
	},
}
Craftie.Profession={}
Craftie.Professions={}

Craftie.Packet ={}
Craftie.Packet.Prefix = {
  Load = "!L", --onload
  Ping = "!P", --ping request
  Data = "!D", --data chunk
}

function Craftie.BitDouble(packet, decompress)
  local package = ""
  local pos = {
    {"fff","l"},{"101","j"},{"111",";"}, {"000","J"},
    {":::","i"}, {"1m1","{"}, {"1D1","+"}, {"1B1","~"},
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

function arrayToString(array)
  formstring=""
  for k,v in pairs(array) do
    formstring = formstring .. v .. "|n"
  end
  return formstring
end

function split(s, delimiter)
  result = {}
  if (s) then
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
      table.insert(result, match)
    end
  end
  return result
end

function isempty(s)
  return s == nil or s == ''
end

function table.merge(t1, t2)
 for k,v in ipairs(t2) do
    table.insert(t1, v)
 end
  return t1
end

function pairsByKeys(t, f)
  local a = {}
  for n in pairs(t) do table.insert(a, n) end
  table.sort(a, f)
  local i = 0
  local iter = function()
    i = i + 1
    if a[i] == nil then return nil
    else return a[i], t[a[i]]
    end
  end
  return iter
end

function firstToUpper(str)
  return (str:gsub("^%l", string.upper))
end

function getKeyFromValue(_array, value, index)
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

local function insertUnique(t, value)
  local seen = {}
  for _, v in ipairs(t) do seen[v] = true end

  if not seen[value] then
      table.insert(t, value)
  end
end

function reindexArray(input, reval)
  local n=#input
  for i=1,n do
    if reval[input[i]] then
      input[i]=nil
    end
  end
  local j=0
  for i=1,n do
    if input[i]~=nil then
      j=j+1
      input[j]=input[i]
    end
  end
  for i=j+1,n do
    input[i]=nil
  end
end

function reindexArraySafe(array)
  local n=0
  local newArray={}
  for i,v in pairs(array) do
    n=n+1
    newArray[n] = v
  end
  return newArray
end

function matchString(source, target)
	local _source_match = ""
	local _target_match = ""
	local _source_reiterate = 1
	local _target_reiterate = 1
	if ((source) and (target)) then
		for _split in string.gmatch(source, "%a+") do
			_source_reiterate = _source_reiterate -1
			if (_source_reiterate >= 0) then
				_source_match = _source_match .. string.lower(_split)
		  end
		end
		for _split in string.gmatch(target, "%a+") do
			_target_reiterate = _target_reiterate -1
			if (_target_reiterate >= 0) then
				_target_match = _target_match .. string.lower(_split)
			end
		end

		if (_source_match == _target_match) then
			return 1
		end
	end
end

function TimeSecondsToMinutes(time)
  local minutes = floor(mod(time, 3600)/60)
  local seconds = floor(mod(time, 60))
	if (minutes <= -1) then
		minutes = 0
	end
	if (seconds <= -1) then
		seconds = 0
	end
  return format("%2d:%02d", minutes, seconds)
end

function round(number)
  if (number - (number % 0.1)) - (number - (number % 1)) < 0.5 then
    number = number - (number % 1)
  else
    number = (number - (number % 1)) + 1
  end
 return number
end

function SortTableByString(tbl) --alpha second key
  table.sort(tbl, function(a, b)
    return string.lower(a[2]) < string.lower(b[2])
  end)
end

function SortTableByMatch(tbl, search)
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
