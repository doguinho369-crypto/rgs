-- ╔════════════════════════════════════════════╗
-- ║   KGS PAINEL  |  Gov BR  v6.0 — ANTIBAN   ║
-- ║          Delta Executor iOS                ║
-- ╚════════════════════════════════════════════╝

local Players  = game:GetService("Players")
local RunSvc   = game:GetService("RunService")
local UIS      = game:GetService("UserInputService")
local TweenSvc = game:GetService("TweenService")

local lp   = Players.LocalPlayer
local char = lp.Character or lp.CharacterAdded:Wait()
local hrp  = char:WaitForChild("HumanoidRootPart")
local hum  = char:WaitForChild("Humanoid")

lp.CharacterAdded:Connect(function(c)
    char = c
    hrp  = c:WaitForChild("HumanoidRootPart")
    hum  = c:WaitForChild("Humanoid")
end)

local CFG = {
    FarmAtivo    = false,
    ESPNPCAtivo  = false,
    ESPPlayAtivo = false,
    WalkSpeed    = 16,
    FarmDelay    = 0.6,
    ChegouDist   = 5,
}

-- antiban: speed suave
local speedAlvo = 16
local function setSpeed(v)
    speedAlvo = v
    CFG.WalkSpeed = v
end

RunSvc.Heartbeat:Connect(function()
    if not hum then return end
    if math.abs(hum.WalkSpeed - speedAlvo) > 0.5 then
        hum.WalkSpeed = hum.WalkSpeed + (speedAlvo - hum.WalkSpeed) * 0.15
    else
        hum.WalkSpeed = speedAlvo
    end
end)

local function humanDelay(base)
    local jitter = base * 0.3
    task.wait(base + math.random() * jitter - jitter * 0.5)
end

local old = (gethui and gethui() or game.CoreGui):FindFirstChild("KGS_PAINEL")
if old then old:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name           = "KGS_PAINEL"
sg.ResetOnSpawn   = false
sg.IgnoreGuiInset = true
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent         = (gethui and gethui()) or game.CoreGui

local COR = {
    bg        = Color3.fromRGB(6, 4, 14),
    glass     = Color3.fromRGB(18, 10, 36),
    glass2    = Color3.fromRGB(28, 16, 52),
    neon      = Color3.fromRGB(160, 60, 255),
    neon2     = Color3.fromRGB(200, 100, 255),
    neon3     = Color3.fromRGB(230, 160, 255),
    accent    = Color3.fromRGB(100, 220, 255),
    btn_off   = Color3.fromRGB(22, 12, 42),
    btn_on    = Color3.fromRGB(90, 28, 180),
    btn_red   = Color3.fromRGB(120, 15, 70),
    txt       = Color3.fromRGB(240, 225, 255),
    sub       = Color3.fromRGB(160, 110, 220),
    dim       = Color3.fromRGB(80, 50, 120),
    esp_npc   = Color3.fromRGB(255, 100, 220),
    esp_play  = Color3.fromRGB(100, 200, 255),
    verde     = Color3.fromRGB(80, 230, 140),
    stroke    = Color3.fromRGB(140, 50, 255),
    white     = Color3.fromRGB(255, 255, 255),
}

-- ═══ BOTÃO FLUTUANTE ═════════════════════════
local openBtn = Instance.new("TextButton")
openBtn.Size             = UDim2.new(0, 44, 0, 44)
openBtn.Position         = UDim2.new(0, 10, 0.4, 0)
openBtn.BackgroundColor3 = COR.glass
openBtn.TextColor3       = COR.neon2
openBtn.Text             = "K"
openBtn.Font             = Enum.Font.GothamBold
openBtn.TextSize         = 20
openBtn.Visible          = false
openBtn.ZIndex           = 20
openBtn.Parent           = sg
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(1, 0)
local skO = Instance.new("UIStroke", openBtn)
skO.Color = COR.neon; skO.Thickness = 1.5

task.spawn(function()
    while true do
        TweenSvc:Create(skO, TweenInfo.new(1.2, Enum.EasingStyle.Sine), {Thickness = 2.5}):Play()
        task.wait(1.2)
        TweenSvc:Create(skO, TweenInfo.new(1.2, Enum.EasingStyle.Sine), {Thickness = 1}):Play()
        task.wait(1.2)
    end
end)

