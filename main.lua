local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "Grace - FPS BOOSTER",
    LoadingTitle = "Grace",
    LoadingSubtitle = "FPS Booster"
})

local Tab = Window:CreateTab("FPS", 4483362458)

Tab:CreateButton({
    Name = "HUD ve Texture Kaldır",
    Callback = function()

        -- CoreGui dışındaki ScreenGui'leri kapat
        for _,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
            if v:IsA("ScreenGui") then
                v.Enabled = false
            end
        end

        -- Texture ve Decal kaldır
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Texture") or v:IsA("Decal") then
                v:Destroy()
            end

            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            end
        end

        -- Işık efektlerini kaldır
        local lighting = game:GetService("Lighting")

        for _,v in pairs(lighting:GetChildren()) do
            if v:IsA("BloomEffect")
            or v:IsA("BlurEffect")
            or v:IsA("SunRaysEffect")
            or v:IsA("ColorCorrectionEffect")
            or v:IsA("DepthOfFieldEffect") then
                v:Destroy()
            end
        end

        lighting.GlobalShadows = false
        lighting.FogEnd = 100000

        Rayfield:Notify({
            Title = "FPS Boost",
            Content = "HUD ve textureler kaldırıldı.",
            Duration = 5
        })
    end
})

----------------------------------------------------
-- 🔥 EKLENEN NO ANIMATION BUTONU
----------------------------------------------------

Tab:CreateButton({
    Name = "No Animations (Local)",
    Callback = function()

        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:FindFirstChildOfClass("Humanoid")

        if humanoid then
            -- mevcut animasyonları durdur
            for _,track in pairs(humanoid:GetPlayingAnimationTracks()) do
                track:Stop()
            end

            -- yeni animasyonları engellemeye çalışır (local)
            humanoid.AnimationPlayed:Connect(function(track)
                track:Stop()
            end)
        end

        Rayfield:Notify({
            Title = "FPS Boost",
            Content = "No Animations aktif edildi.",
            Duration = 5
        })
    end
})
