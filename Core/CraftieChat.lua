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

Craftie.Chat = {}
Craftie.ChatFilter = {}

function Craftie:BuildChatHooks()
  local prof_parent = ""
  for k,v in pairs(Craftie.Professions) do
    Craftie.Chat[v[2]] = {}
  end

  for k,v in pairs(Craftie.Professions) do
    prof_parent = "[" .. v[2]
    table.insert(Craftie.Chat[v[2]], v[2])
    if (v[5][1] ~= nil) then
      for a,b in pairs(v[5]) do
        --print(" - " .. b)
        table.insert(Craftie.Chat[v[2]], b)
        prof_parent = prof_parent .. " | " .. b
      end
    end
    Craftie:Notification("Craftie:BuildChatHooks: " .. prof_parent .. "]", Craftie.CHAT.FUNC)
  end

  for k,v in pairs(Craftie.Professions) do
    Craftie.ChatFilter[v[2]] = function(self, event, msg, author, ...)
      --local parent = Craftie.Chat.Alchemy[1]
      for a,b in pairs(Craftie.Chat[v[2]]) do
        local pattern= "%[" .. b .. "%]"
        if (msg:find(pattern)) then --register the author data
          local filter = gsub(msg, pattern, "|Haddon:Craftie:" .. author .. ":" .. v[2] .. "|h" .. Craftie._G.Image.Tooltip.Layout .. pattern .. "|h|r")
          return false, filter, author, ...
        end
      end
    end
  end

  for k,v in pairs(Craftie.ChannelList) do
    for _,prof in pairs(Craftie.Professions) do
      --segment each primary profession
      ChatFrame_AddMessageEventFilter(v, Craftie.ChatFilter[prof[2]])
    end
  end
  if (IsInGuild()) then
    ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", Craftie.LookupItem)
  end
end