-- ═══ FRAME PRINCIPAL ═════════════════════════
local frame = Instance.new("Frame")
frame.Size             = UDim2.new(0, 262, 0, 0)
frame.Position         = UDim2.new(0, 10, 0.1, 0)
frame.AutomaticSize    = Enum.AutomaticSize.Y
frame.BackgroundColor3 = COR.bg
frame.BorderSizePixel  = 0
frame.Active           = true
frame.Draggable        = true
frame.ClipsDescendants = true
frame.Parent           = sg
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 16)
local skF = Instance.new("UIStroke", frame)
skF.Color = COR.neon; skF.Thickness = 1.2

local gradBG = Instance.new("UIGradient", frame)
gradBG.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   COR.glass2),
    ColorSequenceKeypoint.new(0.5, COR.glass),
    ColorSequenceKeypoint.new(1,   COR.bg),
})
gradBG.Rotation = 145

-- ═══ HEADER ══════════════════════════════════
local hdr = Instance.new("Frame")
hdr.Size             = UDim2.new(1, 0, 0, 52)
hdr.BackgroundColor3 = COR.glass2
hdr.BorderSizePixel  = 0
hdr.ZIndex           = 2
hdr.ClipsDescendants = true
hdr.Parent           = frame
Instance.new("UICorner", hdr).CornerRadius = UDim.new(0, 16)

local hdrGrad = Instance.new("UIGradient", hdr)
hdrGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(80, 20, 160)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(50, 10, 110)),
    ColorSequenceKeypoint.new(1,   COR.glass2),
})
hdrGrad.Rotation = 100

local topBar = Instance.new("Frame")
topBar.Size             = UDim2.new(1, 0, 0, 2)
topBar.BackgroundColor3 = COR.neon2
topBar.BorderSizePixel  = 0
topBar.ZIndex           = 5
topBar.Parent           = hdr
local topBarGrad = Instance.new("UIGradient", topBar)
topBarGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(0.3, COR.neon3),
    ColorSequenceKeypoint.new(0.7, COR.accent),
    ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,0,0)),
})
task.spawn(function()
    while true do
        TweenSvc:Create(topBarGrad, TweenInfo.new(2, Enum.EasingStyle.Sine), {Rotation = 180}):Play()
        task.wait(2)
        TweenSvc:Create(topBarGrad, TweenInfo.new(2, Enum.EasingStyle.Sine), {Rotation = 0}):Play()
        task.wait(2)
    end
end)

local iconDot = Instance.new("Frame")
iconDot.Size             = UDim2.new(0, 8, 0, 8)
iconDot.Position         = UDim2.new(0, 14, 0.5, -4)
iconDot.BackgroundColor3 = COR.neon2
iconDot.BorderSizePixel  = 0
iconDot.ZIndex           = 4
iconDot.Parent           = hdr
Instance.new("UICorner", iconDot).CornerRadius = UDim.new(1, 0)
task.spawn(function()
    while true do
        TweenSvc:Create(iconDot, TweenInfo.new(0.9, Enum.EasingStyle.Sine), {BackgroundColor3 = COR.accent}):Play()
        task.wait(0.9)
        TweenSvc:Create(iconDot, TweenInfo.new(0.9, Enum.EasingStyle.Sine), {BackgroundColor3 = COR.neon2}):Play()
        task.wait(0.9)
    end
end)

local ttl = Instance.new("TextLabel")
ttl.Size               = UDim2.new(0.7, 0, 0, 20)
ttl.Position           = UDim2.new(0, 28, 0.5, -18)
ttl.BackgroundTransparency = 1
ttl.Text               = "KGS PAINEL"
ttl.Font               = Enum.Font.GothamBold
ttl.TextSize           = 15
ttl.TextColor3         = COR.white
ttl.TextXAlignment     = Enum.TextXAlignment.Left
ttl.ZIndex             = 3
ttl.Parent             = hdr

