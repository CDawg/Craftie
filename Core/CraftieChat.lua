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
  C_GuildInfo.GuildRoster()
  local numTotalMembers, numOnlineMembers = GetNumGuildMembers()
  --local pattern= "craftie who %["
  local pattern= "craftie recipe "
  local recipelist = {}
  local count = 0
  if (msg:find(pattern)) then
    local negate_pattern = string.gsub(msg, pattern, "")
    if (negate_pattern:len() >= 2) then --did we actually type something
      for _,prof in pairs(Craftie.Professions) do
        --print(prof[1])
        if (Craftie.Save.Account.CACHE ~= nil) then
          if (Craftie.Save.Account.CACHE[prof[2]:upper()] ~= nil) then
            --print(prof[1]:upper())
            for i = 1, numTotalMembers do
              local name = GetGuildRosterInfo(i)
              --print(name)
              if (name) then
                local guild_crafter = Ambiguate(name, "none")
                if (Craftie.Save.Account.CACHE[prof[2]:upper()][guild_crafter] ~= nil) then
                  local cachestring = Craftie:Split(Craftie.Save.Account.CACHE[prof[2]:upper()][guild_crafter], ";")

                  for k,cache in pairs(cachestring) do
                    if ((cache ~= nil) and (cache ~= "")) then --who can make it that's cached
                      --print(guild_crafter .. " can make " .. Craftie:SanitizeString(cache, true))
                      local match = string.gsub(msg, pattern, "")
                      local item_name = string.gsub(match, "%b[]", "")
                      local item_link = Craftie:Split(item_name, ":")

                      for _,recipe in pairs(Craftie.Profession[prof[2]]) do
                        --print(recipe[1] .. " " .. recipe[2] .. " item_name " .. item_name)
                        if (item_link[2] ~= nil) then
                          item_name = C_Item.GetItemInfo(item_link[2]) --someone posted a link, get ID
                        end
                        if (Craftie:SanitizeString(item_name, true) == Craftie:SanitizeString(recipe[2], true) and Craftie:SanitizeString(item_name, true) == Craftie:SanitizeString(cache, true)) then
                          local itemName, itemLink = C_Item.GetItemInfo(recipe[4]) --id
                          C_Timer.After(0.2, function() --give it time to register/cache
                            if (itemName) then
                              --print("found: " .. guild_crafter .. " - ".. prof[1] .. " - " .. recipe[1] .. " - " .. itemName)
                              count = count +1
                              table.insert(recipelist, {guild_crafter, itemLink})
                            end
                          end)
                        end
                      end

                    end
                  end

                end
              end
            end
          end
        end
      end

      if (Ambiguate(author, "none") == Craftie.Player.Name) then
        C_ChatInfo.SendChatMessage("Craftie Searching...", "GUILD", nil)
        --local item_name = string.gsub(negate_pattern, "%b[]", "")
        --print(item_name)
        C_Timer.After(2, function() --give it time to register/cache
          C_ChatInfo.SendChatMessage("Craftie Recipe Search: Found [" .. count .. "]", "GUILD", nil)
          if (count >= 1) then
            for k,v in pairs(recipelist) do
              if (v[2] ~= nil) then
                --print("recipelist: " .. k .. " | " .. v[1] .. " | " .. v[2])
                C_Timer.After(count*0.120, function()
                  C_ChatInfo.SendChatMessage(v[1] .. " " .. v[2], "GUILD", nil)
                end)
              end
            end
          end
        end)
      end
      local filter = gsub(msg, pattern, pattern)
      return false, filter, author, ...
    end
  end
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
      --local player = Ambiguate(name, "none")
      local playerData = Craftie:Split(spellData[5], "-") --remove realm data
      local player = playerData[1]
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
