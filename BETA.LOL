

local notificationSound = Instance.new'Sound'
notificationSound.SoundId = 'rbxassetid://6897623656'
notificationSound.Volume = 1
notificationSound.Parent = game.Players.LocalPlayer.PlayerGui

local warningSound = Instance.new'Sound' 
warningSound.SoundId = 'rbxassetid://1570162306'
warningSound.Volume = 1
warningSound.Parent = game.Players.LocalPlayer.PlayerGui

local players = game:GetService'Players'
local replicatedStorage = game:GetService'ReplicatedStorage'
local camera = workspace.CurrentCamera
local runService = game:GetService'RunService'
local UserInputService = game:GetService('UserInputService')
local lighting = game.Lighting
local gameData = replicatedStorage.GameData
local latestRoom = gameData.LatestRoom
local floor = gameData.Floor

local player = players.LocalPlayer
local playerGUI = player.PlayerGui
local mainGUI = playerGUI.MainUI
local mainGame = mainGUI.Initiator.Main_Game
local hints = playerGUI.PermUI.Hints
local remoteListener = mainGame:FindFirstChild'RemoteListener'

local character
character = player.Character
function eyesSpawned()
    local eyes; do
        eyes = workspace:FindFirstChild('BackdoorLookman') or workspace:FindFirstChild('Eyes')
    end

    return eyes ~= nil
end

local rep = 'https://raw.githubusercontent.com/mstudio45/LinoriaLib/main/'

local lib =   loadstring(game:HttpGet(rep.. 'Library.lua'))()
local save =  loadstring(game:HttpGet(rep.. 'addons/SaveManager.lua'))()
local theme = loadstring(game:HttpGet(rep.. 'addons/ThemeManager.lua'))()
local LiveCaption = loadstring(game:HttpGet('https://raw.githubusercontent.com/Cold-Script/Love/main/Live'))()

local Options = getgenv().Options

local window = lib:CreateWindow({
    Title = 'YOU HUB v5 | DOORS 👁️ [BETA] | ' .. player.Name,
    Center = true,
    AutoShow = true,
    TabPadding = 8,
    MenuFadeTime = 0.2
})

-- settings up stuff


local flags = {
    speed = true,
    speedbypass = false,
    noclip = false,
    ncpbypass = false,
    clipPrompts = true,
    auraPrompts = false,
    reachPrompts = true,
    fly = false,
    esp = false,
    espRainbow = false,
    tracers = false,
    fov = true,
    fb = false,
    betterEnvironment = false,
    padLock = true,
    thirdperson = false,
    doorreach = true,
    voiddisabler = true
}

local AntiEntity = {
    Screech =  false,
    Figure = false,
    Seek = false,
    A90 = false,
    Snare = false,
    Eyes = false,
    Obstruction = false
}
local v16={espdoors=false,espkeys=false,espitems=false,espbooks=false,esprush=false,espchest=false,esplocker=false,esphumans=false,espgold=false,goldespvalue=1061 -(810 + 251) ,hintrush=false,hintrushhee=false,light=false,instapp=false,noseek=false,nogates=false,nopuzzle=false,noa90=false,noskeledoors=false,noseekarmsfire=false,noscreech=false,nodupe=false,getcode=false,getcodet=false,roomsnolock=false,draweraura=false,autorooms=false,itemsaura=false,autopulllever=false,bookcollecter=false,breakercollecter=false};local v17={table.unpack(v16)};local v18={doors={},keys={},items={},books={},entity={},chests={},lockers={},people={},gold={}};
local v22;v22=hookmetamethod(game,"__namecall",function(v75,...)local v76=0 + 0 ;local v77;local v78;while true do if (v76==(0 + 0)) then v77={...};v78=getnamecallmethod();v76=534 -(43 + 490) ;end if (v76==(734 -(711 + 22))) then if ((tostring(v75)=="Screech") and (v78=="FireServer") and getgenv().avoidsc) then local v437=0;while true do if (v437==(0 -0)) then v77[860 -(240 + 619) ]=true;return v22(v75,unpack(v77));end end end if ((tostring(v75)=="ClutchHeartbeat") and (v78=="FireServer") and getgenv().winhb) then v77[2]=true;return v22(v75,unpack(v77));end v76=1 + 1 ;end if (v76==(2 -0)) then return v22(v75,...);end end end);workspace.ChildAdded:Connect(function(v79)task.wait();if ((v79.Name=="RushMoving") or (v79.Name=="AmbushMoving")) then while workspace:FindFirstChild(v79.Name) and getgenv().hxde  do task.wait();part=v79:WaitForChild("RushNew");game.Players.LocalPlayer.Character.Collision.CFrame=CFrame.new(part.Position + Vector3.new(0 + 0 ,1819 -(1344 + 400) ,0) );end end end);

local OldScreechModule = remoteListener.Modules.Screech
local OldA90Module = remoteListener.Modules.A90

local values = {
    speedV = 25,
    fieldOfView = 120,
    speedbypassDelay = .2
}

local speedMethod = 'Walkspeed'

local espColors = {
    [1] = Color3.fromRGB(0, 255, 0),
    [2] = Color3.fromRGB(0, 255, 255),
    [3] = Color3.fromRGB(255, 0, 0)
}

function notify(Text, Duration, Type, Duration)
    lib:Notify(Text, Duration or (Type == 'Entity' and 10 or 5))
    if Type == 'Entity' then warningSound:Play() else notificationSound:Play() end
end

function firep(prompt)
    assert(prompt:IsA'ProximityPrompt', 'not a prompt fucking retard')
    
    prompt.Enabled = true
    if prompt.HoldDuration == 0 then
        fireproximityprompt(prompt, 1)
    else
        task.spawn(function()
            prompt:InputHoldBegin()
            prompt.PromptButtonHoldEnded:Wait()
            prompt:InputHoldEnd()
        end)
    end
