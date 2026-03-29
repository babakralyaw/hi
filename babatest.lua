--[[
RYSA CHEAT - MODERN GUI
Menü: End tuşu
]]

if game.CoreGui:FindFirstChild("RysaUI") then
    game.CoreGui:FindFirstChild("RysaUI"):Destroy()
end

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local ModernUI = {}
ModernUI.Colors = {
    Primary = Color3.fromRGB(100, 150, 255),
    Secondary = Color3.fromRGB(60, 100, 200),
    Background = Color3.fromRGB(12, 12, 18),
    Surface = Color3.fromRGB(20, 20, 30),
    Hover = Color3.fromRGB(30, 30, 45),
    Text = Color3.fromRGB(240, 240, 250),
    TextSecondary = Color3.fromRGB(150, 150, 170),
    Accent = Color3.fromRGB(100, 200, 255)
}

local function Tween(object, duration, properties)
    local tween = TweenService:Create(object, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
    tween:Play()
    return tween
end

local function MakeDraggable(frame, dragHandle)
    local dragging = false
    local dragStart = nil
    local startPos = nil

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
end

function ModernUI:CreateWindow(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RysaUI"
    screenGui.Parent = game.CoreGui
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Parent = screenGui
    mainFrame.BackgroundColor3 = ModernUI.Colors.Background
    mainFrame.Position = UDim2.new(0.5, -450, 0.5, -350)
    mainFrame.Size = UDim2.new(0, 900, 0, 700)
    mainFrame.BorderSizePixel = 0

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = mainFrame

    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Parent = mainFrame
    shadow.BackgroundTransparency = 1
    shadow.Position = UDim2.new(0, -10, 0, -10)
    shadow.Size = UDim2.new(1, 20, 1, 20)
    shadow.Image = "rbxasset://textures/Cursors/MouseLockedCursor.png"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ZIndex = 0

    -- Header
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Parent = mainFrame
    header.BackgroundColor3 = ModernUI.Colors.Surface
    header.Position = UDim2.new(0, 0, 0, 0)
    header.Size = UDim2.new(1, 0, 0, 60)
    header.BorderSizePixel = 0

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 12)
    headerCorner.Parent = header

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, ModernUI.Colors.Surface),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 40))
    }
    gradient.Parent = header

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "Title"
    titleLabel.Parent = header
    titleLabel.BackgroundTransparency = 1
    titleLabel.Position = UDim2.new(0, 20, 0, 15)
    titleLabel.Size = UDim2.new(0, 300, 0, 30)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Text = title
    titleLabel.TextColor3 = ModernUI.Colors.Text
    titleLabel.TextSize = 24
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local subtitle = Instance.new("TextLabel")
    subtitle.Name = "Subtitle"
    subtitle.Parent = header
    subtitle.BackgroundTransparency = 1
    subtitle.Position = UDim2.new(0, 20, 0, 40)
    subtitle.Size = UDim2.new(0, 300, 0, 15)
    subtitle.Font = Enum.Font.Gotham
    subtitle.Text = "Modern Cheat Menu"
    subtitle.TextColor3 = ModernUI.Colors.TextSecondary
    subtitle.TextSize = 11
    subtitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Sidebar
    local sidebar = Instance.new("Frame")
    sidebar.Name = "Sidebar"
    sidebar.Parent = mainFrame
    sidebar.BackgroundColor3 = ModernUI.Colors.Background
    sidebar.Position = UDim2.new(0, 0, 0, 60)
    sidebar.Size = UDim2.new(0, 200, 0, 640)
    sidebar.BorderSizePixel = 0

    local sidebarCorner = Instance.new("UICorner")
    sidebarCorner.CornerRadius = UDim.new(0, 12)
    sidebarCorner.Parent = sidebar

    local tabContainer = Instance.new("Frame")
    tabContainer.Name = "TabContainer"
    tabContainer.Parent = sidebar
    tabContainer.BackgroundTransparency = 1
    tabContainer.Position = UDim2.new(0, 0, 0, 10)
    tabContainer.Size = UDim2.new(1, 0, 0, 500)

    local tabLayout = Instance.new("UIListLayout")
    tabLayout.Parent = tabContainer
    tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
    tabLayout.Padding = UDim.new(0, 8)

    local padding = Instance.new("UIPadding")
    padding.PaddingLeft = UDim.new(0, 10)
    padding.PaddingRight = UDim.new(0, 10)
    padding.Parent = tabContainer

    -- Profile Section
    local profileFrame = Instance.new("Frame")
    profileFrame.Name = "Profile"
    profileFrame.Parent = sidebar
    profileFrame.BackgroundColor3 = ModernUI.Colors.Surface
    profileFrame.Position = UDim2.new(0, 10, 0, 550)
    profileFrame.Size = UDim2.new(0, 180, 0, 80)
    profileFrame.BorderSizePixel = 0

    local profileCorner = Instance.new("UICorner")
    profileCorner.CornerRadius = UDim.new(0, 8)
    profileCorner.Parent = profileFrame

    local profileGradient = Instance.new("UIGradient")
    profileGradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, ModernUI.Colors.Primary),
        ColorSequenceKeypoint.new(1, ModernUI.Colors.Secondary)
    }
    profileGradient.Transparency = NumberSequence.new{
        NumberSequenceKeypoint.new(0, 0.8),
        NumberSequenceKeypoint.new(1, 0.9)
    }
    profileGradient.Parent = profileFrame

    local avatar = Instance.new("ImageLabel")
    avatar.Name = "Avatar"
    avatar.Parent = profileFrame
    avatar.BackgroundColor3 = ModernUI.Colors.Hover
    avatar.Position = UDim2.new(0, 10, 0, 10)
    avatar.Size = UDim2.new(0, 50, 0, 50)
    avatar.Image = "rbxthumb://type=AvatarHeadShot&id=" .. LocalPlayer.UserId .. "&w=420&h=420"
    avatar.BorderSizePixel = 0

    local avatarCorner = Instance.new("UICorner")
    avatarCorner.CornerRadius = UDim.new(0, 6)
    avatarCorner.Parent = avatar

    local playerName = Instance.new("TextLabel")
    playerName.Name = "PlayerName"
    playerName.Parent = profileFrame
    playerName.BackgroundTransparency = 1
    playerName.Position = UDim2.new(0, 70, 0, 10)
    playerName.Size = UDim2.new(0, 100, 0, 20)
    playerName.Font = Enum.Font.GothamBold
    playerName.Text = LocalPlayer.Name
    playerName.TextColor3 = ModernUI.Colors.Text
    playerName.TextSize = 12
    playerName.TextXAlignment = Enum.TextXAlignment.Left

    local playerStatus = Instance.new("TextLabel")
    playerStatus.Name = "Status"
    playerStatus.Parent = profileFrame
    playerStatus.BackgroundTransparency = 1
    playerStatus.Position = UDim2.new(0, 70, 0, 32)
    playerStatus.Size = UDim2.new(0, 100, 0, 15)
    playerStatus.Font = Enum.Font.Gotham
    playerStatus.Text = "Premium • Lifetime"
    playerStatus.TextColor3 = ModernUI.Colors.Accent
    playerStatus.TextSize = 10
    playerStatus.TextXAlignment = Enum.TextXAlignment.Left

    -- Content Area
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "Content"
    contentFrame.Parent = mainFrame
    contentFrame.BackgroundColor3 = ModernUI.Colors.Background
    contentFrame.Position = UDim2.new(0, 200, 0, 60)
    contentFrame.Size = UDim2.new(0, 700, 0, 640)
    contentFrame.BorderSizePixel = 0

    local contentCorner = Instance.new("UICorner")
    contentCorner.CornerRadius = UDim.new(0, 12)
    contentCorner.Parent = contentFrame

    local contentScroll = Instance.new("ScrollingFrame")
    contentScroll.Name = "Scroll"
    contentScroll.Parent = contentFrame
    contentScroll.BackgroundTransparency = 1
    contentScroll.Position = UDim2.new(0, 0, 0, 0)
    contentScroll.Size = UDim2.new(1, 0, 1, 0)
    contentScroll.ScrollBarThickness = 4
    contentScroll.ScrollBarImageColor3 = ModernUI.Colors.Primary
    contentScroll.CanvasSize = UDim2.new(0, 0, 0, 0)

    local contentLayout = Instance.new("UIListLayout")
    contentLayout.Parent = contentScroll
    contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    contentLayout.Padding = UDim.new(0, 12)

    local contentPadding = Instance.new("UIPadding")
    contentPadding.PaddingLeft = UDim.new(0, 15)
    contentPadding.PaddingRight = UDim.new(0, 15)
    contentPadding.PaddingTop = UDim.new(0, 15)
    contentPadding.PaddingBottom = UDim.new(0, 15)
    contentPadding.Parent = contentScroll

    MakeDraggable(mainFrame, header)

    local tabs = {}
    local currentTab = nil

    function tabs:CreateTab(name, icon)
        local tabButton = Instance.new("TextButton")
        tabButton.Name = name
        tabButton.Parent = tabContainer
        tabButton.BackgroundColor3 = ModernUI.Colors.Background
        tabButton.Size = UDim2.new(1, -20, 0, 45)
        tabButton.AutoButtonColor = false
        tabButton.BorderSizePixel = 0
        tabButton.Text = ""

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 8)
        tabCorner.Parent = tabButton

        local tabIcon = Instance.new("TextLabel")
        tabIcon.Name = "Icon"
        tabIcon.Parent = tabButton
        tabIcon.BackgroundTransparency = 1
        tabIcon.Position = UDim2.new(0, 10, 0, 10)
        tabIcon.Size = UDim2.new(0, 25, 0, 25)
        tabIcon.Font = Enum.Font.GothamBold
        tabIcon.Text = icon
        tabIcon.TextSize = 16

        local tabLabel = Instance.new("TextLabel")
        tabLabel.Name = "Label"
        tabLabel.Parent = tabButton
        tabLabel.BackgroundTransparency = 1
        tabLabel.Position = UDim2.new(0, 45, 0, 10)
        tabLabel.Size = UDim2.new(0, 130, 0, 25)
        tabLabel.Font = Enum.Font.Gotham
        tabLabel.Text = name
        tabLabel.TextColor3 = ModernUI.Colors.TextSecondary
        tabLabel.TextSize = 13
        tabLabel.TextXAlignment = Enum.TextXAlignment.Left

        local tabContent = Instance.new("Frame")
        tabContent.Name = "Content_" .. name
        tabContent.Parent = contentScroll
        tabContent.BackgroundTransparency = 1
        tabContent.Size = UDim2.new(1, -30, 0, 0)
        tabContent.Visible = false

        local tabContentLayout = Instance.new("UIListLayout")
        tabContentLayout.Parent = tabContent
        tabContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        tabContentLayout.Padding = UDim.new(0, 10)

        tabButton.MouseEnter:Connect(function()
            if currentTab ~= tabButton then
                Tween(tabButton, 0.2, {BackgroundColor3 = ModernUI.Colors.Hover})
                Tween(tabLabel, 0.2, {TextColor3 = ModernUI.Colors.Text})
            end
        end)

        tabButton.MouseLeave:Connect(function()
            if currentTab ~= tabButton then
                Tween(tabButton, 0.2, {BackgroundColor3 = ModernUI.Colors.Background})
                Tween(tabLabel, 0.2, {TextColor3 = ModernUI.Colors.TextSecondary})
            end
        end)

        tabButton.MouseButton1Click:Connect(function()
            if currentTab then
                Tween(currentTab, 0.2, {BackgroundColor3 = ModernUI.Colors.Background})
                currentTab:FindFirstChild("Label").TextColor3 = ModernUI.Colors.TextSecondary
                for _, v in pairs(contentScroll:GetChildren()) do
                    if v:IsA("Frame") and v.Name:match("Content_") then
                        v.Visible = false
                    end
                end
            end

            currentTab = tabButton
            Tween(tabButton, 0.2, {BackgroundColor3 = ModernUI.Colors.Surface})
            Tween(tabLabel, 0.2, {TextColor3 = ModernUI.Colors.Primary})
            tabContent.Visible = true
            contentScroll.CanvasSize = UDim2.new(0, 0, 0, tabContentLayout.AbsoluteContentSize.Y + 30)
        end)

        local items = {}

        function items:Button(text, callback)
            local button = Instance.new("TextButton")
            button.Name = "Button"
            button.Parent = tabContent
            button.BackgroundColor3 = ModernUI.Colors.Surface
            button.Size = UDim2.new(1, 0, 0, 45)
            button.AutoButtonColor = false
            button.BorderSizePixel = 0
            button.Font = Enum.Font.Gotham
            button.Text = text
            button.TextColor3 = ModernUI.Colors.Text
            button.TextSize = 13

            local buttonCorner = Instance.new("UICorner")
            buttonCorner.CornerRadius = UDim.new(0, 8)
            buttonCorner.Parent = button

            local buttonGradient = Instance.new("UIGradient")
            buttonGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, ModernUI.Colors.Surface),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 40))
            }
            buttonGradient.Parent = button

            button.MouseEnter:Connect(function()
                Tween(button, 0.2, {BackgroundColor3 = ModernUI.Colors.Hover})
            end)

            button.MouseLeave:Connect(function()
                Tween(button, 0.2, {BackgroundColor3 = ModernUI.Colors.Surface})
            end)

            button.MouseButton1Click:Connect(function()
                pcall(callback)
            end)

            tabContentLayout.Parent = tabContent
            contentScroll.CanvasSize = UDim2.new(0, 0, 0, tabContentLayout.AbsoluteContentSize.Y + 30)
        end

        function items:Toggle(text, default, callback)
            local toggle = Instance.new("TextButton")
            toggle.Name = "Toggle"
            toggle.Parent = tabContent
            toggle.BackgroundColor3 = ModernUI.Colors.Surface
            toggle.Size = UDim2.new(1, 0, 0, 45)
            toggle.AutoButtonColor = false
            toggle.BorderSizePixel = 0
            toggle.Text = ""

            local toggleCorner = Instance.new("UICorner")
            toggleCorner.CornerRadius = UDim.new(0, 8)
            toggleCorner.Parent = toggle

            local toggleGradient = Instance.new("UIGradient")
            toggleGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, ModernUI.Colors.Surface),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(25, 25, 40))
            }
            toggleGradient.Parent = toggle

            local label = Instance.new("TextLabel")
            label.Name = "Label"
            label.Parent = toggle
            label.BackgroundTransparency = 1
            label.Position = UDim2.new(0, 15, 0, 10)
            label.Size = UDim2.new(0, 400, 0, 25)
            label.Font = Enum.Font.Gotham
            label.Text = text
            label.TextColor3 = ModernUI.Colors.Text
            label.TextSize = 13
            label.TextXAlignment = Enum.TextXAlignment.Left

            local toggleSwitch = Instance.new("Frame")
            toggleSwitch.Name = "Switch"
            toggleSwitch.Parent = toggle
            toggleSwitch.BackgroundColor3 = ModernUI.Colors.Hover
            toggleSwitch.Position = UDim2.new(0, 620, 0, 12)
            toggleSwitch.Size = UDim2.new(0, 50, 0, 21)
            toggleSwitch.BorderSizePixel = 0

            local switchCorner = Instance.new("UICorner")
            switchCorner.CornerRadius = UDim.new(1, 0)
            switchCorner.Parent = toggleSwitch

            local dot = Instance.new("Frame")
            dot.Name = "Dot"
            dot.Parent = toggleSwitch
            dot.BackgroundColor3 = ModernUI.Colors.Text
            dot.Position = UDim2.new(0, 2, 0, 2)
            dot.Size = UDim2.new(0, 17, 0, 17)
            dot.BorderSizePixel = 0

            local dotCorner = Instance.new("UICorner")
            dotCorner.CornerRadius = UDim.new(1, 0)
            dotCorner.Parent = dot

            local toggled = default or false

            local function updateToggle()
                if toggled then
                    Tween(toggleSwitch, 0.3, {BackgroundColor3 = ModernUI.Colors.Primary})
                    Tween(dot, 0.3, {Position = UDim2.new(0, 31, 0, 2)})
                else
                    Tween(toggleSwitch, 0.3, {BackgroundColor3 = ModernUI.Colors.Hover})
                    Tween(dot, 0.3, {Position = UDim2.new(0, 2, 0, 2)})
                end
            end

            if toggled then
                updateToggle()
                pcall(callback, toggled)
            end

            toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                updateToggle()
                pcall(callback, toggled)
            end)

            toggle.MouseEnter:Connect(function()
                Tween(toggle, 0.2, {BackgroundColor3 = Color3.fromRGB(28, 28, 42)})
            end)

            toggle.MouseLeave:Connect(function()
                Tween(toggle, 0.2, {BackgroundColor3 = ModernUI.Colors.Surface})
            end)

            tabContentLayout.Parent = tabContent
            contentScroll.CanvasSize = UDim2.new(0, 0, 0, tabContentLayout.AbsoluteContentSize.Y + 30)
        end

        return items
    end

    return tabs
end

local ui = ModernUI:CreateWindow("RYSA CHEAT")
local tabs = ui

-- Tabs
local settings = tabs:CreateTab("Settings", "⚙️")
settings:Button("Test Button", function()
    print("Settings Test")
end)
settings:Toggle("Enable Feature", false, function(state)
    print("Feature:", state)
end)

local executor = tabs:CreateTab("Lua Executor", "💻")
executor:Button("Execute Script", function()
    print("Executor")
end)

local local_tab = tabs:CreateTab("Local", "👤")
local_tab:Button("Local Features", function()
    print("Local")
end)

local players = tabs:CreateTab("Players", "👥")
players:Button("Player List", function()
    print("Players")
end)

local server = tabs:CreateTab("Server", "🌐")
server:Button("Server Info", function()
    print("Server")
end)

local misc = tabs:CreateTab("Misc", "🎮")
misc:Button("Miscellaneous", function()
    print("Misc")
end)

-- Menu Toggle
local menuOpen = true
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.End then
        menuOpen = not menuOpen
        screenGui.Enabled = menuOpen
    end
end)

print("✅ RYSA CHEAT - BAŞLANDI")
print("Menü: End tuşu")
