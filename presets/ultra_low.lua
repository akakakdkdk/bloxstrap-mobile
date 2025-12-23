local Lighting = game:GetService("Lighting")
Lighting.Technology = Enum.Technology.Compatibility
Lighting.GlobalShadows = false
Lighting.Brightness = 0.5
Lighting.ExposureCompensation = -0.5
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0
Lighting.ShadowSoftness = 0

for _, v in pairs(Lighting:GetChildren()) do
    if v:IsA("PostEffect") or v:IsA("Atmosphere") then
        v:Destroy()
    end
end

warn("[Preset] Ultra Low FPS aplicado")
