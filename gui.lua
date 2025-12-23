-- Evita múltiplas GUIs
if game.CoreGui:FindFirstChild("BloxstrapMobileUI") then
    game.CoreGui.BloxstrapMobileUI:Destroy()
end

-- Carrega WindUI
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)

if not success or not WindUI then
    warn("[Bloxstrap Mobile] Não foi possível carregar WindUI")
    return
end

-- Cria a janela principal
local MainUI = WindUI:Window({
    Name = "Bloxstrap Mobile",
    Size = UDim2.fromOffset(400, 250),
    Theme = "Dark"
})

-- FPS Label
local FPSLabel = MainUI:Label("FPS: 0")

-- Atualiza FPS em tempo real
spawn(function()
    local RunService = game:GetService("RunService")
    local lastTime = tick()
    while true do
        RunService.RenderStepped:Wait()
        local currentTime = tick()
        local fps = math.floor(1 / math.clamp(currentTime - lastTime, 0.001, 1))
        lastTime = currentTime
        FPSLabel:SetText("FPS: " .. fps)
    end
end)

-- Preset ativo
local ActivePresetLabel = MainUI:Label("Preset ativo: Nenhum")

-- Função para adicionar botão de preset
local function AddPresetButton(name, url)
    MainUI:Button(name, function()
        ActivePresetLabel:SetText("Preset ativo: " .. name)
        local success, err = pcall(function()
            loadstring(game:HttpGet(url, true))()
        end)
        if not success then
            warn("[Bloxstrap Mobile] Erro ao carregar preset:", err)
        end
    end)
end

-- Presets
AddPresetButton("✨ Clean VFX", "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/clean_vfx.lua")
AddPresetButton("🔥 Ultra Low FPS", "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/ultra_low.lua")

-- Botão reset gráfico
MainUI:Button("♻️ Reset gráfico", function()
    local Lighting = game:GetService("Lighting")
    Lighting.GlobalShadows = true
    Lighting.Brightness = 1
    Lighting.ExposureCompensation = 0
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    Lighting.ShadowSoftness = 0.5
    ActivePresetLabel:SetText("Preset ativo: Nenhum")
    warn("[Bloxstrap Mobile] Gráfico resetado")
end)

-- Tabs laterais (opcional)
local Tab1 = MainUI:Tab("Presets")
local Tab2 = MainUI:Tab("Configurações")

-- Mover elementos para tabs se quiser
-- Por exemplo, FPSLabel e ActivePresetLabel em Configurações:
Tab2:Label("FPS: 0") -- você pode mover o FPSLabel aqui se desejar
Tab2:Label("Preset ativo: Nenhum")
