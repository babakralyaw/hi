--[[
    ╔════════════════════════════════════════════════════════════════════╗
    ║                      RYSA CHEAT v2.0                              ║
    ║              Roblox Executor Compatible Cheat                      ║
    ║        ESP | Aimbot | Wallshot | BunnyHop | Full Features          ║
    ╚════════════════════════════════════════════════════════════════════╝
]]

if getgenv().RysaCheat then
    getgenv().RysaCheat:Destroy()
end

local RysaCheat = {}
getgenv().RysaCheat = RysaCheat

--// Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

--// Variables
local ESPObjects = {}
local FriendList = {}
local MenuOpen = true
local SelectedTab = 1
local Connections = {}
local TabOffset = 0

--// Settings
RysaCheat.Settings = {
    Enabled = true,
    AimbotEnabled = false,
    ESPEnabled = true,
    NoClipEnabled = false,
    BunnyHopEnabled = false,
    
    TeamCheck = false,
    AliveCheck = true,
    
    MaxDistance = 500,
    LockPart = "Head",
    MenuKey = Enum.KeyCode.End
}

--// ESP Settings
RysaCheat.ESPSettings = {
    BoxEnabled = true,
    BoxColor = Color3.fromRGB(0, 255, 0),
    BoxThickness = 2,
    
    NameEnabled = true,
    NameColor = Color3.fromRGB(255, 255, 255),
    NameSize = 13,
    
    HealthEnabled = true,
    HealthBarWidth = 50,
    HealthBarHeight = 4,
    
    DistanceEnabled = true,
    DistanceColor = Color3.fromRGB(200, 200, 200),
    DistanceSize = 11,
    
    ChineseHatEnabled = true,
    ChineseHatColor = Color3.fromRGB(255, 200, 0),
    ChineseHatSize = 30,
    
    EnemyColor = Color3.fromRGB(255, 0, 0),
    AllyColor = Color3.fromRGB(0, 255, 0),
    FriendColor = Color3.fromRGB(0, 150, 255),
    
    OutlineColor = Color3.fromRGB(0, 0, 0)
}

--// FOV Settings
RysaCheat.FOVSettings = {
    Enabled = true,
    Visible = true,
    Amount = 150,
    Color = Color3.fromRGB(0, 255, 0),
    LockedColor = Color3.fromRGB(255, 0, 0),
    Transparency = 0.5,
    Sides = 60,
    Thickness = 2,
    Filled = false
}

--// Aimbot Settings
RysaCheat.AimbotSettings = {
    Enabled = false,
    Smoothing = 0.15,
    Prediction = true,
    PredictionAmount = 0.5,
    IgnoreFriends = true
}

--// BunnyHop Settings
RysaCheat.BunnyHopSettings = {
    Enabled = false,
    Speed = 50,
    Height = 50,
    AutoHop = true
}

--// Advanced Settings
RysaCheat.AdvancedSettings = {
    ShowHeadDots = true,
    HeadDotSize = 4,
    HeadDotColor = Color3.fromRGB(255, 255, 0),
    CullDistance = 1000,
    ShowFPS = true
}

