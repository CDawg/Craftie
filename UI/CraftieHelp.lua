--[==[
Copyright ©2020 Porthias of Myzrael or Porthios of Myzrael

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

--Help / Contact
Craftie.Contact = {
  "|n" .. Craftie.Color.Yellow .. "Curseforge|r|nhttps://www.curseforge.com/wow/addons/craftie/",
  "|n" .. Craftie.Color.Yellow .. "Discord (.porthios)|r|nhttps://discordapp.com/users/238146303324979200",
}

local dimensions = {
  W = Craftie.Frame:GetWidth()-26,
  H = Craftie.Frame:GetHeight()-124,
  X = 12,
  Y = -100
}

Craftie.Help = CreateFrame("Frame", "Craftie.Help", Craftie.Frame)
Craftie.Help:SetWidth(dimensions.W)
Craftie.Help:SetHeight(dimensions.H)
Craftie.Help:SetPoint("TOPLEFT", dimensions.X, dimensions.Y)
--Craftie.Help:SetFrameStrata("MEDIUM")

Craftie.HelpScrollFrame={}
Craftie.HelpScrollFrame = CreateFrame("Frame", "Craftie.HelpScrollFrame", Craftie.Help, "InsetFrameTemplate4")
Craftie.HelpScrollFrame:SetWidth(Craftie.Help:GetWidth())
Craftie.HelpScrollFrame:SetHeight(Craftie.Help:GetHeight())
Craftie.HelpScrollFrame:SetPoint("TOPLEFT", 0, 0)

Craftie.HelpScrollFrameBack = Craftie.HelpScrollFrame:CreateTexture(nil, "BACKGROUND")
Craftie.HelpScrollFrameBack:SetWidth(Craftie.HelpScrollFrame:GetWidth())
Craftie.HelpScrollFrameBack:SetHeight(Craftie.HelpScrollFrame:GetHeight())
Craftie.HelpScrollFrameBack:SetPoint("TOPLEFT", 0, 0)
Craftie.HelpScrollFrameBack:SetTexture(Craftie._G.Image.Background.Shadow)
Craftie.HelpScrollFrameBack:SetDesaturation(0.3)

Craftie.HelpScrollFrame.Child = CreateFrame("ScrollFrame", nil, Craftie.HelpScrollFrame, "UIPanelScrollFrameTemplate")
Craftie.HelpScrollFrame.Child:SetPoint("TOPLEFT", Craftie.HelpScrollFrame, "TOPLEFT", 5, -10)
Craftie.HelpScrollFrame.Child:SetPoint("BOTTOMRIGHT", Craftie.HelpScrollFrame, "BOTTOMRIGHT", 10, 10)
Craftie.HelpScrollFrameChildFrame = CreateFrame("Frame", "Craftie.HelpScrollFrameChildFrame", Craftie.HelpScrollFrame.Child)
Craftie.HelpScrollFrameChildFrame:SetSize(Craftie.Help:GetWidth(), Craftie.Help:GetHeight())
Craftie.HelpScrollFrame.Child:SetScrollChild(Craftie.HelpScrollFrameChildFrame)
Craftie.HelpScrollFrame.Child.ScrollBar:ClearAllPoints()
Craftie.HelpScrollFrame.Child.ScrollBar:SetPoint("TOPLEFT", Craftie.HelpScrollFrame.Child, "TOPRIGHT", -32, -5)
Craftie.HelpScrollFrame.Child.ScrollBar:SetPoint("BOTTOMRIGHT", Craftie.HelpScrollFrame.Child, "BOTTOMRIGHT", -11, 5)

Craftie:ScrollBarFrame(Craftie.HelpScrollFrame.Child)

local help = {}

help[1] = Craftie:HelpBulletPoint("First Time Using Craftie?") .. [==[
Note: This setup only needs to be completed once per character.

 1. Open Craftie and select each profession your character knows.

   |TInterface/Addons/Craftie/Images/Help/help-craftie-new.png:128:64|t

 2. |CFF9CFFA1That's it!|r You're now ready to share your |CFF42DBFF[Recipe Book]|r in any chat channel.

   |TInterface/Addons/Craftie/Images/Help/help-spellbook.png:128:256|t
The first time you open a profession's recipe list, Craftie permanently links it to that profession.
Craftie automatically keeps your Recipe Book up to date whenever you learn new recipes or increase your profession skill.

This version is more concise while making the one-time setup and ongoing automation clear to new users.
]==]

help[2] = Craftie:HelpBulletPoint("Guild Members") .. [==[
Guild members who also use Craftie are automatically added to your Crafters list, allowing you to browse all of their known recipes.
]==]

help[3] = Craftie:HelpBulletPoint("Opening Another Crafter's Recipe Book") .. [==[
When another Craftie user posts their profession link, you can simply click it to view all of their available recipes and add them to your list of crafters.
Craftie enhances profession links shared in any chat.
]==]


Craftie.Help.Data={}
Craftie.Help.Data = CreateFrame("EditBox", nil, Craftie.HelpScrollFrameChildFrame)
Craftie.Help.Data:SetWidth(Craftie.Help:GetWidth()-110)
--Craftie.Help.Data:SetHeight(Craftie.Help:GetHeight())
--Craftie.Help.Data:SetFontObject(GameFontWhite)
Craftie.Help.Data:SetFont(Craftie._G.Font.Style.Alpha, Craftie._G.Font.Size, Craftie._G.Font.Flags)
Craftie.Help.Data:SetTextColor(1, 1, 0.9, 1)
Craftie.Help.Data:SetPoint("TOPLEFT", 24, -4)
Craftie.Help.Data:SetMultiLine(true)
Craftie.Help.Data:ClearFocus()
Craftie.Help.Data:SetAutoFocus(false)
Craftie.Help.Data:SetEnabled(false)
local help_sheet = ""
for k,v in pairs(help) do
  help_sheet = help_sheet .. v .. "|n|n"
end
Craftie.Help.Data:SetText(help_sheet)

Craftie.Help:Hide()
