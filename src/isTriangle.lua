local getLargestTriangle = require(script.Parent.getLargestTriangle)
local getTriangleArea = require(script.Parent.getTriangleArea)

local TRIANGLE_PERCENT = 0.75

local function isTriangle(hull: { Vector2 }, hullArea: number)
	local triangle = getLargestTriangle(hull)
	local triangleArea = getTriangleArea(unpack(triangle))

	return triangleArea / hullArea >= TRIANGLE_PERCENT
end

return isTriangle