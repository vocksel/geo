--[[
	Given a rectangle, returns the side lengths as a Vector2 where X is the
	width and Y is the height.

	For this to work, the points of the rectangle must be aligned relatively to
	each other. For example, the points that represent the width must be on the
	same Y axis and the points that represent the height must be on the same X
	axis.
]]

local t = require(script.Parent.t)

local check = t.array(t.Vector2)

local function getSideLengths(points)
	assert(check(points))
	assert(#points == 4, "To get the side length of a rectangle, there must be exactly 4 points given")

	local width, height

	for i, point in ipairs(points) do
		local nextPoint = points[i + 1] or points[1]

		if point.X == nextPoint.X then
			height = math.max((point - nextPoint).Magnitude, height or 0)
		end

		if point.Y == nextPoint.Y then
			width = math.max((point - nextPoint).Magnitude, width or 0)
		end
	end

	return Vector2.new(width, height)
end

return getSideLengths