local subttl = Instance.new("TextLabel")
subttl.Size               = UDim2.new(0.7, 0, 0, 13)
subttl.Position           = UDim2.new(0, 28, 0.5, 2)
subttl.BackgroundTransparency = 1
subttl.Text               = "Gov Brasileiro  ·  v6.0"
subttl.Font               = Enum.Font.Gotham
subttl.TextSize           = 10
subttl.TextColor3         = COR.sub
subttl.TextXAlignment     = Enum.TextXAlignment.Left
subttl.ZIndex             = 3
subttl.Parent             = hdr

local minBtn = Instance.new("TextButton")
minBtn.Size             = UDim2.new(0, 28, 0, 28)
minBtn.Position         = UDim2.new(1, -38, 0.5, -14)
minBtn.BackgroundColor3 = Color3.fromRGB(50, 10, 90)
minBtn.TextColor3       = COR.sub
minBtn.Text             = "−"
minBtn.Font             = Enum.Font.GothamBold
minBtn.TextSize         = 16
minBtn.ZIndex           = 4
minBtn.Parent           = hdr
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1, 0)

minBtn.MouseButton1Click:Connect(function()
    frame.Visible   = false
    openBtn.Visible = true
end)
openBtn.MouseButton1Click:Connect(function()
    frame.Visible   = true
    openBtn.Visible = false
end)

-- ═══ CONTENT ═════════════════════════════════
local content = Instance.new("Frame")
content.Size          = UDim2.new(1, 0, 0, 0)
content.Position      = UDim2.new(0, 0, 0, 52)
content.AutomaticSize = Enum.AutomaticSize.Y
content.BackgroundTransparency = 1
content.Parent        = frame

local layout = Instance.new("UIListLayout", content)
layout.Padding             = UDim.new(0, 6)
layout.SortOrder           = Enum.SortOrder.LayoutOrder
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local pad = Instance.new("UIPadding", content)
pad.PaddingTop    = UDim.new(0, 10)
pad.PaddingBottom = UDim.new(0, 12)

-- ═══ HELPERS ═════════════════════════════════
local toggles = {}

local function divider(order)
    local wrap = Instance.new("Frame")
    wrap.Size               = UDim2.new(0.9, 0, 0, 10)
    wrap.BackgroundTransparency = 1
    wrap.LayoutOrder        = order
    wrap.Parent             = content
    local d = Instance.new("Frame")
    d.Size             = UDim2.new(1, 0, 0, 1)
    d.Position         = UDim2.new(0, 0, 0.5, 0)
    d.BackgroundColor3 = COR.dim
    d.BorderSizePixel  = 0
    d.Parent           = wrap
    local dg = Instance.new("UIGradient", d)
    dg.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0,   Color3.fromRGB(0,0,0)),
        ColorSequenceKeypoint.new(0.5, COR.neon),
        ColorSequenceKeypoint.new(1,   Color3.fromRGB(0,0,0)),
    })
end

local function secao(txt, order)
    local f = Instance.new("Frame")
    f.Size               = UDim2.new(0.95, 0, 0, 24)
    f.BackgroundTransparency = 1
    f.LayoutOrder        = order
    f.Parent             = content
    local l = Instance.new("TextLabel")
    l.Size               = UDim2.new(1, -10, 1, 0)
    l.Position           = UDim2.new(0, 10, 0, 0)
    l.BackgroundTransparency = 1
    l.Text               = txt:upper()
    l.Font               = Enum.Font.GothamBold
    l.TextSize           = 10
    l.TextColor3         = COR.sub
    l.TextXAlignment     = Enum.TextXAlignment.Left
    l.Parent             = f
end

