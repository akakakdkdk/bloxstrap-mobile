-- URL base dos presets
local url = "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/"

-- Evita duplicar GUI
if game.CoreGui:FindFirstChild("BloxstrapMobileUI") then
    game.CoreGui.BloxstrapMobileUI:Destroy()
end

-- Carregando WindUi
local WindUi = loadstring(game:HttpGet("https://raw.githubusercontent.com/akakakdkdk/WindUi/main/init.lua", true))()
local window = WindUi:CreateWindow({
    Name = "Bloxstrap Mobile",
    Size = UDim2.fromScale(0.35, 0.5),
    Theme = "Dark"
})

-- FPS Label
local fpsLabel = window:CreateLabel("FPS: 0", {TextColor = Color3.fromRGB(0,255,0)})

-- Atualiza FPS
spawn(function()
    local RunService = game:GetService("RunService")
    local lastTime = tick()
    while true do
        RunService.RenderStepped:Wait()
        local currentTime = tick()
        local fps = math.floor(1 / math.clamp(currentTime - lastTime, 0.001, 1))
        lastTime = currentTime
        fpsLabel:SetText("FPS: " .. fps)
    end
end)

-- Preset ativo
local presetLabel = window:CreateLabel("Preset ativo: Nenhum", {TextColor = Color3.fromRGB(0,255,255)})

-- Função para criar botões de preset
local function makeButton(text, urlPreset)
    local btn = window:CreateButton({
        Name = text,
        Callback = function()
            presetLabel:SetText("Preset ativo: " .. text)
            warn("Carregando preset:", text)
            loadstring(game:HttpGet(urlPreset, true))()
        end
    })
end

-- Botão Reset gráfico
window:CreateButton({
    Name = "♻️ Reset gráfico",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = true
        Lighting.Brightness = 1
        Lighting.ExposureCompensation = 0
        Lighting.EnvironmentDiffuseScale = 1
        Lighting.EnvironmentSpecularScale = 1
        Lighting.ShadowSoftness = 0.5
        warn("[Preset] Gráfico resetado")
        presetLabel:SetText("Preset ativo: Nenhum")
    end
})

-- Adiciona botões de presets
makeButton("✨ Clean VFX", url .. "clean_vfx.lua")
makeButton("🔥 Ultra Low FPS", url .. "ultra_low.lua")
