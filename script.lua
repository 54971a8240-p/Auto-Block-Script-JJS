print("[AutoBlock] Running")

loadstring(game:HttpGet("https://raw.githubusercontent.com/neaxusxgod-png/NonUI/main/NonUI.lua"))()
local Non = _G.NonUI or NonUI
if not Non then print("[AutoBlock] ERROR: NonUI failed to load") return end

local Players   = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer      = Players.LocalPlayer
local CharactersFolder = Workspace:WaitForChild("Characters")

local COUNTERS = {
    ["Eye Catching"]  = 0x33,
    ["Manji Kick"]    = 0x34,
    ["Head Splitter"] = 0x34,
}

local BlockAnimations   = {}
local AbilityAnimations = {}
local DashAnimations    = {}
do
    local b = {
        -- M1's Every Character!
        "127851700400958", "72548435296350", "84547415708554", "92966188946988",
        "134243365075812", "95295463826732", "105077924973072", "124862357369335",
        "81630213087988", "109299799610861", "94588892125071", "97868312130612",
        "140588454098230", "138826758216894", "75337033003776", "138489871864252",
        "96185406489877", "105287938257399", "126277739156443", "99710481887795",
        "121322029260156", "122655618588472", "96327114254575", "107029561762376",
        "117831239064143", "133936641185614", "122573730331631", "82400997593751",
        "118634493886688", "133240987753043", "130806585141471", "131967150738931",
        "84442064935420", "98783064085844", "85148168523745", "108686045412945",
        "79718433989469", "101283990868172", "108708446862011", "77583711129628",
        "116910683335467", "84359513001979", "79436586236026", "102285403332509",
        "104137631480391", "92698956945928", "85068785050521", "79086910454958",
        "108027796023968", "99205259396653", "131909724908049", "72575786212990",
        "119248903710146", "123168328205349", "125689391910002", "84080901810314",
        "139833047658617", "79271374075726", "133447840605824", "113963875117859",
        "106282708121342", "101681158700275", "114985590391235", "108449614447004",
        "122170399962557", "117638619792450", "105961366724096", "86519781516542",
        "123591522021548", "124726819047447", "119042572747325", "111750364977569",
        "73456086297777", "87792276744794", "136978371933277", "100040983719699",
        "136466703751033", "129583539805939",
    }
    local a = {
        -- Gojo
        "95421145178968", "137654778575373", "104749346956269", "137865634124104",
        -- Yuji
        "77200218033775", "124901309160375",
        -- Hakari
        "82541714192027", "72063002791216", "72467492674240", "108123475959041",
        -- Megumi
        "116432619539029",
        -- Mahito
        "103493656287292", "89092734635186", "72475960800126",
        -- Choso
        "127171275866632", "84039122607068", "100446064103831",
        -- Todo
        "84737448668938", "111720035828971",
        -- Higuruma
        "89652378115594", "133869529005453", "135411487367370", "86362077638309",
        -- Yuta
        "125904281673524", "89582140026963", "95077220586856", "108418554887656",
        -- Mechamaru
        "120136894011461", "93901924492394", "87472283043607", "114277419400774",
        "78540995456941", "119635500264882", "139595086016682", "118069379726477",
        "105934922038894",
        -- Naoya
        "101079657277587", "118607369830566", "86045680364061", "119211164876773",
        -- Nanami
        "130957217409359", "81210313723714", "100811576955331", "113359849246757",
        -- Ryu
        "73243807139765", "114822879878184", "138826705245289", "70394890117813",
        -- Ko-Guy
        "129678103897608", "129132347098646", "134777193523837", "121550561336691",
        -- Yuki
        "115097960689033", "94347210073500", "104793932628579", "77833820443705",
        -- Charles
        "103013818601982", "79860101129549", "72932825817330",
        -- Haruta
        "120914276661831", "133303451091615", "102053631728986", "76957377224584",
        -- Mei Mei
        "126362899488198", "90781290293652", "81007905598407",
        -- Kurourushi
        "83430571986421", "78636717376287", "104082985552315", "85938446097801",
        "116119661056362",
    }
    local d = {
        "110978068388232",
    }
    for _, id in ipairs(b) do BlockAnimations[id]   = true end
    for _, id in ipairs(a) do AbilityAnimations[id] = true end
    for _, id in ipairs(d) do DashAnimations[id]    = true end
end

local IA = { CD = 0x18, CN = 0x08 }
local AA = { NN = 0x10, AL = 0xB50 }
local TA = { AN = 0xB8, AI = 0xC0 }

local function rp(a)
    if not a or a <= 4096 then return nil end
    local ok, v = pcall(memory_read, "uintptr_t", a)
    return (ok and v and v > 4096) and v or nil
end

