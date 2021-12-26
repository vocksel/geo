local t = require(script.Parent.Parent.t)

-- This thinness ratio approaches unity, and typically floats around 0.95 when
-- given points that make a line. We make the certainty a bit less to account
-- for any curvier lines.
local LINE_CERTAINTY = 0.85

local check = t.array(t.Vector2)

--[=[
	@function isLine

	Checks if a series of drawn points represent a Line shape by calculating the
	thinness of the points given.

	@within Geo
	@param points { Vector2 }
	@return boolean -- Returns true if the points represent a line, false
		otherwise.
]=]
local function isLine(points: { Vector2 })
	assert(check(points))

	if #points < 2 then
		return false
	end

	local perimeter = 0
	for i = 1, #points - 1 do
		perimeter += (points[i] - points[i + 1]).Magnitude
	end

	local length = (points[1] - points[#points]).Magnitude
	local thinnessRatio = length / perimeter

	return thinnessRatio >= LINE_CERTAINTY
end

return isLine
