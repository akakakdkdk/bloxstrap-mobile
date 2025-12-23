local Lighting = game:GetService("Lighting")

settings().Rendering.QualityLevel = Enum.QualityLevel.Level01

Lighting.Technology = Enum.Technology.Compatibility
Lighting.GlobalShadows = false
Lighting.Brightness = 1
Lighting.ExposureCompensation = -0.6
Lighting.EnvironmentDiffuseScale = 0
Lighting.EnvironmentSpecularScale = 0

for _, v in pairs(Lighting:GetChildren()) do
	if v:IsA("PostEffect") or v:IsA("Atmosphere") then
		v:Destroy()
	end
end

for _, v in pairs(workspace:GetDescendants()) do
	if v:IsA("ParticleEmitter")
	or v:IsA("Trail")
	or v:IsA("Beam") then
		v.Enabled = false
	end
end

warn("Ultra Low aplicado")