--// Menu Settings
RysaCheat.MenuSettings = {
    MenuPosition = UDim2.new(0, 20, 0, 20),
    MenuSize = UDim2.new(0, 280, 0, 650),
    MenuColor = Color3.fromRGB(15, 15, 25),
    MenuTransparency = 0.1,
    AccentColor = Color3.fromRGB(0, 150, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    TabColor = Color3.fromRGB(25, 25, 40),
    TabActiveColor = Color3.fromRGB(0, 150, 255)
}

--// FOV Circle
RysaCheat.FOVCircle = Drawing.new("Circle")

--// Menu UI
local MenuUI = {
    MainFrame = nil,
    Elements = {},
    FPS = nil,
    LastFPS = 0,
    FPSCounter = 0,
    TabButtons = {},
    TabContents = {}
}

--// Create Professional Menu
local function CreateMenu()
    local MenuX = RysaCheat.MenuSettings.MenuPosition.X.Offset
    local MenuY = RysaCheat.MenuSettings.MenuPosition.Y.Offset
    local MenuW = RysaCheat.MenuSettings.MenuSize.X.Offset
    local MenuH = RysaCheat.MenuSettings.MenuSize.Y.Offset
    
    -- Main Frame
    local MainFrame = Drawing.new("Square")
    MainFrame.Size = RysaCheat.MenuSettings.MenuSize
    MainFrame.Position = RysaCheat.MenuSettings.MenuPosition
    MainFrame.Color = RysaCheat.MenuSettings.MenuColor
    MainFrame.Filled = true
    MainFrame.Transparency = RysaCheat.MenuSettings.MenuTransparency
    MainFrame.Thickness = 1
    MainFrame.BorderColor = RysaCheat.MenuSettings.AccentColor
    
    MenuUI.MainFrame = MainFrame
    table.insert(MenuUI.Elements, MainFrame)
    
    -- Header Background
    local HeaderBG = Drawing.new("Square")
    HeaderBG.Size = Vector2.new(MenuW, 40)
    HeaderBG.Position = Vector2.new(MenuX, MenuY)
    HeaderBG.Color = Color3.fromRGB(10, 10, 20)
    HeaderBG.Filled = true
    HeaderBG.Thickness = 0
    
    table.insert(MenuUI.Elements, HeaderBG)
    
    -- Header Text
    local Header = Drawing.new("Text")
    Header.Text = "RYSA CHEAT"
    Header.Size = 18
    Header.Color = RysaCheat.MenuSettings.AccentColor
    Header.Position = Vector2.new(MenuX + 10, MenuY + 8)
    Header.Center = false
    Header.Outline = true
    Header.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(MenuUI.Elements, Header)
    
    -- FPS Counter
    local FPS = Drawing.new("Text")
    FPS.Size = 11
    FPS.Color = Color3.fromRGB(0, 255, 0)
    FPS.Position = Vector2.new(MenuX + MenuW - 50, MenuY + 10)
    FPS.Center = false
    FPS.Outline = true
    FPS.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    MenuUI.FPS = FPS
    table.insert(MenuUI.Elements, FPS)
    
    -- Separator Line
    local Sep1 = Drawing.new("Line")
    Sep1.From = Vector2.new(MenuX, MenuY + 40)
    Sep1.To = Vector2.new(MenuX + MenuW, MenuY + 40)
    Sep1.Color = RysaCheat.MenuSettings.AccentColor
    Sep1.Thickness = 1
    
    table.insert(MenuUI.Elements, Sep1)
    
    -- Tab Buttons
    local Tabs = {"AIMBOT", "ESP", "MISC", "FRIENDS"}
    local TabWidth = (MenuW - 4) / 4
    
    for i, TabName in ipairs(Tabs) do
        local TabBtn = Drawing.new("Square")
        TabBtn.Size = Vector2.new(TabWidth, 30)
        TabBtn.Position = Vector2.new(MenuX + 2 + (i-1) * TabWidth, MenuY + 42)
        TabBtn.Color = i == 1 and RysaCheat.MenuSettings.TabActiveColor or RysaCheat.MenuSettings.TabColor
        TabBtn.Filled = true
        TabBtn.Thickness = 0
        
        table.insert(MenuUI.Elements, TabBtn)
        table.insert(MenuUI.TabButtons, {Button = TabBtn, Name = TabName, Index = i})
        
        local TabText = Drawing.new("Text")
        TabText.Text = TabName
        TabText.Size = 12
        TabText.Color = Color3.fromRGB(255, 255, 255)
        TabText.Position = Vector2.new(MenuX + 2 + (i-1) * TabWidth + TabWidth/2, MenuY + 50)
        TabText.Center = true
        TabText.Outline = true
        TabText.OutlineColor = Color3.fromRGB(0, 0, 0)
        
        table.insert(MenuUI.Elements, TabText)
    end
    
    -- Separator Line 2
    local Sep2 = Drawing.new("Line")
    Sep2.From = Vector2.new(MenuX, MenuY + 74)
    Sep2.To = Vector2.new(MenuX + MenuW, MenuY + 74)
    Sep2.Color = RysaCheat.MenuSettings.AccentColor
    Sep2.Thickness = 1
    
    table.insert(MenuUI.Elements, Sep2)
    
    -- Content Area Background
    local ContentBG = Drawing.new("Square")
    ContentBG.Size = Vector2.new(MenuW - 4, MenuH - 80)
    ContentBG.Position = Vector2.new(MenuX + 2, MenuY + 76)
    ContentBG.Color = Color3.fromRGB(20, 20, 35)
    ContentBG.Filled = true
    ContentBG.Thickness = 0
    
    table.insert(MenuUI.Elements, ContentBG)
    
    -- AIMBOT Tab Content
    local AimbotContent = {}
    
    local AimbotTitle = Drawing.new("Text")
    AimbotTitle.Text = "AIMBOT"
    AimbotTitle.Size = 14
    AimbotTitle.Color = RysaCheat.MenuSettings.AccentColor
    AimbotTitle.Position = Vector2.new(MenuX + 15, MenuY + 85)
    AimbotTitle.Center = false
    AimbotTitle.Outline = true
    AimbotTitle.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(AimbotContent, AimbotTitle)
    
    local AimbotStatus = Drawing.new("Text")
    AimbotStatus.Text = "Status: " .. (RysaCheat.AimbotSettings.Enabled and "ON" or "OFF")
    AimbotStatus.Size = 12
    AimbotStatus.Color = RysaCheat.AimbotSettings.Enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    AimbotStatus.Position = Vector2.new(MenuX + 15, MenuY + 105)
    AimbotStatus.Center = false
    AimbotStatus.Outline = true
    AimbotStatus.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(AimbotContent, AimbotStatus)
    
    local SmoothText = Drawing.new("Text")
    SmoothText.Text = "Smoothing: " .. string.format("%.2f", RysaCheat.AimbotSettings.Smoothing)
    SmoothText.Size = 11
    SmoothText.Color = RysaCheat.MenuSettings.TextColor
    SmoothText.Position = Vector2.new(MenuX + 15, MenuY + 120)
    SmoothText.Center = false
    SmoothText.Outline = true
    SmoothText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(AimbotContent, SmoothText)
    
    local PredText = Drawing.new("Text")
    PredText.Text = "Prediction: " .. (RysaCheat.AimbotSettings.Prediction and "ON" or "OFF")
    PredText.Size = 11
    PredText.Color = RysaCheat.MenuSettings.TextColor
    PredText.Position = Vector2.new(MenuX + 15, MenuY + 135)
    PredText.Center = false
    PredText.Outline = true
    PredText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(AimbotContent, PredText)
    
    local IgnoreFriendsText = Drawing.new("Text")
    IgnoreFriendsText.Text = "Ignore Friends: " .. (RysaCheat.AimbotSettings.IgnoreFriends and "ON" or "OFF")
    IgnoreFriendsText.Size = 11
    IgnoreFriendsText.Color = RysaCheat.MenuSettings.TextColor
    IgnoreFriendsText.Position = Vector2.new(MenuX + 15, MenuY + 150)
    IgnoreFriendsText.Center = false
    IgnoreFriendsText.Outline = true
    IgnoreFriendsText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(AimbotContent, IgnoreFriendsText)
    
    -- ESP Tab Content
    local ESPContent = {}
    
    local ESPTitle = Drawing.new("Text")
    ESPTitle.Text = "ESP"
    ESPTitle.Size = 14
    ESPTitle.Color = RysaCheat.MenuSettings.AccentColor
    ESPTitle.Position = Vector2.new(MenuX + 15, MenuY + 85)
    ESPTitle.Center = false
    ESPTitle.Outline = true
    ESPTitle.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(ESPContent, ESPTitle)
    
    local ESPStatus = Drawing.new("Text")
    ESPStatus.Text = "Status: " .. (RysaCheat.Settings.ESPEnabled and "ON" or "OFF")
    ESPStatus.Size = 12
    ESPStatus.Color = RysaCheat.Settings.ESPEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    ESPStatus.Position = Vector2.new(MenuX + 15, MenuY + 105)
    ESPStatus.Center = false
    ESPStatus.Outline = true
    ESPStatus.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(ESPContent, ESPStatus)
    
    local BoxText = Drawing.new("Text")
    BoxText.Text = "Box: " .. (RysaCheat.ESPSettings.BoxEnabled and "ON" or "OFF")
    BoxText.Size = 11
    BoxText.Color = RysaCheat.MenuSettings.TextColor
    BoxText.Position = Vector2.new(MenuX + 15, MenuY + 120)
    BoxText.Center = false
    BoxText.Outline = true
    BoxText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(ESPContent, BoxText)
    
    local NameText = Drawing.new("Text")
    NameText.Text = "Names: " .. (RysaCheat.ESPSettings.NameEnabled and "ON" or "OFF")
    NameText.Size = 11
    NameText.Color = RysaCheat.MenuSettings.TextColor
    NameText.Position = Vector2.new(MenuX + 15, MenuY + 135)
    NameText.Center = false
    NameText.Outline = true
    NameText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(ESPContent, NameText)
    
    local HealthText = Drawing.new("Text")
    HealthText.Text = "Health: " .. (RysaCheat.ESPSettings.HealthEnabled and "ON" or "OFF")
    HealthText.Size = 11
    HealthText.Color = RysaCheat.MenuSettings.TextColor
    HealthText.Position = Vector2.new(MenuX + 15, MenuY + 150)
    HealthText.Center = false
    HealthText.Outline = true
    HealthText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(ESPContent, HealthText)
    
    local HatText = Drawing.new("Text")
    HatText.Text = "Chinese Hat: " .. (RysaCheat.ESPSettings.ChineseHatEnabled and "ON" or "OFF")
    HatText.Size = 11
    HatText.Color = RysaCheat.MenuSettings.TextColor
    HatText.Position = Vector2.new(MenuX + 15, MenuY + 165)
    HatText.Center = false
    HatText.Outline = true
    HatText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(ESPContent, HatText)
    
    -- MISC Tab Content
    local MiscContent = {}
    
    local MiscTitle = Drawing.new("Text")
    MiscTitle.Text = "MISC"
    MiscTitle.Size = 14
    MiscTitle.Color = RysaCheat.MenuSettings.AccentColor
    MiscTitle.Position = Vector2.new(MenuX + 15, MenuY + 85)
    MiscTitle.Center = false
    MiscTitle.Outline = true
    MiscTitle.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(MiscContent, MiscTitle)
    
    local NoClipText = Drawing.new("Text")
    NoClipText.Text = "NoClip: " .. (RysaCheat.Settings.NoClipEnabled and "ON" or "OFF")
    NoClipText.Size = 12
    NoClipText.Color = RysaCheat.Settings.NoClipEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    NoClipText.Position = Vector2.new(MenuX + 15, MenuY + 105)
    NoClipText.Center = false
    NoClipText.Outline = true
    NoClipText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(MiscContent, NoClipText)
    
    local BunnyHopText = Drawing.new("Text")
    BunnyHopText.Text = "BunnyHop: " .. (RysaCheat.Settings.BunnyHopEnabled and "ON" or "OFF")
    BunnyHopText.Size = 12
    BunnyHopText.Color = RysaCheat.Settings.BunnyHopEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    BunnyHopText.Position = Vector2.new(MenuX + 15, MenuY + 120)
    BunnyHopText.Center = false
    BunnyHopText.Outline = true
    BunnyHopText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(MiscContent, BunnyHopText)
    
    local FOVText = Drawing.new("Text")
    FOVText.Text = "FOV: " .. RysaCheat.FOVSettings.Amount
    FOVText.Size = 11
    FOVText.Color = RysaCheat.MenuSettings.TextColor
    FOVText.Position = Vector2.new(MenuX + 15, MenuY + 135)
    FOVText.Center = false
    FOVText.Outline = true
    FOVText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(MiscContent, FOVText)
    
    local BunnySpeedText = Drawing.new("Text")
    BunnySpeedText.Text = "BunnyHop Speed: " .. RysaCheat.BunnyHopSettings.Speed
    BunnySpeedText.Size = 11
    BunnySpeedText.Color = RysaCheat.MenuSettings.TextColor
    BunnySpeedText.Position = Vector2.new(MenuX + 15, MenuY + 150)
    BunnySpeedText.Center = false
    BunnySpeedText.Outline = true
    BunnySpeedText.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(MiscContent, BunnySpeedText)
    
    -- FRIENDS Tab Content
    local FriendsContent = {}
    
    local FriendsTitle = Drawing.new("Text")
    FriendsTitle.Text = "FRIENDS"
    FriendsTitle.Size = 14
    FriendsTitle.Color = RysaCheat.MenuSettings.AccentColor
    FriendsTitle.Position = Vector2.new(MenuX + 15, MenuY + 85)
    FriendsTitle.Center = false
    FriendsTitle.Outline = true
    FriendsTitle.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(FriendsContent, FriendsTitle)
    
    local FriendsInfo = Drawing.new("Text")
    FriendsInfo.Text = "Friends: " .. (next(FriendList) and "Yes" or "None")
    FriendsInfo.Size = 12
    FriendsInfo.Color = RysaCheat.MenuSettings.TextColor
    FriendsInfo.Position = Vector2.new(MenuX + 15, MenuY + 105)
    FriendsInfo.Center = false
    FriendsInfo.Outline = true
    FriendsInfo.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(FriendsContent, FriendsInfo)
    
    local CmdInfo = Drawing.new("Text")
    CmdInfo.Text = "Use commands:"
    CmdInfo.Size = 11
    CmdInfo.Color = Color3.fromRGB(150, 150, 255)
    CmdInfo.Position = Vector2.new(MenuX + 15, MenuY + 125)
    CmdInfo.Center = false
    CmdInfo.Outline = true
    CmdInfo.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(FriendsContent, CmdInfo)
    
    local Cmd1 = Drawing.new("Text")
    Cmd1.Text = "AddFriend(name)"
    Cmd1.Size = 10
    Cmd1.Color = Color3.fromRGB(200, 200, 255)
    Cmd1.Position = Vector2.new(MenuX + 20, MenuY + 140)
    Cmd1.Center = false
    Cmd1.Outline = true
    Cmd1.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(FriendsContent, Cmd1)
    
    local Cmd2 = Drawing.new("Text")
    Cmd2.Text = "RemoveFriend(name)"
    Cmd2.Size = 10
    Cmd2.Color = Color3.fromRGB(200, 200, 255)
    Cmd2.Position = Vector2.new(MenuX + 20, MenuY + 153)
    Cmd2.Center = false
    Cmd2.Outline = true
    Cmd2.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    table.insert(FriendsContent, Cmd2)
    
    MenuUI.TabContents[1] = AimbotContent
    MenuUI.TabContents[2] = ESPContent
    MenuUI.TabContents[3] = MiscContent
    MenuUI.TabContents[4] = FriendsContent
    
    for i, Content in ipairs(MenuUI.TabContents) do
        for _, Element in ipairs(Content) do
            table.insert(MenuUI.Elements, Element)
            Element.Visible = (i == 1)
        end
    end
end

--// Create ESP Box
local function CreateESPBox(Player)
    if not Player.Character or not Player.Character:FindFirstChild("HumanoidRootPart") then
        return nil
    end
    
    local ESPBox = {
        NameLabel = Drawing.new("Text"),
        HealthBar = Drawing.new("Square"),
        HealthBarBG = Drawing.new("Square"),
        DistanceLabel = Drawing.new("Text"),
        BoxOutline = Drawing.new("Square"),
        BoxFill = Drawing.new("Square"),
        HeadDot = Drawing.new("Circle"),
        ChineseHat = Drawing.new("Circle"),
        Player = Player
    }
    
    ESPBox.NameLabel.Size = RysaCheat.ESPSettings.NameSize
    ESPBox.NameLabel.Color = RysaCheat.ESPSettings.NameColor
    ESPBox.NameLabel.Center = true
    ESPBox.NameLabel.Outline = true
    ESPBox.NameLabel.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    ESPBox.HealthBarBG.Color = Color3.fromRGB(50, 50, 50)
    ESPBox.HealthBarBG.Filled = true
    ESPBox.HealthBarBG.Thickness = 1
    
    ESPBox.HealthBar.Filled = true
    ESPBox.HealthBar.Thickness = 1
    
    ESPBox.DistanceLabel.Size = RysaCheat.ESPSettings.DistanceSize
    ESPBox.DistanceLabel.Color = RysaCheat.ESPSettings.DistanceColor
    ESPBox.DistanceLabel.Center = true
    ESPBox.DistanceLabel.Outline = true
    ESPBox.DistanceLabel.OutlineColor = Color3.fromRGB(0, 0, 0)
    
    ESPBox.BoxOutline.Filled = false
    ESPBox.BoxOutline.Thickness = RysaCheat.ESPSettings.BoxThickness
    ESPBox.BoxOutline.Color = RysaCheat.ESPSettings.OutlineColor
    
    ESPBox.BoxFill.Filled = false
    ESPBox.BoxFill.Thickness = RysaCheat.ESPSettings.BoxThickness
    
    ESPBox.HeadDot.Filled = true
    ESPBox.HeadDot.Radius = RysaCheat.AdvancedSettings.HeadDotSize
    ESPBox.HeadDot.Color = RysaCheat.AdvancedSettings.HeadDotColor
    
    ESPBox.ChineseHat.Filled = false
    ESPBox.ChineseHat.Radius = RysaCheat.ESPSettings.ChineseHatSize
    ESPBox.ChineseHat.Color = RysaCheat.ESPSettings.ChineseHatColor
    ESPBox.ChineseHat.Thickness = 2
    
    return ESPBox
end


--// Update ESP Box
local function UpdateESPBox(ESPBox)
    if not ESPBox.Player or not ESPBox.Player.Character then
        return false
    end
    
    local Character = ESPBox.Player.Character
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    local Head = Character:FindFirstChild("Head")
    
    if not HumanoidRootPart or not Humanoid then
        return false
    end
    
    local Distance = (Camera.CFrame.Position - HumanoidRootPart.Position).Magnitude
    if Distance > RysaCheat.AdvancedSettings.CullDistance then
        ESPBox.NameLabel.Visible = false
        ESPBox.HealthBar.Visible = false
        ESPBox.HealthBarBG.Visible = false
        ESPBox.DistanceLabel.Visible = false
        ESPBox.BoxOutline.Visible = false
        ESPBox.BoxFill.Visible = false
        ESPBox.HeadDot.Visible = false
        ESPBox.ChineseHat.Visible = false
        return true
    end
    
    if RysaCheat.Settings.TeamCheck and ESPBox.Player.Team == LocalPlayer.Team then
        ESPBox.NameLabel.Visible = false
        ESPBox.HealthBar.Visible = false
        ESPBox.HealthBarBG.Visible = false
        ESPBox.DistanceLabel.Visible = false
        ESPBox.BoxOutline.Visible = false
        ESPBox.BoxFill.Visible = false
        ESPBox.HeadDot.Visible = false
        ESPBox.ChineseHat.Visible = false
        return true
    end
    
    if RysaCheat.Settings.AliveCheck and Humanoid.Health <= 0 then
        ESPBox.NameLabel.Visible = false
        ESPBox.HealthBar.Visible = false
        ESPBox.HealthBarBG.Visible = false
        ESPBox.DistanceLabel.Visible = false
        ESPBox.BoxOutline.Visible = false
        ESPBox.BoxFill.Visible = false
        ESPBox.HeadDot.Visible = false
        ESPBox.ChineseHat.Visible = false
        return true
    end
    
    local Vector, OnScreen = Camera:WorldToViewportPoint(HumanoidRootPart.Position)
    
    if not OnScreen then
        ESPBox.NameLabel.Visible = false
        ESPBox.HealthBar.Visible = false
        ESPBox.HealthBarBG.Visible = false
        ESPBox.DistanceLabel.Visible = false
        ESPBox.BoxOutline.Visible = false
        ESPBox.BoxFill.Visible = false
        ESPBox.HeadDot.Visible = false
        ESPBox.ChineseHat.Visible = false
        return true
    end
    
    local IsFriend = FriendList[ESPBox.Player.Name] or false
    local IsEnemy = not RysaCheat.Settings.TeamCheck or ESPBox.Player.Team ~= LocalPlayer.Team
    local BoxColor
    
    if IsFriend then
        BoxColor = RysaCheat.ESPSettings.FriendColor
    elseif IsEnemy then
        BoxColor = RysaCheat.ESPSettings.EnemyColor
    else
        BoxColor = RysaCheat.ESPSettings.AllyColor
    end
    
    if RysaCheat.ESPSettings.BoxEnabled then
        local BoxSize = Vector2.new(50, 80)
        local BoxPosition = Vector2.new(Vector.X - BoxSize.X / 2, Vector.Y - BoxSize.Y / 2)
        
        ESPBox.BoxOutline.Size = BoxSize
        ESPBox.BoxOutline.Position = BoxPosition
        ESPBox.BoxOutline.Visible = true
        
        ESPBox.BoxFill.Size = BoxSize
        ESPBox.BoxFill.Position = BoxPosition
        ESPBox.BoxFill.Color = BoxColor
        ESPBox.BoxFill.Visible = true
    end
    
    if RysaCheat.ESPSettings.NameEnabled then
        local NameText = ESPBox.Player.Name
        if IsFriend then
            NameText = "★ " .. NameText .. " ★"
        end
        ESPBox.NameLabel.Text = NameText
        ESPBox.NameLabel.Position = Vector2.new(Vector.X, Vector.Y - 50)
        ESPBox.NameLabel.Visible = true
    end
    
    if RysaCheat.ESPSettings.HealthEnabled then
        local HealthPercent = Humanoid.Health / Humanoid.MaxHealth
        local BarWidth = RysaCheat.ESPSettings.HealthBarWidth
        
        ESPBox.HealthBarBG.Size = Vector2.new(BarWidth, RysaCheat.ESPSettings.HealthBarHeight)
        ESPBox.HealthBarBG.Position = Vector2.new(Vector.X - BarWidth / 2, Vector.Y + 45)
        ESPBox.HealthBarBG.Visible = true
        
        ESPBox.HealthBar.Size = Vector2.new(BarWidth * HealthPercent, RysaCheat.ESPSettings.HealthBarHeight)
        ESPBox.HealthBar.Position = Vector2.new(Vector.X - BarWidth / 2, Vector.Y + 45)
        ESPBox.HealthBar.Color = HealthPercent > 0.5 and Color3.fromRGB(0, 255, 0) or HealthPercent > 0.25 and Color3.fromRGB(255, 255, 0) or Color3.fromRGB(255, 0, 0)
        ESPBox.HealthBar.Visible = true
    end
    
    if RysaCheat.ESPSettings.DistanceEnabled then
        ESPBox.DistanceLabel.Text = string.format("%.0f m", Distance)
        ESPBox.DistanceLabel.Position = Vector2.new(Vector.X, Vector.Y + 60)
        ESPBox.DistanceLabel.Visible = true
    end
    
    if RysaCheat.AdvancedSettings.ShowHeadDots and Head then
        local HeadVector = Camera:WorldToViewportPoint(Head.Position)
        ESPBox.HeadDot.Position = Vector2.new(HeadVector.X, HeadVector.Y)
        ESPBox.HeadDot.Visible = true
    end
    
    if RysaCheat.ESPSettings.ChineseHatEnabled and Head then
        local HeadVector = Camera:WorldToViewportPoint(Head.Position)
        ESPBox.ChineseHat.Position = Vector2.new(HeadVector.X, HeadVector.Y)
        ESPBox.ChineseHat.Visible = true
    end
    
    return true
end

--// Remove ESP Box
local function RemoveESPBox(Player)
    if ESPObjects[Player] then
        for _, Drawing in pairs(ESPObjects[Player]) do
            if Drawing and Drawing.Remove then
                pcall(function() Drawing:Remove() end)
            end
        end
        ESPObjects[Player] = nil
    end
end

--// Clear All ESP
local function ClearAllESP()
    for Player, _ in next, ESPObjects do
        RemoveESPBox(Player)
    end
end

--// Get Closest Player
local function GetClosestPlayer()
    local ClosestPlayer = nil
    local ClosestDistance = RysaCheat.FOVSettings.Amount
    
    for _, Player in next, Players:GetPlayers() do
        if Player ~= LocalPlayer then
            if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                if RysaCheat.Settings.AliveCheck then
                    local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
                    if not Humanoid or Humanoid.Health <= 0 then continue end
                end
                
                if RysaCheat.Settings.TeamCheck and Player.Team == LocalPlayer.Team then
                    continue
                end
                
                if RysaCheat.AimbotSettings.IgnoreFriends and FriendList[Player.Name] then
                    continue
                end
                
                local Vector, OnScreen = Camera:WorldToViewportPoint(Player.Character.HumanoidRootPart.Position)
                if OnScreen then
                    local Distance = (Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y) - Vector2.new(Vector.X, Vector.Y)).Magnitude
                    if Distance < ClosestDistance then
                        ClosestDistance = Distance
                        ClosestPlayer = Player
                    end
                end
            end
        end
    end
    
    return ClosestPlayer
