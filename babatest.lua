--[[
    RYSA CHEAT v2.1 - FIXED
    Roblox Executor Compatible
]]

if getgenv().RysaCheat then
    getgenv().RysaCheat:Destroy()
end

local RysaCheat = {}
getgenv().RysaCheat = RysaCheat

-- Services
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

-- Variables
local ESPObjects = {}
local FriendList = {}
local MenuOpen = true
local Connections = {}

-- Settings
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

RysaCheat.AimbotSettings = {
    Enabled = false,
    Smoothing = 0.15,
    Prediction = true,
    PredictionAmount = 0.5,
    IgnoreFriends = true
}

RysaCheat.BunnyHopSettings = {
    Enabled = false,
    Speed = 50,
    Height = 50,
    AutoHop = true
}

RysaCheat.AdvancedSettings = {
    ShowHeadDots = true,
    HeadDotSize = 4,
    HeadDotColor = Color3.fromRGB(255, 255, 0),
    CullDistance = 1000,
    ShowFPS = true
}

RysaCheat.MenuSettings = {
    MenuPosition = UDim2.new(0, 20, 0, 20),
    MenuSize = UDim2.new(0, 280, 0, 400),
    MenuColor = Color3.fromRGB(15, 15, 25),
    MenuTransparency = 0.1,
    AccentColor = Color3.fromRGB(0, 150, 255),
    TextColor = Color3.fromRGB(255, 255, 255),
    TabColor = Color3.fromRGB(25, 25, 40),
    TabActiveColor = Color3.fromRGB(0, 150, 255)
}

-- FOV Circle
RysaCheat.FOVCircle = Drawing.new("Circle")
RysaCheat.FOVCircle.Radius = RysaCheat.FOVSettings.Amount
RysaCheat.FOVCircle.Color = RysaCheat.FOVSettings.Color
RysaCheat.FOVCircle.Transparency = RysaCheat.FOVSettings.Transparency
RysaCheat.FOVCircle.Thickness = RysaCheat.FOVSettings.Thickness
RysaCheat.FOVCircle.Filled = RysaCheat.FOVSettings.Filled
RysaCheat.FOVCircle.Visible = RysaCheat.FOVSettings.Visible

-- Menu UI
local MenuUI = {
    MainFrame = nil,
    Elements = {},
    FPS = nil,
    TabButtons = {},
    TabContents = {}
}

-- Create Menu
local function CreateMenu()
    local MenuX = 20
    local MenuY = 20
    local MenuW = 280
    local MenuH = 400
    
    -- Main Frame
    local MainFrame = Drawing.new("Square")
    MainFrame.Size = Vector2.new(MenuW, MenuH)
    MainFrame.Position = Vector2.new(MenuX, MenuY)
    MainFrame.Color = RysaCheat.MenuSettings.MenuColor
    MainFrame.Filled = true
    MainFrame.Transparency = RysaCheat.MenuSettings.MenuTransparency
    MainFrame.Thickness = 1
    MainFrame.BorderColor = RysaCheat.MenuSettings.AccentColor
    MainFrame.Visible = true
    
    MenuUI.MainFrame = MainFrame
    table.insert(MenuUI.Elements, MainFrame)
    
    -- Header
    local Header = Drawing.new("Text")
    Header.Text = "RYSA CHEAT v2.1"
    Header.Size = 16
    Header.Color = RysaCheat.MenuSettings.AccentColor
    Header.Position = Vector2.new(MenuX + 10, MenuY + 10)
    Header.Center = false
    Header.Outline = true
    Header.OutlineColor = Color3.fromRGB(0, 0, 0)
    Header.Visible = true
    
    table.insert(MenuUI.Elements, Header)
    
    -- Status Text
    local StatusText = Drawing.new("Text")
    StatusText.Text = "Status: LOADED"
    StatusText.Size = 12
    StatusText.Color = Color3.fromRGB(0, 255, 0)
    StatusText.Position = Vector2.new(MenuX + 10, MenuY + 35)
    StatusText.Center = false
    StatusText.Outline = true
    StatusText.OutlineColor = Color3.fromRGB(0, 0, 0)
    StatusText.Visible = true
    
    table.insert(MenuUI.Elements, StatusText)
    
    -- Separator
    local Sep = Drawing.new("Line")
    Sep.From = Vector2.new(MenuX, MenuY + 55)
    Sep.To = Vector2.new(MenuX + MenuW, MenuY + 55)
    Sep.Color = RysaCheat.MenuSettings.AccentColor
    Sep.Thickness = 1
    Sep.Visible = true
    
    table.insert(MenuUI.Elements, Sep)
    
    -- Options
    local Options = {
        {Text = "Aimbot: " .. (RysaCheat.AimbotSettings.Enabled and "ON" or "OFF"), Y = 70},
        {Text = "ESP: " .. (RysaCheat.Settings.ESPEnabled and "ON" or "OFF"), Y = 90},
        {Text = "NoClip: " .. (RysaCheat.Settings.NoClipEnabled and "ON" or "OFF"), Y = 110},
        {Text = "BunnyHop: " .. (RysaCheat.Settings.BunnyHopEnabled and "ON" or "OFF"), Y = 130},
        {Text = "FOV: " .. RysaCheat.FOVSettings.Amount, Y = 150},
        {Text = "", Y = 170},
        {Text = "Press END to toggle menu", Y = 190},
        {Text = "Press F1 for Aimbot", Y = 210},
        {Text = "Press F2 for ESP", Y = 230},
        {Text = "Press F3 for NoClip", Y = 250},
        {Text = "Press F4 for BunnyHop", Y = 270},
    }
    
    for _, opt in ipairs(Options) do
        local OptionText = Drawing.new("Text")
        OptionText.Text = opt.Text
        OptionText.Size = 11
        OptionText.Color = RysaCheat.MenuSettings.TextColor
        OptionText.Position = Vector2.new(MenuX + 15, MenuY + opt.Y)
        OptionText.Center = false
        OptionText.Outline = true
        OptionText.OutlineColor = Color3.fromRGB(0, 0, 0)
        OptionText.Visible = true
        
        table.insert(MenuUI.Elements, OptionText)
    end
