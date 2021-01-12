local ALXIDE = Instance.new("ScreenGui")
local Fade = Instance.new("Frame")
local Main = Instance.new("Frame")
local Topbar = Instance.new("Frame")
local Name = Instance.new("TextLabel")
local UIGradient = Instance.new("UIGradient")
local UIGradient_2 = Instance.new("UIGradient")
local PianoCounter = Instance.new("TextLabel")
local Delay = Instance.new("TextBox")
local UICorner = Instance.new("UICorner")
local Holder = Instance.new("Frame")
local BoxFrameHolder = Instance.new("Frame")
local UICorner_2 = Instance.new("UICorner")
local BoxHolder = Instance.new("Frame")
local UICorner_3 = Instance.new("UICorner")
local ScrollingBoxHolder = Instance.new("ScrollingFrame")
local Box = Instance.new("TextBox")
local ButtonHolder = Instance.new("Frame")
local Stop = Instance.new("TextButton")
local UICorner_4 = Instance.new("UICorner")
local Pause = Instance.new("TextButton")
local UICorner_5 = Instance.new("UICorner")
local UICorner_6 = Instance.new("UICorner")
local UIGridLayout = Instance.new("UIGridLayout")
local Play = Instance.new("TextButton")
local UICorner_7 = Instance.new("UICorner")
local ListHolder = Instance.new("Frame")
local UICorner_8 = Instance.new("UICorner")
local ScrollingListHolder = Instance.new("Frame")
local UICorner_9 = Instance.new("UICorner")
local List = Instance.new("ScrollingFrame")
local UIGridLayout_2 = Instance.new("UIGridLayout")
local Add = Instance.new("TextButton")
local UICorner_10 = Instance.new("UICorner")
local AddingFrame = Instance.new("Frame")
local SaveTopbar = Instance.new("Frame")
local UIGradient_3 = Instance.new("UIGradient")
local SaveName = Instance.new("TextLabel")
local UIGradient_4 = Instance.new("UIGradient")
local UICorner_11 = Instance.new("UICorner")
local SaveHolder = Instance.new("Frame")
local SaveInfoFrame = Instance.new("Frame")
local UICorner_12 = Instance.new("UICorner")
local Information = Instance.new("Frame")
local MusicName = Instance.new("TextBox")
local UICorner_13 = Instance.new("UICorner")
local UICorner_14 = Instance.new("UICorner")
local MusicDelay = Instance.new("TextBox")
local UICorner_15 = Instance.new("UICorner")
local Confirm = Instance.new("TextButton")
local UICorner_16 = Instance.new("UICorner")
local SaveBoxFrame = Instance.new("Frame")
local UICorner_17 = Instance.new("UICorner")
local Save = Instance.new("TextButton")
local UICorner_18 = Instance.new("UICorner")
local SaveBoxHolder = Instance.new("Frame")
local UICorner_19 = Instance.new("UICorner")
local ScrollingSaveBoxHolder = Instance.new("ScrollingFrame")
local SaveBox = Instance.new("TextBox")
local MusicBar = Instance.new("TextButton")

ALXIDE.IgnoreGuiInset = true
ALXIDE.Name = "ALXIDE"
ALXIDE.Parent = game:GetService("CoreGui")
ALXIDE.ResetOnSpawn = false

Fade.Name = "Fade"
Fade.Parent = ALXIDE
Fade.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Fade.BackgroundTransparency = 1.000
Fade.BorderColor3 = Color3.fromRGB(0, 0, 0)
Fade.BorderSizePixel = 0
Fade.Size = UDim2.new(1, 0, 1, 0)

Main.Name = "Main"
Main.Parent = ALXIDE
Main.AnchorPoint = Vector2.new(0.5, 1)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 0, 1, -50)
Main.Size = UDim2.new(0, 700, 0, 350)

Topbar.Name = "Topbar"
Topbar.Parent = Main
Topbar.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Topbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
Topbar.BorderSizePixel = 0
Topbar.Size = UDim2.new(1, 0, 0, 25)

Name.Name = "Name"
Name.Parent = Topbar
Name.AnchorPoint = Vector2.new(0.5, 0.5)
Name.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Name.BackgroundTransparency = 1.000
Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Name.BorderSizePixel = 0
Name.Position = UDim2.new(0.5, 0, 0.5, 0)
Name.Size = UDim2.new(1, 0, 1, 0)
Name.Font = Enum.Font.SourceSansSemibold
Name.Text = "ALXIDE"
Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Name.TextSize = 25.000
Name.TextWrapped = true

UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 30, 30))}
UIGradient.Offset = Vector2.new(0, 0.25)
UIGradient.Rotation = 90
UIGradient.Parent = Name

UIGradient_2.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(200, 50, 50)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
UIGradient_2.Rotation = 90
UIGradient_2.Parent = Topbar

PianoCounter.Name = "PianoCounter"
PianoCounter.Parent = Topbar
PianoCounter.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
PianoCounter.BackgroundTransparency = 1.000
PianoCounter.BorderColor3 = Color3.fromRGB(0, 0, 0)
PianoCounter.BorderSizePixel = 0
PianoCounter.Size = UDim2.new(1, -10, 1, 0)
PianoCounter.Font = Enum.Font.SourceSansSemibold
PianoCounter.Text = "[0/0]"
PianoCounter.TextColor3 = Color3.fromRGB(120, 0, 0)
PianoCounter.TextSize = 20.000
PianoCounter.TextWrapped = true
PianoCounter.TextXAlignment = Enum.TextXAlignment.Right

Delay.Name = "Delay"
Delay.Parent = Topbar
Delay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Delay.BackgroundTransparency = 1.000
Delay.BorderColor3 = Color3.fromRGB(0, 0, 0)
Delay.BorderSizePixel = 0
Delay.Position = UDim2.new(0, 10, 0, 0)
Delay.Size = UDim2.new(0, 50, 1, 0)
Delay.ClearTextOnFocus = false
Delay.Font = Enum.Font.SourceSansSemibold
Delay.PlaceholderColor3 = Color3.fromRGB(120, 0, 0)
Delay.PlaceholderText = "Delay"
Delay.Text = "0.1"
Delay.TextColor3 = Color3.fromRGB(120, 0, 0)
Delay.TextSize = 25.000
Delay.TextWrapped = true
Delay.TextXAlignment = Enum.TextXAlignment.Left

UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = Main

Holder.Name = "Holder"
Holder.Parent = Main
Holder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Holder.BackgroundTransparency = 1.000
Holder.BorderColor3 = Color3.fromRGB(0, 0, 0)
Holder.BorderSizePixel = 0
Holder.Position = UDim2.new(0, 0, 0, 25)
Holder.Size = UDim2.new(1, 0, 1, -25)

BoxFrameHolder.Name = "BoxFrameHolder"
BoxFrameHolder.Parent = Holder
BoxFrameHolder.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
BoxFrameHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
BoxFrameHolder.BorderSizePixel = 0
BoxFrameHolder.Position = UDim2.new(0, 10, 0, 10)
BoxFrameHolder.Size = UDim2.new(0, 535, 1, -75)

UICorner_2.CornerRadius = UDim.new(0, 5)
UICorner_2.Parent = BoxFrameHolder

BoxHolder.Name = "BoxHolder"
BoxHolder.Parent = BoxFrameHolder
BoxHolder.AnchorPoint = Vector2.new(0.5, 0.5)
BoxHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
BoxHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
BoxHolder.BorderSizePixel = 0
BoxHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
BoxHolder.Size = UDim2.new(1, -10, 1, -10)

UICorner_3.CornerRadius = UDim.new(0, 5)
UICorner_3.Parent = BoxHolder

ScrollingBoxHolder.Name = "ScrollingBoxHolder"
ScrollingBoxHolder.Parent = BoxHolder
ScrollingBoxHolder.Active = true
ScrollingBoxHolder.AnchorPoint = Vector2.new(0.5, 0.5)
ScrollingBoxHolder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScrollingBoxHolder.BackgroundTransparency = 1.000
ScrollingBoxHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollingBoxHolder.BorderSizePixel = 0
ScrollingBoxHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
ScrollingBoxHolder.Size = UDim2.new(1, -10, 1, -10)
ScrollingBoxHolder.CanvasSize = UDim2.new(0, 0, 5, 0)
ScrollingBoxHolder.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
ScrollingBoxHolder.ScrollBarThickness = 5