end

--// Aimbot Function
local function AimbotTick()
    if not RysaCheat.AimbotSettings.Enabled then
        RysaCheat.FOVCircle.Color = RysaCheat.FOVSettings.Color
        return
    end
    
    local TargetPlayer = GetClosestPlayer()
    if not TargetPlayer or not TargetPlayer.Character then
        RysaCheat.FOVCircle.Color = RysaCheat.FOVSettings.Color
        return
    end
    
    local TargetPart = TargetPlayer.Character:FindFirstChild(RysaCheat.Settings.LockPart)
    if not TargetPart then
        RysaCheat.FOVCircle.Color = RysaCheat.FOVSettings.Color
        return
    end
    
    local TargetPosition = TargetPart.Position
    if RysaCheat.AimbotSettings.Prediction then
        local Humanoid = TargetPlayer.Character:FindFirstChildOfClass("Humanoid")
        if Humanoid then
            TargetPosition = TargetPosition + (TargetPlayer.Character.HumanoidRootPart.Velocity * RysaCheat.AimbotSettings.PredictionAmount)
        end
    end
    
    local Direction = (TargetPosition - Camera.CFrame.Position).Unit
    local NewCFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + Direction)
    Camera.CFrame = Camera.CFrame:Lerp(NewCFrame, RysaCheat.AimbotSettings.Smoothing)
    
    RysaCheat.FOVCircle.Color = RysaCheat.FOVSettings.LockedColor
