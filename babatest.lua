--[=[
  MM2 BASIT HACK - MENU SUREKLI ACIK
  Menü direkt açık gelir, kapatmak için X'e bas
]=]

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

-- Ayarlar
local Settings = {
    Aimbot = true,
    ESP = true,
    FOVSize = 150,
    Smoothness = 5
}

-- MENUYÜ DOĞRUDAN OLUŞTUR (kapalı değil, direkt göster)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2Menu"
ScreenGui.Parent = CoreGui
ScreenGui.Enabled = true -- DIREKT ACIK!
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Arkaplan karartma (menü dışına tıklayınca kapanmasın diye)
local Background = Instance.new("Frame")
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.BackgroundTransparency = 0.3
Background.BorderSizePixel = 0
Background.Parent = ScreenGui

-- Ana menü çerçevesi
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 250)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.BorderSizePixel = 2
MainFrame.BorderColor3 = Color3.fromRGB(0, 120, 255)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Başlık çubuğu
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -40, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "MM2 HACK v2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Kapatma butonu (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -35, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy() -- Menüyü tamamen kaldır
end)

-- İçerik alanı
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -55)
ContentFrame.Position = UDim2.new(0, 10, 0, 45)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- Aimbot butonu
local AimbotBtn = Instance.new("TextButton")
AimbotBtn.Size = UDim2.new(1, -20, 0, 40)
AimbotBtn.Position = UDim2.new(0, 10, 0, 10)
AimbotBtn.BackgroundColor3 = Settings.Aimbot and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
AimbotBtn.Text = Settings.Aimbot and "AIMBOT: ACIK" or "AIMBOT: KAPALI"
AimbotBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AimbotBtn.TextSize = 16
AimbotBtn.Font = Enum.Font.GothamBold
AimbotBtn.BorderSizePixel = 0
AimbotBtn.Parent = ContentFrame

AimbotBtn.MouseButton1Click:Connect(function()
    Settings.Aimbot = not Settings.Aimbot
    AimbotBtn.BackgroundColor3 = Settings.Aimbot and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    AimbotBtn.Text = Settings.Aimbot and "AIMBOT: ACIK" or "AIMBOT: KAPALI"
end)

-- ESP butonu
local ESPBtn = Instance.new("TextButton")
ESPBtn.Size = UDim2.new(1, -20, 0, 40)
ESPBtn.Position = UDim2.new(0, 10, 0, 60)
ESPBtn.BackgroundColor3 = Settings.ESP and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
ESPBtn.Text = Settings.ESP and "ESP: ACIK" or "ESP: KAPALI"
ESPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBtn.TextSize = 16
ESPBtn.Font = Enum.Font.GothamBold
ESPBtn.BorderSizePixel = 0
ESPBtn.Parent = ContentFrame

ESPBtn.MouseButton1Click:Connect(function()
    Settings.ESP = not Settings.ESP
    ESPBtn.BackgroundColor3 = Settings.ESP and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    ESPBtn.Text = Settings.ESP and "ESP: ACIK" or "ESP: KAPALI"
end)

-- Smoothness slider
local SmoothLabel = Instance.new("TextLabel")
SmoothLabel.Size = UDim2.new(1, -20, 0, 20)
SmoothLabel.Position = UDim2.new(0, 10, 0, 110)
SmoothLabel.BackgroundTransparency = 1
SmoothLabel.Text = "Smoothness: " .. Settings.Smoothness
SmoothLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
SmoothLabel.TextSize = 14
SmoothLabel.Font = Enum.Font.Gotham
SmoothLabel.TextXAlignment = Enum.TextXAlignment.Left
SmoothLabel.Parent = ContentFrame

local SmoothSlider = Instance.new("Frame")
SmoothSlider.Size = UDim2.new(1, -20, 0, 20)
SmoothSlider.Position = UDim2.new(0, 10, 0, 135)
SmoothSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
SmoothSlider.BorderSizePixel = 0
SmoothSlider.Parent = ContentFrame

local SmoothFill = Instance.new("Frame")
SmoothFill.Size = UDim2.new(Settings.Smoothness / 10, 0, 1, 0)
SmoothFill.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
SmoothFill.BorderSizePixel = 0
SmoothFill.Parent = SmoothSlider

local SmoothValue = Instance.new("TextLabel")
SmoothValue.Size = UDim2.new(0, 30, 0, 20)
SmoothValue.Position = UDim2.new(1, -35, 0, 135)
SmoothValue.BackgroundTransparency = 1
SmoothValue.Text = Settings.Smoothness
SmoothValue.TextColor3 = Color3.fromRGB(255, 255, 0)
SmoothValue.TextSize = 14
SmoothValue.Font = Enum.Font.GothamBold
SmoothValue.Parent = ContentFrame

SmoothSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local connection
        connection = RunService.RenderStepped:Connect(function()
            local mousePos = UserInputService:GetMouseLocation()
            local absPos = SmoothSlider.AbsolutePosition
            local size = SmoothSlider.AbsoluteSize.X
            local percent = math.clamp((mousePos.X - absPos.X) / size, 0.1, 1)
            local value = math.floor(percent * 10)
            SmoothFill.Size = UDim2.new(percent, 0, 1, 0)
            SmoothLabel.Text = "Smoothness: " .. value
            SmoothValue.Text = value
            Settings.Smoothness = value
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end
end)

