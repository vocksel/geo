local getPerimeter = require(script.Parent.getPerimeter)

local function fuzzyeq(a, b, epsilon)
	return math.abs(a - b) <= epsilon
end

local function isCircle(hull: { Vector2 }, hullArea: number)
	local perimeter = getPerimeter(hull)

	-- This ratio approaches 4pi for circles, so we will then compare that the
	-- ratio is roughly close to that value for circle detection.
	local thinnessRatio = perimeter^2 / hullArea

	return fuzzyeq(4 * math.pi, thinnessRatio, 1)
end

return isCircle