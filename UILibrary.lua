local UserInput = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UILibrary = {}

function Tween(O,T,S)
    TweenService:Create(O,TweenInfo.new(T),S):Play()
end

local UIScreen = Instance.new("ScreenGui")
local UIMain = Instance.new("TextLabel")
local CategoryFolder = Instance.new("Frame")
local CategoryLayout = Instance.new("UIListLayout")

local ToggleUI = true

UIScreen.Name = HttpService:GenerateGUID(false)
UIScreen.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

UIMain.Name = "UIMain"
UIMain.Parent = UIScreen
UIMain.BackgroundColor3 = Color3.fromRGB(0,0,0)
UIMain.BackgroundTransparency = 0.5
UIMain.BorderColor3 = Color3.fromRGB(0,0,0)
UIMain.BorderSizePixel = 0
UIMain.Position = UDim2.new(0,20,0,20)
UIMain.Size = UDim2.new(0,200,0,15)
UIMain.Font = Enum.Font.Code
UIMain.Text = "UILibrary"
UIMain.TextColor3 = Color3.fromRGB(255, 0, 255)
UIMain.TextSize = 15
UIMain.TextStrokeTransparency = 0.75

CategoryFolder.Name = "CategoryFolder"
CategoryFolder.Parent = UIMain
CategoryFolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
CategoryFolder.BackgroundTransparency = 1
CategoryFolder.BorderColor3 = Color3.fromRGB(0,0,0)
CategoryFolder.BorderSizePixel = 0
CategoryFolder.Position = UDim2.new(0,0,1,0)
CategoryFolder.Size = UDim2.new(1,0,0,0)

CategoryLayout.Name = "CategoryLayout"
CategoryLayout.Parent = CategoryFolder
CategoryLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
CategoryLayout.SortOrder = Enum.SortOrder.LayoutOrder

UserInput.InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.RightShift then
        if ToggleUI then
            Tween(UIMain, 1, {
                Position = UIMain.Position - UDim2.new(0,220,0,0)
            })
            ToggleUI = false
        else
            Tween(UIMain, 1, {
                Position = UDim2.new(0,20,0,20)
            })
            ToggleUI = true
        end
    end
end)

function UILibrary:ChangeName(Name)
	UIMain.Text = Name
end

function UILibrary:CreateCategory(Name)
    local Category = Instance.new("Frame")
	local CategoryName = Instance.new("TextLabel")
    local FunctionFolder = Instance.new("Frame")
    local FunctionLayout = Instance.new("UIListLayout")

    local FunctionTable = {}

	Category.Name = Name
	Category.Parent = CategoryFolder
	Category.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Category.BackgroundTransparency = 0.5
	Category.BorderColor3 = Color3.fromRGB(0,0,0)
	Category.BorderSizePixel = 0
	Category.Size = UDim2.new(1,0,0,20)

    CategoryName.Name = "CategoryName"
	CategoryName.Parent = Category
	CategoryName.AnchorPoint = Vector2.new(1,0)
	CategoryName.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CategoryName.BackgroundTransparency = 1
	CategoryName.BorderColor3 = Color3.fromRGB(0,0,0)
	CategoryName.BorderSizePixel = 0
	CategoryName.Position = UDim2.new(1,0,0,0)
	CategoryName.Size = UDim2.new(1,-5,0,15)
	CategoryName.Font = Enum.Font.Code
	CategoryName.Text = Name
	CategoryName.TextColor3 = Color3.fromRGB(0,255,255)
	CategoryName.TextSize = 15
	CategoryName.TextStrokeTransparency = 0.75
	CategoryName.TextXAlignment = Enum.TextXAlignment.Left

    FunctionFolder.Name = "FunctionFolder"
    FunctionFolder.Parent = Category
    FunctionFolder.AnchorPoint = Vector2.new(1,0)
    FunctionFolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
    FunctionFolder.BackgroundTransparency = 1
    FunctionFolder.BorderColor3 = Color3.fromRGB(0,0,0)
    FunctionFolder.BorderSizePixel = 0
    FunctionFolder.Position = UDim2.new(1,0,0,15)
    FunctionFolder.Size = UDim2.new(1,-10,0,0)

    FunctionLayout.Name = "FunctionLayout"
    FunctionLayout.Parent = FunctionFolder
    FunctionLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
    FunctionLayout.SortOrder = Enum.SortOrder.LayoutOrder

	function FunctionTable:CreateLabel(Text)
        local Label = Instance.new("TextLabel")

        Label.Name = Text .. "Label"
		Label.Parent = FunctionFolder
		Label.BackgroundColor3 = Color3.fromRGB(0,0,0)
		Label.BackgroundTransparency = 1
		Label.BorderColor3 = Color3.fromRGB(0,0,0)
		Label.BorderSizePixel = 0
		Label.Size = UDim2.new(1,0,0,15)
		Label.Font = Enum.Font.Code
		Label.Text = Text
		Label.TextColor3 = Color3.fromRGB(255,255,255)
		Label.TextSize = 15
		Label.TextStrokeTransparency = 0.75
		Label.TextXAlignment = Enum.TextXAlignment.Left
        Category.Size = Category.Size + UDim2.new(0,0,0,15)
    end

