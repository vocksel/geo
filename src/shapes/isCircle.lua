local t = require(script.Parent.Parent.t)
local getPerimeter = require(script.Parent.Parent.getPerimeter)

local fuzzyeqCheck = t.tuple(t.number, t.number, t.number)
local function fuzzyeq(a, b, epsilon)
	assert(fuzzyeqCheck(a, b, epsilon))

	return math.abs(a - b) <= epsilon
end

local isCircleCheck = t.tuple(t.array(t.Vector2), t.numberPositive)
local function isCircle(hull: { Vector2 }, hullArea: number)
	assert(isCircleCheck(hull, hullArea))

	local perimeter = getPerimeter(hull)

	-- This ratio approaches 4pi for circles, so we will then compare that the
	-- ratio is roughly close to that value for circle detection.
	local thinnessRatio = perimeter ^ 2 / hullArea

	return fuzzyeq(4 * math.pi, thinnessRatio, 1)
end

return isCircle