end

--// NoClip Function
local function NoClipTick()
    if not RysaCheat.Settings.NoClipEnabled or not LocalPlayer.Character then
        return
    end
    
    for _, Part in pairs(LocalPlayer.Character:GetDescendants()) do
        if Part:IsA("BasePart") then
            Part.CanCollide = false
        end
    end
end

--// BunnyHop Function
local function BunnyHopTick()
    if not RysaCheat.Settings.BunnyHopEnabled or not LocalPlayer.Character then
        return
    end
    
    local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    local HumanoidRootPart = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if not Humanoid or not HumanoidRootPart then
        return
    end
    
    if Humanoid:GetState() == Enum.HumanoidStateType.Landed then
        Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        
        local Direction = HumanoidRootPart.CFrame.LookVector
        HumanoidRootPart.Velocity = Direction * RysaCheat.BunnyHopSettings.Speed + Vector3.new(0, RysaCheat.BunnyHopSettings.Height, 0)
    end
end

--// Functions
function RysaCheat:ToggleAimbot()
    RysaCheat.AimbotSettings.Enabled = not RysaCheat.AimbotSettings.Enabled
    print(RysaCheat.AimbotSettings.Enabled and "✓ Aimbot Enabled" or "✗ Aimbot Disabled")
end

function RysaCheat:ToggleESP()
    RysaCheat.Settings.ESPEnabled = not RysaCheat.Settings.ESPEnabled
    print(RysaCheat.Settings.ESPEnabled and "✓ ESP Enabled" or "✗ ESP Disabled")