function FunctionTable:CreateButton(Name, Callback)
        local Button = Instance.new("TextButton")
        local ToggleIndication = Instance.new("TextLabel")

        Button.Name = Name .. " Toggle"
        Button.Parent = FunctionFolder
        Button.BackgroundColor3 = Color3.fromRGB(0,0,0)
        Button.BackgroundTransparency = 1
        Button.BorderColor3 = Color3.fromRGB(0,0,0)
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(1,0,0,15)
        Button.AutoButtonColor = false
        Button.Font = Enum.Font.Code
        Button.Text = Name
        Button.TextColor3 = Color3.fromRGB(255,255,255)
        Button.TextSize = 15
        Button.TextStrokeTransparency = 0.75
        Button.TextXAlignment = Enum.TextXAlignment.Left
		Category.Size = Category.Size + UDim2.new(0,0,0,15)

		Button.MouseButton1Down:Connect(function()
			Button.TextColor3 = Color3.fromRGB(200,200,200)
			Callback(Button)
		end)

		Button.MouseButton1Up:Connect(function()
			Button.TextColor3 = Color3.fromRGB(255,255,255)
		end)
    end

    function FunctionTable:CreateToggle(Name, Callback)
        local Toggle = Instance.new("TextButton")
        local ToggleIndication = Instance.new("TextLabel")

        Toggle.Name = Name .. " Toggle"
        Toggle.Parent = FunctionFolder
        Toggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
        Toggle.BackgroundTransparency = 1
        Toggle.BorderColor3 = Color3.fromRGB(0,0,0)
        Toggle.BorderSizePixel = 0
        Toggle.Size = UDim2.new(1,0,0,15)
        Toggle.AutoButtonColor = false
        Toggle.Font = Enum.Font.Code
        Toggle.Text = Name
        Toggle.TextColor3 = Color3.fromRGB(255,255,255)
        Toggle.TextSize = 15
        Toggle.TextStrokeTransparency = 0.75
        Toggle.TextXAlignment = Enum.TextXAlignment.Left

        ToggleIndication.Name = "Indication"
        ToggleIndication.Parent = Toggle
        ToggleIndication.AnchorPoint = Vector2.new(1,0)
        ToggleIndication.BackgroundColor3 = Color3.fromRGB(0,0,0)
        ToggleIndication.BackgroundTransparency = 1
        ToggleIndication.BorderColor3 = Color3.fromRGB(0,0,0)
        ToggleIndication.BorderSizePixel = 0
        ToggleIndication.Position = UDim2.new(1,-10,0,0)
        ToggleIndication.Size = UDim2.new(0,40,1,0)
        ToggleIndication.Font = Enum.Font.Code
        ToggleIndication.Text = "false"
        ToggleIndication.TextColor3 = Color3.fromRGB(255,0,0)
        ToggleIndication.TextSize = 15
        ToggleIndication.TextStrokeTransparency = 0.75
		Category.Size = Category.Size + UDim2.new(0,0,0,15)

		local function SetState(State)
			if State then
				ToggleIndication.Text = "true"
				ToggleIndication.TextColor3 = Color3.fromRGB(0,255,0)
			else
				ToggleIndication.Text = "false"
				ToggleIndication.TextColor3 = Color3.fromRGB(255,0,0)
			end
			Callback(Toggled)
		end
		Toggle.MouseButton1Down:Connect(function()
			Toggled = not Toggled
			SetState(Toggled)
		end)
		return {
			SetState = SetState
		}
    end
    return FunctionTable
end

return UILibrary