local function toggle(nome, order, cb)
    -- row clicável inteiro
    local row = Instance.new("TextButton")
    row.Size             = UDim2.new(0.95, 0, 0, 44)
    row.BackgroundColor3 = COR.btn_off
    row.BorderSizePixel  = 0
    row.Text             = ""
    row.AutoButtonColor  = false
    row.LayoutOrder      = order
    row.Parent           = content
    Instance.new("UICorner", row).CornerRadius = UDim.new(0, 10)
    local skR = Instance.new("UIStroke", row)
    skR.Color = Color3.fromRGB(50, 25, 85); skR.Thickness = 1

    local lbl = Instance.new("TextLabel")
    lbl.Size               = UDim2.new(1, -60, 1, 0)
    lbl.Position           = UDim2.new(0, 14, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text               = nome
    lbl.Font               = Enum.Font.Gotham
    lbl.TextSize           = 13
    lbl.TextColor3         = COR.txt
    lbl.TextXAlignment     = Enum.TextXAlignment.Left
    lbl.ZIndex             = 2
    lbl.Parent             = row

    -- pill toggle
    local pill = Instance.new("Frame")
    pill.Size             = UDim2.new(0, 36, 0, 20)
    pill.Position         = UDim2.new(1, -48, 0.5, -10)
    pill.BackgroundColor3 = Color3.fromRGB(40, 20, 65)
    pill.BorderSizePixel  = 0
    pill.ZIndex           = 2
    pill.Parent           = row
    Instance.new("UICorner", pill).CornerRadius = UDim.new(1, 0)
    local skP = Instance.new("UIStroke", pill)
    skP.Color = COR.dim; skP.Thickness = 1

    local knob = Instance.new("Frame")
    knob.Size             = UDim2.new(0, 14, 0, 14)
    knob.Position         = UDim2.new(0, 3, 0.5, -7)
    knob.BackgroundColor3 = COR.dim
    knob.BorderSizePixel  = 0
    knob.ZIndex           = 3
    knob.Parent           = pill
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

    local state = false
    local function setState(v)
        state = v
        if v then
            TweenSvc:Create(pill,  TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(70, 20, 150)}):Play()
            TweenSvc:Create(knob,  TweenInfo.new(0.18), {Position = UDim2.new(1, -17, 0.5, -7), BackgroundColor3 = COR.neon2}):Play()
            TweenSvc:Create(skP,   TweenInfo.new(0.18), {Color = COR.neon}):Play()
            TweenSvc:Create(skR,   TweenInfo.new(0.18), {Color = COR.neon}):Play()
            TweenSvc:Create(row,   TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(40, 15, 85)}):Play()
            TweenSvc:Create(lbl,   TweenInfo.new(0.18), {TextColor3 = COR.white}):Play()
        else
            TweenSvc:Create(pill,  TweenInfo.new(0.18), {BackgroundColor3 = Color3.fromRGB(40, 20, 65)}):Play()
            TweenSvc:Create(knob,  TweenInfo.new(0.18), {Position = UDim2.new(0, 3, 0.5, -7), BackgroundColor3 = COR.dim}):Play()
            TweenSvc:Create(skP,   TweenInfo.new(0.18), {Color = COR.dim}):Play()
            TweenSvc:Create(skR,   TweenInfo.new(0.18), {Color = Color3.fromRGB(50, 25, 85)}):Play()
            TweenSvc:Create(row,   TweenInfo.new(0.18), {BackgroundColor3 = COR.btn_off}):Play()
            TweenSvc:Create(lbl,   TweenInfo.new(0.18), {TextColor3 = COR.txt}):Play()
        end
        cb(v)
    end

    row.MouseButton1Click:Connect(function() setState(not state) end)
    toggles[nome] = { setter = setState }
end

