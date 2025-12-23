-- Limpa partículas, trails, beams e efeitos visuais
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Beam") or obj:IsA("Smoke") or obj:IsA("Fire") then
        obj.Enabled = false
        obj.Rate = 0
    end
end

warn("[Preset] Clean VFX aplicado")
