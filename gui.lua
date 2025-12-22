warn("[Bloxstrap] GUI carregando...")

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

-- Espera o player existir
if not player then
    Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
    player = Players.LocalPlayer
end

-- Remove GUI antiga se existir
pcall(function()
    CoreGui:FindFirstChild("BloxstrapMobile"):Destroy()
end)

local gui = Instance.new("ScreenGui")
gui.Name = "BloxstrapMobile"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.Parent = CoreGui -- 🔥 ISSO É O MAIS IMPORTANTE

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.45, 0.5)
frame.Position = UDim2.fromScale(0.05, 0.25)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Text = "Bloxstrap Mobile"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 16

local function button(text, y, url)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0.9,0,0,40)
    b.Position = UDim2.new(0.05,0,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(35,35,35)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    Instance.new("UICorner", b)

    if url ~= "" then
        b.MouseButton1Click:Connect(function()
            loadstring(game:HttpGet(url, true))()
        end)
    else
        b.MouseButton1Click:Connect(function()
            gui:Destroy()
        end)
    end
end

button("🔥 Ultra Low FPS", 60,
"https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/ultra_low.lua")

button("✨ Clean VFX", 110,
"https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/clean_vfx.lua")

button("🥋 Jujutsu Shenanigans", 160,
"https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/jjs.lua")

button("📊 FPS Counter", 210,
"https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/utils/fps_counter.lua")

button("❌ Fechar", 260, "")

warn("[Bloxstrap] GUI exibida com sucesso")
