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
    Craftie.Chat[v[1]] = {}
  end

  for k,v in pairs(Craftie.Professions) do
    prof_parent = "[" .. v[1]
    table.insert(Craftie.Chat[v[1]], v[1])
    if (v[4][1] ~= nil) then
      for a,b in pairs(v[4]) do
        --print(" - " .. b)
        table.insert(Craftie.Chat[v[1]], b)
        prof_parent = prof_parent .. " | " .. b
      end
    end
    Craftie:Notification("Craftie:BuildChatHooks: " .. prof_parent .. "]", Craftie.CHAT.FUNC)
  end

  for k,v in pairs(Craftie.Professions) do
    Craftie.ChatFilter[v[1]] = function(self, event, msg, author, ...)
      --local parent = Craftie.Chat.Alchemy[1]
      for a,b in pairs(Craftie.Chat[v[1]]) do
        local pattern= "%[" .. b .. "%]"
        if (msg:find(pattern)) then --register the author data
          local filter = gsub(msg, pattern, "|Haddon:Craftie:" .. author .. ":" .. v[1] .. "|h|T" .. Craftie._G.Path .. "Images/" .. Craftie._G.Icon .. ".png:14:14|t" .. pattern .. "|h|r")
          --local filter = gsub(msg, pattern, "|Haddon:Craftie:" .. author .. ":" .. v[1] .. "|h|T" .. Craftie._G.Path .. "Images/" .. Craftie._G.Icon .. ".png:14:14|t[Craftie" .. pattern .. "]|h|r")
          return false, filter, author, ...
        end
      end
    end
  end

  for k,v in pairs(Craftie.ChannelList) do
    for _,prof in pairs(Craftie.Professions) do
      --segment each primary profession
      ChatFrame_AddMessageEventFilter(v, Craftie.ChatFilter[prof[1]])
    end
  end

  --ChatFrame_AddMessageEventFilter(v, Craftie.ChatFilter[prof[1]])"CHAT_MSG_SYSTEM",
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
        Craftie:SendPacket(Craftie.Packet.Prefix.Ping, Craftie.Player.Name .. "," .. prof, "WHISPER", player)
        Craftie.Packet.ACK[player] = 0
        C_Timer.After(Craftie.Packet.Timeout, function()
           --if the ack doesnt come back from the backet within this timeframe, timeout!
          if (Craftie.Packet.ACK[player] == 0) then
            Craftie:Notification("[" .. player .. "] has outdated data", Craftie.CHAT.WARN)
          end
          Craftie:UpdateCrafterList()
          --print("open book to player " .. player)
          Craftie:GetCrafterIndex(player)
        end)
      end
      --we still need to open the book, but cache the incoming data
      C_Timer.After(0.2, function()
        Craftie:Notification("SetItemRef " .. prof, Craftie.CHAT.FUNC)
        Craftie:Open(player, prof) --need to cache player data loading
      end)
    end
  end
end)

--[==[
--Dont use! API was changed and this causes performance issues
EventRegistry:RegisterCallback("SetItemRef", function(init, link, text, button, chatFrame)
end)
]==]--