local function slider(nome, min, max, def, order, cb)
    local c = Instance.new("Frame")
    c.Size             = UDim2.new(0.95, 0, 0, 64)
    c.BackgroundColor3 = COR.btn_off
    c.BorderSizePixel  = 0
    c.LayoutOrder      = order
    c.Parent           = content
    Instance.new("UICorner", c).CornerRadius = UDim.new(0, 10)
    local skC = Instance.new("UIStroke", c)
    skC.Color = Color3.fromRGB(50, 25, 85); skC.Thickness = 1

    local lbl = Instance.new("TextLabel")
    lbl.Size               = UDim2.new(0.6, -10, 0, 24)
    lbl.Position           = UDim2.new(0, 14, 0, 8)
    lbl.BackgroundTransparency = 1
    lbl.Text               = nome
    lbl.Font               = Enum.Font.Gotham
    lbl.TextSize           = 12
    lbl.TextColor3         = COR.sub
    lbl.TextXAlignment     = Enum.TextXAlignment.Left
    lbl.Parent             = c

    local val_lbl = Instance.new("TextLabel")
    val_lbl.Size               = UDim2.new(0.4, -14, 0, 24)
    val_lbl.Position           = UDim2.new(0.6, 0, 0, 8)
    val_lbl.BackgroundTransparency = 1
    val_lbl.Text               = tostring(def)
    val_lbl.Font               = Enum.Font.GothamBold
    val_lbl.TextSize           = 13
    val_lbl.TextColor3         = COR.neon2
    val_lbl.TextXAlignment     = Enum.TextXAlignment.Right
    val_lbl.Parent             = c

    local track = Instance.new("Frame")
    track.Size             = UDim2.new(1, -20, 0, 6)
    track.Position         = UDim2.new(0, 10, 0, 44)
    track.BackgroundColor3 = Color3.fromRGB(30, 12, 55)
    track.BorderSizePixel  = 0
    track.Parent           = c
    Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame")
    fill.Size             = UDim2.new((def-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = COR.neon
    fill.BorderSizePixel  = 0
    fill.Parent           = track
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)
    local fg = Instance.new("UIGradient", fill)
    fg.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, COR.neon),
        ColorSequenceKeypoint.new(1, COR.accent),
    })

    local knob = Instance.new("Frame")
    knob.Size             = UDim2.new(0, 16, 0, 16)
    knob.Position         = UDim2.new((def-min)/(max-min), -8, 0.5, -8)
    knob.BackgroundColor3 = COR.white
    knob.BorderSizePixel  = 0
    knob.Parent           = track
    Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)
    local skK = Instance.new("UIStroke", knob)
    skK.Color = COR.neon; skK.Thickness = 1.5

    local drag = false
    local function update(inputX)
        local x   = math.clamp((inputX - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local v   = math.floor(min + x * (max - min))
        fill.Size     = UDim2.new(x, 0, 1, 0)
        knob.Position = UDim2.new(x, -8, 0.5, -8)
        val_lbl.Text  = tostring(v)
        cb(v)
    end

    knob.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then drag = true end
    end)
    track.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then
            drag = true; update(i.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1
        or i.UserInputType == Enum.UserInputType.Touch then drag = false end
    end)
    UIS.InputChanged:Connect(function(i)
        if drag and (i.UserInputType == Enum.UserInputType.MouseMovement
        or i.UserInputType == Enum.UserInputType.Touch) then
            update(i.Position.X)
        end
    end)
end

-- ═══ MASTER ══════════════════════════════════
local masterAtivo = false
local mb = Instance.new("TextButton")
mb.Size             = UDim2.new(0.95, 0, 0, 46)
mb.BackgroundColor3 = Color3.fromRGB(100, 15, 55)
mb.TextColor3       = COR.white
mb.Text             = "  ATIVAR TUDO"
mb.Font             = Enum.Font.GothamBold
mb.TextSize         = 13
mb.AutoButtonColor  = false
mb.LayoutOrder      = 0
mb.Parent           = content
Instance.new("UICorner", mb).CornerRadius = UDim.new(0, 10)
local skMB = Instance.new("UIStroke", mb)
skMB.Color = Color3.fromRGB(180, 30, 100); skMB.Thickness = 1.2

local mbGrad = Instance.new("UIGradient", mb)
mbGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 20, 75)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 10, 45)),
})
mbGrad.Rotation = 90

local mDot = Instance.new("Frame")
mDot.Size             = UDim2.new(0, 7, 0, 7)
mDot.Position         = UDim2.new(0, 14, 0.5, -3.5)
mDot.BackgroundColor3 = Color3.fromRGB(220, 60, 100)
mDot.BorderSizePixel  = 0
mDot.ZIndex           = 2
mDot.Parent           = mb
Instance.new("UICorner", mDot).CornerRadius = UDim.new(1, 0)

