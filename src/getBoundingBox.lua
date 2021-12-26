local t = require(script.Parent.t)

local check = t.array(t.Vector2)

--[=[
	@function getBoundingBox

	Based on a series of 4+ points, 4 new points that represent the minimum
	bounding box are returned.

	The following image illustrates how this works. From a convex hull, the
	enclosing rectangle surrounds the hull entirely.

	![Enclosing rectangle surrounding a convex hull](/enclosing-rectangle.png)

	:::note
	Keep in mind that the resulting rectangle is always axis-aligned. That is,
	there is no support for rotation.
	:::

	@within Geo
	@tag helper
	@param points { Vector2 } -- Array of points to get a bounding box around
	@return { Vector2 } -- Returns 4 points that make up the bounding box
]=]
local function getBoundingBox(points: { Vector2 })
	assert(check(points))

	if #points <= 4 then
		return points
	end

	local xmin = math.huge
	local xmax = 0
	local ymin = math.huge
	local ymax = 0

	for _, point in ipairs(points) do
		xmin = math.min(point.X, xmin)
		xmax = math.max(point.X, xmax)
		ymin = math.min(point.Y, ymin)
		ymax = math.max(point.Y, ymax)
	end

	return {
		Vector2.new(xmin, ymin),
		Vector2.new(xmax, ymin),
		Vector2.new(xmax, ymax),
		Vector2.new(xmin, ymax),
	}
end

return getBoundingBox
