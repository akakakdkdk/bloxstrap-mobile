warn("[Bloxstrap] Tentando criar GUI...")

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local player = Players.LocalPlayer

repeat task.wait() until player
repeat task.wait() until player:FindFirstChild("PlayerGui")

-- Função segura pra criar GUI
local function createGui(parent)
    local gui = Instance.new("ScreenGui")
    gui.Name = "BloxstrapMobile"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = parent

    local frame = Instance.new("Frame", gui)
    frame.Size = UDim2.fromScale(0.8, 0.6)
    frame.Position = UDim2.fromScale(0.1, 0.2)
    frame.BackgroundColor3 = Color3.fromRGB(18,18,18)
    frame.Active = true
    frame.Draggable = true
    Instance.new("UICorner", frame).CornerRadius = UDim.new(0,14)

    local title = Instance.new("TextLabel", frame)
    title.Size = UDim2.new(1,0,0,45)
    title.BackgroundTransparency = 1
    title.Text = "Bloxstrap Mobile"
    title.TextColor3 = Color3.new(1,1,1)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18

    local function btn(text, y, url)
        local b = Instance.new("TextButton", frame)
        b.Size = UDim2.new(0.9,0,0,45)
        b.Position = UDim2.new(0.05,0,0,y)
        b.Text = text
        b.BackgroundColor3 = Color3.fromRGB(35,35,35)
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

    btn("🔥 Ultra Low FPS", 60,
    "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/ultra_low.lua")

    btn("✨ Clean VFX", 115,
    "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/clean_vfx.lua")

    btn("🥋 JJS Preset", 170,
    "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/jjs.lua")

    btn("📊 FPS Counter", 225,
    "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/utils/fps_counter.lua")

    btn("❌ Fechar", 280, "")

    warn("[Bloxstrap] GUI criada com sucesso")
end

-- REMOVE GUI ANTIGA
pcall(function()
    CoreGui:FindFirstChild("BloxstrapMobile"):Destroy()
end)
pcall(function()
    player.PlayerGui:FindFirstChild("BloxstrapMobile"):Destroy()
end)

-- TENTA COREGUI, SE FALHAR USA PLAYERGUI
local success = pcall(function()
    createGui(CoreGui)
end)

if not success then
    warn("[Bloxstrap] CoreGui bloqueado, usando PlayerGui")
    createGui(player.PlayerGui)
end
