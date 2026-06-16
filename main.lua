local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "AFK Optimizer",
    LoadingTitle = "Grace AFK Mode",
    LoadingSubtitle = "Client Safe Optimizer"
})

local Tab = Window:CreateTab("AFK Mode", 4483362458)

local function enableAFK()

    local Players = game:GetService("Players")
    local Lighting = game:GetService("Lighting")
    local RunService = game:GetService("RunService")

    local player = Players.LocalPlayer

    -- UI kapat
    for _,v in pairs(player:WaitForChild("PlayerGui"):GetChildren()) do
        if v:IsA("ScreenGui") then
            v.Enabled = false
        end
    end

    -- Lighting optimize
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 1e9
    Lighting.Brightness = 1
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0

    for _,v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then
            v.Enabled = false
        end
    end

    -- FPS limit (stabil)
    pcall(function()
        setfpscap(30)
    end)

    -- Animation disable
    local function disableAnimations(character)
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            local animator = humanoid:FindFirstChildOfClass("Animator")
            if animator then
                for _,track in pairs(animator:GetPlayingAnimationTracks()) do
                    track:Stop()
                end
            end
        end

        local animate = character:FindFirstChild("Animate")
        if animate then
            animate.Disabled = true
        end
    end

    if player.Character then
        disableAnimations(player.Character)
    end

    player.CharacterAdded:Connect(function(char)
        task.wait(1)
        disableAnimations(char)
    end)

end

Tab:CreateButton({
    Name = "Enable AFK Mode (FPS + No Animations)",
    Callback = function()
        enableAFK()

        Rayfield:Notify({
            Title = "AFK MODE",
            Content = "Activated successfully",
            Duration = 5
        })
    end,
})