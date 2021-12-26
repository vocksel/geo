local t = require(script.Parent.t)

local check = t.array(t.Vector2)

--[=[
	@function getPolygonArea

	Gets the area of an arbitrary polygon.

	:::info
	This is specifically used to find the area of the convex hull, but it can be
	used in conjunction with anything so long as the points are in clockwise or
	conterclockwise order.
	:::

	```lua
	local sorted = ...
	local hull = getConvexHull(sorted)
	local area = getPolygonArea(hull)
	```

	@within Geo
	@tag helper
	@param points { Vector2 } -- Array of points that make up a polygon.
	@return number -- Returns the area of the given polygon.
]=]
local function getPolygonArea(points: { Vector2 })
	assert(check(points))

	local area = 0

	for i, point in ipairs(points) do
		local nextPoint = points[i + 1] or points[1]
		area += point:Cross(nextPoint)
	end

	return math.abs(area / 2)
end

return getPolygonArea
