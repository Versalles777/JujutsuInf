local cloneref = cloneref or function(o) return o end
COREGUI = cloneref(game:GetService("CoreGui"))
Players = cloneref(game:GetService("Players"))

if not game:IsLoaded() then
    print('carregando v2')
    game.Loaded:Wait()
end

local player = game:GetService("Players").LocalPlayer
local Rayfield 
local Window 
queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local function Carregartudo()
    if Rayfield then
        print("Rayfield já carregado. Não é necessário recarregar.")
        return
    end

    print('carregando')

    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    Window = Rayfield:CreateWindow({
        Name = "Rayfield Example Window",
        Icon = 0,  
        LoadingTitle = "Rayfield Interface Suite",
        LoadingSubtitle = "by Sirius",
        Theme = "Default",
        DisableRayfieldPrompts = false,
        DisableBuildWarnings = false,
        ConfigurationSaving = {
            Enabled = true,
            FolderName = "Kill boss auto",
            FileName = "kill boss"
        },
        Discord = {
            Enabled = false, 
            Invite = "noinvitelink", 
            RememberJoins = true 
        },
        KeySystem = false, 
        KeySettings = {
            Title = "Untitled",
            Subtitle = "Key System",
            Note = "No method of obtaining the key is provided",
            FileName = "Key",
            SaveKey = true,
            GrabKeyFromSite = false,
            Key = {"Hello"}
        }
    })
    local config = {
        autofarm = false
    }
    local Tab = Window:CreateTab("Boss", "rewind")
    local Workspace = game:GetService('Workspace')
    local TweenService = game:GetService('TweenService')
    local Players = game:GetService('Players')
    local Player = Players.LocalPlayer
    local HumanoidRootPart = player.Character.HumanoidRootPart
    local TweenServiceTP = function(Pos)
        local distance = (HumanoidRootPart.Position - Pos).Magnitude
        local duration = distance / 300
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
        
        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, { CFrame = CFrame.new(Pos) })
        
        return tween
    end
    local Toggle = Tab:CreateToggle({
        Name = "Auto Farm Boss",
        CurrentValue = false,
        Flag = "AutoBoss", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            config.autofarm = Value
            if config.autofarm then
                local BossSpawn = Workspace.Objects.Spawns.BossSpawn
                local tween = TweenServiceTP(BossSpawn.Position)
                tween:Play()
                tween.Completed:Wait()
                task.wait(10)
                while config.autofarm do
                    local mobs = Workspace.Objects.Mobs
                    local Quantity = #mobs or 0
                    if Quantity > 0 then
                        for i, mob in pairs(mobs:GetChildren()) do
                            mob.Humanoid.Health = 0
                        end
                    end
                    task.spawn(function()
                        task.wait(15)
                        mouse1click()
                    end)
                    Rayfield:Destroy()
                    task.wait(1)
                end
            end

        end,
     })

    print('carregado')
    print(queueteleport)
end

Carregartudo()

player.OnTeleport:Connect(function()
    print('teleportado')
    if queueteleport then
        queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Versalles777/JujutsuInf/refs/heads/main/killboss.lua'))()")
    end
end)
