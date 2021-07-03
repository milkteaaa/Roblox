local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local PlayerService = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = PlayerService.LocalPlayer
local Camera = Workspace.CurrentCamera

local PlayerFolder = Workspace.Characters

if not getgenv().Config then
getgenv().Config = {

    -- fov circle
    CircleVisible = true,
    CircleTransparency = 1,
    CircleColor = Color3.fromRGB(255,128,255),
    CircleThickness = 1,
    CircleNumSides = 30,
    CircleFilled = false,

    -- box, player names and health bar (not really useful for this game)
    OutlineVisible = true,
    TextVisible = true,
    HealthbarVisible = false,
    BoxVisible = true,

    Transparency = 1, -- idk useless i think
    Color = Color3.fromRGB(255,128,255), -- disable rainbow before using
    Rainbow = false, -- rainbow boxes yay

    -- Aimbot
    Aimbot = true,
    Sensitivity = 0.5,
    -- SilentAim
    SilentAim = false,
    --Things related to aim and silent aim
    TeamCheck = false,
    FieldOfView = 100,
    Distance = 1000, -- related to esp too
    PrimaryPart = "Head"
}
end

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

local function CreateESP(Model, Info, ShowDistance)
    local Text = Drawing.new("Text")
    local HealthbarOutline = Drawing.new("Square")
    local Healthbar = Drawing.new("Square")
    local BoxOutline = Drawing.new("Square")
    local Box = Drawing.new("Square")
    
    local Render = RunService.RenderStepped:Connect(function()
        if Model and Model:FindFirstChild(Config.PrimaryPart) then
            Camera = Workspace.CurrentCamera
            if (Camera.CFrame.Position - Model[Config.PrimaryPart].Position).Magnitude <= Config.Distance then
                local Vector, OnScreen = Camera:WorldToViewportPoint(Model[Config.PrimaryPart].Position)
                if OnScreen then
                    local xSize,ySize,xMin,yMin,xMax,yMax = GetCorners(Model)

                    Box.Visible = Config.BoxVisible
                    Box.Transparency = Config.Transparency
                    Box.Color = Config.Color
                    Box.Thickness = 2
                    Box.Filled = false

                    Box.Size = Vector2.new(xSize, ySize)
                    Box.Position = Vector2.new(xMin, yMin)

                    BoxOutline.Visible = Config.OutlineVisible
                    BoxOutline.Transparency = Config.Transparency
                    BoxOutline.Color = Color3.fromRGB(0,0,0)
                    BoxOutline.Thickness = 4
                    BoxOutline.Filled = false

                    BoxOutline.Size = Vector2.new(xSize,ySize)
                    BoxOutline.Position = Vector2.new(xMin,yMin)

                    Text.Visible = Config.TextVisible
                    Text.Transparency = Config.Transparency
                    Text.Color = Color3.fromRGB(255,255,255)
                    Text.Text = tostring(Info) .. "\n" .. math.round((Camera.CFrame.Position - Model[Config.PrimaryPart].Position).Magnitude) .. " studs"
                    Text.Size = 20
                    Text.Center = true
                    Text.Outline = Config.OutlineVisible
                    Text.OutlineColor = Color3.fromRGB(0,0,0)
                    Text.Position = Vector2.new(xMax - xSize/2, yMax)

                    if Model:FindFirstChildOfClass("Humanoid") then
                        Healthbar.Visible = Config.HealthbarVisible
                        Healthbar.Transparency = Config.Transparency
                        Healthbar.Color = Color3.fromRGB(255,0,0):Lerp(Color3.fromRGB(0,255,0),Model.Humanoid.Health/Model.Humanoid.MaxHealth)
                        Healthbar.Thickness = 1
                        Healthbar.Filled = true

                        Healthbar.Size = Vector2.new(2,0):Lerp(Vector2.new(2,-ySize),Model.Humanoid.Health/Model.Humanoid.MaxHealth)
                        Healthbar.Position = Vector2.new(xMin-7,yMax)

                        HealthbarOutline.Visible = Config.HealthbarVisible and Config.OutlineVisible
                        HealthbarOutline.Transparency = Config.Transparency
                        HealthbarOutline.Color = Color3.fromRGB(0,0,0)
                        HealthbarOutline.Thickness = 1
                        HealthbarOutline.Filled = true

                        HealthbarOutline.Size = Vector2.new(4,-ySize-2)
                        HealthbarOutline.Position = Vector2.new(xMin-8,yMax+1)
                    else
                        Healthbar.Visible = false
                        HealthbarOutline.Visible = false
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
            warn("BoxESP: PrimaryPart.Parent ~= Model")
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
                local Vector, OnScreen = Camera:WorldToViewportPoint(Player.Character:FindFirstChild(Config.PrimaryPart).Position)
                if OnScreen then
                    local CameraPosition = Camera.CFrame.Position
                    if Workspace:FindPartOnRayWithIgnoreList(Ray.new(CameraPosition, (Player.Character:FindFirstChild(Config.PrimaryPart).Position - CameraPosition).Unit * Config.Distance), {Player}) then
                        local DistanceMagnitude = (LocalPlayer.Character:FindFirstChild(Config.PrimaryPart).Position - Player.Character:FindFirstChild(Config.PrimaryPart).Position).Magnitude
                        local VectorMagnitude = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(Vector.X, Vector.Y)).Magnitude
                        if VectorMagnitude < ClosestTarget and VectorMagnitude <= Config.FieldOfView and DistanceMagnitude <= Config.Distance then
                            Target = Player.Character:FindFirstChild(Config.PrimaryPart)
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
    CameraPosition = Camera.CFrame.Position
    local script = getcallingscript()
    if tostring(script) == "GarbageCode" then
        if table.find(args[3], LocalPlayer.Character, 1) and not table.find(args[3], Workspace.WaterCollision, 2) and not table.find(args[3], Workspace.Characters, 3) then
            --args[2] = Ray.new(CameraPosition, (hit.Position + Vector3.new(0, (CameraPosition - hit.Position).Magnitude / Config.Distance, 0) - CameraPosition).Unit * (Config.Distance * 10)) -- bad code
            args[2] = Ray.new(args[2].Origin, (hit.Position + Vector3.new(0, (CameraPosition - hit.Position).Magnitude / Config.Distance, 0) - CameraPosition).Unit * (Config.Distance * 10))
            return
        end
    end
end

local rawmetatable = getrawmetatable(game)
local old

setreadonly(rawmetatable, false)
old = hookfunction(rawmetatable.__namecall, function(...)
    local namecallmethod = getnamecallmethod()
    local args = {...}
    if namecallmethod == "FindPartOnRayWithIgnoreList" then
        returnHit(hit, args)
    end
    return old(unpack(args))
end)
setreadonly(rawmetatable, true)

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