mb.MouseButton1Click:Connect(function()
    masterAtivo = not masterAtivo
    if masterAtivo then
        mb.Text = "  DESATIVAR TUDO"
        mbGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 25, 180)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(45, 12, 110)),
        })
        TweenSvc:Create(skMB,  TweenInfo.new(0.2), {Color = COR.neon}):Play()
        TweenSvc:Create(mDot,  TweenInfo.new(0.2), {BackgroundColor3 = COR.verde}):Play()
        setSpeed(60)
    else
        mb.Text = "  ATIVAR TUDO"
        mbGrad.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromRGB(140, 20, 75)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 10, 45)),
        })
        TweenSvc:Create(skMB,  TweenInfo.new(0.2), {Color = Color3.fromRGB(180, 30, 100)}):Play()
        TweenSvc:Create(mDot,  TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(220, 60, 100)}):Play()
        setSpeed(16)
    end
    for _, t in pairs(toggles) do t.setter(masterAtivo) end
end)

divider(1)
secao("Farm", 2)
toggle("Auto Prestígio", 3, function(v) CFG.FarmAtivo = v end)
divider(4)
secao("Player", 5)
slider("WalkSpeed", 16, 150, 16, 6, function(v) setSpeed(v) end)
divider(7)
secao("Visual  /  ESP", 8)
toggle("ESP — NPCs", 9, function(v) CFG.ESPNPCAtivo = v end)
toggle("ESP — Jogadores", 10, function(v) CFG.ESPPlayAtivo = v end)
divider(11)

-- ═══ STATUS BAR ══════════════════════════════
local stBar = Instance.new("Frame")
stBar.Size             = UDim2.new(0.95, 0, 0, 26)
stBar.BackgroundColor3 = Color3.fromRGB(14, 7, 28)
stBar.BorderSizePixel  = 0
stBar.LayoutOrder      = 12
stBar.Parent           = content
Instance.new("UICorner", stBar).CornerRadius = UDim.new(0, 8)
local skSt = Instance.new("UIStroke", stBar)
skSt.Color = Color3.fromRGB(55, 20, 100); skSt.Thickness = 1

local stLbl = Instance.new("TextLabel")
stLbl.Size               = UDim2.new(1, -26, 1, 0)
stLbl.Position           = UDim2.new(0, 10, 0, 0)
stLbl.BackgroundTransparency = 1
stLbl.Text               = "pronto"
stLbl.Font               = Enum.Font.Gotham
stLbl.TextSize           = 10
stLbl.TextColor3         = COR.sub
stLbl.TextXAlignment     = Enum.TextXAlignment.Left
stLbl.Parent             = stBar

local sDot = Instance.new("Frame")
sDot.Size             = UDim2.new(0, 5, 0, 5)
sDot.Position         = UDim2.new(1, -14, 0.5, -2.5)
sDot.BackgroundColor3 = COR.verde
sDot.BorderSizePixel  = 0
sDot.Parent           = stBar
Instance.new("UICorner", sDot).CornerRadius = UDim.new(1, 0)
task.spawn(function()
    while true do
        TweenSvc:Create(sDot, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {BackgroundTransparency = 0.7}):Play()
        task.wait(0.8)
        TweenSvc:Create(sDot, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {BackgroundTransparency = 0}):Play()
        task.wait(0.8)
    end
end)

-- ═══ ESP ═════════════════════════════════════
local function criarBB(parent, cor, txt, tipo)
    local ex = parent:FindFirstChild("KGS_ESP")
    if ex then ex:Destroy() end
    local bb = Instance.new("BillboardGui")
    bb.Name        = "KGS_ESP"
    bb.Size        = UDim2.new(0, 118, 0, 26)
    bb.AlwaysOnTop = true
    bb.StudsOffset = Vector3.new(0, 4.5, 0)
    bb.Parent      = parent
    bb:SetAttribute("tipo", tipo)
    local bg = Instance.new("Frame", bb)
    bg.Size               = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3   = Color3.fromRGB(6, 2, 14)
    bg.BackgroundTransparency = 0.2
    bg.BorderSizePixel    = 0
    Instance.new("UICorner", bg).CornerRadius = UDim.new(0, 6)
    local skBB = Instance.new("UIStroke", bg)
    skBB.Color = cor; skBB.Thickness = 1
    local l = Instance.new("TextLabel", bg)
    l.Size               = UDim2.new(1, 0, 1, 0)
    l.BackgroundTransparency = 1
    l.TextColor3         = cor
    l.Text               = txt
    l.Font               = Enum.Font.GothamBold
    l.TextSize           = 10
end

