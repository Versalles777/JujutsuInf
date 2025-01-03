
print('Started')
repeat
    wait()
until game:IsLoaded()
local player = game:GetService("Players").LocalPlayer
local Rayfield 
local Window 
local queueteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local click = task.spawn(function()
    task.wait(15)
    mouse1click()
end)
local Carregartudo = function()
    local TweenService = game:GetService("TweenService")

        if Rayfield then
            print("Rayfield já carregado. Não é necessário recarregar.")
            return
        end
    local Players = game:GetService('Players')
    local Player = Players.LocalPlayer
    local Character = Player.Character
    local Workspace = game:GetService('Workspace')
    local HumanoidRootPart = Character.HumanoidRootPart
    print('carregando')

    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

    Window = Rayfield:CreateWindow({
        Name = "Kill Boss",
        Icon = 0,  
        LoadingTitle = "Kill Boss",
        LoadingSubtitle = "por versalles__",
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

    local Tab = Window:CreateTab("Boss", "rewind")

    local TweenServiceTP = function(Pos)
        local distance = (HumanoidRootPart.Position - Pos).Magnitude
        local duration = distance / 300
        local tweenInfo = TweenInfo.new(duration, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
        
        local tween = TweenService:Create(HumanoidRootPart, tweenInfo, { CFrame = CFrame.new(Pos) })
        
        return tween
    end
    local Toggle = Tab:CreateToggle({
   Name = "Auto Kill Boss",
   CurrentValue = false,
   Flag = "Toggle1",
   Callback = function(Value)
        if not Value then return end
        local SpawnerPos = Workspace.Objects.Spawns.BossSpawn.Position
        local tween = TweenServiceTP(SpawnerPos)
        tween:Play()
        tween.Completed:Wait()
        task.wait(4)
        local mobs = Workspace.Objects.Mobs
        for i, mob in pairs(mobs:GetChildren()) do
            mob.Humanoid.Health = 0
        end
        click()
        Rayfield:Destroy()
   end,
})

    print('carregado')
end
player.OnTeleport:Connect(function()
    print('teleportado')
    if queueteleport then
        print(queueteleport)
        queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Versalles777/JujutsuInf/refs/heads/main/killboss.lua'))()")
    end
end)
Carregartudo()