Box.Name = "Box"
Box.Parent = ScrollingBoxHolder
Box.AnchorPoint = Vector2.new(0.5, 0.5)
Box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
Box.BorderSizePixel = 0
Box.Position = UDim2.new(0.5, 0, 0.5, 0)
Box.Size = UDim2.new(1, 0, 1, 0)
Box.ClearTextOnFocus = false
Box.Font = Enum.Font.Code
Box.MultiLine = true
Box.PlaceholderColor3 = Color3.fromRGB(30, 30, 30)
Box.Text = ""
Box.TextColor3 = Color3.fromRGB(255, 255, 255)
Box.TextSize = 15.000
Box.TextXAlignment = Enum.TextXAlignment.Left
Box.TextYAlignment = Enum.TextYAlignment.Top

ButtonHolder.Name = "ButtonHolder"
ButtonHolder.Parent = Holder
ButtonHolder.AnchorPoint = Vector2.new(0, 1)
ButtonHolder.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ButtonHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
ButtonHolder.BorderSizePixel = 0
ButtonHolder.Position = UDim2.new(0, 10, 1, -10)
ButtonHolder.Size = UDim2.new(0, 535, 0, 50)

Stop.Name = "Stop"
Stop.Parent = ButtonHolder
Stop.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Stop.BorderColor3 = Color3.fromRGB(0, 0, 0)
Stop.BorderSizePixel = 0
Stop.Position = UDim2.new(0, 215, 0, 5)
Stop.Size = UDim2.new(0, 100, 0, 40)
Stop.AutoButtonColor = false
Stop.Font = Enum.Font.SourceSansSemibold
Stop.Text = "Stop"
Stop.TextColor3 = Color3.fromRGB(120, 120, 120)
Stop.TextSize = 35.000

UICorner_4.CornerRadius = UDim.new(0, 5)
UICorner_4.Parent = Stop

Pause.Name = "Pause"
Pause.Parent = ButtonHolder
Pause.AnchorPoint = Vector2.new(0.5, 0)
Pause.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Pause.BorderColor3 = Color3.fromRGB(0, 0, 0)
Pause.BorderSizePixel = 0
Pause.Position = UDim2.new(0, 160, 0, 5)
Pause.Size = UDim2.new(0, 100, 0, 40)
Pause.AutoButtonColor = false
Pause.Font = Enum.Font.SourceSansSemibold
Pause.Text = "Pause"
Pause.TextColor3 = Color3.fromRGB(120, 120, 120)
Pause.TextSize = 35.000

UICorner_5.CornerRadius = UDim.new(0, 5)
UICorner_5.Parent = Pause

UICorner_6.CornerRadius = UDim.new(0, 5)
UICorner_6.Parent = ButtonHolder

UIGridLayout.Parent = ButtonHolder
UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIGridLayout.CellSize = UDim2.new(0, 170, 0, 40)
UIGridLayout.StartCorner = Enum.StartCorner.TopRight

Play.Name = "Play"
Play.Parent = ButtonHolder
Play.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Play.BorderColor3 = Color3.fromRGB(0, 0, 0)
Play.BorderSizePixel = 0
Play.Position = UDim2.new(0, 5, 0, 5)
Play.Size = UDim2.new(0, 100, 0, 40)
Play.AutoButtonColor = false
Play.Font = Enum.Font.SourceSansSemibold
Play.Text = "Play"
Play.TextColor3 = Color3.fromRGB(0, 120, 0)
Play.TextSize = 35.000

UICorner_7.CornerRadius = UDim.new(0, 5)
UICorner_7.Parent = Play

ListHolder.Name = "ListHolder"
ListHolder.Parent = Holder
ListHolder.AnchorPoint = Vector2.new(1, 0)
ListHolder.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ListHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
ListHolder.BorderSizePixel = 0
ListHolder.Position = UDim2.new(1, -10, 0, 10)
ListHolder.Size = UDim2.new(0, 140, 1, -20)

UICorner_8.CornerRadius = UDim.new(0, 5)
UICorner_8.Parent = ListHolder

ScrollingListHolder.Name = "ScrollingListHolder"
ScrollingListHolder.Parent = ListHolder
ScrollingListHolder.AnchorPoint = Vector2.new(0.5, 0)
ScrollingListHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ScrollingListHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollingListHolder.BorderSizePixel = 0
ScrollingListHolder.Position = UDim2.new(0.5, 0, 0, 5)
ScrollingListHolder.Size = UDim2.new(1, -10, 1, -65)

UICorner_9.CornerRadius = UDim.new(0, 5)
UICorner_9.Parent = ScrollingListHolder

