local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local UserInput = game:GetService("UserInputService")

local Library = {
	LibraryColorTable = {},
    TabCount = 0,
    FirstTab = nil,
    CurrentlyBinding = false,
    RainbowColorValue = 0,
    HueSelectionPosition = 0
}

local function AddCorner(Parent, Radius)
	local UICorner = Instance.new("UICorner")
	UICorner.CornerRadius = Radius
	UICorner.Parent = Parent
end

local function AddListLayout(Parent, FillDirection, SortOrder)
	local UIListLayout = Instance.new("UIListLayout")
	UIListLayout.Parent = Parent
	UIListLayout.FillDirection = FillDirection
	UIListLayout.SortOrder = SortOrder
end

local function AddGridLayout(Parent, SortOrder, CellPadding, CellSize)
	local UIGridLayout = Instance.new("UIGridLayout")
	UIGridLayout.Parent = Parent
	UIGridLayout.SortOrder = SortOrder
	UIGridLayout.CellPadding = CellPadding
	UIGridLayout.CellSize = CellSize
end

local function AddPadding(Parent, PaddingLeft, PaddingTop)
	local UIPadding = Instance.new("UIPadding")
	UIPadding.Parent = Parent
	UIPadding.PaddingLeft = PaddingLeft
	UIPadding.PaddingTop = PaddingTop
end

local function DarkenObjectColor(Object, Amount)
    local ColorR = (Object.r * 255) - Amount
    local ColorG = (Object.g * 255) - Amount
    local ColorB = (Object.b * 255) - Amount
   
    return Color3.fromRGB(ColorR, ColorG, ColorB)
end
--[[
local function SetUIAccent(Color)
    for _,Element in pairs(Library.LibraryColorTable) do
        if HasProperty(Element, "BackgroundColor3") then
            if Element ~= "CheckboxOutline" and Element.ImageColor3 ~= Color3.fromRGB(65, 65, 65) then
                Element.ImageColor3 = Color
            end
        end

        if HasProperty(Element, "TextColor3") then
            if Element.TextColor3 ~= Color3.fromRGB(255, 255, 255) then
                Element.TextColor3 = Color
            end
        end
    end
end
]]
local function MakeDraggable(TopbarObject, Object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil
    
    local function Update(Input)
        local Delta = Input.Position - DragStart
        Object.Position = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
    end
    
    TopbarObject.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = Input.Position
            StartPosition = Object.Position
            
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)
    
    TopbarObject.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            DragInput = Input
        end
    end)
    
    UserInput.InputChanged:Connect(function(Input)
        if Input == DragInput and Dragging then
            Update(Input)
        end
    end)
end

