--[[
	Uses Heron's Formula to calculate the area of a triangle from any three
	points.
]]

local function getTriangleArea(p1: Vector2, p2: Vector2, p3: Vector2)
	local a = (p1 - p2).Magnitude
	local b = (p2 - p3).Magnitude
	local c = (p3 - p1).Magnitude
	local s = (a + b + c) / 2

	return math.sqrt(s * (s - a) * (s - b) * (s - c))
end

return getTriangleArea
