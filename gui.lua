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

-- Cria a janela principal (sintaxe correta)
local MainUI = WindUI:CreateWindow({
    Title = "Bloxstrap Mobile",
    Icon = "rbxassetid://10734950309",
    Author = "Bloxstrap Team",
    Folder = "BloxstrapMobile"
})

-- Cria as tabs
local TabPresets = MainUI:Tab({
    Title = "Presets",
    Icon = "sparkles"
})

local TabConfig = MainUI:Tab({
    Title = "Configurações", 
    Icon = "settings"
})

-- ===== ABA PRESETS =====
local PresetSection = TabPresets:Section("Selecione um Preset")

local activePreset = "Nenhum"
local PresetLabel = PresetSection:Label("Preset ativo: Nenhum")

-- Função para adicionar botão de preset
local function AddPresetButton(name, url, icon)
    PresetSection:Button({
        Title = icon .. " " .. name,
        Callback = function()
            activePreset = name
            PresetLabel:Set("Preset ativo: " .. name)
            
            local success, err = pcall(function()
                loadstring(game:HttpGet(url, true))()
            end)
            
            if not success then
                warn("[Bloxstrap Mobile] Erro ao carregar preset:", err)
                PresetLabel:Set("Preset ativo: Erro ao carregar")
            end
        end
    })
end

-- Lista de presets
AddPresetButton("Clean VFX", "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/clean_vfx.lua", "✨")
AddPresetButton("Ultra Low FPS", "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/ultra_low.lua", "🔥")

-- Botão reset gráfico
PresetSection:Button({
    Title = "♻️ Reset Gráfico",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = true
        Lighting.Brightness = 1
        Lighting.ExposureCompensation = 0
        Lighting.EnvironmentDiffuseScale = 1
        Lighting.EnvironmentSpecularScale = 1
        Lighting.ShadowSoftness = 0.5
        
        activePreset = "Nenhum"
        PresetLabel:Set("Preset ativo: Nenhum")
        warn("[Bloxstrap Mobile] Gráfico resetado")
    end
})

-- ===== ABA CONFIGURAÇÕES =====
local ConfigSection = TabConfig:Section("Informações do Sistema")

local FPSLabel = ConfigSection:Label("FPS: Calculando...")

-- Atualiza FPS em tempo real
task.spawn(function()
    local RunService = game:GetService("RunService")
    local lastTime = tick()
    
    while task.wait(0.5) do
        local currentTime = tick()
        local delta = currentTime - lastTime
        local fps = math.floor(1 / math.clamp(delta, 0.001, 1))
        lastTime = currentTime
        
        pcall(function()
            FPSLabel:Set("FPS: " .. fps)
        end)
    end
end)

-- Informações adicionais
ConfigSection:Label("Versão: 1.0.0")
ConfigSection:Label("Plataforma: Mobile")

warn("[Bloxstrap Mobile] Interface carregada