end

function getPadlockCode(paper)
    if paper and paper:FindFirstChild("UI") then
        local code = {}

        for i, v in paper.UI:GetChildren() do
            if tonumber(v.Name) then
                code[v.ImageRectOffset.X] = {tonumber(v.Name), '_'}
            end
        end
        
        for i, v in hints:GetChildren() do
            if v.Name == 'Icon' then
                if code[v.ImageRectOffset.X] then
                    code[v.ImageRectOffset.X][2] = v.TextLabel.Text
                end
            end
        end
        local final = {}
        
        for i, v in code do
            final[v[1]] = v[2]
        end
        
        local finalcode = ''
        
        for i, v in final do
            finalcode ..= v
        end
        
        warn(finalcode)

        return finalcode
    end

    return '____'
end

function espAttempt(object, typea, text)
    if not flags.esp then return end
    assert(typea == ('item') or typea == ('roomAsset') or typea == ('entity'), 'type was not provided: '..text)

    local room = latestRoom.Value
    local part; do
        local p, e = pcall(function()
            return object.PrimaryPart
        end)
        if p then
            part = object.PrimaryPart
        else
            part = object
        end
    end

    if text == 'Figure' then
        part = object
    end

    local color; do
        if typea == 'item' then
            notify('ITEM | ' .. text .. ' spawned')
            color = espColors[1]
        elseif typea == 'roomAsset' then
            color = espColors[2]
        elseif typea == 'entity' then
            notify('ENTITY | ' .. text .. ' has spawned', 10, 'Entity')
            color = espColors[3]
        else
            color = Color3.fromRGB(124, 124, 124)
        end
    end
    local highlight = Instance.new'Highlight'; do
        highlight.Parent = object
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillColor = color
        local yess = highlight.OutlineTransparency
        highlight.FillTransparency = 1
        highlight.OutlineTransparency =  1
        game:GetService('TweenService'):Create(highlight, TweenInfo.new(1), {
            FillTransparency = 0.75,
            OutlineTransparency = yess
        }):Play()
        highlight.OutlineColor = color
    end

    local billboard = Instance.new'BillboardGui'; do
        billboard.Adornee = part
        billboard.Parent = part
        billboard.Name = 'zzzzz :yawn:'
        if typea == 'roomAsset' or typea == 'entity' then
            billboard.Size = UDim2.new(8, 0, 2, 0)
        else
            billboard.Size = UDim2.new(3, 0, 0.5, 0)
        end
    end
    

    local label = Instance.new'TextLabel'; do
        label.Size = UDim2.new(1, 0, 1, 0)
        label.FontFace = Font.new('rbxassetid://12187362578')
        label.TextColor3 = color
        label.TextScaled = true
        label.BackgroundTransparency = 1
        label.TextStrokeColor3 = Color3.new()
        label.TextStrokeTransparency = 0
        label.Parent = billboard

        task.spawn(function()
            repeat
                label.Text = string.format('%s\n[ %s ]', (text or part.Name), math.floor((camera.CFrame.Position - part:GetPivot().Position).Magnitude))
                runService.RenderStepped:Wait()
            until label.Parent ~= billboard
        end)
    end

    local tracer = Drawing.new('Line'); do
        tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
        tracer.Color = color
        task.spawn(function()
            repeat
                if flags.tracers and part.Parent ~= nil then
                    local vector, onscreen = camera:WorldToViewportPoint(part.Position)
                    tracer.To = Vector2.new(vector.X, vector.Y)
                    tracer.Visible = onscreen
                else
                    tracer.Visible = false
                end
                runService.RenderStepped:Wait()
            until label.Parent ~= billboard
        end)
    end

    billboard.AlwaysOnTop = true

    task.spawn(function()
        repeat
            if flags.esp then
                highlight.Enabled = true
                billboard.Enabled = true
                if flags.espRainbow then
                    tracer.Color = Color3.fromHSV(tick() % 10 / 10, 1, 1)
                    label.TextColor3 = Color3.fromHSV(tick() % 10 / 10, 1, 1)
                    highlight.FillColor = Color3.fromHSV(tick() % 10 / 10, 1, 1)
                    highlight.OutlineColor = Color3.fromHSV(tick() % 10 / 10, 1, 1)
                else
                    tracer.Color = color
                    label.TextColor3 = color
                    highlight.FillColor = color
                    highlight.OutlineColor = Color3.new(1, 1, 1)
                end
            else
                highlight.Enabled = false
                billboard.Enabled = false
            end
            runService.RenderStepped:Wait()
        until billboard.Parent ~= part
    end)

    if typea ~= 'entity' or text == 'Snare' then
        latestRoom:GetPropertyChangedSignal('Value'):Connect(function()
            task.spawn(function()
                game:GetService('TweenService'):Create(highlight, TweenInfo.new(1), {
                    FillTransparency = 1,
                    OutlineTransparency = 1
                }):Play()
                task.wait(1)
                highlight:Destroy()
                billboard:Destroy()
                label:Destroy()
            end)
        end)
    end
end
notify('[ YOU HUB ] : You Enable Transparency Wardrobe [ Press Right ] ')
local general, exploits, visual = window:AddTab'General', window:AddTab'Exploits', window:AddTab'Visuals'
local group = {
    left = general:AddLeftGroupbox'Speed',
    room = general:AddRightGroupbox'Room',
    entity = exploits:AddRightGroupbox'Anti-Entity',
    right = visual:AddLeftGroupbox'Camera',
    env = visual:AddRightGroupbox'Environment',
    left2 = general:AddRightGroupbox'Misc',
    right2 = exploits:AddLeftGroupbox'Disabled',
    left3 = exploits:AddLeftGroupbox'Minigames',
    prompts = exploits:AddLeftGroupbox'Prompts'
}
-- idk
group.entity:AddToggle('Screech', {
    Text = 'Anti-Screech',
    Default = false,
    Tooltip = 'Screech no more',

    Callback = function(v)
        AntiEntity.Screech = v
    end
})

