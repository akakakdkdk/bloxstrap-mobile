-- Evita múltiplas instâncias da GUI
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
    Size = UDim2.fromOffset(450, 300),
    Theme = "Dark"
})

-- Tabs
local TabPresets = MainUI:Tab("Presets")
local TabConfig = MainUI:Tab("Configurações")

-- ===== ABA PRESETS =====
local ActivePresetLabel = TabPresets:Label("Preset ativo: Nenhum")

-- Função para adicionar botão de preset
local function AddPresetButton(name, url)
    TabPresets:Button(name, function()
        ActivePresetLabel:SetText("Preset ativo: " .. name)
        local success, err = pcall(function()
            loadstring(game:HttpGet(url, true))()
        end)
        if not success then
            warn("[Bloxstrap Mobile] Erro ao carregar preset:", err)
            ActivePresetLabel:SetText("Preset ativo: Erro ao carregar")
        end
    end)
end

-- Lista de presets
AddPresetButton("✨ Clean VFX", "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/clean_vfx.lua")
AddPresetButton("🔥 Ultra Low FPS", "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/ultra_low.lua")

-- Botão reset gráfico
TabPresets:Button("♻️ Reset Gráfico", function()
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

-- ===== ABA CONFIGURAÇÕES =====
local FPSLabel = TabConfig:Label("FPS: 0")

-- Atualiza FPS em tempo real
task.spawn(function()
    local RunService = game:GetService("RunService")
    local lastTime = tick()
    
    while task.wait(0.5) do -- Atualiza a cada 0.5s para economizar recursos
        local currentTime = tick()
        local delta = currentTime - lastTime
        local fps = math.floor(1 / math.clamp(delta, 0.001, 1))
        lastTime = currentTime
        
        FPSLabel:SetText("FPS: " .. fps)
    end
end)

-- Informações adicionais
TabConfig:Label("Versão: 1.0")
TabConfig:Label("Desenvolvido para Mobile"
