local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local Geo = require(ReplicatedStorage.Geo)

local screen = Instance.new("ScreenGui")
screen.Name = "Drawing"

local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.fromOffset(400, 400)
container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
container.Parent = screen

local info = Instance.new("TextLabel")
info.Name = "Info"
info.Text = "Click to draw"
info.TextSize = 24
info.TextColor3 = Color3.fromRGB(0, 0, 0)
info.BackgroundTransparency = 1
info.Size = UDim2.fromScale(1, 1)
info.Parent = container

local canvas = Instance.new("Frame")
canvas.Name = "Canvas"
canvas.Size = UDim2.fromScale(1, 1)
canvas.BackgroundTransparency = 1
canvas.Parent = container

local POINT_FRAME do
    POINT_FRAME = Instance.new("Frame")
    POINT_FRAME.Name = "Point"
    POINT_FRAME.Size = UDim2.fromOffset(2, 2)
    POINT_FRAME.BorderSizePixel = 0
    POINT_FRAME.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
end

local points = {}

local function clear()
    info.Text = ""
    canvas:ClearAllChildren()
    points = {}
end

local function addPoint()
    local mouse = UserInputService:GetMouseLocation()
    local inset = GuiService:GetGuiInset()
    local point = Vector2.new(mouse.X, mouse.Y - inset.Y)

    local newPoint = POINT_FRAME:Clone()
    newPoint.Position = UDim2.fromOffset(point.X, point.Y)
    newPoint.Parent = canvas

    table.insert(points, point)
end

local function onInputEnd(input, callback)
    local event
    event = input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            event:Disconnect()
            callback()
        end
    end)
end

canvas.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        clear()
        addPoint()

        local mouseMove = canvas.MouseMoved:Connect(addPoint)

        onInputEnd(input, function()
            mouseMove:Disconnect()

            local shape = Geo.detectShape(points) or "None"
            local orientation = Geo.getOrientation(points) or "None"

            info.Text = ("Shape: %s\nOrientation: %s"):format(shape, orientation)
        end)
    end
end)

screen.Parent = Players.LocalPlayer.PlayerGui
