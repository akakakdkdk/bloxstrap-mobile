-- FPS BOOST ULTRA LOW (DELTA SAFE)

repeat task.wait() until game:IsLoaded()

pcall(function()
    setfpscap(120)
end)

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

-- iluminação bem fraca
Lighting.GlobalShadows = false
Lighting.Brightness = 0.8
Lighting.ExposureCompensation = -1
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0
Lighting.ShadowSoftness = 0
Lighting.Technology = Enum.Technology.Compatibility

-- remove efeitos
for _, v in ipairs(Lighting:GetChildren()) do
    if v:IsA("PostEffect")
    or v:IsA("Atmosphere")
    or v:IsA("Sky") then
        v:Destroy()
    end
end

-- simplifica o mapa
for _, obj in ipairs(Workspace:GetDescendants()) do
    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.Plastic
        obj.Reflectance = 0
        obj.CastShadow = false
    elseif obj:IsA("ParticleEmitter")
    or obj:IsA("Beam")
    or obj:IsA("Trail")
    or obj:IsA("Fire")
    or obj:IsA("Smoke") then
        obj.Enabled = false
    end
end

warn("FPS BOOST ULTRA LOW ATIVADO")
