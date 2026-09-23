-- ============================================================
-- true am am v1.0 - FTAP (SolarisUI Edition)
-- Р§РђРЎРўР¬ 1: РЁР°РїРєР° + РћРєРЅРѕ + Defense (Antis + Anti Kick)
-- ============================================================

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/katnaa-debug/SolarisUI/refs/heads/main/Library1.lua"))()

-- ============================================================
-- KEY SYSTEM (SolarisUI РІСЃС‚СЂРѕРµРЅРЅС‹Р№)
-- ============================================================
Library:KeySystem({
    Key = "Hsu67pocoyo8dt",
    Link = "https://discord.gg/trueamam",
    Title = "true am am | Key System",
    Theme = "Default"
})

print("[true am am] РљР»СЋС‡ РїСЂРёРЅСЏС‚. Р—Р°РіСЂСѓР·РєР°...")

-- ===== РЎР•Р Р’РРЎР« =====
local P   = game:GetService("Players")
local U   = game:GetService("UserInputService")
local R   = game:GetService("RunService")
local RS  = game:GetService("ReplicatedStorage")
local LP  = P.LocalPlayer
local Cam = workspace.CurrentCamera
local OrigFOV = Cam.FieldOfView

-- ===== РЈР”РђР›Р•РќРР• РЎРўРђР РћР“Рћ Р“РЈР =====
if game.CoreGui:FindFirstChild("TrueAmAm") then
    game.CoreGui.TrueAmAm:Destroy()
end

-- ===== РЎРћР—Р”РђРќРР• РћРљРќРђ =====
local Window = Library:CreateWindow({
    Title = "true am am",
    Theme = "Default",
    ToggleKey = Enum.KeyCode.RightShift,
    ShowWatermark = {
        Enabled = true,
        Title = true,
        User = true,
        FPS = true,
        Time = true,
        Ping = true
    },
    CustomIcon = "rbxassetid://10884488899"
})

-- ============================================================
-- Р’РљР›РђР”РљРђ: DEFENSE (Antis)
-- ============================================================
local DefenseTab = Window:CreateTab("Defense", false, "rbxassetid://10734950309")

-- ===== РЎРЎР«Р›РљР РќРђ FTAP-РЎРћР‘Р«РўРРЇ =====
local GrabEvents_Def      = RS:FindFirstChild("GrabEvents")
local SetNetOwner_Def     = GrabEvents_Def and GrabEvents_Def:FindFirstChild("SetNetworkOwner")

local CharEvents_Def      = RS:FindFirstChild("CharacterEvents")
local Struggle_Def        = CharEvents_Def and CharEvents_Def:FindFirstChild("Struggle")
local RagdollRemote_Def   = CharEvents_Def and CharEvents_Def:FindFirstChild("RagdollRemote")

local MenuToys_Def        = RS:FindFirstChild("MenuToys")
local SpawnToy_Def        = MenuToys_Def and MenuToys_Def:FindFirstChild("SpawnToyRemoteFunction")
local DestroyToy_Def      = MenuToys_Def and MenuToys_Def:FindFirstChild("DestroyToy")

local PlayerEvents_Def    = RS:FindFirstChild("PlayerEvents")
local StickyPartEvent_Def = PlayerEvents_Def and PlayerEvents_Def:FindFirstChild("StickyPartEvent")

DefenseTab:CreateSection("Antis")

-- ============================================================
-- 1. AntiGrabV1
-- ============================================================
local antiGrabV1Active = false
local antiGrabV1Task   = nil

DefenseTab:CreateToggle({
    Name = "Anti Grab (Ags)",
    Flag = "AntiGrabV1",
    Default = false,
    Callback = function(Value)
        antiGrabV1Active = Value
        if Value then
            antiGrabV1Task = task.spawn(function()
                while antiGrabV1Active do
                    pcall(function()
                        local isHeld = LP:FindFirstChild("IsHeld")
                        if isHeld and isHeld.Value then
                            local char = LP.Character
                            if char then
                                local hum = char:FindFirstChild("Humanoid")
                                local hrp = char:FindFirstChild("HumanoidRootPart")
                                if hum and hrp then
                                    if Struggle_Def then Struggle_Def:FireServer(LP) end
                                    if RagdollRemote_Def then
                                        RagdollRemote_Def:FireServer(hrp, 0.00000000001)
                                    end
                                    if hum.Sit then hum.Sit = false end
                                end
                            end
                        end
                    end)
                    task.wait(0.05)
                end
            end)
        else
            if antiGrabV1Task then
                task.cancel(antiGrabV1Task)
                antiGrabV1Task = nil
            end
        end
    end
})

