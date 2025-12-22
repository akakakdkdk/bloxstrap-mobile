-- Clean VFX Preset

local Lighting = game:GetService("Lighting")

Lighting.Technology = Enum.Technology.Compatibility
Lighting.GlobalShadows = false
Lighting.Brightness = 1.5

for _, v in ipairs(workspace:GetDescendants()) do
    if v:IsA("ParticleEmitter") then
        v.Rate = math.clamp(v.Rate * 0.25, 1, 50)
    elseif v:IsA("Trail") or v:IsA("Beam") then
        v.Enabled = true
    end
end

warn("[Bloxstrap Mobile] Clean VFX applied")
