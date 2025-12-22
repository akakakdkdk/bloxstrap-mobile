-- Bloxstrap Mobile - Initiate
-- Main loader

warn("[Bloxstrap Mobile] Initiated")

local PRESET_URL = "https://raw.githubusercontent.com/akakakdkdk/bloxstrap-mobile/main/ultra_low.lua"

local success, err = pcall(function()
    loadstring(game:HttpGet(PRESET_URL, true))()
end)

if success then
    warn("[Bloxstrap Mobile] Ultra Low preset loaded successfully")
else
    warn("[Bloxstrap Mobile] Failed to load preset:", err)
end