local function rs(a)
    if not a or a <= 4096 then return nil end
    local ok, v = pcall(memory_read, "string", a)
    return ok and v or nil
end

local function gcn(a)
    local d = rp(a + IA.CD)
    local n = d and rp(d + IA.CN)
    return n and rs(n) or nil
end

local function scanMem(addr)
    local head = rp(addr + AA.AL)
    if not head then return nil, nil, nil end
    local node = rp(head)
    if not node or node == head then return nil, nil, nil end
    local bId, dId, aId, i = nil, nil, nil, 0
    while node and node ~= 0 and node ~= head and i < 30 do
        i = i + 1
        local ta = rp(node + AA.NN)
        if ta and gcn(ta) == "AnimationTrack" then
            local ap = rp(ta + TA.AN)
            if ap and gcn(ap) == "Animation" then
                local id = rs(rp(ap + TA.AI))
                id = id and id:match("%d+$")
                if id then
                    if BlockAnimations[id]   then bId = id break end
                    if DashAnimations[id]    then dId = id end
                    if AbilityAnimations[id] then aId = id break end
                end
            end
        end
        node = rp(node)
    end
    return bId, dId, aId
end

local function getRoot(char)
    return char:FindFirstChild("HumanoidRootPart")
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("Torso")
end

local function enemyFacingMe(eRoot, myPos)
    local dir  = myPos - eRoot.Position
    local flat = Vector3.new(dir.X, 0, dir.Z)
    if flat.Magnitude < 0.1 then return true end
    local look = Vector3.new(eRoot.CFrame.LookVector.X, 0, eRoot.CFrame.LookVector.Z)
    if look.Magnitude < 0.01 then return true end
    return look.Unit:Dot(flat.Unit) >= 0.3
end

local isHeld          = false
local lastChar        = nil
local counterCooldown = 0
local lingerUntil     = 0
local LINGER_TIME     = 0.15
local lastBlockedId   = nil

local state = {
    blockEnabled      = false,
    blockMelee        = true,
    blockDash         = true,
    blockAbility      = true,
    meleeRange        = 8,
    dashRange         = 20,
    abilityRange      = 15,
    blockHold         = 0.4,
    counterEnabled    = false,
    counterChoice     = "Eye Catching",
    counterMelee      = true,
    counterDash       = true,
    counterAbility    = true,
    meleeCRange       = 10,
    dashCRange        = 15,
    abilityCRange     = 12,
    counterHold       = 0.1,
}

local Window     = Non:CreateWindow({ Title = "JJS Script", Folder = "JJSScript", Theme = "Dark" })
local Main       = Window:Section({ Title = "Main" })
local BlockTab   = Main:Tab({ Title = "Auto Block",   Icon = "shield" })
local CounterTab = Main:Tab({ Title = "Auto Counter", Icon = "zap" })

BlockTab:Toggle({ Title = "Auto Block",    Flag = "ab_enabled", Callback = function(v) state.blockEnabled  = v end })
BlockTab:Toggle({ Title = "Block Melee",   Flag = "ab_melee",   Default = true, Callback = function(v) state.blockMelee   = v end })
BlockTab:Toggle({ Title = "Block Dash",    Flag = "ab_dash",    Default = true, Callback = function(v) state.blockDash    = v end })
BlockTab:Toggle({ Title = "Block Ability", Flag = "ab_ability", Default = true, Callback = function(v) state.blockAbility = v end })
BlockTab:Slider({ Title = "Melee Range",   Flag = "ab_mrange",  Min = 1, Max = 50, Default = 8,  Callback = function(v) state.meleeRange   = v end })
BlockTab:Slider({ Title = "Dash Range",    Flag = "ab_drange",  Min = 1, Max = 50, Default = 20, Callback = function(v) state.dashRange    = v end })
BlockTab:Slider({ Title = "Ability Range", Flag = "ab_arange",  Min = 1, Max = 50, Default = 15, Callback = function(v) state.abilityRange = v end })
BlockTab:Slider({ Title = "Hold Duration", Flag = "ab_hold",    Min = 0.05, Max = 1.0, Default = 0.4, Rounding = 2, Callback = function(v) state.blockHold = v end })

