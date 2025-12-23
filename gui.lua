-- Evita múltiplas instâncias da GUI
if game.CoreGui:FindFirstChild("BloxstrapMobileUI") then
    game.CoreGui.BloxstrapMobileUI:Destroy()
end

-- Carrega Fluent UI
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- Cria a janela principal
local Window = Fluent:CreateWindow({
    Title = "Bloxstrap Mobile " .. "v1.0",
    SubTitle = "Otimização Gráfica",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- ===== TAB PRESETS =====
local Tabs = {
    Presets = Window:AddTab({ Title = "🎨 Presets", Icon = "sparkles" }),
    Config = Window:AddTab({ Title = "⚙️ Configurações", Icon = "settings" })
}

local activePreset = "Nenhum"

-- Label do preset ativo
local PresetLabel = Tabs.Presets:AddParagraph({
    Title = "Status",
    Content = "Preset ativo: Nenhum"
})

-- Função para adicionar botão de preset
local function AddPresetButton(name, emoji, url, description)
    Tabs.Presets:AddButton({
        Title = emoji .. " " .. name,
        Description = description,
        Callback = function()
            activePreset = name
            PresetLabel:SetDesc("Preset ativo: " .. name)
            
            Fluent:Notify({
                Title = "Carregando...",
                Content = "Aplicando " .. name,
                Duration = 2
            })
            
            task.wait(0.5)
            
            local success, err = pcall(function()
                loadstring(game:HttpGet(url, true))()
            end)
            
            if not success then
                warn("[Bloxstrap Mobile] Erro:", err)
                PresetLabel:SetDesc("Preset ativo: Erro ao carregar")
                Fluent:Notify({
                    Title = "❌ Erro",
                    Content = "Falha ao carregar " .. name,
                    Duration = 3
                })
            else
                Fluent:Notify({
                    Title = "✅ Sucesso",
                    Content = name .. " aplicado com sucesso!",
                    Duration = 3
                })
            end
        end
    })
end

-- Seção de presets
Tabs.Presets:AddSection("Presets Disponíveis")

-- Lista de presets
AddPresetButton(
    "Clean VFX",
    "✨",
    "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/clean_vfx.lua",
    "Visual limpo com efeitos otimizados"
)

AddPresetButton(
    "Ultra Low FPS",
    "🔥",
    "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/presets/ultra_low.lua",
    "Máxima performance, mínimo gráfico"
)

-- Seção de reset
Tabs.Presets:AddSection("Restaurar")

-- Botão reset gráfico
Tabs.Presets:AddButton({
    Title = "♻️ Reset Gráfico",
    Description = "Restaura todas as configurações para o padrão",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.GlobalShadows = true
        Lighting.Brightness = 1
        Lighting.ExposureCompensation = 0
        Lighting.EnvironmentDiffuseScale = 1
        Lighting.EnvironmentSpecularScale = 1
        Lighting.ShadowSoftness = 0.5
        
        activePreset = "Nenhum"
        PresetLabel:SetDesc("Preset ativo: Nenhum")
        
        Fluent:Notify({
            Title = "♻️ Reset Completo",
            Content = "Gráfico restaurado para o padrão",
            Duration = 2
        })
    end
})

-- ===== TAB CONFIGURAÇÕES =====
Tabs.Config:AddSection("Informações do Sistema")

-- FPS Counter
local FPSParagraph = Tabs.Config:AddParagraph({
    Title = "📊 Performance",
    Content = "FPS: Calculando..."
})

-- Atualiza FPS em tempo real
task.spawn(function()
    local RunService = game:GetService("RunService")
    local lastTime = tick()
    local frameCount = 0
    local fpsHistory = {}
    
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local currentTime = tick()
        
        if currentTime - lastTime >= 1 then
            local fps = frameCount
            frameCount = 0
            lastTime = currentTime
            
            -- Adiciona ao histórico
            table.insert(fpsHistory, fps)
            if #fpsHistory > 5 then
                table.remove(fpsHistory, 1)
            end
            
            -- Calcula média
            local sum = 0
            for _, v in ipairs(fpsHistory) do
                sum = sum + v
            end
            local avgFPS = math.floor(sum / #fpsHistory)
            
            -- Atualiza label
            pcall(function()
                FPSParagraph:SetDesc(string.format("FPS Atual: %d | Média: %d", fps, avgFPS))
            end)
        end
    end)
end)

-- Informações adicionais
Tabs.Config:AddParagraph({
    Title = "ℹ️ Sobre",
    Content = "Versão: 1.0.0\nPlataforma: Mobile\nDesenvolvedor: Bloxstrap Team"
})

-- Ping do servidor
local PingLabel = Tabs.Config:AddParagraph({
    Title = "🌐 Conexão",
    Content = "Ping: Calculando..."
})

task.spawn(function()
    local Stats = game:GetService("Stats")
    while task.wait(2) do
        pcall(function()
            local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            PingLabel:SetDesc("Ping: " .. ping .. "ms")
        end)
    end
end)

-- Botão fechar
Tabs.Config:AddButton({
    Title = "❌ Fechar Interface",
    Description = "Fecha a UI completamente",
    Callback = function()
        Fluent:Destroy()
    end
})

-- Notificação de inicialização
Fluent:Notify({
    Title = "🎉 Bloxstrap Mobile",
    Content = "Interface carregada com sucesso!",
    Duration = 5
})

warn("[Bloxstrap Mobile] Interface Fluent carregada!")
