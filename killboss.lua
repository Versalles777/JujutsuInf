local cloneref = cloneref or function(o) return o end
COREGUI = cloneref(game:GetService("CoreGui"))
Players = cloneref(game:GetService("Players"))

if not game:IsLoaded() then
print('carregando v2')
    local notLoaded = Instance.new("Message")
    notLoaded.Parent = COREGUI
    notLoaded.Text = "Carregando"
    game.Loaded:Wait()
    notLoaded:Destroy()
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

    local Tab = Window:CreateTab("Boss", "rewind")
    local Workspace = game:GetService('Workspace')
    local Button = Tab:CreateButton({
        Name = "Kill boss",
        Callback = function()
            local mobs = Workspace.Objects.Mobs
            for i, mob in pairs(mobs:GetChildren()) do
                mob.Humanoid.Health = 0
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
