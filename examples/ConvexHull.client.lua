--[[
	An example that sets up a ScreenGui with some random points so the Graham
	Scan implementation can be viewed in action.
]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local getConvexHull = require(ReplicatedStorage.Geo.getConvexHull)
local sortCounterClockwise = require(ReplicatedStorage.Geo.sortCounterClockwise)

local POINT_SIZE = 5 -- px
local MAX_SPREAD = 400 -- px
local NUM_POINTS = 10
local LINE_SIZE = 2 -- px

local function drawLine(parent: Instance, p1: Vector2, p2: Vector2)
	local length = (p1 - p2).Magnitude
	local midpoint = (p2 + p1) / 2
	local angle = math.atan2(p2.Y - p1.Y, p2.X - p1.X)

	local frame = Instance.new("Frame")
	frame.Name = "Line"
	frame.BorderSizePixel = 0
	frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	frame.BackgroundTransparency = 0.5
	frame.Rotation = angle * (180 / math.pi)
	frame.AnchorPoint = Vector2.new(0.5, 0)
	frame.Position = UDim2.fromOffset(midpoint.X, midpoint.Y)
	frame.Size = UDim2.fromOffset(length, LINE_SIZE)
	frame.Parent = parent
end

local function generateHull(parent)
	parent:ClearAllChildren()

	local points = {}
	local rng = Random.new()
	for _ = 1, NUM_POINTS do
		table.insert(points, Vector2.new(rng:NextInteger(0, MAX_SPREAD), rng:NextInteger(0, MAX_SPREAD)))
	end

	for _, point in ipairs(points) do
		local frame = Instance.new("Frame")
		frame.Size = UDim2.fromOffset(POINT_SIZE, POINT_SIZE)
		frame.BackgroundColor3 = Color3.new()
		frame.BorderSizePixel = 0
		frame.AnchorPoint = Vector2.new(0.5, 0.5)
		frame.Position = UDim2.fromOffset(point.X, point.Y)
		frame.Parent = parent

		local label = Instance.new("TextLabel")
		label.RichText = true
		label.Text = ("(%i,%i)"):format(point.X, point.Y)
		label.Size = UDim2.fromOffset(60, 14)
		label.TextSize = 14
		label.Font = Enum.Font.Ubuntu
		label.TextColor3 = Color3.fromRGB(255, 255, 255)
		label.BackgroundTransparency = 1
		label.AnchorPoint = Vector2.new(0.5, 1)
		label.Position = UDim2.fromScale(0.5, -1)
		label.Parent = frame
	end

	local shift = 1

	local sorted = sortCounterClockwise(points)
	local hull = getConvexHull(sorted)

	drawLine(parent, hull[#hull], hull[1])

	for index, point in ipairs(hull) do
		for _, frame in ipairs(parent:GetChildren()) do
			local position = frame.Position

			if position.X.Offset == point.X and position.Y.Offset == point.Y then
				if index > 1 then
					drawLine(parent, hull[index - 1], point)
				end

				frame.TextLabel.Text = ("<b>%i</b> %s"):format(index, frame.TextLabel.Text)

				local color: Color3
				if index == 1 then
					color = Color3.fromRGB(255, 150, 0)
				else
					color = Color3.fromRGB(144 * shift, 255, 80 * shift)
					shift -= #points/100
				end
				frame.BackgroundColor3 = color
			end
		end
	end
end

local screen = Instance.new("ScreenGui")
screen.Parent = Players.LocalPlayer.PlayerGui

local layout = Instance.new("UIListLayout")
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.Padding = UDim.new(0, 8)
layout.Parent = screen

local container = Instance.new("Frame")
container.LayoutOrder = 1
container.Size = UDim2.fromOffset(MAX_SPREAD, MAX_SPREAD)
container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
container.BackgroundTransparency = 0.5
container.Parent = screen

local button = Instance.new("TextButton")
button.LayoutOrder = 1
button.Text = "Refresh"
button.Size = UDim2.fromOffset(100, 20)
button.Parent = screen

button.Activated:Connect(function()
    generateHull(container)
end)

generateHull(container)