-- FOV slider
local FOVLabel = Instance.new("TextLabel")
FOVLabel.Size = UDim2.new(1, -20, 0, 20)
FOVLabel.Position = UDim2.new(0, 10, 0, 165)
FOVLabel.BackgroundTransparency = 1
FOVLabel.Text = "FOV: " .. Settings.FOVSize
FOVLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
FOVLabel.TextSize = 14
FOVLabel.Font = Enum.Font.Gotham
FOVLabel.TextXAlignment = Enum.TextXAlignment.Left
FOVLabel.Parent = ContentFrame

local FOVSlider = Instance.new("Frame")
FOVSlider.Size = UDim2.new(1, -20, 0, 20)
FOVSlider.Position = UDim2.new(0, 10, 0, 190)
FOVSlider.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
FOVSlider.BorderSizePixel = 0
FOVSlider.Parent = ContentFrame

local FOVFill = Instance.new("Frame")
FOVFill.Size = UDim2.new(Settings.FOVSize / 500, 0, 1, 0)
FOVFill.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
FOVFill.BorderSizePixel = 0
FOVFill.Parent = FOVSlider

local FOVValue = Instance.new("TextLabel")
FOVValue.Size = UDim2.new(0, 40, 0, 20)
FOVValue.Position = UDim2.new(1, -45, 0, 190)
FOVValue.BackgroundTransparency = 1
FOVValue.Text = Settings.FOVSize
FOVValue.TextColor3 = Color3.fromRGB(255, 255, 0)
FOVValue.TextSize = 14
FOVValue.Font = Enum.Font.GothamBold
FOVValue.Parent = ContentFrame

FOVSlider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        local connection
        connection = RunService.RenderStepped:Connect(function()
            local mousePos = UserInputService:GetMouseLocation()
            local absPos = FOVSlider.AbsolutePosition
            local size = FOVSlider.AbsoluteSize.X
            local percent = math.clamp((mousePos.X - absPos.X) / size, 0, 1)
            local value = math.floor(percent * 500)
            FOVFill.Size = UDim2.new(percent, 0, 1, 0)
            FOVLabel.Text = "FOV: " .. value
            FOVValue.Text = value
            Settings.FOVSize = value
        end)
        
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                connection:Disconnect()
            end
        end)
    end
end)

-- ESP için BillboardGui'ler
local ESPTags = {}

function CreateESP(player)
    if player == LocalPlayer then return end
    
    local char = player.Character
    if not char then return end
    
    local head = char:FindFirstChild("Head")
    if not head then return end
    
    local billboard = Instance.new("BillboardGui")
    billboard.Name = player.Name .. "_ESP"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 150, 0, 40)
    billboard.StudsOffset = Vector3.new(0, 2.5, 0)
    billboard.AlwaysOnTop = true
    billboard.Enabled = Settings.ESP
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextStrokeTransparency = 0.2
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 16
    nameLabel.Parent = billboard
    
    billboard.Parent = head
    ESPTags[player] = billboard
end

function UpdateESP()
    for player, billboard in pairs(ESPTags) do
        if billboard and billboard.Parent then
            billboard.Enabled = Settings.ESP
            
            -- Renk güncelleme
            local char = player.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                local label = billboard:FindFirstChildOfClass("TextLabel")
                if label then
                    if tool and (tool.Name:lower():find("knife") or tool.Name:lower():find("gun")) then
                        label.TextColor3 = Color3.fromRGB(255, 50, 50) -- Katil
                        label.Text = player.Name .. " 🔪"
                    else
                        label.TextColor3 = Color3.fromRGB(255, 255, 255) -- Masum
                        label.Text = player.Name
                    end
                end
            end
        end
    end
end

-- Yeni oyuncular için
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        CreateESP(player)
    end)
end)

-- Mevcut oyuncular için
for _, player in pairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        if player.Character then
            CreateESP(player)
        end
        player.CharacterAdded:Connect(function()
            task.wait(0.5)
            CreateESP(player)
        end)
    end
end

-- Aimbot
function GetClosestPlayer()
    local closest = nil
    local shortest = Settings.FOVSize
    local mousePos = UserInputService:GetMouseLocation()
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local head = player.Character:FindFirstChild("Head")
            if head then
                local screenPos, onScreen = Camera:WorldToViewportPoint(head.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    if dist < shortest then
                        shortest = dist
                        closest = {Player = player, Head = head, ScreenPos = screenPos}
                    end
                end
            end
        end
    end
    
    return closest
end

-- FOV çemberi (opsiyonel)
local FOVCircle = Drawing and Drawing.new("Circle")
if FOVCircle then
    FOVCircle.Thickness = 2
    FOVCircle.NumSides = 60
    FOVCircle.Color = Color3.fromRGB(255, 255, 255)
    FOVCircle.Filled = false
    FOVCircle.Visible = true
end

-- Ana döngü
RunService.RenderStepped:Connect(function()
    -- ESP güncelle
    UpdateESP()
    
    -- FOV çemberi
    if FOVCircle then
        FOVCircle.Position = UserInputService:GetMouseLocation()
        FOVCircle.Radius = Settings.FOVSize
        FOVCircle.Visible = Settings.Aimbot
    end
    
    -- Aimbot
    if Settings.Aimbot and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        local target = GetClosestPlayer()
        if target then
            local mousePos = UserInputService:GetMouseLocation()
            mousemoverel(
                (target.ScreenPos.X - mousePos.X) / Settings.Smoothness,
                (target.ScreenPos.Y - mousePos.Y) / Settings.Smoothness
            )
        end
    end
end)

-- Bildirim
StarterGui:SetCore("SendNotification", {
    Title = "MM2 HACK",
    Text = "Menu yuklendi! Kapatmak icin X'e bas",
    Duration = 5
})

print("=== MM2 HACK MENU ACIK ===")
print("Kapatmak icin menudeki X'e bas")
