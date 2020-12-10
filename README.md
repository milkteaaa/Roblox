# Roblox

## Blackhawk Rescue Mission 5
```lua
--[[
getgenv().Config = {
   CircleVisible = false,
   CircleTransparency = 0.25,
   CircleColor = Color3.new(1,1,1),

   CircleThickness = 1.5,
   CircleNumSides = 20,
   CircleFilled = false,

   SilentAim = false,
   VisibiltyCheck = false,
   FOV = 100,
   Distance = 1000,
   TargetMode = "NPC",
   HitPart = "Head",
   FOVMode = "Cursor"
}
-- Toggles won't show up as enabled if you toggle them in config
-- Also this config may be outdated please check github for new loadstring
-- github.com/AlexR32/Roblox
]]
loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BlackhawkRescueMission5.lua"))()
```
## CoastingUI V2
```lua
local CoreGui = game:GetService("CoreGui")
local Config = {
	Theme = {
		BackgroundColor = Color3.fromRGB(35,35,35),
		MainColor = Color3.fromRGB(255,75,75),
		TextFont = Enum.Font.SourceSansBold,
		EasingStyle = Enum.EasingStyle.Quart
	},
	CheatName = nil,
	Discord = nil,
	UIKeybind = Enum.KeyCode.RightShift
}
local CoastingCore = loadstring(game:HttpGet(("https://raw.githubusercontent.com/AlexR32/Roblox/main/CoastingUIV2.lua"), true))()
local Coasting = CoastingCore:Init(Config, CoreGui)

local Main = Coasting:CreateTab("Main")
local Credits = Coasting:CreateTab("Credits")
local MainSec = Main:CreateSection("Main")
local OtherSec = Main:CreateSection("Other")
local Other2Sec = Main:CreateSection("Other 2")
local CoastingUISec = Credits:CreateSection("CoastingUI Devs")
local OtherDevsSec = Credits:CreateSection("Other Devs")

MainSec:CreateButton("Really cool button", function()
    print("OH YEAH")
end)

MainSec:CreateToggle("Really cool Toggle", function(Boolean)
    print("OH YEAH " .. tostring(Boolean))
end)

OtherSec:CreateSlider("Really cool Slider", 0, 100, 50, false, function(Number)
    print("OH YEAH " .. tostring(Number))
end)

Other2Sec:CreateLabel("Very nice label", "Did you expect that?")

CoastingUISec:CreateLabel("Main Dev", "coasts @v3rmillion.net coasts#7386 @discord.com")
CoastingUISec:CreateLabel("V2 Dev", "Alex332Rus @v3rmillion.net AlexR32#3232 @discord.com")
OtherDevsSec:CreateLabel("Other Dev", "NAME @v3rmillion.net NAME#0000 @discord.com")
```
