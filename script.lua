local Players   = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local LocalPlayer      = Players.LocalPlayer
local CharactersFolder = Workspace:WaitForChild("Characters")

local BlockAnimations = {}
local DashAnimations  = {}
do
    local b = {
        "97901397284754","76470718091246","105028055041290","90926294837924",
        "81426568444338","92796867394473","135686778593679","105571879949076",
        "136466703751033","129583539805939","110425977429691","118433412162663",
        "131033861605339","93880529089759","128247404669136","75985296743258",
        "92045676155777","124726819047447","123591522021548","86519781516542",
        "105961366724096","92698956945928","83782195794718","92966188946988",
        "134243365075812","121322029260156","105077924973072","116910683335467",
        "138169151223960","109598602517674","89537672683114","88849926869776",
        "111083699259354","92081142332466","128267680345523","87792276744794",
        "136978371933277","117638619792450","122170399962557","108449614447004",
        "114985590391235","100040983719699","119152716475706","112976111828157",
        "101681158700275","106282708121342","113963875117859","133447840605824",
        "134917827147266","122074769949629","81708642912019","94781366396051",
        "89394375446962","115446267797335","102085681670810","84602523265622",
        "114913455544468","78540777177847","104137631480391","102285403332509",
        "79436586236026","84359513001979","77284264481284","86109053396974",
        "91853462087608","108376755316792","101107501526373","74580112757879",
        "97207871642820","101283990868172","108708446862011","77583711129628",
        "139899183181812","100919783371339","101862938993177","100835844904897",
        "80504019426174","78540995456941","79718433989469","108686045412945",
        "85148168523745","98783064085844","116462971170564","79860101129549",
        "125689391910002","140597320237985","84080901810314","79271374075726",
        "139833047658617","121403322067812","135256592475167","137919635923292",
        "109432265703187","113432456707949","93796567192197","123778544771528",
        "119438066502737","117465720955224","121158593063065","110326542726854",
        "84442064935420","130135202362252","111750364977569","73456086297777",
        "131967150738931","130806585141471","133240987753043","96433049733325",
        "84989753395518","86626502434817","105878146832347","114375152692460",
        "74550814125588","123236749567737","76273288374330","117318845383884",
        "131279921755936","100474683542881","97215638330770","104087365067491",
        "124777463468279","97504088532041","107825127494342","91990544700842",
        "106474043944206","115586282387431","130284226842903","123168328205349",
        "119248903710146","72575786212990","131909724908049","120951759618134",
        "117831239064143","98577624776161","109340494549365","139280948741186",
        "132855702748568","118634493886688","82400997593751","122573730331631",
        "133936641185614","99205259396653","108027796023968","79086910454958",
        "85068785050521","81630213087988","124862357369335","95295463826732",
        "127851700400958","107029561762376","96327114254575","110351847187022",
        "89888040037257","98845475810982","138626478088332","130659585624615",
        "105870773841535","79568627671998","114562626498918","85887300265206",
        "86918383671100","80150988150906","98365018553171","119042572747325",
        "125120382787311","71784337627181","130013701390383","81786875517933",
        "134461702265323","122655618588472","99710481887795","126277739156443",
        "84870056161157","114797198964940","119434039452526","79037514387169",
        "96513213736303","121800365664070","109718372214725","105287938257399",
        "96185406489877","138489871864252","75337033003776","132281807148575",
        "99451940496871","109299799610861","138826758216894","140588454098230",
        "97868312130612","94588892125071","117045209683198","85569553424083",
        "118417554538697","126525655772712","73686261221181","77624096831098",
        "92144658193162","139078698020363","92337983867412","123906985655392",
        "135190329919676","84413496769668","128524425761051","124812814978068",
        "129392532939530","83843118463884","92424708306981","90981055255583",
        "95002584969527","114648729358082","115220151812065","104148378077935",
        "72211631197834","140487289646129","75961842881209","75425383606016",
        "105376952884290","108636011034323","123414935051274","110146909061402",
        "84547415708554","72548435296350","116432619539029","17324258817",
        "16705392699","137654778575373","137865634124104","110978068388232",
        "104749346956269","124901309160375","89092734635186","132653290201368",
        "121984128639453","101617544363219","75736902190737","118861398234801",
        "132725601768618","77200218033775","82541714192027","72063002791216",
        "79619765411660","81112033595734","115234621584704","84039122607068",
        "127171275866632","100446064103831","94720627091769","111720035828971",
        "89652378115594","124340599144108","71186534081075","129132347098646",
        "129678103897608","134777193523837","79538775132859","85783365130041",
        "84827960380871","72933571933445","103013818601982",
    }
    for _, id in ipairs(b) do BlockAnimations[id] = true end
    for _, id in ipairs({"9443519528"}) do DashAnimations[id] = true end