group.entity:AddToggle('Eyes', {
    Text = 'Anti-Eyes & Anti-Lookman',
    Default = false,
    Tooltip = 'Eyes & Lookman no more',

    Callback = function(v)
        AntiEntity.Eyes = v
    end
})

group.entity:AddToggle('A90', {
    Text = 'Anti-A90',
    Default = false,
    Tooltip = 'A90 no more',

    Callback = function(v)
        AntiEntity.A90 = v
    end
})

group.entity:AddToggle('Obstruction', {
    Text = 'Anti-Obstruction',
    Default = false,
    Tooltip = 'Obstruction no more',

    Callback = function(v)
        AntiEntity.Obstruction = v
    end
})

group.entity:AddToggle('Seek', {
    Text = 'Anti-Seek Trigger',
    Default = false,
    Tooltip = 'Seek no more',

    Callback = function(v)
        AntiEntity.Seek = v
    end
})

group.entity:AddToggle('Figure', {
    Text = 'Anti-Figure [ 50 ]',
    Default = false,
    Tooltip = 'Figure no more',

    Callback = function(v)
        AntiEntity.Figure = v
    end
})
game:GetService("Workspace").DescendantAdded:Connect(function(v186)if  not _G.antibanananana then return;end if v186.IsA(v186,"Part") then if _G.antibanananana then if (v186.Name=="BananaPeel") then v186.CanTouch=false;end end end end);group.entity:AddToggle("MyToggle",{Text="Anti-BananaPeel",Default=false,Tooltip="Anti BananaPeel!",Callback=function(v187)local v188=0;while true do if (v188==(0 + 0)) then _G.antibanananana=v187;if (_G.antibanananana==true) then for v600,v601 in pairs(game:GetService("Workspace"):GetDescendants()) do if v601:IsA("Part") then if (v601.Name=="BananaPeel") then v601.CanTouch=false;end end end end break;end end end});game:GetService("RunService").RenderStepped:Connect(function()pcall(function()if _G.antije then for v413,v414 in pairs(game.workspace:GetChildren()) do if (v414.Name=="JeffTheKiller") then v414.Knife.CanTouch=false;end end for v415,v416 in pairs(game.workspace:GetChildren()) do if (v416.Name=="JeffTheKiller") then v416.Head.CanTouch=false;end end for v417,v418 in pairs(game.workspace:GetChildren()) do if (v418.Name=="JeffTheKiller") then v418.HumanoidRootPart.CanTouch=false;end end for v419,v420 in pairs(game.workspace:GetChildren()) do if (v420.Name=="JeffTheKiller") then v420["Left Arm"].CanTouch=false;end end for v421,v422 in pairs(game.workspace:GetChildren()) do if (v422.Name=="JeffTheKiller") then v422["Left Leg"].CanTouch=false;end end for v423,v424 in pairs(game.workspace:GetChildren()) do if (v424.Name=="JeffTheKiller") then v424["Right Arm"].CanTouch=false;end end for v425,v426 in pairs(game.workspace:GetChildren()) do if (v426.Name=="JeffTheKiller") then v426["Right Leg"].CanTouch=false;end end for v427,v428 in pairs(game.workspace:GetChildren()) do if (v428.Name=="JeffTheKiller") then v428.Torso.CanTouch=false;end end end end);end);
group.entity:AddToggle("MyToggle",{Text="Anti-Jeff The Killer",Default=false,Tooltip="Anti Jeff!",Callback=function(v189)_G.antije=v189;end});

