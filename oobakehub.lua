-- お化けhub GUI部分（ドラッグ＋ボタン強化版）
-- これを元のGUI作成部分と置き換えてください

-- ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "ObakeHubGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- スマホ判定
local isMobile = UserInputService.TouchEnabled

-- サイズをスマホに優しく調整
local guiWidth  = isMobile and 300 or 320
local guiHeight = isMobile and 460 or 400

local outer = Instance.new("Frame")
outer.Name = "Outer"
outer.Size = UDim2.new(0, guiWidth, 0, guiHeight)
outer.Position = UDim2.new(0.5, -guiWidth/2, 0.12, 0)  -- 画面中央寄りスタート
outer.BackgroundTransparency = 1
outer.Parent = screenGui

local card = Instance.new("Frame")
card.Name = "Card"
card.Size = UDim2.new(1, -16, 1, -16)
card.Position = UDim2.new(0, 8, 0, 8)
card.BackgroundColor3 = Color3.fromRGB(18, 15, 28)
card.BackgroundTransparency = 0.15
card.BorderSizePixel = 0
card.Parent = outer

local cardCorner = Instance.new("UICorner")
cardCorner.CornerRadius = UDim.new(0, 20)
cardCorner.Parent = card

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(140, 80, 220)
stroke.Thickness = 2.5
stroke.Transparency = 0.4
stroke.Parent = card

-- タイトルバー（ここをドラッグ可能に）
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 70)
titleBar.BackgroundTransparency = 1  -- 透明にして範囲だけ広く
titleBar.ZIndex = 10
titleBar.Parent = card

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 0, 36)
title.Position = UDim2.new(0, 16, 0, 10)
title.BackgroundTransparency = 1
title.Text = "お化けhub"
title.Font = Enum.Font.GothamBlack
title.TextSize = isMobile and 28 or 26
title.TextColor3 = Color3.fromRGB(220, 180, 255)
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = card

local sub = Instance.new("TextLabel")
sub.Size = UDim2.new(1, -20, 0, 22)
sub.Position = UDim2.new(0, 16, 0, 46)
sub.BackgroundTransparency = 1
sub.Text = "TikTokお化け"
sub.Font = Enum.Font.Gotham
sub.TextSize = isMobile and 15 or 14
sub.TextColor3 = Color3.fromRGB(180, 140, 220)
sub.TextXAlignment = Enum.TextXAlignment.Left
sub.Parent = card

-- トグル（サイズアップ）
local function createToggle(y, text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -24, 0, isMobile and 54 or 48)
    frame.Position = UDim2.new(0, 12, 0, y)
    frame.BackgroundColor3 = Color3.fromRGB(35, 30, 55)
    frame.BackgroundTransparency = 0.6
    frame.Parent = card

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.65, 0, 1, 0)
    lbl.Position = UDim2.new(0, 16, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.GothamSemibold
    lbl.TextSize = isMobile and 17 or 15
    lbl.TextColor3 = Color3.fromRGB(230, 200, 255)
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, isMobile and 70 or 64, 0, isMobile and 36 or 32)
    btn.Position = UDim2.new(1, isMobile and -88 or -80, 0.5, -(isMobile and 18 or 16))
    btn.BackgroundColor3 = Color3.fromRGB(60, 50, 90)
    btn.Text = ""
    btn.Parent = frame

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 18)
    btnCorner.Parent = btn

    local ind = Instance.new("Frame")
    ind.Size = UDim2.new(0, isMobile and 30 or 26, 0, isMobile and 30 or 26)
    ind.Position = UDim2.new(0, 3, 0.5, -(isMobile and 15 or 13))
    ind.BackgroundColor3 = Color3.fromRGB(160, 140, 200)
    ind.BorderSizePixel = 0
    ind.Parent = btn

    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(1,0)
    indCorner.Parent = ind

    local enabled = false
    btn.MouseButton1Click:Connect(function()
        enabled = not enabled
        local targetPos = enabled and UDim2.new(1, -(isMobile and 36 or 32), 0.5, -(isMobile and 15 or 13)) or UDim2.new(0, 3, 0.5, -(isMobile and 15 or 13))
        local targetColor = enabled and Color3.fromRGB(100, 220, 140) or Color3.fromRGB(60, 50, 90)
        local indColor = enabled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(160, 140, 200)

        TweenService:Create(ind, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Position = targetPos}):Play()
        TweenService:Create(btn, TweenInfo.new(0.25), {BackgroundColor3 = targetColor}):Play()
        TweenService:Create(ind, TweenInfo.new(0.25), {BackgroundColor3 = indColor}):Play()

        callback(enabled)
    end)
end

-- トグル配置（位置を調整）
createToggle(80,  "Admin Commands",  function(v) adminFeaturesEnabled = v end)
createToggle(145, "Auto-Defense",     function(v) autoDefenseEnabled = v  end)
createToggle(210, "Anti-TP Scam",     function(v)
    antiTPScamEnabled = v
    if v and not myPlot then
        myPlot = findMyPlot()
        if myPlot then myPlotAnimalPodiums = getMyPlotAnimalPodiums(myPlot) end
    end
end)

-- EXECUTEボタン（大きく・目立つ）
local execBtn = Instance.new("TextButton")
execBtn.Size = UDim2.new(1, -24, 0, isMobile and 60 or 50)
execBtn.Position = UDim2.new(0, 12, 1, isMobile and -80 or -70)
execBtn.BackgroundColor3 = Color3.fromRGB(90, 40, 140)  -- 紫系
execBtn.Text = isMobile and "実行する" or "EXECUTE (F)"
execBtn.Font = Enum.Font.GothamBold
execBtn.TextSize = isMobile and 22 or 18
execBtn.TextColor3 = Color3.fromRGB(255, 240, 255)
execBtn.Parent = card

local execCorner = Instance.new("UICorner")
execCorner.CornerRadius = UDim.new(0, 16)
execCorner.Parent = execBtn

execBtn.MouseButton1Click:Connect(executeCommands)

-- ドラッグ機能（タイトルバー全体で動かせる）
local dragging = false
local dragStart, startPos

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = outer.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        outer.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)

-- プレイヤーリスト部分も必要ならここに追加（前回のコードからコピー）
-- ... (refreshList, updatePlayerList などの関数を入れてください)

print("👻 お化けhub 起動 | UIドラッグ可能になりました")
