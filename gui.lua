-- URL base dos presets
local url = "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/"

-- Evita duplicar GUI
if game.CoreGui:FindFirstChild("BloxstrapMobileUI") then
    game.CoreGui.BloxstrapMobileUI:Destroy()
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BloxstrapMobileUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Painel principal
local Frame = Instance.new("Frame")
Frame.Size = UDim2.fromOffset(400, 250)
Frame.Position = UDim2.new(0.5, -200, 0.5, -125) -- centralizado
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0, 12)

-- Topbar (arrastável)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TopBar.Parent = Frame
local TopCorner = Instance.new("UICorner", TopBar)
TopCorner.CornerRadius = UDim.new(0, 12)

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Bloxstrap Mobile"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

-- Botão minimizar
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -55, 0, 2)
MinBtn.Text = "_"
MinBtn.TextColor3 = Color3.fromRGB(255,255,255)
MinBtn.BackgroundColor3 = Color3.fromRGB(80,80,80)
MinBtn.Font = Enum.Font.Gotham
MinBtn.TextSize = 16
MinBtn.BorderSizePixel = 0
MinBtn.Parent = TopBar
local MinCorner = Instance.new("UICorner", MinBtn)
MinCorner.CornerRadius = UDim.new(0, 6)

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -25, 0, 2)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.Font = Enum.Font.Gotham
CloseBtn.TextSize = 16
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TopBar
local CloseCorner = Instance.new("UICorner", CloseBtn)
CloseCorner.CornerRadius = UDim.new(0, 6)

-- Conteúdo
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, 0, 1, -30)
Content.Position = UDim2.new(0, 0, 0, 30)
Content.BackgroundTransparency = 1
Content.Parent = Frame

-- Lateral de tabs
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(0, 100, 1, 0)
TabFrame.Position = UDim2.new(0, 0, 0, 0)
TabFrame.BackgroundColor3 = Color3.fromRGB(40,40,40)
TabFrame.Parent = Content
local TabCorner = Instance.new("UICorner", TabFrame)
TabCorner.CornerRadius = UDim.new(0, 8)

-- Frame de conteúdo das tabs
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(1, -100, 1, 0)
MainFrame.Position = UDim2.new(0, 100, 0, 0)
MainFrame.BackgroundTransparency = 1
MainFrame.Parent = Content

local UIList = Instance.new("UIListLayout", MainFrame)
UIList.Padding = UDim.new(0, 8)
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.VerticalAlignment = Enum.VerticalAlignment.Top

-- FPS Label
local FPSLabel = Instance.new("TextLabel")
FPSLabel.Size = UDim2.fromScale(1, 0)
FPSLabel.AutomaticSize = Enum.AutomaticSize.Y
FPSLabel.BackgroundTransparency = 1
FPSLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
FPSLabel.Font = Enum.Font.Gotham
FPSLabel.TextSize = 14
FPSLabel.Text = "FPS: 0"
FPSLabel.Parent = MainFrame

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

-- Preset ativo
local ActiveLabel = Instance.new("TextLabel")
ActiveLabel.Size = UDim2.fromScale(1, 0)
ActiveLabel.AutomaticSize = Enum.AutomaticSize.Y
ActiveLabel.BackgroundTransparency = 1
ActiveLabel.TextColor3 = Color3.fromRGB(0, 255, 255)
ActiveLabel.Font = Enum.Font.Gotham
ActiveLabel.TextSize = 14
ActiveLabel.Text = "Preset ativo: Nenhum"
ActiveLabel.Parent = MainFrame

-- Função criar botão
local function makeButton(text, urlPreset)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.fromScale(1, 0)
    btn.AutomaticSize = Enum.AutomaticSize.Y
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = Color3.fromRGB(50,50,50)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    btn.BorderSizePixel = 0
    btn.Parent = MainFrame

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
ResetBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
ResetBtn.Font = Enum.Font.Gotham
ResetBtn.TextSize = 14
ResetBtn.BorderSizePixel = 0
ResetBtn.Parent = MainFrame

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

-- Presets
makeButton("✨ Clean VFX", url .. "clean_vfx.lua")
makeButton("🔥 Ultra Low FPS", url .. "ultra_low.lua")

-- Função minimizar
local minimized = false
MinBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    Content.Visible = not minimized
    if minimized then
        Frame.Size = UDim2.new(0, 400, 0, 30)
    else
        Frame.Size = UDim2.new(0, 400, 0, 250)
    end
end)

-- Função fechar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Drag functionality
local UserInputService = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
        startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
