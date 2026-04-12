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

Craftie.Profession.Alchemy = {
{2454, "Elixir of Lion's Strength"},
{2457, "Elixir of Minor Agility"},
{2458, "Elixir of Minor Fortitude"},
{3383, "Elixir of Wisdom"},
{3389, "Elixir of Defense"},
{3390, "Elixir of Lesser Agility"},
{3391, "Elixir of Ogre's Strength"},
{3495, "Elixir of Suffering"},
{3497, "Elixir of Pain"},
{3825, "Elixir of Fortitude"},
{3828, "Elixir of Detect Lesser Invisibility"},
{5996, "Elixir of Water Breathing"},
{5997, "Elixir of Minor Defense"},
{6373, "Elixir of Firepower"},
{6662, "Elixir of Giant Growth"},
{8827, "Elixir of Water Walking"},
{8949, "Elixir of Agility"},
{8951, "Elixir of Greater Defense"},
{9154, "Elixir of Detect Undead"},
{9179, "Elixir of Greater Intellect"},
{9187, "Elixir of Greater Agility"},
{9197, "Elixir of Dream Vision"},
{9206, "Elixir of Giants"},
{9224, "Elixir of Demonslaying"},
{9233, "Elixir of Detect Demon"},
{9264, "Elixir of Shadow Power"},
{13445, "Elixir of Superior Defense"},
{13447, "Elixir of the Sages"},
{13452, "Elixir of the Mongoose"},
{13453, "Elixir of Brute Force"},
{17708, "Elixir of Frost Power"},
{18294, "Elixir of Greater Water Breathing"},
{21546, "Elixir of Greater Firepower"},
{22823, "Elixir of Camouflage"},
{22824, "Elixir of Major Strength"},
{22825, "Elixir of Healing Power"},
{22827, "Elixir of Major Frost Power"},
{22830, "Elixir of the Searching Eye"},
{22831, "Elixir of Major Agility"},
{22833, "Elixir of Major Firepower"},
{22834, "Elixir of Major Defense"},
{22835, "Elixir of Major Shadow Power"},
{22840, "Elixir of Major Mageblood"},
{22848, "Elixir of Empowerment"},
{28104, "Elixir of Mastery"},
{32062, "Elixir of Major Fortitude"},
{32067, "Elixir of Draenic Wisdom"},
{32068, "Elixir of Ironskin"},
{32446, "Elixir of Shadows"},
{33080, "Elixir of Water Elementals"},
{45621, "Elixir of Minor Accuracy"},
}

--select entry, name, ItemLevel from item_template where name like "Elixir%" and ItemLevel < 80 and spellid_1 > 0 order by entry ASC;