List.Name = "List"
List.Parent = ScrollingListHolder
List.Active = true
List.AnchorPoint = Vector2.new(0.5, 0.5)
List.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
List.BackgroundTransparency = 1.000
List.BorderColor3 = Color3.fromRGB(0, 0, 0)
List.BorderSizePixel = 0
List.Position = UDim2.new(0.5, 0, 0.5, 0)
List.Size = UDim2.new(1, -10, 1, -10)
List.CanvasSize = UDim2.new(0, 0, 5, 0)
List.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
List.ScrollBarThickness = 5

UIGridLayout_2.Parent = List
UIGridLayout_2.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIGridLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
UIGridLayout_2.CellPadding = UDim2.new(0, 0, 0, 0)
UIGridLayout_2.CellSize = UDim2.new(1, -20, 0, 25)

Add.Name = "Add"
Add.Parent = ListHolder
Add.AnchorPoint = Vector2.new(0, 1)
Add.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Add.BorderColor3 = Color3.fromRGB(0, 0, 0)
Add.BorderSizePixel = 0
Add.Position = UDim2.new(0, 5, 1, -5)
Add.Size = UDim2.new(1, -10, 0, 40)
Add.AutoButtonColor = false
Add.Font = Enum.Font.SourceSansSemibold
Add.Text = "+"
Add.TextColor3 = Color3.fromRGB(0, 120, 0)
Add.TextSize = 35.000

UICorner_10.CornerRadius = UDim.new(0, 5)
UICorner_10.Parent = Add

AddingFrame.Name = "AddingFrame"
AddingFrame.Parent = ALXIDE
AddingFrame.AnchorPoint = Vector2.new(0.5, 1)
AddingFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
AddingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
AddingFrame.BorderSizePixel = 0
AddingFrame.Position = UDim2.new(0.5, 505, 1, -50)
AddingFrame.Size = UDim2.new(0, 300, 0, 300)

SaveTopbar.Name = "SaveTopbar"
SaveTopbar.Parent = AddingFrame
SaveTopbar.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
SaveTopbar.BorderColor3 = Color3.fromRGB(0, 0, 0)
SaveTopbar.BorderSizePixel = 0
SaveTopbar.Size = UDim2.new(1, 0, 0, 25)

UIGradient_3.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(200, 50, 50)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))}
UIGradient_3.Rotation = 90
UIGradient_3.Parent = SaveTopbar

SaveName.Name = "SaveName"
SaveName.Parent = SaveTopbar
SaveName.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SaveName.BackgroundTransparency = 1.000
SaveName.BorderColor3 = Color3.fromRGB(0, 0, 0)
SaveName.BorderSizePixel = 0
SaveName.Size = UDim2.new(1, 0, 1, 0)
SaveName.Font = Enum.Font.SourceSansSemibold
SaveName.Text = "ALXIDE"
SaveName.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveName.TextSize = 25.000
SaveName.TextWrapped = true

UIGradient_4.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(30, 30, 30))}
UIGradient_4.Offset = Vector2.new(0, 0.25)
UIGradient_4.Rotation = 90
UIGradient_4.Parent = SaveName

UICorner_11.CornerRadius = UDim.new(0, 5)
UICorner_11.Parent = AddingFrame

SaveHolder.Name = "SaveHolder"
SaveHolder.Parent = AddingFrame
SaveHolder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
SaveHolder.BackgroundTransparency = 1.000
SaveHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
SaveHolder.BorderSizePixel = 0
SaveHolder.Position = UDim2.new(0, 0, 0, 25)
SaveHolder.Size = UDim2.new(1, 0, 1, -25)

SaveInfoFrame.Name = "SaveInfoFrame"
SaveInfoFrame.Parent = SaveHolder
SaveInfoFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SaveInfoFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
SaveInfoFrame.BorderSizePixel = 0
SaveInfoFrame.Position = UDim2.new(0, 5, 0, 5)
SaveInfoFrame.Size = UDim2.new(1, -10, 1, -10)
SaveInfoFrame.Visible = false

UICorner_12.CornerRadius = UDim.new(0, 5)
UICorner_12.Parent = SaveInfoFrame

Information.Name = "Information"
Information.Parent = SaveInfoFrame
Information.AnchorPoint = Vector2.new(0.5, 0)
Information.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Information.BorderColor3 = Color3.fromRGB(0, 0, 0)
Information.BorderSizePixel = 0
Information.Position = UDim2.new(0.5, 0, 0, 5)
Information.Size = UDim2.new(1, -10, 1, -55)

