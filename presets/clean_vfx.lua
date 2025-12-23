for _, v in pairs(workspace:GetDescendants()) do
	if v:IsA("ParticleEmitter")
	or v:IsA("Trail")
	or v:IsA("Beam") then
		v.Enabled = false
	end
end

warn("VFX limpo")
