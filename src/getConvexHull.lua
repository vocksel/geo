local t = require(script.Parent.t)

local crossCheck = t.tuple(t.Vector2, t.Vector2, t.Vector2)

local function cross(a, b, c)
	assert(crossCheck(a, b, c))

	return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x)
end

local getConvexHullCheck = t.array(t.Vector2)

--[=[
	@function getConvexHull

	Uses an implementation of the [Graham Scan](https://en.wikipedia.org/wiki/Graham_scan)
	algorithm to find the points that represent the convex hull of a list of points.

	:::caution
	The points passed to this function must pass through `sortCounterClockwise()`
	first, otherwise you will get unexpected results.
	:::

	The following gif shows an example of how this works. Notice that only the
	outer points are connected, and that the bottommost point is highlighted a
	different color.

	![Convex hull generation](/static/convex-hull-generation.gif)

	@within Geo
	@param points { Vector2 } -- Array of points to get the convex hull of
	@return { Vector2 } -- Returns an array of points that compose the convex hull of what was given
]=]
local function getConvexHull(points: { [number]: Vector2 })
	assert(getConvexHullCheck(points))
	assert(#points >= 3, "To get a convex hull there must be at least 3 points")

	local hull = { points[1], points[2] }

	for i = 3, #points do
		local point = points[i]

		-- This filters out colinear points by comparing the current point with
		-- the last one. Vector2 comparison checks if the X and Y components of
		-- each is the same, rather than checking if the instances are the same.
		if point == hull[#hull] then
			continue
		end

		-- If the next turn is clockwise, this will continue removing points
		-- from the end of the hull until the last point in the hull makes a
		-- counterclockwise turn to `point`.
		while cross(hull[#hull - 1], hull[#hull], point) > 0 do
			table.remove(hull, #hull)

			if #hull == 1 then
				break
			end
		end

		table.insert(hull, point)
	end

	return hull
end

return getConvexHull