MusicName.Name = "MusicName"
MusicName.Parent = Information
MusicName.AnchorPoint = Vector2.new(0.5, 0)
MusicName.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MusicName.BorderColor3 = Color3.fromRGB(0, 0, 0)
MusicName.BorderSizePixel = 0
MusicName.Position = UDim2.new(0.5, 0, 0, 0)
MusicName.Size = UDim2.new(1, -10, 0.5, 0)
MusicName.Font = Enum.Font.SourceSansSemibold
MusicName.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
MusicName.PlaceholderText = "Name"
MusicName.Text = ""
MusicName.TextColor3 = Color3.fromRGB(120, 120, 120)
MusicName.TextScaled = true
MusicName.TextSize = 35.000
MusicName.TextWrapped = true

UICorner_13.CornerRadius = UDim.new(0, 5)
UICorner_13.Parent = MusicName

UICorner_14.CornerRadius = UDim.new(0, 5)
UICorner_14.Parent = Information

MusicDelay.Name = "MusicDelay"
MusicDelay.Parent = Information
MusicDelay.AnchorPoint = Vector2.new(0.5, 1)
MusicDelay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MusicDelay.BorderColor3 = Color3.fromRGB(0, 0, 0)
MusicDelay.BorderSizePixel = 0
MusicDelay.Position = UDim2.new(0.5, 0, 1, 0)
MusicDelay.Size = UDim2.new(1, -10, 0.5, 0)
MusicDelay.Font = Enum.Font.SourceSansSemibold
MusicDelay.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
MusicDelay.PlaceholderText = "Delay (Optional)"
MusicDelay.Text = ""
MusicDelay.TextColor3 = Color3.fromRGB(120, 120, 120)
MusicDelay.TextScaled = true
MusicDelay.TextSize = 45.000
MusicDelay.TextWrapped = true

UICorner_15.CornerRadius = UDim.new(0, 5)
UICorner_15.Parent = MusicDelay

Confirm.Name = "Confirm"
Confirm.Parent = SaveInfoFrame
Confirm.Active = false
Confirm.AnchorPoint = Vector2.new(0.5, 1)
Confirm.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Confirm.BorderColor3 = Color3.fromRGB(0, 0, 0)
Confirm.BorderSizePixel = 0
Confirm.Position = UDim2.new(0.5, 0, 1, -5)
Confirm.Size = UDim2.new(0, 150, 0, 40)
Confirm.AutoButtonColor = false
Confirm.Font = Enum.Font.SourceSansSemibold
Confirm.Text = "Confirm"
Confirm.TextColor3 = Color3.fromRGB(0, 120, 0)
Confirm.TextSize = 35.000

UICorner_16.CornerRadius = UDim.new(0, 5)
UICorner_16.Parent = Confirm

SaveBoxFrame.Name = "SaveBoxFrame"
SaveBoxFrame.Parent = SaveHolder
SaveBoxFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
SaveBoxFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
SaveBoxFrame.BorderSizePixel = 0
SaveBoxFrame.Position = UDim2.new(0, 5, 0, 5)
SaveBoxFrame.Size = UDim2.new(1, -10, 1, -10)

UICorner_17.CornerRadius = UDim.new(0, 5)
UICorner_17.Parent = SaveBoxFrame

Save.Name = "Save"
Save.Parent = SaveBoxFrame
Save.AnchorPoint = Vector2.new(0.5, 1)
Save.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Save.BorderColor3 = Color3.fromRGB(0, 0, 0)
Save.BorderSizePixel = 0
Save.Position = UDim2.new(0.5, 0, 1, -5)
Save.Size = UDim2.new(0, 150, 0, 40)
Save.AutoButtonColor = false
Save.Font = Enum.Font.SourceSansSemibold
Save.Text = "Save"
Save.TextColor3 = Color3.fromRGB(0, 120, 0)
Save.TextSize = 35.000

UICorner_18.CornerRadius = UDim.new(0, 5)
UICorner_18.Parent = Save

