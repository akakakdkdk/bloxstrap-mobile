-- URL base dos presets
local url = "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/"

-- Evita duplicar GUI
if game.CoreGui:FindFirstChild("BloxstrapMobileUI") then
    game.CoreGui.BloxstrapMobileUI:Destroy()
end

-- Cria a ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxstrapMobileUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Painel principal
local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromScale(0.35, 0.5)
Frame.Position = UDim2.fromScale(0.05, 0.25)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UIList = Instance.new("UIListLayout", Frame)
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.VerticalAlignment = Enum.VerticalAlignment.Top

-- Label Preset ativo
local ActiveLabel = Instance.new("TextLabel")
ActiveLabel.Size = UDim2.fromScale(1, 0)
ActiveLabel.AutomaticSize = Enum.AutomaticSize.Y
ActiveLabel.BackgroundTransparency = 1
ActiveLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
ActiveLabel.Font = Enum.Font.Gotham
ActiveLabel.TextSize = 14
ActiveLabel.Text = "Preset ativo: Nenhum"
ActiveLabel.Parent = Frame

-- FPS Label
local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.fromScale(1, 0)
FPSLabel.AutomaticSize = Enum.AutomaticSize.Y
FPSLabel.BackgroundTransparency = 1
FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
FPSLabel.Font = Enum.Font.Gotham
FPSLabel.TextSize = 14
FPSLabel.Text = "FPS: 0"
FPSLabel.Parent = Frame

-- Atualiza FPS
spawn(function()
    local RunService = game:GetService("RunService")
    local lastTime = tick()
    while true do
        RunService.RenderStepped:Wait()
        local currentTime = tick()
        local fps = math.floor(1 / math.clamp(currentTime - lastTime, 0.001, 1))
        lastTime = currentTime
        FPSLabel.Text = "FPS: " .. fps
    end
end)

-- Função para criar botões
local function makeButton(text, urlPreset)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromScale(1, 0)
    btn.AutomaticSize = Enum.AutomaticSize.Y
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.Parent = Frame

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        ActiveLabel.Text = "Preset ativo: " .. text
        warn("Carregando preset:", text)
        loadstring(game:HttpGet(urlPreset, true))()
    end)
end

-- Botão Reset gráfico
local ResetBtn = Instance.new("TextButton")
ResetBtn.Size = UDim2.fromScale(1, 0)
ResetBtn.AutomaticSize = Enum.AutomaticSize.Y
ResetBtn.Text = "♻️ Reset gráfico"
ResetBtn.TextColor3 = Color3.fromRGB(255,255,255)
ResetBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
ResetBtn.Font = Enum.Font.Gotham
ResetBtn.TextSize = 14
ResetBtn.BorderSizePixel = 0
ResetBtn.Parent = Frame

local corner = Instance.new("UICorner", ResetBtn)
corner.CornerRadius = UDim.new(0, 8)

ResetBtn.MouseButton1Click:Connect(function()
    local Lighting = game:GetService("Lighting")
    Lighting.GlobalShadows = true
    Lighting.Brightness = 1
    Lighting.ExposureCompensation = 0
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    Lighting.ShadowSoftness = 0.5
    warn("[Preset] Gráfico resetado")
    ActiveLabel.Text = "Preset ativo: Nenhum"
end)

-- Botões de presets
makeButton("✨ Clean VFX", url .. "clean_vfx.lua")
makeButton("🔥 Ultra Low FPS", url .. "ultra_low.lua")