end

function RysaCheat:ToggleNoClip()
    RysaCheat.Settings.NoClipEnabled = not RysaCheat.Settings.NoClipEnabled
    print(RysaCheat.Settings.NoClipEnabled and "✓ NoClip Enabled" or "✗ NoClip Disabled")
end

function RysaCheat:ToggleBunnyHop()
    RysaCheat.Settings.BunnyHopEnabled = not RysaCheat.Settings.BunnyHopEnabled
    print(RysaCheat.Settings.BunnyHopEnabled and "✓ BunnyHop Enabled" or "✗ BunnyHop Disabled")
end

function RysaCheat:ToggleMenu()
    MenuOpen = not MenuOpen
    print(MenuOpen and "✓ Menu Opened" or "✗ Menu Closed")
end

function RysaCheat:SetMenuKey(KeyCode)
    RysaCheat.Settings.MenuKey = KeyCode
    print("✓ Menu key changed to: " .. tostring(KeyCode))
end

function RysaCheat:AddFriend(PlayerName)
    FriendList[PlayerName] = true
    print("✓ Added " .. PlayerName .. " to friend list")
end

function RysaCheat:RemoveFriend(PlayerName)
    FriendList[PlayerName] = nil
    print("✓ Removed " .. PlayerName .. " from friend list")
