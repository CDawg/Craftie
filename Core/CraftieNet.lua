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

function Craftie:PacketSend(prefix, data, channel, target)
  local repack = prefix .. "," .. Craftie._G.Version .. "," .. data
  local packet = Craftie:Split(data, ",")

  C_ChatInfo.RegisterAddonMessagePrefix(Craftie._G.Prefix)
  if (prefix == Craftie.Packet.Prefix.Data) then
    -- senderPrefix, senderVer, senderName, senderClass, profNum, profLevel, profData, profMastery
    repack = prefix .. "," .. Craftie._G.Version .. "," .. packet[1] .. "," .. packet[2] .. "," .. packet[3] .. "," .. packet[4] .. "," .. Craftie:BitCompression(packet[5], false) .. "," .. packet[6]
  end

  if (channel == "WHISPER") then
  	C_ChatInfo.SendAddonMessage(Craftie._G.Prefix, repack, channel, target)
    Craftie:Notification(repack .. " [" .. #repack .. "] -> " .. Craftie.Color.Lime .. target, Craftie.CHAT.SEND)
  else
    C_ChatInfo.SendAddonMessage(Craftie._G.Prefix, repack, channel)
    if (channel == "YELL") then channel = "LOCAL" end
    Craftie:Notification(repack .. " [" .. #repack .. "] -> " .. Craftie.Color.Yellow .. channel, Craftie.CHAT.SEND)
  end
  --Craftie:Notification("Prefix: " .. prefix, Craftie.CHAT.FUNC)
end

Craftie.VersionNotified = 0
function Craftie:VersionControl(version)
  --control if someone is behind a major version, only warn for minor version differences
  local stable_version = true

  --minor version difference
  if (version > tonumber(Craftie._G.Version)) then
    if (Craftie.VersionNotified ~= 1) then --dont spam the requester
      Craftie:Notification("You have an outdated version [" .. Craftie._G.Version .. "] of [" .. version .. "]", Craftie.CHAT.ERROR)
    end
    stable_version = false
    Craftie.VersionNotified = 1
  end

  --major version difference
  if (version < tonumber(Craftie._G.Version)) then
    if (version < tonumber(Craftie._G.Version) - 0.01) then --version is drastically outdated by 2 minor versions, do not pull data
      Craftie:Notification("Crafter has an outdated version [" .. version .. "] of [" .. Craftie._G.Version .. "]", Craftie.CHAT.ERROR)
      stable_version = false
    else
      Craftie:Notification("Crafter has an outdated version [" .. version .. "] of [" .. Craftie._G.Version .. "]", Craftie.CHAT.WARN)
      stable_version = true
    end
  end
  return stable_version
end

function Craftie:PacketParse(netpacket)
  local prefix = ""
  local version = 0

  if (string.sub(netpacket, 1, 1) == "!") then
    local packet = Craftie:Split(netpacket, ",")

    prefix  = packet[1]
    version = tonumber(packet[2])

    Craftie:Notification(netpacket, Craftie.CHAT.ACK)

    --ping another crafter for their data
    if (prefix == Craftie.Packet.Prefix.Ping) then
      local requester = packet[3]
      local profPack = packet[4]
      local profParse = Craftie:Split(profPack, "|")
      local profName = profParse[1]
      local profData = ""

      if ((requester ~= Craftie.Player.Name) or (Craftie.DEBUGLEVEL >= 3)) then
        Craftie:Notification("You were pinged by " .. requester .. " for " .. profName, Craftie.CHAT.ACK)
        --get my saved prof data and send it
        if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()] ~= nil) then
          if (CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()][Craftie.Player.Name] ~= nil) then
            profData = CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()][Craftie.Player.Name]
            if (profData ~= "") then
              Craftie:PacketSend(Craftie.Packet.Prefix.Data, Craftie.Player.Name .. "," .. profData, "WHISPER", requester)
            end
          end
        else
          Craftie:Notification("You were pinged by " .. requester .. " for " .. profName .. " and you have outdated data!", Craftie.CHAT.WARN)
        end
      else
        --rather than a break, just ignore
        Craftie:Notification("Requester == Self. Ignoring", Craftie.CHAT.ACK)
      end
    end

    --handshake, get the other crafters data and store it
    --similar to Craftie:CrafterBuildData
    if (Craftie:VersionControl(version)) then
      if (prefix == Craftie.Packet.Prefix.Data) then
        local crafterName = packet[3]
        local crafterClass = packet[4]
        local profName  = Craftie.Professions[tonumber(packet[5])][1]
        local profNum   = packet[5]
        local profLevel = packet[6]
        local crafterData = Craftie:BitCompression(packet[7], Craftie.CHAT.ACK) --decompress
        local profMastery = packet[8]
        Craftie:Notification("Receiving Data:|n" .. crafterName .. "|" .. profName .. "|n" .. crafterData .. "," .. profMastery, Craftie.CHAT.ACK)
        --store it
        Craftie.Packet.ACK[crafterName] = 1 --got an ack
        Craftie.PlayerOnline[crafterName] = 1
        local profString = crafterClass .. "," .. profNum .. "," .. profLevel .. "," .. crafterData .. "," .. profMastery .. "," .. Craftie.Date
        Craftie:Notification(profString, Craftie.CHAT.SAVE)
        CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction]["BLOB"][profName:upper()][crafterName] = profString
      end
    end

    --receiving tooltip info from players locally
    if (prefix == Craftie.Packet.Prefix.Info) then
      --print(netpacket)
      if (packet[4] ~= nil) then
        local crafter = packet[3]
        local craftData = Craftie:Split(packet[4], ";")
        --local tooltip={}
        local a={}
        local b={}
        local c={}
        Craftie.PlayerGUIDProf[crafter]={}
        if (craftData[1] ~= "") then
          a = Craftie:Split(craftData[1], ":")
          --table.insert(tooltip, {prof1=p[1], prof1L=p[2]})
          Craftie.PlayerGUIDProf[crafter]={profN1=a[1], profL1=a[2], profM1=tonumber(a[3])}
        end
        if (craftData[2] ~= "") then
          b = Craftie:Split(craftData[2], ":")
          --table.insert(tooltip, {prof2=p[1], prof2L=p[2]})
          Craftie.PlayerGUIDProf[crafter]={profN1=a[1], profL1=a[2], profM1=tonumber(a[3]), profN2=b[1], profL2=b[2], profM2=tonumber(b[3])}
        end
        if (craftData[3] ~= "") then
          c = Craftie:Split(craftData[3], ":")
          --table.insert(tooltip, {prof3=p[1], prof3L=p[2]})
          Craftie.PlayerGUIDProf[crafter]={profN1=a[1], profL1=a[2], profM1=tonumber(a[3]), profN2=b[1], profL2=b[2], profM2=tonumber(b[3]), profN3=c[1], profL3=c[2], profM3=tonumber(c[3])}
        end
      end
    end

    --online
    if (prefix == Craftie.Packet.Prefix.Net) then
      --print(packet[3] .. " | " .. packet[4])
      if ((packet[3] ~= nil) and (packet[4] ~= nil)) then
        Craftie.PlayerOnline[packet[3]] = 1
        Craftie:Notification("Online Ping Status: " .. packet[3], Craftie.CHAT.ACK)
      end
    end

    --receiving order
    if (prefix == Craftie.Packet.Prefix.Order) then
      --print(packet[3] .. " | " .. packet[4])
      if ((packet[3] ~= nil) and (packet[5] ~= nil)) then
        if (Craftie.Save.Player["ORDERS"] == nil) then
          Craftie.Save.Player["ORDERS"] = {} --doesnt exist, just build it
          Craftie:Notification("Building New Orders table", Craftie.CHAT.FUNC)
        end
        --Craftie:PacketSend(Craftie.Packet.Prefix.Ack, Craftie.Player.Name .. ",1", "WHISPER", packet[3])
        C_Timer.After(0.1, function()
          Craftie.Save.Player["ORDERS"][packet[3]] = packet[4] .. "," .. packet[5] .. "," .. packet[6] .. "," .. Craftie.Date
        end)
        C_Timer.After(0.2, function()
          Craftie:Notification("Order From: " .. packet[3] .. "," .. packet[5], Craftie.CHAT.FUNC)
          if (Craftie.Save.Player.CONFIG["ORDERNOTIF1"] ~= 0) and (not IsInRaid()) then
            if (Craftie.Save.Player.CONFIG["ORDERNOTIF2"] ~= 0) and (not IsInInstance()) then
              if (Craftie.Save.Player.CONFIG["ORDERNOTIF3"] ~= 0) and (Craftie.IsInCombat == false) then
                Craftie:AlertIcon(0)
              end
            end
          end
          Craftie:GetCraftOrders()
        end)
      end
    end

  else
    Craftie:Notification("Malformed Packet [Version Mismatch]: " .. netpacket, Craftie.CHAT.ERROR)
  end
  --Craftie:Notification("Malformed Packet [Bad Prefix]: " .. netpacket, Craftie.CHAT.ERROR)
end
