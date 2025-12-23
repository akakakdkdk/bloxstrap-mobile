local url = "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/"

-- Evitar duplicar GUI
if game.CoreGui:FindFirstChild("BloxstrapMobileUI") then
    game.CoreGui.BloxstrapMobileUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxstrapMobileUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromScale(0.45, 0.4)
Frame.Position = UDim2.fromScale(0.05, 0.3)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UIList = Instance.new("UIListLayout", Frame)
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.VerticalAlignment = Enum.VerticalAlignment.Top

-- Função para criar botões
local function makeButton(text, urlPreset)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromScale(1, 0)
    btn.AutomaticSize = Enum.AutomaticSize.Y
    btn.Text = text
    btn.TextColor3 = Color3.new(1,1,1)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.Parent = Frame

    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        warn("Carregando preset:", text)
        loadstring(game:HttpGet(urlPreset, true))()
    end)
end

-- ORDEM DOS BOTÕES NA GUI
makeButton("✨ Clean VFX", url .. "clean_vfx.lua")
makeButton("🔥 Ultra Low FPS", url .. "ultra_low.lua")
