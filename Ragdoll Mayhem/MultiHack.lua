local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local PlayerService = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = PlayerService.LocalPlayer
local Camera = Workspace.CurrentCamera

local PlayerFolder = Workspace.LiveRagdolls

if not getgenv().Config then
getgenv().Config = {

    -- fov circle
    CircleVisible = true,
    CircleTransparency = 1,
    CircleColor = Color3.fromRGB(255,128,255),
    CircleThickness = 1,
    CircleNumSides = 30,
    CircleFilled = false,
    CircleRainbow = false,

    -- box, player names and health bar (not really useful for this game)
    OutlineVisible = true,
    TextVisible = true,
    HealthbarVisible = false,
    BoxVisible = true,

    Color = Color3.fromRGB(255,128,255), -- disable rainbow before using
    Rainbow = false, -- rainbow boxes yay

    -- Aimbot and Silent Aim related things
    Aimbot = false,
    Sensitivity = 0.5,
    SilentAim = true,
    TeamCheck = false,
    FieldOfView = 100,
    Distance = 1000, -- this related to esp too
    AimPart = "Head",

    -- dont touch
    ESPPlayerPart = "Torso",
    ESPModelPart = "Torso"
}
end

local UIConfig = {
    WindowName = "RAGDOLL UNIVERSE",
    Color = Color3.fromRGB(255,128,64),
    Keybind = Enum.KeyCode.RightShift
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/AlexR32/Roblox/main/BracketV3.lua"))()
local Window = Library:CreateWindow(UIConfig, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("Aimbot")
local Section2 = Tab1:CreateSection("FOV Circle")
local Section3 = Tab1:CreateSection("ESP")
local Section4 = Tab2:CreateSection("Menu")
local Section5 = Tab2:CreateSection("Background")

local SilentAimToggle = Section1:CreateToggle("Silent Aim", nil, function(State)
    Config.SilentAim = State
end)
SilentAimToggle:SetState(Config.SilentAim)

local AimbotToggle = Section1:CreateToggle("Aimbot", nil, function(State)
    Config.Aimbot = State
end)
AimbotToggle:SetState(Config.Aimbot)

local TeamCheckToggle = Section1:CreateToggle("Team Check", nil, function(State)
    Config.TeamCheck = State
end)
TeamCheckToggle:SetState(Config.TeamCheck)

local SensitivitySlider = Section1:CreateSlider("Aimbot Sensitivity", 0,1,nil,false, function(Value)
    Config.Sensitivity = Value
end)
SensitivitySlider:SetValue(Config.Sensitivity)

local FOVSlider = Section1:CreateSlider("Field Of View", 0,500,nil,true, function(Value)
    Config.FieldOfView = Value
end)
FOVSlider:SetValue(Config.FieldOfView)

local DistanceSlider = Section1:CreateSlider("Distance", 0,5000,nil,true, function(Value)
    Config.Distance = Value
end)
DistanceSlider:SetValue(Config.Distance)

local AimPartDropdown = Section1:CreateDropdown("Aim Part")
local HeadOption = AimPartDropdown:AddOption("Head", function(String)
    Config.AimPart = String
end)
local TorsoOption = AimPartDropdown:AddOption("Torso", function(String)
    Config.AimPart = String
end)

if Config.AimPart == "Head" then
    HeadOption:SetOption()
elseif Config.AimPart == "Torso" then
    TorsoOption:SetOption()
end


local CircleToggle = Section2:CreateToggle("Circle Visible", nil, function(State)
    Config.CircleVisible = State
end)
CircleToggle:SetState(Config.CircleVisible)

local CircleTranspSlider = Section2:CreateSlider("Circle Transparency", 0,1,nil,false, function(Value)
    Config.CircleTransparency = Value
end)
CircleTranspSlider:SetValue(Config.CircleTransparency)

local CircleColorpicker = Section2:CreateColorpicker("Circle Color", function(Color)
    Config.CircleColor = Color
end)
CircleColorpicker:UpdateColor(Config.CircleColor)

local CircleThicknessSlider = Section2:CreateSlider("Circle Thickness", 1,5,nil,true, function(Value)
    Config.CircleThickness = Value
end)
CircleThicknessSlider:SetValue(Config.CircleThickness)

local CircleSidesSlider = Section2:CreateSlider("Circle NumSides", 0,100,nil,true, function(Value)
    Config.CircleNumSides = Value
end)
CircleSidesSlider:SetValue(Config.CircleNumSides)

local CircleFilledToggle = Section2:CreateToggle("Circle Filled", nil, function(State)
    Config.CircleFilled = State
end)
CircleFilledToggle:SetState(Config.CircleFilled)

local CircleRainbowToggle = Section2:CreateToggle("Circle Rainbow", nil, function(State)
    Config.CircleRainbow = State
end)
CircleRainbowToggle:SetState(Config.CircleRainbow)


local ESPOutlineToggle = Section3:CreateToggle("ESP Outline", nil, function(State)
    Config.OutlineVisible = State
end)
ESPOutlineToggle:SetState(Config.OutlineVisible)

local ESPTextToggle = Section3:CreateToggle("Text Visible", nil, function(State)
    Config.TextVisible = State
end)
ESPTextToggle:SetState(Config.TextVisible)

local ESPHealthToggle = Section3:CreateToggle("Healthbar Visible", nil, function(State)
    Config.HealthbarVisible = State
end)
ESPHealthToggle:SetState(Config.HealthbarVisible)

local ESPBoxToggle = Section3:CreateToggle("Box Visible", nil, function(State)
    Config.BoxVisible = State
end)
ESPBoxToggle:SetState(Config.BoxVisible)

local ESPColorpicker = Section3:CreateColorpicker("ESP Color", function(Color)
    Config.Color = Color
end)
ESPColorpicker:UpdateColor(Config.Color)

local ESPRainbowToggle = Section3:CreateToggle("ESP Rainbow", nil, function(State)
    Config.Rainbow = State
end)
ESPRainbowToggle:SetState(Config.Rainbow)



local Toggle3 = Section4:CreateToggle("UI Toggle", nil, function(State)
	Window:Toggle(State)
end)
Toggle3:CreateKeybind(tostring(UIConfig.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
	UIConfig.Keybind = Enum.KeyCode[Key]
end)
Toggle3:SetState(true)

local Colorpicker3 = Section4:CreateColorpicker("UI Color", function(Color)
	Window:ChangeColor(Color)
end)
Colorpicker3:UpdateColor(UIConfig.Color)

-- credits to jan for patterns
local Dropdown3 = Section5:CreateDropdown("Image")
local Option7 = Dropdown3:AddOption("Default", function(String)
	Window:SetBackground("2151741365")
end)
local Option8 = Dropdown3:AddOption("Hearts", function(String)
	Window:SetBackground("6073763717")
end)
local Option9 = Dropdown3:AddOption("Abstract", function(String)
	Window:SetBackground("6073743871")
end)
local Option10 = Dropdown3:AddOption("Hexagon", function(String)
	Window:SetBackground("6073628839")
end)
local Option11 = Dropdown3:AddOption("Circles", function(String)
	Window:SetBackground("6071579801")
end)
local Option12 = Dropdown3:AddOption("Lace With Flowers", function(String)
	Window:SetBackground("6071575925")
end)
local Option13 = Dropdown3:AddOption("Floral", function(String)
	Window:SetBackground("5553946656")
end)
Option7:SetOption()

local Colorpicker4 = Section5:CreateColorpicker("Color", function(Color)
	Window:SetBackgroundColor(Color)
end)
Colorpicker4:UpdateColor(Color3.new(1,1,1))

local Slider3 = Section5:CreateSlider("Transparency",0,1,nil,false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider3:SetValue(0)

local Slider4 = Section5:CreateSlider("Tile Scale",0,1,nil,false, function(Value)
	Window:SetTileScale(Value)
end)
Slider4:SetValue(0.5)

local function GetCorners(Model)
    local CFrame, Size = Model:GetBoundingBox()
    local CornerTable = {
        Vector3.new(CFrame.X + Size.X / 2, CFrame.Y + Size.Y / 2, CFrame.Z), -- TopRight
        Vector3.new(CFrame.X - Size.X / 2, CFrame.Y + Size.Y / 2, CFrame.Z), -- TopLeft

        Vector3.new(CFrame.X - Size.X / 2, CFrame.Y - Size.Y / 2, CFrame.Z), -- BottomLeft
        Vector3.new(CFrame.X + Size.X / 2, CFrame.Y - Size.Y / 2, CFrame.Z), -- BottomRight
    }

    local xMin = Camera.ViewportSize.X
    local yMin = Camera.ViewportSize.Y
    local xMax = 0
    local yMax = 0
                            
    for _, Corner in next, CornerTable do
        local Position = Camera:WorldToViewportPoint(Corner)

        if Position.X > xMax then
            xMax = Position.X
        end

        if Position.X < xMin then
            xMin = Position.X
        end

        if Position.Y > yMax then
            yMax = Position.Y
        end

        if Position.Y < yMin then
            yMin = Position.Y
        end
    end

    return xMax - xMin,yMax - yMin,xMin,yMin,xMax,yMax
end

local function CreateESP(Model, Info)
    local Text = Drawing.new("Text")
    local HealthbarOutline = Drawing.new("Square")
    local Healthbar = Drawing.new("Square")
    local BoxOutline = Drawing.new("Square")
    local Box = Drawing.new("Square")

    local Render = RunService.RenderStepped:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild(Config.ESPPlayerPart) then
            if Model and Model:FindFirstChild(Config.ESPModelPart) then
                if Model:FindFirstChildOfClass("Humanoid") and Model:FindFirstChildOfClass("Humanoid").Health ~= 0 then
                    Camera = Workspace.CurrentCamera
                    local Vector, OnScreen = Camera:WorldToViewportPoint(Model[Config.ESPModelPart].Position)
                    if OnScreen then
                        local xSize,ySize,xMin,yMin,xMax,yMax = GetCorners(Model)

                        Text.Visible = Config.TextVisible
                        Text.Transparency = 1
                        Text.Color = Color3.fromRGB(255,255,255)
                        Text.Text = tostring(Info) .. "\n" .. math.round((LocalPlayer.Character[Config.ESPPlayerPart].Position - Model[Config.ESPModelPart].Position).Magnitude) .. " studs"
                        Text.Size = 20
                        Text.Center = true
                        Text.Outline = Config.OutlineVisible
                        Text.OutlineColor = Color3.fromRGB(0,0,0)
                        Text.Position = Vector2.new(xMax - xSize/2, yMax)

                        HealthbarOutline.Visible = Config.HealthbarVisible and Config.OutlineVisible
                        HealthbarOutline.Transparency = 1
                        HealthbarOutline.Color = Color3.fromRGB(0,0,0)
                        HealthbarOutline.Thickness = 1
                        HealthbarOutline.Filled = true

                        HealthbarOutline.Size = Vector2.new(4,-ySize-2)
                        HealthbarOutline.Position = Vector2.new(xMin-8,yMax+1)

                        Healthbar.Visible = Config.HealthbarVisible
                        Healthbar.Transparency = 1
                        Healthbar.Color = Color3.fromRGB(255,0,0):Lerp(Color3.fromRGB(0,255,0), Model.Humanoid.Health/Model.Humanoid.MaxHealth)
                        Healthbar.Thickness = 1
                        Healthbar.Filled = true

                        Healthbar.Size = Vector2.new(2,0):Lerp(Vector2.new(2,-ySize),Model.Humanoid.Health/Model.Humanoid.MaxHealth)
                        Healthbar.Position = Vector2.new(xMin-7,yMax)

                        BoxOutline.Visible = Config.BoxVisible and Config.OutlineVisible
                        BoxOutline.Transparency = 1
                        BoxOutline.Color = Color3.fromRGB(0,0,0)
                        BoxOutline.Thickness = 4
                        BoxOutline.Filled = false

                        BoxOutline.Size = Vector2.new(xSize,ySize)
                        BoxOutline.Position = Vector2.new(xMin,yMin)

                        Box.Visible = Config.BoxVisible
                        Box.Transparency = 1
                        Box.Color = Config.Color
                        Box.Thickness = 2
                        Box.Filled = false

                        Box.Size = Vector2.new(xSize, ySize)
                        Box.Position = Vector2.new(xMin, yMin)
                    else
                        Text.Visible = false
                        HealthbarOutline.Visible = false
                        Healthbar.Visible = false
                        BoxOutline.Visible = false
                        Box.Visible = false
                    end
                else
                    Text.Visible = false
                    HealthbarOutline.Visible = false
                    Healthbar.Visible = false
                    BoxOutline.Visible = false
                    Box.Visible = false
                end
            else
                Text.Visible = false
                HealthbarOutline.Visible = false
                Healthbar.Visible = false
                BoxOutline.Visible = false
                Box.Visible = false
            end
        else
            warn("BoxESP: ModelPart.Parent ~= Model")
            Text.Visible = false
            HealthbarOutline.Visible = false
            Healthbar.Visible = false
            BoxOutline.Visible = false
            Box.Visible = false
        end
    end)

    Model.AncestryChanged:Connect(function(Child, Parent)
        if not Parent then
            Render:Disconnect()
            Text:Remove()
            HealthbarOutline:Remove()
            Healthbar:Remove()
            BoxOutline:Remove()
            Box:Remove()
        end
    end)
end

local function TeamCheck(Target)
    if Config.TeamCheck then
        if LocalPlayer.Team ~= Target.Team then
            return true
        else
            return false
        end
    end
    return true
end

local function GetTarget()
    local ClosestTarget = math.huge
    local Target = nil
    for _, Player in pairs(PlayerService:GetPlayers()) do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChildOfClass("Humanoid") then
            if TeamCheck(Player) and Player.Character:FindFirstChildOfClass("Humanoid").Health ~= 0 then
                Camera = Workspace.CurrentCamera
                local Vector, OnScreen = Camera:WorldToViewportPoint(Player.Character:FindFirstChild(Config.AimPart).Position)
                if OnScreen then
                    local CameraPosition = Camera.CFrame.Position
                    if Workspace:FindPartOnRayWithIgnoreList(Ray.new(CameraPosition, (Player.Character:FindFirstChild(Config.AimPart).Position - CameraPosition).Unit * Config.Distance), {Player}) then
                        local DistanceMagnitude = (LocalPlayer.Character:FindFirstChild(Config.AimPart).Position - Player.Character:FindFirstChild(Config.AimPart).Position).Magnitude
                        local VectorMagnitude = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(Vector.X, Vector.Y)).Magnitude
                        if VectorMagnitude < ClosestTarget and VectorMagnitude <= Config.FieldOfView and DistanceMagnitude <= Config.Distance then
                            Target = Player.Character:FindFirstChild(Config.AimPart)
                            ClosestTarget = VectorMagnitude
                        end
                    end
                end
            end
        end
    end
    return Target
end

local function returnHit(hit, args)
    Camera = Workspace.CurrentCamera
    CameraPosition = Camera.CFrame.Position
    if table.find(args[2], LocalPlayer.Character, 1) and not table.find(args[2], Workspace.WaterLayer, 2) and not table.find(args[2], Workspace.LiveRagdolls, 3) then
        --table.foreach(args[2], print)
        args[1] = Ray.new(args[1].Origin, (hit.Position + Vector3.new(0, (CameraPosition - hit.Position).Magnitude / Config.Distance, 0) - CameraPosition).Unit * (Config.Distance * 10))
        return
    end
end

namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local namecallmethod = getnamecallmethod()
    local args = {...}
    if namecallmethod == "FindPartOnRayWithIgnoreList" then
        if hit then
            returnHit(hit, args)
        end
    end
    return namecall(self, unpack(args))
end)

RunService.RenderStepped:Connect(function()
    if Config.Aimbot then
        if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
            local Target = GetTarget()
            if Target then
                local Mouse = UserInputService:GetMouseLocation()
                local TargetPos = Camera:WorldToViewportPoint(Target.Position)
                mousemoverel((TargetPos.X - Mouse.X) * Config.Sensitivity, (TargetPos.Y - Mouse.Y) * Config.Sensitivity)
            end
        end
    end

    if Config.SilentAim then
        hit = GetTarget()
    else
        hit = nil
    end
end)

local Circle = Drawing.new("Circle")
RunService.Heartbeat:Connect(function()
    if Circle then
        Circle.Visible = Config.CircleVisible
        Circle.Transparency = Config.CircleTransparency
        Circle.Color = Config.CircleColor

        Circle.Thickness = Config.CircleThickness
        Circle.NumSides = Config.CircleNumSides
        Circle.Radius = Config.FieldOfView
        Circle.Filled = Config.CircleFilled
        Circle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    end
end)

RunService.RenderStepped:Connect(function()
    if Config.Rainbow then
        local Hue, Saturation, Value = Config.Color:ToHSV()
        if Hue == 1 then
            Hue = 0
        end
        Config.Color = Color3.fromHSV(Hue + 0.001, 1, 1)
    end
    if Config.CircleRainbow then
        local Hue, Saturation, Value = Config.CircleColor:ToHSV()
        if Hue == 1 then
            Hue = 0
        end
        Config.CircleColor = Color3.fromHSV(Hue + 0.001, 1, 1)
    end
end)

for _, Player in pairs(PlayerFolder:GetChildren()) do
    if Player.Name ~= LocalPlayer.Name then
        if Player:WaitForChild("Humanoid", 5) then
            if Player.Humanoid.Health ~= 0 then
                CreateESP(Player, Player.Name)
            end
        end
    end
end

PlayerFolder.ChildAdded:Connect(function(Player)
    if Player.Name ~= LocalPlayer.Name then
        if Player:WaitForChild("Humanoid", 5) then
            if Player.Humanoid.Health ~= 0 then
                CreateESP(Player, Player.Name)
            end
        end
    end
end)
