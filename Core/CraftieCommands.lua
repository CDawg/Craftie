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

--need to localize the commands
local commands = {
  {"options", "Settings"},
  {"debug",   "info here"},
  {"log",     "Open The Debug Logger"},
  {"delete",  "Delete a table [config | crafters | orders | favs]"},
}

SLASH_Craftie1 = "/" .. Craftie._G.Prefix:lower()
function SlashCmdList.Craftie(cmd)
  if ((cmd == nil) or (cmd == "")) then
    Craftie:Open()
    Craftie:Notification("Commands:", Craftie.CHAT.INFO)
    for k,v in pairs(commands) do
      print(Craftie.Color.Lime .. v[1] .. "|r    " .. v[2])
    end
	end
	local _, _, cmd, args = string.find(cmd, "%s?(%w+)%s?(.*)")

  if (cmd == commands[1][1]) then
    Settings.OpenToCategory(Craftie.Settings.Category:GetID())
    Craftie.Frame:Hide()
  end

  if (cmd == commands[2][1]) then
    local count = 0
    for i in pairs(Craftie.CHAT) do
      count = count+1
    end
    if (args == "") then
      local sorted = {}
      for key, value in pairs(Craftie.CHAT) do
        table.insert(sorted, {key=key,num=value[1],text=value[2]})
      end
      table.sort(sorted, function(a, b)
        return a.num < b.num
      end)
      for _, v in ipairs(sorted) do
        if (v.num <= Craftie.DEBUGLEVEL) then
          Craftie:Notification(v.num .. " = " .. Craftie:TextSpacing(v.text, 19) .. Craftie.Color.Lime .. "[ON]", Craftie.CHAT.INFO)
        else
          Craftie:Notification(v.num .. " = " .. Craftie:TextSpacing(v.text, 19) .. Craftie.Color.Gray .. "[OFF]", Craftie.CHAT.INFO)
        end
      end
    else
      if (args) then
        if (tonumber(args) > count) then
          Craftie.Notification("Max debug level = " .. count, Craftie.CHAT.INFO)
        else
          Craftie.DEBUGLEVEL = tonumber(args)
          Craftie.Save.Player.CONFIG["DEBUGLEVEL"] = tonumber(args)
        end
      else
        Craftie:Notification("Debug Level must be an integer [1-".. count .."]", Craftie.CHAT.ERROR)
      end
      Craftie:Notification("Debug Level set to " .. Craftie.DEBUGLEVEL, Craftie.CHAT.INFO)
    end
    Craftie:Notification("Debug Level = " ..Craftie.DEBUGLEVEL, Craftie.CHAT.INFO)
  end

  if (cmd == commands[3][1]) then
    Craftie.Logger:Show()
  end

  if (cmd == commands[4][1]) then
    if ((args == "") or (args == nil)) then
      print("|n" .. commands[4][2] .. "|n")
    end
    if (args == "config") then
      CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["CONFIG"] = {}
      ReloadUI()
    end
    if (args == "orders") then
      CraftieDB[Craftie.Player.Realm][Craftie.Player.Faction][Craftie.Player.Name]["ORDERS"] = {}
      Craftie:GetCraftOrders()
    end
  end

  if ((cmd == nil) or (cmd == "")) then
    print("|n")
  end

end