CounterTab:Toggle({ Title = "Auto Counter",    Flag = "ac_enabled", Callback = function(v) state.counterEnabled  = v end })
CounterTab:Dropdown({
    Title    = "Counter",
    Flag     = "ac_counter",
    Options  = { "Eye Catching", "Manji Kick", "Head Splitter" },
    Callback = function(v) state.counterChoice = v end,
})
CounterTab:Toggle({ Title = "Counter Melee",   Flag = "ac_melee",   Default = true, Callback = function(v) state.counterMelee   = v end })
CounterTab:Toggle({ Title = "Counter Dash",    Flag = "ac_dash",    Default = true, Callback = function(v) state.counterDash    = v end })
CounterTab:Toggle({ Title = "Counter Ability", Flag = "ac_ability", Default = true, Callback = function(v) state.counterAbility = v end })
CounterTab:Slider({ Title = "Melee Range",     Flag = "ac_mrange",  Min = 1, Max = 50, Default = 10, Callback = function(v) state.meleeCRange   = v end })
CounterTab:Slider({ Title = "Dash Range",      Flag = "ac_drange",  Min = 1, Max = 50, Default = 15, Callback = function(v) state.dashCRange    = v end })
CounterTab:Slider({ Title = "Ability Range",   Flag = "ac_arange",  Min = 1, Max = 50, Default = 12, Callback = function(v) state.abilityCRange = v end })

task.spawn(function()
    while true do
        task.wait(0.008)

        if not state.blockEnabled and not state.counterEnabled then
            if isHeld then pcall(keyrelease, 0x46); isHeld = false end
            continue
        end

        if not isrbxactive() then
            if isHeld then pcall(keyrelease, 0x46); isHeld = false end
            continue
        end

        local BLOCK_KEY    = 0x46
        local maxScan      = math.max(state.meleeRange, state.dashRange, state.abilityRange, state.meleeCRange, state.dashCRange, state.abilityCRange) + 5

        local char = CharactersFolder:FindFirstChild(LocalPlayer.Name)
        if char ~= lastChar then
            if isHeld then pcall(keyrelease, BLOCK_KEY); isHeld = false end
            lingerUntil   = 0
            lastBlockedId = nil
            lastChar      = char
        end
        if not char then continue end

        local localRoot = getRoot(char)
        if not localRoot then continue end
        local myPos = localRoot.Position

        local info    = char:FindFirstChild("Info")
        local stunVal = info and info:FindFirstChild("Stun")
        local stunned = stunVal ~= nil and stunVal.Value == true

        local threatDetected = false
        local counterThreat  = false
        local currentAnimId  = nil

        for _, enemy in ipairs(CharactersFolder:GetChildren()) do
            if enemy.Name == LocalPlayer.Name then continue end

            local eRoot = getRoot(enemy)
            if not eRoot then continue end

            local diff = eRoot.Position - myPos
            local dist = Vector3.new(diff.X, 0, diff.Z).Magnitude
            if dist > maxScan then continue end

            local hum = enemy:FindFirstChildWhichIsA("Humanoid")
            if not hum or hum.Health <= 0 then continue end

            if not enemyFacingMe(eRoot, myPos) then continue end

            local anim = hum:FindFirstChild("Animator")
            if not anim then continue end

            local addr = tonumber(anim.Address)
            if not addr or addr <= 4096 then continue end

            local bid, did, aid = scanMem(addr)

            if bid then
                if dist <= state.meleeRange and state.blockMelee then
                    threatDetected = true
                    currentAnimId  = bid
                end
                if dist <= state.meleeCRange and state.counterMelee then
                    counterThreat = true
                end
            end

            if did then
                if dist <= state.dashRange and state.blockDash then
                    threatDetected = true
                    currentAnimId  = did
                end
                if dist <= state.dashCRange and state.counterDash then
                    counterThreat = true
                end
            end

            if aid then
                if dist <= state.abilityRange and state.blockAbility then
                    threatDetected = true
                    currentAnimId  = aid
                end
                if dist <= state.abilityCRange and state.counterAbility then
                    counterThreat = true
                end
            end
        end

        -- Auto Counter
        if state.counterEnabled and counterThreat and not stunned and not isHeld and tick() > counterCooldown then
            local key = COUNTERS[state.counterChoice]
            if key then
                pcall(keypress, key)
                task.wait(state.counterHold)
                pcall(keyrelease, key)
                counterCooldown = tick() + 0.5
            end
        end

        -- Auto Block — untouched from working version
        if state.blockEnabled and not stunned then
            if threatDetected then
                lingerUntil = tick() + LINGER_TIME
                if not isHeld then
                    isHeld        = true
                    lastBlockedId = currentAnimId
                    local alreadyBlocking = info ~= nil and info:FindFirstChild("Block") ~= nil
                    if not alreadyBlocking then pcall(keypress, BLOCK_KEY) end
                elseif currentAnimId ~= lastBlockedId then
                    lastBlockedId = currentAnimId
                    pcall(keyrelease, BLOCK_KEY)
                    task.wait(0.008)
                    pcall(keypress, BLOCK_KEY)
                end
            elseif isHeld and tick() >= lingerUntil then
                pcall(keyrelease, BLOCK_KEY)
                isHeld        = false
                lastBlockedId = nil
            end
        elseif isHeld then
            pcall(keyrelease, 0x46)
            isHeld        = false
            lastBlockedId = nil
        end
    end
end)