game:GetService("RunService").RenderStepped:Connect(function()pcall(function()if _G.bypassSnare then for v399,v400 in pairs(game.workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Assets"):GetChildren()) do if (v400.Name=="Snare") then v400.Hitbox['TouchInterest']:Destroy();end end end end);end);group.entity:AddToggle("MyToggle",{Text="Anti-Snare",Default=false,Tooltip="Anti Snare",Callback=function(v132)_G.bypassSnare=v132;end});

group.entity:AddToggle("",{Text="Anti-Void Roblox",Default=false,Callback=function(value)
flag.voiddisabler = value 
end})
group.entity:AddToggle("MyToggle",{Text="Anti-Dupe [ No Locked ]",Default=false,Tooltip="Anti Dupe No locked",Callback=function(v128)v16.nodupe=v128;if v128 then local v288;v288=game:GetService("ReplicatedStorage").GameData.LatestRoom:GetPropertyChangedSignal("Value"):Connect(function()task.wait();for v397,v398 in pairs(game:GetService("Workspace").CurrentRooms:GetDescendants()) do if (v398.Name=="DoorFake") then v398.Hidden.CanTouch=false;end end repeat task.wait();until  not v16.nodupe v288:Disconnect();end);end end});
group.entity:AddToggle("MyToggle",{Text="Anti-Halt",Default=false,Tooltip="Anti Halt",Callback=function(v122)local v123=0;while true do if (v123==(1480 -(641 + 839))) then _G.BypassHalte=v122;if (_G.BypassHalte==true) then local v472=913 -(910 + 3) ;local v473;while true do if (v472==(0 -0)) then v473=game:GetService("ReplicatedStorage").ClientModules.EntityModules.Shade;v473.Parent=game.Workspace;break;end end elseif (_G.BypassHalte==false) then local v642=1684 -(1466 + 218) ;local v643;while true do if (v642==(0 + 0)) then v643=game.Workspace.Shade;v643.Parent=game:GetService("ReplicatedStorage").ClientModules.EntityModules;break;end end end break;end end end});
local Toggle = group.entity:AddToggle("BK",{Text = "Anti-Lava",Default = false,Tooltip = "BypassKillbricks",Callback = function(Value)if Value then for _, child in pairs(workspace.CurrentRooms:GetChildren()) do
if child then for _, v in pairs(child:GetDescendants()) do
if v.Name == "Lava" then v.CanTouch = false end end end end ; killBricks = workspace.CurrentRooms.ChildAdded:Connect(function(child)
task.wait(1)if child then for _, v in pairs(child:GetDescendants()) do
if v.Name == "Lava" then v.CanTouch = false end end end end)else
killBricks:Disconnect()
for _, child in pairs(workspace.CurrentRooms:GetChildren()) do
if child then for _, v in pairs(child:GetDescendants()) do
if v.Name == "Lava" then v.CanTouch = true end end end end end end});
group.entity:AddToggle("BS",{Text = "Anti-Scary Wall",Default = false,Tooltip = "BypassSeek",Callback = function(Value)if Value then for _, child in pairs(workspace.CurrentRooms:GetChildren()) do
if child.Parts:FindFirstChild("ScaryWall") then child.Parts.ScaryWall:Destroy() end end
SeekWall = workspace.CurrentRooms.ChildAdded:Connect(function(child)
task.wait(1)
if child.Parts:FindFirstChild("ScaryWall") then child.Parts.ScaryWall:Destroy() end end) else SeekWall:Disconnect() end end});
local Toggle = group.entity:AddToggle("BD",{Text = "Anti-DrakoBloxxers",Default = false,Tooltip = "BypassDrakoBloxxers",Callback = function(Value)if Value then
DrakoBloxxers = workspace.ChildAdded:Connect(function(child)
task.wait(1)
if child.Name == "Drakobloxxer" then child:Destroy() for _, v in pairs(workspace:GetChildren()) do if v.Name == "Sound" and v:IsA("Sound") then v:Destroy() end end end end) else DrakoBloxxers:Disconnect() end end})
game:GetService("RunService").RenderStepped:Connect(function()pcall(function()if _G.MSHNL then if game.workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Assets"):FindFirstChild("Chandelier") then game.workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Assets").Chandelier:Destroy();end end end);end);game:GetService("RunService").RenderStepped:Connect(function()pcall(function()if _G.MSHNL then if game.workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Assets"):FindFirstChild("Light_Fixtures") then game.workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Assets").Light_Fixtures:Destroy();end end end);end)
group.entity:AddToggle("Nlight",{Text = "Anti-Break Light",Default = false,Tooltip = "No Light",Callback = function(NL)_G.MSHNL = NL ;end})

group.room:AddToggle('cv131313m', {
    Text = 'Padlock',
    Default = true,
    Tooltip = 'Automatically does padlock code',
    Callback = function(v)
        flags.padLock = v
    end
})

group.room:AddToggle('cv131313m2233', {
    Text = 'Door reach',
    Default = true,
    Tooltip = 'Automatically opens door for you',
    Callback = function(v)
        flags.doorreach = v
    end
})
group.right:AddLabel('Third person'):AddKeyPicker('cv6mmm', {
    Default = 'V',
    NoUI = false,
    Text = 'Third Person',
    Callback = function(v)
        flags.thirdperson = v
        mainGame.Camera.Enabled = not v
    end
})

group.env:AddToggle('environmentFB', {
    Text = 'FullBright',
    Default = false,
    Tooltip = 'Turns the room bright',
    Callback = function(v)
        if v then
            game.Lighting.Brightness = 3
            game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
            game.Lighting.GlobalShadows = false
        else
            game.Lighting.Brightness = 1
            game.Lighting.OutdoorAmbient = Color3.new(0,0,0)
            game.Lighting.GlobalShadows = true
       end
    end
})
group.env:AddToggle('Envr', {
    Text = 'Better Environment',
    Default = false,
    Tooltip = 'Gives better lighting',
    Callback = function(v)
        flags.betterEnvironment = v
        if flags.betterEnvironment then
            task.spawn(function()
                repeat
                    lighting.OutdoorAmbient = Color3.fromRGB(255,255,255)
                    task.wait()
                until not flags.betterEnvironment
            end)
        else
            lighting.Ambient = workspace.CurrentRooms[player:GetAttribute("CurrentRoom")]:GetAttribute("Ambient")
        end
    end
})
group.env:AddToggle('environmentFB', {
    Text = 'No Fog',
    Default = false,
    Tooltip = 'Turns the room nofog',
    Callback = function(v)
        if v then
            game.Lighting.FogEnd = 9e9
        else
            game.Lighting.FogEnd = 200
       end
    end
})
-- speeeeedd
group.left:AddToggle('cv1', {
    Text = 'Enabled Speed',
    Default = flags.speed,
    Tooltip = 'makes u fast',
    Callback = function(v)
        flags.speed = v
    end
})

group.left:AddSlider('cv2', {
    Text = 'Studs WalkSpeed',
    Default = 25,
    Min = 16,
    Max = 25,
    Rounding = 1,
    Compact = true,
    Callback = function(v)
        values.speedV = v
    end
})

group.left:AddDropdown('cv3', {
    Values = {'Walkspeed', 'Boost', 'CFrameWalk'},
    Text = 'Speed method',
    Default = 'Walkspeed',
    Multi = false,
    Tooltip = 'what method to use for speed',
    Callback = function(v)
        speedMethod = v
    end
})

group.left:AddLabel('Fly - F'):AddKeyPicker('cv6', {
    Default = 'F',
    NoUI = false,
    Text = 'Fly [ PC ]',
    Callback = function(v)
        flags.fly = v
    end
})
-- field of view
group.right:AddToggle('cv4', {
    Text = 'Enabled FOV',
    Default = true,
    Tooltip = 'changes fov',
    Callback = function(v)
        flags.fov = v
    end
})

group.right:AddSlider('cv5', {
    Text = 'FOV',
    Default = 120,
    Min = 70,
    Max = 120,
    Rounding = 1,
    Compact = true,
    Callback = function(v)
        warn(v)
        values.fieldOfView = v
    end
})
group.right:AddButton({Text="Press Key V",Func=function()game:GetService("VirtualInputManager"):SendKeyEvent(true,"V",false,game)
end})
-- noclip
group.left2:AddLabel("Noclip"):AddKeyPicker('cv6', {
    Default = 'N',
    NoUI = false,
    Text = 'Noclip',
    Callback = function(v)
        flags.noclip = v
        if flags.noclip then
            for i, Part in character:GetDescendants() do
                if Part:IsA'BasePart' then
                    local CC = Part.CanCollide
                    task.spawn(function()
                        repeat
                            Part.CanCollide = false
                            task.wait()
                        until not flags.noclip
                        Part.CanCollide = CC
                    end)
                end
            end
        end
    end
})
game:GetService("RunService").RenderStepped:Connect(function()pcall(function()for v243,v244 in next,game.Players.LocalPlayer.Character:GetDescendants() do if (v244.IsA(v244,"BasePart") and getgenv().col) then v244.CanCollide=false;end end end);end);game:GetService("RunService").RenderStepped:Connect(function()pcall(function()if _G.SlowDownnnonononoo then if (game.Players.LocalPlayer.Character.Head.Massless==true) then local v451=1726 -(1668 + 58) ;local v452;while true do if (v451==(626 -(512 + 114))) then v452=false;game.Players.LocalPlayer.Character.Head.Massless=v452;game.Players.LocalPlayer.Character.LeftFoot.Massless=v452;game.Players.LocalPlayer.Character.LeftHand.Massless=v452;v451=2 -1 ;end if ((1 -0)==v451) then game.Players.LocalPlayer.Character.LeftLowerArm.Massless=v452;game.Players.LocalPlayer.Character.LeftLowerLeg.Massless=v452;game.Players.LocalPlayer.Character.LeftUpperArm.Massless=v452;game.Players.LocalPlayer.Character.LeftUpperLeg.Massless=v452;v451=6 -4 ;end if (v451==(2 + 1)) then game.Players.LocalPlayer.Character.RightLowerLeg.Massless=v452;game.Players.LocalPlayer.Character.RightUpperArm.Massless=v452;game.Players.LocalPlayer.Character.RightUpperLeg.Massless=v452;game.Players.LocalPlayer.Character.UpperTorso.Massless=v452;break;end if (v451==2) then game.Players.LocalPlayer.Character.LowerTorso.Massless=v452;game.Players.LocalPlayer.Character.RightFoot.Massless=v452;game.Players.LocalPlayer.Character.RightHand.Massless=v452;game.Players.LocalPlayer.Character.RightLowerArm.Massless=v452;v451=3;end end end end end);end);group.left2:AddToggle("MyToggle",{Text="No Slow Downing",Default=false,Tooltip="No Slow Down",Callback=function(v85)_G.SlowDownnnonononoo=v85;if (_G.SlowDownnnonononoo==false) then local v245=true;game.Players.LocalPlayer.Character.Head.Massless=v245;game.Players.LocalPlayer.Character.LeftFoot.Massless=v245;game.Players.LocalPlayer.Character.LeftHand.Massless=v245;game.Players.LocalPlayer.Character.LeftLowerArm.Massless=v245;game.Players.LocalPlayer.Character.LeftLowerLeg.Massless=v245;game.Players.LocalPlayer.Character.LeftUpperArm.Massless=v245;game.Players.LocalPlayer.Character.LeftUpperLeg.Massless=v245;game.Players.LocalPlayer.Character.LowerTorso.Massless=v245;game.Players.LocalPlayer.Character.RightFoot.Massless=v245;game.Players.LocalPlayer.Character.RightHand.Massless=v245;game.Players.LocalPlayer.Character.RightLowerArm.Massless=v245;game.Players.LocalPlayer.Character.RightLowerLeg.Massless=v245;game.Players.LocalPlayer.Character.RightUpperArm.Massless=v245;game.Players.LocalPlayer.Character.RightUpperLeg.Massless=v245;game.Players.LocalPlayer.Character.UpperTorso.Massless=v245;end end});
group.left2:AddToggle("MyToggle",{Text="Collision Downing Mode",Default=false,Callback=function(GM)if GM then
local Collison = game.Players.LocalPlayer.Character:FindFirstChild("Collision")
Collison.Position = Collison.Position - Vector3.new(0,10,0)
else
local Collison = game.Players.LocalPlayer.Character:FindFirstChild("Collision")
Collison.Position = Collison.Position - Vector3.new(0,-10,0)end;end})
group.left2:AddButton({Text="Press Key N",Func=function()game:GetService("VirtualInputManager"):SendKeyEvent(true,"N",false,game)
end})
group.left2:AddButton({Text="Reset Character",DoubleClick=true,Func=function()game.Players.LocalPlayer.Character.Humanoid.Health=0
end})
-- esp
local promptsToAura = {}
local reachedPrompts = {}
local auraPrompts = {
    'ActivateEventPrompt',
    'HerbPrompt',
    'LootPrompt',
    'ModulePrompt'
}

local reach; do
    reach = 7
end

function roomAdded(newRoom)
    local room = workspace.CurrentRooms[latestRoom.Value]
    local assets = room:WaitForChild'Assets'
    
    task.spawn(function()
        repeat
            if flags.doorreach then
                room.Door.ClientOpen:FireServer()
            end
            task.wait()
        until room ~= workspace.CurrentRooms[latestRoom.Value]
    end)

    local function descendants(v)

        if AntiEntity.Obstruction then
            if v.Name == 'AnimatorPart' or v.Name == 'HurtPart' then
                v.CanTouch = false
                v.Transparency = 1
                v:ClearAllChildren()
            end
        end

        if AntiEntity.Seek then
            if v:IsA'BasePart' and v.Parent and v.Parent.Name == 'TriggerEventCollision' and v.Name == 'Collision' then
                v.CanTouch = false
            end
        end

        if v:IsA'ProximityPrompt' then
            if flags.clipPrompts then
                v.RequiresLineOfSight = false
            end
            if flags.reachPrompts then
                task.spawn(function()
                    repeat
                        v.MaxActivationDistance = 7 + reach
                        task.wait()
                    until v.Parent == nil
                end)
            end
            if table.find(auraPrompts, v.Name) and flags.auraPrompts then
                task.spawn(function()
                    wait(1.5)
                    repeat
                        if v:IsA'ProximityPrompt' then
                            local interaction = 'Interactions'..player.Name
                            if v:GetAttribute(interaction) then return end
                            firep(v)
                        end
                        task.wait()
                    until v.Parent == nil
                end)
            end
        end

        task.spawn(function()
            if v.Name == 'Key' then
                espAttempt(v:FindFirstAncestor'KeyObtain', 'item', 'Key')
            elseif v.Name == 'LiveHintBook' then
                espAttempt(v, 'item', 'Book')
            elseif v.Name == 'TimerLever' then
                espAttempt(v, 'item', 'Lever')
            elseif v.Name == 'FigureRagdoll' then
                if AntiEntity.Figure then
                    for i,v2 in v:GetDescendants() do
                        pcall(function()
                            v2.CanCollide = false
                        end)
                    end
    
                    task.spawn(function()
                        repeat
                            task.wait()
                            v:PivotTo(v:GetPivot() * CFrame.new(0, -2, 1) * CFrame.Angles(0, math.rad(10), 0))
                        until v.Parent == nil
                        notify('[ YOU HUB ] : Library Ez 🤑🤑🤑')
                    end)
                end

                espAttempt(v, 'entity', 'Figure')
            elseif v.Name == 'Snare' then
                
                if AntiEntity.Snare then
                    v.CanTouch = false
                end

                espAttempt(v, 'entity', 'Snare')
            elseif v.Name:match('Pickup') then
                espAttempt(v, 'item', v.Name:match'LiveBreakerPolePickup' and 'Breaker' or v.Name)
            elseif v.Name == 'GoldPile' then
                espAttempt(v, 'item', 'Gold [' .. v:GetAttribute'GoldValue' .. ']')
            end
        end)
    end

    for i,v in room:GetDescendants() do
        descendants(v)
    end

    room.DescendantAdded:Connect(descendants)
    
    for i,v in assets:GetChildren() do
        if v.Name == 'Wardrobe' or v.Name == 'Toolshed' or v.Name == 'Rooms_Locker' then
            espAttempt(v, 'roomAsset', 'Closet')
        end
    end
    espAttempt(room.Name == '50' and room.Door or floor.Value == 'Rooms' and room.Door or room.Door.Door, 'roomAsset', room:GetAttribute('RequiresKey') and 'Locked Door' or 'Door')
end

function workspaceAdded(entity)
    task.wait(0.01)
    if player:DistanceFromCharacter(entity.PrimaryPart.Position) <= 2000 then
        entity.PrimaryPart.Transparency = 1
        entity.PrimaryPart.Material = Enum.Material.SmoothPlastic
        espAttempt(entity, 'entity', entity.Name:split('Moving')[1] or entity.Name:split('Backdoor')[1] or entity.Name)
    end
end

workspace.ChildAdded:Connect(workspaceAdded)

roomAdded()

workspace.CurrentRooms.ChildAdded:Connect(roomAdded)


-- prompts

local exitKeys = {
    Enum.KeyCode.W,
    Enum.KeyCode.A,
    Enum.KeyCode.S,
    Enum.KeyCode.D
}

game:GetService('ProximityPromptService').PromptTriggered:Connect(function(prompt)
    if prompt.Parent.Name == 'Wardrobe' or prompt.Parent.Name == 'Toolshed' or prompt.Parent.Name == 'RetroWardrobe' or prompt.Parent.Name == 'Backdoor_Wardrobe' then
        local ogTransparency = {}
        for i, v in pairs(prompt.Parent:GetDescendants()) do
            pcall(function()
                ogTransparency[v.Name] = v.Transparency
                v.Transparency = 0.75
            end)
        end
        task.wait(1)
        task.spawn(function()
            repeat
                if not UserInputService:GetFocusedTextBox() and UserInputService:IsKeyDown(exitKeys[1]) or UserInputService:IsKeyDown(exitKeys[2]) or UserInputService:IsKeyDown(exitKeys[3]) or UserInputService:IsKeyDown(exitKeys[4]) then
                    for i, v in pairs(prompt.Parent:GetDescendants()) do
                        pcall(function()
                            v.Transparency = ogTransparency[v.Name]
                        end)
                    end
                    remoteFolder.CamLock:FireServer()
                    break
                end
                task.wait()
            until false
        end)
    end
end)
game.Players.LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()if (_G.ClosetExitFix and (game.Players.LocalPlayer.Character:GetAttribute("Hiding")==true)) then game:GetService("ReplicatedStorage").EntityInfo.CamLock:FireServer();end end);group.right2:AddToggle("MyToggle",{Text="Disable Error Closet",Default=false,Tooltip="Closet Exit Fast",Callback=function(v104)_G.ClosetExitFix=v104;end})