end

local IA={CD=0x18,CN=0x08}
local AA={NN=0x10,AL=0xB80}
local TA={AN=0xB8,AI=0xC0}
local function rp(a) if not a or a<=4096 then return nil end local ok,v=pcall(memory_read,"uintptr_t",a) return(ok and v and v>4096)and v or nil end
local function rs(a) if not a or a<=4096 then return nil end local ok,v=pcall(memory_read,"string",a) return ok and v or nil end
local function gcn(a) local d=rp(a+IA.CD) local n=d and rp(d+IA.CN) return n and rs(n) or nil end

local function scanMem(addr)
    local head=rp(addr+AA.AL) if not head then return nil,nil end
    local node=rp(head) if not node or node==head then return nil,nil end
    local bId,dId,i=nil,nil,0
    while node and node~=0 and node~=head and i<30 do
        i=i+1
        local ta=rp(node+AA.NN)
        if ta and gcn(ta)=="AnimationTrack" then
            local ap=rp(ta+TA.AN)
            if ap and gcn(ap)=="Animation" then
                local id=rs(rp(ap+TA.AI))
                id=id and id:match("%d+$")
                if id then
                    if BlockAnimations[id] then bId=id break end
                    if DashAnimations[id]  then dId=id end
                end
            end
        end
        node=rp(node)
    end
    return bId,dId
end

local function scanAPI(char)
    local hum=char:FindFirstChildWhichIsA("Humanoid")
    local anim=hum and hum:FindFirstChild("Animator")
    if not anim then return nil,nil end
    local ok,tracks=pcall(function() return anim:GetPlayingAnimationTracks() end)
    if not ok then return nil,nil end
    local bId,dId
    for _,t in ipairs(tracks) do
        if t and t.Animation then
            local id=t.Animation.AnimationId:match("%d+$")
            if id then
                if BlockAnimations[id] then bId=id end
                if DashAnimations[id]  then dId=id end
            end
        end
    end
    return bId,dId
end

local function getRoot(char)
    return char:FindFirstChild("HumanoidRootPart")
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("Torso")
end

local function flat(v) local f=Vector3.new(v.X,0,v.Z) return f.Magnitude<0.01 and Vector3.new(0,0,-1) or f.Unit end
local DOT=0.25
local function isFacing(lr,er) local d=er.Position-lr.Position if Vector3.new(d.X,0,d.Z).Magnitude<0.1 then return true end return flat(lr.CFrame.LookVector):Dot(flat(d))>=DOT end

local isHeld=false
local blockEnd=0
local ActiveThreats={}
local lastChar=nil

UI.AddTab("Auto Block", function(tab)
    local sec = tab:Section("Settings", "Left")
    sec:Toggle("ab_enabled",  "Enable",     false)
    sec:Keybind("ab_kb",      0x00,             "toggle")
    sec:Toggle("ab_melee",    "Block Melee",    true)
    sec:Toggle("ab_dash",     "Block Dash",     true)
    sec:SliderInt("ab_range", "Range",          1, 50, 8)
    sec:SliderFloat("ab_hold","Hold Duration",  0.05, 1.0, 0.4, "%.2f")
end)

