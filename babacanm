--[=[
  MM2 BASIT HACK
  SADECE CALISAN ÖZELLIKLER
  Menu: F7
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

-- Menü
local MenuOpen = false
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MM2Menu"
ScreenGui.Parent = CoreGui
ScreenGui.Enabled = false

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 250, 0, 200)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.Text = "MM2 HACK"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -30, 0, 0)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = Title

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui.Enabled = false
end)

-- Aimbot toggle
local AimbotBtn = Instance.new("TextButton")
AimbotBtn.Size = UDim2.new(1, -20, 0, 35)
AimbotBtn.Position = UDim2.new(0, 10, 0, 40)
AimbotBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
AimbotBtn.Text = "Aimbot: ACIK"
AimbotBtn.TextColor3 = Color3.new(1, 1, 1)
AimbotBtn.TextSize = 14
AimbotBtn.Font = Enum.Font.Gotham
AimbotBtn.Parent = MainFrame

AimbotBtn.MouseButton1Click:Connect(function()
    Settings.Aimbot = not Settings.Aimbot
    AimbotBtn.BackgroundColor3 = Settings.Aimbot and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    AimbotBtn.Text = Settings.Aimbot and "Aimbot: ACIK" or "Aimbot: KAPALI"
end)

-- ESP toggle
local ESPBtn = Instance.new("TextButton")
ESPBtn.Size = UDim2.new(1, -20, 0, 35)
ESPBtn.Position = UDim2.new(0, 10, 0, 80)
ESPBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
ESPBtn.Text = "ESP: ACIK"
ESPBtn.TextColor3 = Color3.new(1, 1, 1)
ESPBtn.TextSize = 14
ESPBtn.Font = Enum.Font.Gotham
ESPBtn.Parent = MainFrame

ESPBtn.MouseButton1Click:Connect(function()
    Settings.ESP = not Settings.ESP
    ESPBtn.BackgroundColor3 = Settings.ESP and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    ESPBtn.Text = Settings.ESP and "ESP: ACIK" or "ESP: KAPALI"
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
    billboard.Size = UDim2.new(0, 100, 0, 30)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.new(1, 1, 1)
    nameLabel.TextStrokeTransparency = 0.3
    nameLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextSize = 14
    nameLabel.Parent = billboard
    
    billboard.Parent = head
    ESPTags[player] = billboard
end

function UpdateESP()
    for player, billboard in pairs(ESPTags) do
        if billboard and billboard.Parent then
            billboard.Enabled = Settings.ESP
            
            -- Renk güncelleme (katil kırmızı)
            local char = player.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                local label = billboard:FindFirstChildOfClass("TextLabel")
                if label then
                    if tool and (tool.Name:lower():find("knife") or tool.Name:lower():find("gun")) then
                        label.TextColor3 = Color3.fromRGB(255, 0, 0) -- Katil kırmızı
                    else
                        label.TextColor3 = Color3.fromRGB(255, 255, 255) -- Masum beyaz
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

-- Basit Aimbot
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

-- Ana döngü
RunService.RenderStepped:Connect(function()
    -- ESP güncelle
    UpdateESP()
    
    -- Aimbot (sadece sağ tık basılıyken)
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

-- F7 ile menü aç/kapa
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F7 then
        MenuOpen = not MenuOpen
        ScreenGui.Enabled = MenuOpen
    end
end)

-- Bildirim
StarterGui:SetCore("SendNotification", {
    Title = "MM2 HACK",
    Text = "Yuklendi! Menü: F7",
    Duration = 3
})

print("MM2 HACK - Menü icin F7")