end

-- Create ESP Box
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
    
    return ESPBox
end

-- Update ESP Box
local function UpdateESPBox(ESPBox)
    if not ESPBox.Player or not ESPBox.Player.Character then
        return false
    end
    
    local Character = ESPBox.Player.Character
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    
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
        return true
    end
    
    if RysaCheat.Settings.AliveCheck and Humanoid.Health <= 0 then
        ESPBox.NameLabel.Visible = false
        ESPBox.HealthBar.Visible = false
        ESPBox.HealthBarBG.Visible = false
        ESPBox.DistanceLabel.Visible = false
        ESPBox.BoxOutline.Visible = false
        ESPBox.BoxFill.Visible = false
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
        return true
    end
    
    local IsFriend = FriendList[ESPBox.Player.Name] or false
    local BoxColor = IsFriend and RysaCheat.ESPSettings.FriendColor or RysaCheat.ESPSettings.EnemyColor
    
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
        ESPBox.NameLabel.Text = ESPBox.Player.Name
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
        ESPBox.HealthBar.Color = HealthPercent > 0.5 and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        ESPBox.HealthBar.Visible = true
    end
    
    if RysaCheat.ESPSettings.DistanceEnabled then
        ESPBox.DistanceLabel.Text = string.format("%.0f m", Distance)
        ESPBox.DistanceLabel.Position = Vector2.new(Vector.X, Vector.Y + 60)
        ESPBox.DistanceLabel.Visible = true
    end
    
    return true
end

-- Remove ESP Box
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

-- Clear All ESP
local function ClearAllESP()
    for Player, _ in next, ESPObjects do
        RemoveESPBox(Player)
    end
end

-- Get Closest Player
local function GetClosestPlayer()
    local ClosestPlayer = nil
    local ClosestDistance = RysaCheat.FOVSettings.Amount
    
    for _, Player in next, Players:GetPlayers() do
        if Player ~= LocalPlayer and Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
            local Humanoid = Player.Character:FindFirstChildOfClass("Humanoid")
            if RysaCheat.Settings.AliveCheck and (not Humanoid or Humanoid.Health <= 0) then continue end
            
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
    
    return ClosestPlayer
end

-- Aimbot Tick
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

-- NoClip Tick
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

-- BunnyHop Tick
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

-- Functions
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
    for _, Element in ipairs(MenuUI.Elements) do
        Element.Visible = MenuOpen
    end
    print(MenuOpen and "✓ Menu Opened" or "✗ Menu Closed")
end

function RysaCheat:AddFriend(PlayerName)
    FriendList[PlayerName] = true
    print("✓ Added " .. PlayerName .. " to friend list")
end

function RysaCheat:RemoveFriend(PlayerName)
    FriendList[PlayerName] = nil
    print("✓ Removed " .. PlayerName .. " from friend list")
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

-- Input Handling
local InputConnection = UserInputService.InputBegan:Connect(function(Input, GameProcessed)
    if GameProcessed then return end
    
    if Input.KeyCode == Enum.KeyCode.End then
        RysaCheat:ToggleMenu()
    elseif Input.KeyCode == Enum.KeyCode.F1 then
        RysaCheat:ToggleAimbot()
    elseif Input.KeyCode == Enum.KeyCode.F2 then
        RysaCheat:ToggleESP()
    elseif Input.KeyCode == Enum.KeyCode.F3 then
        RysaCheat:ToggleNoClip()
    elseif Input.KeyCode == Enum.KeyCode.F4 then
        RysaCheat:ToggleBunnyHop()
    end
end)

table.insert(Connections, InputConnection)

-- Main Render Loop
local RenderConnection = RunService.RenderStepped:Connect(function()
    -- Update FOV Circle
    if RysaCheat.FOVSettings.Visible then
        RysaCheat.FOVCircle.Position = Vector2.new(UserInputService:GetMouseLocation().X, UserInputService:GetMouseLocation().Y)
    end
    
    -- Update Aimbot
    AimbotTick()
    
    -- Update NoClip
    NoClipTick()
    
    -- Update BunnyHop
    BunnyHopTick()
    
    -- Update ESP
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
end)

table.insert(Connections, RenderConnection)

-- Player Added/Removed
local PlayerAddedConnection = Players.PlayerAdded:Connect(function(Player)
    if Player ~= LocalPlayer and RysaCheat.Settings.ESPEnabled then
        ESPObjects[Player] = CreateESPBox(Player)
    end
end)

local PlayerRemovedConnection = Players.PlayerRemoving:Connect(function(Player)
    RemoveESPBox(Player)
end)

table.insert(Connections, PlayerAddedConnection)
table.insert(Connections, PlayerRemovedConnection)

-- Initialize
CreateMenu()
print("✓ RYSA CHEAT v2.1 Loaded Successfully!")
print("✓ Press END to toggle menu")
print("✓ F1=Aimbot, F2=ESP, F3=NoClip, F4=BunnyHop")