task.spawn(function()
    while true do
        task.wait(0.05)

        if not UI.GetValue("ab_enabled") then
            if isHeld then pcall(keyrelease,0x46); isHeld=false end
            continue
        end

        if not isrbxactive() then
            if isHeld then pcall(keyrelease,0x46); isHeld=false end
            continue
        end

        local BLOCK_KEY  = 0x46
        local blockMelee = UI.GetValue("ab_melee")
        local blockDash  = UI.GetValue("ab_dash")
        local range      = UI.GetValue("ab_range")
        local hold       = UI.GetValue("ab_hold")
        local maxScan    = range + 5

        local char = CharactersFolder:FindFirstChild(LocalPlayer.Name)
        if char ~= lastChar then
            if isHeld then pcall(keyrelease,BLOCK_KEY); isHeld=false end
            blockEnd=0; ActiveThreats={}; lastChar=char
        end
        if not char then continue end

        local localRoot = getRoot(char)
        if not localRoot then continue end

        local info    = char:FindFirstChild("Info")
        local stunVal = info and info:FindFirstChild("Stun")
        local stunned = stunVal ~= nil and stunVal.Value == true

        local detected={}
        local bSrc,dSrc,bId,dId

        for _,enemy in ipairs(CharactersFolder:GetChildren()) do
            if enemy.Name==LocalPlayer.Name then continue end
            local eRoot=getRoot(enemy)
            if not eRoot then continue end
            local diff=eRoot.Position-localRoot.Position
            local dist=Vector3.new(diff.X,0,diff.Z).Magnitude
            if dist>maxScan then continue end
            if not enemy:FindFirstChild("Humanoid") then continue end

            local bid,did
            local hum=enemy:FindFirstChildWhichIsA("Humanoid")
            local anim=hum and hum:FindFirstChild("Animator")
            local addr=anim and tonumber(anim.Address)
            if addr then bid,did=scanMem(addr) end
            if not bid and not did then bid,did=scanAPI(enemy) end

            if blockMelee and bid and dist<=range and isFacing(localRoot,eRoot) then
                bSrc=enemy; bId=bid
                detected[enemy.Name.."_"..bid]=true
            end
            if blockDash and did and dist<=range and isFacing(localRoot,eRoot) then
                dSrc=enemy; dId=did
                detected[enemy.Name.."_"..did]=true
            end
        end

        local src   = dSrc or bSrc
        local detId = dId  or bId
        local dash  = dSrc ~= nil

        if src and detId then
            local key=src.Name.."_"..detId
            if not ActiveThreats[key] then
                ActiveThreats[key]={
                    endTime=tick()+hold,
                    pressAt=tick(),
                    dash=dash,
                }
            end
        end

        local shouldHold=false
        for key,data in pairs(ActiveThreats) do
            local seen=detected[key]
            local canFire=tick()>=data.pressAt
            if data.dash then
                if seen and canFire then
                    shouldHold=true
                    blockEnd=math.max(blockEnd,tick()+hold)
                elseif not seen then
                    ActiveThreats[key]=nil
                end
            else
                if tick()>=data.endTime then data.expired=true end
                if data.expired and not seen then
                    ActiveThreats[key]=nil
                elseif not data.expired and canFire then
                    shouldHold=true
                    blockEnd=math.max(blockEnd,data.endTime)
                end
            end
        end

        if not stunned then
            if shouldHold then
                if not isHeld then
                    isHeld=true
                    local alreadyBlocking=info ~= nil and info:FindFirstChild("Block") ~= nil
                    if not alreadyBlocking then pcall(keypress,BLOCK_KEY) end
                end
            elseif isHeld and tick()>=blockEnd then
                pcall(keyrelease,BLOCK_KEY)
                isHeld=false
            end
        end
    end
end)
print("[AutoBlock] Running")