SaveBoxHolder.Name = "SaveBoxHolder"
SaveBoxHolder.Parent = SaveBoxFrame
SaveBoxHolder.AnchorPoint = Vector2.new(0.5, 0)
SaveBoxHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SaveBoxHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
SaveBoxHolder.BorderSizePixel = 0
SaveBoxHolder.Position = UDim2.new(0.5, 0, 0, 5)
SaveBoxHolder.Size = UDim2.new(1, -10, 1, -55)

UICorner_19.CornerRadius = UDim.new(0, 5)
UICorner_19.Parent = SaveBoxHolder

ScrollingSaveBoxHolder.Name = "ScrollingSaveBoxHolder"
ScrollingSaveBoxHolder.Parent = SaveBoxHolder
ScrollingSaveBoxHolder.Active = true
ScrollingSaveBoxHolder.AnchorPoint = Vector2.new(0.5, 0.5)
ScrollingSaveBoxHolder.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ScrollingSaveBoxHolder.BackgroundTransparency = 1.000
ScrollingSaveBoxHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
ScrollingSaveBoxHolder.BorderSizePixel = 0
ScrollingSaveBoxHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
ScrollingSaveBoxHolder.Size = UDim2.new(1, -10, 1, -10)
ScrollingSaveBoxHolder.CanvasSize = UDim2.new(0, 0, 5, 0)
ScrollingSaveBoxHolder.ScrollBarThickness = 5
ScrollingSaveBoxHolder.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)

SaveBox.Name = "SaveBox"
SaveBox.Parent = ScrollingSaveBoxHolder
SaveBox.AnchorPoint = Vector2.new(0.5, 0.5)
SaveBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SaveBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
SaveBox.BorderSizePixel = 0
SaveBox.Position = UDim2.new(0.5, 0, 0.5, 0)
SaveBox.Size = UDim2.new(1, 0, 1, 0)
SaveBox.ClearTextOnFocus = false
SaveBox.Font = Enum.Font.Code
SaveBox.MultiLine = true
SaveBox.PlaceholderColor3 = Color3.fromRGB(30, 30, 30)
SaveBox.Text = ""
SaveBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBox.TextSize = 15.000
SaveBox.TextXAlignment = Enum.TextXAlignment.Left
SaveBox.TextYAlignment = Enum.TextYAlignment.Top

MusicBar.Name = "MusicBar"
MusicBar.Parent = ALXIDE
MusicBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MusicBar.BackgroundTransparency = 1.000
MusicBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
MusicBar.BorderSizePixel = 0
MusicBar.Size = UDim2.new(0, 130, 0, 20)
MusicBar.Visible = false
MusicBar.AutoButtonColor = false
MusicBar.Font = Enum.Font.SourceSansSemibold
MusicBar.Text = "SONG_NAME"
MusicBar.TextColor3 = Color3.fromRGB(120, 120, 120)
MusicBar.TextScaled = true
MusicBar.TextSize = 20.000
MusicBar.TextWrapped = true

loadstring(game:HttpGet('https://pastebin.com/raw/tqLie506'))()
local UserInputService = game:GetService("UserInputService")
local PlayerService = game:GetService("Players")
local Player = PlayerService.LocalPlayer
local Mouse = Player:GetMouse()

local AddingFrameOpen = true
Main.Position = UDim2.new(0.5, 0,1, 550)
AddingFrame.Position = UDim2.new(0.5, 505,1, 550)

function Tween(O,T,S)
    game:GetService("TweenService"):Create(O,TweenInfo.new(T),S):Play()
end

UserInputService.InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.Insert then
		if Fade.BackgroundTransparency == 1 then
			Tween(Fade, 1, {
				BackgroundTransparency = 0.5
			})
			wait(1)
			Main:TweenPosition(UDim2.new(0.5, 0,1, -50))
        elseif Fade.BackgroundTransparency == 0.5 then
            AddingFrame:TweenPosition(UDim2.new(0.5, 505,1, 550))
            Main:TweenPosition(UDim2.new(0.5, 0,1, 550))
            AddingFrameOpen = true
			wait(1)
			Tween(Fade, 1, {
				BackgroundTransparency = 1
			})
		end
    end
end)

function OpenAddingFrame()
    if AddingFrameOpen then
		AddingFrame:TweenPosition(UDim2.new(0.5, 505,1, -50))
		AddingFrameOpen = false
    else
		AddingFrame:TweenPosition(UDim2.new(0.5, 505,1, 550))
		AddingFrameOpen = true
    end
end
Add.MouseButton1Click:Connect(OpenAddingFrame)

