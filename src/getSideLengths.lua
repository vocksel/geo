--[=[
	@function getSideLengths

	Gets the side lengths of a rectangle as a Vector2.

	For this to work, the points of the rectangle must be aligned relatively to
	each other. For example, the points that represent the width must be on the
	same Y axis and the points that represent the height must be on the same X
	axis.

	:::tip
	It is best to use this function in conjunction with `getBoundingBox()`.
	:::

	@within Geo
	@tag helper
	@param points { Vector2 } -- Array of points composing a rectangle
	@return Vector2 -- Returns a Vector2 representing the side lengths of a rectangle where the X component is the width, and the Y component is the height.
]=]

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
