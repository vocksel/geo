local t = require(script.Parent.t)

local check = t.array(t.Vector2)

--[=[
	@function getPerimeter

	Gets the perimeter of a convex object.

	Given an ordered list of points, this function counts up the distance between
	every side length to get the perimeter of the geometric object.

	:::caution
	Only use this with points that have a defined shape, such as a rectangle or
	convex hull. If there are excess points you will get incorrect results.
	:::

	@within Geo
	@param points { Vector 2} -- Array of points to get the perimeter of
	@return number -- The perimeter of the given points
]=]
local function getPerimeter(points: { Vector2 })
	assert(check(points))

	if #points == 1 then
		return 0
	elseif #points == 2 then
		return (points[1] - points[2]).Magnitude
	end

	local perimeter = 0
	for i = 2, #points do
		perimeter += (points[i - 1] - points[i]).Magnitude
	end
	return perimeter
end

return getPerimeter