-- ═══ FARM ════════════════════════════════════
local function ehNPC(obj)
    return obj:FindFirstChildWhichIsA("Humanoid") ~= nil
end

local function montarFila()
    local fila = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= char and ehNPC(obj) then
            local root = obj.PrimaryPart
                or obj:FindFirstChild("HumanoidRootPart")
                or obj:FindFirstChildWhichIsA("BasePart")
            if root then
                local pp = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                local cd = obj:FindFirstChildWhichIsA("ClickDetector", true)
                if pp or cd then
                    table.insert(fila, { obj = obj, root = root, pp = pp, cd = cd })
                end
            end
        end
    end
    return fila
end

local function andarAteNPC(root)
    hum:MoveTo(root.Position)
    local t = 0
    while t < 10 do
        task.wait(0.1)
        t = t + 0.1
        if not CFG.FarmAtivo then return false end
        if (hrp.Position - root.Position).Magnitude <= CFG.ChegouDist then return true end
        hum:MoveTo(root.Position)
    end
    return false
end

task.spawn(function()
    while true do
        task.wait(0.2)
        if not CFG.FarmAtivo or not char or not hrp then continue end

        local fila = montarFila()
        if #fila == 0 then
            stLbl.Text = "nenhum NPC encontrado"
            task.wait(1)
            continue
        end

        local visitados = {}
        while CFG.FarmAtivo do
            local disponiveis = {}
            for _, a in pairs(fila) do
                if not visitados[a.obj] and a.root and a.root.Parent then
                    table.insert(disponiveis, a)
                end
            end
            if #disponiveis == 0 then break end

            local alvo, melhorDist = nil, math.huge
            for _, a in pairs(disponiveis) do
                local d = (hrp.Position - a.root.Position).Magnitude
                if d < melhorDist then melhorDist = d; alvo = a end
            end
            if not alvo then break end

            stLbl.Text = "indo → "..alvo.obj.Name
            local chegou = andarAteNPC(alvo.root)

            if chegou then
                stLbl.Text = "clicando → "..alvo.obj.Name
                humanDelay(0.1)
                if alvo.pp and alvo.pp.Parent then fireproximityprompt(alvo.pp) end
                if alvo.cd and alvo.cd.Parent then fireclickdetector(alvo.cd) end
                humanDelay(CFG.FarmDelay)
            else
                stLbl.Text = "timeout → "..alvo.obj.Name
                task.wait(0.3)
            end
            visitados[alvo.obj] = true
        end

        stLbl.Text = "reiniciando..."
        task.wait(0.5 + math.random() * 0.3)
    end
end)

-- ═══ ESP LOOP ════════════════════════════════
RunSvc.Heartbeat:Connect(function()
    if not char or not hrp then return end

    for _, p in pairs(Players:GetPlayers()) do
        if p ~= lp and p.Character then
            local root = p.Character:FindFirstChild("HumanoidRootPart")
            if root then
                if CFG.ESPPlayAtivo and not root:FindFirstChild("KGS_ESP") then
                    local d = math.floor((hrp.Position - root.Position).Magnitude)
                    criarBB(root, COR.esp_play, p.Name.." · "..d.."m", "player")
                elseif not CFG.ESPPlayAtivo then
                    local bb = root:FindFirstChild("KGS_ESP")
                    if bb then bb:Destroy() end
                end
            end
        end
    end

    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= char and ehNPC(obj) then
            local root = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if root then
                local temI = obj:FindFirstChildWhichIsA("ProximityPrompt", true)
                    or obj:FindFirstChildWhichIsA("ClickDetector", true)
                if CFG.ESPNPCAtivo and temI and not root:FindFirstChild("KGS_ESP") then
                    local d = math.floor((hrp.Position - root.Position).Magnitude)
                    criarBB(root, COR.esp_npc, "⚡ "..obj.Name.." · "..d.."m", "npc")
                elseif not CFG.ESPNPCAtivo then
                    local bb = root:FindFirstChild("KGS_ESP")
                    if bb and bb:GetAttribute("tipo") == "npc" then bb:Destroy() end
                end
            end
        end
    end
end)

print("[KGS PAINEL v6.0 — ANTIBAN] carregado ✓")
