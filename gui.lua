warn("[Bloxstrap] GUI via gethui iniciando")

local hui = gethui and gethui() or game:GetService("CoreGui")

-- remove GUI antiga
pcall(function()
    hui:FindFirstChild("BloxstrapMobile"):Destroy()
end)

local gui = Instance.new("ScreenGui")
gui.Name = "BloxstrapMobile"
gui.IgnoreGuiInset = true
gui.Parent = hui

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.75, 0.6)
frame.Position = UDim2.fromScale(0.125, 0.2)
frame.BackgroundColor3 = Color3.fromRGB(14,14,14)
frame.Active = true
frame.Draggable = true
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,16)

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.new(1,0,0,45)
title.BackgroundTransparency = 1
title.Text = "Bloxstrap Mobile"
title.TextColor3 = Color3.new(1,1,1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local function button(text, y, url)
    local b = Instance.new("TextButton", frame)
    b.Size = UDim2.new(0.9,0,0,45)
    b.Position = UDim2.new(0.05,0,0,y)
    b.Text = text
    b.BackgroundColor3 = Color3.fromRGB(32,32,32)
    b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.Gotham
    b.TextSize = 15
    Instance.new("UICorner", b)

    b.MouseButton1Click:Connect(function()
        if url ~= "" then
            loadstring(game:HttpGet(url, true))()
        else
            gui:Destroy()
        end
    end)
end

button("🔥 Ultra Low FPS", 60,
"https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/ultra_low.lua")

button("✨ Clean VFX", 115,
"https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/clean_vfx.lua")

button("🥋 JJS Preset", 170,
"https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/jjs.lua")

button("📊 FPS Counter", 225,
"https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/utils/fps_counter.lua")

button("❌ Fechar", 280, "")

warn("[Bloxstrap] GUI FINAL carregada")