Save.MouseButton1Down:Connect(function()
    SaveBoxFrame.Visible = false
    SaveInfoFrame.Visible = true
end)

Confirm.MouseButton1Down:Connect(function()
    local Ready = true
    for i,v in pairs(List:GetChildren()) do
        if v.Name:match(MusicName.Text) then
            print('Already in use!')
            Confirm.TextColor3 = Color3.fromRGB(120, 0, 0)
            wait(.2)
            Confirm.TextColor3 = Color3.fromRGB(0, 120, 0)
            Ready = false
        end
    end
    if Ready then
        OpenAddingFrame = false
        local MouseIn = false
        local Add_Bar = MusicBar:Clone()
        local Notes = Instance.new('StringValue')
        local Speed = Instance.new('StringValue')
        Notes.Parent = Add_Bar
        Speed.Parent = Add_Bar
        Add_Bar.Name = MusicName.Text
        Add_Bar.Text = MusicName.Text
        Add_Bar.Parent = List
        Notes.Value = SaveBox.Text
        Speed.Value = MusicDelay.Text
        Add_Bar.MouseEnter:connect(function()
            MouseIn = true
            Mouse.KeyDown:connect(function(key)
                if key:lower() == 'e' then
                    if MouseIn == true then
                        Add_Bar:Remove()
                    end
                end
            end)
        end)
        Add_Bar.MouseLeave:connect(function()
            MouseIn = false
        end)
        Add_Bar.MouseButton1Down:Connect(function()
            Box.Text = Notes.Value
            if type(tonumber(Speed.Value)) == 'number' then
                Delay.Text = Speed.Value
            end
        end)
        SaveInfoFrame.Visible = false
        SaveBoxFrame.Visible = true
        MusicName.Text = ''
        MusicDelay.Text = ''
        SaveBox.Text = ''
        Add_Bar.Visible = true
        AddingFrame:TweenPosition(UDim2.new(0.5, 505,1, 550))
		AddingFrameOpen = true
    end
end)

StopValue = false
GroupNote = false
Stop.MouseButton1Down:Connect(function()
	StopValue = true
end)

Special_Notes = {'!','@','$','^','(','%'}

function ShiftKey(key)
	local AsciiKey = _G.Ascii[key]
	keypress(0xA0); keypress(AsciiKey);
	keyrelease(0xA0); keyrelease(AsciiKey);
end

Play.MouseButton1Down:Connect(function()
	local Count = 0
	Speed = Delay.Text
	Pause.TextColor3 = Color3.fromRGB(120, 120, 120)
	paused = false
	c = coroutine.create(function()
		for Notes in Box.Text:gmatch('[^%.]') do
			if paused then
				coroutine.yield()
			end
			local Special_Play = false
			local DefaultSpeed = Delay.Text
			print(Speed)
            if StopValue == true then
                StopValue = false
                break
            end
			if Notes == '[' then
				GroupNote = true
				Speed = '0'
			elseif Notes == ']' then
				GroupNote = false
				Speed = DefaultSpeed
			elseif Notes == '|' then
			wait(.5)
			elseif Notes == '{' then
				Speed = Speed/2
			elseif Notes == '}' then
				Speed = DefaultSpeed
			elseif Notes == ' ' then
				wait(Speed+'.01')
			end
			for i=1,#Special_Notes do
				if Notes == Special_Notes[i] then
					ShiftKey(Notes)
					Special_Play = true
				end
			end
			if not Special_Play and not paused then
				if Notes:match('%w' or '%d') then
					local Press = _G.Ascii[Notes:lower()]
					if not Notes:match('%d') and Notes == Notes:upper() then
						keypress(0xA0); keypress(Press); keyrelease(Press);
						keyrelease(0xA0)
					else
						keypress(Press); keyrelease(Press)
					end 
				end
			end
			print(Notes)
			Count=Count+1
			wait(tonumber(Speed))
			PianoCounter.Text = '['..Count..'/'..#Box.Text..']'
		end
	end)
	coroutine.resume(c)
end)

Pause.MouseButton1Down:Connect(function()
	if paused then 
		paused = false
		Pause.TextColor3 = Color3.fromRGB(120, 120, 120)
		coroutine.resume(c)
	else
		paused = true
		Pause.TextColor3 = Color3.fromRGB(60, 60, 60)
		coroutine.resume(c)
	end
end)