--guild only
function Craftie.LookupItem(self, event, msg, author, ...)
  local pattern = "craftie "
  local commandStart, commandEnd = msg:lower():find(pattern, 1, true)
  -- Only treat Craftie at the start of a message as a command. This also
  -- prevents Craftie's own result messages from recursively starting searches.
  if (commandStart ~= 1) then return end

  local query = msg:sub(commandEnd + 1):match("^%s*(.-)%s*$")
  if (query:len() < 2) then return end

  if (C_GuildInfo and C_GuildInfo.GuildRoster) then
    C_GuildInfo.GuildRoster()
  end

  local guildMembers = {}
  for i = 1, GetNumGuildMembers() do
    local name = GetGuildRosterInfo(i)
    if (name) then guildMembers[Ambiguate(name, "none")] = true end
  end

  local queryItemID = tonumber(query:match("|Hitem:(%d+)") or query:match("^item:(%d+)") or query:match("^(%d+)$"))
  local querySpellID = tonumber(query:match("|Hspell:(%d+)") or query:match("^spell:(%d+)"))
  local queryName = query:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|H.-|h(.-)|h", "%1")
  queryName = Craftie:SanitizeString(queryName, true)
  local results = {}

  local function RecipeMatches(recipe)
    if (queryItemID) then return tonumber(recipe[4]) == queryItemID end
    if (querySpellID) then return tonumber(recipe[1]) == querySpellID end

    local recipeName = Craftie:SanitizeString(recipe[2], true)
    local enchantName = recipeName:gsub("^enchant%s+", "")
    return recipeName:find(queryName, 1, true) ~= nil or enchantName:find(queryName, 1, true) ~= nil
  end

  local function RecipeLink(recipe)
    if recipe[4] == nil or recipe[4] == "" then
      return GetSpellLink(recipe[1]) or ("|Hspell:" .. recipe[1] .. "|h[" .. recipe[2] .. "]|h")
    end

    local _, itemLink = C_Item.GetItemInfo(recipe[4])
    return itemLink or ("|Hitem:" .. recipe[4] .. "|h[" .. recipe[2] .. "]|h")
  end

  local cacheRoot = Craftie.Save.Account and Craftie.Save.Account.CACHE
  if (cacheRoot) then
    for _, prof in pairs(Craftie.Professions) do
      local professionCache = cacheRoot[prof[2]:upper()]
      local recipes = Craftie.Profession[prof[2]]
      if (professionCache and recipes) then
        for crafter, cacheString in pairs(professionCache) do
          if (guildMembers[crafter]) then
            local knownRecipes = {}
            for _, cachedName in pairs(Craftie:Split(cacheString, ";")) do
              if (cachedName and cachedName ~= "") then
                knownRecipes[Craftie:SanitizeString(cachedName, true)] = true
              end
            end

            for _, recipe in pairs(recipes) do
              if knownRecipes[Craftie:SanitizeString(recipe[2], true)] and RecipeMatches(recipe) then
                table.insert(results, {crafter, RecipeLink(recipe), recipe[2]})
              end
            end
          end
        end
      end
    end
  end

  if (Ambiguate(author, "none") == Craftie.Player.Name) then
    table.sort(results, function(a, b)
      if a[3] == b[3] then return a[1] < b[1] end
      return a[3] < b[3]
    end)
    C_ChatInfo.SendChatMessage("[Craftie] Recipe Search: Found [" .. #results .. "]", "GUILD", nil)
    for i, result in ipairs(results) do
      local crafter = result[1]
      local recipeLink = result[2]
      C_Timer.After(i * 0.15, function()
        C_ChatInfo.SendChatMessage(crafter .. " " .. recipeLink, "GUILD", nil)
      end)
    end
  end

  return false, msg, author, ...
end

hooksecurefunc("SetItemRef", function(link, text, button)
  -- Check if the clicked link is an item
  local linkType = Craftie:Split(link, ":")
  --print("linkType " .. linkType[1])

  if (linkType[1] == "spell") then
    --print("text " .. text)
    local spellData = Craftie:Split(text, ":")
    --for k,v in pairs(spellData) do
      --print(k .. " | " .. v)
    --end
    if (spellData[4] == Craftie._G.Prefix) then
      --local playerData = Craftie:Split(spellData[5], "-") --remove realm data
      local player = Ambiguate(spellData[5], "none")
      local profLink   = spellData[6]
      local profSplit = Craftie:Split(profLink, "|") --clean up link
      local prof = profSplit[1]
      --print(player .. " | " .. prof)
      ItemRefTooltip:Hide() --make this an option?
      if ((player ~= Craftie.Player.Name) or (Craftie.DEBUGLEVEL >= 3)) then
        Craftie:PacketSend(Craftie.Packet.Prefix.Ping, Craftie.Player.Name .. "," .. prof, "WHISPER", player)
        Craftie.Packet.ACK[player] = 0
        Craftie:Notification(Craftie._L.Notification.Collecting .. Craftie.Color.Blue .. " [" .. prof .. "]|r from " .. player .. "...", Craftie.CHAT.INFO)
        C_Timer.After(Craftie.Packet.Timeout, function()
           --if the ack doesnt come back from the backet within this timeframe, timeout!
          if (Craftie.Packet.ACK[player] == 0) then
            Craftie:Notification("[" .. player .. "] " .. Craftie._L.Notification.Outdated, Craftie.CHAT.WARN)
          else
            if (Craftie.Save.Player.CONFIG["AUTO_OPEN"] == 0) then
              Craftie:Notification(Craftie._L.Notification.Adding .. " " .. player .. " - " .. Craftie.Color.Blue .. "[" .. prof .. "]", Craftie.CHAT.INFO)
            else
              --print("open book to player " .. player)
              Craftie:UpdateCrafterList()
              Craftie:GetCrafterIndex(player)
            end
          end
        end)
      end
      if (Craftie.Save.Player.CONFIG["AUTO_OPEN"] ~= 0) then
        --we still need to open the book, but cache the incoming data
        C_Timer.After(0.2, function()
          Craftie:Notification("SetItemRef " .. prof, Craftie.CHAT.FUNC)
          Craftie:Open(player, prof) --need to cache player data loading
        end)
      end
    end
  end
end)

--[==[
--Dont use! API was changed and this causes performance issues
EventRegistry:RegisterCallback("SetItemRef", function(init, link, text, button, chatFrame)
end)
]==]--
