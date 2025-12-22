-- Bloxstrap Mobile - Ultra Low Preset
-- Focused on maximum FPS

pcall(function()
    setfpscap(120)
end)

pcall(function()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
end)

local Lighting = game:GetService("Lighting")

Lighting.Technology = Enum.Technology.Compatibility
Lighting.GlobalShadows = false
Lighting.Brightness = 1
Lighting.ExposureCompensation = -0.5
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0
Lighting.ShadowSoftness = 0

-- Remove
