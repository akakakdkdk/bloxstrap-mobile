-- Carrega a WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Cria a janela principal
local MainUI = WindUI:CreateWindow({
    Name = "Bloxstrap Mobile",
    Size = UDim2.fromOffset(400, 250),
    Theme = "Dark"
})

-- FPS Label
local FPSLabel = MainUI:AddLabel("FPS: 0")

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
local ActivePresetLabel = MainUI:AddLabel("Preset ativo: Nenhum")

-- Função para adicionar botões de presets
local function AddPresetButton(name, urlPreset)
    MainUI:AddButton(name, function()
        ActivePresetLabel:SetText("Preset ativo: " .. name)
        warn("Carregando preset:", name)
        loadstring(game:HttpGet(urlPreset, true))()
    end)
end

-- Presets
AddPresetButton("✨ Clean VFX", "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/clean_vfx.lua")
AddPresetButton("🔥 Ultra Low FPS", "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/ultra_low.lua")

-- Botão reset gráfico
MainUI:AddButton("♻️ Reset gráfico", function()
    local Lighting = game:GetService("Lighting")
    Lighting.GlobalShadows = true
    Lighting.Brightness = 1
    Lighting.ExposureCompensation = 0
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1
    Lighting.ShadowSoftness = 0.5
    ActivePresetLabel:SetText("Preset ativo: Nenhum")
    warn("[Preset] Gráfico resetado")
end)
