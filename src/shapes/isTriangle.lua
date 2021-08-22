local t = require(script.Parent.Parent.t)
local getLargestTriangle = require(script.Parent.Parent.getLargestTriangle)
local getTriangleArea = require(script.Parent.Parent.getTriangleArea)

local TRIANGLE_PERCENT = 0.75

local check = t.tuple(t.array(t.Vector2), t.numberPositive)

local function isTriangle(hull: { Vector2 }, hullArea: number)
	assert(check(hull, hullArea))

	local triangle = getLargestTriangle(hull)
	local triangleArea = getTriangleArea(unpack(triangle))

	return triangleArea / hullArea >= TRIANGLE_PERCENT
end

return isTriangle
