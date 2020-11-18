# Roblox Scripts

## Silent Aim
```lua
getgenv().CircleTransparency = 0.25
getgenv().CircleThickness = 1.5
getgenv().CircleVisible = true
getgenv().CircleColor = Color3.new(1,1,1)
getgenv().CircleFilled = true
getgenv().GlobalRadius = 100
getgenv().GlobalDistance = 500
getgenv().SelectedPart = "Head"

loadstring(game:HttpGet(("https://raw.githubusercontent.com/AlexR32/Roblox/main/BRM%205.lua"), true))()
```
## GuiLibrary
```lua
local GuiLibrary = loadstring(game:HttpGet((""), true))()
local Gui = GuiLibrary:CreateGui("GuiLibrary")
local AimbotCategory = Gui:CreateCategory("Aimbot")
AimbotCategory:CreateFunction("Toggle Aimbot")
```