game:GetService("RunService").RenderStepped:Connect(function()pcall(function()if _G.NoluckNoob then if game.workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("RoomsDoor_Entrance") then game.workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("RoomsDoor_Entrance").Chain1:Destroy();game.workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("RoomsDoor_Entrance").Chain2:Destroy();game.workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("RoomsDoor_Entrance").Model:Destroy();game.workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("RoomsDoor_Entrance").SkullLock:Destroy();game.workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("RoomsDoor_Entrance").Door.EnterPrompt.Enabled=true;end end end);end);group.right2:AddToggle("MyToggle",{Text="Disable Locked A-000",Default=false,Tooltip="A-000 No lock",Callback=function(v101)_G.NoluckNoob=v101;end});

group.right2:AddToggle("MyToggle",{Text="Disable Gate Door",Default=false,Tooltip="Remove Gate Doors",Callback=function(v115)v16.nogates=v115;if v115 then spawn(function()for v390,v391 in pairs(workspace.CurrentRooms:GetChildren()) do local v392=0;local v393;while true do if ((881 -(614 + 267))==v392) then v393=v391:WaitForChild("Gate",34 -(19 + 13) );if v393 then local v798=v393:WaitForChild("ThingToOpen",2 -0 );if v798 then v798:Destroy();end end break;end end end end);local v278;v278=workspace.CurrentRooms.ChildAdded:Connect(function(v327)local v328=0 -0 ;local v329;while true do if (v328==(0 -0)) then v329=v327:WaitForChild("Gate",1 + 1 );if v329 then local v742=0 -0 ;local v743;while true do if (v742==(0 -0)) then v743=v329:WaitForChild("ThingToOpen",1814 -(1293 + 519) );if v743 then v743:Destroy();end break;end end end break;end end end);spawn(function()local v330=0 -0 ;local v331;while true do if ((0 -0)==v330) then v331=workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Gate",3 -1 );if v331 then local v744=0;local v745;while true do if (v744==(0 -0)) then v745=v331:WaitForChild("ThingToOpen",4 -2 );if v745 then v745:Destroy();end break;end end end break;end end end);repeat task.wait();until  not v16.nogates v278:Disconnect();end end});

group.right2:AddToggle("MyToggle",{Text="Disable Puzzle Picture",Default=false,Tooltip="Remove Puzzle Doors",Callback=function(v117)local v118=0 + 0 ;while true do if (v118==0) then v16.nopuzzle=v117;if v117 then spawn(function()for v634,v635 in pairs(workspace.CurrentRooms:GetChildren()) do local v636=0 + 0 ;local v637;local v638;while true do if (v636==(0 -0)) then v637=v635:WaitForChild("Assets");v638=v637:WaitForChild("Paintings",1 + 1 );v636=1 + 0 ;end if (v636==(1 + 0)) then if v638 then local v885=v638:WaitForChild("MovingDoor",1098 -(709 + 387) );if v885 then v885:Destroy();end end break;end end end end);local v466;v466=workspace.CurrentRooms.ChildAdded:Connect(function(v535)local v536=v535:WaitForChild("Assets");local v537=v536:WaitForChild("Paintings",1860 -(673 + 1185) );if v537 then local v746=0 -0 ;local v747;while true do if (v746==0) then v747=v537:WaitForChild("MovingDoor",6 -4 );if v747 then v747:Destroy();end break;end end end end);spawn(function()local v538=0;local v539;local v540;while true do if (v538==0) then v539=workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Assets");v540=v539:WaitForChild("Paintings",2);v538=1 -0 ;end if (v538==(1 + 0)) then if v540 then local v867=v540:WaitForChild("MovingDoor",2 + 0 );if v867 then v867:Destroy();end end break;end end end);repeat task.wait();until  not v16.nopuzzle v466:Disconnect();end break;end end end});

group.left3:AddToggle("MyToggle",{Text="Auto-Heartbeat [ Minigame ]",Default=false,Tooltip="Win Heartbeat MiniGame",Callback=function(v97)getgenv().winhb=v97;end});game:GetService("RunService").RenderStepped:Connect(function()pcall(function()if _G.AutoBreaker then game:GetService("ReplicatedStorage").EntityInfo.EBF:FireServer();end end);end);group.left3:AddToggle("MyToggle",{Text="Auto-Breaker [ Minigame ]",Default=false,Tooltip="Breaker Box Minigame So Ez",Callback=function(v102)_G.AutoBreaker=v102;end});


group.prompts:AddToggle("",{Text="Clip Prompts",Callback=function(value)flag.clipPrompts = value end})

group.prompts:AddToggle('cv14', {
    Text = 'Reach',
    Tooltip = 'Use prompts from a distance',
    Default = true,
    Callback = function(v)
        flags.reachPrompts = v
    end
})

group.prompts:AddSlider('cv15', {
    Text = 'Distance',
    Default = 7,
    Min = 7,
    Max = 30,
    Rounding = 1,
    Compact = true,
    Callback = function(v)
        reach = v
    end
})

-- connections
local frame = {
    Counter = 0,
    Timer = tick()
}
local fps = 0

local watermarkConnection = runService.RenderStepped:Connect(function(deltaTime)
    frame.Counter += 1
    
    if (tick() - frame.Timer) >= 1 then
        frame.Timer = tick()
        fps = frame.Counter
        frame.Counter = 0
    end

    local watermark = ('YOU HUB v5 | DOORS 👁️ [BETA] | %s fps'):format(fps)

    lib:SetWatermark(watermark)
end)

-- mainscript
local speedbypassCVM = tick()
local flyvelo = Instance.new('BodyVelocity'); do
    flyvelo.Velocity = Vector3.zero
    flyvelo.MaxForce = Vector3.one * 9e9
end

local NoAccel = PhysicalProperties.new(100, 2, 0, 100, 0)
character.Collision.CollisionCrouch.Massless = true
character.Collision.CollisionCrouch.CanCollide = false

function OnCharacterAdded(Character)
    Character.ChildAdded:Connect(function(Object)
        task.wait(.5)
        if Object:IsA'Tool' then
            if Object.Name == 'LibraryHintPaper' and flags.padLock then
                notify(string.format('The current code is: %s', getPadlockCode(Object)))
                
                if tonumber(getPadlockCode(Object)) then
                    remoteFolder.PL:FireServer(tostring(getPadlockCode(Object)))
                end
            end
        end
    end)
end

player.CharacterAdded:Connect(OnCharacterAdded)
OnCharacterAdded(character)

runService.RenderStepped:Connect(function(delta)
    game:GetService('ProximityPromptService').MaxPromptsVisible = 50
    character = player.Character
    character.HumanoidRootPart.CustomPhysicalProperties = NoAccel
    character.Collision.CustomPhysicalProperties = NoAccel
    character.Collision.CollisionCrouch.CustomPhysicalProperties = NoAccel
    task.spawn(function()
        if flags.speed then -- speed
            if speedMethod == 'Walkspeed' then
                character.Humanoid.WalkSpeed = values.speedV
            elseif speedMethod == 'Boost' then
                character.Humanoid:SetAttribute('SpeedBoostBehind', values.speedV)
            elseif speedMethod == 'CFrameWalk' then
                character:TranslateBy(character.Humanoid.MoveDirection * (values.speedV / 1.23) / 100)
            end
            if (tick() - speedbypassCVM) >= values.speedbypassDelay then
                character.Collision.Massless = not character.Collision.Massless
                speedbypassCVM = tick()
            end
        else
            speedbypassCVM = tick()
        end
    end)
    
    task.spawn(function()
        if flags.fb then
            game.Lighting.Brightness = 3
            game.Lighting.OutdoorAmbient = Color3.new(1,1,1)
        else

            game.Lighting.Brightness = 1
            game.Lighting.OutdoorAmbient = Color3.new(0,0,0)
        end
    end)

    task.spawn(function()
        if flags.voiddisabler then
            workspace.FallenPartsDestroyHeight = 0 / 0 -- otherwise known as nan! (a number below -math.huge)
        else
            workspace.FallenPartsDestroyHeight = OldVoid
        end
    end)

    task.spawn(function()
        if flags.thirdperson then
            camera.CameraType = Enum.CameraType.Custom
            character.HumanoidRootPart.CFrame = CFrame.new(character.HumanoidRootPart.Position) * CFrame.fromOrientation(0, ({camera.CFrame:ToOrientation()})[2], 0)
            character.Head.Transparency = 0
            for i, v in character:GetChildren() do
                if v:IsA'Accessory' and v.Name:lower():match('accessory') then
                    for name, src in v:GetChildren() do
                        pcall(function()
                            src.Transparency = 0
                        end)
                    end
                end
            end
        else
            camera.CameraType = Enum.CameraType.Scriptable
            character.Head.Transparency = 1
            for i, v in character:GetChildren() do
                if v:IsA'Accessory' and v.Name:lower():match('accessory') then
                    for name, src in v:GetChildren() do
                        pcall(function()
                            src.Transparency = 1
                        end)
                    end
                end
            end
        end
    end)

    task.spawn(function()
        flyvelo.Parent = flags.fly and character.HumanoidRootPart or nil
        flyvelo.Name = math.random(1000, 9999)
        if flags.fly then
            local add = Vector3.zero

            if UserInputService:IsKeyDown(Enum.KeyCode.W) then add += camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then add -= camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then add += camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then add -= camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then add += camera.CFrame.UpVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then add -= camera.CFrame.UpVector end

            flyvelo.Velocity = add * (values.speedV * 20) / 300 * 22
        end
    end)

    if eyesSpawned() then
        if AntiEntity.Eyes then
            if eyesSpawned() then
                remoteFolder.MotorReplication:FireServer(0, -90, 0, false)
            end
        end
    end

    task.spawn(function()
        if flags.fov then
            camera.FieldOfView = values.fieldOfView
        else
            camera.FieldOfView = 70
        end
    end)

    pcall(function()
        if AntiEntity.Screech then
            OldScreechModule.Name = 'lol'
        end

        if AntiEntity.A90 then
            OldA90Module.Name = 'blahhh'
        end
    end)
end)

-- finishing up

lib.ToggleKeybind = Options.MenuKeybind

local configuration = window:AddTab'Configuration'
do
local configuratio = configuration:AddLeftGroupbox("Menu")
configuratio:AddButton({Text="Unload Library",DoubleClick=true,Func=function()
Library:Unload()
end})
configuratio:AddToggle("yre",{Text="Keyboard",Default=false,Callback=function(value)
lib.KeybindFrame.Visible = value
end})
    theme:SetLibrary(lib)
    save:SetLibrary(lib)
    save:IgnoreThemeSettings()
    save:SetIgnoreIndexes({ 'MenuKeybind' })
    theme:SetFolder('baa')
    save:SetFolder('baa/doors')
    save:BuildConfigSection(configuration)
    theme:ApplyToTab(configuration)
    save:LoadAutoloadConfig()
end
