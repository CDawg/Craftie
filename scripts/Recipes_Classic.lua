function SetSkillLevels(a, b, c, d, e)
    --return a
end

function SetCraftedItem(num, data)
end

function SetRecipeItem(num, data)
end

function AddQuest()
    --return "Quest"
end

function AddTrainer()
    --return "Trainer"
end

function AddVendor()
    --return "vendor"
end

function AddWorldDrop()
    --return "drop"
end

function AddQuest()
    --return "quest"
end

function AddDrop()
    --return "drop"
end

FullRecipe = {}
key = 0
function AddRecipe(name, id)
  key = key+1
  --FullRecipe[key] = name
  FullRecipe[key] = {id, name}
end

AddRecipe("Spiced Wolf Meat", 2539)
SetSkillLevels(10, 10, 50, 70, 90)
SetCraftedItem(2680, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Charred Wolf Meat", 2538)
SetSkillLevels(1, 1, 45, 65, 85)
SetCraftedItem(2679, "BIND_ON_EQUIP")

AddQuest()

AddRecipe("Roasted Boar Meat", 2540)
SetSkillLevels(1, 1, 45, 65, 85)
SetCraftedItem(2681, "BIND_ON_EQUIP")

AddQuest()

AddRecipe("Coyote Steak", 2541)
SetSkillLevels(50, 50, 90, 110, 130)
SetCraftedItem(2684, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Goretusk Liver Pie", 2542)
SetSkillLevels(50, 50, 90, 110, 130)
SetRecipeItem(2697, "BIND_ON_EQUIP")
SetCraftedItem(724, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Westfall Stew", 2543)
SetSkillLevels(50, 50, 115, 135, 155)
SetRecipeItem(728, "BIND_ON_PICKUP")
SetCraftedItem(733, "BIND_ON_EQUIP")

AddVendor()
AddWorldDrop()

AddRecipe("Crab Cake", 2544)
SetSkillLevels(75, 75, 115, 135, 155)
SetCraftedItem(2683, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Cooked Crab Claw", 2545)
SetSkillLevels(85, 85, 125, 145, 165)
SetRecipeItem(2698, "BIND_ON_PICKUP")
SetCraftedItem(2682, "BIND_ON_EQUIP")

AddVendor()
AddWorldDrop()

AddRecipe("Dry Pork Ribs", 2546)
SetSkillLevels(80, 80, 120, 140, 160)
SetCraftedItem(2687, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Redridge Goulash", 2547)
SetSkillLevels(100, 100, 135, 155, 175)
SetRecipeItem(2699, "BIND_ON_EQUIP")
SetCraftedItem(1082, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Succulent Pork Ribs", 2548)
SetSkillLevels(110, 110, 130, 150, 170)
SetRecipeItem(2700, "BIND_ON_EQUIP")
SetCraftedItem(2685, "BIND_ON_EQUIP")

AddVendor()
AddWorldDrop()

AddRecipe("Seasoned Wolf Kabob", 2549)
SetSkillLevels(100, 100, 140, 160, 180)
SetRecipeItem(2701, "BIND_ON_EQUIP")
SetCraftedItem(1017, "BIND_ON_EQUIP")

AddVendor()
AddQuest()

AddRecipe("Beer Basted Boar Ribs", 2795)
SetSkillLevels(10, 10, 60, 80, 100)
SetRecipeItem(2889, "BIND_ON_EQUIP")
SetCraftedItem(2888, "BIND_ON_EQUIP")

AddVendor()
AddQuest()

AddRecipe("Crocolisk Steak", 3370)
SetSkillLevels(80, 80, 120, 140, 160)
SetRecipeItem(3678, "BIND_ON_EQUIP")
SetCraftedItem(3662, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Blood Sausage", 3371)
SetSkillLevels(60, 60, 100, 120, 140)
SetRecipeItem(3679, "BIND_ON_EQUIP")
SetCraftedItem(3220, "BIND_ON_EQUIP")

AddVendor()
AddQuest()

AddRecipe("Murloc Fin Soup", 3372)
SetSkillLevels(90, 90, 130, 150, 170)
SetRecipeItem(3680, "BIND_ON_EQUIP")
SetCraftedItem(3663, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Crocolisk Gumbo", 3373)
SetSkillLevels(120, 120, 160, 180, 200)
SetRecipeItem(3681, "BIND_ON_EQUIP")
SetCraftedItem(3664, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Curiously Tasty Omelet", 3376)
SetSkillLevels(130, 130, 170, 190, 210)
SetRecipeItem(3682, "BIND_ON_EQUIP")
SetCraftedItem(3665, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Gooey Spider Cake", 3377)
SetSkillLevels(110, 110, 150, 170, 190)
SetRecipeItem(3683, "BIND_ON_EQUIP")
SetCraftedItem(3666, "BIND_ON_EQUIP")

AddVendor()
AddQuest()

AddRecipe("Big Bear Steak", 3397)
SetSkillLevels(110, 110, 150, 170, 190)
SetRecipeItem(3734, "BIND_ON_EQUIP")
SetCraftedItem(3726, "BIND_ON_EQUIP")

AddRecipe("Hot Lion Chops", 3398)
SetSkillLevels(125, 125, 175, 195, 215)
SetRecipeItem(3735, "BIND_ON_EQUIP")
SetCraftedItem(3727, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Tasty Lion Steak", 3399)
SetSkillLevels(150, 150, 190, 210, 230)
SetRecipeItem(3736, "BIND_ON_PICKUP")
SetCraftedItem(3728, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Soothing Turtle Bisque", 3400)
SetSkillLevels(175, 175, 215, 235, 255)
SetRecipeItem(3737, "BIND_ON_PICKUP")
SetCraftedItem(3729, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Barbecued Buzzard Wing", 4094)
SetSkillLevels(175, 175, 215, 235, 255)
SetRecipeItem(4609, "BIND_ON_EQUIP")
SetCraftedItem(4457, "BIND_ON_EQUIP")

AddTrainer()
AddVendor()

AddRecipe("Kaldorei Spider Kabob", 6412)
SetSkillLevels(10, 10, 50, 70, 90)
SetRecipeItem(5482, "BIND_ON_EQUIP")
SetCraftedItem(5472, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Scorpid Surprise", 6413)
SetSkillLevels(20, 20, 60, 80, 100)
SetRecipeItem(5483, "BIND_ON_EQUIP")
SetCraftedItem(5473, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Roasted Kodo Meat", 6414)
SetSkillLevels(35, 35, 75, 95, 115)
SetRecipeItem(5484, "BIND_ON_EQUIP")
SetCraftedItem(5474, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Fillet of Frenzy", 6415)
SetSkillLevels(50, 50, 90, 110, 130)
SetRecipeItem(5485, "BIND_ON_EQUIP")
SetCraftedItem(5476, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Strider Stew", 6416)
SetSkillLevels(50, 50, 90, 110, 130)
SetRecipeItem(5486, "BIND_ON_EQUIP")
SetCraftedItem(5477, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Dig Rat Stew", 6417)
SetSkillLevels(90, 90, 130, 150, 170)
SetRecipeItem(78342, "BIND_ON_PICKUP")
SetCraftedItem(5478, "BIND_ON_EQUIP")

AddDrop()

AddRecipe("Crispy Lizard Tail", 6418)
SetSkillLevels(100, 100, 140, 160, 180)
SetRecipeItem(5488, "BIND_ON_EQUIP")
SetCraftedItem(5479, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Lean Venison", 6419)
SetSkillLevels(110, 110, 150, 170, 190)
SetRecipeItem(5489, "BIND_ON_EQUIP")
SetCraftedItem(5480, "BIND_ON_EQUIP")


AddRecipe("Boiled Clams", 6499)
SetSkillLevels(50, 50, 90, 110, 130)
SetCraftedItem(5525, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Goblin Deviled Clams", 6500)
SetSkillLevels(125, 125, 165, 185, 205)
SetCraftedItem(5527, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Clam Chowder", 6501)
SetSkillLevels(90, 90, 130, 150, 170)
SetRecipeItem(5528, "BIND_ON_EQUIP")
SetCraftedItem(5526, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Giant Clam Scorcho", 7213)
SetSkillLevels(175, 175, 215, 235, 255)
SetRecipeItem(6039, "BIND_ON_EQUIP")
SetCraftedItem(6038, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Brilliant Smallfish", 7751)
SetSkillLevels(1, 1, 45, 65, 85)
SetRecipeItem(6325, "BIND_ON_EQUIP")
SetCraftedItem(6290, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Slitherskin Mackerel", 7752)
SetSkillLevels(1, 1, 45, 65, 85)
SetRecipeItem(6326, "BIND_ON_EQUIP")
SetCraftedItem(787, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Longjaw Mud Snapper", 7753)
SetSkillLevels(50, 50, 90, 110, 130)
SetRecipeItem(6328, "BIND_ON_EQUIP")
SetCraftedItem(4592, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Loch Frenzy Delight", 7754)
SetSkillLevels(50, 50, 90, 110, 130)
SetRecipeItem(6329, "BIND_ON_EQUIP")
SetCraftedItem(6316, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Bristle Whisker Catfish", 7755)
SetSkillLevels(100, 100, 140, 160, 180)
SetRecipeItem(6330, "BIND_ON_EQUIP")
SetCraftedItem(4593, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Rainbow Fin Albacore", 7827)
SetSkillLevels(50, 50, 90, 110, 130)
SetRecipeItem(6368, "BIND_ON_EQUIP")
SetCraftedItem(5095, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Rockscale Cod", 7828)
SetSkillLevels(175, 175, 190, 210, 230)
SetRecipeItem(6369, "BIND_ON_EQUIP")
SetCraftedItem(4594, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Savory Deviate Delight", 8238)
SetSkillLevels(85, 85, 125, 145, 165)
SetRecipeItem(6661, "BIND_ON_EQUIP")
SetCraftedItem(6657, "BIND_ON_EQUIP")

AddWorldDrop()

AddRecipe("Herb Baked Egg", 8604)
SetSkillLevels(1, 1, 45, 65, 85)
SetCraftedItem(6888, "BIND_ON_EQUIP")

AddQuest()

AddRecipe("Smoked Bear Meat", 8607)
SetSkillLevels(40, 40, 80, 100, 120)
SetRecipeItem(6892, "BIND_ON_EQUIP")
SetCraftedItem(6890, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Thistle Tea", 9513)
SetSkillLevels(60, 60, 100, 120, 140)
SetRecipeItem(18160, "BIND_ON_PICKUP")
SetCraftedItem(7676, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Goldthorn Tea", 13028)
SetSkillLevels(175, 175, 175, 190, 205)
SetCraftedItem(10841, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Lean Wolf Steak", 15853)
SetSkillLevels(125, 125, 165, 185, 205)
SetRecipeItem(12227, "BIND_ON_EQUIP")
SetCraftedItem(12209, "BIND_ON_EQUIP")

AddRecipe("Roast Raptor", 15855)
SetSkillLevels(175, 175, 215, 235, 255)
SetRecipeItem(12228, "BIND_ON_EQUIP")
SetCraftedItem(12210, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Hot Wolf Ribs", 15856)
SetSkillLevels(175, 175, 215, 235, 255)
SetRecipeItem(12229, "BIND_ON_EQUIP")
SetCraftedItem(13851, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Jungle Stew", 15861)
SetSkillLevels(175, 175, 215, 235, 255)
SetRecipeItem(12231, "BIND_ON_EQUIP")
SetCraftedItem(12212, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Carrion Surprise", 15863)
SetSkillLevels(175, 175, 215, 235, 255)
SetRecipeItem(12232, "BIND_ON_EQUIP")
SetCraftedItem(12213, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Mystery Stew", 15865)
SetSkillLevels(175, 175, 215, 235, 255)
SetRecipeItem(12233, "BIND_ON_EQUIP")
SetCraftedItem(12214, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Dragonbreath Chili", 15906)
SetSkillLevels(200, 200, 225, 237, 250)
SetRecipeItem(12239, "BIND_ON_EQUIP")
SetCraftedItem(12217, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Heavy Kodo Stew", 15910)
SetSkillLevels(200, 200, 225, 237, 250)
SetRecipeItem(12240, "BIND_ON_EQUIP")
SetCraftedItem(12215, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Spiced Chili Crab", 15915)
SetSkillLevels(225, 225, 250, 262, 275)
SetRecipeItem(16111, "BIND_ON_EQUIP")
SetCraftedItem(12216, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Monster Omelet", 15933)
SetSkillLevels(225, 225, 250, 262, 275)
SetRecipeItem(16110, "BIND_ON_EQUIP")
SetCraftedItem(12218, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Crispy Bat Wing", 15935)
SetSkillLevels(1, 1, 45, 65, 85)
SetRecipeItem(12226, "BIND_ON_EQUIP")
SetCraftedItem(12224, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Spotted Yellowtail", 18238)
SetSkillLevels(225, 225, 250, 262, 275)
SetRecipeItem(13939, "BIND_ON_EQUIP")
SetCraftedItem(6887, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Cooked Glossy Mightfish", 18239)
SetSkillLevels(225, 225, 250, 262, 275)
SetRecipeItem(13940, "BIND_ON_EQUIP")
SetCraftedItem(13927, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Grilled Squid", 18240)
SetSkillLevels(240, 240, 265, 277, 290)
SetRecipeItem(13942, "BIND_ON_EQUIP")
SetCraftedItem(13928, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Filet of Redgill", 18241)
SetSkillLevels(225, 225, 250, 262, 275)
SetRecipeItem(13941, "BIND_ON_EQUIP")
SetCraftedItem(13930, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Hot Smoked Bass", 18242)
SetSkillLevels(240, 240, 265, 277, 290)
SetRecipeItem(13943, "BIND_ON_EQUIP")
SetCraftedItem(13929, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Nightfin Soup", 18243)
SetSkillLevels(250, 250, 275, 285, 295)
SetRecipeItem(13945, "BIND_ON_EQUIP")
SetCraftedItem(13931, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Poached Sunscale Salmon", 18244)
SetSkillLevels(250, 250, 275, 285, 295)
SetRecipeItem(13946, "BIND_ON_EQUIP")
SetCraftedItem(13932, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Lobster Stew", 18245)
SetSkillLevels(275, 275, 300, 312, 325)
SetRecipeItem(13947, "BIND_ON_EQUIP")
SetCraftedItem(13933, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Mightfish Steak", 18246)
SetSkillLevels(275, 275, 300, 312, 325)
SetRecipeItem(13948, "BIND_ON_EQUIP")
SetCraftedItem(13934, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Baked Salmon", 18247)
SetSkillLevels(275, 275, 300, 312, 325)
SetRecipeItem(13949, "BIND_ON_EQUIP")
SetCraftedItem(13935, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Undermine Clam Chowder", 20626)
SetSkillLevels(225, 225, 250, 262, 275)
SetRecipeItem(16767, "BIND_ON_EQUIP")
SetCraftedItem(16766, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Mithril Head Trout", 20916)
SetSkillLevels(175, 175, 215, 235, 255)
SetRecipeItem(17062, "BIND_ON_EQUIP")
SetCraftedItem(8364, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Gingerbread Cookie", 21143)
SetSkillLevels(1, 1, 45, 65, 85)
SetRecipeItem(17200, "BIND_ON_EQUIP")
SetCraftedItem(17197, "BIND_ON_EQUIP")

AddVendor()


AddRecipe("Winter Veil Egg Nog", 21144)
SetSkillLevels(35, 35, 75, 95, 115)
SetRecipeItem(17201, "BIND_ON_EQUIP")
SetCraftedItem(17198, "BIND_ON_EQUIP")

AddVendor()


AddRecipe("Spider Sausage", 21175)
SetSkillLevels(200, 200, 225, 237, 250)
SetCraftedItem(17222, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Tender Wolf Steak", 22480)
SetSkillLevels(225, 225, 250, 262, 275)
SetRecipeItem(18046, "BIND_ON_EQUIP")
SetCraftedItem(18045, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Runn Tum Tuber Surprise", 22761)
SetSkillLevels(275, 275, 300, 312, 325)
SetRecipeItem(18267, "BIND_ON_PICKUP")
SetCraftedItem(18254, "BIND_ON_EQUIP")

AddDrop()

AddRecipe("Heavy Crocolisk Stew", 24418)
SetSkillLevels(150, 150, 160, 180, 200)
SetRecipeItem(20075, "BIND_ON_EQUIP")
SetCraftedItem(20074, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Smoked Desert Dumplings", 24801)
SetSkillLevels(285, 285, 310, 322, 335)
SetCraftedItem(20452, "BIND_ON_EQUIP")

AddQuest()

AddRecipe("Dirge's Kickin' Chimaerok Chops", 25659)
SetSkillLevels(300, 300, 325, 337, 350)
SetRecipeItem(21025, "BIND_ON_EQUIP")
SetCraftedItem(21023, "BIND_ON_EQUIP")

AddRecipe("Smoked Sagefish", 25704)
SetSkillLevels(80, 80, 120, 140, 160)
SetRecipeItem(21099, "BIND_ON_EQUIP")
SetCraftedItem(21072, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Sagefish Delight", 25954)
SetSkillLevels(175, 175, 215, 235, 255)
SetRecipeItem(21219, "BIND_ON_EQUIP")
SetCraftedItem(21217, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Crunchy Spider Surprise", 28267)
SetSkillLevels(60, 60, 100, 120, 140)
SetRecipeItem(22647, "BIND_ON_EQUIP")
SetCraftedItem(22645, "BIND_ON_EQUIP")

AddVendor()
AddQuest()

AddRecipe("Lynx Steak", 33276)
SetSkillLevels(1, 1, 45, 65, 85)
SetRecipeItem(27685, "BIND_ON_EQUIP")
SetCraftedItem(27635, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Roasted Moongraze Tenderloin", 33277)
SetSkillLevels(1, 1, 45, 65, 85)
SetRecipeItem(27686, "BIND_ON_EQUIP")
SetCraftedItem(24105, "BIND_ON_EQUIP")

AddQuest()

AddRecipe("Bat Bites", 33278)
SetSkillLevels(50, 50, 90, 110, 130)
SetRecipeItem(27687, "BIND_ON_EQUIP")
SetCraftedItem(27636, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Buzzard Bites", 33279)
SetSkillLevels(300, 300, 320, 330, 340)
SetRecipeItem(27684, "BIND_ON_EQUIP")
SetCraftedItem(27651, "BIND_ON_EQUIP")

AddQuest()

AddRecipe("Ravager Dog", 33284)
SetSkillLevels(300, 300, 320, 330, 340)
SetRecipeItem(27688, "BIND_ON_EQUIP")
SetCraftedItem(27655, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Blackened Basilisk", 33286)
SetSkillLevels(315, 315, 335, 345, 355)
SetRecipeItem(27690, "BIND_ON_EQUIP")
SetCraftedItem(27657, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Roasted Clefthoof", 33287)
SetSkillLevels(325, 325, 345, 355, 365)
SetRecipeItem(27691, "BIND_ON_EQUIP")
SetCraftedItem(27658, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Warp Burger", 33288)
SetSkillLevels(325, 325, 345, 355, 365)
SetRecipeItem(27692, "BIND_ON_EQUIP")
SetCraftedItem(27659, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Talbuk Steak", 33289)
SetSkillLevels(325, 325, 345, 355, 365)
SetRecipeItem(27693, "BIND_ON_EQUIP")
SetCraftedItem(27660, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Blackened Trout", 33290)
SetSkillLevels(300, 300, 320, 330, 340)
SetRecipeItem(27694, "BIND_ON_EQUIP")
SetCraftedItem(27661, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Feltail Delight", 33291)
SetSkillLevels(300, 300, 320, 330, 340)
SetRecipeItem(27695, "BIND_ON_EQUIP")
SetCraftedItem(27662, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Blackened Sporefish", 33292)
SetSkillLevels(310, 310, 330, 340, 350)
SetRecipeItem(27696, "BIND_ON_EQUIP")
SetCraftedItem(27663, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Grilled Mudfish", 33293)
SetSkillLevels(320, 320, 340, 350, 360)
SetRecipeItem(27697, "BIND_ON_EQUIP")
SetCraftedItem(27664, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Poached Bluefish", 33294)
SetSkillLevels(320, 320, 340, 350, 360)
SetRecipeItem(27698, "BIND_ON_EQUIP")
SetCraftedItem(27665, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Golden Fish Sticks", 33295)
SetSkillLevels(325, 325, 345, 355, 365)
SetRecipeItem(27699, "BIND_ON_EQUIP")
SetCraftedItem(27666, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Spicy Crawdad", 33296)
SetSkillLevels(350, 350, 370, 375, 380)
SetRecipeItem(27700, "BIND_ON_EQUIP")
SetCraftedItem(27667, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Clam Bar", 36210)
SetSkillLevels(300, 300, 320, 330, 340)
SetRecipeItem(30156, "BIND_ON_EQUIP")
SetCraftedItem(30155, "BIND_ON_EQUIP")

AddVendor()

AddRecipe("Spice Bread", 37836)
SetSkillLevels(1, 1, 30, 35, 38)
SetCraftedItem(30816, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Mok'Nathal Shortribs", 38867)
SetSkillLevels(335, 335, 355, 365, 375)
SetRecipeItem(31675, "BIND_ON_PICKUP")
SetCraftedItem(31672, "BIND_ON_EQUIP")

AddVendor()
AddVendor()
AddQuest()

AddRecipe("Crunchy Serpent", 38868)
SetSkillLevels(335, 335, 355, 365, 375)
SetRecipeItem(31674, "BIND_ON_PICKUP")
SetCraftedItem(31673, "BIND_ON_EQUIP")

AddVendor()
AddVendor()
AddQuest()

AddRecipe("Stewed Trout", 42296)
SetSkillLevels(320, 320, 335, 345, 355)
SetCraftedItem(33048, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Fisherman's Feast", 42302)
SetSkillLevels(350, 350, 375, 380, 385)
SetCraftedItem(33052, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Hot Buttered Trout", 42305)
SetSkillLevels(350, 350, 375, 380, 385)
SetCraftedItem(33053, "BIND_ON_EQUIP")

AddTrainer()

AddRecipe("Skullfish Soup", 43707)
SetSkillLevels(325, 325, 335, 345, 355)
SetRecipeItem(33870, "BIND_ON_PICKUP")
SetCraftedItem(33825, "BIND_ON_EQUIP")

AddQuest()
AddQuest()

AddRecipe("Stormchops", 43758)
SetSkillLevels(300, 300, 320, 330, 340)
SetRecipeItem(33871, "BIND_ON_PICKUP")
SetCraftedItem(33866, "BIND_ON_EQUIP")

AddQuest()
AddQuest()

AddRecipe("Broiled Bloodfin", 43761)
SetSkillLevels(300, 300, 320, 330, 340)
SetRecipeItem(33869, "BIND_ON_PICKUP")
SetCraftedItem(33867, "BIND_ON_EQUIP")

AddQuest()
AddQuest()

AddRecipe("Spicy Hot Talbuk", 43765)
SetSkillLevels(325, 325, 335, 345, 355)
SetRecipeItem(33873, "BIND_ON_PICKUP")
SetCraftedItem(33872, "BIND_ON_EQUIP")

AddQuest()
AddQuest()

AddRecipe("Kibler's Bits", 43772)
SetSkillLevels(300, 300, 345, 355, 365)
SetRecipeItem(33875, "BIND_ON_PICKUP")
SetCraftedItem(33874, "BIND_ON_EQUIP")

AddQuest()
AddQuest()

AddRecipe("Delicious Chocolate Cake", 43779)
SetSkillLevels(1, 1, 50, 62, 75)
SetRecipeItem(33925, "BIND_ON_PICKUP")
SetCraftedItem(33924, "BIND_ON_EQUIP")

AddQuest()
AddQuest()



----------------------------------
---COMPARE
-----------------------------------

CookingArray = {
{7751, 'Brilliant Smallfish', 1, 6290, {{6291, 1}}, {'Vendor'}},
{15935, 'Crispy Bat Wing', 1, 12224, {{12223, 1}, {2678, 1}}, {'Vendor'}},
{43779, 'Delicious Chocolate Cake', 1, 33924, {{30817, 8}, {1179, 4}, {2678, 4}, {6889, 8}, {2593, 1}, {785, 3}}, {'Drop'}},
{21143, 'Gingerbread Cookie', 1, 17197, {{6889, 1}, {17194, 1}}, {'Vendor'}},
{8604, 'Herb Baked Egg', 1, 6888, {{6889, 1}, {2678, 1}}, {}},
{33276, 'Lynx Steak', 1, 27635, {{27668, 1}}, {'Vendor'}},
{33277, 'Roasted Moongraze Tenderloin', 1, 24105, {{23676, 1}}, {'Quest'}},
{7752, 'Slitherskin Mackerel', 1, 787, {{6303, 1}}, {'Vendor'}},
{37836, 'Spice Bread', 1, 30816, {{30817, 1}, {2678, 1}}, {"Trainer"}},
{6412, 'Kaldorei Spider Kabob', 10, 5472, {{5465, 1}}, {'Quest'}},
{2539, 'Spiced Wolf Meat', 10, 2680, {{2672, 1}, {2678, 1}}, {"Trainer"}},
{6413, 'Scorpid Surprise', 20, 5473, {{5466, 1}}, {'Vendor'}},
--{818, 'Basic Campfire', 25, '', {{4470, 1}}, {"Trainer"}},
{2795, 'Beer Basted Boar Ribs', 25, 2888, {{2886, 1}, {2894, 1}}, {'Quest', 'Vendor'}},
{21144, 'Egg Nog', 35, 17198, {{6889, 1}, {1179, 1}, {17196, 1}, {17194, 1}}, {'Vendor'}},
{6414, 'Roasted Kodo Meat', 35, 5474, {{5467, 1}, {2678, 1}}, {'Vendor'}},
{8607, 'Smoked Bear Meat', 40, 6890, {{3173, 1}}, {'Vendor'}},
{33278, 'Bat Bites', 50, 27636, {{27669, 1}}, {'Vendor'}},
{6499, 'Boiled Clams', 50, 5525, {{5503, 1}, {159, 1}}, {"Trainer"}},
{2541, 'Coyote Steak', 50, 2684, {{2673, 1}}, {"Trainer"}},
{6415, 'Fillet of Frenzy', 50, 5476, {{5468, 1}, {2678, 1}}, {'Vendor'}},
{2542, 'Goretusk Liver Pie', 50, 724, {{723, 1}, {2678, 1}}, {'Quest', 'Vendor'}},
{7754, 'Loch Frenzy Delight', 50, 6316, {{6317, 1}, {2678, 1}}, {'Vendor'}},
{7753, 'Longjaw Mud Snapper', 50, 4592, {{6289, 1}}, {'Vendor'}},
{7827, 'Rainbow Fin Albacore', 50, 5095, {{6361, 1}}, {'Vendor'}},
{6416, 'Strider Stew', 50, 5477, {{5469, 1}, {4536, 1}}, {'Quest', 'Vendor'}},
{3371, 'Blood Sausage', 60, 3220, {{3173, 1}, {3172, 1}, {3174, 1}}, {'Quest', 'Vendor'}},
{28267, 'Crunchy Spider Surprise', 60, 22645, {{22644, 1}}, {'Quest', 'Vendor'}},
{9513, 'Thistle Tea', 60, 7676, {{2452, 1}, {159, 1}}, {'Quest', 'Vendor'}},
{2544, 'Crab Cake', 75, 2683, {{2674, 1}, {2678, 1}}, {"Trainer"}},
{2543, 'Westfall Stew', 75, 733, {{729, 1}, {730, 1}, {731, 1}}, {'Quest', 'Vendor'}},
{3370, 'Crocolisk Steak', 80, 3662, {{2924, 1}, {2678, 1}}, {'Quest', 'Vendor'}},
{2546, 'Dry Pork Ribs', 80, 2687, {{2677, 1}, {2678, 1}}, {"Trainer"}},
{25704, 'Smoked Sagefish', 80, 21072, {{21071, 1}, {2678, 1}}, {'Vendor'}},
{2545, 'Cooked Crab Claw', 85, 2682, {{2675, 1}, {2678, 1}}, {'Drop', 'Vendor'}},
{8238, 'Savory Deviate Delight', 85, 6657, {{6522, 1}, {2678, 1}}, {'Drop'}},
{6501, 'Clam Chowder', 90, 5526, {{5503, 1}, {1179, 1}, {2678, 1}}, {'Vendor'}},
{6417, 'Dig Rat Stew', 90, 5478, {{5051, 1}}, {'Quest'}},
{3372, 'Murloc Fin Soup', 90, 3663, {{1468, 2}, {2692, 1}}, {'Quest', 'Vendor'}},
{7755, 'Bristle Whisker Catfish', 100, 4593, {{6308, 1}}, {'Vendor'}},
{45695, "Captain Rumsey's Lager", 100, 34832, {{2596, 1}, {2594, 1}}, {'Drop'}},
{6418, 'Crispy Lizard Tail', 100, 5479, {{5470, 1}, {2692, 1}}, {'Vendor'}},
{2547, 'Redridge Goulash', 100, 1082, {{1081, 1}, {1080, 1}}, {'Quest', 'Vendor'}},
{2549, 'Seasoned Wolf Kabob', 100, 1017, {{1015, 2}, {2665, 1}}, {'Quest', 'Vendor'}},
{3397, 'Big Bear Steak', 110, 3726, {{3730, 1}, {2692, 1}}, {'Quest', 'Vendor'}},
{3377, 'Gooey Spider Cake', 110, 3666, {{2251, 2}, {2692, 1}}, {'Quest', 'Vendor'}},
{6419, 'Lean Venison', 110, 5480, {{5471, 1}, {2678, 4}}, {'Vendor'}},
{2548, 'Succulent Pork Ribs', 110, 2685, {{2677, 2}, {2692, 1}}, {'Drop', 'Vendor'}},
{3373, 'Crocolisk Gumbo', 120, 3664, {{3667, 1}, {2692, 1}}, {'Quest', 'Vendor'}},
{6500, 'Goblin Deviled Clams', 125, 5527, {{5504, 1}, {2692, 1}}, {"Trainer"}},
{3398, 'Hot Lion Chops', 125, 3727, {{3731, 1}, {2692, 1}}, {'Quest', 'Vendor'}},
{15853, 'Lean Wolf Steak', 125, 12209, {{1015, 1}, {2678, 1}}, {'Vendor'}},
{3376, 'Curiously Tasty Omelet', 130, 3665, {{3685, 1}, {2692, 1}}, {'Quest', 'Vendor'}},
{24418, 'Heavy Crocolisk Stew', 150, 20074, {{3667, 2}, {3713, 1}}, {'Vendor'}},
{3399, 'Tasty Lion Steak', 150, 3728, {{3731, 2}, {3713, 1}}, {'Quest'}},
{4094, 'Barbecued Buzzard Wing', 175, 4457, {{3404, 1}, {2692, 1}}, {"Trainer"}},
{15863, 'Carrion Surprise', 175, 12213, {{12037, 1}, {2692, 1}}, {'Vendor'}},
{7213, 'Giant Clam Scorcho', 175, 6038, {{4655, 1}, {2692, 1}}, {'Vendor'}},
{13028, 'Goldthorn Tea', 175, 10841, {{3821, 1}, {159, 1}}, {"Trainer"}},
{15856, 'Hot Wolf Ribs', 175, 13851, {{12203, 1}, {2692, 1}}, {'Vendor'}},
{15861, 'Jungle Stew', 175, 12212, {{12202, 1}, {159, 1}, {4536, 2}}, {'Vendor'}},
{20916, 'Mithril Headed Trout', 175, 8364, {{8365, 1}}, {"Trainer"}},
{15865, 'Mystery Stew', 175, 12214, {{12037, 1}, {2596, 1}}, {'Vendor'}},
{15855, 'Roast Raptor', 175, 12210, {{12184, 1}, {2692, 1}}, {'Vendor'}},
{7828, 'Rockscale Cod', 175, 4594, {{6362, 1}}, {'Vendor'}},
{25954, 'Sagefish Delight', 175, 21217, {{21153, 1}, {2692, 1}}, {'Vendor'}},
{3400, 'Soothing Turtle Bisque', 175, 3729, {{3712, 1}, {3713, 1}}, {'Quest'}},
{15906, 'Dragonbreath Chili', 200, 12217, {{12037, 1}, {4402, 1}, {2692, 1}}, {'Vendor'}},
{15910, 'Heavy Kodo Stew', 200, 12215, {{12204, 2}, {3713, 1}, {159, 1}}, {'Vendor'}},
{21175, 'Spider Sausage', 200, 17222, {{12205, 2}}, {"Trainer"}},
{18239, 'Cooked Glossy Mightfish', 225, 13927, {{13754, 1}, {3713, 1}}, {'Vendor'}},
{18241, 'Filet of Redgill', 225, 13930, {{13758, 1}}, {'Vendor'}},
{15933, 'Monster Omelet', 225, 12218, {{12207, 1}, {3713, 2}}, {'Vendor'}},
{15915, 'Spiced Chili Crab', 225, 12216, {{12206, 1}, {2692, 2}}, {'Vendor'}},
{18238, 'Spotted Yellowtail', 225, 6887, {{4603, 1}}, {'Vendor'}},
{22480, 'Tender Wolf Steak', 225, 18045, {{12208, 1}, {3713, 1}}, {'Vendor'}},
{20626, 'Undermine Clam Chowder', 225, 16766, {{7974, 2}, {2692, 1}, {1179, 1}}, {'Vendor'}},
{18240, 'Grilled Squid', 240, 13928, {{13755, 1}, {3713, 1}}, {'Vendor'}},
{18242, 'Hot Smoked Bass', 240, 13929, {{13756, 1}, {2692, 2}}, {'Vendor'}},
{46684, 'Charred Bear Kabobs', 250, 35563, {{35562, 1}}, {'Vendor'}},
{46688, 'Juicy Bear Burger', 250, 35565, {{35562, 1}}, {'Vendor'}},
{18243, 'Nightfin Soup', 250, 13931, {{13759, 1}, {159, 1}}, {'Vendor'}},
{18244, 'Poached Sunscale Salmon', 250, 13932, {{13760, 1}}, {'Vendor'}},
{18247, 'Baked Salmon', 275, 13935, {{13889, 1}, {3713, 1}}, {'Vendor'}},
{18245, 'Lobster Stew', 275, 13933, {{13888, 1}, {159, 1}}, {'Vendor'}},
{18246, 'Mightfish Steak', 275, 13934, {{13893, 1}, {2692, 1}, {3713, 1}}, {'Vendor'}},
{22761, 'Runn Tum Tuber Surprise', 275, 18254, {{18255, 1}, {3713, 1}}, {'Drop'}},
{24801, 'Smoked Desert Dumplings', 285, 20452, {{20424, 1}, {3713, 1}}, {"Trainer"}},
{33290, 'Blackened Trout', 300, 27661, {{27422, 1}}, {'Vendor'}},
{43761, 'Broiled Bloodfin', 300, 33867, {{33823, 1}}, {'Drop'}},
{33279, 'Buzzard Bites', 300, 27651, {{27671, 1}}, {'Quest'}},
{36210, 'Clam Bar', 300, 30155, {{24477, 2}, {3713, 1}}, {'Vendor'}},
{25659, "Dirge's Kickin' Chimaerok Chops", 300, 21023, {{2692, 1}, {9061, 1}, {8150, 1}, {21024, 1}}, {'Quest'}},
{33291, 'Feltail Delight', 300, 27662, {{27425, 1}}, {'Vendor'}},
{43772, "Kibler's Bits", 300, 33874, {{27671, 1}}, {'Drop'}},
{33284, 'Ravager Dog', 300, 27655, {{27674, 1}}, {'Vendor'}},
{43758, 'Stormchops', 300, 33866, {{27678, 1}, {13757, 1}}, {'Drop'}},
{33292, 'Blackened Sporefish', 310, 27663, {{27429, 1}}, {'Vendor'}},
{33285, 'Sporeling Snack', 310, 27656, {{27676, 1}}, {'Vendor'}},
{33286, 'Blackened Basilisk', 315, 27657, {{27677, 1}}, {'Vendor'}},
{33293, 'Grilled Mudfish', 320, 27664, {{27435, 1}}, {'Vendor'}},
{33294, 'Poached Bluefish', 320, 27665, {{27437, 1}}, {'Vendor'}},
{33295, 'Golden Fish Sticks', 325, 27666, {{27438, 1}}, {'Vendor'}},
{45022, 'Hot Apple Cider', 325, 34411, {{34412, 1}, {17196, 1}, {17194, 1}}, {'Vendor'}},
{33287, 'Roasted Clefthoof', 325, 27658, {{27678, 1}}, {'Vendor'}},
{43707, 'Skullfish Soup', 325, 33825, {{33824, 1}}, {'Drop'}},
{43765, 'Spicy Hot Talbuk', 325, 33872, {{27682, 1}, {2692, 1}}, {'Drop'}},
{33289, 'Talbuk Steak', 325, 27660, {{27682, 1}}, {'Vendor'}},
{33288, 'Warp Burger', 325, 27659, {{27681, 1}}, {'Vendor'}},
{38868, 'Crunchy Serpent', 335, 31673, {{31671, 1}}, {'Quest', 'Vendor'}},
{38867, "Mok'Nathal Shortribs", 335, 31672, {{31670, 1}}, {'Quest', 'Vendor'}},
{42296, 'Stewed Trout', 335, 33048, {{27422, 1}, {2593, 1}, {3713, 1}}, {"Trainer"}},
{33296, 'Spicy Crawdad', 350, 27667, {{27439, 1}}, {'Vendor'}},
{42302, "Fisherman's Feast", 375, 33052, {{27515, 1}, {4539, 5}, {3713, 5}}, {"Trainer"}},
{42305, 'Hot Buttered Trout', 375, 33053, {{27516, 1}, {3713, 2}}, {"Trainer"}},
}

--[==[
for k,v in pairs(FullRecipe) do
  print(v[2])
end

for k,v in pairs(CookingArray) do
  print(v[2])
end
]==]--

function _CopyTable(original)
  local copy = {}
  for k, v in pairs(original) do
    if type(v) == "table" then
      v = _CopyTable(v) -- Recursive call for nested tables
    end
    copy[k] = v
  end
  return copy
end

function _GetKeyFromValue(_array, value, index)
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

local newArray = _CopyTable(FullRecipe)
local key = 0
for k,v in pairs(FullRecipe) do
  key = key+1
  for a,b in pairs(CookingArray) do
    if (v[1] == b[1]) then
      print("[" .. key .. "] " .. v[1] .. " == " .. b[1])
      --table.remove(newArray, key)
      --newArray[v[1]] = nil
      local _k = _GetKeyFromValue(newArray, v[1], 1)
      newArray[_k] = nil
    end
  end
end

--table.sort(newArray)
for k,v in pairs(newArray) do
  print(v[1] .. ": " .. v[2])
end
print(key)
