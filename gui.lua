-- Bloxstrap Mobile GUI

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "BloxstrapMobileGui"
gui.Parent = player:WaitForChild("PlayerGui")
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.35, 0.4)
frame.Position = UDim2.fromScale(0.05, 0.3)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Active = true
frame.Draggable = true

local uiCorner = Instance.new("UICorner", frame)
uiCorner.CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Bloxstrap Mobile"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local function createButton(text, y, callback)
    local btn = Instance.new("TextButton", frame)
    btn.Size = UDim2.new(0.9,0,0,40)
    btn.Position = UDim2.new(0.05,0,0,y)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 14
    Instance.new("UICorner", btn)

    btn.MouseButton1Click:Connect(callback)
end

createButton("🔥 Ultra Low FPS", 50, function()
    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/ultra_low.lua",
        true
    ))()
end)

createButton("✨ Clean VFX", 100, function()
    loadstring(game:HttpGet(
        "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/clean_vfx.lua",
        true
    ))()
end)

createButton("❌ Fechar GUI", 150, function()
    gui:Destroy()
end)

warn("[Bloxstrap Mobile] GUI loaded")
