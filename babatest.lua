--[[
RYSA CHEAT - NEVERLOSE LIBRARY
Menü: End tuşu
]]

if game.CoreGui:FindFirstChild("Library") then
    game.CoreGui:FindFirstChild("Library"):Destroy()
end

local VLib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local HttpService = game:GetService("HttpService")

coroutine.wrap(function()
    while wait() do
        VLib.RainbowColorValue = VLib.RainbowColorValue + 1 / 255
        VLib.HueSelectionPosition = VLib.HueSelectionPosition + 1

        if VLib.RainbowColorValue >= 1 then
            VLib.RainbowColorValue = 0
        end

        if VLib.HueSelectionPosition == 80 then
            VLib.HueSelectionPosition = 0
        end
    end
end)()

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
        Tween:Play()
    end

    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = object.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    topbarobject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

local Library = Instance.new("ScreenGui")
Library.Name = "Library"
Library.Parent = game.CoreGui
Library.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local uitoggled = false
UserInputService.InputBegan:Connect(function(io, p)
    if io.KeyCode == Enum.KeyCode.End then
        if uitoggled == false then
            Library.Enabled = false
            uitoggled = true
        else
            Library.Enabled = true
            uitoggled = false
        end
    end
end)

function VLib:Window(text, textgame, textcircle)
    local FirstTab = false
    local MainFrame = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local LeftFrame = Instance.new("Frame")
    local LeftFrameCorner = Instance.new("UICorner")
    local MainTitle = Instance.new("TextLabel")
    local TabHolder = Instance.new("Frame")
    local TabHoldLayout = Instance.new("UIListLayout")
    local ContainerHold = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")
    local ProfileFrame = Instance.new("Frame")
    local ProfileCorner = Instance.new("UICorner")
    local ProfileAvatar = Instance.new("ImageLabel")
    local ProfileName = Instance.new("TextLabel")
    local ProfileStatus = Instance.new("TextLabel")
    local Separator = Instance.new("Frame")

    MainFrame.Name = "MainFrame"
    MainFrame.Parent = Library
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.Position = UDim2.new(0.5, -400, 0.5, -300)
    MainFrame.Size = UDim2.new(0, 800, 0, 600)

    MainCorner.CornerRadius = UDim.new(0, 8)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = MainFrame

    LeftFrame.Name = "LeftFrame"
    LeftFrame.Parent = MainFrame
    LeftFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    LeftFrame.Position = UDim2.new(0, 0, 0, 0)
    LeftFrame.Size = UDim2.new(0, 220, 0, 600)

    LeftFrameCorner.CornerRadius = UDim.new(0, 8)
    LeftFrameCorner.Name = "LeftFrameCorner"
    LeftFrameCorner.Parent = LeftFrame

    MainTitle.Name = "MainTitle"
    MainTitle.Parent = LeftFrame
    MainTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MainTitle.BackgroundTransparency = 1.000
    MainTitle.Position = UDim2.new(0.05, 0, 0.02, 0)
    MainTitle.Size = UDim2.new(0, 200, 0, 30)
    MainTitle.Font = Enum.Font.GothamBold
    MainTitle.Text = text
    MainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    MainTitle.TextSize = 28.000
    MainTitle.TextXAlignment = Enum.TextXAlignment.Left

    TabHolder.Name = "TabHolder"
    TabHolder.Parent = LeftFrame
    TabHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHolder.BackgroundTransparency = 1.000
    TabHolder.Position = UDim2.new(0, 0, 0.08, 0)
    TabHolder.Size = UDim2.new(0, 220, 0, 450)

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHolder
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 0)

    ProfileFrame.Name = "ProfileFrame"
    ProfileFrame.Parent = LeftFrame
    ProfileFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ProfileFrame.Position = UDim2.new(0, 0, 0.85, 0)
    ProfileFrame.Size = UDim2.new(0, 220, 0, 90)
    ProfileFrame.BorderSizePixel = 0

    ProfileCorner.CornerRadius = UDim.new(0, 0)
    ProfileCorner.Name = "ProfileCorner"
    ProfileCorner.Parent = ProfileFrame

    ProfileAvatar.Name = "ProfileAvatar"
    ProfileAvatar.Parent = ProfileFrame
    ProfileAvatar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ProfileAvatar.Position = UDim2.new(0.05, 0, 0.08, 0)
    ProfileAvatar.Size = UDim2.new(0, 50, 0, 50)
    ProfileAvatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420"
    
    local AvatarCorner = Instance.new("UICorner")
    AvatarCorner.CornerRadius = UDim.new(0, 5)
    AvatarCorner.Parent = ProfileAvatar

    ProfileName.Name = "ProfileName"
    ProfileName.Parent = ProfileFrame
    ProfileName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ProfileName.BackgroundTransparency = 1.000
    ProfileName.Position = UDim2.new(0.3, 0, 0.08, 0)
    ProfileName.Size = UDim2.new(0, 140, 0, 20)
    ProfileName.Font = Enum.Font.GothamBold
    ProfileName.Text = LocalPlayer.Name
    ProfileName.TextColor3 = Color3.fromRGB(255, 255, 255)
    ProfileName.TextSize = 14.000
    ProfileName.TextXAlignment = Enum.TextXAlignment.Left

    ProfileStatus.Name = "ProfileStatus"
    ProfileStatus.Parent = ProfileFrame
    ProfileStatus.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ProfileStatus.BackgroundTransparency = 1.000
    ProfileStatus.Position = UDim2.new(0.3, 0, 0.35, 0)
    ProfileStatus.Size = UDim2.new(0, 140, 0, 15)
    ProfileStatus.Font = Enum.Font.Gotham
    ProfileStatus.Text = "Till: Lifetime"
    ProfileStatus.TextColor3 = Color3.fromRGB(150, 150, 150)
    ProfileStatus.TextSize = 11.000
    ProfileStatus.TextXAlignment = Enum.TextXAlignment.Left

    Separator.Name = "Separator"
    Separator.Parent = LeftFrame
    Separator.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Separator.Position = UDim2.new(0, 0, 0.84, 0)
    Separator.Size = UDim2.new(0, 220, 0, 1)
    Separator.BorderSizePixel = 0

    ContainerHold.Name = "ContainerHold"
    ContainerHold.Parent = MainFrame

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = MainFrame
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Position = UDim2.new(0.27, 0, 0, 0)
    DragFrame.Size = UDim2.new(0, 530, 0, 30)

    MakeDraggable(DragFrame, MainFrame)

    local Tabs = {}
    function Tabs:Tab(text, icon)
        local Tab = Instance.new("TextButton")
        local TabCorner = Instance.new("UICorner")
        local TabIcon = Instance.new("TextLabel")
        local Title = Instance.new("TextLabel")
        
        Tab.Name = "Tab"
        Tab.Parent = TabHolder
        Tab.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Tab.Size = UDim2.new(0, 220, 0, 45)
        Tab.AutoButtonColor = false
        Tab.Font = Enum.Font.Gotham
        Tab.Text = ""
        Tab.BorderSizePixel = 0

        TabCorner.CornerRadius = UDim.new(0, 0)
        TabCorner.Name = "TabCorner"
        TabCorner.Parent = Tab

        TabIcon.Name = "TabIcon"
        TabIcon.Parent = Tab
        TabIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabIcon.BackgroundTransparency = 1.000
        TabIcon.Position = UDim2.new(0.05, 0, 0.15, 0)
        TabIcon.Size = UDim2.new(0, 20, 0, 20)
        TabIcon.Font = Enum.Font.GothamBold
        TabIcon.Text = icon
        TabIcon.TextColor3 = Color3.fromRGB(100, 150, 255)
        TabIcon.TextSize = 16.000

        Title.Name = "Title"
        Title.Parent = Tab
        Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Title.BackgroundTransparency = 1.000
        Title.Position = UDim2.new(0.15, 0, 0.15, 0)
        Title.Size = UDim2.new(0, 150, 0, 20)
        Title.Font = Enum.Font.Gotham
        Title.Text = text
        Title.TextColor3 = Color3.fromRGB(200, 200, 200)
        Title.TextSize = 14.000
        Title.TextXAlignment = Enum.TextXAlignment.Left

        local Container = Instance.new("ScrollingFrame")
        local ContainerLayout = Instance.new("UIListLayout")

        Container.Name = "Container"
        Container.Parent = ContainerHold
        Container.Active = true
        Container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        Container.BackgroundTransparency = 0.000
        Container.BorderSizePixel = 0
        Container.Position = UDim2.new(0.275, 0, 0.05, 0)
        Container.Size = UDim2.new(0, 530, 0, 550)
        Container.ScrollBarThickness = 5
        Container.CanvasSize = UDim2.new(0, 0, 0, 0)
        Container.Visible = false
        Container.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)

        ContainerLayout.Name = "ContainerLayout"
        ContainerLayout.Parent = Container
        ContainerLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ContainerLayout.Padding = UDim.new(0, 10)

        if FirstTab == false then
            FirstTab = true
            Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Title.TextColor3 = Color3.fromRGB(100, 150, 255)
            Container.Visible = true
        end
        Tab.MouseButton1Click:Connect(function()
            for i, v in next, ContainerHold:GetChildren() do
                if v.Name == "Container" then
                    v.Visible = false
                end
            end

            for i, v in next, TabHolder:GetChildren() do
                if v.ClassName == "TextButton" then
                    v.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                    v:FindFirstChild("Title").TextColor3 = Color3.fromRGB(200, 200, 200)
                end
            end
            
            Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Title.TextColor3 = Color3.fromRGB(100, 150, 255)
            Container.Visible = true
        end)
        local ContainerItems = {}
        function ContainerItems:Button(text, callback)
            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")

            Button.Name = "Button"
            Button.Parent = Container
            Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Button.Size = UDim2.new(0, 510, 0, 40)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.Gotham
            Button.TextColor3 = Color3.fromRGB(200, 200, 200)
            Button.TextSize = 14.000
            Button.Text = text

            ButtonCorner.CornerRadius = UDim.new(0, 4)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            Button.MouseEnter:Connect(function()
                TweenService:Create(
                    Button,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                ):Play()
            end)
            Button.MouseLeave:Connect(function()
                TweenService:Create(
                    Button,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}
                ):Play()
            end)

            Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)

            Button.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end
        function ContainerItems:Toggle(text, Default, callback)
            local Toggled = Default or false
            local Toggle = Instance.new("TextButton")
            local ToggleCorner = Instance.new("UICorner")
            local Title = Instance.new("TextLabel")
            local ToggleFrame = Instance.new("Frame")
            local ToggleFrameCorner = Instance.new("UICorner")
            local ToggleDot = Instance.new("Frame")
            local ToggleDotCorner = Instance.new("UICorner")
            
            Toggle.Name = "Toggle"
            Toggle.Parent = Container
            Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            Toggle.Size = UDim2.new(0, 510, 0, 40)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.Gotham
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(200, 200, 200)
            Toggle.TextSize = 14.000

            ToggleCorner.CornerRadius = UDim.new(0, 4)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle

            Title.Name = "Title"
            Title.Parent = Toggle
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0.02, 0, 0, 0)
            Title.Size = UDim2.new(0, 450, 0, 40)
            Title.Font = Enum.Font.Gotham
            Title.Text = text
            Title.TextColor3 = Color3.fromRGB(200, 200, 200)
            Title.TextSize = 14.000
            Title.TextXAlignment = Enum.TextXAlignment.Left

            ToggleFrame.Name = "ToggleFrame"
            ToggleFrame.Parent = Toggle
            ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            ToggleFrame.Position = UDim2.new(0.92, 0, 0.25, 0)
            ToggleFrame.Size = UDim2.new(0, 35, 0, 18)
            ToggleFrame.BorderSizePixel = 0

            ToggleFrameCorner.CornerRadius = UDim.new(1, 0)
            ToggleFrameCorner.Name = "ToggleFrameCorner"
            ToggleFrameCorner.Parent = ToggleFrame

            ToggleDot.Name = "ToggleDot"
            ToggleDot.Parent = ToggleFrame
            ToggleDot.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            ToggleDot.Position = UDim2.new(0.08, 0, 0.15, 0)
            ToggleDot.Size = UDim2.new(0, 14, 0, 14)
            ToggleDot.BorderSizePixel = 0

            ToggleDotCorner.CornerRadius = UDim.new(1, 0)
            ToggleDotCorner.Name = "ToggleDotCorner"
            ToggleDotCorner.Parent = ToggleDot

            Toggle.MouseEnter:Connect(function()
                TweenService:Create(
                    Toggle,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}
                ):Play()
            end)
            Toggle.MouseLeave:Connect(function()
                TweenService:Create(
                    Toggle,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}
                ):Play()
            end)

            if Toggled == true then
                ToggleDot.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                TweenService:Create(
                    ToggleDot,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad),
                    {Position = UDim2.new(0.6, 0, 0.15, 0)}
                ):Play()
                pcall(callback, Toggled)
            end

            Toggle.MouseButton1Click:Connect(function()
                Toggled = not Toggled
                if Toggled == true then
                    ToggleDot.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                    ToggleFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    TweenService:Create(
                        ToggleDot,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad),
                        {Position = UDim2.new(0.6, 0, 0.15, 0)}
                    ):Play()
                else
                    ToggleDot.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                    ToggleFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    TweenService:Create(
                        ToggleDot,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad),
                        {Position = UDim2.new(0.08, 0, 0.15, 0)}
                    ):Play()
                end
                pcall(callback, Toggled)
            end)

            Container.CanvasSize = UDim2.new(0, 0, 0, ContainerLayout.AbsoluteContentSize.Y)
        end
        return ContainerItems
    end
    return Tabs
end

local Rysa = VLib:Window("RYSA", "CHEAT", "")

local Settings = Rysa:Tab("Settings", "⚙️")
Settings:Button("Test Button", function()
    print("Test")
end)
Settings:Toggle("Test Toggle", false, function(state)
    print("Toggle:", state)
end)

local LuaExecuter = Rysa:Tab("Lua Executer", "💻")
LuaExecuter:Button("Execute", function()
    print("Lua Executer")
end)

local Local = Rysa:Tab("Local", "👤")
Local:Button("Local Features", function()
    print("Local")
end)

local PlayerList = Rysa:Tab("PlayerList", "👥")
PlayerList:Button("Players", function()
    print("PlayerList")
end)

local Server = Rysa:Tab("Server", "🌐")
Server:Button("Server Info", function()
    print("Server")
end)

print("✅ RYSA CHEAT - BAŞLANDI")
print("Menü: End tuşu")
