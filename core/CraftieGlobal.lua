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

Craftie._G = {
  --title  = TOCA.colors.class[7][4] .. TOCA._L.TITLE .."|r",
  author = "Porthias",
  CMD    = "/craftie",
  --width  = 150,
  --height = 85,
  font   = "Interface/Addons/Craftie/fonts/FRIZQT__.TTF",
  dir    = "Interface/Addons/Craftie/",
  prefix = "CRAHH",
  suffix = "TBC Anniversary",
  date   = date("%Y%m%d"),
  update = 20260608,
}

Craftie.Framelevel = {
  Background= 0,
  Foreground= 1,
  Menu      = 2,
  Buttons   = 3,
  Cover     = 4,
}

Craftie.Backdrop = {
  General = {
    bgFile  = "Interface/Tooltips/UI-Tooltip-Background",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 12,
    insets  = {left=2, right=2, top=2, bottom=2},
  },
  Button = {
    bgFile  = "Interface/Buttons/GoldGradiant",
    edgeFile= "Interface/ToolTips/UI-Tooltip-Border",
    edgeSize= 10,
    insets  = {left=2, right=2, top=2, bottom=2},
  },
  Slider = {
    Template = "UISliderTemplateWithLabels",
  }
}

function Craftie.Notification(msg, debug)
  if (debug) then
    print(msg)
  end
end

function Craftie.Init()
--init
end

Craftie.Professions = {
--in order
  {"FirstAid"},
  {"Blacksmithing", "Trade_BlackSmithing", "0.60, 0.54, 0.48"}, --["Alchemy"] = "Interface\\Icons\\Trade_Alchemy",
  {"Leatherworking","Trade_LeatherWorking","0.76, 0.63, 0.42"},
  {"Alchemy",       "Trade_Alchemy",       "0.72, 0.80, 0.19"},
  {"Herbalism"},
  {"Cooking",       "INV_Misc_Food_15",    "0.88, 0.44, 0.13"},
  {"Mining"},
  {"Tailoring",     "Trade_Tailoring",     "0.91, 0.69, 0.88"},
  {"Engineering",   "Trade_Engineering",   "0.91, 0.75, 0.25"},
  {"Enchanting",    "Trade_Engraving",     "0.73, 0.33, 0.83"},
  {"Fishing"},
  {"Skinning"},
  {"Jewelcrafting", "INV_Misc_Gem_02",     "1.00, 0.25, 0.25"},
}

function Craftie.GetProfessionsPlayer()
	local pass = false
	local skills = {}
	local skillnum = 0
	local header1 = string.lower( TRADE_SKILLS )
	local header2 = string.lower( SECONDARY_SKILLS )
	for k = 1, GetNumSkillLines( ) do
		local name, header = GetSkillLineInfo( k )
		if header ~= nil then
			name = string.lower( name )
			if string.match( header1, name ) or string.match( header2, name ) then
				pass = true
				if string.match( header2, name ) and skillnum < 2 then
					skillnum = 2
				end
			else
				pass = false
			end
		else
			if (pass) then
				skillnum = skillnum + 1
				skills[skillnum] = k
			end
		end
	end
	return skills[1], skills[2], skills[3], skills[4], skills[5]
end

function Craftie.GetProfessionsLibrary(lib)

end

function Craftie.SendPacket(packet, channel, compress)
  compressPacket = packet
  if (compress) then
    compressPacket = packet:gsub("%s+", "") --filter spaces
  end
  Craftie.Notification("sending packet " .. compressPacket, true)
  if (channel == "GUILD") then
    if (not IsInGuild()) then return end
  end
  C_ChatInfo.SendAddonMessage("CRAHH", compressPacket, channel)
  Craftie.Notification("sending packet " .. compressPacket, true)
end

function Craftie.ParsePacket(netpacket, code)
  if (netpacket) then
    if (string.sub(netpacket, 1, strlen(code)) == code) then
      parse = string.gsub(netpacket, code, "")
      return parse
    end
  end
end