end

function RysaCheat:GetFriendList()
    return FriendList
end

function RysaCheat:Destroy()
    for _, Connection in pairs(Connections) do
        if Connection then
            pcall(function() Connection:Disconnect() end)
        end
    end
    
    ClearAllESP()
    
    for _, Element in pairs(MenuUI.Elements) do
        if Element and Element.Remove then
            pcall(function() Element:Remove() end)
        end
    end
    
    if RysaCheat.FOVCircle and RysaCheat.FOVCircle.Remove then
        pcall(function() RysaCheat.FOVCircle:Remove() end)
    end
    
    getgenv().RysaCheat = nil
end


--// Main Loop
local function Start()
    CreateMenu()
    
    table.insert(Connections, RunService.RenderStepped:Connect(function()
        -- FPS Counter
        MenuUI.FPSCounter = MenuUI.FPSCounter + 1
        if tick() % 1 < 0.016 then
            MenuUI.LastFPS = MenuUI.FPSCounter
            MenuUI.FPSCounter = 0
        end
        
        if MenuUI.FPS and RysaCheat.AdvancedSettings.ShowFPS then
            MenuUI.FPS.Text = "FPS: " .. MenuUI.LastFPS
            MenuUI.FPS.Visible = MenuOpen
        end
        
        -- FOV Circle
        if RysaCheat.FOVSettings.Enabled and RysaCheat.Settings.ESPEnabled then
            RysaCheat.FOVCircle.Radius = RysaCheat.FOVSettings.Amount
            RysaCheat.FOVCircle.Thickness = RysaCheat.FOVSettings.Thickness
            RysaCheat.FOVCircle.Filled = RysaCheat.FOVSettings.Filled
            RysaCheat.FOVCircle.NumSides = RysaCheat.FOVSettings.Sides
            RysaCheat.FOVCircle.Color = RysaCheat.FOVSettings.Color
            RysaCheat.FOVCircle.Transparency = RysaCheat.FOVSettings.Transparency
            RysaCheat.FOVCircle.Visible = RysaCheat.FOVSettings.Visible
            RysaCheat.FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
        else
            RysaCheat.FOVCircle.Visible = false
        end
        
        -- ESP
        if RysaCheat.Settings.ESPEnabled then
            for _, Player in next, Players:GetPlayers() do
                if Player ~= LocalPlayer then
                    if not ESPObjects[Player] then
                        ESPObjects[Player] = CreateESPBox(Player)
                    end
                    
                    if ESPObjects[Player] then
                        UpdateESPBox(ESPObjects[Player])
                    end
                end
            end
        else
            ClearAllESP()
        end
        
        -- Aimbot
        AimbotTick()
        
        -- NoClip
        if RysaCheat.Settings.NoClipEnabled then
            NoClipTick()
        end
        
        -- BunnyHop
        if RysaCheat.Settings.BunnyHopEnabled then
            BunnyHopTick()
        end
        
        -- Update Menu Visibility
        for _, Element in pairs(MenuUI.Elements) do
            if Element then
                Element.Visible = MenuOpen
            end
        end
    end))
    
    table.insert(Connections, Players.PlayerRemoving:Connect(function(Player)
        RemoveESPBox(Player)
    end))
    
    -- Tab Switching & Menu Toggle
    table.insert(Connections, UserInputService.InputBegan:Connect(function(Input, GameProcessed)
        if GameProcessed then return end
        
        -- Menu Toggle
        if Input.KeyCode == RysaCheat.Settings.MenuKey then
            MenuOpen = not MenuOpen
            print(MenuOpen and "✓ Menu Opened" or "✗ Menu Closed")
        end
        
        -- Tab Switching
        if Input.KeyCode == Enum.KeyCode.One then
            SelectedTab = 1
            for i, Content in ipairs(MenuUI.TabContents) do
                for _, Element in ipairs(Content) do
                    Element.Visible = (i == 1)
                end
            end
            for i, TabBtn in ipairs(MenuUI.TabButtons) do
                TabBtn.Button.Color = i == 1 and RysaCheat.MenuSettings.TabActiveColor or RysaCheat.MenuSettings.TabColor
            end
        elseif Input.KeyCode == Enum.KeyCode.Two then
            SelectedTab = 2
            for i, Content in ipairs(MenuUI.TabContents) do
                for _, Element in ipairs(Content) do
                    Element.Visible = (i == 2)
                end
            end
            for i, TabBtn in ipairs(MenuUI.TabButtons) do
                TabBtn.Button.Color = i == 2 and RysaCheat.MenuSettings.TabActiveColor or RysaCheat.MenuSettings.TabColor
            end
        elseif Input.KeyCode == Enum.KeyCode.Three then
            SelectedTab = 3
            for i, Content in ipairs(MenuUI.TabContents) do
                for _, Element in ipairs(Content) do
                    Element.Visible = (i == 3)
                end
            end
            for i, TabBtn in ipairs(MenuUI.TabButtons) do
                TabBtn.Button.Color = i == 3 and RysaCheat.MenuSettings.TabActiveColor or RysaCheat.MenuSettings.TabColor
            end
        elseif Input.KeyCode == Enum.KeyCode.Four then
            SelectedTab = 4
            for i, Content in ipairs(MenuUI.TabContents) do
                for _, Element in ipairs(Content) do
                    Element.Visible = (i == 4)
                end
            end
            for i, TabBtn in ipairs(MenuUI.TabButtons) do
                TabBtn.Button.Color = i == 4 and RysaCheat.MenuSettings.TabActiveColor or RysaCheat.MenuSettings.TabColor
            end
        end
    end))