-- ============================================================
-- 2. AntiGrabV2
-- ============================================================
local antiGrabV2Active = false
local antiGrabV2Task   = nil

DefenseTab:CreateToggle({
    Name = "Anti Grab Best (seatless gucci)",
    Flag = "AntiGrabV2",
    Default = false,
    Callback = function(Value)
        antiGrabV2Active = Value
        if Value then
            antiGrabV2Task = task.spawn(function()
                local hkAGSt, hkAGModel, hkPlot = nil, nil, nil
                while antiGrabV2Active do
                    pcall(function()
                        local plr = LP
                        local plotsFolder = workspace:FindFirstChild("Plots")
                        local plotItems   = workspace:FindFirstChild("PlotItems")

                        if plotsFolder then
                            for _, home in pairs(plotsFolder:GetChildren()) do
                                local sign = home:FindFirstChild("PlotSign")
                                if sign then
                                    local owners = sign:FindFirstChild("ThisPlotsOwners")
                                    if owners then
                                        for _, person in pairs(owners:GetChildren()) do
                                            if person.Value == plr.Name then hkPlot = home.Name end
                                        end
                                    end
                                end
                            end
                        end

                        local myFolder = workspace:FindFirstChild(plr.Name .. "SpawnedInToys")
                        hkAGModel = myFolder and myFolder:FindFirstChild("InstrumentWoodwindOcarina")
                        if not hkAGModel and hkPlot and plotItems then
                            local pf = plotItems:FindFirstChild(hkPlot)
                            if pf then
                                hkAGModel = pf:FindFirstChild("InstrumentWoodwindOcarina")
                            end
                        end

                        if hkAGModel then
                            if plr.Character then
                                for _, prt in pairs(plr.Character:GetChildren()) do
                                    local po = prt:FindFirstChild("PartOwner")
                                    if po and po.Value ~= "" then
                                        local holdPart = hkAGModel:FindFirstChild("HoldPart")
                                        local holdRemote = holdPart and holdPart:FindFirstChild("HoldItemRemoteFunction")
                                        if holdRemote then
                                            task.spawn(function()
                                                pcall(function()
                                                    holdRemote:InvokeServer(hkAGModel, plr.Character)
                                                end)
                                            end)
                                            if DestroyToy_Def then DestroyToy_Def:FireServer(hkAGModel) end
                                            local hum = plr.Character:FindFirstChild("Humanoid")
                                            if hum then
                                                hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                                                hum.AutoRotate = true
                                                if hum.Sit then hum.Sit = false end
                                            end
                                            po.Value = ""
                                        end
                                    end
                                end
                            end
                        else
                            local canSpawn = plr:FindFirstChild("CanSpawnToy")
                            if plr.Character and canSpawn and canSpawn.Value and not hkAGSt then
                                hkAGSt = tick()
                                task.spawn(function()
                                    if SpawnToy_Def then
                                        pcall(function()
                                            SpawnToy_Def:InvokeServer(
                                                "InstrumentWoodwindOcarina",
                                                CFrame.new(1e5, 1e5, 1e5),
                                                Vector3.new(0, 0, 0)
                                            )
                                        end)
                                    end
                                end)
                            elseif hkAGSt and tick() - hkAGSt > 1 and myFolder
                                   and not myFolder:FindFirstChild("InstrumentWoodwindOcarina") then
                                hkAGSt = nil
                            end

                            local grabbed = false
                            if plr.Character then
                                for _, prt in pairs(plr.Character:GetChildren()) do
                                    local po = prt:FindFirstChild("PartOwner")
                                    if po and po.Value ~= "" then grabbed = true end
                                end
                            end

                            if grabbed then
                                if Struggle_Def then Struggle_Def:FireServer(plr) end
                                if plr.Character then
                                    local hum = plr.Character:FindFirstChild("Humanoid")
                                    local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                                    if hum and hrp and RagdollRemote_Def then
                                        RagdollRemote_Def:FireServer(hrp, 0.00000000001)
                                        for _, track in ipairs(hum:GetPlayingAnimationTracks()) do
                                            if track.Animation.AnimationId == "rbxassetid://7047322890" then
                                                track:Stop()
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    task.wait()
                end
            end)
        else
            if antiGrabV2Task then
                task.cancel(antiGrabV2Task)
                antiGrabV2Task = nil
            end
        end
    end
})

-- ============================================================
-- 3. Gucci Anti Grab
-- ============================================================
local gucciActive = false
local gucciTask   = nil

local function FWC(Parent, Name, Time)
    return Parent:FindFirstChild(Name) or Parent:WaitForChild(Name, Time or 3)
end

local function GucciAntiGrab()
    if not gucciActive then return end

    local char = LP.Character or LP.CharacterAdded:Wait()
    local hum  = FWC(char, "Humanoid")
    if not hum then return end

    hum.Sit = true
    task.wait(0.02)
    hum.Sit = false
    task.wait(0.02)

    local hrp = FWC(char, "HumanoidRootPart")

    if SpawnToy_Def then
        pcall(function()
            SpawnToy_Def:InvokeServer(
                "CreatureBlobman",
                hrp.CFrame * CFrame.new(0, 0, -5),
                Vector3.new(0, -15.716, 0)
            )
        end)
    end

    local BackPack = workspace:FindFirstChild(LP.Name .. 'SpawnedInToys')
    if not BackPack then return end

    local Blob
    BackPack.ChildAdded:Once(function(toy)
        if toy.Name == "CreatureBlobman" then Blob = toy end
    end)

    local t0 = tick()
    while not Blob and tick() - t0 < 3 do task.wait(0.05) end
    if not Blob then return end

    local Seat = FWC(Blob, "VehicleSeat")

    for _ = 1, 15 do
        if not gucciActive then break end
        if Seat and Seat.Parent and Seat.Occupant ~= hum then
            Seat:Sit(hum)
        end
        task.wait(0.03)
        if hum.Sit then break end
    end

    task.wait(0.4)
    hum.Sit = false
    Blob.Name = "Gucci"

    for _, p in pairs(Blob:GetChildren()) do
        if p:IsA("BasePart") then
            p.CanCollide = false
            p.CanTouch   = false
            p.CanQuery   = false
        end
    end

    local BHead = Blob:FindFirstChild("Head")
    task.spawn(function()
        while gucciActive and Blob.Parent and BHead do
            BHead.CFrame = CFrame.new(BHead.Position.X, 1e5, BHead.Position.Z)
            task.wait(0.05)
        end
    end)
end

DefenseTab:CreateToggle({
    Name = "Gucci Anti Grab",
    Flag = "GucciAntiGrab",
    Default = false,
    Callback = function(Value)
        gucciActive = Value

        if gucciTask then
            task.cancel(gucciTask)
            gucciTask = nil
        end

        if not Value then
            local BackPack = workspace:FindFirstChild(LP.Name .. 'SpawnedInToys')
            if BackPack then
                for _, v in pairs(BackPack:GetChildren()) do
                    if v.Name == "Gucci" or v.Name == "CreatureBlobman" then
                        if DestroyToy_Def then
                            pcall(function() DestroyToy_Def:FireServer(v) end)
                        end
                    end
                end
            end
            return
        end

        gucciTask = task.spawn(function()
            while gucciActive do
                local BackPack = workspace:FindFirstChild(LP.Name .. 'SpawnedInToys')
                local gucci = BackPack and BackPack:FindFirstChild("Gucci")
                if not gucci then
                    pcall(GucciAntiGrab)
                end
                task.wait(1)
            end
        end)
    end
})

-- ============================================================
-- 4. Anti Kick (СЃСЋСЂРёРєРµРЅ РїРѕ РґРёР°РіРѕРЅР°Р»Рё РЅР° С‚РѕСЂСЃ)
-- ============================================================
local antiKickActive = false
local antiKickTask   = nil
local antiKickToy    = nil
local antiKickSticky = nil

local function CleanAntiKickToy()
    if antiKickToy and antiKickToy.Parent and DestroyToy_Def then
        pcall(function() DestroyToy_Def:FireServer(antiKickToy) end)
    end
    antiKickToy    = nil
    antiKickSticky = nil
end

local function SpawnAntiKickShuriken()
    local char = LP.Character
    if not char then return nil end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return nil end

    local myFolder = workspace:FindFirstChild(LP.Name .. "SpawnedInToys")
    if not myFolder then return nil end

    local canSpawn = LP:FindFirstChild("CanSpawnToy")
    if canSpawn and not canSpawn.Value then return nil end

    -- РЎРїР°РІРЅРёРј СЃСЋСЂРёРєРµРЅ СЂСЏРґРѕРј СЃ HRP
    local spawnCF = hrp.CFrame * CFrame.new(0, 5, 0) * CFrame.Angles(-0.605, -0.321, 0)

    if SpawnToy_Def then
        task.spawn(function()
            pcall(function()
                SpawnToy_Def:InvokeServer("NinjaShuriken", spawnCF, Vector3.new(0, 0, 0))
            end)
        end)
    end

    local toy
    local conn
    conn = myFolder.ChildAdded:Connect(function(child)
        if child.Name == "NinjaShuriken" then
            toy = child
        end
    end)

    local t0 = tick()
    while not toy and tick() - t0 < 3 do task.wait(0.05) end
    if conn then conn:Disconnect() end
    if not toy then return nil end

    -- РЎРєСЂС‹РІР°РµРј СЃСЋСЂРёРєРµРЅ
    for _, v in pairs(toy:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
            v.CanTouch   = false
            v.CanQuery   = false
            v.Transparency = 1
        end
    end

    local sticky = toy:FindFirstChild("StickyPart")
    if not sticky then
        if DestroyToy_Def then pcall(function() DestroyToy_Def:FireServer(toy) end) end
        return nil
    end

    -- Р—Р°Р±РёСЂР°РµРј ownership
    if SetNetOwner_Def then
        for _ = 1, 15 do
            pcall(function() SetNetOwner_Def:FireServer(sticky, sticky.CFrame) end)
            task.wait(0.02)
            local po = sticky:FindFirstChild("PartOwner")
            if po and po.Value == LP.Name then break end
        end
    end

    return toy, sticky
end

local function StickAntiKick()
    local char = LP.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp or not antiKickSticky then return end

    -- РљР»РµРёРј РїРѕ РґРёР°РіРѕРЅР°Р»Рё РЅР° С‚РѕСЂСЃ (HRP)
    local stickCF = CFrame.new(0, -0.5, 0) * CFrame.Angles(math.rad(45), math.rad(45), 0)
    if StickyPartEvent_Def then
        pcall(function()
            StickyPartEvent_Def:FireServer(antiKickSticky, hrp, stickCF)
        end)
    end
end

local function UnstickAntiKick()
    if not antiKickSticky or not antiKickSticky.Parent then return end
    -- РћС‚РєР»РµРёРІР°РµРј вЂ” СѓРІРѕРґРёРј РґР°Р»РµРєРѕ, С‡С‚РѕР±С‹ СЃРµСЂРІРµСЂ СЃРЅСЏР» weld
    pcall(function()
        antiKickSticky.CFrame = CFrame.new(0, 50000, 0)
        antiKickSticky.AssemblyLinearVelocity = Vector3.zero
        antiKickSticky.AssemblyAngularVelocity = Vector3.zero
    end)
end

DefenseTab:CreateToggle({
    Name = "Anti Kick (Shuriken)",
    Flag = "AntiKick",
    Default = false,
    Callback = function(Value)
        antiKickActive = Value

        if antiKickTask then
            task.cancel(antiKickTask)
            antiKickTask = nil
        end

        if not Value then
            CleanAntiKickToy()
            return
        end

        antiKickTask = task.spawn(function()
            while antiKickActive do
                pcall(function()
                    local char = LP.Character
                    if not char then return end
                    local hrp = char:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end

                    -- РЎРїР°РІРЅ СЃСЋСЂРёРєРµРЅР° РµСЃР»Рё РµРіРѕ РЅРµС‚
                    if not antiKickToy or not antiKickToy.Parent
                       or not antiKickSticky or not antiKickSticky.Parent then
                        CleanAntiKickToy()
                        local toy, sticky = SpawnAntiKickShuriken()
                        antiKickToy    = toy
                        antiKickSticky = sticky
                        task.wait(0.2)
                    end

                    if antiKickSticky and antiKickSticky.Parent then
                        -- РџСЂРѕРІРµСЂСЏРµРј ownership
                        local po = antiKickSticky:FindFirstChild("PartOwner")
                        if po and po.Value ~= LP.Name then
                            if SetNetOwner_Def then
                                pcall(function()
                                    SetNetOwner_Def:FireServer(antiKickSticky, antiKickSticky.CFrame)
                                end)
                            end
                        end

                        -- Р”РµСЂР¶РёРј СЃСЋСЂРёРєРµРЅ Сѓ С‚РѕСЂСЃР° (РїРѕ РґРёР°РіРѕРЅР°Р»Рё)
                        StickAntiKick()

                        -- РџРµСЂРёРѕРґРёС‡РµСЃРєРё РѕС‚РєР»РµРёРІР°РµРј Рё РїСЂРёРєР»РµРёРІР°РµРј РѕР±СЂР°С‚РЅРѕ
                        task.wait(0.4)
                        UnstickAntiKick()

                        task.wait(0.05)

                        -- Р’ РІРѕР·РґСѓС…Рµ (РµСЃР»Рё РїРµСЂСЃРѕРЅР°Р¶ РЅРµ РЅР° Р·РµРјР»Рµ) СЃРЅРѕРІР° РїСЂРёРєР»РµРёРІР°РµРј
                        if char a