function Library:Init(Config, LibraryParent)
	local UILibrary = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local Border = Instance.new("Frame")
	local Topbar = Instance.new("Frame")
	local CheatName = Instance.new("TextLabel")
	local DiscordInvite = Instance.new("TextLabel")
	local UITabs = Instance.new("Frame")
	local TabButtons = Instance.new("Frame")
	local Tabs = Instance.new("Frame")
	local Modal = Instance.new("TextButton")

	local LibraryInit = {}

	UILibrary.Name = HttpService:GenerateGUID(false)
	UILibrary.Parent = LibraryParent
	UILibrary.DisplayOrder = 1

	Main.Name = "Main"
	Main.Parent = UILibrary
	Main.AnchorPoint = Vector2.new(0.5,0.5)
	Main.BackgroundColor3 = Config.Theme.BackgroundColor
	Main.BorderColor3 = Color3.fromRGB(0,0,0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5,0,0.5,0)
	Main.Size = UDim2.new(0,450,0,0)
	Main.ZIndex = 2

	AddCorner(Main, UDim.new(0,5))

	Border.Name = "Border"
	Border.Parent = Main
	Border.AnchorPoint = Vector2.new(0.5,0.5)
	Border.BackgroundColor3 = Config.Theme.MainColor
	Border.BorderColor3 = Color3.fromRGB(0,0,0)
	Border.BorderSizePixel = 0
	Border.Position = UDim2.new(0.5,0,0.5,0)
	Border.Size = UDim2.new(1,2,1,2)

	AddCorner(Border, UDim.new(0,5))

	Topbar.Name = "Topbar"
	Topbar.Parent = Main
	Topbar.AnchorPoint = Vector2.new(0.5,0)
	Topbar.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Topbar.BackgroundTransparency = 1
	Topbar.BorderColor3 = Color3.fromRGB(0,0,0)
	Topbar.BorderSizePixel = 0
	Topbar.Position = UDim2.new(0.5,0,0,0)
	Topbar.Size = UDim2.new(0,450,0,15)
	Topbar.ZIndex = 2

	CheatName.Name = "CheatName"
	CheatName.Parent = Topbar
	CheatName.BackgroundColor3 = Color3.fromRGB(0,0,0)
	CheatName.BackgroundTransparency = 1
	CheatName.BorderColor3 = Color3.fromRGB(0,0,0)
	CheatName.BorderSizePixel = 0
	CheatName.ClipsDescendants = true
	CheatName.Position = UDim2.new(0,5,0,0)
	CheatName.Size = UDim2.new(1,-5,1,0)
	CheatName.ZIndex = 2
	CheatName.Font = Config.Theme.TextFont
	if Config.CheatName then
		CheatName.Text = Config.CheatName .. " - CoastingUI V2"
	else
		CheatName.Text = "CoastingUI V2"
	end
	CheatName.TextColor3 = Color3.fromRGB(255,255,255)
	CheatName.TextSize = 13
	CheatName.TextStrokeTransparency = 0.75
	CheatName.TextXAlignment = Enum.TextXAlignment.Left

	DiscordInvite.Name = "DiscordInvite"
	DiscordInvite.Parent = Topbar
	DiscordInvite.AnchorPoint = Vector2.new(1,0)
	DiscordInvite.BackgroundColor3 = Color3.fromRGB(0,0,0)
	DiscordInvite.BackgroundTransparency = 1
	DiscordInvite.BorderColor3 = Color3.fromRGB(0,0,0)
	DiscordInvite.BorderSizePixel = 0
	DiscordInvite.ClipsDescendants = true
	DiscordInvite.Position = UDim2.new(1,-5,0,0)
	DiscordInvite.Size = UDim2.new(1,-5,1,0)
	DiscordInvite.ZIndex = 2
	DiscordInvite.Font = Config.Theme.TextFont
	if Config.Discord then
		DiscordInvite.Text = "Discord: " .. Config.Discord
	else
		DiscordInvite.Text = ""
	end
	DiscordInvite.TextColor3 = Color3.fromRGB(255,255,255)
	DiscordInvite.TextSize = 13
	DiscordInvite.TextStrokeTransparency = 0.75
	DiscordInvite.TextXAlignment = Enum.TextXAlignment.Right

	UITabs.Name = "UITabs"
	UITabs.Parent = Main
	UITabs.AnchorPoint = Vector2.new(0.5,0.5)
	UITabs.BackgroundColor3 = Color3.fromRGB(0,0,0)
	UITabs.BackgroundTransparency = 1
	UITabs.BorderColor3 = Color3.fromRGB(0,0,0)
	UITabs.BorderSizePixel = 0
	UITabs.ClipsDescendants = true
	UITabs.Position = UDim2.new(0.5,0,0.5,0)
	UITabs.Size = UDim2.new(1,0,1,0)

	TabButtons.Name = "TabButtons"
	TabButtons.Parent = UITabs
	TabButtons.AnchorPoint = Vector2.new(0.5,0)
	TabButtons.BackgroundColor3 = Config.Theme.MainColor
	TabButtons.BorderColor3 = Color3.fromRGB(0,0,0)
	TabButtons.BorderSizePixel = 0
	TabButtons.Position = UDim2.new(0.5,0,0,15)
	TabButtons.Size = UDim2.new(1,-15,0,25)
	TabButtons.ZIndex = 2

	AddListLayout(TabButtons, Enum.FillDirection.Horizontal, Enum.SortOrder.LayoutOrder)
	AddCorner(TabButtons, UDim.new(0,5))

	Tabs.Name = "Tabs"
	Tabs.Parent = UITabs
	Tabs.AnchorPoint = Vector2.new(0.5,0)
	Tabs.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Tabs.BackgroundTransparency = 1
	Tabs.BorderColor3 = Color3.fromRGB(0,0,0)
	Tabs.BorderSizePixel = 0
	Tabs.Position = UDim2.new(0.5,0,0,40)
	Tabs.Size = UDim2.new(1,-15,1,-40)
	Tabs.ZIndex = 2
	TweenService:Create(Main, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(0,450,0,250)}):Play()
	TweenService:Create(Border, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Transparency = 0}):Play()

	Modal.Name = "Modal"
	Modal.Parent = Main
	Modal.BackgroundColor3 = Color3.fromRGB(0,0,0)
	Modal.BackgroundTransparency = 1
	Modal.BorderColor3 = Color3.fromRGB(0,0,0)
	Modal.BorderSizePixel = 0
	Modal.AutoButtonColor = false
	Modal.Font = Config.Theme.TextFont
	Modal.Text = ""
	Modal.TextColor3 = Color3.fromRGB(255,255,255)
	Modal.TextSize = 15
	Modal.TextStrokeTransparency = 0.75
	Modal.TextTransparency = 1

	table.insert(Library.LibraryColorTable, Border)
	table.insert(Library.LibraryColorTable, TabButtons)
	MakeDraggable(Topbar, Main)

	local function CloseAllTabs()
	    for _,Tab in pairs(Tabs:GetChildren()) do
	        if Tab:IsA("ScrollingFrame") then
	            Tab.Visible = false
	        end
	    end
	end

	local function ResetAllTabButtons()
	    for _,TabButton in pairs(TabButtons:GetChildren()) do
	        if TabButton:IsA("TextButton") then
	            TweenService:Create(TabButton, TweenInfo.new(0.3, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = Config.Theme.MainColor}):Play()
	        end
	    end
	end

	local function KeepFirstTabOpen()
	    for _,Tab in pairs(Tabs:GetChildren()) do
	        if Tab:IsA("ScrollingFrame") then
	            if Tab.Name == Library.FirstTab .. "Tab" then
	                Tab.Visible = true
	            else
	                Tab.Visible = false
	            end
	        end
	    end

	    for _,TabButton in pairs(TabButtons:GetChildren()) do
	        if TabButton:IsA("TextButton") then
	            if TabButton.Name == Library.FirstTab .. "TabButton" then
	                TweenService:Create(TabButton, TweenInfo.new(0.3, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = DarkenObjectColor(Config.Theme.MainColor, 15)}):Play()
	            else
	                TweenService:Create(TabButton, TweenInfo.new(0.3, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = Config.Theme.MainColor}):Play()
	            end
	        end
	    end
	end

	local function ToggleUI()
	    Library.UIOpen = not Library.UIOpen
	    if Library.UIOpen then
			Modal.Modal = false
	        TweenService:Create(Main, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(0,450,0,0)}):Play()
	        TweenService:Create(Border, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Transparency = 1}):Play()
			TweenService:Create(Topbar, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(0,450,0,0)}):Play()
	    elseif not Library.UIOpen then
			Modal.Modal = true
	        TweenService:Create(Main, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(0,450,0,250)}):Play()
	        TweenService:Create(Border, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Transparency = 0}):Play()
			TweenService:Create(Topbar, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(0,450,0,15)}):Play()
	    end
	end

	function LibraryInit:CreateTab(Name)
		local Tab = Instance.new("ScrollingFrame")
		local TabContentLayout = Instance.new("UIGridLayout")
		local TabButton = Instance.new("TextButton")
		local ButtonEnd = Instance.new("Frame")
		--local TabButtonEnd = Instance.new("TextButton")

		local TabElement = {}
		Library.TabCount = Library.TabCount + 1
		if Library.TabCount == 1 then
			Library.FirstTab = Name
		end

		Tab.Name = Name .. "Tab"
		Tab.Parent = Tabs
		Tab.Active = true
		Tab.BackgroundColor3 = Color3.fromRGB(0,0,0)
		Tab.BackgroundTransparency = 1
		Tab.BorderColor3 = Color3.fromRGB(0,0,0)
		Tab.BorderSizePixel = 0
		Tab.Size = UDim2.new(1,0,1,0)
		Tab.ZIndex = 2
		--Tab.BottomImage = ""
		--Tab.MidImage = ""
		Tab.ScrollBarThickness = 0
		--Tab.TopImage = ""

		TabContentLayout.Parent = Tab
		TabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
		TabContentLayout.CellPadding = UDim2.new(0, 25, 0, 25)
		TabContentLayout.CellSize = UDim2.new(0, 200, 0, 185)
		AddPadding(Tab, UDim.new(0,5), UDim.new(0,15))
		
		TabButton.Name = Name .. "TabButton"
		TabButton.Parent = TabButtons
		TabButton.BackgroundColor3 = Config.Theme.MainColor
		TabButton.BackgroundTransparency = 1
		TabButton.BorderColor3 = Color3.fromRGB(0,0,0)
		TabButton.BorderSizePixel = 0
		TabButton.Size = UDim2.new(0.2,0,0,25)
		TabButton.ZIndex = 2
		TabButton.Font = Config.Theme.TextFont
		TabButton.Text = Name
		TabButton.TextColor3 = Color3.fromRGB(255,255,255)
		TabButton.TextSize = 15
		TabButton.TextStrokeTransparency = 0.75

		ButtonEnd.Name = "ButtonEnd"
		ButtonEnd.Parent = TabButton
		ButtonEnd.AnchorPoint = Vector2.new(0.5,0.5)
		ButtonEnd.BackgroundColor3 = DarkenObjectColor(Config.Theme.MainColor, 15)
		ButtonEnd.BorderColor3 = Color3.fromRGB(0,0,0)
		ButtonEnd.BorderSizePixel = 0
		ButtonEnd.Position = UDim2.new(1,0,0.5,0)
		ButtonEnd.Size = UDim2.new(0,2,1,-5)
		ButtonEnd.ZIndex = 2

		Tab.Visible = true
		table.insert(Library.LibraryColorTable, TabButton)
		CloseAllTabs()
    	ResetAllTabButtons()
		TweenService:Create(TabButton, TweenInfo.new(0.3, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = DarkenObjectColor(Config.Theme.MainColor, 15)}):Play()
		KeepFirstTabOpen()
		TabButton.MouseButton1Down:Connect(function()
	        CloseAllTabs()
	        ResetAllTabButtons()
	        Tab.Visible = true
	        TweenService:Create(TabButton, TweenInfo.new(0.3, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = DarkenObjectColor(Config.Theme.MainColor, 15)}):Play()
    	end)

		function TabElement:CreateSection(Name)
			local Section = Instance.new("Frame")
			local SectionTitle = Instance.new("TextLabel")
			local SectionBorder = Instance.new("Frame")
			local SectionContent = Instance.new("ScrollingFrame")
			local SectionContentLayout = Instance.new("UIListLayout")

			local SectionElement = {}

			Section.Name = Name .. "Section"
			Section.Parent = Tab
			Section.BackgroundColor3 = Config.Theme.BackgroundColor
			Section.BorderColor3 = Color3.fromRGB(0,0,0)
			Section.BorderSizePixel = 0
			Section.Size = UDim2.new(0,100,0,100)
			Section.ZIndex = 4

			SectionTitle.Name = "SectionTitle"
			SectionTitle.Parent = Section
			SectionTitle.AnchorPoint = Vector2.new(0.5,0.5)
			SectionTitle.BackgroundColor3 = Config.Theme.BackgroundColor
			SectionTitle.BorderColor3 = Color3.fromRGB(0,0,0)
			SectionTitle.BorderSizePixel = 0
			SectionTitle.Position = UDim2.new(0.5,0,0,0)
			SectionTitle.Text = Name
			SectionTitle.TextSize = 15
			SectionTitle.Size = UDim2.new(0,SectionTitle.TextBounds.X + 5,0,15)
			SectionTitle.ZIndex = 4
			SectionTitle.Font = Config.Theme.TextFont
			--SectionTitle.Text = Name
			SectionTitle.TextColor3 = Color3.fromRGB(255,255,255)
			--SectionTitle.TextSize = 15
			SectionTitle.TextStrokeTransparency = 0.75

			SectionBorder.Name = "SectionBorder"
			SectionBorder.Parent = Section
			SectionBorder.AnchorPoint = Vector2.new(0.5,0.5)
			SectionBorder.BackgroundColor3 = Config.Theme.MainColor
			SectionBorder.BorderColor3 = Color3.fromRGB(0,0,0)
			SectionBorder.BorderSizePixel = 0
			SectionBorder.Position = UDim2.new(0.5,0,0.5,0)
			SectionBorder.Size = UDim2.new(1,2,1,2)
			SectionBorder.ZIndex = 3

			AddCorner(SectionBorder, UDim.new(0,5))
			AddCorner(Section, UDim.new(0,5))

			SectionContent.Name = "SectionContent"
			SectionContent.Parent = Section
			SectionContent.Active = true
			SectionContent.AnchorPoint = Vector2.new(0,1)
			SectionContent.BackgroundColor3 = Color3.fromRGB(0,0,0)
			SectionContent.BackgroundTransparency = 1
			SectionContent.BorderColor3 = Color3.fromRGB(0,0,0)
			SectionContent.BorderSizePixel = 0
			SectionContent.Position = UDim2.new(0,0,1,0)
			SectionContent.Size = UDim2.new(1,0,1,-5)
			SectionContent.ZIndex = 4
			SectionContent.BottomImage = ""
			SectionContent.MidImage = ""
			SectionContent.ScrollBarThickness = 0
			SectionContent.TopImage = ""
			SectionContentLayout.Parent = SectionContent
			SectionContentLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			SectionContentLayout.SortOrder = Enum.SortOrder.LayoutOrder

			table.insert(Library.LibraryColorTable, SectionBorder)
			SectionContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            	SectionContent.CanvasSize = UDim2.new(0, 0, 0, SectionContentLayout.AbsoluteContentSize.Y + 15)
        	end)
			
			function SectionElement:CreateLabel(Name, Text)
				local Label = Instance.new("TextLabel")

				Label.Name = Name .. "Label"
				Label.Parent = SectionContent
				Label.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Label.BackgroundTransparency = 1
				Label.BorderColor3 = Color3.fromRGB(0,0,0)
				Label.BorderSizePixel = 0
				Label.RichText = true
				Label.Text = Text
				Label.TextSize = 15
				Label.TextWrapped = true
				Label.Size = UDim2.new(1,0,0,Label.TextBounds.Y)
				Label.ZIndex = 5
				--Label.RichText = true
				Label.Font = Config.Theme.TextFont
				--Label.Text = Text
				Label.TextColor3 = Color3.fromRGB(255,255,255)
				--Label.TextSize = 15
				Label.TextStrokeTransparency = 0.75
				--Label.TextWrapped = true

				local function ChangeText(Text)
					Label.Text = Text
				end

				Label:GetPropertyChangedSignal("TextBounds"):Connect(function()
	                if Label.Text ~= "" then
	                    TweenService:Create(Label, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, Label.TextBounds.Y)}):Play()
	                else
	                    TweenService:Create(Label, TweenInfo.new(0.5, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 0, 0)}):Play()
	                end
	            end)

	            return {
	                ChangeText = ChangeText
	            }
			end

			function SectionElement:CreateButton(Name, Callback)
				local ButtonHolder = Instance.new("Frame")
				local Button = Instance.new("TextButton")

				ButtonHolder.Name = Name .. "Button"
				ButtonHolder.Parent = SectionContent
				ButtonHolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
				ButtonHolder.BackgroundTransparency = 1
				ButtonHolder.BorderColor3 = Color3.fromRGB(0,0,0)
				ButtonHolder.BorderSizePixel = 0
				ButtonHolder.Size = UDim2.new(1,0,0,35)
				ButtonHolder.ZIndex = 5

				Button.Name = "Button"
				Button.Parent = ButtonHolder
				Button.AnchorPoint = Vector2.new(0.5,0.5)
				Button.BackgroundColor3 = Config.Theme.MainColor
				Button.BorderColor3 = Color3.fromRGB(0,0,0)
				Button.BorderSizePixel = 0
				Button.ClipsDescendants = true
				Button.Position = UDim2.new(0.5,0,0.5,0)
				Button.Size = UDim2.new(1,0,0,25)
				Button.ZIndex = 6
				Button.AutoButtonColor = false
				Button.Font = Config.Theme.TextFont
				Button.Text = Name
				Button.TextColor3 = Color3.fromRGB(255,255,255)
				Button.TextSize = 15
				Button.TextStrokeTransparency = 0.75

				Button.MouseButton1Down:Connect(function()
	                TweenService:Create(Button, TweenInfo.new(0.25, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = DarkenObjectColor(Config.Theme.MainColor, 20)}):Play()
	                --RippleEffect(Button)
	                Callback(Button)
	            end)

	            Button.MouseButton1Up:Connect(function()
	                TweenService:Create(Button, TweenInfo.new(0.25, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = Config.Theme.MainColor}):Play()
	            end)

	            Button.InputEnded:Connect(function(input)
	                if input.UserInputType == Enum.UserInputType.MouseMovement then
	                    TweenService:Create(Button, TweenInfo.new(0.25, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {BackgroundColor3 = Config.Theme.MainColor}):Play()
	                end
	            end)

	            table.insert(Library.LibraryColorTable, Button)
			end

			function SectionElement:CreateToggle(Name, Callback)
				local ToggleHolder = Instance.new("Frame")
				local Title = Instance.new("TextLabel")
				local Toggle = Instance.new("TextButton")
				local CheckboxTicked = Instance.new("ImageLabel")
				local CheckboxOutline = Instance.new("ImageLabel")
				local TickCover = Instance.new("Frame")

				local Toggled = false

				ToggleHolder.Name = Name .. "Toggle"
				ToggleHolder.Parent = SectionContent
				ToggleHolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
				ToggleHolder.BackgroundTransparency = 1
				ToggleHolder.BorderColor3 = Color3.fromRGB(0,0,0)
				ToggleHolder.BorderSizePixel = 0
				ToggleHolder.Size = UDim2.new(1,0,0,35)
				ToggleHolder.ZIndex = 5

				Title.Name = "Title"
				Title.Parent = ToggleHolder
				Title.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.fromRGB(0,0,0)
				Title.BorderSizePixel = 0
				Title.Position = UDim2.new(0,10,0,0)
				Title.Size = UDim2.new(1,-50,1,0)
				Title.ZIndex = 5
				Title.Font = Config.Theme.TextFont
				Title.Text = Name
				Title.TextColor3 = Color3.fromRGB(185, 185, 185)
				Title.TextSize = 15
				Title.TextStrokeTransparency = 0.75
				Title.TextXAlignment = Enum.TextXAlignment.Left

				Toggle.Name = "Toggle"
				Toggle.Parent = ToggleHolder
				Toggle.AnchorPoint = Vector2.new(1,0.5)
				Toggle.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Toggle.BackgroundTransparency = 1
				Toggle.BorderColor3 = Color3.fromRGB(0,0,0)
				Toggle.BorderSizePixel = 0
				Toggle.Position = UDim2.new(1,-10,0.5,0)
				Toggle.Size = UDim2.new(0,20,0,20)
				Toggle.ZIndex = 5
				Toggle.AutoButtonColor = false
				Toggle.Font = Config.Theme.TextFont
				Toggle.Text = ""
				Toggle.TextColor3 = Color3.fromRGB(255,255,255)
				Toggle.TextSize = 15
				Toggle.TextStrokeTransparency = 0.75

				CheckboxTicked.Name = "CheckboxTicked"
				CheckboxTicked.Parent = Toggle
				CheckboxTicked.BackgroundColor3 = Color3.fromRGB(0,0,0)
				CheckboxTicked.BackgroundTransparency = 1
				CheckboxTicked.BorderColor3 = Color3.fromRGB(0,0,0)
				CheckboxTicked.BorderSizePixel = 0
				CheckboxTicked.Position = UDim2.new(0.5,-12,0.5,-12)
				CheckboxTicked.Size = UDim2.new(0,24,0,24)
				CheckboxTicked.ZIndex = 5
				CheckboxTicked.Image = "http://www.roblox.com/asset/?id=5416796675"
				CheckboxTicked.ImageColor3 = Color3.fromRGB(65,65,65)

				CheckboxOutline.Name = "CheckboxOutline"
				CheckboxOutline.Parent = Toggle
				CheckboxOutline.BackgroundColor3 = Color3.fromRGB(0,0,0)
				CheckboxOutline.BackgroundTransparency = 1
				CheckboxOutline.BorderColor3 = Color3.fromRGB(0,0,0)
				CheckboxOutline.BorderSizePixel = 0
				CheckboxOutline.Position = UDim2.new(0.5,-12,0.5,-12)
				CheckboxOutline.Size = UDim2.new(0,24,0,24)
				CheckboxOutline.ZIndex = 5
				CheckboxOutline.Image = "http://www.roblox.com/asset/?id=5416796047"
				CheckboxOutline.ImageColor3 = Color3.fromRGB(65,65,65)

				TickCover.Name = "TickCover"
				TickCover.Parent = Toggle
				TickCover.BackgroundColor3 = Config.Theme.BackgroundColor
				TickCover.BorderColor3 = Color3.fromRGB(0,0,0)
				TickCover.BorderSizePixel = 0
				TickCover.Position = UDim2.new(0.5,-7,0.5,-7)
				TickCover.Size = UDim2.new(0,14,0,14)
				TickCover.ZIndex = 5

				local function SetState(state)
	                if state then
	                    TweenService:Create(Title, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
	                    TweenService:Create(TickCover, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 0, 0.5, 0), Size = UDim2.new(0, 0, 0, 0)}):Play()
	                    TweenService:Create(CheckboxOutline, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Config.Theme.MainColor}):Play()
	                    TweenService:Create(CheckboxTicked, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Config.Theme.MainColor}):Play()
	                elseif not state then
	                    TweenService:Create(Title, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextColor3 = Color3.fromRGB(185, 185, 185)}):Play()
	                    TweenService:Create(TickCover, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Position = UDim2.new(0.5, -7, 0.5, -7), Size = UDim2.new(0, 14, 0, 14)}):Play()
	                    TweenService:Create(CheckboxOutline, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(65, 65, 65)}):Play()
	                    TweenService:Create(CheckboxTicked, TweenInfo.new(0.12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageColor3 = Color3.fromRGB(65, 65, 65)}):Play()
					end
					
	                Callback(Toggled)
				end
				
				Toggle.MouseButton1Down:Connect(function()
	                Toggled = not Toggled
					SetState(Toggled)
	            end)

	            table.insert(Library.LibraryColorTable, CheckboxOutline)
	            table.insert(Library.LibraryColorTable, CheckboxTicked)

				return {
                	SetState = SetState
            	}
			end
			function SectionElement:CreateSlider(Name, Min, Max, Preset, Precise, Callback)
				local SliderHolder = Instance.new("Frame")
				local Title = Instance.new("TextLabel")
				local SliderValue = Instance.new("Frame")
				local Value = Instance.new("TextBox")
				local SliderBackground = Instance.new("Frame")
				local SliderIndicator = Instance.new("Frame")
				local CircleSelector = Instance.new("Frame")

				local SliderDragging = false
	            local StartingValue = Preset
	    
	            if StartingValue == nil then
	                StartingValue = Preset
	            end

				SliderHolder.Name = Name .. "Slider"
				SliderHolder.Parent = SectionContent
				SliderHolder.BackgroundColor3 = Color3.fromRGB(0,0,0)
				SliderHolder.BackgroundTransparency = 1
				SliderHolder.BorderColor3 = Color3.fromRGB(0,0,0)
				SliderHolder.BorderSizePixel = 0
				SliderHolder.Size = UDim2.new(1,0,0,50)
				SliderHolder.ZIndex = 5

				Title.Name = "Title"
				Title.Parent = SliderHolder
				Title.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Title.BackgroundTransparency = 1
				Title.BorderColor3 = Color3.fromRGB(0,0,0)
				Title.Position = UDim2.new(0,10,0,0)
				Title.Size = UDim2.new(1,-75,0,35)
				Title.ZIndex = 5
				Title.Font = Config.Theme.TextFont
				Title.Text = Name
				Title.TextColor3 = Color3.fromRGB(255,255,255)
				Title.TextSize = 15
				Title.TextStrokeTransparency = 0.75
				Title.TextXAlignment = Enum.TextXAlignment.Left

				SliderValue.Name = "SliderValue"
				SliderValue.Parent = SliderHolder
				SliderValue.AnchorPoint = Vector2.new(1,0.5)
				SliderValue.BackgroundColor3 = Color3.fromRGB(65,65,65)
				SliderValue.BorderColor3 = Color3.fromRGB(0,0,0)
				SliderValue.BorderSizePixel = 0
				SliderValue.Position = UDim2.new(1,-10,0.5,-5)
				SliderValue.Size = UDim2.new(0,50,0,20)
				SliderValue.ZIndex = 5
				AddCorner(SliderValue, UDim.new(0,5))

				Value.Name = "Value"
				Value.Parent = SliderValue
				Value.BackgroundColor3 = Color3.fromRGB(0,0,0)
				Value.BackgroundTransparency = 1
				Value.BorderColor3 = Color3.fromRGB(0,0,0)
				Value.BorderSizePixel = 0
				Value.Size = UDim2.new(1,0,1,0)
				Value.ZIndex = 5
				Value.Font = Config.Theme.TextFont
				Value.PlaceholderColor3 = Color3.fromRGB(255,255,255)
				Value.Text = tostring(StartingValue or Precise and tonumber(string.format("%.2f", StartingValue)))
				Value.TextColor3 = Color3.fromRGB(255,255,255)
				Value.TextSize = 15
				Value.TextStrokeTransparency = 0.75

				SliderBackground.Name = "SliderBackground"
				SliderBackground.Parent = SliderHolder
				SliderBackground.AnchorPoint = Vector2.new(0.5,1)
				SliderBackground.BackgroundColor3 = Color3.fromRGB(55,55,55)
				SliderBackground.BorderColor3 = Color3.fromRGB(0,0,0)
				SliderBackground.BorderSizePixel = 0
				SliderBackground.Position = UDim2.new(0.5,0,1,-5)
				SliderBackground.Size = UDim2.new(1,-20,0,10)
				SliderBackground.ZIndex = 5
				AddCorner(SliderBackground, UDim.new(0,5))

				SliderIndicator.Name = "SliderIndicator"
				SliderIndicator.Parent = SliderBackground
				SliderIndicator.BackgroundColor3 = Config.Theme.MainColor
				SliderIndicator.BorderColor3 = Color3.fromRGB(0,0,0)
				SliderIndicator.BorderSizePixel = 0
				SliderIndicator.Size = UDim2.new(((StartingValue or Min) - Min) / (Max - Min), 0, 1, 0)
				SliderIndicator.ZIndex = 5
				AddCorner(SliderIndicator, UDim.new(0,5))

				CircleSelector.Name = "CircleSelector"
				CircleSelector.Parent = SliderIndicator
				CircleSelector.AnchorPoint = Vector2.new(0, 0.5)
				CircleSelector.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				CircleSelector.BackgroundTransparency = 1
				CircleSelector.BorderColor3 = Color3.fromRGB(0, 0, 0)
				CircleSelector.BorderSizePixel = 0
				CircleSelector.Position = UDim2.new(1, -10, 0.5, 0)
				CircleSelector.Size = UDim2.new(0, 20, 0, 20)
				CircleSelector.ZIndex = 5
				--AddCorner(CircleSelector, UDim.new(1,0))

				local function Sliding(Input)
	                local SliderPosition = UDim2.new(math.clamp((Input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1), 0, 1, 0)
	                TweenService:Create(SliderIndicator, TweenInfo.new(0.02, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = SliderPosition}):Play()
	    
	                local NonSliderPreciseValue = math.floor(((SliderPosition.X.Scale * Max) / Max) * (Max - Min) + Min)
	                local SliderPreciseValue = ((SliderPosition.X.Scale * Max) / Max) * (Max - Min) + Min
	    
	                local SlidingValue = (Precise and SliderPreciseValue or NonSliderPreciseValue)
	                SlidingValue = tonumber(string.format("%.2f", SlidingValue))
	    
	                Value.Text = tostring(SlidingValue)
	                Callback(SlidingValue)
	            end
	    
	            Value.FocusLost:Connect(function()
	                if not tonumber(Value.Text) then
	                    Value.Text = tostring(StartingValue or Precise and tonumber(string.format("%.2f", StartingValue)))
	                elseif Value.Text == "" or tonumber(Value.Text) <= Min then
	                    Value.Text = Min
	                elseif Value.Text == "" or tonumber(Value.Text) >= Max then
	                    Value.Text = Max
	                end
	    
	                TweenService:Create(SliderIndicator, TweenInfo.new(0.02, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(((tonumber(Value.Text) or Min) - Min) / (Max - Min), 0, 1, 0)}):Play()
	                Callback(tonumber(Value.Text))
	            end)
	    
	            CircleSelector.InputBegan:Connect(function(Input)
	                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
	                    SliderDragging = true
	                end
	            end)
	            
	            CircleSelector.InputEnded:Connect(function(Input)
	                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
	                    SliderDragging = false
	                end
	            end)
	            
	            CircleSelector.InputBegan:Connect(function(Input)
	                if Input.UserInputType == Enum.UserInputType.MouseButton1 then
	                    Sliding(Input)
	                end
	            end)
	        
	            UserInput.InputChanged:Connect(function(Input)
	                if SliderDragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
	                    Sliding(Input)
	                end
	            end)

	            local function SetSliderValue(Value)
	                Value.Text = Value
	                TweenService:Create(SliderIndicator, TweenInfo.new(0.02, Config.Theme.EasingStyle, Enum.EasingDirection.Out), {Size = UDim2.new(((tonumber(Value.Text) or Min) - Min) / (Max - Min), 0, 1, 0)}):Play()
	                Callback(tonumber(Value.Text))
	            end

	            Callback(StartingValue)
	            table.insert(Library.LibraryColorTable, SliderIndicator)

	            return {
	                SetSliderValue = SetSliderValue
	            }
			end
			function SectionElement:CreateColorPicker(Name, Preset, Callback)
				
			end
			function SectionElement:CreateDropdown(Name, OptionTable, Preset, Callback)
				
			end
			function SectionElement:CreateKeybind(Name, Preset, KeyboardOnly, HoldMode, Callback)
				
			end
			SectionContent.CanvasSize = UDim2.new(0, 0, 0, SectionContentLayout.AbsoluteContentSize.Y + 15)
			Tab.CanvasSize = UDim2.new(0, 0, 0, TabContentLayout.AbsoluteContentSize.Y + 25)
			return SectionElement
		end
		return TabElement
	end
	UserInput.InputBegan:Connect(function(Input)
	    if Input.KeyCode == Config.UIKeybind then
	        ToggleUI()
	    end
	end)
	return LibraryInit
end

return Library