end

--// Start
Start()

print("╔════════════════════════════════════════════════════════════╗")
print("║                 RYSA CHEAT v2.0 LOADED                    ║")
print("║                                                            ║")
print("║  MENU KEY: END (Değiştirilebilir)                          ║")
print("║                                                            ║")
print("║  COMMANDS:                                                 ║")
print("║  getgenv().RysaCheat:ToggleAimbot()                        ║")
print("║  getgenv().RysaCheat:ToggleESP()                           ║")
print("║  getgenv().RysaCheat:ToggleNoClip()                        ║")
print("║  getgenv().RysaCheat:ToggleBunnyHop()                      ║")
print("║  getgenv().RysaCheat:ToggleMenu()                          ║")
print("║  getgenv().RysaCheat:AddFriend('PlayerName')               ║")
print("║  getgenv().RysaCheat:RemoveFriend('PlayerName')            ║")
print("║  getgenv().RysaCheat:SetMenuKey(Enum.KeyCode.F1)           ║")
print("║                                                            ║")
print("║  TAB SWITCHING (In-Game):                                  ║")
print("║  Press 1 = AIMBOT                                          ║")
print("║  Press 2 = ESP                                             ║")
print("║  Press 3 = MISC                                            ║")
print("║  Press 4 = FRIENDS                                         ║")
print("║                                                            ║")
print("║  SETTINGS:                                                 ║")
print("║  getgenv().RysaCheat.Settings                              ║")
print("║  getgenv().RysaCheat.ESPSettings                           ║")
print("║  getgenv().RysaCheat.AimbotSettings                        ║")
print("║  getgenv().RysaCheat.BunnyHopSettings                      ║")
print("║  getgenv().RysaCheat.FOVSettings                           ║")
print("║                                                            ║")
print("╚════════════════════════════════════════════════════════════╝")
